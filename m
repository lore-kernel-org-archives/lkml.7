Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8888206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLPLB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:01:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbfLPLB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:01:58 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A52CA99EDB6985B6C7A7;
        Mon, 16 Dec 2019 19:01:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 19:01:50 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>
CC:     <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] EDAC: remove set but not used variable 'ecc_loc'
Date:   Mon, 16 Dec 2019 19:01:21 +0800
Message-ID: <20191216110121.46698-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/i5100_edac.c: In function ‘i5100_read_log’:
drivers/edac/i5100_edac.c:489:11: warning: variable ‘ecc_loc’
set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
changes in V2
-remove the definition of the function i5100_redmemb_ecc_locator()
 drivers/edac/i5100_edac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 0ddc41e47a96..191aa7c19ded 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -259,11 +259,6 @@ static inline u32 i5100_nrecmemb_ras(u32 a)
 	return a & ((1 << 16) - 1);
 }
 
-static inline u32 i5100_redmemb_ecc_locator(u32 a)
-{
-	return a & ((1 << 18) - 1);
-}
-
 static inline u32 i5100_recmema_merr(u32 a)
 {
 	return i5100_nrecmema_merr(a);
@@ -486,7 +481,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
 	u32 dw;
 	u32 dw2;
 	unsigned syndrome = 0;
-	unsigned ecc_loc = 0;
 	unsigned merr;
 	unsigned bank;
 	unsigned rank;
@@ -499,7 +493,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, int chan,
 		pci_read_config_dword(pdev, I5100_REDMEMA, &dw2);
 		syndrome = dw2;
 		pci_read_config_dword(pdev, I5100_REDMEMB, &dw2);
-		ecc_loc = i5100_redmemb_ecc_locator(dw2);
 	}
 
 	if (i5100_validlog_recmemvalid(dw)) {
-- 
2.17.2

