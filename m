Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A92AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1BD20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391387AbfFMQMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:12:17 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32442 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbfFMQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:12:14 -0400
Received: from heffalump.sk2.org (unknown [88.186.243.14])
        by smtp5-g21.free.fr (Postfix) with ESMTPS id 4DB325FFB9;
        Thu, 13 Jun 2019 18:12:12 +0200 (CEST)
Received: from steve by heffalump.sk2.org with local (Exim 4.89)
        (envelope-from <steve@sk2.org>)
        id 1hbSKh-0004Qa-LM; Thu, 13 Jun 2019 18:12:11 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Drop unused isa_page_to_bus
Date:   Thu, 13 Jun 2019 18:11:55 +0200
Message-Id: <20190613161155.16946-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isa_page_to_bus is deprecated and no longer used anywhere, this patch
removes it entirely.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 arch/alpha/include/asm/io.h | 5 -----
 arch/arm/include/asm/io.h   | 1 -
 arch/mips/include/asm/io.h  | 2 --
 arch/x86/include/asm/io.h   | 1 -
 4 files changed, 9 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index ccf9d65166bb..af2c0063dc75 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -93,11 +93,6 @@ static inline void * phys_to_virt(unsigned long address)
 
 #define page_to_phys(page)	page_to_pa(page)
 
-static inline dma_addr_t __deprecated isa_page_to_bus(struct page *page)
-{
-	return page_to_phys(page);
-}
-
 /* Maximum PIO space address supported?  */
 #define IO_SPACE_LIMIT 0xffff
 
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 7e22c81398c4..f96ec93679b7 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -33,7 +33,6 @@
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
 #define isa_virt_to_bus virt_to_phys
-#define isa_page_to_bus page_to_phys
 #define isa_bus_to_virt phys_to_virt
 
 /*
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 29997e42480e..1790274c27eb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -149,8 +149,6 @@ static inline void *isa_bus_to_virt(unsigned long address)
 	return phys_to_virt(address);
 }
 
-#define isa_page_to_bus page_to_phys
-
 /*
  * However PCI ones are not necessarily 1:1 and therefore these interfaces
  * are forbidden in portable PCI drivers.
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index a06a9f8294ea..6bed97ff6db2 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -165,7 +165,6 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
 {
 	return (unsigned int)virt_to_phys(address);
 }
-#define isa_page_to_bus(page)	((unsigned int)page_to_phys(page))
 #define isa_bus_to_virt		phys_to_virt
 
 /*
-- 
2.11.0

