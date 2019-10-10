Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E72C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEC2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697555;
	bh=6EyxsEqBJ2oOZtJcJw9OqpnSifZ1fmKpzk8Q4zKakk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ac89aXgLxJuiihCYbAd9odcFvsiUNmEBJcD1BvSRWVi3Wjff3eUV8bfxRDlJR0V5
	 CBjt7iwfqMDYbJL3thN2x1XvpIRP8PL24wcsXaWI1lgr6QUdswl7imHxovT8I+XzII
	 Zd5g3JOMaPPzbGtWw19OinQam6Ve/akFT2L2MhH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbfJJIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390261AbfJJIw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:52:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B28521A4C;
        Thu, 10 Oct 2019 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697547;
        bh=6EyxsEqBJ2oOZtJcJw9OqpnSifZ1fmKpzk8Q4zKakk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WE5auOpJ48YU3IBTQmY79PeedEhOpnTGDosifgdGH3mwk5eykUjFDPYBAr0f20emc
         cbyBZTzomrx/u3/dA5XQW1rCw1r3acdCnQCH2cOOEDnbtHAZ0PMzUupMqQmvKUIfpP
         GjenVEB5F5fVdEBPUKmDOmxbDNg+t2+8oGU708FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/61] xen/pci: reserve MCFG areas earlier
Date:   Thu, 10 Oct 2019 10:36:56 +0200
Message-Id: <20191010083508.961319238@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>

[ Upstream commit a4098bc6eed5e31e0391bcc068e61804c98138df ]

If MCFG area is not reserved in E820, Xen by default will defer its usage
until Dom0 registers it explicitly after ACPI parser recognizes it as
a reserved resource in DSDT. Having it reserved in E820 is not
mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
and firmware is free to keep a hole in E820 in that place. Xen doesn't know
what exactly is inside this hole since it lacks full ACPI view of the
platform therefore it's potentially harmful to access MCFG region
without additional checks as some machines are known to provide
inconsistent information on the size of the region.

Now xen_mcfg_late() runs after acpi_init() which is too late as some basic
PCI enumeration starts exactly there as well. Trying to register a device
prior to MCFG reservation causes multiple problems with PCIe extended
capability initializations in Xen (e.g. SR-IOV VF BAR sizing). There are
no convenient hooks for us to subscribe to so register MCFG areas earlier
upon the first invocation of xen_add_device(). It should be safe to do once
since all the boot time buses must have their MCFG areas in MCFG table
already and we don't support PCI bus hot-plug.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pci.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 7494dbeb4409c..db58aaa4dc598 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -29,6 +29,8 @@
 #include "../pci/pci.h"
 #ifdef CONFIG_PCI_MMCONFIG
 #include <asm/pci_x86.h>
+
+static int xen_mcfg_late(void);
 #endif
 
 static bool __read_mostly pci_seg_supported = true;
@@ -40,7 +42,18 @@ static int xen_add_device(struct device *dev)
 #ifdef CONFIG_PCI_IOV
 	struct pci_dev *physfn = pci_dev->physfn;
 #endif
-
+#ifdef CONFIG_PCI_MMCONFIG
+	static bool pci_mcfg_reserved = false;
+	/*
+	 * Reserve MCFG areas in Xen on first invocation due to this being
+	 * potentially called from inside of acpi_init immediately after
+	 * MCFG table has been finally parsed.
+	 */
+	if (!pci_mcfg_reserved) {
+		xen_mcfg_late();
+		pci_mcfg_reserved = true;
+	}
+#endif
 	if (pci_seg_supported) {
 		struct {
 			struct physdev_pci_device_add add;
@@ -213,7 +226,7 @@ static int __init register_xen_pci_notifier(void)
 arch_initcall(register_xen_pci_notifier);
 
 #ifdef CONFIG_PCI_MMCONFIG
-static int __init xen_mcfg_late(void)
+static int xen_mcfg_late(void)
 {
 	struct pci_mmcfg_region *cfg;
 	int rc;
@@ -252,8 +265,4 @@ static int __init xen_mcfg_late(void)
 	}
 	return 0;
 }
-/*
- * Needs to be done after acpi_init which are subsys_initcall.
- */
-subsys_initcall_sync(xen_mcfg_late);
 #endif
-- 
2.20.1



