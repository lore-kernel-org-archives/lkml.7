Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C291C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A02070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfJGKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:41:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727252AbfJGKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:41:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3FC3B212;
        Mon,  7 Oct 2019 10:41:42 +0000 (UTC)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/stackframe/32: repair 32-bit Xen PV
Message-ID: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
Date:   Mon, 7 Oct 2019 12:41:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once again RPL checks have been introduced which don't account for a
32-bit kernel living in ring 1 when running in a PV Xen domain. The
case in FIXUP_FRAME has been preventing boot; adjust BUG_IF_WRONG_CR3
as well just in case.

Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -48,6 +48,17 @@
 
 #include "calling.h"
 
+#ifndef CONFIG_XEN_PV
+# define USER_SEGMENT_RPL_MASK SEGMENT_RPL_MASK
+#else
+/*
+ * When running paravirtualized on Xen the kernel runs in ring 1, and hence
+ * simple mask based tests (i.e. ones not comparing against USER_RPL) have to
+ * ignore bit 0. See also the C-level get_kernel_rpl().
+ */
+# define USER_SEGMENT_RPL_MASK (SEGMENT_RPL_MASK & ~1)
+#endif
+
 	.section .entry.text, "ax"
 
 /*
@@ -172,7 +183,7 @@
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 	.if \no_user_check == 0
 	/* coming from usermode? */
-	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, PT_CS(%esp)
 	jz	.Lend_\@
 	.endif
 	/* On user-cr3? */
@@ -217,7 +228,7 @@
 	testl	$X86_EFLAGS_VM, 4*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 #endif
-	testl	$SEGMENT_RPL_MASK, 3*4(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, 3*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 
 	orl	$CS_FROM_KERNEL, 3*4(%esp)
