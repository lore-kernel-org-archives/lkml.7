Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC02C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D020684
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCDXCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:02:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCDXCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:02:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CD17308404C;
        Mon,  4 Mar 2019 23:02:50 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4596C5D6B3;
        Mon,  4 Mar 2019 23:02:47 +0000 (UTC)
Date:   Mon, 4 Mar 2019 18:02:46 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: x86 VM Boot hang with latest linux-next
Message-ID: <20190304230246.GC20327@redhat.com>
References: <CAKgT0UeMqmojVrNV1i-DdY18EBwbJ_4zVTUggAWas5D5yeU1PQ@mail.gmail.com>
 <20190303034847.GA8699@redhat.com>
 <CAKgT0Ue9+wSL60Bj0drkgVQwem=mh_eTrFMda+inX4=qBgi3dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue9+wSL60Bj0drkgVQwem=mh_eTrFMda+inX4=qBgi3dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 04 Mar 2019 23:02:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03 2019 at 12:06pm -0500,
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> Thanks. The behavior of it has me wondering if we are looking at
> something like an uninitialized data issue or something like that
> since as I mentioned I don't see this occur on every boot, just on
> most of them. So every now and then I can boot up the VM without any
> issues, but most of the time it will boot and then get stuck waiting
> on jobs that take forever.

The commit in question (1efa3bb79d3 "dm: must allocate dm_noclone for
stacked noclone devices") conditionally allocates the 'struct
dm_noclone' and I can only infer that the change is causing a negative
side-effect in virtualized environments (both x86_64 and s390).

I haven't been able to reproduce on x86_64 kvm with virtio-scsi on
fedora 25 though.  Will try fedora 29 shortly, and also try virtio-blk.

Could you please provide your guest's .config (even if just off-list)?
Also, what kernel are you running on the host?

Thanks,
Mike
