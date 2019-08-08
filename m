Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FAEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF786217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfHHCDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:03:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730655AbfHHCDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:03:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDAE935F919AAF914DE0;
        Thu,  8 Aug 2019 10:03:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 10:02:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] f2fs: Fix build error while CONFIG_NLS=m
Date:   Thu, 8 Aug 2019 10:02:53 +0800
Message-ID: <20190808020253.27276-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_F2FS_FS=y but CONFIG_NLS=m, building fails:

fs/f2fs/file.o: In function `f2fs_ioctl':
file.c:(.text+0xb86f): undefined reference to `utf16s_to_utf8s'
file.c:(.text+0xe651): undefined reference to `utf8s_to_utf16s'

Select CONFIG_NLS to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 110a38c..95f1b99 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -2,6 +2,7 @@
 config F2FS_FS
 	tristate "F2FS filesystem support"
 	depends on BLOCK
+	select NLS
 	select CRYPTO
 	select CRYPTO_CRC32
 	select F2FS_FS_XATTR if FS_ENCRYPTION
-- 
2.7.4


