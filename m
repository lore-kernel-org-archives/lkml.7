Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46124C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0182067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHdDBgfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLLPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:24:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfLLPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/RjQApOCHLXz1ezNB0hYM9BgwHOfsdfgZjmYHBLFUwE=; b=MHdDBgfz9CVVpwK8i4UfKFzIp
        ROwltcE151eEuwH18cr7vuwk+lGB98qlJCviTjjcQiGlm0TOQIlYiLF8bVW2P6t9KhJUFiN/KDLK8
        +C7zbvAwwcI64XM3FlGskmC/fjod7ItxH0vyat+sOK/191DgBcs7q8VUZMlYn/+JdeZEzcJG7q5pI
        tBRdVYPJAatJqh4iTKYQFikoCxdnDRIyuBfjP854w9CMayXYaVG1nyXIfNKBrK+YCnWHGkD321nXF
        TfwwkSluIuAJ3T3kCo90TeEyUtQeS/h9iC+HdP1JDSFc3kk5YNU8PFPepGLV/6dr7ca+olVg5xprc
        m0v2EtMRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQK0-0001h0-Oa; Thu, 12 Dec 2019 15:24:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7639304D2B;
        Thu, 12 Dec 2019 16:22:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDBCA2B195D80; Thu, 12 Dec 2019 16:24:06 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:24:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
Message-ID: <20191212152406.GB2827@hirez.programming.kicks-ass.net>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212144102.181510-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:41:02PM +0800, Cheng Jian wrote:

> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")

The 'funny' thing is that select_idle_core() actually does the right
thing.

Copying that should work:


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..416d574dcebf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5828,6 +5837,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
@@ -5859,11 +5869,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
+	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return si_cpu;
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
-			continue;
 		if (available_idle_cpu(cpu))
 			break;
 		if (si_cpu == -1 && sched_idle_cpu(cpu))
