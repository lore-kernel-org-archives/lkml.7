Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E77C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622F62084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2FpZWx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDINFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:05:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfDINFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CjtoRP42eTI2LNKFPIrllb450E9S5cHidQXEBfL9NTI=; b=u2FpZWx+pOdYxsV+KF9FSs2+2
        cHRtNcxUUBlCxr1jFI+znAIJB9j19fInApqSG1ZDmPK/Izq6TCnxI2s+x745oRSw5LKDM56RmAvF7
        soal2wTm6ssFcjJuXUGpK7jbJOdZbgdslNhiXtuChZnr+WA1CIlG2wawKD8ZCnwjLFnXrdYHF+mpu
        lBZ59zM3n5Xv9arqflVR6LCMu7i0N3iSIYsGX9TmOyef+9yt+mlIB04zfAlvxjmxkAcX5hSzi1f1U
        nDDO93SFL/3tcYGN3admeerHtBNF5xiB11Rjk6DRfr9tJdRWKkxjqAS9rr3krf7BA3gGg2IfOegpE
        kLs43TueQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDqRO-00087z-98; Tue, 09 Apr 2019 13:05:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D24D4201F29A5; Tue,  9 Apr 2019 15:05:27 +0200 (CEST)
Date:   Tue, 9 Apr 2019 15:05:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, bsegall@google.com,
        torvalds@linux-foundation.org, anton@ozlabs.org, efault@gmx.de,
        mingo@kernel.org, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/fair: Limit sched_cfs_period_timer loop
 to avoid hard lockup
Message-ID: <20190409130527.GR11158@hirez.programming.kicks-ass.net>
References: <20190319130005.25492-1-pauld@redhat.com>
 <tip-06ec5d30e8d57b820d44df6340dcb25010d6d0fa@git.kernel.org>
 <20190409124815.GA10132@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409124815.GA10132@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 08:48:16AM -0400, Phil Auld wrote:
> Hi Ingo, Peter,
> 
> On Wed, Apr 03, 2019 at 01:38:39AM -0700 tip-bot for Phil Auld wrote:
> > Commit-ID:  06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> > Gitweb:     https://git.kernel.org/tip/06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> > Author:     Phil Auld <pauld@redhat.com>
> > AuthorDate: Tue, 19 Mar 2019 09:00:05 -0400
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 3 Apr 2019 09:50:23 +0200
> 
> This commit seems to have gotten lost. It's not in tip and now the 
> direct gitweb link is also showing bad commit reference. 
> 
> Did this fall victim to a reset or something?

It had (trivial) builds fails on 32 bit. I have a fixed up version
around somewhere, but that hasn't made it back in yet.
