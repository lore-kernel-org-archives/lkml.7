Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AAE20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Su8N9cqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCRVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:34:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38952 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:34:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so14829811edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hxn8bhL6i6OeFd+VonfuZwY+0TgW0yjYTmapufycG6g=;
        b=Su8N9cqyfF4F2xKnxJWuHWrFL5YNdNpX6S4VddJVVOtvvaROKyrUOIfOWI68dmfeGS
         EwT9mQ3vI1Zro3tyZdk+h2E3p1j/QXzDcdcIZOesg19RfdojmkqHHbNu96qCN3sT2rjb
         axJqkUJV4/+ga/P7pe/z4TjUg7pRGtixmIcaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hxn8bhL6i6OeFd+VonfuZwY+0TgW0yjYTmapufycG6g=;
        b=h0CO9UFsLwiJNm4JR9BsRw6EYzt35AjLrvIJ9DGobOA4AubT6YHcodM1/nO7jM36gt
         0ehavXwUtNWtLr4J5g40Yj0J6yuAkn0mdVeVEFn0qDiLBJSKx07Vsej2VeF79zSPRtMh
         KjL+WnaiT8gE9l+lCh7hKb7Q1Eo5iv/VAw7EKSUfhscjSiGgTitEcPyv+EKxziEfc+Yg
         EKStQVAczKovsc42XlklxAp9hsrQjESJNVtGyyegAl/fM67fMp0TVUFvwJ7vhdtp0EA/
         n1Vir9sS0FDWTm7JBE5DtHyfBhdnt6vAVD+IJ/zLT28jotQFak/dViEjusxBH8ac9AcI
         RIRA==
X-Gm-Message-State: APjAAAUOC+4brEEMSwVqP6A/zhcJ77GNTpSLuhST05RwF5CP7Hkt/ErM
        +C6s34j2kz5ZnlDFW2g5W+vOUA==
X-Google-Smtp-Source: APXvYqz1CxuhpHEbtFJg2rzZXtS8VV7/oWc2iYuLu7StbDOf6ibJiqukHyPdr/hJvQ63lNzUdpaRXQ==
X-Received: by 2002:a17:906:a291:: with SMTP id i17mr12251877ejz.180.1552944881406;
        Mon, 18 Mar 2019 14:34:41 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-117-200.cgn.fibianet.dk. [5.186.117.200])
        by smtp.gmail.com with ESMTPSA id d17sm2639629ejm.35.2019.03.18.14.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:34:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2/resend] tracing: eliminate const char[] auto variables
Date:   Mon, 18 Mar 2019 22:34:27 +0100
Message-Id: <20190318213427.22108-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181102205442.7758-1-linux@rasmusvillemoes.dk>
References: <20181102205442.7758-1-linux@rasmusvillemoes.dk>
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

Finally, for the two runs of spaces, just use variables initialized with
string literals; the linker (at least for x86) will reuse the tail of
the longer for the shorter string.

x86-64 defconfig + CONFIG_FUNCTION_TRACER:

$ scripts/stackdelta /tmp/stackusage.{0,1}
./kernel/trace/ftrace.c ftrace_mod_callback     152     136     -16
./kernel/trace/trace.c  trace_default_header    56      32      -24
./kernel/trace/trace.c  tracing_mark_raw_write  96      72      -24
./kernel/trace/trace.c  tracing_mark_write      104     80      -24

bloat-o-meter

add/remove: 1/0 grow/shrink: 0/4 up/down: 14/-258 (-244)
Function                                     old     new   delta
this_mod                                       -      14     +14
ftrace_mod_callback                          577     542     -35
tracing_mark_raw_write                       444     374     -70
tracing_mark_write                           616     540     -76
trace_default_header                         600     523     -77

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Hi Steven

I didn't get any response to this; just let me know if you don't want
this kind of microoptimization patches.

v2: update change log with stack and code delta info.

 kernel/trace/ftrace.c |  2 +-
 kernel/trace/trace.c  | 13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

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
index 21153e64bf1c..a7f7d141c902 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3556,8 +3556,8 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char tgid_space[] = "          ";
-	const char space[] = "  ";
+	const char *tgid_space = "          ";
+	const char *space = "  ";
 
 	print_event_info(buf, m);
 
@@ -6304,13 +6304,13 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
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
@@ -6342,7 +6342,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
-		memcpy(&entry->buf, faulted, FAULTED_SIZE);
+		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
 		written = -EFAULT;
 	} else
@@ -6383,7 +6383,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	struct raw_data_entry *entry;
-	const char faulted[] = "<faulted>";
 	unsigned long irq_flags;
 	ssize_t written;
 	int size;
@@ -6423,7 +6422,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
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

