Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E9C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C12084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfDMVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:00:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:00:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKxK8r2266971
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:59:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKxJZ12266968;
        Sat, 13 Apr 2019 13:59:19 -0700
Date:   Sat, 13 Apr 2019 13:59:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-0d714dba162620fd8b9f5b3104a487e041353c4d@git.kernel.org>
Cc:     riel@surriel.com, x86@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, bp@suse.de, mhocko@suse.cz,
        ak@linux.intel.com, dave.hansen@intel.com, rkrcmar@redhat.com,
        Jason@zx2c4.com, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, luto@kernel.org, bigeasy@linutronix.de,
        mingo@kernel.org, kvm@vger.kernel.org, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, hpa@zytor.com
Reply-To: luto@kernel.org, bigeasy@linutronix.de, mingo@kernel.org,
          mingo@redhat.com, pbonzini@redhat.com, jroedel@suse.de,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          kvm@vger.kernel.org, mhocko@suse.cz, ak@linux.intel.com,
          x86@kernel.org, riel@surriel.com, jgross@suse.com,
          linux-kernel@vger.kernel.org, bp@suse.de, dave.hansen@intel.com,
          rkrcmar@redhat.com, tglx@linutronix.de, Jason@zx2c4.com
In-Reply-To: <20190403164156.19645-20-bigeasy@linutronix.de>
References: <20190403164156.19645-20-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Update xstate's PKRU value on write_pkru()
Git-Commit-ID: 0d714dba162620fd8b9f5b3104a487e041353c4d
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

Commit-ID:  0d714dba162620fd8b9f5b3104a487e041353c4d
Gitweb:     https://git.kernel.org/tip/0d714dba162620fd8b9f5b3104a487e041353c4d
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:48 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 20:33:29 +0200

x86/fpu: Update xstate's PKRU value on write_pkru()

During the context switch the xstate is loaded which also includes the
PKRU value.

If xstate is restored on return to userland it is required
that the PKRU value in xstate is the same as the one in the CPU.

Save the PKRU in xstate during modification.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-20-bigeasy@linutronix.de
---
 arch/x86/include/asm/pgtable.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9beb371b1adf..5cfbbb6d458d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,6 +23,8 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/api.h>
 
 extern pgd_t early_top_pgt[PTRS_PER_PGD];
 int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
@@ -133,8 +135,23 @@ static inline u32 read_pkru(void)
 
 static inline void write_pkru(u32 pkru)
 {
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		__write_pkru(pkru);
+	struct pkru_state *pk;
+
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
+
+	/*
+	 * The PKRU value in xstate needs to be in sync with the value that is
+	 * written to the CPU. The FPU restore on return to userland would
+	 * otherwise load the previous value again.
+	 */
+	fpregs_lock();
+	if (pk)
+		pk->pkru = pkru;
+	__write_pkru(pkru);
+	fpregs_unlock();
 }
 
 static inline int pte_young(pte_t pte)
