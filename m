Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3915C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0413218C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368210;
	bh=/tCmCysmJi+p1l9eCzbFxPQDPgIRckyhiAZbfMRf6V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KFcLNJ7RtD1vaPOl5YOp+7DSCLGcAYog5889/J8w5bvAqBDlHXkXpEF2QW2ruw0eI
	 VNVZA48mt4GP3iLBxgC8Cdh6CktiJ7d75RBIB63aDUheH0FvcJS4j77ZIT3/88R5r5
	 SYrgQzTEkJrHBdCBJ+Z1Ha8pBjc56I+gfz+0C9/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfDDI4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbfDDI4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9474C2177E;
        Thu,  4 Apr 2019 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368204;
        bh=/tCmCysmJi+p1l9eCzbFxPQDPgIRckyhiAZbfMRf6V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ds/q8VUAfsZiIkWND5Jb/1XImw/hTt+lr6Cz8YS61lEyMliQSRXqfcXYI3nUq3/zf
         Gxbic65m5I8CvcHu84T26FAFuy8aEa9ixjT1nGdRCOFjZfLzMiy8E9nrZ3LP6mIS/0
         ENi26xePRt09fI5inpTP0rr+MnnEAp4C4bXyydlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/121] sched/topology: Fix percpu data types in struct sd_data & struct s_data
Date:   Thu,  4 Apr 2019 10:47:43 +0200
Message-Id: <20190404084549.334573305@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index cf257c2e728d..5a92baa91e0c 100644
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
index 659e075ef70b..9dcd80ed9d4c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -499,7 +499,7 @@ static int __init isolated_cpu_setup(char *str)
 __setup("isolcpus=", isolated_cpu_setup);
 
 struct s_data {
-	struct sched_domain ** __percpu sd;
+	struct sched_domain * __percpu *sd;
 	struct root_domain	*rd;
 };
 
-- 
2.19.1



