Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C55C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98D20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408137AbfIWNwi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:52:38 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25438 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408054AbfIWNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569246753; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=J+RAoR9tomNVZU/mzeKkMqlwAouomzOPjyiwdjBgbV3GvXnZj+SJe8pYusoWr0Lu7CH7qVSSkBsgbxTXw7krWWhYAj3oAM1Cm0dC3yjaXZ6N4/IklR6Q2IRksE1qZp6tSR9s5otGxEQiMwyq7Fng0DYZBLu/w40askmksYd9v8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569246753; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=e6Khvy3mu9aDU7zyjkFNrandNk8BohZOJUQrMc7mULw=; 
        b=obaB91txsk+YzAyGYQooQMEbrT2k3nvDAV9xVKv4vsyzfdKECBHpnl5kVBBwUt1f7sTLG4q+pKg6dzUgwrKxw55Ct15a0/0MI0mE7ru7CACeoTKDW0bimRJlXvCua3CVSixkM446HPo68rzZA+A51/jANc8lo/86P4mOczTiOv0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain.localdomain (113.116.51.134 [113.116.51.134]) by mx.zoho.com.cn
        with SMTPS id 156924675002389.18761640130299; Mon, 23 Sep 2019 21:52:30 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190923135223.27674-1-cgxu519@zoho.com.cn>
Subject: [PATCH v2] quota: code cleanup for hash bits calculation
Date:   Mon, 23 Sep 2019 21:52:23 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanup for hash bits calculation by
calling ilog2().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
v1->v2:
- Calculate hash bits by directly calling ilog2().

 fs/quota/dquot.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..fde1b94ea587 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2983,11 +2983,7 @@ static int __init dquot_init(void)
 
 	/* Find power-of-two hlist_heads which can fit into allocation */
 	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
-	dq_hash_bits = 0;
-	do {
-		dq_hash_bits++;
-	} while (nr_hash >> dq_hash_bits);
-	dq_hash_bits--;
+	dq_hash_bits = ilog2(nr_hash);
 
 	nr_hash = 1UL << dq_hash_bits;
 	dq_hash_mask = nr_hash - 1;
-- 
2.21.0



