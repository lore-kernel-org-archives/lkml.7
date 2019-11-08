Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B620C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4758C2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DrU3rcVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfKHNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfKHNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jf1k3sM3wl4/jDj/QHvTwKV6U+u2sGKxNz0VSjSHmWY=; b=DrU3rcVs66lkMcq+eT/uy/a225
        hlb+1u7Bnhq6p6G39D88RgAoiWQNKcMxgnturJZste+E3ZAr1twYeb8/u3JihPeTcWbw6/aeavdMm
        dR7t0D1ecZ35NCvsFC9zp5FByzaYbKKn6FIsFyCQRg2EksCx+0ReLor3QHa7fNP80krXVx3+vL4hD
        9m+X9aeML5bAMRiin6aeo7vDEf+Tji9Uaboeseat0vMjzACIUFmCQPy4zhg2F0/zuCaoX3JZtR7l/
        TnCG5Engv4jNAU8+MP9wNYcSofDnTopbddRmfwK73zUDkjpWCae3PAO4Cyx/ataKf3qoOOi8O0VvL
        iKB1vb4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4CY-0006lI-SY; Fri, 08 Nov 2019 13:21:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1466306CAC;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 52B8820C10EBD; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.717931380@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 6/7] sched/fair: Use mul_u32_u32()
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the code I encountered another site where we should be
using mul_u32_u32() because GCC just won't take a hint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -229,8 +229,7 @@ static u64 __calc_delta(u64 delta_exec,
 		}
 	}
 
-	/* hint to use a 32x32->64 mul */
-	fact = (u64)(u32)fact * lw->inv_weight;
+	fact = mul_u32_u32(fact, lw->inv_weight);
 
 	while (fact >> 32) {
 		fact >>= 1;


