Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD6D2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfDPHqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:46:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:46:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G7k7q63337111
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 00:46:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G7k66M3337108;
        Tue, 16 Apr 2019 00:46:06 -0700
Date:   Tue, 16 Apr 2019 00:46:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-510bb96fe5b3480b4b22d815786377e54cb701e7@git.kernel.org>
Cc:     xose.vazquez@gmail.com, riel@surriel.com, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: luto@kernel.org, bp@alien8.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          dave.hansen@linux.intel.com, riel@surriel.com,
          xose.vazquez@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Prevent bogus warnings with "noexec=off"
Git-Commit-ID: 510bb96fe5b3480b4b22d815786377e54cb701e7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  510bb96fe5b3480b4b22d815786377e54cb701e7
Gitweb:     https://git.kernel.org/tip/510bb96fe5b3480b4b22d815786377e54cb701e7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 15 Apr 2019 10:46:07 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 09:42:10 +0200

x86/mm: Prevent bogus warnings with "noexec=off"

Xose Vazquez Perez reported boot warnings when NX is disabled on the kernel command line.

__early_set_fixmap() triggers this warning:

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
Tested-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/dump_pagetables.c | 3 ++-
 arch/x86/mm/ioremap.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index ee8f8ab46941..c0309ea9abee 100644
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
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..dd73d5d74393 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 	pte = early_ioremap_pte(addr);
 
 	/* Sanitize 'prot' against any unsupported bits: */
-	pgprot_val(flags) &= __default_kernel_pte_mask;
+	pgprot_val(flags) &= __supported_pte_mask;
 
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
