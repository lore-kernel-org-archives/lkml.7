Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186182087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354251;
	bh=F6vAXa6hdCxPYF4uvKhz5OrXvmiM0aKK28VgnEqL+/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OD0Y++T9ritdr1a90FjqQCeli1Mw6vsiDnxf+sd69cG85dyeCB4uQrkMOlGUuvufx
	 SIl0q+rw0XKyBrlQuzaZA4ep2XUF1SdSEvyokdXG/S4oWGaegiIqzYfi8M1Dox8b0c
	 rwwxlQtPTULODbANBt2sY1peIuxPaWDUBQmp8I7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfDOSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfDOSqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1332087C;
        Mon, 15 Apr 2019 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353982;
        bh=F6vAXa6hdCxPYF4uvKhz5OrXvmiM0aKK28VgnEqL+/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pm7s115eFCUMWYBX3zlIamihij0InYGVfnSDUhcvyfTJix1xKpUnDJia31MzJ9F3L
         mgKXpZ4nwNenT2Gc69rGH+ROsEUWsQTjm31o07qoEHhzDlDZ9blaf1SpzcR3GvFSZl
         jOgqYd6bfvthi5Jc43WZK1wmRZJiTvcHYdQlPhTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/76] powerpc/asm: Add a patch_site macro & helpers for patching instructions
Date:   Mon, 15 Apr 2019 20:43:51 +0200
Message-Id: <20190415183714.994496321@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/code-patching-asm.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/code-patching.h     |  2 ++
 arch/powerpc/lib/code-patching.c             | 16 ++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/powerpc/include/asm/code-patching-asm.h

diff --git a/arch/powerpc/include/asm/code-patching-asm.h b/arch/powerpc/include/asm/code-patching-asm.h
new file mode 100644
index 000000000000..ed7b1448493a
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
diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index b4ab1f497335..ab934f8232bd 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -28,6 +28,8 @@ unsigned int create_cond_branch(const unsigned int *addr,
 				unsigned long target, int flags);
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_instruction_site(s32 *addr, unsigned int instr);
+int patch_branch_site(s32 *site, unsigned long target, int flags);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index c77c486fbf24..14535ad4cdd1 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -40,6 +40,22 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags)
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
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags)
 {
-- 
2.19.1



