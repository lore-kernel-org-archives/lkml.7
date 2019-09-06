Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295CB20678
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392117AbfIFDa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:30:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392106AbfIFDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:30:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1505E259FF9CE83B7552;
        Fri,  6 Sep 2019 11:30:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 11:30:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Julia.Lawall@lip6.fr>, <Gilles.Muller@lip6.fr>,
        <nicolas.palix@imag.fr>, <michal.lkml@markovi.net>,
        <gregkh@linuxfoundation.org>, <swboyd@chromium.org>,
        <yuehaibing@huawei.com>
CC:     <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] coccinelle: platform_get_irq: Fix parse error
Date:   Fri, 6 Sep 2019 11:30:06 +0800
Message-ID: <20190906033006.17616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When do coccicheck, I get this error:

spatch -D report --no-show-diff --very-quiet --cocci-file
./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
--dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
 -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
 -I ./include/uapi -I ./include/generated/uapi
 --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
minus: parse error:
  File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
  around = '\(',
  whole content = if ( ret \( < \| <= \) 0 )

In commit e56476897448 ("fpga: Remove dev_err() usage
after platform_get_irq()") log, I found the semantic patch,
it fix this issue.

Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 scripts/coccinelle/api/platform_get_irq.cocci | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index f6e1afc..06b6a95 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -21,7 +21,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 if (ret != -EPROBE_DEFER)
@@ -47,7 +47,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 -if (ret != -EPROBE_DEFER)
@@ -74,7 +74,7 @@ platform_get_irq
 platform_get_irq_byname
 )(E, ...);
 
-if ( ret \( < \| <= \) 0 )
+if ( \( ret < 0 \| ret <= 0 \) )
 {
 (
 if (ret != -EPROBE_DEFER)
-- 
2.7.4


