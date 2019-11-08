Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69262C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2A4222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226186;
	bh=l7QRm0jpWs+Dw06KX5tGaULvYirJMr6RQf8NbO314VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeeiNbZEZTQEJznp3ijrfullajW0ActbmSsaDRQ7iy6cuLqAPiQI++ytNVsi0rtdM
	 z8zhLYoYl+qBU76yrGFw/x3ewW3ubEJZVXZMxNkhQg9M+UFcvta7MxoxaQzwx6XWjk
	 CIEjbnU9fjg2z44xOILWHIZp2FpLB6kwQIOGIqyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKHPQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHPQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:23 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8FB222CB;
        Fri,  8 Nov 2019 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226183;
        bh=l7QRm0jpWs+Dw06KX5tGaULvYirJMr6RQf8NbO314VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq2b3vT48ZvrSk6UN7goduuzbfQPQn2Stvu4Yn0fK4XmNVSHUJiqSgVELxORkKKEs
         7o3y7KiNd/fC95rJzaui0HElp//hhleV+9JbRYU0j0lXoMZyGL0GesZyHpORT+nI+P
         L6WwpUMdmM7XmzXwUPyN8FD2l1QQN+5KxELpSlyI=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/9] PCI: Export pci_ats_disabled() as a GPL symbol to modules
Date:   Fri,  8 Nov 2019 15:16:02 +0000
Message-Id: <20191108151608.20932-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building drivers for ATS-aware IOMMUs as modules requires access to
pci_ats_disabled(). Export it as a GPL symbol to get things working.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..4fbe5b576dd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
 }
+EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

