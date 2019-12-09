Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C4120692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g3T/MDzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLIQdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:33:31 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:40277 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575909208; x=1607445208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=t29Bus9xPFaseU1gY2l8PQOiWeI07rdLZFKW3LNWWP8=;
  b=g3T/MDzdOSxTojst7Xiolx4/nbG0JpSg4hR7t+wfRNgk8f0pznn5AX+S
   l2ZW1phuAaZWYa6T7/d19YtSlD8GUrY0yGCuHt7jtT+2XNIOObdY2Gn5Q
   R59Xf75hegYurF8dyyYRzbFwWeKd3KzEgH0+5qrLwljVkxpSmdhqlwqs8
   k=;
IronPort-SDR: DNeif+ZFispR/AFWaUdEweL93WIbFYTuhbrUa81zcLuI2C7A/vInPhcE28Z7jlgOluV3mzlHSp
 tOyDPc10h1uQ==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="4058952"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Dec 2019 16:32:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 11DA2A2355;
        Mon,  9 Dec 2019 16:32:38 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:38 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.171) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:32 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <axboe@kernel.dk>, <hdegoede@redhat.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH 1/2] ata: libahci: move ahci platform shutdown function to libahci
Date:   Mon, 9 Dec 2019 16:32:08 +0000
Message-ID: <20191209163209.26284-2-hhhawa@amazon.com>
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

Move ahci platform shutdown function to libahci as preparation to add
shutdown handler for PCIe AHCI.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci.c          | 33 +++++++++++++++++++++++++++++++++
 drivers/ata/libahci_platform.c | 20 +-------------------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 3dbf398c92ea..df84dfdf9037 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -418,6 +418,7 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
+void ahci_common_shutdown(struct ata_host *host);
 void ahci_error_handler(struct ata_port *ap);
 u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index bff369d9a1a7..f5dd5d66c442 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2602,6 +2602,39 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
 
+/**
+ * ahci_common_shutdown - Disable interrupts and stop DMA for host ports
+ * @host: target ATA host
+ *
+ * This common function is called during system shutdown and performs the
+ * minimal deconfiguration required to ensure that an ahci host cannot corrupt
+ * or otherwise interfere with a new kernel being started with kexec.
+ */
+void ahci_common_shutdown(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	int i;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		/* Disable port interrupts */
+		if (ap->ops->freeze)
+			ap->ops->freeze(ap);
+
+		/* Stop the port DMA engines */
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+	}
+
+	/* Disable and clear host interrupts */
+	writel(readl(mmio + HOST_CTL) & ~HOST_IRQ_EN, mmio + HOST_CTL);
+	readl(mmio + HOST_CTL); /* flush */
+	writel(GENMASK(host->n_ports, 0), mmio + HOST_IRQ_STAT);
+}
+EXPORT_SYMBOL_GPL(ahci_common_shutdown);
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Common AHCI SATA low-level routines");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 8befce036af8..dd2bfa3986f8 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -680,26 +680,8 @@ static void ahci_host_stop(struct ata_host *host)
 void ahci_platform_shutdown(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
-	struct ahci_host_priv *hpriv = host->private_data;
-	void __iomem *mmio = hpriv->mmio;
-	int i;
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap = host->ports[i];
-
-		/* Disable port interrupts */
-		if (ap->ops->freeze)
-			ap->ops->freeze(ap);
 
-		/* Stop the port DMA engines */
-		if (ap->ops->port_stop)
-			ap->ops->port_stop(ap);
-	}
-
-	/* Disable and clear host interrupts */
-	writel(readl(mmio + HOST_CTL) & ~HOST_IRQ_EN, mmio + HOST_CTL);
-	readl(mmio + HOST_CTL); /* flush */
-	writel(GENMASK(host->n_ports, 0), mmio + HOST_IRQ_STAT);
+	ahci_common_shutdown(host);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_shutdown);
 
-- 
2.17.1

