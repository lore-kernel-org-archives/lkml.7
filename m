Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52018C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D89F20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfIWLjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfIWLjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18329AAB0;
        Mon, 23 Sep 2019 11:39:38 +0000 (UTC)
Date:   Mon, 23 Sep 2019 13:39:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: Fix unnecessary returning broken pipe error from
 devkmsg_read
Message-ID: <20190923113936.73lhmpxurynem62e@pathway.suse.cz>
References: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
 <20190923100513.GA51932@jagdpanzerIV>
 <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-23 18:45:18, He Zhe wrote:
> 
> 
> On 9/23/19 6:05 PM, Sergey Senozhatsky wrote:
> > On (09/18/19 21:31), zhe.he@windriver.com wrote:
> >> When users read the buffer from start, there is no need to return -EPIPE
> >> since the possible overflows will not affect the output.
> >>
> > [..]
> >> -	if (user->seq < log_first_seq) {
> >> +	if (user->seq == 0) {
> >> +		user->seq = log_first_seq;
> >> +	} else if (user->seq < log_first_seq) {
> >>  		/* our last seen message is gone, return error and reset */
> >>  		user->idx = log_first_idx;
> >>  		user->seq = log_first_seq;
> > A tough call.
> >
> > User-space wants to read messages which are gone: log_first_seq > user->seq.
> >
> > I think returning EPIPE is sort of appropriate; user-space, possibly,
> > can printf(stderr, "Some /dev/kmsg messages are gone\n"); or something
> > like that.
> 
> Yes, a tough call. I was looking at the similar part of RT kernel and thought
> that handling was better.
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/printk/printk.c?h=linux-5.2.y-rt#n706

Adding John into CC. He takes care of printk() in RT kernel.


> IMHO, the EPIPE is used to inform user-space when the buffer has overflown and
> there is a inconsistency/break between what has been read and what has not.

What is the motivation for the change, please?
Have you just noticed the inconsistency between normal and RT kernel?
Or was there any bug report?

We need to be careful to do not break user space. And this patch
modifies the existing behavior.

> When user-space just wants to read the buffer from sequence 0, there would not
> be the inconsistency.
> 
> I think it is NOT necessary to inform user-space, when it just wants to read
> from the beginning of the buffer, that the buffer has changed since the time
> point when it issues the action of reading.

Who would set sequence 0, please?

IMHO, the patch is wrong.

devkmsg_open() initializes user->seq to a valid sequence number.
We should return -EPIPE when user->seq == 0 during devkmsg_open()
and the first messages got lost before the first read.

> But if that IS what we want, the RT
> kernel needs to be changed so that mainline and RT kernel act in the same way.

I agree.

Best Regards,
Petr
