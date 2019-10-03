Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEF217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfJCJwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:52:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbfJCJwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:52:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64FB8B119;
        Thu,  3 Oct 2019 09:52:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] x86/asm: Reorder early variables
Date:   Thu,  3 Oct 2019 11:52:37 +0200
Message-Id: <20191003095238.29831-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving early_recursion_flag (4 bytes) after early_level4_pgt (4k) and
early_dynamic_pgts (256k) saves 4k which are used for alignment of
early_level4_pgt after early_recursion_flag.

The real improvement is merely on the source code side. Previously it
was:
* __INITDATA + .balign
* early_recursion_flag variable
* a ton of CPP MACROS
* __INITDATA (again)
* early_top_pgt and early_recursion_flag variables
* .data

Now, it is a bit simpler:
* a ton of CPP MACROS
* __INITDATA + .balign
* early_top_pgt and early_recursion_flag variables
* early_recursion_flag variable
* .data

On the binary level the change looks like this:
Before:
 (sections)
  12 .init.data    00042000  0000000000000000  0000000000000000 00008000  2**12
 (symbols)
  000000       4 OBJECT  GLOBAL DEFAULT   22 early_recursion_flag
  001000    4096 OBJECT  GLOBAL DEFAULT   22 early_top_pgt
  002000 0x40000 OBJECT  GLOBAL DEFAULT   22 early_dynamic_pgts

After:
 (sections)
  12 .init.data    00041004  0000000000000000  0000000000000000 00008000  2**12
 (symbols)
  000000    4096 OBJECT  GLOBAL DEFAULT   22 early_top_pgt
  001000 0x40000 OBJECT  GLOBAL DEFAULT   22 early_dynamic_pgts
  041000       4 OBJECT  GLOBAL DEFAULT   22 early_recursion_flag

So the resulting vmlinux is smaller by 4k with my toolchain as many
other variables can be placed after early_recursion_flag to fill the
rest of the page. Note that this is only .init data, so it is freed
right after being booted anyway. Savings on-disk are none --
compression of zeros is easy, so the size of bzImage is the same pre and
post the change.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/head_64.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f3d3e9646a99..f00d7c0c1c86 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -335,12 +335,6 @@ early_idt_handler_common:
 	jmp restore_regs_and_return_to_kernel
 END(early_idt_handler_common)
 
-	__INITDATA
-
-	.balign 4
-GLOBAL(early_recursion_flag)
-	.long 0
-
 #define NEXT_PAGE(name) \
 	.balign	PAGE_SIZE; \
 GLOBAL(name)
@@ -375,6 +369,8 @@ GLOBAL(name)
 	.endr
 
 	__INITDATA
+	.balign 4
+
 NEXT_PGD_PAGE(early_top_pgt)
 	.fill	512,8,0
 	.fill	PTI_USER_PGD_FILL,8,0
@@ -382,6 +378,9 @@ NEXT_PGD_PAGE(early_top_pgt)
 NEXT_PAGE(early_dynamic_pgts)
 	.fill	512*EARLY_DYNAMIC_PAGE_TABLES,8,0
 
+GLOBAL(early_recursion_flag)
+	.long 0
+
 	.data
 
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
-- 
2.23.0

