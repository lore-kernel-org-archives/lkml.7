Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C75C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640598;
	bh=uoGfpUeuIvKrRjJ8W9UmvXGRoaQW3kSZZ1iO8OjKlIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UQ34NBTWFxYbZ9LVgvEMCpDUBEesYCqkgz8Iv428NYuojYQRDHUpInwFYAfUwO8vR
	 UVdSurNWHN/TmuSLrP4Zahso+HHtps9tHYCz+5HHbvvMkxqAOSMtCEVUCB2UzRFY/A
	 gvyNO1OjGnU/Cs6gI1Rt8aldyMRPmL30JHOc9wNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbfEWTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389104AbfEWTSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4203205ED;
        Thu, 23 May 2019 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639086;
        bh=uoGfpUeuIvKrRjJ8W9UmvXGRoaQW3kSZZ1iO8OjKlIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGMfBR3UkQhlc1fyPCiawNBaGYxTb/9XrCgRbZbLfUKUn12ytGnVSE5UIJ/G/2BCV
         NfTlwag4SPUp70Dtu8speJjcEKmcOdmUw8VjOXj+iLTmKXYSga2OuN9aQ045RfAGpA
         nDHwp/q6FBzH3R2P0tYgs1YjGd8jR/ra4qZ9Hc3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 072/114] PCI: Init PCIe feature bits for managed host bridge alloc
Date:   Thu, 23 May 2019 21:06:11 +0200
Message-Id: <20190523181738.279463354@linuxfoundation.org>
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

commit 6302bf3ef78dd210b5ff4a922afcb7d8eff8a211 upstream.

Two functions allocate a host bridge: devm_pci_alloc_host_bridge() and
pci_alloc_host_bridge().  At the moment, only the unmanaged one initializes
the PCIe feature bits, which prevents from using features such as hotplug
or AER on some systems, when booting with device tree.  Make the
initialization code common.

Fixes: 02bfeb484230 ("PCI/portdrv: Simplify PCIe feature permission checking")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -535,16 +535,9 @@ static void pci_release_host_bridge_dev(
 	kfree(to_pci_host_bridge(dev));
 }
 
-struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
+static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
-	struct pci_host_bridge *bridge;
-
-	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
-	if (!bridge)
-		return NULL;
-
 	INIT_LIST_HEAD(&bridge->windows);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
@@ -557,6 +550,18 @@ struct pci_host_bridge *pci_alloc_host_b
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+}
+
+struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
+	pci_init_host_bridge(bridge);
+	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
@@ -571,7 +576,7 @@ struct pci_host_bridge *devm_pci_alloc_h
 	if (!bridge)
 		return NULL;
 
-	INIT_LIST_HEAD(&bridge->windows);
+	pci_init_host_bridge(bridge);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;


