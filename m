Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC21842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NEamSqOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbfG2PYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:24:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfG2PYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FZx89eZZ1cBDWZtSjJDEcEp5nFP6/pPHiWDDeTBCfTQ=; b=NEamSqOt48WRoVpCxOh3/8dAG
        WK6u8E+U0XGi+29bUCas9/PJV88ERYN99TwdcLcCpKfjLzLqrDM8FdSx/dTIlB2Ing2wOMyoLFjWn
        O6mAt5DIepAlznjW+8hEOqoiEaeK6PhXdb2HCHz4pfVSTEs6FMylJTYdzxnkV/Sukg+Av5Qro6FYq
        o0id/pAs8wRem/+ipiqiWLAjB+dw/52cXSb22+/uY53njU52OY/4QW3Ioe02/p1UWOpaOu1Ya/XfG
        50sBtZKx+vHul9PmG3i6d9GVwwgmX9Jeskujp+zNWUanH30zVG23FpIT4fovM+0+D2nOZ+HlrSlUw
        GMs4YIWkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7Vl-0003Ua-SO; Mon, 29 Jul 2019 15:24:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A15AB20B00021; Mon, 29 Jul 2019 17:24:28 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:24:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, dbueso@suse.de,
        mingo@redhat.com, jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH 1/4] locking/rwsem: Add missing ACQUIRE to read_slowpath
 exit when queue is empty
Message-ID: <20190729152428.GH31398@hirez.programming.kicks-ass.net>
References: <20190718134954.496297975@infradead.org>
 <20190718135205.916241783@infradead.org>
 <20190719084956.GA6750@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719084956.GA6750@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:49:56AM +0200, Andrea Parri wrote:
> > @@ -1032,6 +1032,8 @@ rwsem_down_read_slowpath(struct rw_semap
> >  		 */
> >  		if (adjustment && !(atomic_long_read(&sem->count) &
> >  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> > +			/* Provide lock ACQUIRE */
> > +			smp_acquire__after_ctrl_dep();
> 
> Does this also make the lock RCtso?  Or maybe RCtso was already
> guaranteed (and I'm failing to see why)?

I didn't specifically look for that, but I suspect not, esp given the
next patch.

