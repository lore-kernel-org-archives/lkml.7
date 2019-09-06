Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E2FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3456B2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393178AbfIFLIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392425AbfIFLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6T-0007AZ-8M; Fri, 06 Sep 2019 13:08:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A0FD21C0E2D;
        Fri,  6 Sep 2019 13:08:17 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:17 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI: hv: Allocate a named fwnode instead of an
 address-based one
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809761.24167.3177451802491888333.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     467a3bb974320a23c0c000559cc54b64e06e9787
Gitweb:        https://git.kernel.org/tip/467a3bb974320a23c0c000559cc54b64e06e9787
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Aug 2019 15:23:33 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Aug 2019 14:24:49 +01:00

PCI: hv: Allocate a named fwnode instead of an address-based one

To allocate its fwnode that is then used to allocate an irqdomain,
the driver uses irq_domain_alloc_fwnode(), passing it a VA as an
identifier. This is a rather bad idea, as this address ends up
published in debugfs (and we want to move away from VAs there
anyway).

Instead, let's allocate a named fwnode by using the device GUID as
an identifier. It is allegedly unique, and can be traced back to
the original device.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40b6254..97056f3 100644
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
+	name = kasprintf(GFP_KERNEL, "%pUL", &hdev->dev_instance);
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
