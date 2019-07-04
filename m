Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D1C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014EF218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXhpG/pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfGDPgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:36:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34746 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfGDPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:36:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so5857825qkt.1;
        Thu, 04 Jul 2019 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpJC9kCa+OkhQnsrIzucYVXRwKjdr868qAn0ryhvY+U=;
        b=vXhpG/pj/uK99DQkain0mvVrKftdDNxlJ+l43JOIg2V01P+eix4jz5OdbKNaCb4eRG
         hGeU/tRjsK4iUq3nAA3mVvLArQ87pw4akTTUCLh6XLsJL747BMkNV5scUKLHpbbJ9Sp/
         9+bhEkVkWOlUa+l40QXNkdPbAT5IahNFUnb4GSWEThIO/rVaLibBKcVBI40nHyyN2IyI
         ENTicZJMA8FgZHN98S0YsGqF+dHNGdA2vfkMFekw995+ptlNyvC6lkVXU7aoZbq2B4qv
         E2RO4uoNgk1IO+Pj1zr4vi0jcr+F6jXu8oNHSCFaunybs67LQErn5B5PSVZFLbYf41vq
         WO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpJC9kCa+OkhQnsrIzucYVXRwKjdr868qAn0ryhvY+U=;
        b=NRpcIWhLDJuHS3udD1jQWIEsM6g1fcAC8V7eufBB/B7XGCbxwUpVKs+sQ/Kw4C0+XC
         m1VhJjeDBk+zqiB4p0NPwLbyNWVDMqA2KVKAxjs+nUUIZWNQS+quEdzJpF1PB3mnYEFU
         jB0D9H6dCdl9h+O3H5pZjeAbX4NS+KLNghEozS2lWxSoRWy9o745wWblCEGXLgx3Rdxp
         /lGCDe06wN0EUYkB5osc3dngXH0rW9VfbV5Zp4VYmQGrmBy3tHWgjNF9okeOuKq5Fzmg
         CMpy4GVqEMRkBqamT/ppNhVJqBRy9mlctmOSCqBgTem7KgnIfhbiyJ/dXb7lHP5OZZVk
         ghcw==
X-Gm-Message-State: APjAAAXeyddEH5d/vKP+BLiW4sPDyjoWrk0xPnPNqjE06cN7f/Zaxt8q
        LSrhbkNVeXCVmafJcloRxPE=
X-Google-Smtp-Source: APXvYqzzdfOB+G5FOyvCwr+ySJYOZG8pxOXRwAT5aXnhsvpc5lgeYSaHaZJn0kqXBsl3zQ7qTuVlJg==
X-Received: by 2002:a37:48c7:: with SMTP id v190mr36312204qka.350.1562254574244;
        Thu, 04 Jul 2019 08:36:14 -0700 (PDT)
Received: from localhost.localdomain (pool-72-93-241-64.bstnma.fios.verizon.net. [72.93.241.64])
        by smtp.gmail.com with ESMTPSA id 67sm2087140qkh.108.2019.07.04.08.36.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 08:36:13 -0700 (PDT)
From:   Ryan Kennedy <ryan5544@gmail.com>
To:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Kennedy <ryan5544@gmail.com>
Subject: [PATCH 2/2] usb: pci-quirks: Minor cleanup for AMD PLL quirk
Date:   Thu,  4 Jul 2019 11:35:29 -0400
Message-Id: <20190704153529.9429-3-ryan5544@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704153529.9429-1-ryan5544@gmail.com>
References: <20190704153529.9429-1-ryan5544@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_amd_find_chipset_info() is used for chipset detection for
several quirks. It is strange that its return value indicates
the need for the PLL quirk, which means it is often ignored.
This patch adds a function specifically for checking the PLL
quirk like the other ones. Additionally, rename probe_result to
something more appropriate.

Signed-off-by: Ryan Kennedy <ryan5544@gmail.com>
---
 drivers/usb/host/ehci-pci.c   |  4 ++--
 drivers/usb/host/ohci-pci.c   |  2 +-
 drivers/usb/host/pci-quirks.c | 30 ++++++++++++++++--------------
 drivers/usb/host/pci-quirks.h |  2 +-
 drivers/usb/host/xhci-pci.c   |  2 +-
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index fe9422d3bcdc..b0882c13a1d1 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -149,7 +149,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 		break;
 	case PCI_VENDOR_ID_AMD:
 		/* AMD PLL quirk */
