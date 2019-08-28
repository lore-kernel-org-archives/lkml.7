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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695BC233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R04ttarl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfH1W43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:29 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50237 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfH1W41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:27 -0400
Received: by mail-pf1-f202.google.com with SMTP id b21so845175pfb.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WH4YcJNGldw8lGialETJ/aKYammbyIUszQaJj27lQ9U=;
        b=R04ttarliq3AU5HEMs+PgjVrPHYJ9wCLxu6WOLrSANpSN/Ghx9wW3fAyo7ejGQCptx
         PADhzXyMrmVT3btp0uzstj7JM7DzYHXL50hQhMHKO/EZ6HJUWCGDl0DCmav6f2SDQeGv
         LuFj0sCNJeIvOfGQQ99FrUalx6sy5DbVqj1l/1uiZo1rsewBVYp1wsnsR3kRuiJnRfCL
         AZWVSWZQsS+E7WmswnOjvygHYBkH0RqxQvQzs6XXcdBHeZ7E3W28gCOmXUGTRYrMfO6p
         nLOvhDo1nQeTbjJ1SBraZQwONtehxUlKs/Z9CXM2s+o9PNi/xcrDRjSXA0DgNciCCqDG
         z6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WH4YcJNGldw8lGialETJ/aKYammbyIUszQaJj27lQ9U=;
        b=VUiGQAx5Wt6tu663ERSD0PV9VzGqrLEn3Mxlg0PyhkrhB8d6ntaikeG1q+fYdBGPkT
         pIN2lDgvr9SXwuoNvsmVGJrOnwDmSprdpt1KCByEgOB6r0e9dhq61mFnHhVRbMgzPLZ3
         xJHoP3a6vDQImXk3+2sMgcvogsK+jQB2F9IGTIRoaduVWJUPTX03inbmQIo0Lv0BZyBT
         NmHMpAE2beGX+pta+TyM3wHRbwkX6IKF+wwrgK0U9n9m0RyIMSdLYR6eP1yR5tIxNS1+
         6wnsK9/l5xLs5yn14qlPqnXQp07eDea5zVXUbrtyfybkOJd5lrnDtLeNuw0tQCANTTPE
         zQlg==
X-Gm-Message-State: APjAAAWlDKkxNij3jL3ZiTVEAcoFd8ZdechJcxeJgM0yyFtvqLnXE47Q
        pwjVqQLSWdOzHsRLkPC8zGppsSi7oHXCNB5rdpQ=
X-Google-Smtp-Source: APXvYqzuQv/BQWiW1u5m8CslOF4lew5X7hK5GTJxsPz4whfLKQaRdr2JQEcWemGFaLGblbtvQGMys3nGuGZfC2m3Ndw=
X-Received: by 2002:a63:3dcd:: with SMTP id k196mr5589110pga.45.1567032986002;
 Wed, 28 Aug 2019 15:56:26 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:32 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-12-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 11/14] include/asm-generic: prefer __section from compiler_attributes.h
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
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/error-injection.h | 2 +-
 include/asm-generic/kprobes.h         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 95a159a4137f..a593a50b33e3 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -23,7 +23,7 @@ struct error_injection_entry {
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\
-	__attribute__((__section__("_error_injection_whitelist")))	\
+	__section(_error_injection_whitelist)				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 4a982089c95c..20d69719270f 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -9,12 +9,11 @@
  * by using this macro.
  */
 # define __NOKPROBE_SYMBOL(fname)				\
-static unsigned long __used					\
-	__attribute__((__section__("_kprobe_blacklist")))	\
+static unsigned long __used __section(_kprobe_blacklist)	\
 	_kbl_addr_##fname = (unsigned long)fname;
 # define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 /* Use this to forbid a kprobes attach on very low level functions */
-# define __kprobes	__attribute__((__section__(".kprobes.text")))
+# define __kprobes	__section(.kprobes.text)
 # define nokprobe_inline	__always_inline
 #else
 # define NOKPROBE_SYMBOL(fname)
-- 
2.23.0.187.g17f5b7556c-goog

