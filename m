Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F86C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD9220652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611154;
	bh=SEKwVuizM7PcgHmpksIIZh0HPBrRpSX10k3pwBU4kYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tro7uyrzlp+75dH/IW6PQ9Wq/LH4GXhym8Ogi93sly+JiT8X+yQHaRCOwrBwrOKRC
	 QUBzixs4cWyrINieNv712Jl7M6WkUF7TkEDjaNI7RYI00pWg5RZyk+5VZ8B75PLpOI
	 RcfJJOq7Y6KIo+O1MEdmkWCujeOWm4kw+/cTjUYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404306AbfDRSMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbfDRSM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA6920675;
        Thu, 18 Apr 2019 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611149;
        bh=SEKwVuizM7PcgHmpksIIZh0HPBrRpSX10k3pwBU4kYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMr4RXT0oWpe7v7+9sIe/PXlf9rfjkRGTY8LnidAyCPnZjealTYJ+/RfxzHk13vKb
         xZN6vx5TgDWEsUp/EG3CflxmVS2+i+LGTvnnWgL7BpsgSJ1/tzAOHxESbxAtMBdiiJ
         83kJ94i8gPMabGIRXk/QdVqcPBZY85Rq/CUe4HoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 78/93] PCI/ASPM: Save LTR Capability for suspend/resume
Date:   Thu, 18 Apr 2019 19:57:56 +0200
Message-Id: <20190418160444.948574125@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dbbfadf2319005cf528b0f15f12a05d4e4644303 ]

Latency Tolerance Reporting (LTR) allows Endpoints and Switch Upstream
Ports to report their latency requirements to upstream components.  If ASPM
L1 PM substates are enabled, the LTR information helps determine when a
Link enters L1.2 [1].

Software must set the maximum latency values in the LTR Capability based on
characteristics of the platform, then set LTR Mechanism Enable in the
Device Control 2 register in the PCIe Capability.  The device can then use
LTR to report its latency tolerance.

If the device reports a maximum latency value of zero, that means the
device requires the highest possible performance and the ASPM L1.2 substate
is effectively disabled.

We put devices in D3 for suspend, and we assume their internal state is
lost.  On resume, previously we did not restore the LTR Capability, but we
did restore the LTR Mechanism Enable bit, so devices would request the
highest possible performance and ASPM L1.2 wouldn't be used.

[1] PCIe r4.0, sec 5.5.1
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201469
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 53 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5a94a3cf61cd..e91005d0f20c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1233,7 +1233,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
 }
 
-
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -1270,6 +1269,45 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 }
 
+static void pci_save_ltr_state(struct pci_dev *dev)
+{
+	int ltr;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+		return;
+	}
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
+}
+
+static void pci_restore_ltr_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ltr;
+	u16 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state || !ltr)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
+	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
+}
 
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending
@@ -1291,6 +1329,7 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	return pci_save_vc_state(dev);
 }
@@ -1390,7 +1429,12 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
-	/* PCI Express register must be restored first */
+	/*
+	 * Restore max latencies (in the LTR capability) before enabling
+	 * LTR itself (in the PCIe capability).
+	 */
+	pci_restore_ltr_state(dev);
+
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
@@ -3020,6 +3064,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to preallocate PCI-X save buffer\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
+					    2 * sizeof(u16));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
-- 
2.19.1



