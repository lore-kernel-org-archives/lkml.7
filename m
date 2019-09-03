Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC585C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B9C233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528382;
	bh=yTa37E69ew+PyFM9YaEtmaGvfFlvf1Qrwn5zd/5ae4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h6UHEfOjpxlJCylroG5IAVHA198aWSBXTirOQlByMOuhFi9DrtRy7OIPzFu1GT7td
	 3h5AM0k+xjBfOm5LyuL8s9bX+gD3U2mYlVmjZ2FjkEfS52U063+io8efDJo8jC6ZRt
	 JT9z6x7/05MO7/OJBj2h6Sw/5TTskKtKEC9ZF3tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfICQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbfICQcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:32:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B412343A;
        Tue,  3 Sep 2019 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528325;
        bh=yTa37E69ew+PyFM9YaEtmaGvfFlvf1Qrwn5zd/5ae4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qw0JMBOqgVsdSNt8nsfYPC86pvlIMuAwIPse9eerNzhGDErg+H1a7AZqnei4JfO2R
         yNdNEP3Gm89ItPIlZuZbs092/x2hqSwc94eR59rln5kIfo0d30hTe41l+ZfEevxLrk
         THSJwCu0LRwN0jeYc1bzw2kA1Z7BdMdB7sDhhvrw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 157/167] bcache: only clear BTREE_NODE_dirty bit when it is set
Date:   Tue,  3 Sep 2019 12:25:09 -0400
Message-Id: <20190903162519.7136-157-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit e5ec5f4765ada9c75fb3eee93a6e72f0e50599d5 ]

In bch_btree_cache_free() and btree_node_free(), BTREE_NODE_dirty is
always set no matter btree node is dirty or not. The code looks like
this,
	if (btree_node_dirty(b))
		btree_complete_write(b, btree_current_write(b));
	clear_bit(BTREE_NODE_dirty, &b->flags);

Indeed if btree_node_dirty(b) returns false, it means BTREE_NODE_dirty
bit is cleared, then it is unnecessary to clear the bit again.

This patch only clears BTREE_NODE_dirty when btree_node_dirty(b) is
true (the bit is set), to save a few CPU cycles.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/btree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 3f4211b5cd334..8c80833e73a9a 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -772,10 +772,10 @@ void bch_btree_cache_free(struct cache_set *c)
 	while (!list_empty(&c->btree_cache)) {
 		b = list_first_entry(&c->btree_cache, struct btree, list);
 
-		if (btree_node_dirty(b))
+		if (btree_node_dirty(b)) {
 			btree_complete_write(b, btree_current_write(b));
-		clear_bit(BTREE_NODE_dirty, &b->flags);
-
+			clear_bit(BTREE_NODE_dirty, &b->flags);
+		}
 		mca_data_free(b);
 	}
 
@@ -1063,9 +1063,10 @@ static void btree_node_free(struct btree *b)
 
 	mutex_lock(&b->write_lock);
 
-	if (btree_node_dirty(b))
+	if (btree_node_dirty(b)) {
 		btree_complete_write(b, btree_current_write(b));
-	clear_bit(BTREE_NODE_dirty, &b->flags);
+		clear_bit(BTREE_NODE_dirty, &b->flags);
+	}
 
 	mutex_unlock(&b->write_lock);
 
-- 
2.20.1

