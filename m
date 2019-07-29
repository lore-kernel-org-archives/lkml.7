Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D2B217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428982;
	bh=88T8WQy+9gKqfooyuekwAxRjIY12W/zte00sVRrZulk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOZWM6PcckoZbR2tRfzD0OBGTMsCYqPxKn7TRn3EZ0KG4fFA8d2VK/rtzAIjAPVMM
	 YSHjgXYERaoE3tN2yNh9o/3yxZg9yZxwddMdv7uiDKXkWBnVMgrHVMe+utEFnOeqYy
	 2g8vVMwNEc9Kzx6SjyWxORIzcksk8v36N8+cU/2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfG2TgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388572AbfG2TgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:36:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87512171F;
        Mon, 29 Jul 2019 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428975;
        bh=88T8WQy+9gKqfooyuekwAxRjIY12W/zte00sVRrZulk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuskjZW8kFqmeJ4ABEuTFh6HeBi8dW4yyvCRaX7JwV212nJ3aqRhBMfRzYGs3bJ+J
         3oBxffR4CCkkF/m65srF5gFqG3Vk4q30kJ9PM9+BFIVnS343Kx5z7T1LS9xhsYojjF
         UysPXca4WUhO46+vfA/gMZIHc3gU7hMtGuBRCFSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 228/293] PCI: Return error if cannot probe VF
Date:   Mon, 29 Jul 2019 21:21:59 +0200
Message-Id: <20190729190841.960852238@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 76002d8b48c4b08c9bd414517dd295e132ad910b ]

Commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
VF driver binding") allows the user to specify that drivers for VFs of
a PF should not be probed, but it actually causes pci_device_probe() to
return success back to the driver core in this case.  Therefore by all
sysfs appearances the device is bound to a driver, the driver link from
the device exists as does the device link back from the driver, yet the
driver's probe function is never called on the device.  We also fail to
do any sort of cleanup when we're prohibited from probing the device,
the IRQ setup remains in place and we even hold a device reference.

Instead, abort with errno before any setup or references are taken when
pci_device_can_probe() prevents us from trying to probe the device.

Link: https://lore.kernel.org/lkml/155672991496.20698.4279330795743262888.stgit@gimli.home
Fixes: 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-driver.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ea69b4dbab66..e5a8bf2c9b37 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -415,6 +415,9 @@ static int pci_device_probe(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = to_pci_driver(dev->driver);
 
+	if (!pci_device_can_probe(pci_dev))
+		return -ENODEV;
+
 	pci_assign_irq(pci_dev);
 
 	error = pcibios_alloc_irq(pci_dev);
@@ -422,12 +425,10 @@ static int pci_device_probe(struct device *dev)
 		return error;
 
 	pci_dev_get(pci_dev);
-	if (pci_device_can_probe(pci_dev)) {
-		error = __pci_device_probe(drv, pci_dev);
-		if (error) {
-			pcibios_free_irq(pci_dev);
-			pci_dev_put(pci_dev);
-		}
+	error = __pci_device_probe(drv, pci_dev);
+	if (error) {
+		pcibios_free_irq(pci_dev);
+		pci_dev_put(pci_dev);
 	}
 
 	return error;
-- 
2.20.1



