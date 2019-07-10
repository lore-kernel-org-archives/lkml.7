Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25C0C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F3C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562771057;
	bh=v1Wk/HvLNFBZWtEXQWxjIRIVKkMaRMBZQCIrUWgf9tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdzYByAFDu527xBkIoRJxgZKJUoex+i/+B6h0rM6pS6yAUXGYFGTMsUZTnuOuBf5R
	 injVcz4+VTUuCY5jtVAmeqptFa5bOxPvj5KE8LaeU4CwGvGk3hrSM9rqMmTpc/OVDt
	 yM7MpeKyEmFkfTHczpYAVZWDPfaLjIkS8QB/NtHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfGJPEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfGJPDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:03:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3CA21537;
        Wed, 10 Jul 2019 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562771029;
        bh=v1Wk/HvLNFBZWtEXQWxjIRIVKkMaRMBZQCIrUWgf9tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n32wGNbGxgojV4w2sAMX+8E85PHTozGAgSrq3dJTMru9p7F+PUZbmIJl3Dcgx16tA
         8OcrBU3wKInO0mt7snZJrHxow/4BiH/a5ufSRN0AmgRNTNHCGo2JKUGMigcqEiZzzT
         dtl6Bk1c61QnBwwSHxQa3oOhIoeEe7MwuNiyMyFQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 7/7] dmaengine: imx-sdma: fix use-after-free on probe error path
Date:   Wed, 10 Jul 2019 11:03:35 -0400
Message-Id: <20190710150337.7390-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710150337.7390-1-sashal@kernel.org>
References: <20190710150337.7390-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <thesven73@gmail.com>

[ Upstream commit 2b8066c3deb9140fdf258417a51479b2aeaa7622 ]

If probe() fails anywhere beyond the point where
sdma_get_firmware() is called, then a kernel oops may occur.

Problematic sequence of events:
1. probe() calls sdma_get_firmware(), which schedules the
   firmware callback to run when firmware becomes available,
   using the sdma instance structure as the context
2. probe() encounters an error, which deallocates the
   sdma instance structure
3. firmware becomes available, firmware callback is
   called with deallocated sdma instance structure
4. use after free - kernel oops !

Solution: only attempt to load firmware when we're certain
that probe() will succeed. This guarantees that the firmware
callback's context will remain valid.

Note that the remove() path is unaffected by this issue: the
firmware loader will increment the driver module's use count,
ensuring that the module cannot be unloaded while the
firmware callback is pending or running.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Reviewed-by: Robin Gong <yibin.gong@nxp.com>
[vkoul: fixed braces for if condition]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/imx-sdma.c | 48 ++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b9c29720aeb1..840d0755e24d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1821,27 +1821,6 @@ static int sdma_probe(struct platform_device *pdev)
 	if (pdata && pdata->script_addrs)
 		sdma_add_scripts(sdma, pdata->script_addrs);
 
-	if (pdata) {
-		ret = sdma_get_firmware(sdma, pdata->fw_name);
-		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
-	} else {
-		/*
-		 * Because that device tree does not encode ROM script address,
-		 * the RAM script in firmware is mandatory for device tree
-		 * probe, otherwise it fails.
-		 */
-		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
-					      &fw_name);
-		if (ret)
-			dev_warn(&pdev->dev, "failed to get firmware name\n");
-		else {
-			ret = sdma_get_firmware(sdma, fw_name);
-			if (ret)
-				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
-		}
-	}
-
 	sdma->dma_device.dev = &pdev->dev;
 
 	sdma->dma_device.device_alloc_chan_resources = sdma_alloc_chan_resources;
@@ -1883,6 +1862,33 @@ static int sdma_probe(struct platform_device *pdev)
 		of_node_put(spba_bus);
 	}
 
+	/*
+	 * Kick off firmware loading as the very last step:
+	 * attempt to load firmware only if we're not on the error path, because
+	 * the firmware callback requires a fully functional and allocated sdma
+	 * instance.
+	 */
+	if (pdata) {
+		ret = sdma_get_firmware(sdma, pdata->fw_name);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
+	} else {
+		/*
+		 * Because that device tree does not encode ROM script address,
+		 * the RAM script in firmware is mandatory for device tree
+		 * probe, otherwise it fails.
+		 */
+		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
+					      &fw_name);
+		if (ret) {
+			dev_warn(&pdev->dev, "failed to get firmware name\n");
+		} else {
+			ret = sdma_get_firmware(sdma, fw_name);
+			if (ret)
+				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
+		}
+	}
+
 	return 0;
 
 err_register:
-- 
2.20.1

