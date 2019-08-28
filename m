Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2717FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004C622CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfH1Wbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:31:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48645 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1Wbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:31:52 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i36TX-0005tv-Iv; Thu, 29 Aug 2019 00:31:36 +0200
Date:   Thu, 29 Aug 2019 00:31:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Song Liu <songliubraving@fb.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] x86/mm/cpa: Prevent large page split when ftrace flips RW
 on kernel text
In-Reply-To: <9B34E971-20ED-4A58-B086-AB94990B5A26@fb.com>
Message-ID: <alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de>
References: <20190828142445.454151604@linutronix.de> <20190828143123.971884723@linutronix.de> <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com> <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de> <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
 <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de> <9B34E971-20ED-4A58-B086-AB94990B5A26@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace does not use text_poke() for enabling trace functionality. It uses
its own mechanism and flips the whole kernel text to RW and back to RO.

The CPA rework removed a loop based check of 4k pages which tried to
preserve a large page by checking each 4k page whether the change would
actually cover all pages in the large page.

This resulted in endless loops for nothing as in testing it turned out that
it actually never preserved anything. Of course testing missed to include
ftrace, which is the one and only case which benefitted from the 4k loop.

As a consequence enabling function tracing or ftrace based kprobes results
in a full 4k split of the kernel text, which affects iTLB performance.

The kernel RO protection is the only valid case where this can actually
preserve large pages.

All other static protections (RO data, data NX, PCI, BIOS) are truly
static.  So a conflict with those protections which results in a split
should only ever happen when a change of memory next to a protected region
is attempted. But these conflicts are rightfully splitting the large page
to preserve the protected regions. In fact a change to the protected
regions itself is a bug and is warned about.

Add an exception for the static protection check for kernel text RO when
the to be changed region spawns a full large page which allows to preserve
the large mappings. This also prevents the syslog to be spammed about CPA
violations when ftrace is used.

The exception needs to be removed once ftrace switched over to text_poke()
which avoids the whole issue.

Fixes: 585948f4f695 ("x86/mm/cpa: Avoid the 4k pages check completely")
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/mm/pageattr.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -516,7 +516,7 @@ static inline void check_conflict(int wa
  */
 static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 					  unsigned long pfn, unsigned long npg,
-					  int warnlvl)
+					  unsigned long lpsize, int warnlvl)
 {
 	pgprotval_t forbidden, res;
 	unsigned long end;
@@ -535,9 +535,17 @@ static inline pgprot_t static_protection
 	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
 	forbidden = res;
 
-	res = protect_kernel_text_ro(start, end);
-	check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
-	forbidden |= res;
+	/*
+	 * Special case to preserve a large page. If the change spawns the
+	 * full large page mapping then there is no point to split it
+	 * up. Happens with ftrace and is going to be removed once ftrace
+	 * switched to text_poke().
+	 */
+	if (lpsize != (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
+		res = protect_kernel_text_ro(start, end);
+		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
+		forbidden |= res;
+	}
 
 	/* Check the PFN directly */
 	res = protect_pci_bios(pfn, pfn + npg - 1);
@@ -819,7 +827,7 @@ static int __should_split_large_page(pte
 	 * extra conditional required here.
 	 */
 	chk_prot = static_protections(old_prot, lpaddr, old_pfn, numpages,
-				      CPA_CONFLICT);
+				      psize, CPA_CONFLICT);
 
 	if (WARN_ON_ONCE(pgprot_val(chk_prot) != pgprot_val(old_prot))) {
 		/*
@@ -855,7 +863,7 @@ static int __should_split_large_page(pte
 	 * protection requirement in the large page.
 	 */
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
-				      CPA_DETECT);
+				      psize, CPA_DETECT);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -906,7 +914,8 @@ static void split_set_pte(struct cpa_dat
 	if (!cpa->force_static_prot)
 		goto set;
 
-	prot = static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
+	/* Hand in lpsize = 0 to enforce the protection mechanism */
+	prot = static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT);
 
 	if (pgprot_val(prot) == pgprot_val(ref_prot))
 		goto set;
@@ -1503,7 +1512,8 @@ static int __change_page_attr(struct cpa
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
 		cpa_inc_4k_install();
-		new_prot = static_protections(new_prot, address, pfn, 1,
+		/* Hand in lpsize = 0 to enforce the protection mechanism */
+		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
