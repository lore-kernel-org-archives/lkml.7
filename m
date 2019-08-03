Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB9CC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F0C206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnutsWHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfHCTMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 15:12:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44597 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHCTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:12:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so34874353plr.11;
        Sat, 03 Aug 2019 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dKDYsp/97LqrwIUh/s8HvXnvevJhelv8ENgKPsdnnK4=;
        b=OnutsWHtFPDcONwsibIP736naeob21/Wzsr3epTDYdN9h0UNh9HBb+bB9InH61qSwx
         Nm+v1gU+JpN78E9YJFN5zJhZ6j0C23gqSck/v3IbUSHDdlZmCBMot2zO3BCyY0vlKREN
         dwwVyXaTzscwdhgxGl64ialumlIFNkNDhlTu1ciuiUw2Ox7h17esG8i9aaeaJiD1SfH6
         o+4lDb28vcbGeGrHOrWWJNFQSnmzXNyJAvwkMAcDwhQPvTBIBYSjbjMIvDn5CmGiqRBu
         JHeCaCa+t++mWc0/qx7tGy68ipYWw7zjlxWcDbpjDooawJHWFa6qF6i1yIgxu7ygKe6L
         Ov4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dKDYsp/97LqrwIUh/s8HvXnvevJhelv8ENgKPsdnnK4=;
        b=f3YUdUAxYuLTU2q5o4noMZUFSe6Ov8TGmXbiZF84gT4ILPagHtucZwQXAfiJ1dCMBK
         0Kc9GtwZhNNmCpZALnPQs3eSwR9mqtmVmQyEJkButIUxHLBiqnHlb87gcuFSReVwN9OE
         E+QaWzhVCGof1/iz/rm62L7o+OMW0GIgzI6AfGC40Tniux8uUFQ1xV49AEeDwBw308X+
         3+XMLzHSHfWIeUpi7TOacT86dLrCP4x7hxSm1e/OsxSv09vGTwFRLMftJvkupRYL7rHn
         6R9vZM2lzmTvmV4Qsz0t4Lx0fW5eV2O+iSYSWkUQJQq8ibi+DGBXNzqaRu9x7w4Xueqv
         AWtA==
X-Gm-Message-State: APjAAAXQFXBiF9a8sdIrIno8n1v3oHKFjq43pC98KNIM51dN5Q6r3r+k
        W+kBOkRzucmToNT42RGwVSA=
X-Google-Smtp-Source: APXvYqygX1Mr2RIZkxVLWQBubhGZ/MVy58JPT7oS4GPwuZwIAqkSNzG7YPgcc+k+0+ec/21W3mad0A==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr138470060plb.60.1564859533808;
        Sat, 03 Aug 2019 12:12:13 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.49.144])
        by smtp.gmail.com with ESMTPSA id f32sm15858439pgb.21.2019.08.03.12.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Aug 2019 12:12:12 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, sfr@canb.auug.org.au, mpe@ellerman.id.au,
        paul.burton@mips.com, colin.king@canonical.com,
        gregkh@linuxfoundation.org, rfontana@redhat.com,
        tglx@linutronix.de, arnd@arndb.de, firoz.khan@linaro.org,
        jannh@google.com, namit@vmware.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] arch/alpha: Remove dead code
Date:   Sun,  4 Aug 2019 00:47:36 +0530
Message-Id: <1564859856-5916-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are dead code since 2.6.11. If there is no plan to use
it further, this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/alpha/boot/bootpz.c          |  6 ------
 arch/alpha/kernel/core_irongate.c | 20 ------------------
 arch/alpha/kernel/core_polaris.c  |  3 ---
 arch/alpha/kernel/core_titan.c    | 22 --------------------
 arch/alpha/kernel/core_tsunami.c  | 16 --------------
 arch/alpha/kernel/core_wildfire.c | 22 --------------------
 arch/alpha/kernel/err_marvel.c    | 16 --------------
 arch/alpha/kernel/machvec_impl.h  |  6 ------
 arch/alpha/kernel/module.c        |  4 ----
 arch/alpha/kernel/osf_sys.c       |  9 --------
 arch/alpha/kernel/smp.c           |  9 --------
 arch/alpha/kernel/sys_jensen.c    | 22 --------------------
 arch/alpha/kernel/sys_marvel.c    |  9 --------
 arch/alpha/kernel/sys_miata.c     |  6 ------
 arch/alpha/kernel/sys_ruffian.c   |  6 ------
 arch/alpha/kernel/sys_rx164.c     | 12 -----------
 arch/alpha/kernel/sys_sable.c     | 12 -----------
 arch/alpha/kernel/sys_wildfire.c  | 44 ---------------------------------------
 arch/alpha/kernel/traps.c         | 10 ---------
 arch/alpha/mm/numa.c              |  4 ----
 20 files changed, 258 deletions(-)

diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index 99b8d7d..a106ece 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -379,16 +379,10 @@ extern int decompress_kernel(void* destination, void *source,
 				   uncompressed_image_start,
 				   uncompressed_image_end))
 		{
-#if 0
-			uncompressed_image_start += K_COPY_IMAGE_SIZE;
-			uncompressed_image_end += K_COPY_IMAGE_SIZE;
-			initrd_image_start += K_COPY_IMAGE_SIZE;
-#else
 			/* Keep as close as possible to end of BOOTP image. */
 			uncompressed_image_start += PAGE_SIZE;
 			uncompressed_image_end += PAGE_SIZE;
 			initrd_image_start += PAGE_SIZE;
-#endif
 		}
 	}
 
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index a9fd133..d6be68c 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -358,22 +358,6 @@ struct pci_ops irongate_pci_ops =
 	last = addr + size - 1;
 	size = PAGE_ALIGN(last) - addr;
 
-#if 0
-	printk("irongate_ioremap(0x%lx, 0x%lx)\n", addr, size);
-	printk("irongate_ioremap:  gart_bus_addr  0x%lx\n", gart_bus_addr);
-	printk("irongate_ioremap:  gart_aper_size 0x%lx\n", gart_aper_size);
-	printk("irongate_ioremap:  mmio_regs      %p\n", mmio_regs);
-	printk("irongate_ioremap:  gatt_pages     %p\n", gatt_pages);
-	
-	for(baddr = addr; baddr <= last; baddr += PAGE_SIZE)
-	{
-		cur_gatt = phys_to_virt(GET_GATT(baddr) & ~1);
-		pte = cur_gatt[GET_GATT_OFF(baddr)] & ~1;
-		printk("irongate_ioremap:  cur_gatt %p pte 0x%x\n",
-		       cur_gatt, pte);
-	}
-#endif
-
 	/*
 	 * Map it
 	 */
@@ -398,10 +382,6 @@ struct pci_ops irongate_pci_ops =
 	flush_tlb_all();
 
 	vaddr = (unsigned long)area->addr + (addr & ~PAGE_MASK);
-#if 0
-	printk("irongate_ioremap(0x%lx, 0x%lx) returning 0x%lx\n",
-	       addr, size, vaddr);
-#endif
 	return (void __iomem *)vaddr;
 }
 EXPORT_SYMBOL(irongate_ioremap);
diff --git a/arch/alpha/kernel/core_polaris.c b/arch/alpha/kernel/core_polaris.c
index 75d622d..9e20984 100644
--- a/arch/alpha/kernel/core_polaris.c
+++ b/arch/alpha/kernel/core_polaris.c
@@ -152,9 +152,6 @@ struct pci_ops polaris_pci_ops =
 	 * for now assume that the firmware has done the right thing
 	 * already.
 	 */
