Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6221C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976BE2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELLsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 07:48:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfELLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 07:48:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F4122B53C7888E2F4D59;
        Sun, 12 May 2019 19:48:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sun, 12 May 2019
 19:48:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
        <akpm@linux-foundation.org>, <geert+renesas@glider.be>,
        <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ARM: mm: remove unused variables
Date:   Sun, 12 May 2019 19:41:05 +0800
Message-ID: <20190512114105.41792-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc warnings:

arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:456:13: warning: unused variable 'itcm_end' [-Wunused-variable]
  extern u32 itcm_end;
             ^
arch/arm/mm/init.c:455:13: warning: unused variable 'dtcm_end' [-Wunused-variable]
  extern u32 dtcm_end;
             ^

They are not used any more since
commit 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mm/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be0b429..c71ecbb 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -450,12 +450,6 @@ static void __init free_highpages(void)
  */
 void __init mem_init(void)
 {
-#ifdef CONFIG_HAVE_TCM
-	/* These pointers are filled in on TCM detection */
-	extern u32 dtcm_end;
-	extern u32 itcm_end;
-#endif
-
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
 	/* this will put all unused low memory onto the freelists */
-- 
2.7.4


