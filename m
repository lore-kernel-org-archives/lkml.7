Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A4220811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ri/IWHh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfCYWTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:19:17 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54278 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:19:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id BD1D9957
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d30YLgNi5o0u for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 17:19:15 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 85B3392B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:19:15 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id r136so9820347ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wMN6xXX31A6AdzQAJGc2vG9ofT3CoZG7Cbz+jNnp6f8=;
        b=Ri/IWHh+UZOTC7ZjY4+AHxTHHeE03LtftP/f73T6u1Ndc5c/G84oyC5h/XcypurBr/
         m3txydiTyFZKrl9mX6le7RxJygALM1cd+VCRmv553UxKXOPiLu8qlHsLW6VQ/2GnfwF2
         KrkNM+srVDJNlpryuymtMSzPYP3kgwtrXzmHqu+RxPVPspOm7GeAEu+Skr9X5YXgKZLU
         DJta+7ZXNvdYf8U5t4Oiqvrw8GBrbsWn5ZWkM8THTE7wJvHxzX/TSidF6fYMEWa+5fR6
         3zU+Kjn1+zbCNW3i7102e1rCdCkh0VJ4XapJQ7aqKBYlZPptSpcitFAsgaXnscRksF0Q
         Sezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wMN6xXX31A6AdzQAJGc2vG9ofT3CoZG7Cbz+jNnp6f8=;
        b=RjNjnvCj/WcGkhROen18BU58UWwzTWFL5IvfcM9MPx+GhtoNrudCU4vp0IvSAHJ/BW
         Skt5xZYtPmI0clYbFCIzn+s/Crbjk2OoZPKDd5HxxG5eoFxXFJbx55yAExI0wkEGuIeI
         eYLZoKtraVj6L9Qw9kCPS2pblQJ1MjFOWws8CDHO3CiWTYCGrWhiX4M5EA+xiVuZlsPr
         hURTsIwUYRKpiVtpmalLdSU+WHLFcWWQWVM6rckVgt59Zi2etImb9CZ3xGSZ5pravpRj
         Z8U+L1T6RAu+HYR8i7vv/zVgHCWdPRsA0irqWbSmZQWeYFkwQwMx50h0ebb22KhutMfe
         SNbA==
X-Gm-Message-State: APjAAAUZf/LP/wXIb3PhUNMYextM5m9kUpE6S7ohhVjpsUGQRRF74+mY
        pAkZU3UmvS33iFMzGfg7r++f9goVxSADuxFYNhH1WlDVGi1OE4xh6SfMJjyohlmtlS5DAa379Il
        9OAwI6tUX69dDoY2pqYix4F2F8h82
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr16967273ioc.142.1553552355183;
        Mon, 25 Mar 2019 15:19:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJpikc1k86UuAZEIpBOenvhqms6j6+SUAXP6kJ8lTR9Ao9sezT7dyXG/DCDzkMGqenPZaMnw==
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr16967256ioc.142.1553552354910;
        Mon, 25 Mar 2019 15:19:14 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k4sm10043741itc.32.2019.03.25.15.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:19:14 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: xilinx: Check for __get_free_pages() failure
Date:   Mon, 25 Mar 2019 17:19:09 -0500
Message-Id: <20190325221909.26315-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325215105.GB24180@google.com>
References: <20190325215105.GB24180@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __get_free_pages() fails, the patch returns -ENOMEM to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
v3: remove "unlikely", as suggested by Bjorn Helgaas.
v2: caller is redefined to accept the error code, as suggested by
Steven Price <steven.price@arm.com>
---
 drivers/pci/controller/pcie-xilinx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 9bd1a35cd5d8..abc214e94f7c 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -336,14 +336,19 @@ static const struct irq_domain_ops msi_domain_ops = {
  * xilinx_pcie_enable_msi - Enable MSI support
  * @port: PCIe port information
  */
-static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
+static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 {
 	phys_addr_t msg_addr;
 
 	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!port->msi_pages)
+		return -ENOMEM;
+
 	msg_addr = virt_to_phys((void *)port->msi_pages);
 	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+
+	return 0;
 }
 
 /* INTx Functions */
@@ -498,6 +503,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
+	int ret;
 
 	/* Setup INTx */
 	pcie_intc_node = of_get_next_child(node, NULL);
@@ -526,7 +532,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 			return -ENODEV;
 		}
 
-		xilinx_pcie_enable_msi(port);
+		ret = xilinx_pcie_enable_msi(port);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.1

