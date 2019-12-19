Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E8C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664472467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757053;
	bh=+WTtqAFVopoXQZplgExaFV+agqrd+AIa7dTwWybSTC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fuekzhfzyVZLrbGAWaBiqvpSpPFJmjqVOwg7QXPSjHknut1qhbn9awtReriN2JcpU
	 yUjiC2BGBe8cduO8GzU8g4apZh60J3TG+B6MYleP3pXBSkXKeIxr2v909djd7Qsb4O
	 8HkCyLvs5GgECbrxl/paTua657CEn4EZKSZ/rLKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLSMEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfLSMEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:10 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FB724683;
        Thu, 19 Dec 2019 12:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757049;
        bh=+WTtqAFVopoXQZplgExaFV+agqrd+AIa7dTwWybSTC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J751/wORuYIf/VyBBcqzUDOT1gqPqORGxyQUdPBzOPU0m5n9XO+WcQb08vZjupFzw
         2YXK9CVR5ce6pwbRf9IiFrdYdga9JtJYNlBxcgoa/GRJe7bRCaIYZ/RnDqOa0Zx0N0
         bTH2XhHL5l+/DYNi10C4WU/Pxao3lKvX32WD8dN4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 03/16] PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()
Date:   Thu, 19 Dec 2019 12:03:39 +0000
Message-Id: <20191219120352.382-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@google.com>

Commit d355bb209783 ("PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()")
unexported a bunch of symbols from the PCI core since the only external
users were non-modular IOMMU drivers. Although most of those symbols
can remain private for now, 'pci_{enable,disable_ats()' is required for
the ARM SMMUv3 driver to build as a module, otherwise we get a build
failure as follows:

  | ERROR: "pci_enable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
  | ERROR: "pci_disable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!

Re-export these two functions so that the ARM SMMUv3 driver can be build
as a module.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
[will: rewrote commit message]
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/pci/ats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 982b46f0a54d..dcbcf1331bb2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -69,6 +69,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	dev->ats_enabled = 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_ats);
 
 /**
  * pci_disable_ats - disable the ATS capability
@@ -87,6 +88,7 @@ void pci_disable_ats(struct pci_dev *dev)
 
 	dev->ats_enabled = 0;
 }
+EXPORT_SYMBOL_GPL(pci_disable_ats);
 
 void pci_restore_ats_state(struct pci_dev *dev)
 {
-- 
2.24.1.735.g03f4e72817-goog

