Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49427C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162382070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gmPJJTJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfCYVbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:31:21 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38652 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfCYVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:31:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 44974A18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IL1SxVn_X9yS for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:31:19 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1439BA42
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:31:19 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id i1so8804435ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVxWXw8Sn3gNzOTimeFumsSWj/9YML5pciPmDNZvpy8=;
        b=gmPJJTJ9rJ4c46xHP9tSZTNViTHacnNY3bPCq9KagN73bEhsZCfQ3qEgjMvff24fxb
         qg6UV7Maxg7NCs3mTsDd1iwPmqTCWKSXJ1QaEULXLJvV8BFydMBUlTY9YXx1U0s5PyVO
         T2R2lMobT96Onp0xbJLnNMxa7l2ZcqnnhgUDbmhOwHNozLNDpL81HKQby0H68GdILPfr
         v93wNIFHLFesR/D3Xrsh7tqQ3efG5s1SkYYCO4ERWkMav4DMJIW1ZTmyMTo+CTU0Uxhv
         gUdE0+D862XOCu1n1jw5KTEP9llMSFq+51rpx4jjrsHxxwRu4czVUCxxIMiWCkQIebhN
         OVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVxWXw8Sn3gNzOTimeFumsSWj/9YML5pciPmDNZvpy8=;
        b=OxGk2lPG72m+BNsqWQgALWvIwhFC5+nLAr/vN/B/ICWgTHbkOX4jHGKKqyRiusCUbp
         SsvagjUoz5ve1sCbw+MyzUHOv6Vy6Cywtq3zA9o2rxpKkEsJSrH4aLtdzSpVeFh2YxAV
         Lgnto0OkArmq/l1ruZ4PC3E34CXPRAbbXf4Wi41JB2psOWZUVz6mbRpLUt7Argi2NDYd
         5a3XkisL/+DcYYs4lOOYA5/g7J1+uF75NvMRB1714evCYsiBU2AqoFzI0RHhnSwLDmuj
         SwmRYyeATXsAWm9zCzATQy6dSekW0Yxh4gSR77pagFSXqBrZdq083avsnzxT7+9hrtaa
         g4GA==
X-Gm-Message-State: APjAAAXEQZaWeGO5jGL84OjFCmjOIDUlwCpTjCqhepApxlwzoMkIvKu8
        QumsBK0ZIPO79yRttnN9ogGghoFI9gEYYWhEo9ekS1q4+VKWsJd0x6zvzSGxGrks8c+Gi04+7lD
        3bAiHeBqTr23ri7Vhd4HBuNowF35i
X-Received: by 2002:a02:1ac3:: with SMTP id 186mr19524375jai.96.1553549478656;
        Mon, 25 Mar 2019 14:31:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcGfD0Zm6chsvdgnkzcyYJasdQOZJzFaZhtJg3gYZfA/WaljxLp1iXvG6s9XLAVIHKRgmDOg==
X-Received: by 2002:a02:1ac3:: with SMTP id 186mr19524353jai.96.1553549478422;
        Mon, 25 Mar 2019 14:31:18 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v133sm660223ita.2.2019.03.25.14.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:31:17 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: pcie-xilinx: fix a missing-check bug for __get_free_pages
Date:   Mon, 25 Mar 2019 16:31:13 -0500
Message-Id: <20190325213113.24705-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d0aa29e9-54c6-bc8b-4827-0562b277265f@arm.com>
References: <d0aa29e9-54c6-bc8b-4827-0562b277265f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case __get_free_pages fail, the fix returns -ENOMEMto avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Steven Price <steven.price@arm.com>
---
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
+	if (unlikely(!port->msi_pages))
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

