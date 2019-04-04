Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B90C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844F120449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369865;
	bh=47S0Pso0HxbbKdpbq6SywImh7Wj1h6QJUSbOOZBo/Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/viptdpxhlTIL/viZyP8xJBl2DxXfhSLo7mqDgltKRrxLV+TIdVXwYsvlPXIY420
	 nBEa3JDWfrRK+0fZvfdBaVe5sQgrjuhiwHum+Jb4x50PxVwDMbXzKSIoIZt/fA8JsP
	 29phkAaa16JkhuFRtJ3zKoNUf2RpoBU+jxEA+4Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbfDDJYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733047AbfDDJOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE7F2147C;
        Thu,  4 Apr 2019 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369274;
        bh=47S0Pso0HxbbKdpbq6SywImh7Wj1h6QJUSbOOZBo/Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgpOVq12bDVJuGQ/IXbSZQRuQ7CaZjN/o9gFbJpMRxjPfIvbObe+368WGsJthZnYu
         bOe/lgA2PllP5yRpxjpi47vxtXhlmuE0kKoKuFT8RataMY1M6EWmJVziPH6+SCD319
         fU68BxSHmYXgik+y5nUWdqfLDJBGL0Eaf3bRbDio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 149/246] sched/topology: Fix percpu data types in struct sd_data & struct s_data
Date:   Thu,  4 Apr 2019 10:47:29 +0200
Message-Id: <20190404084624.386574660@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



