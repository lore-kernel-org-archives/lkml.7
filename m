Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF6EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE00F21915
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfDJLFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:05:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbfDJLFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:51 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB36-00056R-JS; Wed, 10 Apr 2019 13:05:48 +0200
Message-Id: <20190410103645.136887071@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 17/41] tracing: Make stack_trace_print() static and rename
 it
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in the source file where it is defined and it's using the
stack_trace_ namespace. Rename it to free it up for stack trace related
functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h     |    1 -
 kernel/trace/trace_stack.c |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -251,7 +251,6 @@ extern unsigned long stack_trace_max_siz
 extern arch_spinlock_t stack_trace_max_lock;
 
 extern int stack_tracer_enabled;
-void stack_trace_print(void);
 int
 stack_trace_sysctl(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp,
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -41,7 +41,7 @@ static DEFINE_MUTEX(stack_sysctl_mutex);
 int stack_tracer_enabled;
 static int last_stack_tracer_enabled;
 
-void stack_trace_print(void)
+static void trace_stack_trace_print(void)
 {
 	long i;
 	int size;
@@ -179,7 +179,7 @@ check_stack(unsigned long ip, unsigned l
 	stack_trace_max.nr_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
-		stack_trace_print();
+		trace_stack_trace_print();
 		BUG();
 	}
 


