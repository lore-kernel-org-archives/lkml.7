Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B61218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257106;
	bh=30jEuTb2sc8IKV4P93TVLhopECT0iNJy/gUutzjOHss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUsunqRR2T/loPJv4olxBC0Ai23HwvUv6W/aiFWK73zCcaZcyL7eJ2aipQC4cnQWd
	 kt8PUwsYk3iV2S/EmFFQgb9ZodJGS6Tgmgev/Tu0Tg3hVCqEUDMiY6wHRxlcbnP4Un
	 l7cqs83muEEQ5DbKzbk5bsN/TkTc0QP98WsUz6Y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfCVMSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390113AbfCVMSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2E021900;
        Fri, 22 Mar 2019 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257102;
        bh=30jEuTb2sc8IKV4P93TVLhopECT0iNJy/gUutzjOHss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3NMeX2VOxR9BmpWmTBrp8HInEXaJ73k2lCaJzlMRO1qGuTsyPfUx8sUaXyUuJ5iO
         RiN9dWMQpgz+wDpfnmhlWw5m5lKE8X6PkmKT1YAOASpwIxVTCEnfxLpccEpJRQRMW6
         5Kf6r1p9M7MKsy1l2vRHGIxBvMPKuEYZ58L4Wmkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5.0 133/238] PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
Date:   Fri, 22 Mar 2019 12:15:52 +0100
Message-Id: <20190322111306.317983647@linuxfoundation.org>
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

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

commit 33776d059630e5045ea9ccf756c74de8f9cc86de upstream.

Depending on the capabilities of the PCI controller/platform, the
PCI-to-PCI bridge emulation behavior might need to be different. For
example, on platforms that use the pci-mvebu code, we currently don't
support prefetchable memory BARs, so the corresponding fields in the
PCI-to-PCI bridge configuration space should be read-only.

To implement this, extend pci_bridge_emul_init() to take a "flags"
argument, with currently one flag supported:

PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR

that will make the prefetchable memory base and limit registers
read-only.

The pci-mvebu and pci-aardvark drivers are updated accordingly.

Fixes: 1f08673eef123 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Reported-by: Luís Mendes <luis.p.mendes@gmail.com>
Reported-by: Leigh Brown <leigh@solinno.co.uk>
Tested-by: Leigh Brown <leigh@solinno.co.uk>
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Cc: Luís Mendes <luis.p.mendes@gmail.com>
Cc: Leigh Brown <leigh@solinno.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/pci-aardvark.c |    2 +-
 drivers/pci/controller/pci-mvebu.c    |    2 +-
 drivers/pci/pci-bridge-emul.c         |    8 +++++++-
 drivers/pci/pci-bridge-emul.h         |    7 ++++++-
 4 files changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -499,7 +499,7 @@ static void advk_sw_pci_bridge_init(stru
 	bridge->data = pcie;
 	bridge->ops = &advk_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge);
+	pci_bridge_emul_init(bridge, 0);
 
 }
 
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -583,7 +583,7 @@ static void mvebu_pci_bridge_emul_init(s
 	bridge->data = port;
 	bridge->ops = &mvebu_pci_bridge_emul_ops;
 
-	pci_bridge_emul_init(bridge);
+	pci_bridge_emul_init(bridge, PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR);
 }
 
 static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -267,7 +267,8 @@ const static struct pci_bridge_reg_behav
  * (typically at least vendor, device, revision), the ->ops pointer,
  * and optionally ->data and ->has_pcie.
  */
-int pci_bridge_emul_init(struct pci_bridge_emul *bridge)
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
+			 unsigned int flags)
 {
 	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
@@ -295,6 +296,11 @@ int pci_bridge_emul_init(struct pci_brid
 		}
 	}
 
+	if (flags & PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR) {
+		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].ro = ~0;
+		bridge->pci_regs_behavior[PCI_PREF_MEMORY_BASE / 4].rw = 0;
+	}
+
 	return 0;
 }
 
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -119,7 +119,12 @@ struct pci_bridge_emul {
 	bool has_pcie;
 };
 
-int pci_bridge_emul_init(struct pci_bridge_emul *bridge);
+enum {
+	PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR = BIT(0),
+};
+
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
+			 unsigned int flags);
 void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge);
 
 int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,


