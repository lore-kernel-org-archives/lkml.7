Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90684C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AD620803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413354;
	bh=JtACATcwmcbz708hHUzdd0IOTSOOkUpjlomJex/Mlv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bcehoq/KQd3NSNl0xcX6o6SGBBAVmYKCDFxAL0Jiofd72KgMJ/x41MmjOPyKWCH1O
	 /yesFG+qSRi4++8AqUAwbPo39sdnn5m99TKzIntI8lacmGd0Xf4kRiRw4ce5vOGDkg
	 zvkNng5Tg3GImiBCJFqwuJeAGjYXL6dXUvH1x9Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfLCWtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbfLCWtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136BC20803;
        Tue,  3 Dec 2019 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413349;
        bh=JtACATcwmcbz708hHUzdd0IOTSOOkUpjlomJex/Mlv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxtkVZPT8swUkTkx9TTf1b7WA0UnLGdjHAPSTYiyq1ufXZMuptpq7fWqhNX0iLxSm
         ZUfqOBQt6N3JbpOsMbEnMCYEm91TKERUSXbPbsfoOtafohfje7+RgS04tXxt9rctR3
         ZFXnLCYNZ3nv2zc3tKS5qK8+skXlaC0aHMxoxwlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shenghui Wang <shhuiw@foxmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/321] bcache: do not check if debug dentry is ERR or NULL explicitly on remove
Date:   Tue,  3 Dec 2019 23:32:41 +0100
Message-Id: <20191203223432.102563399@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4998b4cae9c11..14d381cc6d747 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1491,8 +1491,7 @@ static void cache_set_free(struct closure *cl)
 	struct cache *ca;
 	unsigned int i;
 
-	if (!IS_ERR_OR_NULL(c->debug))
-		debugfs_remove(c->debug);
+	debugfs_remove(c->debug);
 
 	bch_open_buckets_free(c);
 	bch_btree_cache_free(c);
-- 
2.20.1



