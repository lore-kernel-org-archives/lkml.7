Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34318C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F325D223A7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pH4l246J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfDPOCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:02:01 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:47830 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDPOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:02:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 91AF3C2E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Er-uHCAYC37z for <linux-kernel@vger.kernel.org>;
        Tue, 16 Apr 2019 09:01:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 67486A99
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:01:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id y18so16621034ior.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iwjMijP3+qu6tm9Ocaym7EnWSSoP8/7s8H9M+zp/o04=;
        b=pH4l246JQa7gqqHTnkvh/2qqqxnoKjbpdrSf7IcXCYV5RfBTK2/o/oB32m/e7Mhamb
         RKzevpkRs+mKB11gq4VNFtfQNiteam507U6Q3vYPveE0301V5O4w79/fAWaXtEODsMcO
         5G3s1FFyhWFoB9jz5w0iRBuGdL0JRT1kWxT4J8Tou53UmCR48Yj3bIjepRbmd6BuH0J6
         QChDp0cYmzKyXeBOXk2magzcfnXeJIssCtUVgcMouF3iNUQgfqgTOM/bdg+uVqrkpUAy
         dM3avtUc2iOWAhO2gm7nvmvmak+LG7gKt20kGd5qjxDynZsDorvoXg57dFzSNh8A4o2T
         nyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iwjMijP3+qu6tm9Ocaym7EnWSSoP8/7s8H9M+zp/o04=;
        b=n2SYKVxRXP8jVpZryaKz68Ss2D9Otp1ievD3eWsTFqJC/4H5R5kMGd7wSVVPiD+d5q
         e46rl/dH3lZ4cWDwx75KKkvZJpCLcQLlDPt+o4tWXGocOLRK+dA7boWDjeHFdCz6Fso5
         WrcXs03GSlUFazP2FYvXCfM43OQzeuormOC3+U8Ih3Aeqj/nC0kLt3cvmkImDYJtN/i3
         YA2oiX8XJAyRpV9MeYdNzL3b6aX4HzyZks0o4SC+64A/1yuU/uAnJ1jPsbwM8+ZGuyaF
         XsG82dTc9LvDdjDcdK8xNAGE5/t9NNsASp2KTVYeB+RygBybCoFTiqc4XyufCzzfJCUS
         t7Pw==
X-Gm-Message-State: APjAAAUHs2owk3duTodb+f+WSi0U+0K/+e8H/AmXNV4sSHwhjtjzflZw
        JgYwRfxEAqOWhTQikhGcluBGE4hOKq8tlafpJ1dcHBjQPwoUyDtdQpS2t4jMOCk8IgzwyMGoIzW
        7gP9CDepPNBMeoG2fRyP9b0kU3Osf
X-Received: by 2002:a24:d643:: with SMTP id o64mr29154579itg.148.1555423318965;
        Tue, 16 Apr 2019 07:01:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuYxaJBOuetMqAT1zQQQN2fVktQuApd+U6kCX1zxVT/gLExusOiL5Rk0VleOFmxdlfUFooOA==
X-Received: by 2002:a24:d643:: with SMTP id o64mr29154491itg.148.1555423318246;
        Tue, 16 Apr 2019 07:01:58 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id m6sm19496152ioj.36.2019.04.16.07.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 07:01:57 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v2] x86/PCI: fix a memory leak bug
Date:   Tue, 16 Apr 2019 09:01:38 -0500
Message-Id: <1555423298-6677-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pcibios_irq_init(), the PCI IRQ routing table 'pirq_table' is firstly
found through pirq_find_routing_table(). If the table is not found and
'CONFIG_PCI_BIOS' is defined, the table is then allocated in
pcibios_get_irq_routing_table() using kmalloc(). In the following
execution, if the I/O APIC is used, this table is actually not used.
However, in that case, the allocated table is not freed, which can lead to
a memory leak bug.

To fix this issue, this patch frees the allocated table if it is not used.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 arch/x86/pci/irq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 52e5510..d3a73f9 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1119,6 +1119,8 @@ static const struct dmi_system_id pciirq_dmi_table[] __initconst = {
 
 void __init pcibios_irq_init(void)
 {
+	struct irq_routing_table *rtable = NULL;
+
 	DBG(KERN_DEBUG "PCI: IRQ init\n");
 
 	if (raw_pci_ops == NULL)
@@ -1129,8 +1131,10 @@ void __init pcibios_irq_init(void)
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS
-	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
+	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN)) {
 		pirq_table = pcibios_get_irq_routing_table();
+		rtable = pirq_table;
+	}
 #endif
 	if (pirq_table) {
 		pirq_peer_trick();
@@ -1145,8 +1149,10 @@ void __init pcibios_irq_init(void)
 		 * If we're using the I/O APIC, avoid using the PCI IRQ
 		 * routing table
 		 */
-		if (io_apic_assign_pci_irqs)
+		if (io_apic_assign_pci_irqs) {
+			kfree(rtable);
 			pirq_table = NULL;
+		}
 	}
 
 	x86_init.pci.fixup_irqs();
-- 
2.7.4

