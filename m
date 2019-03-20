Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73336C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3442184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ExE5tP7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCTISE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:18:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCTISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:18:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id u68so1163650lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siP39SFJ8UOjZv5/fRFAasm28Vpi2DbwWeM9YLtISs4=;
        b=ExE5tP7fHiUklXNMVdmE3HmLyStsHG2u6GsLXginSp61ryMxFqAo8MUy0ez+a1Odyn
         CF6hAAH8imCWIy4EQ/V/TBOgJCSq9vAOI3wD7Xw+M35kl4ZTsL3Zo/5Ah86PYBFz+v6z
         1MnUvueZBolynmkRnBdOXeddbKN9NZD1vcZiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siP39SFJ8UOjZv5/fRFAasm28Vpi2DbwWeM9YLtISs4=;
        b=nNU0b+BaSrZJ5W3xfKvBbIVf+PlKd1kAKtA0mRGlYz0ZUDXO9SaU3ZVfNjUOm1rjtp
         njXBuLnkmtFqHFygNserxNo3s5eRGXW3XOPSq0D8bBXzdmzQv2WyMmCYqBYEx+j8f8MA
         Eu/0++6YHbT+ul1Lp0FVSa1bJTc/eZlwdaDtCaBmlK259pf81Vtu+MzMPNI3OF7K22Vt
         ykSHmKRXyXhXVN63R6CUsAZRV2CQxAjbkJNKboFwtuszTBzo0KpfCN0B5MsGyqK5R/PE
         mFL6/Ym4HkPKMq1T/u+NpdPqZCzO7iAjhUf+9aOur0UA2RTybpYm5InA5eU8aesFxPbj
         dQ6w==
X-Gm-Message-State: APjAAAW7Oq0MMhXDiQ9kRAsvBmVF8puH88A6jk9FedX/gHyr+gQQ8+jS
        tHA9zkW0cYj/+1K2eA2E38wgDQ==
X-Google-Smtp-Source: APXvYqw//N9a92XO0MPOmxiyqug/stJkVRnFMbb6LqBsbgH1o8vZJr7h4VtNn0o11rAMoNkOY6ysgg==
X-Received: by 2002:a19:c314:: with SMTP id t20mr15491043lff.114.1553069880916;
        Wed, 20 Mar 2019 01:18:00 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y1sm223019ljj.13.2019.03.20.01.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:18:00 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: eliminate const char[] auto variables
Date:   Wed, 20 Mar 2019 09:17:57 +0100
Message-Id: <20190320081757.6037-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318213427.22108-1-linux@rasmusvillemoes.dk>
References: <20190318213427.22108-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I played around with various versions using field width, but the use
of tgid-dependent strings in the last two cases made gcc keep
iffyfying the whole thing. So I came up with this instead.

 kernel/trace/ftrace.c |  2 +-
 kernel/trace/trace.c  | 34 +++++++++++++---------------------
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fa79323331b2..e232dd31cfae 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3879,7 +3879,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
-	const char this_mod[] = "__this_module";
+	static const char this_mod[] = "__this_module";
 	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 21153e64bf1c..b869e5a0dc79 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3556,25 +3556,18 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
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
@@ -6304,13 +6297,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
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
@@ -6342,7 +6335,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
 		written = -EFAULT;
 	} else
@@ -6383,7 +6376,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	struct raw_data_entry *entry;
-	const char faulted[] = "<faulted>";
 	unsigned long irq_flags;
 	ssize_t written;
 	int size;
@@ -6423,7 +6415,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
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

