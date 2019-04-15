Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF1AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6A6218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354919;
	bh=22TtPF4sI/bKU7sJXPl65FvIav0uD7OoHgPmcST+5zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dv0Uy9tvm7RSZvwdGt7kWWv9u9ONGyfJgoZ2aOkRhOfsqpDB0vqH3HSvWdi39yChJ
	 Jvhsdt3NMiLyh4iFy8IyKcF3IJ/Yi6GuIZi8vuHM+EGYteJlTbyn/wUUR7n5Z3g8Uj
	 T3jtOFpme4tR+G06sWlBbadLV5ZkUPB+8UETQkrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfDOTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbfDOTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:01:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D883218D3;
        Mon, 15 Apr 2019 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354911;
        bh=22TtPF4sI/bKU7sJXPl65FvIav0uD7OoHgPmcST+5zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5+To+YgQP+hbYXCbqIKbzICol2W8qBxfQ7ozrm7G2O3PaCZhC+IWulprNQf0KSUz
         lojFvAtG+KpbShEpAt+OiBaZXZdgpxOqbCpVMNX+O/YBrBYIq6Z/RzNakifzti4pjv
         f0smS/2S2qAoNZBBp+NlhJjNZDsqPWioKTFq76XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/69] x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
Date:   Mon, 15 Apr 2019 20:58:21 +0200
Message-Id: <20190415183726.883542005@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 090edbe23ff57940fca7f57d9165ce57a826bd7a ]

x86_64's saved_context nonsensically used separate idt_limit and
idt_base fields and then cast &idt_limit to struct desc_ptr *.

This was correct (with -fno-strict-aliasing), but it's confusing,
served no purpose, and required #ifdeffery. Simplify this by
using struct desc_ptr directly.

No change in functionality.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/967909ce38d341b01d45eff53e278e2728a3a93a.1513286253.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/suspend_64.h |  3 +--
 arch/x86/power/cpu.c              | 11 +----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 7306e911faee..600e9e0aea51 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -30,8 +30,7 @@ struct saved_context {
 	u16 gdt_pad; /* Unused */
 	struct desc_ptr gdt_desc;
 	u16 idt_pad;
-	u16 idt_limit;
-	unsigned long idt_base;
+	struct desc_ptr idt;
 	u16 ldt;
 	u16 tss;
 	unsigned long tr;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index a51d2dfb57d1..cba2e2c3f89e 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -82,12 +82,8 @@ static void __save_processor_state(struct saved_context *ctxt)
 	/*
 	 * descriptor tables
 	 */
-#ifdef CONFIG_X86_32
 	store_idt(&ctxt->idt);
-#else
-/* CONFIG_X86_64 */
-	store_idt((struct desc_ptr *)&ctxt->idt_limit);
-#endif
+
 	/*
 	 * We save it here, but restore it only in the hibernate case.
 	 * For ACPI S3 resume, this is loaded via 'early_gdt_desc' in 64-bit
@@ -221,12 +217,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
-#ifdef CONFIG_X86_32
 	load_idt(&ctxt->idt);
-#else
-/* CONFIG_X86_64 */
-	load_idt((const struct desc_ptr *)&ctxt->idt_limit);
-#endif
 
 #ifdef CONFIG_X86_64
 	/*
-- 
2.19.1



