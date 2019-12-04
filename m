Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB01C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EBF205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483759;
	bh=VvRfFCC/KgixHFcsaFYlG0r52DlU90PC4AO4Z5QVs/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUe9K40ezSxljLPOSYv3NSmUdcjBbB4OIYkjWo58OxP0eULS7Wgu72EDhLrtXVD/G
	 l11el7EX8xmV4f/k0tsOFLMpKdLxmPuTaQcof5MeBK208GvABLN8ozFVPT0uXpZ0up
	 /kddNlbFyQwfHg0afmon6AjgAAeYRrV2Xe0WQzZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfLDSWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfLDSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:05 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753A3206DF;
        Wed,  4 Dec 2019 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482704;
        bh=VvRfFCC/KgixHFcsaFYlG0r52DlU90PC4AO4Z5QVs/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ1P4uI0/CN3dJ77rZ/c1eXkJoc9kC2gWEs3L3sm/S5Mi6CAMhwKGL0ruMGbJUbUH
         q262zNpD3metNIDiB5wtC5i4kL46gZHMx7+JpIMlhcbw1L73HBhIWJIhGTGb99qfEE
         AdXSVASmrlsyzy4onIOUA3jsXZeBuSY/uS5O3fxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/209] IB/rxe: Make counters thread safe
Date:   Wed,  4 Dec 2019 18:55:15 +0100
Message-Id: <20191204175328.951209411@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit d5108e69fe013ff47ab815b849caba9cc33ca1e5 ]

Current rxe device counters are not thread safe.
When multiple QPs are used, they can be racy.
Make them thread safe by making it atomic64.

Fixes: 0b1e5b99a48b ("IB/rxe: Add port protocol stats")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 6aeb7a165e469..ea4542a9d69e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -59,7 +59,7 @@ int rxe_ib_get_hw_stats(struct ib_device *ibdev,
 		return -EINVAL;
 
 	for (cnt = 0; cnt  < ARRAY_SIZE(rxe_counter_name); cnt++)
-		stats->value[cnt] = dev->stats_counters[cnt];
+		stats->value[cnt] = atomic64_read(&dev->stats_counters[cnt]);
 
 	return ARRAY_SIZE(rxe_counter_name);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index b2b76a316ebae..d1cc89f6f2e33 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -410,16 +410,16 @@ struct rxe_dev {
 	spinlock_t		mmap_offset_lock; /* guard mmap_offset */
 	int			mmap_offset;
 
-	u64			stats_counters[RXE_NUM_OF_COUNTERS];
+	atomic64_t		stats_counters[RXE_NUM_OF_COUNTERS];
 
 	struct rxe_port		port;
 	struct list_head	list;
 	struct crypto_shash	*tfm;
 };
 
-static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters cnt)
+static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
 {
-	rxe->stats_counters[cnt]++;
+	atomic64_inc(&rxe->stats_counters[index]);
 }
 
 static inline struct rxe_dev *to_rdev(struct ib_device *dev)
-- 
2.20.1



