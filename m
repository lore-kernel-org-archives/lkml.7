Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB873C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1021903
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887881;
	bh=IM1t6g1nMjKWhDLnyHsa0pI2DuK8mSYSBKumetio6Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBs8uWxn0STgp73Lz0MsJ0nriwOv94EO0D2j+qDzzM911OGS7BV95qFUnRMzCXqXX
	 V2h0kOjZcG+TRpg+MdNXNMT4IcPDmfn1dCUTSApqros63nwzJMsakcfKms/0fdBTim
	 o5HRyRY1UeM9Pm0vOFbHhlNgQg6edcM+p5cnHKOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfK0UvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfK0UvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A5721847;
        Wed, 27 Nov 2019 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887875;
        bh=IM1t6g1nMjKWhDLnyHsa0pI2DuK8mSYSBKumetio6Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xysraq16mvTf55O7A9cdEOBNuRp7rSNUpIA3c4bqTpysgCtA8a/vzYqQ/LwCfQEeF
         M4Aqw1m0AuVhCNV73TFBIryDQVgsKvyMkdqnou3TvckrP6KmbaBvR4jX7ZK+jfQ6F2
         p4PGhQyuVUvQlVoQaRmM3YN6g4vGluulFDk6x2Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 127/211] sched/topology: Fix off by one bug
Date:   Wed, 27 Nov 2019 21:31:00 +0100
Message-Id: <20191127203106.103789668@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 993f0b0510dad98b4e6e39506834dab0d13fd539 ]

With the addition of the NUMA identity level, we increased @level by
one and will run off the end of the array in the distance sort loop.

Fixed: 051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9dcd80ed9d4c1..867d173dab482 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1347,7 +1347,7 @@ void sched_init_numa(void)
 	int level = 0;
 	int i, j, k;
 
-	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
+	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);
 	if (!sched_domains_numa_distance)
 		return;
 
-- 
2.20.1



