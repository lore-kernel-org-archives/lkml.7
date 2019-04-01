Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7FE206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139425;
	bh=+9d5ZseOoMwxFiOAdxZ6Bo362qgmjPjxpclEmQX6md0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPV+Hpo5rmX+Zw74VMkyB0bF+v60FfO7jh41XtVZIsucqRDwVE0bJYfI6C3S77kFY
	 sA42iX4suSDzmiFr9vB0IPnMNoysceaD6izQl2IQ1Zs9J6as3EMgNK4O7iouhGz1S+
	 j7kGWI2BL6BHi75fnpkwIeja/goax9b9tn+4Pdms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfDARXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbfDARXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:23:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AABF206DD;
        Mon,  1 Apr 2019 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139419;
        bh=+9d5ZseOoMwxFiOAdxZ6Bo362qgmjPjxpclEmQX6md0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+qBl1QVxFvoR1HK+wvbp04yBFuMBE7wnrlF4Cn26XYyyBqxWWlDVxpG0BgTvEJ4i
         znCt0UMYUaAfMV1dZxR9d4aTavyBBXKdv6gR2uRZPo5EDq0gPUZbHBQdhX7ggXHtQ9
         aO6cm8MWLiKRZXkGoZ7I4DWKl7C1HCY6DJ7HEnKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 043/107] powerpc/fsl: Add infrastructure to fixup branch predictor flush
Date:   Mon,  1 Apr 2019 19:01:58 +0200
Message-Id: <20190401170049.547049830@linuxfoundation.org>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit 76a5eaa38b15dda92cd6964248c39b5a6f3a4e9d upstream.

In order to protect against speculation attacks (Spectre
variant 2) on NXP PowerPC platforms, the branch predictor
should be flushed when the privillege level is changed.
This patch is adding the infrastructure to fixup at runtime
the code sections that are performing the branch predictor flush
depending on a boot arg parameter which is added later in a
separate patch.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/feature-fixups.h |   12 ++++++++++++
 arch/powerpc/include/asm/setup.h          |    2 ++
 arch/powerpc/kernel/vmlinux.lds.S         |    8 ++++++++
 arch/powerpc/lib/feature-fixups.c         |   23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+)

--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -219,6 +219,17 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET 953b-954b;			\
 	.popsection;
 
+#define START_BTB_FLUSH_SECTION			\
+955:							\
+
+#define END_BTB_FLUSH_SECTION			\
+956:							\
+	.pushsection __btb_flush_fixup,"a";	\
+	.align 2;							\
+957:						\
+	FTR_ENTRY_OFFSET 955b-957b;			\
+	FTR_ENTRY_OFFSET 956b-957b;			\
+	.popsection;
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
@@ -228,6 +239,7 @@ extern long __start___stf_entry_barrier_
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
 extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
+extern long __start__btb_flush_fixup, __stop__btb_flush_fixup;
 
 void apply_feature_fixups(void);
 void setup_feature_keys(void);
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -66,6 +66,8 @@ void do_barrier_nospec_fixups_range(bool
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
 #endif
 
+void do_btb_flush_fixups(void);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -164,6 +164,14 @@ SECTIONS
 	}
 #endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	. = ALIGN(8);
+	__spec_btb_flush_fixup : AT(ADDR(__spec_btb_flush_fixup) - LOAD_OFFSET) {
+		__start__btb_flush_fixup = .;
+		*(__btb_flush_fixup)
+		__stop__btb_flush_fixup = .;
+	}
+#endif
 	EXCEPTION_TABLE(0)
 
 	NOTES :kernel :notes
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -347,6 +347,29 @@ void do_barrier_nospec_fixups_range(bool
 
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
+
+static void patch_btb_flush_section(long *curr)
+{
+	unsigned int *start, *end;
+
+	start = (void *)curr + *curr;
+	end = (void *)curr + *(curr + 1);
+	for (; start < end; start++) {
+		pr_devel("patching dest %lx\n", (unsigned long)start);
+		patch_instruction(start, PPC_INST_NOP);
+	}
+}
+
+void do_btb_flush_fixups(void)
+{
+	long *start, *end;
+
+	start = PTRRELOC(&__start__btb_flush_fixup);
+	end = PTRRELOC(&__stop__btb_flush_fixup);
+
+	for (; start < end; start += 2)
+		patch_btb_flush_section(start);
+}
 #endif /* CONFIG_PPC_FSL_BOOK3E */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)


