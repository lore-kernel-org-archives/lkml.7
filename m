Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DC320883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139267;
	bh=FASaS34GqbleI83ztECSZIvQJb98GrE8Ycs33m8oTSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LRopD+0StNJZ7MQHVsnnlY8j/cDMyeAc4Q56j1LuHK7syx+RorMyY5rvfZvl+Fb3Q
	 AVcLfJA7IImePH+lf+ryfWkZFl0zCCew2oCnCL3hefJZdRqAfbcEAzGv858wWNrLAQ
	 FBal5rDlvZCZZ31IBZSg3bfXh/zakAMydN3ZMd54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfDARVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731739AbfDARVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80DF20883;
        Mon,  1 Apr 2019 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139262;
        bh=FASaS34GqbleI83ztECSZIvQJb98GrE8Ycs33m8oTSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmEg/SycNcWJPAdzbGTWFrrclm9jBAo9Klp2Hti/RjRxdZO91H6tNpPtxBGthVtd9
         WzrZhSua/6UTbXfaFsGK219h84btTaIAb1SbatWaN1AaiN+0pMjiJ6+PPlvslhSzgY
         70Qvl8Ia/FFHunwdTh3Pw52xooOoZxo0eEgv0Bsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 024/107] powerpc/64s: Add support for ori barrier_nospec patching
Date:   Mon,  1 Apr 2019 19:01:39 +0200
Message-Id: <20190401170047.924873340@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Suchanek <msuchanek@suse.de>

commit 2eea7f067f495e33b8b116b35b5988ab2b8aec55 upstream.

Based on the RFI patching. This is required to be able to disable the
speculation barrier.

Only one barrier type is supported and it does nothing when the
firmware does not enable it. Also re-patching modules is not supported
So the only meaningful thing that can be done is patching out the
speculation barrier at boot when the user says it is not wanted.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/barrier.h        |    2 +-
 arch/powerpc/include/asm/feature-fixups.h |    9 +++++++++
 arch/powerpc/include/asm/setup.h          |    1 +
 arch/powerpc/kernel/security.c            |    9 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |    7 +++++++
 arch/powerpc/lib/feature-fixups.c         |   27 +++++++++++++++++++++++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -81,7 +81,7 @@ do {									\
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
  */
-#define barrier_nospec_asm ori 31,31,0
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop
 
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -211,6 +211,14 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 951b-952b;			\
 	.popsection;
 
+#define NOSPEC_BARRIER_FIXUP_SECTION			\
+953:							\
+	.pushsection __barrier_nospec_fixup,"a";	\
+	.align 2;					\
+954:							\
+	FTR_ENTRY_OFFSET 953b-954b;			\
+	.popsection;
+
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
@@ -219,6 +227,7 @@ extern long stf_barrier_fallback;
 extern long __start___stf_entry_barrier_fixup, __stop___stf_entry_barrier_fixup;
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
+extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
 
 void apply_feature_fixups(void);
 void setup_feature_keys(void);
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,6 +52,7 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+void do_barrier_nospec_fixups(bool enable);
 
 #endif /* !__ASSEMBLY__ */
 
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -10,10 +10,19 @@
 
 #include <asm/debugfs.h>
 #include <asm/security_features.h>
+#include <asm/setup.h>
 
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+static bool barrier_nospec_enabled;
+
+static void enable_barrier_nospec(bool enable)
+{
+	barrier_nospec_enabled = enable;
+	do_barrier_nospec_fixups(enable);
+}
+
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,6 +153,13 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+
+	. = ALIGN(8);
+	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
+		__start___barrier_nospec_fixup = .;
+		*(__barrier_nospec_fixup)
+		__stop___barrier_nospec_fixup = .;
+	}
 #endif
 
 	EXCEPTION_TABLE(0)
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -277,6 +277,33 @@ void do_rfi_flush_fixups(enum l1d_flush_
 		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
 						: "unknown");
 }
+
+void do_barrier_nospec_fixups(bool enable)
+{
+	unsigned int instr, *dest;
+	long *start, *end;
+	int i;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	instr = 0x60000000; /* nop */
+
+	if (enable) {
+		pr_info("barrier-nospec: using ORI speculation barrier\n");
+		instr = 0x63ff0000; /* ori 31,31,0 speculation barrier */
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)


