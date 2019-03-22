Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B777E2196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257199;
	bh=hipuiCT8gDrcQ4Po9vPqCZJ6+DiIoQtwcKCylcdmEo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJjv7u+3is5YSXG9TpuV/wM/UQO05nNfLqTPOOYAw/2VJ16KhoVvUr3e5vidbQilj
	 HbZ5KpzYhJPbIaQJzVf3jh+Nvo2rWUGmVwWimz2l87LwEIhZjUFnYZ4YYnEMYR2/fn
	 fabOqikWxmVbshLouWt7D8iqtxKfsM8hYuFzeC/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfCVMTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390687AbfCVMTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE5721900;
        Fri, 22 Mar 2019 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257186;
        bh=hipuiCT8gDrcQ4Po9vPqCZJ6+DiIoQtwcKCylcdmEo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az2IX7dM5MZI0DDxJ1rdDoaajC7AsUUJ9aOy+WypUqC+fBb7rFrFX/sChPgMttfGW
         /X1BrQLepyibd4V4bIdFlMStV9bST73YwcoDlDXjw23W8NwztGY9nF5dg/TYQqPbCn
         kOSGmaWk+Cv3dK+NewHWvrYHGGz+B8BJqLi8M0ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.0 127/238] PCI/ASPM: Use LTR if already enabled by platform
Date:   Fri, 22 Mar 2019 12:15:46 +0100
Message-Id: <20190322111305.993708301@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

commit 10ecc818ea7319b5d0d2b4e1aa6a77323e776f76 upstream.

RussianNeuroMancer reported that the Intel 7265 wifi on a Dell Venue 11 Pro
7140 table stopped working after wakeup from suspend and bisected the
problem to 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't
have LTR").  David Ward reported the same problem on a Dell Latitude 7350.

After af8bb9f89838 ("PCI/ACPI: Request LTR control from platform before
using it"), we don't enable LTR unless the platform has granted LTR control
to us.  In addition, we don't notice if the platform had already enabled
LTR itself.

After 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't have
LTR"), we avoid using LTR if we don't think the path to the device has LTR
enabled.

The combination means that if the platform itself enables LTR but declines
to give the OS control over LTR, we unnecessarily avoided using ASPM L1.2.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201469
Fixes: 9ab105deb60f ("PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR")
Fixes: af8bb9f89838 ("PCI/ACPI: Request LTR control from platform before using it")
Reported-by: RussianNeuroMancer <russianneuromancer@ya.ru>
Reported-by: David Ward <david.ward@ll.mit.edu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2071,11 +2071,8 @@ static void pci_configure_ltr(struct pci
 {
 #ifdef CONFIG_PCIEASPM
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	u32 cap;
 	struct pci_dev *bridge;
-
-	if (!host->native_ltr)
-		return;
+	u32 cap, ctl;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -2084,22 +2081,35 @@ static void pci_configure_ltr(struct pci
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
 
-	/*
-	 * Software must not enable LTR in an Endpoint unless the Root
-	 * Complex and all intermediate Switches indicate support for LTR.
-	 * PCIe r3.1, sec 6.18.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		dev->ltr_path = 1;
-	else {
+	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl);
+	if (ctl & PCI_EXP_DEVCTL2_LTR_EN) {
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+			dev->ltr_path = 1;
+			return;
+		}
+
 		bridge = pci_upstream_bridge(dev);
 		if (bridge && bridge->ltr_path)
 			dev->ltr_path = 1;
+
+		return;
 	}
 
-	if (dev->ltr_path)
+	if (!host->native_ltr)
+		return;
+
+	/*
+	 * Software must not enable LTR in an Endpoint unless the Root
+	 * Complex and all intermediate Switches indicate support for LTR.
+	 * PCIe r4.0, sec 6.18.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    ((bridge = pci_upstream_bridge(dev)) &&
+	      bridge->ltr_path)) {
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_LTR_EN);
+		dev->ltr_path = 1;
+	}
 #endif
 }
 


