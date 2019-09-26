Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB7C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4792B222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfIZIet convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:34:49 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25536 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfIZIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:34:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569486867; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JDOAWshIAKHIt9lvZ+E0HsldGL6oEwZ27ZG9ZtMY+2BBOrXHAm/8GXnSAgWx61MPS85swqJ+WKbF6aFMvbAYVyjwZIK+dDrE8qoUiLdfqOjiz3ZunRU7kIiglv/aUvjNtgPijRCVqK50t4jfHiG4M4maCEDEWiBazBqPCS78o58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569486867; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=sY84mFHAUNWRb4RXvWo/1dvC0g5bsM50xgryt7N6/MQ=; 
        b=bFQHzEy2f2R3pZWIr5ovyRuNINZyQnFgWRz1RTVtDH8JdkV76R1kXUvh2dbBI1DzbpKA5tuqTS2yMQQ3a85tlTsN8xws2E9T+0UxUHBfaERoR26Ed3aSeuMLxkID40aSnOGOwQIot7fEEudHmAWskPwKBdbPeL2OHZdIwbPVkRo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1569486865611975.134032737806; Thu, 26 Sep 2019 16:34:25 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190926083408.4269-1-cgxu519@zoho.com.cn>
Subject: [PATCH] quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list
Date:   Thu, 26 Sep 2019 16:34:08 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is meaningless to increase DQST_LOOKUPS number while iterating
over dirty/inuse list, so just avoid it.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/quota/dquot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..00a3c6df2ea3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -595,7 +595,6 @@ int dquot_scan_active(struct super_block *sb,
 		/* Now we have active dquot so we can just increase use count */
 		atomic_inc(&dquot->dq_count);
 		spin_unlock(&dq_list_lock);
-		dqstats_inc(DQST_LOOKUPS);
 		dqput(old_dquot);
 		old_dquot = dquot;
 		/*
@@ -649,7 +648,6 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			 * use count */
 			dqgrab(dquot);
 			spin_unlock(&dq_list_lock);
-			dqstats_inc(DQST_LOOKUPS);
 			err = sb->dq_op->write_dquot(dquot);
 			if (err) {
 				/*
-- 
2.20.1



