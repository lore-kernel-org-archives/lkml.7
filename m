Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F3D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfEMRPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbfEMRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:15:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75EA33087945;
        Mon, 13 May 2019 17:15:23 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F3F18E51;
        Mon, 13 May 2019 17:15:20 +0000 (UTC)
Date:   Mon, 13 May 2019 13:15:19 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Tim Murray <timmurray@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        tj@kernel.org
Subject: Re: Problems caused by dm crypt: use WQ_HIGHPRI for the IO and crypt
 workqueues
Message-ID: <20190513171519.GA26166@redhat.com>
References: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 13 May 2019 17:15:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2019 at 12:18pm -0400,
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> I wanted to jump on the bandwagon of people reporting problems with
> commit a1b89132dc4f ("dm crypt: use WQ_HIGHPRI for the IO and crypt
> workqueues").
> 
> Specifically I've been tracking down communication errors when talking
> to our Embedded Controller (EC) over SPI.  I found that communication
> errors happened _much_ more frequently on newer kernels than older
> ones.  Using ftrace I managed to track the problem down to the dm
> crypt patch.  ...and, indeed, reverting that patch gets rid of the
> vast majority of my errors.
> 
> If you want to see the ftrace of my high priority worker getting
> blocked for 7.5 ms, you can see:
> 
> https://bugs.chromium.org/p/chromium/issues/attachmentText?aid=392715
> 
> 
> In my case I'm looking at solving my problems by bumping the CrOS EC
> transfers fully up to real time priority.  ...but given that there are
> other reports of problems with the dm-crypt priority (notably I found
> https://bugzilla.kernel.org/show_bug.cgi?id=199857) maybe we should
> also come up with a different solution for dm-crypt?
> 

And chance you can test how behaviour changes if you remove
WQ_CPU_INTENSIVE? e.g.:

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 692cddf3fe2a..c97d5d807311 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2827,8 +2827,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	ret = -ENOMEM;
 	cc->io_queue = alloc_workqueue("kcryptd_io/%s",
-				       WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
-				       1, devname);
+				       WQ_HIGHPRI | WQ_MEM_RECLAIM, 1, devname);
 	if (!cc->io_queue) {
 		ti->error = "Couldn't create kcryptd io queue";
 		goto bad;
@@ -2836,11 +2835,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	if (test_bit(DM_CRYPT_SAME_CPU, &cc->flags))
 		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
-						  WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
-						  1, devname);
+						  WQ_HIGHPRI | WQ_MEM_RECLAIM, 1, devname);
 	else
 		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
-						  WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
+						  WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
 						  num_online_cpus(), devname);
 	if (!cc->crypt_queue) {
 		ti->error = "Couldn't create kcryptd queue";
