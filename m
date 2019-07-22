Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05ACC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B35218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfGVPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:52:21 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:60568 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfGVPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:52:16 -0400
Received: from [195.176.96.199] (helo=jupiter)
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92)
        id 1hpa1N-0008A8-KD; Mon, 22 Jul 2019 17:14:37 +0200
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH 07/10] Pass the return value of kref_put further
Date:   Mon, 22 Jul 2019 17:14:23 +0200
Message-Id: <20190722151426.5266-8-mplaneta@os.inf.tu-dresden.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used in a later patch.

Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 3 ++-
 drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 30a887cf9200..711d7d7f3692 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -541,7 +541,7 @@ static void rxe_dummy_release(struct kref *kref)
 {
 }
 
-void rxe_drop_ref(struct rxe_pool_entry *pelem)
+int rxe_drop_ref(struct rxe_pool_entry *pelem)
 {
 	int res;
 	struct rxe_pool *pool = pelem->pool;
@@ -553,4 +553,5 @@ void rxe_drop_ref(struct rxe_pool_entry *pelem)
 	if (res) {
 		rxe_elem_release(&pelem->ref_cnt);
 	}
+	return res;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b90cc84c5511..1e3508c74dc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -166,6 +166,6 @@ static inline void rxe_add_ref(struct rxe_pool_entry *pelem) {
 }
 
 /* drop a reference on an object */
-void rxe_drop_ref(struct rxe_pool_entry *pelem);
+int rxe_drop_ref(struct rxe_pool_entry *pelem);
 
 #endif /* RXE_POOL_H */
-- 
2.20.1

