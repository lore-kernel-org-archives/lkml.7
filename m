Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05381C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81FE2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwcgrcRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgAGJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:13:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAGJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LJedfaMXja7b+egF2xBxy81N7itSb3Uz7KEWlyYZZ/4=; b=hwcgrcRNri3U/OnBWYGvTnopP
        OWv4vq07pGkfVvAAcnwbTSZMTPmgFaKryx7th7kDVUqJnPbVbYZ3OZQVktFdtlVXyIJo3M+iWbDRm
        ZxCPOlYYJLguS2sRVOoSDZcHTYTJQqsDX3eKRqYOL6Xf8LOEKl1o2upPobvMsBp0VYOLLTQFED28a
        uMtrr6N3OM8zgHWMK5WNkZCy6fD99xOuYodlZy+HlT3q/MkT2+Vzl5gs86Sx982Zw46HaL/4e8rCk
        nYVBOH6sGSOeLz7uuyeJTZxQCqCmcuj2/CpmI5RKS+r8+iRuDrr+ytA37QHd4HcCLDJxVat5R3jH6
        U6AxW9g6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iokvN-0001RT-Gk; Tue, 07 Jan 2020 09:13:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49F87304A59;
        Tue,  7 Jan 2020 10:11:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEBE72B284504; Tue,  7 Jan 2020 10:13:15 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:13:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/cputime: code cleanup in
 irqtime_account_process_tick
Message-ID: <20200107091315.GS2844@hirez.programming.kicks-ass.net>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577959674-255537-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200106155350.GB26097@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106155350.GB26097@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 04:53:51PM +0100, Frederic Weisbecker wrote:
> On Thu, Jan 02, 2020 at 06:07:53PM +0800, Alex Shi wrote:
> > In this func, since account_system_time() considers guest time account
> > and other system time.  we could fold the account_guest_time into
> > account_system_time() to simply the code.
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Wanpeng Li <wanpeng.li@hotmail.com>
> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/sched/cputime.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index cff3e656566d..46b837e94fce 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -381,13 +381,10 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
> >  		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
> >  	} else if (user_tick) {
> >  		account_user_time(p, cputime);
> > -	} else if (p == this_rq()->idle) {
> > +	} else if ((p != this_rq()->idle) || (irq_count() != HARDIRQ_OFFSET))
> > +		account_system_time(p, HARDIRQ_OFFSET, cputime);
> > +	else
> 
> I fear we can't really play the exact same game as account_process_tick() here.
> Since this is irqtime precise accounting, we have already computed the
> irqtime delta in account_other_time() (or we will at some point in the future)
> and substracted it from the ticks to account. This means that the remaining cputime
> to account has to be either utime/stime/gtime/idle-time but not interrupt time, or
> we may account interrupt time twice. And account_system_time() tries to account
> irq time, for example if we interrupt a softirq.

OK, I've dropped 2 and 3. Thanks Frederic!
