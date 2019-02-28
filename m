Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37838C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C820C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367966;
	bh=aj6Dsm3xjEEULMLNGNzowSYa4VUwHHY2B0cksm7C4Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yO0g+DSBfAhW4SFn97QGPaZyyb0dt6IsaK4mcv2HTdPpyd7mTPO6KNM9f2awlyIt7
	 /TCGzv0ugHgnM1gDLfYjSLmV6u1co5BuTImZsjXm56INsaP0jjVHeV3qJtetEu+zB/
	 wYzMOSc5AcHWMpdKaS5QahNxPSUAdQIKz5clntJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfB1Pcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733285AbfB1PI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67AD218D0;
        Thu, 28 Feb 2019 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366536;
        bh=aj6Dsm3xjEEULMLNGNzowSYa4VUwHHY2B0cksm7C4Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECWycOigr02Iqab3FQzrJRzgZTq3WVSpRlPfeOzHx6lnPUtA8iO0Zs+t8IBKq4Gsh
         tn7KJlR4GPaIlEMbiERXM6UswsqI4k5zVAAc1OkQkWzCMIsvTPi3xIui5Gcf7X4Zhy
         UaNDe/AtU0l5J3Obp1WBafQR2hKZmWza/K9jdp6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 26/81] usb: phy: fix link errors
Date:   Thu, 28 Feb 2019 10:07:18 -0500
Message-Id: <20190228150813.10256-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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

