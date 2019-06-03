Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46733217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfFCPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:23 -0400
Received: from foss.arm.com ([217.140.101.70]:54098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbfFCPwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D68A1AED;
        Mon,  3 Jun 2019 08:52:21 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623E43F246;
        Mon,  3 Jun 2019 08:52:20 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 54/57] drivers: pci: Use bus_find_next_device() helper
Date:   Mon,  3 Jun 2019 16:50:20 +0100
Message-Id: <1559577023-558-55-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse the generic helper to find the next device on bus.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/pci/probe.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f9ef7ad..3504695 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -64,11 +64,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	return &r->res;
 }
 
-static int find_anything(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 /*
  * Some device drivers need know if PCI is initiated.
  * Basically, we think PCI is not initiated when there
@@ -79,7 +74,7 @@ int no_pci_devices(void)
 	struct device *dev;
 	int no_devices;
 
-	dev = bus_find_device(&pci_bus_type, NULL, NULL, find_anything);
+	dev = bus_find_next_device(&pci_bus_type, NULL);
 	no_devices = (dev == NULL);
 	put_device(dev);
 	return no_devices;
-- 
2.7.4

