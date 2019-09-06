Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9B3C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694762075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AXfYOfO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfIFD62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:58:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34365 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfIFD62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:58:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2474886plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZNViCP0N32DHFiUhZ1GT+X+dOsTn4cyOWa7lJoIVdEI=;
        b=AXfYOfO0nGdxTFvFA7g0aGzz0arsdR5meyAvEGBw6nC3K67QP0Ra7Uk5EVbjWL3/8z
         bWLSvw9aR6b/xweX585dT3l7yJ/s9nlYMCd/Z8U42n0mGBzCI5yusHShTAoCbh+wRly8
         eP2Ik++ors6kq2CxzobNcYIckfffB4q9lI4u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZNViCP0N32DHFiUhZ1GT+X+dOsTn4cyOWa7lJoIVdEI=;
        b=M2O2/xRD8DroAEFjBKrnkh1IdQ/uO8l7XJ8iiFHU42KAEv/1GQf26iJcgvZ6W57lQd
         6uOQ7U/j9KCB0mY7Fatx4mfygCkNdO8cZoaAl5x4kgPd2YZbPkdPVOFtbYotX5hTnB8I
         +gEUfL7sLSMPxDlEfi3UgrlfSPPZ58FPIpCPrXJmMD5si5gKmWDlQlQ3u+YwLTfibctj
         9l91KtJC4U/HsPRPaaBMMvba6eTMn24aw5t2k93eBKYvTs5wxZ8QmTt/Dz6+VzUejedb
         9HhBvqty9R0V7ytf6mm3/E8qxKcT75sAOtIuSz2PJ0rpLKz1OlDZ/YyAM+fdlhhnhOOK
         NjZA==
X-Gm-Message-State: APjAAAVvfo/BemkLea/fc+Z2cVQgsCZKLHEKPU1AHwLYjpC0GE7ZzF7a
        yCO2KobxyYPRVQqv94VufnrQgQ==
X-Google-Smtp-Source: APXvYqy3UPGT19hWhmdlkeWD30hDNsKTu1kGQ8bZGVywyq175psYPAMutrsptQzkk73s2qaqbfANzg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr7049132plb.93.1567742307277;
        Thu, 05 Sep 2019 20:58:27 -0700 (PDT)
Received: from ashah1-OptiPlex-7010.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b5sm6748512pfp.38.2019.09.05.20.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 20:58:26 -0700 (PDT)
From:   Abhishek Shah <abhishek.shah@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Abhishek Shah <abhishek.shah@broadcom.com>
Subject: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before programming it
Date:   Fri,  6 Sep 2019 09:28:13 +0530
Message-Id: <20190906035813.24046-1-abhishek.shah@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invalidate PAXB inbound/outbound address mapping each time before
programming it. This is helpful for the cases where we need to
reprogram inbound/outbound address mapping without resetting PAXB.
kexec kernel is one such example.

Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index e3ca46497470..99a9521ba7ab 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 	return ret;
 }
 
+static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
+{
+	struct iproc_pcie_ib *ib = &pcie->ib;
+	struct iproc_pcie_ob *ob = &pcie->ob;
+	int idx;
+
+	if (pcie->ep_is_internal)
+		return;
+
+	if (pcie->need_ob_cfg) {
+		/* iterate through all OARR mapping regions */
+		for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
+			iproc_pcie_write_reg(pcie,
+					     MAP_REG(IPROC_PCIE_OARR0, idx), 0);
+		}
+	}
+
+	if (pcie->need_ib_cfg) {
+		/* iterate through all IARR mapping regions */
+		for (idx = 0; idx < ib->nr_regions; idx++) {
+			iproc_pcie_write_reg(pcie,
+					     MAP_REG(IPROC_PCIE_IARR0, idx), 0);
+		}
+	}
+}
+
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
 			       struct device_node *msi_node,
 			       u64 *msi_addr)
@@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	iproc_pcie_perst_ctrl(pcie, true);
 	iproc_pcie_perst_ctrl(pcie, false);
 
+	iproc_pcie_invalidate_mapping(pcie);
+
 	if (pcie->need_ob_cfg) {
 		ret = iproc_pcie_map_ranges(pcie, res);
 		if (ret) {
-- 
2.17.1

