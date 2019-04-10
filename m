Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB06C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FCD206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDJHzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:55:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfDJHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:55:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8604B67F4C4B450E1BF0;
        Wed, 10 Apr 2019 15:55:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 15:55:21 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <yamada.masahiro@socionext.com>, <pmladek@suse.com>,
        <andriy.shevchenko@linux.intel.com>, <willy@infradead.org>,
        <joe.lawrence@redhat.com>, <dunlap@infradead.org>,
        <robin.murphy@arm.com>, <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] lib/Kconfig.debug: Fix build error without CONFIG_BLOCK
Date:   Wed, 10 Apr 2019 15:54:34 +0800
Message-ID: <20190410075434.35220-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

If CONFIG_TEST_KMOD is set to M, while CONFIG_BLOCK is not set,
XFS and BTRFS can not be compiled successly.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2020d76..65ad61b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1939,6 +1939,7 @@ config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
 	depends on NETDEVICES && NET_CORE && INET # for TUN
+	depends on BLOCK
 	select TEST_LKM
 	select XFS_FS
 	select TUN
-- 
2.7.4


