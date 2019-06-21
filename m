Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD51C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AFE2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUDml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:42:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfFUDmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:42:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 851351D891CC0D8F197D;
        Fri, 21 Jun 2019 11:42:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 11:42:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: ks7010: Fix build error
Date:   Fri, 21 Jun 2019 11:42:21 +0800
Message-ID: <20190621034221.36708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when CRYPTO is m and KS7010 is y, building fails:

drivers/staging/ks7010/ks_hostif.o: In function `michael_mic.constprop.13':
ks_hostif.c:(.text+0x560): undefined reference to `crypto_alloc_shash'
ks_hostif.c:(.text+0x580): undefined reference to `crypto_shash_setkey'
ks_hostif.c:(.text+0x5e0): undefined reference to `crypto_destroy_tfm'
ks_hostif.c:(.text+0x614): undefined reference to `crypto_shash_update'
ks_hostif.c:(.text+0x62c): undefined reference to `crypto_shash_update'
ks_hostif.c:(.text+0x648): undefined reference to `crypto_shash_finup'

select CRYPTO and CRYPTO_HASH to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC implementation.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/ks7010/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
index 0987fdc..6a20e64 100644
--- a/drivers/staging/ks7010/Kconfig
+++ b/drivers/staging/ks7010/Kconfig
@@ -5,6 +5,8 @@ config KS7010
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
+	select CRYPTO
+	select CRYPTO_HASH
 	help
 	  This is a driver for KeyStream KS7010 based SDIO WIFI cards. It is
 	  found on at least later Spectec SDW-821 (FCC-ID "S2Y-WLAN-11G-K" only,
-- 
2.7.4


