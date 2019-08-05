Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0015B20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011323;
	bh=i7gOVqMtjCBskIH84y4UQDJED3Qg6Jnw4PH2U/WCxUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CfVwhTXDK5kIFXn24PtpdmwbEbrS822mdjW+C2NfDNsCpuRNALlL9o+XJKHyuEHuP
	 sc6zyD2mQql0Jaxxazor12qDPMv/ICcSZQlUYrckaz5N4L+bdwApbwlbVVtbpz6BIe
	 qDSVR9zaADFIcjTE9nAX4J+optfPVuevy/qc/KVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfHENWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfHENV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:21:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA8620880;
        Mon,  5 Aug 2019 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011316;
        bh=i7gOVqMtjCBskIH84y4UQDJED3Qg6Jnw4PH2U/WCxUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvPoyXb9YqhHVUS+10ed9At1ySfSBsWXnCtpujq6qHXuHTvbRl+tI0xttlVb8wXAO
         +sHXE5gvknanYAAPixFbARpOzlebvIIu5VxdJ4BRCZkDcCxh1reXLRxbdqUKYVaD+A
         BRaSc1gAqfL3S+OpwMcDeKSBslEtmP87oxxmfkPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 014/131] PCI: OF: Initialize dev->fwnode appropriately
Date:   Mon,  5 Aug 2019 15:01:41 +0200
Message-Id: <20190805124952.389932592@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 59b099a6c75e4ddceeaf9676422d8d91d0049755 ]

For PCI devices that have an OF node, set the fwnode as well. This way
drivers that rely on fwnode don't need the special case described by
commit f94277af03ea ("of/platform: Initialise dev->fwnode appropriately").

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 73d5adec0a28d..bc7b27a28795d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -22,12 +22,15 @@ void pci_set_of_node(struct pci_dev *dev)
 		return;
 	dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
 						    dev->devfn);
+	if (dev->dev.of_node)
+		dev->dev.fwnode = &dev->dev.of_node->fwnode;
 }
 
 void pci_release_of_node(struct pci_dev *dev)
 {
 	of_node_put(dev->dev.of_node);
 	dev->dev.of_node = NULL;
+	dev->dev.fwnode = NULL;
 }
 
 void pci_set_bus_of_node(struct pci_bus *bus)
@@ -41,13 +44,18 @@ void pci_set_bus_of_node(struct pci_bus *bus)
 		if (node && of_property_read_bool(node, "external-facing"))
 			bus->self->untrusted = true;
 	}
+
 	bus->dev.of_node = node;
+
+	if (bus->dev.of_node)
+		bus->dev.fwnode = &bus->dev.of_node->fwnode;
 }
 
 void pci_release_bus_of_node(struct pci_bus *bus)
 {
 	of_node_put(bus->dev.of_node);
 	bus->dev.of_node = NULL;
+	bus->dev.fwnode = NULL;
 }
 
 struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
-- 
2.20.1



