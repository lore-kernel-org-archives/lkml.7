Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832EFECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53621655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dapvP4cE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfJGMjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:39:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NmMxgOpk+zChObqScgErQUa8ovA4vZzqiyXm38cl5PM=; b=dapvP4cEpBpOPnz4+8wMTFWU2
        tg0xy4QsH/C4AMgI4jzyAD7dCIuyUQHtzQmFJ4DAMuk5WX0ZOzv0V7YTpsZS/vRD3QSoGf13mtgOd
        OUszb7ntAAQ6pIWJAcnoDGkdxBCl7BTupQivTgOiygB8ujTaKa8OppxvqEYu3djL6HvVWMinTU2ZS
        uDoj/kzq+RM1VFsomoPvi2FRnP9/WTbvf6umMhS5ezww1FcLRdHxhceK9l5KneLkDR7idA1JR4FuN
        BwEjov1MRT86zn1e6UzP+1uqDUZwUEO1UVdvFmeY2cb3OxjcYTfDvt3E4wGCiDH+rviOV9GZofxUu
        jXZpO5CvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHSIA-0003IL-97; Mon, 07 Oct 2019 12:39:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 181E130034F;
        Mon,  7 Oct 2019 14:38:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1221E202A1952; Mon,  7 Oct 2019 14:39:09 +0200 (CEST)
Date:   Mon, 7 Oct 2019 14:39:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>
Subject: Re: [PATCH v2] lib/smp_processor_id: Don't use cpumask_equal()
Message-ID: <20191007123909.GE2294@hirez.programming.kicks-ass.net>
References: <20191003203608.21881-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003203608.21881-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 04:36:08PM -0400, Waiman Long wrote:
> The check_preemption_disabled() function uses cpumask_equal() to see
> if the task is bounded to the current CPU only. cpumask_equal() calls
> memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
> the slow memcmp() function in lib/string.c is used.
> 
> On a RT kernel that call check_preemption_disabled() very frequently,
> below is the perf-record output of a certain microbenchmark:
> 
>   42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
>   40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp
> 
> We should avoid calling memcmp() in performance critical path. So the
> cpumask_equal() call is now replaced with an equivalent simpler check.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks!
