Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D2F206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139317;
	bh=fwffPyjJMQvBJRDJNo15JY3dly8GjAKOrasSNvHipjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JxoaETpJaiX8CH+GOTzeGD7LsyZM0w50lXmM7VKnss86ynifi2qxxl0UHEe5Zx1fn
	 gJFU70weaYFBtZF+u2/LOPISL6AoiMw5HEO2wYHegM3RvtjmRSpMxBR9yfBbsHq2kK
	 Rk+KNDW6h0d0ePYLYMhzp6tare1dd3JfKljwBSxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfDARV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731248AbfDARVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A12206DD;
        Mon,  1 Apr 2019 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139313;
        bh=fwffPyjJMQvBJRDJNo15JY3dly8GjAKOrasSNvHipjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtTo5+2i/fZnSOD2b1SRC3hfsYMj89/sFfegouNNh/Fgy2xCvnHyKJKcfrK/QNy+w
         /XUdQ1A51Ku01ah6bi9uxrumE3pVmD08vnBuZg3gQSaevL+CLXfn1T9Mx2/EPqhY/r
         Rgarli3LvOoneRrUwDxRgaqowVlRzXIFniCnfhRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 038/107] powerpc/asm: Add a patch_site macro & helpers for patching instructions
Date:   Mon,  1 Apr 2019 19:01:53 +0200
Message-Id: <20190401170049.100213074@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit 06d0bbc6d0f56dacac3a79900e9a9a0d5972d818 upstream.

Add a macro and some helper C functions for patching single asm
instructions.

The gas macro means we can do something like:

  1:	nop
  	patch_site 1b, patch__foo

Which is less visually distracting than defining a GLOBAL symbol at 1,
and also doesn't pollute the symbol table which can confuse eg. perf.

These are obviously similar to our existing feature sections, but are
not automatically patched based on CPU/MMU features, rather they are
designed to be manually patched by C code at some arbitrary point.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/code-patching-asm.h |   18 ++++++++++++++++++
 arch/powerpc/include/asm/code-patching.h     |    2 ++
 arch/powerpc/lib/code-patching.c             |   16 ++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/powerpc/include/asm/code-patching-asm.h

--- /dev/null
+++ b/arch/powerpc/include/asm/code-patching-asm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+#ifndef _ASM_POWERPC_CODE_PATCHING_ASM_H
+#define _ASM_POWERPC_CODE_PATCHING_ASM_H
+
+/* Define a "site" that can be patched */
+.macro patch_site label name
+	.pushsection ".rodata"
+	.balign 4
+	.global \name
+\name:
+	.4byte	\label - .
+	.popsection
+.endm
+
+#endif /* _ASM_POWERPC_CODE_PATCHING_ASM_H */
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -32,6 +32,8 @@ unsigned int create_cond_branch(const un
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
 int raw_patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_instruction_site(s32 *addr, unsigned int instr);
+int patch_branch_site(s32 *site, unsigned long target, int flags);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -206,6 +206,22 @@ int patch_branch(unsigned int *addr, uns
 	return patch_instruction(addr, create_branch(addr, target, flags));
 }
 
+int patch_branch_site(s32 *site, unsigned long target, int flags)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, create_branch(addr, target, flags));
+}
+
+int patch_instruction_site(s32 *site, unsigned int instr)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, instr);
+}
+
 bool is_offset_in_branch_range(long offset)
 {
 	/*


