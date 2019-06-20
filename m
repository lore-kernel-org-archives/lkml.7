Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047DC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEC82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hk27VAAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfFTKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:00:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFTKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:00:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5K9wH5f906576
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 02:58:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5K9wH5f906576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024698;
        bh=8gIP6uyAeZBecJEWAZebwYMMjCbnoUAO9/4qg9zM7es=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hk27VAAk61/B/X6uJaj0JwYWyfs1U0n1fwggOVdnnEWF3s6XJs1jtXRkF3EH6Ymw1
         kRYMDmwmRtqg6aDcVdCrWoFrEnqXkjA7Kk+WE3EtEgukYGn3grCAzexKRtHm2Oo/SK
         OC6iHr5e1n+ua0mGginBhN1Lfa2AOlHz6AMONvtdi9IuJHqSTCEg4917gETCrU6yhW
         4wo7vo5aHv53/5nAKUA40UYXjLvP8sfDkVlhlGDVlUTD+5SOaVD5vFHRDqo1y9QEGl
         RBiyoVBbogqLEWmqumSTGIyT7fP75zv9PvdCsJJ9QUV2OucRUKb5sK/aHu3fWbGN/m
         pIEV2uXQoYt0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5K9wG4G906572;
        Thu, 20 Jun 2019 02:58:16 -0700
Date:   Thu, 20 Jun 2019 02:58:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Lendacky <tipbot@zytor.com>
Message-ID: <tip-c603a309cc75f3dd018ddb20ee44c05047918cbf@git.kernel.org>
Cc:     dave.hansen@intel.com, keescook@chromium.org,
        ndesaulniers@google.com, luto@kernel.org, samitolvanen@google.com,
        mingo@redhat.com, dyoung@redhat.com, x86@kernel.org,
        Thomas.Lendacky@amd.com, hpa@zytor.com, brijesh.singh@amd.com,
        okaya@codeaurora.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, lijiang@redhat.com,
        rrichter@marvell.com, pasha.tatashin@oracle.com,
        peterz@infradead.org, bp@suse.de, jroedel@suse.de, bhe@redhat.com,
        tglx@linutronix.de, thomas.lendacky@amd.com
Reply-To: jgross@suse.com, linux-kernel@vger.kernel.org,
          brijesh.singh@amd.com, okaya@codeaurora.org, x86@kernel.org,
          hpa@zytor.com, Thomas.Lendacky@amd.com, mingo@kernel.org,
          lijiang@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
          bhe@redhat.com, jroedel@suse.de, peterz@infradead.org,
          bp@suse.de, rrichter@marvell.com, pasha.tatashin@oracle.com,
          dave.hansen@intel.com, luto@kernel.org, ndesaulniers@google.com,
          keescook@chromium.org, dyoung@redhat.com, mingo@redhat.com,
          samitolvanen@google.com
In-Reply-To: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/mm: Identify the end of the kernel area to be
 reserved
Git-Commit-ID: c603a309cc75f3dd018ddb20ee44c05047918cbf
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

Commit-ID:  c603a309cc75f3dd018ddb20ee44c05047918cbf
Gitweb:     https://git.kernel.org/tip/c603a309cc75f3dd018ddb20ee44c05047918cbf
Author:     Thomas Lendacky <Thomas.Lendacky@amd.com>
AuthorDate: Wed, 19 Jun 2019 18:40:57 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 09:22:47 +0200

x86/mm: Identify the end of the kernel area to be reserved

The memory occupied by the kernel is reserved using memblock_reserve()
in setup_arch(). Currently, the area is from symbols _text to __bss_stop.
Everything after __bss_stop must be specifically reserved otherwise it
is discarded. This is not clearly documented.

Add a new symbol, __end_of_kernel_reserve, that more readily identifies
what is reserved, along with comments that indicate what is reserved,
what is discarded and what needs to be done to prevent a section from
being discarded.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Lianbo Jiang <lijiang@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sections.h | 2 ++
 arch/x86/kernel/setup.c         | 8 +++++++-
 arch/x86/kernel/vmlinux.lds.S   | 9 ++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 8ea1cfdbeabc..71b32f2570ab 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -13,4 +13,6 @@ extern char __end_rodata_aligned[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+extern char __end_of_kernel_reserve[];
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 08a5f4a131f5..dac60ad37e5e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -827,8 +827,14 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 
 void __init setup_arch(char **cmdline_p)
 {
+	/*
+	 * Reserve the memory occupied by the kernel between _text and
+	 * __end_of_kernel_reserve symbols. Any kernel sections after the
+	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
+	 * separate memblock_reserve() or they will be discarded.
+	 */
 	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__bss_stop - (unsigned long)_text);
+			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
 	 * Make sure page 0 is always reserved because on systems with
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0850b5149345..ca2252ca6ad7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -368,6 +368,14 @@ SECTIONS
 		__bss_stop = .;
 	}
 
+	/*
+	 * The memory occupied from _text to here, __end_of_kernel_reserve, is
+	 * automatically reserved in setup_arch(). Anything after here must be
+	 * explicitly reserved using memblock_reserve() or it will be discarded
+	 * and treated as available memory.
+	 */
+	__end_of_kernel_reserve = .;
+
 	. = ALIGN(PAGE_SIZE);
 	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
@@ -382,7 +390,6 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 
-	/* Sections to be discarded */
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
