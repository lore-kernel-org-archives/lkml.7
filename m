Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A4206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKNOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:04:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfKNOEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:04:43 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 873AF8907A96FB076A9B;
        Thu, 14 Nov 2019 22:04:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 22:04:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <valdis.kletnieks@vt.edu>, <gregkh@linuxfoundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: exfat: remove two unused functions
Date:   Thu, 14 Nov 2019 22:03:48 +0800
Message-ID: <20191114140348.46088-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/staging/exfat/exfat_core.c:2045:4: warning: symbol 'calc_checksum_1byte' was not declared. Should it be static?
drivers/staging/exfat/exfat_core.c:2080:5: warning: symbol 'calc_checksum_4byte' was not declared. Should it be static?

The two functions has no caller in tree, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/exfat/exfat_core.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 1638ed2..d2d3447 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2042,17 +2042,6 @@ static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 	return (len - 1) / 15 + 3;
 }
 
-u8 calc_checksum_1byte(void *data, s32 len, u8 chksum)
-{
-	int i;
-	u8 *c = (u8 *)data;
-
-	for (i = 0; i < len; i++, c++)
-		chksum = (((chksum & 1) << 7) | ((chksum & 0xFE) >> 1)) + *c;
-
-	return chksum;
-}
-
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 {
 	int i;
@@ -2077,30 +2066,6 @@ u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 	return chksum;
 }
 
-u32 calc_checksum_4byte(void *data, s32 len, u32 chksum, s32 type)
-{
-	int i;
-	u8 *c = (u8 *)data;
-
-	switch (type) {
-	case CS_PBR_SECTOR:
-		for (i = 0; i < len; i++, c++) {
-			if ((i == 106) || (i == 107) || (i == 112))
-				continue;
-			chksum = (((chksum & 1) << 31) |
-				  ((chksum & 0xFFFFFFFE) >> 1)) + (u32)*c;
-		}
-		break;
-	default
-			:
-		for (i = 0; i < len; i++, c++)
-			chksum = (((chksum & 1) << 31) |
-				  ((chksum & 0xFFFFFFFE) >> 1)) + (u32)*c;
-	}
-
-	return chksum;
-}
-
 /*
  *  Name Resolution Functions
  */
-- 
2.7.4


