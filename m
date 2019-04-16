Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783E420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfDPVHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:07:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:64442 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:07:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 14:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="143496351"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 16 Apr 2019 14:07:50 -0700
Subject: [PATCH] init: Initialize jump labels before command line option
 parsing
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <groeck@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
Date:   Tue, 16 Apr 2019 13:54:04 -0700
Message-ID: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a module option, or core kernel argument, toggles a static-key it
requires jump labels to be initialized early. While x86, PowerPC, and
ARM64 arrange for jump_label_init() to be called before parse_args(),
ARM does not.

  Kernel command line: rdinit=/sbin/init page_alloc.shuffle=1 panic=-1 console=ttyAMA0,115200 page_alloc.shuffle=1
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at ./include/linux/jump_label.h:303
  page_alloc_shuffle+0x12c/0x1ac
  static_key_enable(): static key 'page_alloc_shuffle_key+0x0/0x4' used
  before call to jump_label_init()
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted
  5.1.0-rc4-next-20190410-00003-g3367c36ce744 #1
  Hardware name: ARM Integrator/CP (Device Tree)
  [<c0011c68>] (unwind_backtrace) from [<c000ec48>] (show_stack+0x10/0x18)
  [<c000ec48>] (show_stack) from [<c07e9710>] (dump_stack+0x18/0x24)
  [<c07e9710>] (dump_stack) from [<c001bb1c>] (__warn+0xe0/0x108)
  [<c001bb1c>] (__warn) from [<c001bb88>] (warn_slowpath_fmt+0x44/0x6c)
  [<c001bb88>] (warn_slowpath_fmt) from [<c0b0c4a8>]
  (page_alloc_shuffle+0x12c/0x1ac)
  [<c0b0c4a8>] (page_alloc_shuffle) from [<c0b0c550>] (shuffle_store+0x28/0x48)
  [<c0b0c550>] (shuffle_store) from [<c003e6a0>] (parse_args+0x1f4/0x350)
  [<c003e6a0>] (parse_args) from [<c0ac3c00>] (start_kernel+0x1c0/0x488)

Move the fallback call to jump_label_init() to occur before
parse_args(). The redundant calls to jump_label_init() in other archs
are left intact in case they have static key toggling use cases that are
even earlier than option parsing.

Reported-by: Guenter Roeck <groeck@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 init/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 598e278b46f7..7d4025d665eb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -582,6 +582,8 @@ asmlinkage __visible void __init start_kernel(void)
 	page_alloc_init();
 
 	pr_notice("Kernel command line: %s\n", boot_command_line);
+	/* parameters may set static keys */
+	jump_label_init();
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
 				  static_command_line, __start___param,
@@ -591,8 +593,6 @@ asmlinkage __visible void __init start_kernel(void)
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
 
-	jump_label_init();
-
 	/*
 	 * These use large bootmem allocations and must precede
 	 * kmem_cache_init()

