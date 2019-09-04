Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70921883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 00:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="aw8yoN93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfIDA1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 20:27:43 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:54464 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfIDA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 20:27:43 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 20:27:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1567556862;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=REnkVIGmDtY7lvGG2M1j0JFI4QkmkQIKYK2dQ3BcqE0=;
  b=aw8yoN9380ezXYR6GcSTWVpIt0iGpSKk9+/pu4pnzshv1lpBQBxzV3m/
   00/lSX2jnaU2S4wOGr5Ju1XLMVgd7QFYdv5JdUwIk3BNCIN6a5Vk9F+7j
   Al9rDliHIQUkouu75JDjuhxBtQ3i7d5bc9GstnmLvB9TpweYyCaEPtQVV
   0=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: ihSSbqvcBHI79WN++CxzfilhADPpkPgRdVrUvsODTRGNlVu/v8KiA/qtX5WBIuXu1jFbgT2T2/
 QuuqyfAMPLTt6WApOiA+yLeqvnRRV2g6wFdGB7Mee6A1OMk31Cwzm5hPaIdr9Mv3U0mOwdr75Q
 OlEFTUgwkSh6O0ZVXRIhzTa0y7KIxJZcjMp4ozQPlmkYHBfGvjr+ZiShLVBIV5+K1VXyvMYfXP
 zlzwRzURUY3WIyIMoMNx6BaOBXRwRz1OYDLSmlzXBHhZh2XGyTG1U6LyT0zyK+brgZz5NbeqLN
 5z0=
X-SBRS: 2.7
X-MesageID: 5277025
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,465,1559534400"; 
   d="scan'208";a="5277025"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>, <boris.ostrovsky@oracle.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: [PATCH] xen/pci: try to reserve MCFG areas earlier
Date:   Wed, 4 Sep 2019 01:20:31 +0100
Message-ID: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If MCFG area is not reserved in E820, Xen by default will defer its usage
until Dom0 registers it explicitly after ACPI parser recognizes it as
a reserved resource in DSDT. Having it reserved in E820 is not
mandatory according to "PCI Firmware Specification, rev 3.2" (par. 4.1.2)
and firmware is free to keep a hole E820 in that place. Xen doesn't know
what exactly is inside this hole since it lacks full ACPI view of the
platform therefore it's potentially harmful to access MCFG region
without additional checks as some machines are known to provide
inconsistent information on the size of the region.

Now xen_mcfg_late() runs after acpi_init() which is too late as some basic
PCI enumeration starts exactly there. Trying to register a device prior
to MCFG reservation causes multiple problems with PCIe extended
capability initializations in Xen (e.g. SR-IOV VF BAR sizing). There are
no convenient hooks for us to subscribe to so try to register MCFG
areas earlier upon the first invocation of xen_add_device(). Keep the
existing initcall in case information of MCFG areas is updated later
in acpi_init().

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 drivers/xen/pci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 7494dbe..800f415 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -29,6 +29,9 @@
 #include "../pci/pci.h"
 #ifdef CONFIG_PCI_MMCONFIG
 #include <asm/pci_x86.h>
+
+static int xen_mcfg_late(void);
+static bool __read_mostly pci_mcfg_reserved = false;
 #endif
 
 static bool __read_mostly pci_seg_supported = true;
@@ -41,6 +44,16 @@ static int xen_add_device(struct device *dev)
 	struct pci_dev *physfn = pci_dev->physfn;
 #endif
 
+#ifdef CONFIG_PCI_MMCONFIG
+	/*
+	 * Try to reserve MCFG areas discovered so far early on first invocation
+	 * due to this being potentially called from inside of acpi_init
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
-- 
2.7.4

