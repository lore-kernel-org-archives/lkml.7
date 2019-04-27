Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3E208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfD0KHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:07:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfD0KHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:07:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 847AFAD41;
        Sat, 27 Apr 2019 10:07:47 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 2/4] ftrace: drop 'static' qualifier from ftrace_ops_list_func()
Date:   Sat, 27 Apr 2019 12:06:37 +0200
Message-Id: <20190427100639.15074-3-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190427100639.15074-1-nstange@suse.de>
References: <20190427100639.15074-1-nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With an upcoming patch improving x86' ftrace_int3_handler() not to simply
skip over the insn being updated, ftrace_ops_list_func() will have to get
referenced from arch/x86 code. Drop its 'static' qualifier.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/trace/ftrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b920358dd8f7..ed3c20811d9a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -125,8 +125,8 @@ ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 struct ftrace_ops global_ops;
 
 #if ARCH_SUPPORTS_FTRACE_OPS
-static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct pt_regs *regs);
+void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
+			  struct ftrace_ops *op, struct pt_regs *regs);
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
@@ -6302,8 +6302,8 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
  * set the ARCH_SUPPORTS_FTRACE_OPS.
  */
 #if ARCH_SUPPORTS_FTRACE_OPS
-static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct pt_regs *regs)
+void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
+			  struct ftrace_ops *op, struct pt_regs *regs)
 {
 	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
 }
-- 
2.13.7

