Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2294820879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJo8ErLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfEVOJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:09:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ln74my+QSi7KzB+F2bJIpCgBrF8Xr0ky7NTLpHhHq/Y=; b=XJo8ErLH46Q2n8YidklhJSJWN
        9Em644ZcIm72BX1ldS43vPORUWFz6YnohuuVmUYpffw1ZQTPxSz6NBMCpddJYTrGsPtPhB6HP+pkt
        VKJgHDfHuh8MY/qZw+v1qTAnEhbwHkl39hfZcdCuHFRXKuN7xWm5eXHvhfq8qBupv5oVVRNw5BYT4
        M7FkrU24C5C+W45XtkykWy4hkT8/k/iQg5mxN/UyEb0JYoOaVeRuVS03iGstB9mkpAfwDKrUAPgt8
        qae1KpCoyeK97cybViXqV8dE41ffq7cPU2yg8WAWV4fuKmCG3dVGofNIyNeZiReJ/XNoijFr8oDU3
        /pNbsiWkg==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTRvl-0003ZK-GV; Wed, 22 May 2019 14:09:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 562B6984E09; Wed, 22 May 2019 16:09:21 +0200 (CEST)
Date:   Wed, 22 May 2019 16:09:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190522140921.GD16275@worktop.programming.kicks-ass.net>
References: <20190522111537.27815-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522111537.27815-1-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:15:37PM +0100, Andrew Murray wrote:
> When we are able to allocate a cpumask in on_each_cpu_cond_mask
> we call functions with on_each_cpu_mask - this masks out offline
> cpus via smp_call_function_many.
> 
> However when we fail to allocate a cpumask in on_each_cpu_cond_mask
> we call functions with smp_call_function_single - this will return
> -ENXIO from generic_exec_single if a CPU is offline which will
> result in a WARN_ON_ONCE.
> 
> Let's avoid the WARN by only calling smp_call_function_single when
> the CPU is online and thus making both paths consistent with each
> other.

I'm confused, why are you feeding it offline CPUs to begin with? @mask
shouldn't include them.

Is perhaps the problem that on_each_cpu_cond() uses cpu_onlne_mask
without protection?

Something like so?

diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0bb3b8..a493b3dfa67f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -705,8 +707,10 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 			smp_call_func_t func, void *info, bool wait,
 			gfp_t gfp_flags)
 {
+	cpus_read_lock();
 	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
 				cpu_online_mask);
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 

