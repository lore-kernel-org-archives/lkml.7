Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B7120700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713357;
	bh=pOnkzWA5b87udnsnYixKhMFFuCBi9wHZfo/7ZQmcpUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EgELOB/V7utt2zHVmMrcv8MR660m2slrwV+fBALIj4MTPwc33vh7hGgCbJLq0ODqZ
	 espJrSv5EIWsd8WJ3dBPHZCMepFuMS9rjr5d1UictXqez3G1P6tBZORfdIxOg3h+Gi
	 l41IaoH02e1W55bKxBDxKu2xHleSVDZ+CH/queiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfC0TCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfC0SNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F7221850;
        Wed, 27 Mar 2019 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710425;
        bh=pOnkzWA5b87udnsnYixKhMFFuCBi9wHZfo/7ZQmcpUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqTmkfEsiikVBZ42o9IPagnH/4edlRgG05mXjRL+3NOWuO4+RUyWpgtYst74hHo2M
         9lcSL0z2vHlEwg1WrvuwZ1UL7aIqTLOTqU/OSwFhRScikwfOsYyn9+K+qPmIBa8x4e
         5WPxAEyFn41LAiCNxTsDMfVBNBZbx5ztGr3h0Brw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 112/192] sched/topology: Fix percpu data types in struct sd_data & struct s_data
Date:   Wed, 27 Mar 2019 14:09:04 -0400
Message-Id: <20190327181025.13507-112-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 99687cdbb3f6c8e32bcc7f37496e811f30460e48 ]

The percpu members of struct sd_data and s_data are declared as:

	struct ... ** __percpu member;

So their type is:

	__percpu pointer to pointer to struct ...

But looking at how they're used, their type should be:

	pointer to __percpu pointer to struct ...

and they should thus be declared as:

	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of these
structures.

This addresses a bunch of Sparse's warnings like:

	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190118144936.79158-1-luc.vanoostenryck@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/topology.h | 8 ++++----
 kernel/sched/topology.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..15f3f61f7e3b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -177,10 +177,10 @@ typedef int (*sched_domain_flags_f)(void);
 #define SDTL_OVERLAP	0x01
 
 struct sd_data {
-	struct sched_domain **__percpu sd;
-	struct sched_domain_shared **__percpu sds;
-	struct sched_group **__percpu sg;
-	struct sched_group_capacity **__percpu sgc;
+	struct sched_domain *__percpu *sd;
+	struct sched_domain_shared *__percpu *sds;
+	struct sched_group *__percpu *sg;
+	struct sched_group_capacity *__percpu *sgc;
 };
 
 struct sched_domain_topology_level {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 505a41c42b96..c0a751464971 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -477,7 +477,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 }
 
 struct s_data {
-	struct sched_domain ** __percpu sd;
+	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
 
-- 
2.19.1

