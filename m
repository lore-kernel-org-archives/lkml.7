Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25D4206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714458;
	bh=EJRaAlaxoQ5w5EprQQHjB8rBX/vEQj03XJIgeZe3zJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhf3Of0gtnYZ2XoLEOWOjppsp2OoSKHz1QC63mq07i1pAeLbs1IXKuG543wgpx3M6
	 9S5/UAsqlwTHudyM0QK+rORDVUu5i3kLvtJXAeJUToRXF/cBEPPmmsY1cKVoQwf2nl
	 /1HEQ/TNRLAvmex+z3lKkAtLoQYHfnN4VA04bJYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfC0SHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfC0SHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3409F217F9;
        Wed, 27 Mar 2019 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710022;
        bh=EJRaAlaxoQ5w5EprQQHjB8rBX/vEQj03XJIgeZe3zJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdtp5YJXLT5lwwb5OE0ZdM5d2jdCHetB0s1klHb5AhFgH8y2qYDr+I/gTwTqX9e0l
         gvl4iGPJ5biH7aN7U0fqhBJePKix9t625+3+mvxMkFtibQUEhk/NtMubIbP310Jerm
         snnEEIjEHjc7e2JF4wYgeREjab7RzJNse3rS4fLs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 159/262] sched/topology: Fix percpu data types in struct sd_data & struct s_data
Date:   Wed, 27 Mar 2019 14:00:14 -0400
Message-Id: <20190327180158.10245-159-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index c31d3a47a47c..57c7ed3fe465 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -176,10 +176,10 @@ typedef int (*sched_domain_flags_f)(void);
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
index 3f35ba1d8fde..efca2489d881 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -676,7 +676,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 }
 
 struct s_data {
-	struct sched_domain ** __percpu sd;
+	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
 
-- 
2.19.1