-#if 0
-	printk("polaris_init_arch(): trusting firmware for setup\n");
-#endif
 
 	/*
 	 * Create our single hose.
diff --git a/arch/alpha/kernel/core_titan.c b/arch/alpha/kernel/core_titan.c
index 2a2820f..c7caf10 100644
--- a/arch/alpha/kernel/core_titan.c
+++ b/arch/alpha/kernel/core_titan.c
@@ -367,24 +367,6 @@ struct pci_ops titan_pci_ops =
 void __init
 titan_init_arch(void)
 {
-#if 0
-	printk("%s: titan_init_arch()\n", __func__);
-	printk("%s: CChip registers:\n", __func__);
-	printk("%s: CSR_CSC 0x%lx\n", __func__, TITAN_cchip->csc.csr);
-	printk("%s: CSR_MTR 0x%lx\n", __func__, TITAN_cchip->mtr.csr);
-	printk("%s: CSR_MISC 0x%lx\n", __func__, TITAN_cchip->misc.csr);
-	printk("%s: CSR_DIM0 0x%lx\n", __func__, TITAN_cchip->dim0.csr);
-	printk("%s: CSR_DIM1 0x%lx\n", __func__, TITAN_cchip->dim1.csr);
-	printk("%s: CSR_DIR0 0x%lx\n", __func__, TITAN_cchip->dir0.csr);
-	printk("%s: CSR_DIR1 0x%lx\n", __func__, TITAN_cchip->dir1.csr);
-	printk("%s: CSR_DRIR 0x%lx\n", __func__, TITAN_cchip->drir.csr);
-
-	printk("%s: DChip registers:\n", __func__);
-	printk("%s: CSR_DSC 0x%lx\n", __func__, TITAN_dchip->dsc.csr);
-	printk("%s: CSR_STR 0x%lx\n", __func__, TITAN_dchip->str.csr);
-	printk("%s: CSR_DREV 0x%lx\n", __func__, TITAN_dchip->drev.csr);
-#endif
-
 	boot_cpuid = __hard_smp_processor_id();
 
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
@@ -652,10 +634,6 @@ struct titan_agp_aperture {
 	pctl.pctl_r_bits.apctl_v_agp_rate = 0;		/* 1x */
 	if (agp->mode.bits.rate & 2) 
 		pctl.pctl_r_bits.apctl_v_agp_rate = 1;	/* 2x */
-#if 0
-	if (agp->mode.bits.rate & 4) 
-		pctl.pctl_r_bits.apctl_v_agp_rate = 2;	/* 4x */
-#endif
 	
 	/* RQ Depth? */
 	pctl.pctl_r_bits.apctl_v_agp_hp_rd = 2;
diff --git a/arch/alpha/kernel/core_tsunami.c b/arch/alpha/kernel/core_tsunami.c
index fc1ab73..8b6c47d 100644
--- a/arch/alpha/kernel/core_tsunami.c
+++ b/arch/alpha/kernel/core_tsunami.c
@@ -391,22 +391,6 @@ struct pci_ops tsunami_pci_ops =
 	       ? "succeeded" : "failed");
 #endif /* NXM_MACHINE_CHECKS_ON_TSUNAMI */
 
-#if 0
-	printk("%s: CChip registers:\n", __func__);
-	printk("%s: CSR_CSC 0x%lx\n", __func__, TSUNAMI_cchip->csc.csr);
-	printk("%s: CSR_MTR 0x%lx\n", __func__, TSUNAMI_cchip.mtr.csr);
-	printk("%s: CSR_MISC 0x%lx\n", __func__, TSUNAMI_cchip->misc.csr);
-	printk("%s: CSR_DIM0 0x%lx\n", __func__, TSUNAMI_cchip->dim0.csr);
-	printk("%s: CSR_DIM1 0x%lx\n", __func__, TSUNAMI_cchip->dim1.csr);
-	printk("%s: CSR_DIR0 0x%lx\n", __func__, TSUNAMI_cchip->dir0.csr);
-	printk("%s: CSR_DIR1 0x%lx\n", __func__, TSUNAMI_cchip->dir1.csr);
-	printk("%s: CSR_DRIR 0x%lx\n", __func__, TSUNAMI_cchip->drir.csr);
-
-	printk("%s: DChip registers:\n");
-	printk("%s: CSR_DSC 0x%lx\n", __func__, TSUNAMI_dchip->dsc.csr);
-	printk("%s: CSR_STR 0x%lx\n", __func__, TSUNAMI_dchip->str.csr);
-	printk("%s: CSR_DREV 0x%lx\n", __func__, TSUNAMI_dchip->drev.csr);
-#endif
 	/* With multiple PCI busses, we play with I/O as physical addrs.  */
 	ioport_resource.end = ~0UL;
 
diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index e8d3b03..367479a 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -191,9 +191,6 @@
 	int i;
 
 	temp = fast->qsd_whami.csr;
-#if 0
-	printk(KERN_ERR "fast QSD_WHAMI at base %p is 0x%lx\n", fast, temp);
-#endif
 
 	hard_qbb = (temp >> 8) & 7;
 	soft_qbb = (temp >> 4) & 7;
@@ -218,9 +215,6 @@
 	qsa = WILDFIRE_qsa(soft_qbb);
 
 	temp = qsa->qsa_qbb_id.csr;
-#if 0
-	printk(KERN_ERR "QSA_QBB_ID at base %p is 0x%lx\n", qsa, temp);
-#endif
 
 	if (temp & 0x40) /* Is there an HS? */
 		wildfire_hs_mask = 1;
