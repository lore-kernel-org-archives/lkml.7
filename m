Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300AF2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437427AbfIUB4s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:56:48 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25411 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437018AbfIUB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569030999; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=YFOQ8/rHVTQlLmsfUKxwD/HKr3aI8kncS1BAgGg4t00psmsMGA0CLTSBtSstyIRuE57k0FUBoGD/GySXVf3RvGoA+6OE9JVy88oZM7nsV9+d+h9BRoPkvrjW7m0/hX72K96fksCFUpKced0GEBavmp1MKWI1Tcso/Pmtc2IVhVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569030999; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=U/wMbNMp4BbaqUckWeT2SBc3ztTx39P1i8YQ9Wzd5yo=; 
        b=oxwOy4Ae/RJGeO3RdPpHAE/bfQoRIHcR9NiTYf+ZG1XofSzlcc4zBz/iYarz6Ue0GXUcWR9mXCTXug6RjDo707b2yteOU2mHWJwbc/Dp4zH/M2KsSnLYeuAyuUP510BWoH4NDWKK4aUxG0Tw5lPnCRHF/BE8FxZGVB+ew6wO3E4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain.localdomain (113.116.156.204 [113.116.156.204]) by mx.zoho.com.cn
        with SMTPS id 1569030996721696.1129061703754; Sat, 21 Sep 2019 09:56:36 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190921015628.54335-1-cgxu519@zoho.com.cn>
Subject: [PATCH] quota: code cleanup for hash bits calculation
Date:   Sat, 21 Sep 2019 09:56:28 +0800
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
calling rounddown_pow_of_two() and ilog2()

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/quota/dquot.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..679dd3b5db70 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2983,13 +2983,9 @@ static int __init dquot_init(void)
 
 	/* Find power-of-two hlist_heads which can fit into allocation */
 	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
-	dq_hash_bits = 0;
-	do {
-		dq_hash_bits++;
-	} while (nr_hash >> dq_hash_bits);
-	dq_hash_bits--;
+	nr_hash = rounddown_pow_of_two(nr_hash);
+	dq_hash_bits = ilog2(nr_hash);
 
-	nr_hash = 1UL << dq_hash_bits;
 	dq_hash_mask = nr_hash - 1;
 	for (i = 0; i < nr_hash; i++)
 		INIT_HLIST_HEAD(dquot_hash + i);
-- 
2.21.0



