Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720C420717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520110;
	bh=9MaNyCWvJia4kkvMZep4wOiZNAU6Q48KIxe0ZAmr8xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zK7YvFXilpR/2IuoTU598bJKIV18ebR0YY2f3rDWsg2awvwSNsPXWRNVg5DmtbmPe
	 RzXwVzKOs/AnUgjxj3NqBGwXaeuGLqNeqtABR1kXTvfWr0luhl49nHMHkJbfkSbHWG
	 x5aSYojLWjSpD3c81KVKRskHi8O1y8SBLf2xG/IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfLPSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731319AbfLPSPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:15:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F7F20717;
        Mon, 16 Dec 2019 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520103;
        bh=9MaNyCWvJia4kkvMZep4wOiZNAU6Q48KIxe0ZAmr8xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cbGh1U1+ygVS+uJkU11ZORgaL9piq3a12lcNoUiSYW2Fd4epdQ0VgGbkdrEvArv7
         Ag5Ilv0gGT4PPSJ2nnGYwbpcnAEZRXNdGL5dJPObzekjJWkiwHV1S07mpiYzP15rVD
         mU3OLtEHIUehDinP0Y9FBnP1G7v97SwwuGcVsMGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nagarjuna Kristam <nkristam@nvidia.com>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.4 018/177] usb: host: xhci-tegra: Correct phy enable sequence
Date:   Mon, 16 Dec 2019 18:47:54 +0100
Message-Id: <20191216174816.557705483@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagarjuna Kristam <nkristam@nvidia.com>

commit 6351653febbb784d86fdf83afe41f7523a61b392 upstream.

XUSB phy needs to be enabled before un-powergating the power partitions.
However in the current sequence, it happens opposite. Correct the phy
enable and powergating partition sequence to avoid any boot hangs.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jui Chang Kuo <jckuo@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/1572859470-7823-1-git-send-email-nkristam@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -755,7 +755,6 @@ static int tegra_xusb_runtime_suspend(st
 {
 	struct tegra_xusb *tegra = dev_get_drvdata(dev);
 
-	tegra_xusb_phy_disable(tegra);
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 	tegra_xusb_clk_disable(tegra);
 
@@ -779,16 +778,8 @@ static int tegra_xusb_runtime_resume(str
 		goto disable_clk;
 	}
 
-	err = tegra_xusb_phy_enable(tegra);
-	if (err < 0) {
-		dev_err(dev, "failed to enable PHYs: %d\n", err);
-		goto disable_regulator;
-	}
-
 	return 0;
 
-disable_regulator:
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 disable_clk:
 	tegra_xusb_clk_disable(tegra);
 	return err;
@@ -1181,6 +1172,12 @@ static int tegra_xusb_probe(struct platf
 	 */
 	platform_set_drvdata(pdev, tegra);
 
+	err = tegra_xusb_phy_enable(tegra);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable PHYs: %d\n", err);
+		goto put_hcd;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (pm_runtime_enabled(&pdev->dev))
 		err = pm_runtime_get_sync(&pdev->dev);
@@ -1189,7 +1186,7 @@ static int tegra_xusb_probe(struct platf
 
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to enable device: %d\n", err);
-		goto disable_rpm;
+		goto disable_phy;
 	}
 
 	tegra_xusb_config(tegra, regs);
@@ -1275,9 +1272,11 @@ remove_usb2:
 put_rpm:
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_xusb_runtime_suspend(&pdev->dev);
-disable_rpm:
-	pm_runtime_disable(&pdev->dev);
+put_hcd:
 	usb_put_hcd(tegra->hcd);
+disable_phy:
+	tegra_xusb_phy_disable(tegra);
+	pm_runtime_disable(&pdev->dev);
 put_powerdomains:
 	if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {
 		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
@@ -1314,6 +1313,8 @@ static int tegra_xusb_remove(struct plat
 		tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
 	}
 
+	tegra_xusb_phy_disable(tegra);
+
 	tegra_xusb_padctl_put(tegra->padctl);
 
 	return 0;


