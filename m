Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA76218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353902;
	bh=tkvAW89GK7drc5vQY5yCy4q7yluyQUsa649zRA4ciEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjA1AsErX0DX2yNFr2GwuypSsyxV4fatBct6zGPCuG51ifzLz2C5KS4VyUe+6Qwgv
	 SO743vJxTGNpEVs9exMf5r9nGcqHx+AFW0ubj3gBf0Yq8TjbrxxuidLyqIPxAnByBw
	 Kv2IF1uP+IB/MceOqeYmHt6toVNJZuxUT+LGWI8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfDOSpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfDOSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:44:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB662218D3;
        Mon, 15 Apr 2019 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353897;
        bh=tkvAW89GK7drc5vQY5yCy4q7yluyQUsa649zRA4ciEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZXEDJzCEMBD2M4VN9jNm9CcLvItBh/Z7+lBQ2XJV9WLXQDpec0dqgO6w+vWsSus0
         r78bRLZiWl3xqpEewawQrgoDpbv5epfAzDceY4F4FNDM5fV+Et9OOCGXGfWW0LwIBs
         2KtE4GDrpL19bN7m1cP9X+Pesre+UZzQjqxS55y8=
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
Subject: [PATCH 4.9 02/76] x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
Date:   Mon, 15 Apr 2019 20:43:26 +0200
Message-Id: <20190415183708.245258644@linuxfoundation.org>
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
index 2bd96b4df140..ab899e5f3a85 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -29,8 +29,7 @@ struct saved_context {
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
index 73063dfed476..ec923a1cdaf0 100644
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
@@ -215,12 +211,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
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



