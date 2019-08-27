Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F05C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F2D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cr6sZbnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfH0Ukd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:33 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:39431 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfH0Ukc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:32 -0400
Received: by mail-vs1-f73.google.com with SMTP id o23so148711vsj.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xQrOvf6S08H+KmBAkcZg6Qy0/dGwEEfJY69WYmdUssY=;
        b=Cr6sZbnxHtYHnAGDqNRJ0FYHYH/GhPMxGWgZ0E1UyOgZ2uUKdW7UtB3boil4bOmtBO
         TEXe8zVaIrDmO8ryzIea/9FyEKmZD9T/fSzwoKLPtcRtjGEQHa7xSp5SQeqpClGWv6BM
         SeXkb5yPAB30IBpi2HpQuDPjjoy5IN71DzcHu83nTNdC2IDIkA70+YibTr15PmD5Sg6w
         Abl6Zhb9AR49yJ07plNgEteWk6Grmuk0RJNIo01hzjf9StymCDZrZkedUsvfbxP1m66X
         lH+I1aPIoI+3A69yJ2FYxZalEvx04Lb1Z0daETZRDZo1bPpundCAp4p7rKh99SlbQizp
         DrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xQrOvf6S08H+KmBAkcZg6Qy0/dGwEEfJY69WYmdUssY=;
        b=cOAIRn5Y6u48zMofZcvslcuQl3W0GELIaIzGXKSIHgGv0P0Arf+85sXGBfKt34VQk2
         +gUtBVAsWpvKsZ8Kxb365vNWOUTsoCWc0cNaDNxm0emEZCl39+rJOCPVqJVPC24OXB+e
         ocSM3T8+W7pcA+DywLkJf882mE0+S7ASlxMvQH79Qaxe6K3tD5dl5EfkmYrM343JASbn
         E6+rSswy7DSWlZBuMJsbgc84zCrciOWKQ0Bpj8a4GiawnnxrM5o6YV7FgOG9h5IN/gWK
         l0ZnsqiEaM/lw08t9uXACfk5nr/dUzrQy10osabR9iAyu2BQJlxt17+yncIcxeFe07j6
         B0Pg==
X-Gm-Message-State: APjAAAWr4ZENOVDVgbO9fmPOnsKpgOcjX7BV446l12mCCv8OtTbqi2vB
        kiukay7C/+c0DuS653byWz9kXDBp7rW7JnXXfPY=
X-Google-Smtp-Source: APXvYqwFNFeBW++SLUxMrYNfs5C7l8YWd0rPF5pQo8o9ESGMl9RzXHc0MfpFspGKwT+SdxbWiadgkSIk3vxfYHB3syQ=
X-Received: by 2002:ab0:634d:: with SMTP id f13mr120429uap.58.1566938431654;
 Tue, 27 Aug 2019 13:40:31 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:55 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 02/14] include/linux/compiler.h: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
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
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: Link: https://github.com/ClangBuiltLinux/linux/issues/619
Cc: <stable@vger.kernel.org>
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

