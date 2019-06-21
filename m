Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C782083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfFUFge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:36:34 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:52181 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbfFUFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:36:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 63F0D182CED2A;
        Fri, 21 Jun 2019 05:36:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow71_38f2c0aecdf16
X-Filterd-Recvd-Size: 3741
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Jun 2019 05:36:31 +0000 (UTC)
Message-ID: <df3a7ca31d2002ca447ab062f5b5e32ced9bec85.camel@perches.com>
Subject: [PATCH] powerpc/powernv: Rename pe_level_printk to pe_printk and
 embed KERN_LEVEL in format
From:   Joe Perches <joe@perches.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Jun 2019 22:36:29 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the separate KERN_<LEVEL> from each pe_level_printk and
instead add the KERN_<LEVEL> to the format.

pfix in pe_level_printk could also be used uninitialized so
add a new else and set pfx to the hex value of pe->flags.

Rename pe_level_printk to pe_printk and update the pe_<level>
macros.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
 arch/powerpc/platforms/powernv/pci.h      | 11 +++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 10cc42b9e541..60fc36ae626a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -50,15 +50,23 @@
 static const char * const pnv_phb_names[] = { "IODA1", "IODA2", "NPU_NVLINK",
 					      "NPU_OCAPI" };
 
-void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
-			    const char *fmt, ...)
+void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
 	char pfix[32];
+	char level[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
 
 	va_start(args, fmt);
 
+	while (printk_get_level(fmt)) {
+		size_t size = printk_skip_level(fmt) - fmt;
+
+		memcpy(level, fmt,  size);
+		level[size] = '\0';
+		fmt += size;
+	}
+
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
@@ -74,6 +82,8 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			(pe->rid & 0xff00) >> 8,
 			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
 #endif /* CONFIG_PCI_IOV*/
+	else
+		sprintf(pfix, "(flags: 0x%lx)", pe->flags);
 
 	printk("%spci %s: [PE# %.2x] %pV",
 	       level, pfix, pe->pe_number, &vaf);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index be26ab3d99e0..870b21f55b3f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -205,15 +205,14 @@ extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels);
 extern int pnv_eeh_post_init(void);
 
-__printf(3, 4)
-extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
-			    const char *fmt, ...);
+__printf(2, 3)
+extern void pe_printk(const struct pnv_ioda_pe *pe, const char *fmt, ...);
 #define pe_err(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_ERR, fmt, ##__VA_ARGS__)
+	pe_printk(pe, KERN_ERR fmt, ##__VA_ARGS__)
 #define pe_warn(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_WARNING, fmt, ##__VA_ARGS__)
+	pe_printk(pe, KERN_WARNING fmt, ##__VA_ARGS__)
 #define pe_info(pe, fmt, ...)					\
-	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
+	pe_printk(pe, KERN_INFO fmt, ##__VA_ARGS__)
 
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);


