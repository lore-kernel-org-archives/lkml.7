Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0631EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBACC21744
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfEHUZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfEHUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B42217D8;
        Wed,  8 May 2019 20:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7V-0007iG-34; Wed, 08 May 2019 16:24:53 -0400
Message-Id: <20190508202452.984537761@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [for-next][PATCH 08/13] tracing: Eliminate const char[] auto variables
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Automatic const char[] variables cause unnecessary code
generation. For example, the this_mod variable leads to

    3f04:       48 b8 5f 5f 74 68 69 73 5f 6d   movabs $0x6d5f736968745f5f,%rax # __this_m
    3f0e:       4c 8d 44 24 02                  lea    0x2(%rsp),%r8
    3f13:       48 8d 7c 24 10                  lea    0x10(%rsp),%rdi
    3f18:       48 89 44 24 02                  mov    %rax,0x2(%rsp)
    3f1d:       4c 89 e9                        mov    %r13,%rcx
    3f20:       b8 65 00 00 00                  mov    $0x65,%eax # e
    3f25:       48 c7 c2 00 00 00 00            mov    $0x0,%rdx
                        3f28: R_X86_64_32S      .rodata.str1.1+0x18d
    3f2c:       be 48 00 00 00                  mov    $0x48,%esi
    3f31:       c7 44 24 0a 6f 64 75 6c         movl   $0x6c75646f,0xa(%rsp) # odul
    3f39:       66 89 44 24 0e                  mov    %ax,0xe(%rsp)

i.e., the string gets built on the stack at runtime. Similar code can be
found for the other instances I'm replacing here. Putting the string
in .rodata reduces the combined .text+.rodata size and saves time and
stack space at runtime.

The simplest fix, and what I've done for the this_mod case, is to just
make the variable static.

However, for the "<faulted>" case where the same string is used twice,
that prevents the linker from merging those two literals, so instead use
a macro - that also keeps the two instances automatically in
sync (instead of only the compile-time strlen expression).

Finally, for the two runs of spaces, it turns out that the "build
these strings on the stack" is not the worst part of what gcc does -
it turns print_func_help_header_irq() into "if (tgid) { /*
print_event_info + five seq_printf calls */ } else { /* print
event_info + another five seq_printf */}". Taking inspiration from a
suggestion from Al Viro, use %.*s to make snprintf either stop after
the first two spaces or print the whole string. As a bonus, the
seq_printfs now fit on single lines (at least, they are not longer
than the existing ones in the function just above), making it easier
to see that the ascii art lines up.

x86-64 defconfig + CONFIG_FUNCTION_TRACER:

$ scripts/stackdelta /tmp/stackusage.{0,1}
./kernel/trace/ftrace.c ftrace_mod_callback     152     136     -16
./kernel/trace/trace.c  trace_default_header    56      32      -24
./kernel/trace/trace.c  tracing_mark_raw_write  96      72      -24
./kernel/trace/trace.c  tracing_mark_write      104     80      -24

bloat-o-meter

add/remove: 1/0 grow/shrink: 0/4 up/down: 14/-375 (-361)
Function                                     old     new   delta
this_mod                                       -      14     +14
ftrace_mod_callback                          577     542     -35
tracing_mark_raw_write                       444     374     -70
tracing_mark_write                           616     540     -76
trace_default_header                         600     406    -194

Link: http://lkml.kernel.org/r/20190320081757.6037-1-linux@rasmusvillemoes.dk

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c |  2 +-
 kernel/trace/trace.c  | 34 +++++++++++++---------------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 433a64f49532..7765a53f1006 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3875,7 +3875,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
-	const char this_mod[] = "__this_module";
+	static const char this_mod[] = "__this_module";
 	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dcb9adb44be9..3259019cc66d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3593,25 +3593,18 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char tgid_space[] = "          ";
-	const char space[] = "  ";
+	const char *space = "          ";
+	int prec = tgid ? 10 : 2;
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
-		   tgid ? tgid_space : space);
-	seq_printf(m, "#                          %s / _----=> need-resched\n",
-		   tgid ? tgid_space : space);
-	seq_printf(m, "#                          %s| / _---=> hardirq/softirq\n",
-		   tgid ? tgid_space : space);
-	seq_printf(m, "#                          %s|| / _--=> preempt-depth\n",
-		   tgid ? tgid_space : space);
-	seq_printf(m, "#                          %s||| /     delay\n",
-		   tgid ? tgid_space : space);
-	seq_printf(m, "#           TASK-PID %sCPU#  ||||    TIMESTAMP  FUNCTION\n",
-		   tgid ? "   TGID   " : space);
-	seq_printf(m, "#              | |   %s  |   ||||       |         |\n",
-		   tgid ? "     |    " : space);
+	seq_printf(m, "#                          %.*s  _-----=> irqs-off\n", prec, space);
+	seq_printf(m, "#                          %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                          %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                          %.*s|| / _--=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                          %.*s||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID %.*sCPU#  ||||    TIMESTAMP  FUNCTION\n", prec, "   TGID   ");
+	seq_printf(m, "#              | |   %.*s  |   ||||       |         |\n", prec, "     |    ");
 }
 
 void
@@ -6342,13 +6335,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer *buffer;
 	struct print_entry *entry;
 	unsigned long irq_flags;
-	const char faulted[] = "<faulted>";
 	ssize_t written;
 	int size;
 	int len;
 
 /* Used in tracing_mark_raw_write() as well */
-#define FAULTED_SIZE (sizeof(faulted) - 1) /* '\0' is already accounted for */
+#define FAULTED_STR "<faulted>"
+#define FAULTED_SIZE (sizeof(FAULTED_STR) - 1) /* '\0' is already accounted for */
 
 	if (tracing_disabled)
 		return -EINVAL;
@@ -6380,7 +6373,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
 		written = -EFAULT;
 	} else
@@ -6421,7 +6414,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	struct raw_data_entry *entry;
-	const char faulted[] = "<faulted>";
 	unsigned long irq_flags;
 	ssize_t written;
 	int size;
@@ -6461,7 +6453,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		written = -EFAULT;
 	} else
 		written = cnt;
-- 
2.20.1


