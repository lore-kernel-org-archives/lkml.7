Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475D5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193CF24B74
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfFDGVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:21:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfFDGVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:21:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 138E72D886150BB2774;
        Tue,  4 Jun 2019 14:21:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 14:21:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <patches@armlinux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>,
        <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
        <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <linux@armlinux.org.uk>, <geert@linux-m68k.org>, <krzk@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ARM: mm: remove unused variables
Date:   Tue, 4 Jun 2019 14:19:57 +0800
Message-ID: <20190604061957.18704-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
References: <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
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

Link: https://lkml.org/lkml/2019/5/12/82
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
KernelVersion: 5.2-rc5
 arch/arm/mm/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be0b42937888..c71ecbb04db8 100644
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
2.20.1


