Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E86C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3DE217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639851;
	bh=ffYAePsAYSLY2PZJ5lNAa7ZiztMb4ESID2IlEHjN8yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4fUran3+5OPc8PJ7AjU9jm8s6ffCNtFSDpKB3ta7ZhqFI57SkO/clMyq3N9ZIfP9
	 LpvQgldNy6jqkg81vnvKqJCXO/Kt+3SPvTn8v3psvDzRSXHRJfUcPEybATrFKRRJzP
	 EZ9f/CGTFBiJX7ddDVTFA2x4L4tAavu3gvf93ZTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbfEWTat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391695AbfEWTap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:30:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A54020879;
        Thu, 23 May 2019 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639844;
        bh=ffYAePsAYSLY2PZJ5lNAa7ZiztMb4ESID2IlEHjN8yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8pL2XpUpwlgUGKurncKehxHjQYf22Rw/PvdZ9Zw17clB7KnPnCmNVpJg4Oodyj/t
         vnbORAJupnygvuA7ku+T6WJFOABYiZ77Ti4QgIlD/7Ih4OTeA65ck8vFamoPYKCXX4
         u0YIAlN3zRepASt/O8Abqd4xyn+iarWA4EXFpBKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.1 097/122] PCI: Init PCIe feature bits for managed host bridge alloc
Date:   Thu, 23 May 2019 21:06:59 +0200
Message-Id: <20190523181718.056998161@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
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
@@ -586,16 +586,9 @@ static void pci_release_host_bridge_dev(
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
@@ -608,6 +601,18 @@ struct pci_host_bridge *pci_alloc_host_b
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
@@ -622,7 +627,7 @@ struct pci_host_bridge *devm_pci_alloc_h
 	if (!bridge)
 		return NULL;
 
-	INIT_LIST_HEAD(&bridge->windows);
+	pci_init_host_bridge(bridge);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;


