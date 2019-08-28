Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06251C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5372070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH1UyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:54:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfH1UyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:54:16 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i34xI-0004Oa-0l; Wed, 28 Aug 2019 22:54:12 +0200
Date:   Wed, 28 Aug 2019 22:54:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Subject: [patch V2 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
In-Reply-To: <20190828143123.971884723@linutronix.de>
Message-ID: <alpine.DEB.2.21.1908282252170.1938@nanos.tec.linutronix.de>
References: <20190828142445.454151604@linutronix.de> <20190828143123.971884723@linutronix.de>
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

From: Song Liu <songliubraving@fb.com>

pti_clone_pmds() assumes that the supplied address is either:

 - properly PUD/PMD aligned
or
 - the address is actually mapped which means that independent
   of the mapping level (PUD/PMD/PTE) the next higher mapping
   exist.

If that's not the case the unaligned address can be incremented by PUD or
PMD size wrongly. All callers supply mapped and/or aligned addresses, but
for robustness sake, it's better to handle that case proper and to emit a
warning.

[ tglx: Rewrote changelog and added WARN_ON_ONCE() ]

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Negate P[UM]D_MASK for checking whether the offset part is 0
---
 arch/x86/mm/pti.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -330,13 +330,15 @@ pti_clone_pgtable(unsigned long start, u
 
 		pud = pud_offset(p4d, addr);
 		if (pud_none(*pud)) {
-			addr += PUD_SIZE;
+			WARN_ON_ONCE(addr & ~PUD_MASK);
+			addr = round_up(addr + 1, PUD_SIZE);
 			continue;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (pmd_none(*pmd)) {
-			addr += PMD_SIZE;
+			WARN_ON_ONCE(addr & ~PMD_MASK);
+			addr = round_up(addr + 1, PMD_SIZE);
 			continue;
 		}
 
