Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE12207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfFMPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:01:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54454 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbfFMPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:01:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D442A281A15
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Fix core validation in probe, move after clocks are enabled
Date:   Thu, 13 Jun 2019 17:01:07 +0200
Message-Id: <20190613150107.7892-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The required clocks needs to be enabled before the first register
access. After commit fe8abf332b8f ("usb: dwc3: support clocks and resets
for DWC3 core"), this happens when the dwc3_core_is_valid function is
called, but the mentioned commit adds that call in the wrong place,
before the clocks are enabled. So, move that call after the
clk_bulk_enable() to ensure the clocks are enabled and the reset
deasserted.

I detected this while, as experiment, I tried to move the clocks and resets
from the glue layer to the DWC3 core on a Samsung Chromebook Plus.

That was not detected before because, in most cases, the glue layer
initializes SoC-specific things and then populates the child "snps,dwc3"
with those clocks already enabled.

Fixes: b873e2d0ea1ef ("usb: dwc3: Do core validation early on probe")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/usb/dwc3/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4aff1d8dbc4f..6e9e172010fc 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1423,11 +1423,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		return -ENODEV;
-	}
-
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1460,6 +1455,12 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret)
 		goto unprepare_clks;
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		ret = -ENODEV;
+		goto disable_clks;
+	}
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1525,6 +1526,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+disable_clks:
 	clk_bulk_disable(dwc->num_clks, dwc->clks);
 unprepare_clks:
 	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
-- 
2.20.1

