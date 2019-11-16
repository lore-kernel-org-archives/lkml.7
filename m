Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70681C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394EE21479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921160;
	bh=tgII95yNo67R1JXOG2XCEJcU+1k6nHpaACezIMZWUnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jAsGQ+PHleurpblu7v/zvBZmVBxE6tKHj4ti9O5yTucNndoqSSw/n4JB/wTQ5ty6Y
	 SgAUGCzGY2htFyoRCERzGOrUqJo8G+MATcHo00QV7e72LsSYEAw8UiU5WctI82nhvC
	 dUmgviutLb2E80v1Zj/t49gRzfraTLF95aEVwQEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfKPQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfKPPqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:16 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB43220836;
        Sat, 16 Nov 2019 15:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919176;
        bh=tgII95yNo67R1JXOG2XCEJcU+1k6nHpaACezIMZWUnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOfMFv/XkscGIVagn1YQoi657CteZjGKR1tLyRnQ4fCf66A+TJoyrLz+4JO4h7H+7
         9QzPhqql2WIoEy+2RcnpKvPOqcmVGPubSH8sRfV7Qb2dkgw+Ip3IXFFpyqp05GbBP+
         so3zacnmetEOp9CiEsElZSExkFGERuOKPiFYOsNI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 184/237] sched/topology: Fix off by one bug
Date:   Sat, 16 Nov 2019 10:40:19 -0500
Message-Id: <20191116154113.7417-184-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index c0a7514649715..74b694392f2fd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1329,7 +1329,7 @@ void sched_init_numa(void)
 	int level = 0;
 	int i, j, k;
 
-	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
+	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);
 	if (!sched_domains_numa_distance)
 		return;
 
-- 
2.20.1

