Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D670C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EF12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367574;
	bh=aj6Dsm3xjEEULMLNGNzowSYa4VUwHHY2B0cksm7C4Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0vuNVPXMlGO+5oo2sbtcrPVZmec/31uxE8XbAAURL/j0e631yUbLwuCgfAC0z41EC
	 4Fg22ogCsF0vJ38/R5ZELWL1fI/xEbcM2Q6Foy8N8iI5o9zRiwIQmReDN+oo5DcL9M
	 o+GfNvXGa+k6hxSavb5Rj/1hYuJNt/V1a85gjXD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbfB1P0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388043AbfB1PLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A822218D8;
        Thu, 28 Feb 2019 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366705;
        bh=aj6Dsm3xjEEULMLNGNzowSYa4VUwHHY2B0cksm7C4Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AavkHyYvp3GwctzerOXgRM/aZteeRpKExCtWEX91b15p4+Kw86njvNryj/r/aNzXU
         j9UIWWoBouU0OuvV94wWr2wISUPXuiWH19RrSzOmWXDVCp9Wl83mEH9pVEx9oa4tYe
         5wKIS8sJjM+ZjG185YAXs3y6ATmq9WMuAxQx9ews=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/64] usb: phy: fix link errors
Date:   Thu, 28 Feb 2019 10:10:21 -0500
Message-Id: <20190228151105.11277-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit f2105d42597f4d10e431b195d69e96dccaf9b012 ]

Fix link errors when CONFIG_FSL_USB2_OTG is enabled and USB_OTG_FSM is
set to module then the following link error occurs.

aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_ioctl':
drivers/usb/phy/phy-fsl-usb.c:1083: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:1083:(.text+0x574): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_start_srp':
drivers/usb/phy/phy-fsl-usb.c:674: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:674:(.text+0x61c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_set_host':
drivers/usb/phy/phy-fsl-usb.c:593: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:593:(.text+0x7a4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_start_hnp':
drivers/usb/phy/phy-fsl-usb.c:695: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:695:(.text+0x858): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `a_wait_enum':
drivers/usb/phy/phy-fsl-usb.c:274: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:274:(.text+0x16f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o:drivers/usb/phy/phy-fsl-usb.c:619: more undefined references to `otg_statemachine' follow
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_set_peripheral':
drivers/usb/phy/phy-fsl-usb.c:619:(.text+0x1fa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
make[1]: *** [Makefile:1020: vmlinux] Error 1
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:152: sub-make] Error 2
make: Target 'Image' not remade because of errors.

Rework so that FSL_USB2_OTG depends on that the USB_OTG_FSM is builtin.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index d7312eed60882..91ea3083e7ad9 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -21,7 +21,7 @@ config AB8500_USB
 
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
 	help
-- 
2.19.1