-		if (usb_amd_find_chipset_info())
+		if (usb_amd_quirk_pll_check())
 			ehci->amd_pll_fix = 1;
 		/* AMD8111 EHCI doesn't work, according to AMD errata */
 		if (pdev->device == 0x7463) {
@@ -186,7 +186,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 		break;
 	case PCI_VENDOR_ID_ATI:
 		/* AMD PLL quirk */
-		if (usb_amd_find_chipset_info())
+		if (usb_amd_quirk_pll_check())
 			ehci->amd_pll_fix = 1;
 
 		/*
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index fbcd34911025..208abaaef8f6 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -152,7 +152,7 @@ static int ohci_quirk_amd700(struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 
-	if (usb_amd_find_chipset_info())
+	if (usb_amd_quirk_pll_check())
 		ohci->flags |= OHCI_QUIRK_AMD_PLL;
 
 	/* SB800 needs pre-fetch fix */
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index ad05c27b3a7b..f6d04491df60 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -132,7 +132,7 @@ static struct amd_chipset_info {
 	struct amd_chipset_type sb_type;
 	int isoc_reqs;
 	int probe_count;
-	int probe_result;
+	bool need_pll_quirk;
 } amd_chipset;
 
 static DEFINE_SPINLOCK(amd_lock);
@@ -201,11 +201,11 @@ void sb800_prefetch(struct device *dev, int on)
 }
 EXPORT_SYMBOL_GPL(sb800_prefetch);
 
-int usb_amd_find_chipset_info(void)
+static void usb_amd_find_chipset_info(void)
 {
 	unsigned long flags;
 	struct amd_chipset_info info;
-	int need_pll_quirk = 0;
+	info.need_pll_quirk = 0;
 
 	spin_lock_irqsave(&amd_lock, flags);
 
@@ -213,7 +213,7 @@ int usb_amd_find_chipset_info(void)
 	if (amd_chipset.probe_count > 0) {
 		amd_chipset.probe_count++;
 		spin_unlock_irqrestore(&amd_lock, flags);
-		return amd_chipset.probe_result;
+		return;
 	}
 	memset(&info, 0, sizeof(info));
 	spin_unlock_irqrestore(&amd_lock, flags);
@@ -224,19 +224,19 @@ int usb_amd_find_chipset_info(void)
 
 	switch (info.sb_type.gen) {
 	case AMD_CHIPSET_SB700:
-		need_pll_quirk = info.sb_type.rev <= 0x3B;
+		info.need_pll_quirk = info.sb_type.rev <= 0x3B;
 		break;
 	case AMD_CHIPSET_SB800:
 	case AMD_CHIPSET_HUDSON2:
 	case AMD_CHIPSET_BOLTON:
-		need_pll_quirk = 1;
+		info.need_pll_quirk = 1;
 		break;
 	default:
-		need_pll_quirk = 0;
+		info.need_pll_quirk = 0;
 		break;
 	}
 
-	if (!need_pll_quirk) {
+	if (!info.need_pll_quirk) {
 		if (info.smbus_dev) {
 			pci_dev_put(info.smbus_dev);
 			info.smbus_dev = NULL;
@@ -259,7 +259,6 @@ int usb_amd_find_chipset_info(void)
 		}
 	}
 
-	need_pll_quirk = info.probe_result = 1;
 	printk(KERN_DEBUG "QUIRK: Enable AMD PLL fix\n");
 
 commit:
@@ -270,7 +269,6 @@ int usb_amd_find_chipset_info(void)
 
 		/* Mark that we where here */
 		amd_chipset.probe_count++;
-		need_pll_quirk = amd_chipset.probe_result;
 
 		spin_unlock_irqrestore(&amd_lock, flags);
 
@@ -283,10 +281,7 @@ int usb_amd_find_chipset_info(void)
 		amd_chipset = info;
 		spin_unlock_irqrestore(&amd_lock, flags);
 	}
-
-	return need_pll_quirk;
 }
-EXPORT_SYMBOL_GPL(usb_amd_find_chipset_info);
 
 int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev)
 {
@@ -322,6 +317,13 @@ bool usb_amd_prefetch_quirk(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
 
+bool usb_amd_quirk_pll_check(void)
+{
+	usb_amd_find_chipset_info();
+	return amd_chipset.need_pll_quirk;
+}
+EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_check);
+
 /*
  * The hardware normally enables the A-link power management feature, which
  * lets the system lower the power consumption in idle states.
@@ -527,7 +529,7 @@ void usb_amd_dev_put(void)
 	amd_chipset.nb_type = 0;
 	memset(&amd_chipset.sb_type, 0, sizeof(amd_chipset.sb_type));
 	amd_chipset.isoc_reqs = 0;
-	amd_chipset.probe_result = 0;
+	amd_chipset.need_pll_quirk = 0;
 
 	spin_unlock_irqrestore(&amd_lock, flags);
 
diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
index 63c633077d9e..e729de21fad7 100644
--- a/drivers/usb/host/pci-quirks.h
+++ b/drivers/usb/host/pci-quirks.h
@@ -5,11 +5,11 @@
 #ifdef CONFIG_USB_PCI
 void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
 int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
-int usb_amd_find_chipset_info(void);
 int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
 bool usb_amd_hang_symptom_quirk(void);
 bool usb_amd_prefetch_quirk(void);
 void usb_amd_dev_put(void);
+bool usb_amd_quirk_pll_check(void);
 void usb_amd_quirk_pll_disable(void);
 void usb_amd_quirk_pll_enable(void);
 void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c2fe218e051f..1e0236e90687 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -130,7 +130,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_AMD_0x96_HOST;
 
 	/* AMD PLL quirk */
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_quirk_pll_check())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-- 
2.21.0

