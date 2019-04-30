Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26FEC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F0020652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LqKjHjvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfD3QGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:06:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:06:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UG4HHU1441025
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 09:04:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UG4HHU1441025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556640258;
        bh=/rjmcgFmgp4FJfF1KZLJ/O634csf05g/DF0ZHvo/3Aw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LqKjHjvI9ZE0Z6Zo6I2Ss66PDpeEx8oCSTmoHtt9L0OGtDkUxt6yVtpaV9IK76AB+
         GQ3mPLV4kEzW0KMeuZCHTbsW2+mGcG9vNdDoIzqjh0XkzU9NJ00afWlUObTRN3zRvN
         9yXnlbOtSBo5dBytt0V8sUXa+ICxgyp2HAaFv4k2887RvTa9UAOEHlngbx4kSgiw8H
         BSVIvCA47nYhQgahBPcsqIhuQDPto7NupmH9eLdCX3Op98qY8DuxV0NSSN01y+BkMI
         xB7p6d3s5O5/euGWo4sSUhyyrdTTwCNpOT9AcOnmXRP/0ga9R+NF3HJqFnpGB39kWj
         6W8CE+aL1o+RQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UG4FHa1441014;
        Tue, 30 Apr 2019 09:04:15 -0700
Date:   Tue, 30 Apr 2019 09:04:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gary Hook <tipbot@zytor.com>
Message-ID: <tip-b51ce3744f115850166f3d6c292b9c8cb849ad4f@git.kernel.org>
Cc:     bigeasy@linutronix.de, andriy.shevchenko@linux.intel.com,
        tglx@linutronix.de, kent.overstreet@gmail.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        lirongqing@baidu.com, bp@suse.de, colyli@suse.de, mingo@redhat.com,
        bbrezillon@kernel.org, Gary.Hook@amd.com, luto@kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, gary.hook@amd.com,
        mingo@kernel.org, keescook@chromium.org,
        alexander.shishkin@linux.intel.com, yamada.masahiro@socionext.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, x86@kernel.org
Reply-To: mingo@redhat.com, colyli@suse.de, Gary.Hook@amd.com,
          bbrezillon@kernel.org, lirongqing@baidu.com,
          dave.hansen@linux.intel.com, peterz@infradead.org, bp@suse.de,
          tglx@linutronix.de, kent.overstreet@gmail.com,
          andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org, x86@kernel.org,
          alexander.shishkin@linux.intel.com,
          yamada.masahiro@socionext.com, hpa@zytor.com, mingo@kernel.org,
          keescook@chromium.org, willy@infradead.org,
          akpm@linux-foundation.org, luto@kernel.org, gary.hook@amd.com
In-Reply-To: <155657657552.7116.18363762932464011367.stgit@sosrh3.amd.com>
References: <155657657552.7116.18363762932464011367.stgit@sosrh3.amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/mem_encrypt: Disable all instrumentation
 for early SME setup
Git-Commit-ID: b51ce3744f115850166f3d6c292b9c8cb849ad4f
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

Commit-ID:  b51ce3744f115850166f3d6c292b9c8cb849ad4f
Gitweb:     https://git.kernel.org/tip/b51ce3744f115850166f3d6c292b9c8cb849ad4f
Author:     Gary Hook <Gary.Hook@amd.com>
AuthorDate: Mon, 29 Apr 2019 22:22:58 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 30 Apr 2019 17:59:08 +0200

x86/mm/mem_encrypt: Disable all instrumentation for early SME setup

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
---
 arch/x86/lib/Makefile | 12 ++++++++++++
 lib/Makefile          | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a07..3cb3af51ec89 100644
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
index 3b08673e8881..18c2be516ab4 100644
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
