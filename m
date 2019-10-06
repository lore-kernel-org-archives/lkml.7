Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB613C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B148220862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383833;
	bh=kZEPCmBzfnruGMTP4vMPzELIRnJc++Rbxcjejt8mrIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J7VPwGPgkR5cGkyZfWAOb1TqntmH8cMOxO7fJnOLmgP06Us4t3zKWdku0BFKbgDEj
	 qJdi1WJLMzBPUDlTjlXt1InyDA3m2V62oOHWM/CXFAc7s5SCPWpOd9JXefT2qVE+Ko
	 qJU54VcG7cnsKYPYiI6dxdZ6nGkUYBUApYzl3IvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfJFRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbfJFRns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:43:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A75B20862;
        Sun,  6 Oct 2019 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383827;
        bh=kZEPCmBzfnruGMTP4vMPzELIRnJc++Rbxcjejt8mrIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwO8+UXggHObvNviyPl+ZfH6PCVhCy3UWZBUk+rsNdVvjkPOorZV1VkX/ztI0FcG3
         zFD2rkT6snST6uJJhEDzm9y35bFrVpDZb1/MwUgg+LPgdWiZcrIEd1Hry2Hx7Z0ZSx
         uEd/goIsxfjAopV1b+gSUv+veSCQy3VFei47n04A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 110/166] PCI: Use static const struct, not const static struct
Date:   Sun,  6 Oct 2019 19:21:16 +0200
Message-Id: <20191006171222.680897958@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Wilczynski <kw@linux.com>

[ Upstream commit 8050f3f6645ae0f7e4c1304593f6f7eb2ee7d85c ]

Move the static keyword to the front of declarations of pci_regs_behavior[]
and pcie_cap_regs_behavior[], which resolves compiler warnings when
building with "W=1":

  drivers/pci/pci-bridge-emul.c:41:1: warning: ‘static’ is not at beginning of
  declaration [-Wold-style-declaration]
   const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
   ^
  drivers/pci/pci-bridge-emul.c:176:1: warning: ‘static’ is not at beginning of
  declaration [-Wold-style-declaration]
   const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
   ^

Link: https://lore.kernel.org/r/20190826151436.4672-1-kw@linux.com
Link: https://lore.kernel.org/r/20190828131733.5817-1-kw@linux.com
Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 06083b86d4f45..5fd90105510d9 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -38,7 +38,7 @@ struct pci_bridge_reg_behavior {
 	u32 rsvd;
 };
 
-const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
 	[PCI_COMMAND / 4] = {
 		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -173,7 +173,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	},
 };
 
-const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 	[PCI_CAP_LIST_ID / 4] = {
 		/*
 		 * Capability ID, Next Capability Pointer and
-- 
2.20.1



