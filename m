Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879A2FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA2F20865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkFUrzYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfKHNVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfKHNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgN3CjATcB8xdgDiKZbzkvUoJurgAK/0PjXwpC0hsm0=; b=kkFUrzYfceoVGz3pV13UB4D92q
        YBONRPl2gu1V3dUz4YdciUL/lk5GlHmjYOHBKUNywO/VsEJ+BocIfLqjC4NYGhcL3aimJmVFgtU0a
        2WIrVbrXMlpaBDWgFANz67mtPdtVdXt4x39/G+1qiydPXJgUn26Ig0X7/7G0chDIh1EY/AfPQHaXe
        c03XSvW5DgpZRsFT7RM90SpP0/hT2R9XvjSxzi5iGGuMQoppQNuLeve7sXtJyH+OXQUwvZat1XeV6
        jGBBsKVWcdDy8L3+0z1wkMoaYMWZYsLy/rXLD33z4S0O1oIDovO0eE67veKScR7vY4HUk9NZsSNWz
        yTgw0ltw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4CZ-0003ZS-As; Fri, 08 Nov 2019 13:21:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 591E2305FE7;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 43AFB2026E904; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.488364308@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 2/7] sched/fair: Better document newidle_balance()
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst chasing the pick_next_task() race, there was some confusion
about the newidle_balance() return values. Document them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9920,6 +9920,11 @@ static inline void nohz_newidle_balance(
 /*
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
+ *
+ * Returns:
+ *  <0 - we released the lock and there are !fair tasks present
+ *   0 - failed, no new tasks
+ *  >0 - success, new (fair) tasks present
  */
 int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {


