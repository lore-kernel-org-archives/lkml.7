Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18091C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E275D206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380879;
	bh=a87RG2IfDm8y/jeALS+aChFaTmKn6VxACxCU8UBvCG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDSbaDyTnXMvTHyYBSE7c+6illLrfZizVGOU5a1Pm35z//PrN3BUPx57It4crXAxz
	 SuGH7ZgFcoRsT/IAXGCZhgIwtqX05ky7NlBu/4OpAbLsS5gU1+EOkRH4zdomwHR/WZ
	 Efh7x+CigwhZnYtV1WQ751fjRWP3w+DoMFBipsrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbfIMNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389614AbfIMNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:21:15 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C41206A5;
        Fri, 13 Sep 2019 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380874;
        bh=a87RG2IfDm8y/jeALS+aChFaTmKn6VxACxCU8UBvCG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwDvPbNvFCH7jKxgIBGWZ4CHfVv5EVdLphSG2eRzxJBerwFECeBbGqnCEjaYtJHTq
         k2Z5JVZbfhMbnFmHtPezUqvNIjQ84gBOokIi1ejlyeixb++XP0Daga6ysW3v+3Rry3
         YDlHmKKQGcTmfLFWr3Zqu3enhVNZVEv86eHWoHDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.2 19/37] bcache: add comments for mutex_lock(&b->write_lock)
Date:   Fri, 13 Sep 2019 14:07:24 +0100
Message-Id: <20190913130518.607029021@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When accessing or modifying BTREE_NODE_dirty bit, it is not always
necessary to acquire b->write_lock. In bch_btree_cache_free() and
mca_reap() acquiring b->write_lock is necessary, and this patch adds
comments to explain why mutex_lock(&b->write_lock) is necessary for
checking or clearing BTREE_NODE_dirty bit there.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/md/bcache/btree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 3fbadf2058a65..9788b2ee6638f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -655,6 +655,11 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 		up(&b->io_mutex);
 	}
 
+	/*
+	 * BTREE_NODE_dirty might be cleared in btree_flush_btree() by
+	 * __bch_btree_node_write(). To avoid an extra flush, acquire
+	 * b->write_lock before checking BTREE_NODE_dirty bit.
+	 */
 	mutex_lock(&b->write_lock);
 	if (btree_node_dirty(b))
 		__bch_btree_node_write(b, &cl);
@@ -778,6 +783,11 @@ void bch_btree_cache_free(struct cache_set *c)
 	while (!list_empty(&c->btree_cache)) {
 		b = list_first_entry(&c->btree_cache, struct btree, list);
 
+		/*
+		 * This function is called by cache_set_free(), no I/O
+		 * request on cache now, it is unnecessary to acquire
+		 * b->write_lock before clearing BTREE_NODE_dirty anymore.
+		 */
 		if (btree_node_dirty(b)) {
 			btree_complete_write(b, btree_current_write(b));
 			clear_bit(BTREE_NODE_dirty, &b->flags);
-- 
2.20.1



