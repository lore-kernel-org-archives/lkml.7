Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05392208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUHZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:25:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfFUHZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:25:26 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 028F812DCEED6E197F47;
        Fri, 21 Jun 2019 15:25:24 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Jun 2019
 15:25:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] staging: ks7010: Fix build error
Date:   Fri, 21 Jun 2019 15:24:55 +0800
Message-ID: <20190621072455.14312-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190621070038.GA3029@kroah.com>
References: <20190621070038.GA3029@kroah.com>
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

Add CRYPTO and CRYPTO_HASH dependencies to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8b523f20417d ("staging: ks7010: removed custom Michael MIC implementation.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use 'depends on' instead of 'select'
---
 drivers/staging/ks7010/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
index 0987fdc..9d7cbc8 100644
--- a/drivers/staging/ks7010/Kconfig
+++ b/drivers/staging/ks7010/Kconfig
@@ -5,6 +5,7 @@ config KS7010
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
+	depends on CRYPTO && CRYPTO_HASH
 	help
 	  This is a driver for KeyStream KS7010 based SDIO WIFI cards. It is
 	  found on at least later Spectec SDW-821 (FCC-ID "S2Y-WLAN-11G-K" only,
-- 
2.7.4


