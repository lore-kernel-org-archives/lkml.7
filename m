Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1C8CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87885214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJZB6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:58:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfJZB6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:58:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E90E473D29F01046C96D;
        Sat, 26 Oct 2019 09:58:46 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 26 Oct 2019
 09:58:40 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <davem@davemloft.net>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>
CC:     <linux-ide@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH] ide: remove set but not used variable 'hwif'
Date:   Sat, 26 Oct 2019 09:57:38 +0800
Message-ID: <20191026015738.4865-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/ide/pmac.c: In function pmac_ide_setup_device:
drivers/ide/pmac.c:1027:14: warning: variable hwif set but not used
[-Wunused-but-set-variable]

Fixes: d58b0c39e32f ("powerpc/macio: Rework hotplug media bay support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/ide/pmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index b5647e3..ea0b064 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1019,7 +1019,6 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 	struct device_node *np = pmif->node;
 	const int *bidp;
 	struct ide_host *host;
-	ide_hwif_t *hwif;
 	struct ide_hw *hws[] = { hw };
 	struct ide_port_info d = pmac_port_info;
 	int rc;
@@ -1075,7 +1074,7 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 		rc = -ENOMEM;
 		goto bail;
 	}
-	hwif = pmif->hwif = host->ports[0];
+	pmif->hwif = host->ports[0];
 
 	if (on_media_bay(pmif)) {
 		/* Fixup bus ID for media bay */
-- 
1.8.3.1

