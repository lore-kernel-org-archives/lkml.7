Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A89C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719322075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfC0VhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:37:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58672 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfC0Vgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:50 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE4-0006DN-EM; Wed, 27 Mar 2019 15:36:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE2-0006Cq-Is; Wed, 27 Mar 2019 15:36:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>, Zong Li <zong@andestech.com>,
        Guo Ren <ren_guo@c-sky.com>,
        "Stefan O'Rear" <sorear2@gmail.com>
Date:   Wed, 27 Mar 2019 15:36:43 -0600
Message-Id: <20190327213643.23789-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
References: <20190327213643.23789-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com, ldufour@linux.vnet.ibm.com, rppt@linux.vnet.ibm.com, anup.patel@wdc.com, zong@andestech.com, ren_guo@c-sky.com, sorear2@gmail.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 7/7] RISC-V: Implement pte_devmap()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 2nd software bit in the PTE as the devmap bit and add the
appropriate accessors.

This also allows us to set ARCH_HAS_ZONE_DEVICE.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Zong Li <zong@andestech.com>
Cc: Guo Ren <ren_guo@c-sky.com>
Cc: "Stefan O'Rear" <sorear2@gmail.com>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-bits.h |  8 ++++++--
 arch/riscv/include/asm/pgtable.h      | 10 ++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2cb39b4d6d6b..d365d7e17ed2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV
 	select GENERIC_IRQ_MULTI_HANDLER
 	select ARCH_HAS_PTE_SPECIAL
 	select HAVE_EBPF_JIT if 64BIT
+	select ARCH_HAS_ZONE_DEVICE
 
 config MMU
 	def_bool y
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 470755cb7558..9555d419a46f 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -30,9 +30,11 @@
 #define _PAGE_GLOBAL    (1 << 5)    /* Global */
 #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
 #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
-#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
+#define _PAGE_SOFT1     (1 << 8)    /* Reserved for software */
+#define _PAGE_SOFT2     (1 << 9)    /* Reserved for software */
 
-#define _PAGE_SPECIAL   _PAGE_SOFT
+#define _PAGE_SPECIAL   _PAGE_SOFT1
+#define _PAGE_DEVMAP	_PAGE_SOFT2
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
@@ -41,6 +43,8 @@
  */
 #define _PAGE_PROT_NONE _PAGE_READ
 
+#define __HAVE_ARCH_PTE_DEVMAP
+
 #define _PAGE_PFN_SHIFT 10
 
 /* Set of bits to preserve across pte_modify() */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e071e2be3a6c..a0e6a5f8bbb5 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -248,6 +248,11 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
+static inline int pte_devmap(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DEVMAP;
+}
+
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -289,6 +294,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+static inline pte_t pte_mkdevmap(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL | _PAGE_DEVMAP);
+}
+
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.20.1

