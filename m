Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C349C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13196233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/b3RioC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfH1W4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:09 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51187 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfH1W4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:04 -0400
Received: by mail-vs1-f73.google.com with SMTP id w12so69822vsl.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ni9Z15V4bpyiJCDFN/QunD1NK4akeOXTvBvWzMWvbaw=;
        b=j/b3RioCgNl03gmcLdV5uQhb7+drpE5z7RZ5TEe94ITp7f0ZSQ4JkcmQ/bl4t2ehVf
         1wi3GM2h9kFt7L68RWO88p6Q5PtIhnV3HCEfc3LPPZHsosgTEj5jdefFk+Qyf2J5e6wX
         oli9igakxc1XLUbPINMnqOOTRlDdZfdgIga5IOpmMjEEm6q9/nPA7ACW3VbO1fsKndci
         PpdZSC+1lJBhNMFvjfTeVijKwOGvauVZdHsjMOSHBhqDSGRMjwNgeh7cM/Khj1UQsXdy
         n1yXgLmzOozfiRk67eV8hA7vlZpElNeuEoVLxQFdHmJlWeASzaL63zyNETJ5IBUtnJ5N
         UqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ni9Z15V4bpyiJCDFN/QunD1NK4akeOXTvBvWzMWvbaw=;
        b=cnwmnnvGneTWsXCGrbyPntaH9LEiCsmeG5NwjNA553Oq6SL7fUE/oZFnKyMC0eVvQM
         qk6PwliMVncofAiN862QbOAZ/UJ7kCn/VfpKQfEec6NbE2pzjf91hjcgQxBVXOhU21TY
         Lj9sfa6+qnyoc4eslsfPHJdFfZm4uU5ml0g4VW+nfy0xgkn8LJg53Fy2NoEiY4GOgA7l
         06Px7z9XD1mDxA93IryOrwPFmK0ed9sevswK/2Hl+/WSY8GYLnWAJw87CjAIRLMgGmo0
         5VSKYwzdX4ZfqL5FtHWLekpvSYopfLhVmQ4SoGrSpJkGNT8dhvNdS+qCEO3RX/OBmq1c
         QPYQ==
X-Gm-Message-State: APjAAAWJ842UteWphDPOds0/Is0s5/5Dncf7mBTv/IokEMMIv+tp+lhC
        v64/nR2wYLNxsmV08DzAE4gnfoK1U+QB/v1ix+c=
X-Google-Smtp-Source: APXvYqy+ghTcBhY1RzENygq02azuP9/muKWmZcQ9jOQovS/0K8hgrzb0/XswU9afLX1uVxdbHl5qkbUF9q/3L+cQjZI=
X-Received: by 2002:a1f:880c:: with SMTP id k12mr3650843vkd.71.1567032962908;
 Wed, 28 Aug 2019 15:56:02 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:23 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 02/14] include/linux/compiler.h: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This fixes an Oops observed in distro's that use systemd and not
net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Acked-by: Will Deacon <will@kernel.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f0fd5636fddb..5e88e7e33abe 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -24,7 +24,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			long ______r;					\
 			static struct ftrace_likely_data		\
 				__aligned(4)				\
-				__section("_ftrace_annotated_branch")	\
+				__section(_ftrace_annotated_branch)	\
 				______f = {				\
 				.data.func = __func__,			\
 				.data.file = __FILE__,			\
@@ -60,7 +60,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __trace_if_value(cond) ({			\
 	static struct ftrace_branch_data		\
 		__aligned(4)				\
-		__section("_ftrace_branch")		\
+		__section(_ftrace_branch)		\
 		__if_trace = {				\
 			.func = __func__,		\
 			.file = __FILE__,		\
@@ -118,7 +118,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	".popsection\n\t"
 
 /* Annotate a C jump table to allow objtool to follow the code flow */
-#define __annotate_jump_table __section(".rodata..c_jump_table")
+#define __annotate_jump_table __section(.rodata..c_jump_table)
 
 #else
 #define annotate_reachable()
@@ -298,7 +298,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-	static void * __section(".discard.addressable") __used \
+	static void * __section(.discard.addressable) __used \
 		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
 
 /**
-- 
2.23.0.187.g17f5b7556c-goog

