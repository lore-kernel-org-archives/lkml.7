Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42663C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A4D217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639100;
	bh=+dH4tLbB5MAGB6/kpQgez879bVH3AbQuXGiy5148d+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oju8Vg0VonxO6DXE6ZT6lbHNLbw2hXVYaoGfA5MqfErQVlo010WrhKUtOs7Fo3hsX
	 nXfaHyPCLRcMuVwrNrCXFN1Tq3tyaCzh1t+7yU4IstPuVdFbmPuKIXQ6eovGavRvUH
	 FOA3l0CEUzfyT1eC34NfRav4cC+KT6r7Mlnq9ciw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbfEWTST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389523AbfEWTSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3B6205ED;
        Thu, 23 May 2019 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639094;
        bh=+dH4tLbB5MAGB6/kpQgez879bVH3AbQuXGiy5148d+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ar3GqiS7FEGm0mJy0Nym22/dlsHCDJqImOZE6hCOFhZUYSyWQhud4/BCjnrioR4Ml
         EmauUBiDhEip4SxzASqE5jNmIDwPRMYctQKBF6G8bdOhZ2tWC+WB83Ft4iXKd20W7e
         QDxi+ffTr6ENs3gHuYu0yCedHZpaANevb4JAQt7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 075/114] PCI: Factor out pcie_retrain_link() function
Date:   Thu, 23 May 2019 21:06:14 +0200
Message-Id: <20190523181738.540233344@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

commit 86fa6a344209d9414ea962b1f1ac6ade9dd7563a upstream.

Factor out pcie_retrain_link() to use for Pericom Retrain Link quirk.  No
functional change intended.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -198,6 +198,29 @@ static void pcie_clkpm_cap_init(struct p
 	link->clkpm_capable = (blacklist) ? 0 : capable;
 }
 
+static bool pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	unsigned long start_jiffies;
+	u16 reg16;
+
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	reg16 |= PCI_EXP_LNKCTL_RL;
+	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+
+	/* Wait for link training end. Break out after waiting for timeout */
+	start_jiffies = jiffies;
+	for (;;) {
+		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
+			break;
+		msleep(1);
+	}
+	return !(reg16 & PCI_EXP_LNKSTA_LT);
+}
+
 /*
  * pcie_aspm_configure_common_clock: check if the 2 ends of a link
  *   could use common clock. If they are, configure them to use the
@@ -207,7 +230,6 @@ static void pcie_aspm_configure_common_c
 {
 	int same_clock = 1;
 	u16 reg16, parent_reg, child_reg[8];
-	unsigned long start_jiffies;
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -265,21 +287,7 @@ static void pcie_aspm_configure_common_c
 		reg16 &= ~PCI_EXP_LNKCTL_CCC;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 
-	/* Retrain link */
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
-
-	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
-		msleep(1);
-	}
-	if (!(reg16 & PCI_EXP_LNKSTA_LT))
+	if (pcie_retrain_link(link))
 		return;
 
 	/* Training failed. Restore common clock configurations */