@@ -230,10 +224,6 @@
 		temp = 0;
 		for (i = 0; i < 4; i++) {
 			temp |= gp->gpa_qbb_map[i].csr << (i * 8);
-#if 0
-			printk(KERN_ERR "GPA_QBB_MAP[%d] at base %p is 0x%lx\n",
-			       i, gp, temp);
-#endif
 		}
 
 		for (hard_qbb = 0; hard_qbb < WILDFIRE_MAX_QBB; hard_qbb++) {
@@ -252,32 +242,20 @@
 	    if (WILDFIRE_QBB_EXISTS(soft_qbb)) {
 	        qsd = WILDFIRE_qsd(soft_qbb);
 		temp = qsd->qsd_whami.csr;
-#if 0
-	printk(KERN_ERR "QSD_WHAMI at base %p is 0x%lx\n", qsd, temp);
-#endif
 		hard_qbb = (temp >> 8) & 7;
 		wildfire_hard_qbb_map[hard_qbb] = soft_qbb;
 		wildfire_soft_qbb_map[soft_qbb] = hard_qbb;
 
 		qsa = WILDFIRE_qsa(soft_qbb);
 		temp = qsa->qsa_qbb_pop[0].csr;
-#if 0
-	printk(KERN_ERR "QSA_QBB_POP_0 at base %p is 0x%lx\n", qsa, temp);
-#endif
 		wildfire_cpu_mask |= ((temp >> 0) & 0xf) << (soft_qbb << 2);
 		wildfire_mem_mask |= ((temp >> 4) & 0xf) << (soft_qbb << 2);
 
 		temp = qsa->qsa_qbb_pop[1].csr;
-#if 0
-	printk(KERN_ERR "QSA_QBB_POP_1 at base %p is 0x%lx\n", qsa, temp);
-#endif
 		wildfire_iop_mask |= (1 << soft_qbb);
 		wildfire_ior_mask |= ((temp >> 4) & 0xf) << (soft_qbb << 2);
 
 		temp = qsa->qsa_qbb_id.csr;
-#if 0
-	printk(KERN_ERR "QSA_QBB_ID at %p is 0x%lx\n", qsa, temp);
-#endif
 		if (temp & 0x20)
 		    wildfire_gp_mask |= (1 << soft_qbb);
 
diff --git a/arch/alpha/kernel/err_marvel.c b/arch/alpha/kernel/err_marvel.c
index c0c0cce..695d01d 100644
--- a/arch/alpha/kernel/err_marvel.c
+++ b/arch/alpha/kernel/err_marvel.c
@@ -964,22 +964,6 @@
 	if (lf_subpackets->io->po7_error_sum & IO7__PO7_ERRSUM__ERR_MASK) {
 		marvel_print_po7_err_sum(io);
 
-#if 0
-		printk("%s  PORT 7 ERROR:\n"
-		       "%s    PO7_ERROR_SUM: %016llx\n"
-		       "%s    PO7_UNCRR_SYM: %016llx\n"
-		       "%s    PO7_CRRCT_SYM: %016llx\n"
-		       "%s    PO7_UGBGE_SYM: %016llx\n"
-		       "%s    PO7_ERR_PKT0:  %016llx\n"
-		       "%s    PO7_ERR_PKT1:  %016llx\n",
-		       err_print_prefix,
-		       err_print_prefix, io->po7_error_sum,
-		       err_print_prefix, io->po7_uncrr_sym,
-		       err_print_prefix, io->po7_crrct_sym,
-		       err_print_prefix, io->po7_ugbge_sym,
-		       err_print_prefix, io->po7_err_pkt0,
-		       err_print_prefix, io->po7_err_pkt1);
-#endif
 	}
 
 	/*
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index 38f045e..30cef95 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -143,13 +143,7 @@
 /* GCC actually has a syntax for defining aliases, but is under some
    delusion that you shouldn't be able to declare it extern somewhere
    else beforehand.  Fine.  We'll do it ourselves.  */
-#if 0
-#define ALIAS_MV(system) \
-  struct alpha_machine_vector alpha_mv __attribute__((alias(#system "_mv"))); \
-  EXPORT_SYMBOL(alpha_mv);
-#else
 #define ALIAS_MV(system) \
   asm(".global alpha_mv\nalpha_mv = " #system "_mv"); \
   EXPORT_SYMBOL(alpha_mv);
-#endif
 #endif /* GENERIC */
diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
index ac110ae..08dc283 100644
--- a/arch/alpha/kernel/module.c
+++ b/arch/alpha/kernel/module.c
@@ -11,11 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 
-#if 0
-#define DEBUGP printk
-#else
 #define DEBUGP(fmt...)
-#endif
 
 /* Allocate the GOT at the end of the core sections.  */
 
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index bf497b8..66791e0 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -76,10 +76,6 @@
 	mm->end_code = bss_start + bss_len;
 	mm->start_brk = bss_start + bss_len;
 	mm->brk = bss_start + bss_len;
-#if 0
-	printk("set_program_attributes(%lx %lx %lx %lx)\n",
-		text_start, text_len, bss_start, bss_len);
-#endif
 	return 0;
 }
 
@@ -180,11 +176,6 @@ struct osf_dirent_callback {
 {
 	unsigned long ret = -EINVAL;
 
-#if 0
-	if (flags & (_MAP_HASSEMAPHORE | _MAP_INHERIT | _MAP_UNALIGNED))
-		printk("%s: unimplemented OSF mmap flags %04lx\n", 
-			current->comm, flags);
-#endif
 	if ((off + PAGE_ALIGN(len)) < off)
 		goto out;
 	if (off & ~PAGE_MASK)
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 5f90df3..c2a7916 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -315,10 +315,6 @@ enum ipi_message_type {
 	hwpcb->flags = ipcb->flags;
 	hwpcb->res1 = hwpcb->res2 = 0;
 
-#if 0
-	DBGS(("KSP 0x%lx PTBR 0x%lx VPTBR 0x%lx UNIQUE 0x%lx\n",
-	      hwpcb->ksp, hwpcb->ptbr, hwrpb->vptb, hwpcb->unique));
-#endif
 	DBGS(("Starting secondary cpu %d: state 0x%lx pal_flags 0x%lx\n",
 	      cpuid, idle->state, ipcb->flags));
 
@@ -527,11 +523,6 @@ enum ipi_message_type {
 	unsigned long *pending_ipis = &ipi_data[this_cpu].bits;
 	unsigned long ops;
 
-#if 0
-	DBGS(("handle_ipi: on CPU %d ops 0x%lx PC 0x%lx\n",
-	      this_cpu, *pending_ipis, regs->pc));
-#endif
-
 	mb();	/* Order interrupt and bit testing. */
 	while ((ops = xchg(pending_ipis, 0)) != 0) {
 	  mb();	/* Order bit clearing and data access. */
diff --git a/arch/alpha/kernel/sys_jensen.c b/arch/alpha/kernel/sys_jensen.c
index d0d44f5..681a7df 100644
--- a/arch/alpha/kernel/sys_jensen.c
+++ b/arch/alpha/kernel/sys_jensen.c
@@ -141,28 +141,6 @@
 	    }
 	}
 
-#if 0
-        /* A useful bit of code to find out if an interrupt is going wild.  */
-        {
-          static unsigned int last_msg = 0, last_cc = 0;
-          static int last_irq = -1, count = 0;
-          unsigned int cc;
-
-          __asm __volatile("rpcc %0" : "=r"(cc));
-          ++count;
-#define JENSEN_CYCLES_PER_SEC	(150000000)
-          if (cc - last_msg > ((JENSEN_CYCLES_PER_SEC) * 3) ||
-	      irq != last_irq) {
-                printk(KERN_CRIT " irq %d count %d cc %u @ %lx\n",
-                       irq, count, cc-last_cc, get_irq_regs()->pc);
-                count = 0;
-                last_msg = cc;
-                last_irq = irq;
-          }
-          last_cc = cc;
-        }
-#endif
-
 	handle_irq(irq);
 }
 
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 8d34cf6..4c73243 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -360,15 +360,6 @@
 		       (irq + 16) | (io7->pe << MARVEL_IRQ_VEC_PE_SHIFT),
 		       (irq + 16) | (io7->pe << MARVEL_IRQ_VEC_PE_SHIFT));
 #endif
-
-#if 0
-		pci_write_config_word(dev, msi_loc + PCI_MSI_FLAGS,
-				      msg_ctl & ~PCI_MSI_FLAGS_ENABLE);
-		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &intline);
-		irq = intline;
-
-		printk("  forcing LSI interrupt on irq %d [0x%x]\n", irq, irq);
-#endif
 	}
 
 	irq += 16;					/* offset for legacy */
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 6fa07dc..fda335b 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -65,12 +65,6 @@
 	if (alpha_using_srm)
 		alpha_mv.device_interrupt = miata_srm_device_interrupt;
 
-#if 0
-	/* These break on MiataGL so we'll try not to do it at all.  */
-	*(vulp)PYXIS_INT_HILO = 0x000000B2UL; mb();	/* ISA/NMI HI */
-	*(vulp)PYXIS_RT_COUNT = 0UL; mb();		/* clear count */
-#endif
-
 	init_i8259a_irqs();
 
 	/* Not interested in the bogus interrupts (3,10), Fan Fault (0),
diff --git a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
index 07830cc..fa071f0 100644
--- a/arch/alpha/kernel/sys_ruffian.c
+++ b/arch/alpha/kernel/sys_ruffian.c
@@ -89,12 +89,6 @@
 ruffian_kill_arch (int mode)
 {
 	cia_kill_arch(mode);
-#if 0
-	/* This only causes re-entry to ARCSBIOS */
-	/* Perhaps this works for other PYXIS as well?  */
-	*(vuip) PYXIS_RESET = 0x0000dead;
-	mb();
-#endif
 }
 
 /*
diff --git a/arch/alpha/kernel/sys_rx164.c b/arch/alpha/kernel/sys_rx164.c
index a3db719..adb65b8 100644
--- a/arch/alpha/kernel/sys_rx164.c
+++ b/arch/alpha/kernel/sys_rx164.c
@@ -146,17 +146,6 @@
 static int
 rx164_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-#if 0
-	static char irq_tab_pass1[6][5] __initdata = {
-	  /*INT   INTA  INTB  INTC   INTD */
-	  { 16+3, 16+3, 16+8, 16+13, 16+18},      /* IdSel 5,  slot 2 */
-	  { 16+5, 16+5, 16+10, 16+15, 16+20},     /* IdSel 6,  slot 0 */
-	  { 16+4, 16+4, 16+9, 16+14, 16+19},      /* IdSel 7,  slot 1 */
-	  { -1,     -1,    -1,    -1,   -1},      /* IdSel 8, PCI/ISA bridge */
-	  { 16+2, 16+2, 16+7, 16+12, 16+17},      /* IdSel 9,  slot 3 */
-	  { 16+1, 16+1, 16+6, 16+11, 16+16},      /* IdSel 10, slot 4 */
-	};
-#else
 	static char irq_tab[6][5] = {
 	  /*INT   INTA  INTB  INTC   INTD */
 	  { 16+0, 16+0, 16+6, 16+11, 16+16},      /* IdSel 5,  slot 0 */
@@ -166,7 +155,6 @@
 	  { 16+3, 16+3, 16+9, 16+14, 16+19},      /* IdSel 9,  slot 3 */
 	  { 16+4, 16+4, 16+10, 16+15, 16+5},      /* IdSel 10, PCI-PCI */
 	};
-#endif
 	const long min_idsel = 5, max_idsel = 10, irqs_per_slot = 5;
 
 	/* JRP - Need to figure out how to distinguish pass1 from pass2,
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index 3cf0d32..9c4613f 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -452,10 +452,6 @@
 	mask = sable_lynx_irq_swizzle->shadow_mask &= ~(1UL << bit);
 	sable_lynx_irq_swizzle->update_irq_hw(bit, mask);
 	spin_unlock(&sable_lynx_irq_lock);
-#if 0
-	printk("%s: mask 0x%lx bit 0x%lx irq 0x%x\n",
-	       __func__, mask, bit, irq);
-#endif
 }
 
 static void
@@ -468,10 +464,6 @@
 	mask = sable_lynx_irq_swizzle->shadow_mask |= 1UL << bit;
 	sable_lynx_irq_swizzle->update_irq_hw(bit, mask);
 	spin_unlock(&sable_lynx_irq_lock);
-#if 0
-	printk("%s: mask 0x%lx bit 0x%lx irq 0x%x\n",
-	       __func__, mask, bit, irq);
-#endif
 }
 
 static void
@@ -505,10 +497,6 @@
 
 	bit = (vector - 0x800) >> 4;
 	irq = sable_lynx_irq_swizzle->mask_to_irq[bit];
-#if 0
-	printk("%s: vector 0x%lx bit 0x%x irq 0x%x\n",
-	       __func__, vector, bit, irq);
-#endif
 	handle_irq(irq);
 }
 
diff --git a/arch/alpha/kernel/sys_wildfire.c b/arch/alpha/kernel/sys_wildfire.c
index 8e64052..fedc055 100644
--- a/arch/alpha/kernel/sys_wildfire.c
+++ b/arch/alpha/kernel/sys_wildfire.c
@@ -65,32 +65,6 @@
 static void __init
 wildfire_init_irq_hw(void)
 {
-#if 0
-	register wildfire_pca * pca = WILDFIRE_pca(0, 0);
-	volatile unsigned long * enable0, * enable1, * enable2, *enable3;
-	volatile unsigned long * target0, * target1, * target2, *target3;
-
-	enable0 = (unsigned long *) &pca->pca_int[0].enable;
-	enable1 = (unsigned long *) &pca->pca_int[1].enable;
-	enable2 = (unsigned long *) &pca->pca_int[2].enable;
-	enable3 = (unsigned long *) &pca->pca_int[3].enable;
-
-	target0 = (unsigned long *) &pca->pca_int[0].target;
-	target1 = (unsigned long *) &pca->pca_int[1].target;
-	target2 = (unsigned long *) &pca->pca_int[2].target;
-	target3 = (unsigned long *) &pca->pca_int[3].target;
-
-	*enable0 = *enable1 = *enable2 = *enable3 = 0;
-
-	*target0 = (1UL<<8) | WILDFIRE_QBB(0);
-	*target1 = *target2 = *target3 = 0;
-
-	mb();
-
-	*enable0; *enable1; *enable2; *enable3;
-	*target0; *target1; *target2; *target3;
-
-#else
 	int i;
 
 	doing_init_irq_hw = 1;
@@ -100,7 +74,6 @@
 		wildfire_update_irq_hw(i);
 
 	doing_init_irq_hw = 0;
-#endif
 }
 
 static void
@@ -164,23 +137,6 @@
 	irq_bias = qbbno * (WILDFIRE_PCA_PER_QBB * WILDFIRE_IRQ_PER_PCA)
 		 + pcano * WILDFIRE_IRQ_PER_PCA;
 
-#if 0
-	unsigned long io_bias;
-
-	/* Only need the following for first PCI bus per PCA. */
-	io_bias = WILDFIRE_IO(qbbno, pcano<<1) - WILDFIRE_IO_BIAS;
-
-	outb(0, DMA1_RESET_REG + io_bias);
-	outb(0, DMA2_RESET_REG + io_bias);
-	outb(DMA_MODE_CASCADE, DMA2_MODE_REG + io_bias);
-	outb(0, DMA2_MASK_REG + io_bias);
-#endif
-
-#if 0
-	/* ??? Not sure how to do this, yet... */
-	init_i8259a_irqs(); /* ??? */
-#endif
-
 	for (i = 0; i < 16; ++i) {
 		if (i == 2)
 			continue;
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index f6b9664a..2e5081d 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -93,18 +93,8 @@
 	printk("t11= %016lx  pv = %016lx  at = %016lx\n",
 	       regs->r25, regs->r27, regs->r28);
 	printk("gp = %016lx  sp = %p\n", regs->gp, regs+1);
-#if 0
-__halt();
-#endif
 }
 
-#if 0
-static char * ireg_name[] = {"v0", "t0", "t1", "t2", "t3", "t4", "t5", "t6",
-			   "t7", "s0", "s1", "s2", "s3", "s4", "s5", "s6",
-			   "a0", "a1", "a2", "a3", "a4", "a5", "t8", "t9",
-			   "t10", "t11", "ra", "pv", "at", "gp", "sp", "zero"};
-#endif
-
 static void
 dik_show_code(unsigned int *pc)
 {
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index d0b7337..f081a3e 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -128,10 +128,6 @@ static void __init show_mem_layout(void)
 	if (node_max_pfn > max_low_pfn)
 		max_pfn = max_low_pfn = node_max_pfn;
 
-#if 0 /* we'll try this one again in a little while */
-	/* Cute trick to make sure our local node data is on local memory */
-	node_data[nid] = (pg_data_t *)(__va(node_min_pfn << PAGE_SHIFT));
-#endif
 	printk(" Detected node memory:   start %8lu, end %8lu\n",
 	       node_min_pfn, node_max_pfn);
 
-- 
1.9.1

