Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F46C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BA205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430546;
	bh=Drb7JSB57DtMotOFpPRiaDsEWKfqyiq2kMzgnVjtx9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZC+dntRF3aAGd4TwtV5sacqYsti6oVSRcrJ5nWuk/9LBrb/1qWzsadO2AW9f4cFsT
	 AJZR+XkhdFyD7WrOkIxEnYXufywzO01EUO6x0tG+ZvMBu0Sw2DXC9KuSMgwOWqhE7D
	 vNkVq63RBgh1TZv83M7Px38W4mRbzdijGJIcHcjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfG2Tsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390410AbfG2Tsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:48:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA68205F4;
        Mon, 29 Jul 2019 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429719;
        bh=Drb7JSB57DtMotOFpPRiaDsEWKfqyiq2kMzgnVjtx9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jy313OOk5zUuXc4T8FfHA6LDIRq2x/u064DtiqKNzbpm3wWnAeyjodJfoEIH1yQPL
         4cgw/hX2NQFcQl43794K2JMUFdH07pLijY2i4I+q7FzYptSVEk8bkNvwtV95mi74oo
         cLhySnN8vtA5MHE95WdBVHxS1mDgPqkX5PFvpTXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 071/215] usb: dwc3: Fix core validation in probe, move after clocks are enabled
Date:   Mon, 29 Jul 2019 21:21:07 +0200
Message-Id: <20190729190752.561773195@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dc1b5d9aed1794b5a1c6b0da46e372cc09974cbc ]

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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



