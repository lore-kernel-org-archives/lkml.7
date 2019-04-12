Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C5FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDLNpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:45:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfDLNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:45:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hEwUS-0007DC-P5; Fri, 12 Apr 2019 13:45:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jon Mason <jdmason@kudzu.us>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vxge: fix return of a free'd memblock on a failed dma mapping
Date:   Fri, 12 Apr 2019 14:45:12 +0100
Message-Id: <20190412134512.28164-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if a pci dma mapping failure is detected a free'd
memblock address is returned rather than a NULL (that indicates
an error). Fix this by ensuring NULL is returned on this error case.

Addresses-Coverity: ("Use after free")
Fixes: 528f727279ae ("vxge: code cleanup and reorganization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 7cde387e5ec6..51cd57ab3d95 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -2366,6 +2366,7 @@ static void *__vxge_hw_blockpool_malloc(struct __vxge_hw_device *devh, u32 size,
 				dma_object->addr))) {
 			vxge_os_dma_free(devh->pdev, memblock,
 				&dma_object->acc_handle);
+			memblock = NULL;
 			goto exit;
 		}
 
-- 
2.20.1

