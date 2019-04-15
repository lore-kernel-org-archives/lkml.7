Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08620693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfDOIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:46:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:46:11 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFxFg-0002bO-1h; Mon, 15 Apr 2019 10:46:08 +0200
Date:   Mon, 15 Apr 2019 10:46:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86 team <x86@kernel.org>
Subject: [PATCH] x86/mm: Prevent bogus warnings with "noexec=off"
In-Reply-To: <92ac69b8-7e29-50e1-f460-4e7ac8c6b7ac@gmail.com>
Message-ID: <alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de>
References: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com> <alpine.DEB.2.21.1904141158400.4917@nanos.tec.linutronix.de> <92ac69b8-7e29-50e1-f460-4e7ac8c6b7ac@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xose reported warnings when NX is disabled on the kernel command line.

__early_set_fixmap() triggers:

  attempted to set unsupported pgprot:    8000000000000163
  	       	   	       bits:      8000000000000000
			       supported: 7fffffffffffffff

  WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgtable.h:537
  	   	       	    __early_set_fixmap+0xa2/0xff

because it uses __default_kernel_pte_mask to mask out unsupported bits.

Use __supported_pte_mask instead.

Disabling NX on the command line also triggers the NX warning in the page
table mapping check:

  WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:262 note_page+0x2ae/0x650
  ....

Make the warning depend on NX set in __supported_pte_mask.

Reported-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/dump_pagetables.c |    3 ++-
 arch/x86/mm/ioremap.c         |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -259,7 +259,8 @@ static void note_wx(struct pg_state *st)
 #endif
 	/* Account the WX pages */
 	st->wx_pages += npages;
-	WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %pS\n",
+	WARN_ONCE(__supported_pte_mask & _PAGE_NX,
+		  "x86/mm: Found insecure W+X mapping at address %pS\n",
 		  (void *)st->start_address);
 }
 
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixe
 	pte = early_ioremap_pte(addr);
 
 	/* Sanitize 'prot' against any unsupported bits: */
-	pgprot_val(flags) &= __default_kernel_pte_mask;
+	pgprot_val(flags) &= __supported_pte_mask;
 
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
