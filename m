Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C68C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C363520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441548;
	bh=0w0J78bo621MnLl11JLDo21gEOwqJPVkpR5a3wuPRJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bENhgrHAAMGFV4G22e43GQ05VNVLWMPcS9RlrzgT3JK6R+f1L6KNoJSANnR3u18Q3
	 WHmlsrT8jcFlhgTdKTLxydHYneHpkzm790tBdO/2xP1iCsapbFovSCBKcbU/IzJX5C
	 cl7k7yWf8QDR974vhvCGy4tOnTa6cigix+LjHvL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbfFMP7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfFMItu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:49:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B29206BA;
        Thu, 13 Jun 2019 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415789;
        bh=0w0J78bo621MnLl11JLDo21gEOwqJPVkpR5a3wuPRJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eV32WQ/X8NWaqIFYnyBJcVrJIyBAuNa5XEe+jS+5t7vpb2VkMxVwqkRu4Ytb2P1ra
         I3L46WWLeL9EmnqcHG7X9yi55XFxlTAtxsDbrCakPH8dTnkPFXgiTZ7JIpIanAsQvh
         1mhiEVNB879gG0GrpBeTixX7d70bJfoetN4wIa9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 098/155] PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
Date:   Thu, 13 Jun 2019 10:33:30 +0200
Message-Id: <20190613075658.541457857@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
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
index 94bd31b255a4..ba6907af9dcb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -705,6 +705,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 		ks_pcie_enable_error_irq(ks_pcie);
 }
 
+#ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -724,6 +725,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
@@ -766,12 +768,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	if (ret < 0)
 		return ret;
 
+#ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+#endif
 
 	return 0;
 }
-- 
2.20.1



