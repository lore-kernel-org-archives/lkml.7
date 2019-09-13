Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AA206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380642;
	bh=ZFE8+QNtXmMbENewwtTgJlgNDip9sKbdVE4+5TxJSWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpKzc6Cg7qnOAYQOfwZ7SllTrYC4JbqCkSnRofaBjhuTCqHVDlrTIUzmpyhRy+ZsA
	 M4+4WrQjxXoQ9v90vnMpH11YowbmXz2JhyBvdQl3Y8vrZBhibZ0gFS8mIXgsMf8BiA
	 Po3exfNyQiUhSUFE31RzO2ngWRwJW4IgK+SPu9iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfIMNRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390017AbfIMNRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:17:15 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 195D0206A5;
        Fri, 13 Sep 2019 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380634;
        bh=ZFE8+QNtXmMbENewwtTgJlgNDip9sKbdVE4+5TxJSWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chSPrX7kUMjVnVgNWhSnKTLfbpmFC9Tgz8rU3CTTPQChD+UvAtM6bn2/zf6qaYLn6
         16OGjgof/cXZ0rJL5Z397rYC0HF3oxwadbXo3KMJa1VnqUywDM1tVZp5RBFnWUHrJ/
         UVkkOxffMXNvqHXi0uGUSuIgJrSZMXrbg3KriEdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/190] PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify code
Date:   Fri, 13 Sep 2019 14:06:24 +0100
Message-Id: <20190913130610.230166835@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e6fdd3bf5aecd8615f31a5128775b9abcf3e0d86 ]

Use devm_pci_alloc_host_bridge() to simplify the error code path.  This
also fixes a leak in the dw_pcie_host_init() error path.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: stable@vger.kernel.org	# v4.13+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index acd50920c2ffd..b57ee79f6d699 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -356,7 +356,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "Missing *config* reg space\n");
 	}
 
-	bridge = pci_alloc_host_bridge(0);
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
@@ -367,7 +367,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
-		goto error;
+		return ret;
 
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
@@ -411,8 +411,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						resource_size(pp->cfg));
 		if (!pci->dbi_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -423,8 +422,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					pp->cfg0_base, pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
 			dev_err(dev, "Error with ioremap in function\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -434,8 +432,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
 			dev_err(dev, "Error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
+			return -ENOMEM;
 		}
 	}
 
@@ -458,14 +455,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			    pp->num_vectors == 0) {
 				dev_err(dev,
 					"Invalid number of vectors\n");
-				goto error;
+				return -EINVAL;
 			}
 		}
 
 		if (!pp->ops->msi_host_init) {
 			ret = dw_pcie_allocate_domains(pp);
 			if (ret)
-				goto error;
+				return ret;
 
 			if (pp->msi_irq)
 				irq_set_chained_handler_and_data(pp->msi_irq,
@@ -474,7 +471,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		} else {
 			ret = pp->ops->msi_host_init(pp);
 			if (ret < 0)
-				goto error;
+				return ret;
 		}
 	}
 
@@ -514,8 +511,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
 		dw_pcie_free_msi(pp);
-error:
-	pci_free_host_bridge(bridge);
 	return ret;
 }
 
-- 
2.20.1



