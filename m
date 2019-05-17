Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A621C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7520578
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WlKVIgzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEQHqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfEQHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tmsLUqIFffsMwKQ5rrShy/n7aicGtwKA3Co+5yH2+Eg=; b=WlKVIgzco8hD114GFqSmSVlYG
        K2zQzSLvlv60DtdYFvgpuRPtl/oRuvEOe+/9ddFbi/jRYzLsKrIum562tmMKMnojsQi9qWDxfXd4p
        KPha8+/UkXK81SCyePFKP9Pv+zk1veQdlkwEfy0YqrRWn6DmHFAtFf4Z6spJBynUmTsbPe5MDhwwy
        A5eh+ihjU8UsRYfLvivj2FAk8t3mzch1FlFP9sVLI9hiBSGPSru9eH9opBbR1s0gm20Ub4SQYQy8t
        0pjVpSrC8oc8EDeZJvqsxYFAEy+FN735BEuHG3Aqgop8K27A+4suNH6R7BZkdK9v8DBL/Fcj01iAz
        2itne3pmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRXZ3-0002Yb-LT; Fri, 17 May 2019 07:46:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2256D2027C9FD; Fri, 17 May 2019 09:46:00 +0200 (CEST)
Date:   Fri, 17 May 2019 09:46:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "kasong@redhat.com" <kasong@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:51:55PM +0000, Song Liu wrote:
> Hi, 
> 
> We found a failure with selftests/bpf/tests_prog in test_stacktrace_map (on bpf/master
> branch). 
> 
> After digging into the code, we found that perf_callchain_kernel() is giving empty
> callchain for tracepoint sched/sched_switch. And it seems related to commit
> 
> d15d356887e770c5f2dcf963b52c7cb510c9e42d
> ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> 
> Before this commit, perf_callchain_kernel() returns callchain with regs->ip. With
> this commit, regs->ip is not sent for !perf_hw_regs(regs) case. 

So while I think the below is indeed right; we should store regs->ip
regardless of the unwind path chosen, I still think there's something
fishy if this results in just the 1 entry.

The sched/sched_switch event really should have a non-trivial stack.

Let me see if I can reproduce with just perf.
