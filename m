Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09FCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA22053B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404140;
	bh=27Aee2Qu0qErbEERw1oJDBvvzhWM8S0QTIaSKnmGKpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vspVYceArwWONMdIS+GJ+3vhHhA+yfbKWKEz69uUCbA1Itm++nnaxdevRDyg/0Anc
	 WOnTfH5yYmzIUxA42uGa6hqT40dqA1Upxq4gFAeH1VeTI4B9+jAvruuegwHeLdPIcA
	 wrk7ls8v65d6JbC6jo9X6bQl0yTAp0KfiNhpqnh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfKVG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:28:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfKVFuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834B42070A;
        Fri, 22 Nov 2019 05:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401804;
        bh=27Aee2Qu0qErbEERw1oJDBvvzhWM8S0QTIaSKnmGKpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6k/ipXHRJVy7RKxeiLC7C3Q6Gj5Q4zFJTkGyWvhTUZ2OUAVE9rJiWBy66W1AgEOH
         5CwL39KtLYi3D5QI2y0VWOWJMxChJdm4gNefOalF5j49MyIV/uqEKEtFQtm9+ex3ky
         8UqeJA0lzADHyFzoWCo/u3cwYVuwuP8aZ8bTvgyo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shenghui Wang <shhuiw@foxmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 049/219] bcache: do not check if debug dentry is ERR or NULL explicitly on remove
Date:   Fri, 22 Nov 2019 00:46:21 -0500
Message-Id: <20191122054911.1750-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

[ Upstream commit ae17102316550b4b230a283febe31b2a9ff30084 ]

debugfs_remove and debugfs_remove_recursive will check if the dentry
pointer is NULL or ERR, and will do nothing in that case.

Remove the check in cache_set_free and bch_debug_init.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/debug.c | 3 +--
 drivers/md/bcache/super.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 06da66b2488ae..8c53d874ada4a 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -249,8 +249,7 @@ void bch_debug_init_cache_set(struct cache_set *c)
 
 void bch_debug_exit(void)
 {
-	if (!IS_ERR_OR_NULL(bcache_debug))
-		debugfs_remove_recursive(bcache_debug);
+	debugfs_remove_recursive(bcache_debug);
 }
 
 void __init bch_debug_init(struct kobject *kobj)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2321643974dab..3124399e2607a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1485,8 +1485,7 @@ static void cache_set_free(struct closure *cl)
 	struct cache *ca;
 	unsigned int i;
 
-	if (!IS_ERR_OR_NULL(c->debug))
-		debugfs_remove(c->debug);
+	debugfs_remove(c->debug);
 
 	bch_open_buckets_free(c);
 	bch_btree_cache_free(c);
-- 
2.20.1

