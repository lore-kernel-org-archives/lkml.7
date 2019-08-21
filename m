Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F2C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4558C22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=kontais@zoho.com header.b="Lq+ncVyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHUBjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:39:47 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25534 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUBjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566351579; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=fp8j31Xa/U150l7Y6Fbp1R1Sgruh3tmrn7l8PPam2TDipyKsUCznK+wYJYB0oLjpxnKqrj1iBni6Yyb6QccD2kgnL9VySTEr8RDZ0fY+EJRTQSB6TtIGb3K7aZY5v0IVgxmLaSA8m9C3snw9nszXo7vK9Gr6D5+VZ9DmDjzMufY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566351579; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=X1s7c/q2LhXifg1IRo4YM5sxau9UteN88ivBRni95ns=; 
        b=akJ+PnPqyhzoo0FohsHlhOFPprxL8hWejLAIkEahbv7t/ZQBUJ5PrCSijBmgiBM6W9Dg5r1aE7I6+cr9fknT0DRXj3xeG8RWqe+sAKPrTXWMgsKLPWJ6lCsHLXeaZRWn3DUPPZiXGCDztsVLfUdnqFSfpCt8Oj7MqInou2fUsD4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=kontais@zoho.com;
        dmarc=pass header.from=<kontais@zoho.com> header.from=<kontais@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=knMUgmONZ2y/YuDnv7B7dUtCXn8BCbophzl4idit5x/E7rEhfi4A9PzcP1aSMu3bfcbBSQqgJxba
    tJTQJl9+V2oW/czn9qtl1hoaSjPXsYEzn4SapA+3X+28AGv3LyVa  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566351579;
        s=zm2019; d=zoho.com; i=kontais@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=1322;
        bh=X1s7c/q2LhXifg1IRo4YM5sxau9UteN88ivBRni95ns=;
        b=Lq+ncVyE9B0GiDGyQwLxVAJe2SkVKTdmQ24y96S+aHwDOwAPnX9ExnIR7aEtAhe+
        dW5Z7lXicQVW/7DdSaJUIQEe5HVyhwSBl1zBbuj6LMVoUB52IP7ouSkzRlPOP36ECmo
        AirHUhjOybKTub605M8Tzlqh1vhHcJCQUXGpdyqc=
Received: from dev31.localdomain (103.244.59.4 [103.244.59.4]) by mx.zohomail.com
        with SMTPS id 1566351578120361.08327538001834; Tue, 20 Aug 2019 18:39:38 -0700 (PDT)
From:   Zhang Tao <kontais@zoho.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Zhang Tao <zhangtao27@lenovo.com>
Subject: [PATCH] dm table: fix a potential array out of bounds
Date:   Wed, 21 Aug 2019 09:33:31 +0800
Message-Id: <1566351211-13280-1-git-send-email-kontais@zoho.com>
X-Mailer: git-send-email 1.8.3.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Tao <zhangtao27@lenovo.com>

allocate num + 1 for target and offset array, n_highs need num + 1
elements, the last element will be used for node lookup in function
dm_table_find_target.

Signed-off-by: Zhang Tao <zhangtao27@lenovo.com>
---
 drivers/md/dm-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7b6c3ee..fd7f604 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -160,20 +160,22 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 {
 	sector_t *n_highs;
 	struct dm_target *n_targets;
+	unsigned int alloc_num;
 
 	/*
 	 * Allocate both the target array and offset array at once.
 	 * Append an empty entry to catch sectors beyond the end of
 	 * the device.
 	 */
-	n_highs = (sector_t *) dm_vcalloc(num + 1, sizeof(struct dm_target) +
+	alloc_num = num + 1;
+	n_highs = (sector_t *) dm_vcalloc(alloc_num, sizeof(struct dm_target) +
 					  sizeof(sector_t));
 	if (!n_highs)
 		return -ENOMEM;
 
-	n_targets = (struct dm_target *) (n_highs + num);
+	n_targets = (struct dm_target *) (n_highs + alloc_num);
 
-	memset(n_highs, -1, sizeof(*n_highs) * num);
+	memset(n_highs, -1, sizeof(*n_highs) * alloc_num);
 	vfree(t->highs);
 
 	t->num_allocated = num;
-- 
1.8.3.1


