Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A8BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A3820652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012664;
	bh=RN7ybzdrDD1oADSRPOyNshLaTeRNJcRNmclj/bSGKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JstQ4fBIKp2X53KK2TKPaeSNtFAczdQkU/Eq2/DWIiy0YS7XPGxbLBVpjHin14Usv
	 XKSKewsj5ckU9Rm74d+nyiGmWdxt+BCkWKP4S2XEy86z/5hRH1mvQnCc0nFYrRK8EU
	 94n/zeCTTj4i5ytRURUeTkRFRoUKFKvsvceYL0qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfLJVRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfLJVMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B2D208C3;
        Tue, 10 Dec 2019 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012370;
        bh=RN7ybzdrDD1oADSRPOyNshLaTeRNJcRNmclj/bSGKyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2zA06opgfaC5Zgw4ozyE6RIiKB7LaglzhsmPC6JzIwEO+C4FHvHCqOPQh6elvktB
         kqfDzDzVJfy7T8xi+7s9/tT9lhngm1TpTMX4Imd13DQ/AG09Nr5EBXCGClmTVGVTCy
         0xu3EzF9duainQOvEAgxfPlUWjZS5meku7WSoBJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 296/350] xhci-pci: Allow host runtime PM as default also for Intel Ice Lake xHCI
Date:   Tue, 10 Dec 2019 16:06:41 -0500
Message-Id: <20191210210735.9077-257-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 07a594f353655b1628f598add352e7e754f44869 ]

Intel Ice Lake has two xHCI controllers one on PCH and the other as part
of the CPU itself. The latter is also part of the so called Type C
Subsystem (TCSS) sharing ACPI power resources with the PCIe root ports
and the Thunderbolt controllers. In order to put the whole TCSS block
into D3cold the xHCI needs to be runtime suspended as well when idle.

For this reason allow runtime PM as default for Ice Lake TCSS xHCI
controller.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1573836603-10871-5-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1e0236e906879..a0025d23b2573 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -48,6 +48,7 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI		0x15e9
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
+#define PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI		0x8a13
 
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
@@ -212,7 +213,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI ||
-	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI))
+	     pdev->device == PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_ICE_LAKE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-- 
2.20.1

