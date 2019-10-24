Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079DACA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8CB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503349AbfJXPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:37 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54514 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409866AbfJXPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:36 -0400
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsZnN026966
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:35 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsUeR023479
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:35 -0400
Received: by mail-qk1-f200.google.com with SMTP id x77so23806501qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yKYfNMQHtrbDF/G3Fi58sG8HBu5LDL0Q3jnUUhO0N9U=;
        b=pDDVk8LPXuBRgTLa+8+fhnmhXF6SP0sqZvSpPFTLmD5boUU5jJ3iXf3qyfkas8W5jr
         s/b3ehLpmt8iA27hj5Q4cEqgpQ/zWXedQyqssfMlvX2steLYbg0Aox9VlQ3uDXSKsu8X
         XisrTE/2BDdlu1Q/jqNQZm/9KaWnNA5qtgmCgmpc46u8tbGDg6UZuiChI+BHD973HWb7
         8ESz+QZ5AQJGeMQpbrP4VLGeywnhP4VgQeKt2ORypBwEMsYq3uwA6mgzEm6ZnP5YhvpB
         8mCkvWxU/tPhtfNhxYduLo3MlxDV5YLh4z1CxRH0SKfdg9cYTmOGSiTJSPyP9pqm5clE
         mxOQ==
X-Gm-Message-State: APjAAAXV9f1mMC3xVCF9n6VKpxXxPTc9QVaey2TBDAMhFFGeQk62JVO8
        cylBxyeKXMuvwhsNoGRndi+m/shXlWcCgdzRRuB3C1Ncq2RPo58zwF7yzh+9YT/1sm5MqzMtxxH
        je0Vph3rNK5pMqTM6YF8bEBKpeJsNG+mURFo=
X-Received: by 2002:ac8:2225:: with SMTP id o34mr4928565qto.68.1571932470302;
        Thu, 24 Oct 2019 08:54:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBsKVtiz62Oia4u6IffqufPZzM7lHXCqrHFPfp50DFuDu8QE6bM/XoLuL+c9AKGg/jk/1cIQ==
X-Received: by 2002:ac8:2225:: with SMTP id o34mr4928544qto.68.1571932470041;
        Thu, 24 Oct 2019 08:54:30 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:28 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] staging: exfat: Clean up return code - FFS_MEMORYERR
Date:   Thu, 24 Oct 2019 11:53:19 -0400
Message-Id: <20191024155327.1095907-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_MEMORYERR to -ENOMEM

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  1 -
 drivers/staging/exfat/exfat_core.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 00e5e37100ce..2588a6cbe552 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -218,7 +218,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
-#define FFS_MEMORYERR           17
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 23c369fb98e5..fa2bf18b4a14 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -177,7 +177,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 							       sizeof(struct buffer_head *),
 							       GFP_KERNEL);
 				if (!p_fs->vol_amap)
-					return FFS_MEMORYERR;
+					return -ENOMEM;
 
 				sector = START_SECTOR(p_fs->map_clu);
 
@@ -604,7 +604,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
 						GFP_KERNEL);
 	if (!upcase_table)
-		return FFS_MEMORYERR;
+		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
 
 	while (sector < end_sector) {
@@ -644,7 +644,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 					upcase_table[col_index] = kmalloc_array(UTBL_ROW_COUNT,
 						sizeof(u16), GFP_KERNEL);
 					if (!upcase_table[col_index]) {
-						ret = FFS_MEMORYERR;
+						ret = -ENOMEM;
 						goto error;
 					}
 
@@ -684,7 +684,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
 						GFP_KERNEL);
 	if (!upcase_table)
-		return FFS_MEMORYERR;
+		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
 
 	for (i = 0; index <= 0xFFFF && i < NUM_UPCASE * 2; i += 2) {
@@ -707,7 +707,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 									sizeof(u16),
 									GFP_KERNEL);
 				if (!upcase_table[col_index]) {
-					ret = FFS_MEMORYERR;
+					ret = -ENOMEM;
 					goto error;
 				}
 
-- 
2.23.0

