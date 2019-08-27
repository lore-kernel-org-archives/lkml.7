Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC0BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c21KIJW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfH0UlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:41:02 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51136 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfH0Uk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:59 -0400
Received: by mail-pg1-f201.google.com with SMTP id q9so214730pgv.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/29bjCjTbbl+cLbTxIw0tiWmYrpTAoAKv+ZcK1v+ox8=;
        b=c21KIJW5g4MvXBOS7sME+t0QDUpjgdIeAAj4Dp8ElLl69ZEoixqIhZ+fwaw+wn7eL7
         D6/4lnvdM+kKaI4kTkpi9vlsbviFugLjZgcvgVrDVeotJA4dDdzTebuHj3Z9l9tEh/JW
         +lEUV++D/HbJ+fYgyCwuLobZemlmdv7epF1ZSYGCG/pakcXO33SnFgZZHEIIrnm5+/Gs
         e0FUU/YtFcx1N0xsk2TOXo7UhtkUeLNis39W+2MdQFq1RFeeTbcRLJLSAHd6BNqAsgQN
         bCrq6X0Te9hQI9XwHv33OlzZc5rZ5dptuS18x9F7Iz7djaOR+NK/I/nY/STfG/lUNVry
         6+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/29bjCjTbbl+cLbTxIw0tiWmYrpTAoAKv+ZcK1v+ox8=;
        b=OfGd/uCxNgJMPULN4Yd9sDx9JZfU6CaGBciDu3Qjcw8S+zNkGNuHuacbx0harMv6hN
         NmDJMic7Ti9FKUN+zSVZ2jHIrPUX5NQdMLTxJbrkixQGdDr3EjnuJsYmTT9mOp5wg3cF
         ig0OQBaUM/wKryOZtyaTzbUoqoFweETdhehDh43tZpayrCd6rV6O0HJ39FBk2LaTf868
         hu3RFzzWpQMuPXCAqTP0leQM1Zvg2M8yB2wSlAvWAgICl6+GE4qhe/XOs3LSVp14LRCZ
         OWASzQqnYGFNl6TWYJp8uafqapWD2Ss1n0V6Q3QlzM9tkpWkuNNhck6RxwR4TgS9JAnH
         V8Ug==
X-Gm-Message-State: APjAAAXxj8qMdKnR0nByTNoyjElBmlsSBpWEFH4C0LOawrr2JdzmTSxh
        KApj3DgwU3FP4LCx+j+Nw+dhwMtIy9s85FVEOIs=
X-Google-Smtp-Source: APXvYqws9rBJNdwG7AwVuYJ+B1+1uxBVfBLw5S6uTZm3jhoGgIAtSLYqhIiXulFmjGl2mlFAXSiTZBmYpMcwhY5M8dk=
X-Received: by 2002:a63:a346:: with SMTP id v6mr281349pgn.57.1566938457832;
 Tue, 27 Aug 2019 13:40:57 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:04 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-12-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 11/14] include/asm-generic: prefer __section from compiler_attributes.h
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
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
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

