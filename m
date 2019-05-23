Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47113C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4D221850
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639499;
	bh=cLLt/rInlk/yS1RnHy6KiOCgBywX0s/xE3MlAWS9mKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RP1Wvq4SM8JswPfJcYHB+GxD54YsMFPPT5XgpALg8+yO+WVB3/8imj8roOvadfzSP
	 B5wdltSFBYgxM3BoaUbAcBvXxmhdHJRcXfhiNMm1jgzEN3o9Dr49FQlmtDmgP7+SVb
	 y4xmO7MrbfNNmfwlfc+akV+HmU29DGWoL/YZWQHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbfEWTY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391016AbfEWTYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:24:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4009920868;
        Thu, 23 May 2019 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639494;
        bh=cLLt/rInlk/yS1RnHy6KiOCgBywX0s/xE3MlAWS9mKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoE6keBiJuXJbGi9nwr5kuWZ4EtHODzPOAr+sKn+01X8m9Nh/dOg1nlAFplZ3B5oP
         9+1g+jL3WtXWfc5sK4Jrym0jINW/b94Rz7eSdI2KS6maQqQUe+nqiBM3odWSebYft8
         v+r/YMRC3ThbRs5H4+Ev+LSJZIAtfvg5yb2FX2QY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Gary R Hook <gary.hook@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Coly Li <colyli@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthew Wilcox <willy@infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 126/139] x86/mm/mem_encrypt: Disable all instrumentation for early SME setup
Date:   Thu, 23 May 2019 21:06:54 +0200
Message-Id: <20190523181735.737390919@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b51ce3744f115850166f3d6c292b9c8cb849ad4f ]

Enablement of AMD's Secure Memory Encryption feature is determined very
early after start_kernel() is entered. Part of this procedure involves
scanning the command line for the parameter 'mem_encrypt'.

To determine intended state, the function sme_enable() uses library
functions cmdline_find_option() and strncmp(). Their use occurs early
enough such that it cannot be assumed that any instrumentation subsystem
is initialized.

For example, making calls to a KASAN-instrumented function before KASAN
is set up will result in the use of uninitialized memory and a boot
failure.

When AMD's SME support is enabled, conditionally disable instrumentation
of these dependent functions in lib/string.c and arch/x86/lib/cmdline.c.

 [ bp: Get rid of intermediary nostackp var and cleanup whitespace. ]

Fixes: aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encryption")
Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Coly Li <colyli@suse.de>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: "luto@kernel.org" <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/155657657552.7116.18363762932464011367.stgit@sosrh3.amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/Makefile | 12 ++++++++++++
 lib/Makefile          | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a079..3cb3af51ec897 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,6 +6,18 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
+# Early boot use of cmdline; don't instrument it
+ifdef CONFIG_AMD_MEM_ENCRYPT
+KCOV_INSTRUMENT_cmdline.o := n
+KASAN_SANITIZE_cmdline.o  := n
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_cmdline.o = -pg
+endif
+
+CFLAGS_cmdline.o := $(call cc-option, -fno-stack-protector)
+endif
+
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da714186..d1f312096bec5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -17,6 +17,17 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 
+# Early boot use of cmdline, don't instrument it
+ifdef CONFIG_AMD_MEM_ENCRYPT
+KASAN_SANITIZE_string.o := n
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_string.o = -pg
+endif
+
+CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
+endif
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o int_sqrt.o extable.o \
-- 
2.20.1



