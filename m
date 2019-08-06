Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35016C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9D521743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103474;
	bh=9RLjcrbi8qnSPPJUXBk6XpxRmznfeBCiqCSSbZZh/hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpL/5YYU0UELC6HVCSC703vhxNTJ8TCoZwD5VmJkDOf4+scNBeU8jBdOpNW/oJfXS
	 Wwds0g5OgU4P2cIhB8kKF7PHBNeIu6P9brqsmZWyRe0cNfkMgjfPO6EUdEaQTdZ8oE
	 vaIks9Ey2DMBilZYbgSZ6SJkpYLAs9tmkCoQ5IgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbfHFO5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733202AbfHFO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF7E1169E;
        Tue,  6 Aug 2019 07:57:39 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81A093F706;
        Tue,  6 Aug 2019 07:57:38 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] PCI: hv: Allocate a named fwnode instead of an address-based one
Date:   Tue,  6 Aug 2019 15:57:15 +0100
Message-Id: <20190806145716.125421-8-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allocate its fwnode that is then used to allocate an irqdomain,
the driver uses irq_domain_alloc_fwnode(), passing it a VA as an
identifier. This is a rather bad idea, as this address ends up
published in debugfs (and we want to move away from VAs there
anyway).

Instead, let's allocate a named fwnode by using the device GUID as
an identifier. It is allegedly unique, and can be traced back to
the original device.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40b625458afa..f6ed2583167a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2521,6 +2521,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
 	struct hv_pcibus_device *hbus;
+	char *name;
 	int ret;
 
 	/*
@@ -2589,7 +2590,14 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_config;
 	}
 
-	hbus->sysdata.fwnode = irq_domain_alloc_fwnode(hbus);
+	name = kasprintf("%pUL", &hdev->dev_instance);
+	if (!name) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	hbus->sysdata.fwnode = irq_domain_alloc_named_fwnode(name);
+	kfree(name);
 	if (!hbus->sysdata.fwnode) {
 		ret = -ENOMEM;
 		goto unmap;
-- 
2.20.1

