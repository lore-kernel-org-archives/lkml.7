Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D402218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfDJLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59039 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbfDJLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:25 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3f-0005HJ-0S; Wed, 10 Apr 2019 13:06:23 +0200
Message-Id: <20190410103647.294241460@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 41/41] lib/stackdepot: Remove obsolete functions
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users of the struct stack_trace based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/stackdepot.h |    4 ----
 lib/stackdepot.c           |   20 --------------------
 2 files changed, 24 deletions(-)

--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -23,13 +23,9 @@
 
 typedef u32 depot_stack_handle_t;
 
-struct stack_trace;
-
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t flags);
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace);
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -212,14 +212,6 @@ unsigned int stack_depot_fetch(depot_sta
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
-{
-	unsigned int nent = stack_depot_fetch(handle, &trace->entries);
-
-	trace->max_entries = trace->nr_entries = nent;
-}
-EXPORT_SYMBOL_GPL(depot_fetch_stack);
-
 /**
  * stack_depot_save - Save a stack trace from an array
  *
@@ -314,15 +306,3 @@ depot_stack_handle_t stack_depot_save(un
 	return retval;
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
-
-/**
- * depot_save_stack - save stack in a stack depot.
- * @trace - the stacktrace to save.
- * @alloc_flags - flags for allocating additional memory if required.
- */
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
-				      gfp_t alloc_flags)
-{
-	return stack_depot_save(trace->entries, trace->nr_entries, alloc_flags);
-}
-EXPORT_SYMBOL_GPL(depot_save_stack);


