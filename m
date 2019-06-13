Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3853C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442366;
	bh=uclTob9GQIPP+edHPJZx/gJnRps5nzkGS7uvws+ioa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vL2fi0Rt6X86cucN4Q9Km1UjBJgHzD4PW4u6Pch0B/WrZGLPoGTKbbMVC/5e//vbC
	 Lye0NS4dOEHmLrGto3Z4l4Lk799mtYOjpU6eF19wXAdwhB6MeX5iuYj1bFL8pJeMxR
	 1GMbCb5JxzH9C3q/LGmM16KPUTnNwrnA79mmA9Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391685AbfFMQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbfFMInF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:43:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CDB2063F;
        Thu, 13 Jun 2019 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415384;
        bh=uclTob9GQIPP+edHPJZx/gJnRps5nzkGS7uvws+ioa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAf1hfEGzqwPQ8tFYmxHs4WqxEZJPZbv+7f/vIvH/Em0922koj9SvxMDO39Od+GdH
         yfccolNKoEWFit7yV497O7D9l/iEA2ZholZNRsy7T3GtCznYqKHxUGuQ+NVaioyP0m
         g5/xCYmeuRtigy4Y6XPm3Ap1SZkhNdtuJ7UddFfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/118] PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
Date:   Thu, 13 Jun 2019 10:33:34 +0200
Message-Id: <20190613075648.289807017@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f316a2b53cd7f37963ae20ec7072eb27a349a4ce ]

hook_fault_code() is an ARM32 specific API for hooking into data abort.

AM65X platforms (that integrate ARM v8 cores and select CONFIG_ARM64 as
arch) rely on pci-keystone.c but on them the enumeration of a
non-present BDF does not trigger a bus error, so the fixup exception
provided by calling hook_fault_code() is not needed and can be guarded
with CONFIG_ARM.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e88bd221fffe..5e199e7d2d4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -237,6 +237,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 		ks_dw_pcie_enable_error_irq(ks_pcie);
 }
 
+#ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -256,6 +257,7 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
@@ -279,12 +281,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	val |= BIT(12);
 	writel(val, pci->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
 
+#ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
 	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+#endif
 
 	return 0;
 }
-- 
2.20.1



