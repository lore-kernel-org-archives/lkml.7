Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52171C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241C320661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCHBse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfCHBsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:48:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A0F93003D2A;
        Fri,  8 Mar 2019 01:48:33 +0000 (UTC)
Received: from straylight.hirudinean.org (ovpn-123-76.rdu2.redhat.com [10.10.123.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4442819C65;
        Fri,  8 Mar 2019 01:48:32 +0000 (UTC)
Date:   Thu, 7 Mar 2019 17:48:29 -0800
From:   Chris Leech <cleech@redhat.com>
To:     Lee Duncan <lduncan@suse.com>
Cc:     Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hare@suse.de
Subject: Re: [PATCH v2] scsi:libiscsi: Hold back_lock when calling
 iscsi_complete_task
Message-ID: <20190308014829.GD68002@straylight.hirudinean.org>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        Lee Duncan <lduncan@suse.com>, Lee Duncan <leeman.duncan@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.de
References: <20190225174130.29496-1-leeman.duncan@gmail.com>
 <20190306182349.GB68002@straylight.hirudinean.org>
 <88c1457c-7831-3341-1c63-11eb82244c4b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c1457c-7831-3341-1c63-11eb82244c4b@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 08 Mar 2019 01:48:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:37:50PM -0800, Lee Duncan wrote:
> On 3/6/19 10:23 AM, Chris Leech wrote:
> > On Mon, Feb 25, 2019 at 09:41:30AM -0800, Lee Duncan wrote:
> >> From: Lee Duncan <lduncan@suse.com>
> >>
> >> If there is an error queueing an iscsi command in
> >> iscsi_queuecommand(), for example if the transport fails
> >> to take the command in sessuin->tt->xmit_task(), then
> >> the error path can call iscsi_complete_task() without
> >> first aquiring the back_lock as required. This can
> >> lead to things like ITT pool can get corrupt, resulting
> >> in duplicate ITTs being sent out.
> >>
> >> The solution is to hold the back_lock around
> >> iscsi_complete_task() calls, and to add a little commenting
> >> to help others understand when back_lock must be held.
> >>
> >> Signed-off-by: Lee Duncan <lduncan@suse.com>
> >> ---
> > 
> > Lee,
> > 
> > Quick question, can you confirm that you tested this with lockdep?
> > 
> > It seems right to me, it's just that we've been hit with lockdep
> > problems dealing with these locks before.
> > 
> > - Chris
> 
> I'm glad you asked, to keep me honest -- I had not done it yet, because
> it seemed obvious to me.
> 
> But I did check today, and did not find any deadlock nor leaks. I was
> testing on a 5.0.0-1 kernel.

Thanks!

Acked-by: Chris Leech <cleech@redhat.com>

