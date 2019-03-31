Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7422C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEB320882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B96YOzA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfCaMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:35:59 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:41078 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035758; x=1585571758;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=q0g7/L6Mk+kz0ZZ51WeqH5kQRFucRKUZKixxtnoztbA=;
  b=B96YOzA5HSZiiWs+1u2Ss4i3/FSPL5YdGJdTTVq/edfdOLaoceRSaXw6
   sm+dyEPr1MLsn/t7Ou0iDqDN5ZxFchZTflLLnN38ZJR0abfQKM5H4Tu6C
   //LCot3Vig+O79vSiPKQP9Q+3DXN9NgWBzekgFjoxM0Cp0HJfATfM6qnv
   E=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="668330398"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:35:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCZrFu111365
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:35:56 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:55 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.164) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:46 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <ronenk@amazon.com>, <dwmw@amazon.co.uk>, <vaerov@amazon.com>,
        <zeev@amazon.com>, <alisaidi@amazon.com>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 5/7] ACPI / irq: Add GSI IRQ domain getter function
Date:   Sun, 31 Mar 2019 15:35:31 +0300
Message-ID: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.164]
X-ClientProxiedBy: EX13D20UWC002.ant.amazon.com (10.43.162.163) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GSI IRQ domain getter function (acpi_get_gsi_domain_id), for IRQ
drivers that use ACPI and need the IRQ parent domain to register their
irq-chip device.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
---
 drivers/acpi/irq.c   | 13 +++++++++++++
 include/linux/acpi.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 7c352cb..efc57b1 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -295,3 +295,16 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 	acpi_irq_model = model;
 	acpi_gsi_domain_id = fwnode;
 }
+
+/**
+ * acpi_get_gsi_domain_id - getter for the GSI irqdomain information
+ *
+ * return:
+ * @fwnode: return the irq_domain identifier for mapping and looking up
+ *          GSI interrupts
+ */
+struct fwnode_handle *acpi_get_gsi_domain_id(void)
+{
+	return acpi_gsi_domain_id;
+}
+EXPORT_SYMBOL_GPL(acpi_get_gsi_domain_id);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f2..642c2e2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -322,6 +322,7 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *fwnode);
+struct fwnode_handle *acpi_get_gsi_domain_id(void);
 
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
-- 
2.7.4

