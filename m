Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E5D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZLFBQ9kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCNQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:16:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45309 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfCNQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:16:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so6691786qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QQNK9efwVJSB5uWRv4DAz7KZYo3HiH/2ic9hILiosDs=;
        b=ZLFBQ9krK541EM+bNOaYVDfMPUfeqwoUd3z2SaG0VFLqHe0jIjso43DCHNErb2tFe+
         TVerLtNhGW9uIV2t5yRm6nrNCyMCkVxkSU7Swa2DJKByUOfPKKlmEOJOcVwtRe7nv8oq
         tAVs/S90AGI4uvrwzaSI2PMAB1G8VolV5DONPwGhCNIFX2DZBEN3aLiZiuXLRySyR50z
         mtxzXO8m9Uh1l3D2Lbyg3rQxlCFSbrbkzp+U2K+R9OWl2239+C0bvPHo+y9pmAvAM2vM
         W5MuxBPiCNGihuv5fDfbQqqAP1BvPC2JWBlpSQYpL3uC3Y0H55ebrWk6H63pIJCz3yfK
         LX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QQNK9efwVJSB5uWRv4DAz7KZYo3HiH/2ic9hILiosDs=;
        b=me/DawbpPheOL6BIyeDFQALTamLtP7viBJhbMstYbWR1dmIPFhh0Fu2ultUewDB4Xj
         HZ+GgmiNasU3O84+lXTqDR+mfmrWf/Xv9dx8JeqbmBCyS2EWA2YWOfk5Kaws3CBP2s0g
         NhK4IW33xcX9mdFL39MN0bC1EPQhukEF2AY8941cckHcwIxmprngh6x4OQioF01jPfhn
         J5A4gbGRjEf8rgVqeCqV4f47RYJZUEQUzcBe1l+xlcsKrX1pQAhUKxXbo5SU6tPRbFGs
         DB09pFk8EbgSzx/9Nq5dLpjcPidy8lazp8g3xJDgFYsoO4zyCz+6Xe3SlCYVCVllIcPl
         vOjw==
X-Gm-Message-State: APjAAAU9MT7SBmZQ0QUfFpeK8XcNjIfwnbimWsvhE3b0m6NpT+0AU4Dw
        sFtbcgCxuoqw6CAVoJzJLG9X0uqE1p8=
X-Google-Smtp-Source: APXvYqxaqnmJcuTJMYnkCI7zUdnrYaFofUNmxXXia2QIbvVj4gcell+/qSFrzIgPgXfa6FnG4gL/mg==
X-Received: by 2002:ac8:2b51:: with SMTP id 17mr38804708qtv.328.1552580190237;
        Thu, 14 Mar 2019 09:16:30 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x15sm8710530qts.21.2019.03.14.09.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 09:16:29 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     gkulkarni@cavium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64/mm: fix kernel-doc comments
Date:   Thu, 14 Mar 2019 12:16:19 -0400
Message-Id: <20190314161619.59909-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build a kernel with W=1 generated several warnings due to abuse of
kernel-doc comments, so tidy up comments there a bit.

arch/arm64/mm/numa.c:281: warning: Cannot understand  *
 on line 281 - I thought it was a doc line

Fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/numa.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 06a6f264f2dd..5202f63c29c9 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -124,7 +124,7 @@ static void __init setup_node_to_cpumask_map(void)
 }
 
 /*
- *  Set the cpu to node and mem mapping
+ * Set the cpu to node and mem mapping
  */
 void numa_store_cpu_info(unsigned int cpu)
 {
@@ -200,7 +200,7 @@ void __init setup_per_cpu_areas(void)
 #endif
 
 /**
- * numa_add_memblk - Set node id to memblk
+ * numa_add_memblk() - Set node id to memblk
  * @nid: NUMA node ID of the new memblk
  * @start: Start address of the new memblk
  * @end:  End address of the new memblk
@@ -223,7 +223,7 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	return ret;
 }
 
-/**
+/*
  * Initialize NODE_DATA for a node on the local memory
  */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
@@ -257,7 +257,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
 }
 
-/**
+/*
  * numa_free_distance
  *
  * The current table is freed.
@@ -277,10 +277,8 @@ void __init numa_free_distance(void)
 	numa_distance = NULL;
 }
 
-/**
- *
+/*
  * Create a new NUMA distance table.
- *
  */
 static int __init numa_alloc_distance(void)
 {
@@ -311,7 +309,7 @@ static int __init numa_alloc_distance(void)
 }
 
 /**
- * numa_set_distance - Set inter node NUMA distance from node to node.
+ * numa_set_distance() - Set inter node NUMA distance from node to node.
  * @from: the 'from' node to set distance
  * @to: the 'to'  node to set distance
  * @distance: NUMA distance
@@ -321,7 +319,6 @@ static int __init numa_alloc_distance(void)
  *
  * If @from or @to is higher than the highest known node or lower than zero
  * or @distance doesn't make sense, the call is ignored.
- *
  */
 void __init numa_set_distance(int from, int to, int distance)
 {
@@ -347,7 +344,7 @@ void __init numa_set_distance(int from, int to, int distance)
 	numa_distance[from * numa_distance_cnt + to] = distance;
 }
 
-/**
+/*
  * Return NUMA distance @from to @to
  */
 int __node_distance(int from, int to)
@@ -422,13 +419,15 @@ static int __init numa_init(int (*init_func)(void))
 }
 
 /**
- * dummy_numa_init - Fallback dummy NUMA init
+ * dummy_numa_init() - Fallback dummy NUMA init
  *
  * Used if there's no underlying NUMA architecture, NUMA initialization
  * fails, or NUMA is disabled on the command line.
  *
  * Must online at least one node (node 0) and add memory blocks that cover all
  * allowed memory. It is unlikely that this function fails.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 static int __init dummy_numa_init(void)
 {
@@ -454,9 +453,9 @@ static int __init dummy_numa_init(void)
 }
 
 /**
- * arm64_numa_init - Initialize NUMA
+ * arm64_numa_init() - Initialize NUMA
  *
- * Try each configured NUMA initialization method until one succeeds.  The
+ * Try each configured NUMA initialization method until one succeeds. The
  * last fallback is dummy single node config encomapssing whole memory.
  */
 void __init arm64_numa_init(void)
-- 
2.17.2 (Apple Git-113)

