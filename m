Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D26D24676
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430691;
	bh=NNBDTmI8xWCZc994tBLJOC1MAmxYjRS2Dai03XnsvJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yPiUsLAcZHwZS4reOajOLJKuvRCkY9CmgCj40YlwW/KsM9j7GazFcjhS/+dyBsf23
	 yZNTr9V58NNXz/xVNuK7N/VlbhzONraLJBYsxPrSNJGldq3fHRu+z35SBFV9b4Xzkp
	 7547z9JwFK0NoxatQeoIogbaOgKqkKTw9OOrzbKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgAGU6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgAGU6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:58:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F9E21744;
        Tue,  7 Jan 2020 20:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430686;
        bh=NNBDTmI8xWCZc994tBLJOC1MAmxYjRS2Dai03XnsvJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq8ZBqmCSeT6jru/MwxgVZT9imnoLlTx7LpFsYyul42iZNW+xpI0S+UEpC3d6bKAq
         90OHW1ScwDQQ6AlLCwoDzsULqg2oWLkU/p5T9hL2iDfJW++aCiIxGSDTgrz8F1Exhh
         ZyYad9ZFzFreqNhxjNGiKcLxhgW3GvZyKP4So9gU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 055/191] PCI: Add a helper to check Power Resource Requirements _PR3 existence
Date:   Tue,  7 Jan 2020 21:52:55 +0100
Message-Id: <20200107205335.943418103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 52525b7a3cf82adec5c6cf0ecbd23ff228badc94 ]

A driver may want to know the existence of _PR3, to choose different
runtime suspend behavior. A user will be add in next patch.

This is mostly the same as nouveau_pr3_present().

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20191018073848.14590-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c   | 18 ++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..fcfaadc774ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5854,6 +5854,24 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+bool pci_pr3_present(struct pci_dev *pdev)
+{
+	struct acpi_device *adev;
+
+	if (acpi_disabled)
+		return false;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return false;
+
+	return adev->power.flags.power_resources &&
+		acpi_has_method(adev->handle, "_PR3");
+}
+EXPORT_SYMBOL_GPL(pci_pr3_present);
+#endif
+
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..1d15c5d49cdd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2310,9 +2310,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+bool pci_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.20.1



