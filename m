Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B388C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE9320449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XuEp9kO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfDSSgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:36:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfDSSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:36:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIZpSY384391
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:35:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIZpSY384391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555698952;
        bh=VA8VmbR7gMqlwbqO4TOkSguLnfnNwPcl8JXoiAQ+3mc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XuEp9kO6Q+R6k5Wn/giJw2UvjREODeJ4uKrAVKHgWXq7XMesfowbW4S6mYCveTNp+
         GyqMt30Rn6ik/v3/n2mWEO2iWEuUsikO19wX3MOL9RczAGAsqyLAcaCj/xGDsLaQV0
         8gtvVsuwnhm4VxGug1Gye6CsBbDhvMeYtUBOldqWz724aGEJnknltLxLOJWWYRgAET
         pb2aUVkFtnHeTiu6EqvWvSngLnSkjC2Qq7vYuFWU3u5BeCI42A9FJKDmN5YjZ2W0QO
         1EDHvVewlmpYAsa86wIZL3LRxbAJs7hv7JTfI0qq9m9DgpiYzy2UKZUjXLbE4nqzvb
         Q6F5/Nr4UVrcQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIZpvY384386;
        Fri, 19 Apr 2019 11:35:51 -0700
Date:   Fri, 19 Apr 2019 11:35:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de,
        luto@kernel.org, sean.j.christopherson@intel.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, riel@surriel.com,
        dave.hansen@linux.intel.com, yu-cheng.yu@intel.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org, bp@alien8.de,
          luto@kernel.org, sean.j.christopherson@intel.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          dave.hansen@linux.intel.com, yu-cheng.yu@intel.com
In-Reply-To: <20181221213657.27628-3-sean.j.christopherson@intel.com>
References: <20181221213657.27628-3-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Decode and print #PF oops in human readable
 form
Git-Commit-ID: 18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a
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

Commit-ID:  18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a
Gitweb:     https://git.kernel.org/tip/18ea35c5ed9921867194a8efc2a0ac2d5a3c7d2a
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Fri, 21 Dec 2018 13:36:57 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:31:16 +0200

x86/fault: Decode and print #PF oops in human readable form

Linus pointed out that deciphering the raw #PF error code and printing
a more human readable message are two different things, and also that
printing the negative cases is mostly just noise[1].  For example, the
USER bit doesn't mean the fault originated in user code and stating
that an oops wasn't due to a protection keys violation isn't interesting
since an oops on a keys violation is a one-in-a-million scenario.

Remove the per-bit decoding of the error code and instead print:
  - the raw error code
  - why the fault occurred
  - the effective privilege level of the access
  - the type of access
  - whether the fault originated in user code or kernel code

This provides the user with the information needed to triage 99.9% of
oopses without polluting the log with useless information or conflating
the error_code with the CPL.

Sample output:

    BUG: kernel NULL pointer dereference, address = 0000000000000008
    #PF: supervisor-privileged instruction fetch from kernel code
    #PF: error_code(0x0010) - not-present page

    BUG: unable to handle page fault for address = ffffbeef00000000
    #PF: supervisor-privileged instruction fetch from kernel code
    #PF: error_code(0x0010) - not-present page

    BUG: unable to handle page fault for address = ffffc90000230000
    #PF: supervisor-privileged write access from kernel code
    #PF: error_code(0x000b) - reserved bit violation

[1] https://lkml.kernel.org/r/CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/20181221213657.27628-3-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index df2c5cdef5c4..74c9204c5751 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -603,24 +603,9 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
 }
 
-/*
- * This helper function transforms the #PF error_code bits into
- * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
- */
-static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
-{
-	if (error_code & mask) {
-		if (buf[0])
-			strcat(buf, " ");
-		strcat(buf, txt);
-	}
-}
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	char err_txt[64];
-
 	if (!oops_may_print())
 		return;
 
@@ -651,27 +636,22 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		pr_alert("BUG: unable to handle page fault for address = %px\n",
 			(void *)address);
 
-	err_txt[0] = 0;
-
-	/*
-	 * Note: length of these appended strings including the separation space and the
-	 * zero delimiter must fit into err_txt[].
-	 */
-	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
-	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
-	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
-	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
-	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
-	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
-
-	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+	pr_alert("#PF: %s-privileged %s from %s code\n",
+		 (error_code & X86_PF_USER)  ? "user" : "supervisor",
+		 (error_code & X86_PF_INSTR) ? "instruction fetch" :
+		 (error_code & X86_PF_WRITE) ? "write access" :
+					       "read access",
+			     user_mode(regs) ? "user" : "kernel");
+	pr_alert("#PF: error_code(0x%04lx) - %s\n", error_code,
+		 !(error_code & X86_PF_PROT) ? "not-present page" :
+		 (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
+		 (error_code & X86_PF_PK)    ? "protection keys violation" :
+					       "permissions violation");
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
 
-		pr_alert("This was a system access from user code\n");
-
 		/*
 		 * This can happen for quite a few reasons.  The more obvious
 		 * ones are faults accessing the GDT, or LDT.  Perhaps
