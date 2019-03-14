Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A82C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7474B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Wc46MVTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCNF67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:58:59 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38692 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNF67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:58:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id B0EFFA2C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W3Wqtlncn7Ia for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 00:58:57 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 7F64757A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:58:57 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id v12so3693454itv.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SvUQKGDIhYdSlut3wvJ7Ur1Pv1VSspxRjzKmTkLbVH0=;
        b=Wc46MVTMUeWCjqeD1bwQrvoVQ+iQflpk3FE/nhef3V+W4DAy8XblvrcTAZTGc/+s2N
         wNwe8RssZP+fbSN4nDBKvsUH+duSJgj3u3nnF8XRW28Zwt062Zh742LkZTKQs7H+yD/q
         F4NjXsDMnge4hs0wF5toePIr2Rfszy/dhN3DtQZBtVNBaa+plCV69MrfaSrKDBtgBxYA
         bXyFk8q+AoI5QRqwk5UNuC2yPUHgO3nPf6HU0UvaKNAW64phnqLTlnzoPrpDfLkTfb5p
         Nu66dIonrj6o+LEjd02GlZIY/j7FJq1fRYynr8rv405BDwizI20hQ8P2qblrcKdhz4o6
         Gk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SvUQKGDIhYdSlut3wvJ7Ur1Pv1VSspxRjzKmTkLbVH0=;
        b=FiVRnjX4FfMooxc7gmKgFahUd8TvHRbXkmZykv9tLT1zsakMb6addf1tITg800RBvj
         JkdWJ6ZxypBP6jkSED4Bfmo0DlXp+kaEu8nVHuiP20jI7leVi04p3CcnK4huPRqhbBG2
         0ng7EwQkXczOzNsO5SF7wmlfTR5KmqHM1gSeEFII1yVahCzJ6+5J/0ASYDJJoDDofrqd
         mwZkH9xqhb//1CnHaDYaION6KSqq4G31kqAHEGVZnWKTJrWAXGvCtQdtAiGKawWRfV3M
         EjggC5XeGkMfttDYe8Aiiv/mrIaz0ZUFWMjtYMCNjjNRacYvZ1r2hVgF9znnBta84ukl
         PCiQ==
X-Gm-Message-State: APjAAAVHsfJvh8KAoSeCrQmzK77h0SPoW1uUkNFcYYqHBuTfTG4IwHM6
        jSSNZ3Kf5um7uPj6fgt7ztg4n6FHygkuBHUMdC2uUPMjcvBLny6qDqtu6Ku2j7/lJDyDCKkliVL
        NA+Ls+eIwc1lMrHobzg0BVgAmG/7I
X-Received: by 2002:a24:5407:: with SMTP id t7mr1129654ita.128.1552543137156;
        Wed, 13 Mar 2019 22:58:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaU9bzz2EpnQcxcXTWVnK19DaawKPbD94d82adMrlaZ8GpwI9zcoRFkFU/5yNtHwJb8AlOxw==
X-Received: by 2002:a24:5407:: with SMTP id t7mr1129646ita.128.1552543136955;
        Wed, 13 Mar 2019 22:58:56 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id w8sm682394ita.21.2019.03.13.22.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:58:56 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: pcie-xilinx: fix a missing-check bug for __get_free_pages
Date:   Thu, 14 Mar 2019 00:58:51 -0500
Message-Id: <20190314055851.6884-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case __get_free_pages fail, the fix returns to avoid NULL
pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/pcie-xilinx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 9bd1a35cd5d8..b7083e995c45 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -341,6 +341,9 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 	phys_addr_t msg_addr;
 
 	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
+	if (unlikely(!port->msi_pages))
+		return;
+
 	msg_addr = virt_to_phys((void *)port->msi_pages);
 	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
-- 
2.17.1

