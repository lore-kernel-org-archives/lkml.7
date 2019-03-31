Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31ABC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7138120830
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LzM0K2Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfCaMfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:35:09 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:31847 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035707; x=1585571707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UZvniym4k0zMasC4ZjUS54wGm2H/8Ph+7ayxg+KlP/U=;
  b=LzM0K2KvOx92tXdox50jVdrdZJv5egV3QgbQlXJTYRSJC67SxV0Lyo/5
   TnxaAWwp93UsAC5E6k50IU9VceHhhdB3ac4xaJ1CWLeb1oxchmV43dquj
   /xNh5xb/4gK/5K8neorRfxNPWNG4tcuhmy5M+Ia9ES0PyBBi8MHmhleht
   s=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="791784885"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:35:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCZ0xH106428
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:35:03 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:03 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.69) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:34:53 +0000
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
Subject: [PATCH 1/7] irqchip/alpine-msi: Call IOMMU DMA mapping MSI message hook
Date:   Sun, 31 Mar 2019 15:34:09 +0300
Message-ID: <1554035655-11352-2-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing IOMMU DMA mapping MSI message hook in compose_msi_msg()
callback for Alpine MSIx driver, to map the MSI physical address to
IOMMU IOVA for any device attached to IOMMU DMA ops domains.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
---
 drivers/irqchip/irq-alpine-msi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 23a3b87..ae2fca7 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-iommu.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
 #include <linux/msi.h>
@@ -99,6 +100,12 @@ static void alpine_msix_compose_msi_msg(struct irq_data *data,
 	msg->address_hi = upper_32_bits(msg_addr);
 	msg->address_lo = lower_32_bits(msg_addr);
 	msg->data = 0;
+
+	/*
+	 * Mapping MSI address to IOMMU IOVA, relevant for devices associated
+	 * with IOMMU DMA ops domain.
+	 */
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static struct msi_domain_info alpine_msix_domain_info = {
-- 
2.7.4

