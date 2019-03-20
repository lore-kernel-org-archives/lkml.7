Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD24C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700902175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfCTNyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:54:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbfCTNyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:54:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC3227005DDDFBE10CAB;
        Wed, 20 Mar 2019 21:54:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 21:54:21 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
        <osandov@fb.com>, <james.morse@arm.com>, <sfr@canb.auug.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] proc/kcore: Make kcore_modules static
Date:   Wed, 20 Mar 2019 21:54:17 +0800
Message-ID: <20190320135417.13272-1-yuehaibing@huawei.com>
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

Fix sparse warning:

fs/proc/kcore.c:591:19: warning:
 symbol 'kcore_modules' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185..378f453 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -588,7 +588,7 @@ static void __init proc_kcore_text_init(void)
 /*
  * MODULES_VADDR has no intersection with VMALLOC_ADDR.
  */
-struct kcore_list kcore_modules;
+static struct kcore_list kcore_modules;
 static void __init add_modules_range(void)
 {
 	if (MODULES_VADDR != VMALLOC_START && MODULES_END != VMALLOC_END) {
-- 
2.7.0


