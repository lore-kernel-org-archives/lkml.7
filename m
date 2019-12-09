Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578EC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4820692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tVZbsPnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLIQdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:33:21 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44980 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLIQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575909187; x=1607445187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zgQkIGuRvSxFLjIyYi7BTGpgi6pw2e+YCJP0jZaa6K8=;
  b=tVZbsPnAC64eWTtdfR0q/d45/xuTnUCnOKGc9jOytNZNufcNHwqvAbby
   VPD6LAkY1S4LVKSmHcA4MHrslr36HdDBITaYuRFhxalqRmin4RCWu4Lu3
   GAsI5AdFTQnuPpDGcaGF1uh4/RIbJArxQPj6nLNU76/1sX5atAePi4K8d
   E=;
IronPort-SDR: 03SkaqT8v3qcZpz1V7xfKeW9iH/eqfQz5SDEFDn+XBMLJIABfeP4jEzmvRmIpLAPmnHaCulfNI
 VD8CkwcMIzGA==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="12467600"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 09 Dec 2019 16:32:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 4D581A24D0;
        Mon,  9 Dec 2019 16:32:43 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:43 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.171) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:37 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <axboe@kernel.dk>, <hdegoede@redhat.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH 2/2] ata: ahci: Add shutdown handler
Date:   Mon, 9 Dec 2019 16:32:09 +0000
Message-ID: <20191209163209.26284-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209163209.26284-1-hhhawa@amazon.com>
References: <20191209163209.26284-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D34UWA002.ant.amazon.com (10.43.160.245) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue found while doing kexec on Annapurna Labs SoC: an AXI read
error occur due to an access from the interrupt handler of AHCI to the
AHCI controller.
This patch make sure that the interrupts are disabled for the controller
while doing kexec.

The shutdown handler is called during system shutdown to disable host
controller DMA and interrupts in order to avoid potentially corrupting
or otherwise interfering with a new kernel being started with kexec.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/ata/ahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 05c2b32dcc4d..34ddc259343a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -80,6 +80,7 @@ enum board_ids {
 
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void ahci_remove_one(struct pci_dev *dev);
+static void ahci_shutdown(struct pci_dev *dev);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline);
 static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
@@ -593,6 +594,7 @@ static struct pci_driver ahci_pci_driver = {
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
 	.remove			= ahci_remove_one,
+	.shutdown		= ahci_shutdown,
 	.driver = {
 		.pm		= &ahci_pci_pm_ops,
 	},
@@ -1870,6 +1872,13 @@ static void ahci_remove_one(struct pci_dev *pdev)
 	ata_pci_remove_one(pdev);
 }
 
+static void ahci_shutdown(struct pci_dev *pdev)
+{
+	struct ata_host *host = pci_get_drvdata(pdev);
+
+	ahci_common_shutdown(host);
+}
+
 module_pci_driver(ahci_pci_driver);
 
 MODULE_AUTHOR("Jeff Garzik");
-- 
2.17.1

