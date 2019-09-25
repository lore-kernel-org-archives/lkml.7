Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F97C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F5F205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436769AbfIYOQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:16:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50715 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407554AbfIYOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:16:10 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iD85Q-0000DO-Rb; Wed, 25 Sep 2019 15:16:08 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iD85Q-00065i-G5; Wed, 25 Sep 2019 15:16:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/4] arm: move pcibios_report_status to <asm/pci.h>
Date:   Wed, 25 Sep 2019 15:16:03 +0100
Message-Id: <20190925141604.23364-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
References: <20190925141604.23364-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the pcibios_report_status to <asm/pci.h> include to remove the
following sparse warning and to remove the extra definition in the
footbrdige dc21285.c driver:

arch/arm/kernel/bios32.c:59:6: warning: symbol 'pcibios_report_status' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/pci.h         | 2 ++
 arch/arm/mach-footbridge/dc21285.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 0abd389cf0ec..68e6f25784a4 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -27,5 +27,7 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+extern void pcibios_report_status(unsigned int status_mask, int warn);
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 8b81a17f675d..416462e3f5d6 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -31,7 +31,6 @@
 				  PCI_STATUS_PARITY) << 16)
 
 extern int setup_arm_irq(int, struct irqaction *);
-extern void pcibios_report_status(u_int status_mask, int warn);
 
 static unsigned long
 dc21285_base_address(struct pci_bus *bus, unsigned int devfn)
-- 
2.23.0

