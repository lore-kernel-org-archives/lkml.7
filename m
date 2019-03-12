Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B2206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411333;
	bh=0c1gC9KHLLotoLG+fu8m2RbtGCyJckNtIsZYP2/U/XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dd+nxIbZlLOqTgVT/zkTSwT5VcIjdfELsArEAIt6SLCiM6aXyUgcVNw2u6AgM7MwW
	 tHg+f2mPlKRgfd5KhX2wppWFXu+bPysFzP5Z2540kp059e3A48oaDeB2U4Gfv+JxQy
	 PRPqk4R4i31BrWrGIVTNxi7Rs899tkBMAddB0CMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfCLRWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfCLRSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CD72184C;
        Tue, 12 Mar 2019 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411089;
        bh=0c1gC9KHLLotoLG+fu8m2RbtGCyJckNtIsZYP2/U/XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9ru/f6KRR5CiNeyWSqX4V8nZTkOrfaMkytU5XT3X0QdWhUiHzi0v3NgIlZTA9kye
         Usx1AUXTX4Jk4+ZGdH3V29mTvtTufPpZ1rb0RnSgDXnLQrYyGA36kqX35nw7fM3+T3
         KmABiccFydCTJoQCXchzaRT8/YaCSyETDqT3D5co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 68/96] usb: phy: fix link errors
Date:   Tue, 12 Mar 2019 10:10:26 -0700
Message-Id: <20190312171039.724096063@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 125cea1c3c8d..19ce615455c1 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -20,7 +20,7 @@ config AB8500_USB
 
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
 	help
-- 
2.19.1



