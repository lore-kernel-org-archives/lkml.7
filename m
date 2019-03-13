Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03428C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2A02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6Qm7AcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCMSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:17:38 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43799 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCMSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:17:38 -0400
Received: by mail-vs1-f74.google.com with SMTP id y189so654851vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B7yTfa6bCcb9PKaV1iobsmMqwEGi32G0CcJNlnQFP78=;
        b=I6Qm7AcNBeHZMAsjuo3XWkuLtTJ4JA8+Q0qxlyDLWNkFzprQS2A69hr/ummJwq2QbH
         xp0gsFaqzX+fQR37P68lR3noqmZ5/xTj+hzOMbFlIT45v+jRAjlOweBXlRawUQVFbu4L
         9T/yh1X5JYggBbP+R/dEZt8CluisI6ZAmvOfvdp4ASDBBj5RGEC4P9YS1/pxXZcGGnML
         pQfP7f3UaG0FZVHp+QK2LA5W0qrTIfoEXEk5nWh3IyUvCGJBU2XIj/lp99ZPjJzQrWXd
         qCAyTHICvPX8hh3bkTXcN6FkPwOO34DvkucXhUxWNXI65dLjPGk96Kh2uSm6nZ3pqxh5
         43tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B7yTfa6bCcb9PKaV1iobsmMqwEGi32G0CcJNlnQFP78=;
        b=ggv0H1J72ID6TqqUJ7GGculb6Wc7N8YCPMOHBDqvaGEPEUjKI+u1EthdVD8x289dyC
         fXdidn98CP+7iSVnS4tSEwkt+1ZmNX3CyppVKpUI2Q9/ArkJvO8HSQJy/OX0eM3+WaTH
         jplHqD0iAJXN0ZIbQcna2pWhxdj2ORFizb33Q4mQrOuzV4vfOi4xH2lKduo87exT4d0C
         pO+Rmn1N6iYlke1wKj+45IkVs4vGY7D8iH+N1rGQ/3xg6zN2iKGv8SAxFoWH6Kxq7qyd
         IAXNq4HoWwUIAyKeyyLivaKHxlrTHbdXVKMKIdQeOGP4qpnjqf2tgnyKdYUeEpPOe35N
         ohww==
X-Gm-Message-State: APjAAAXJcWU5QMY6xrOHtSFgLYTaeKmYYl62sfkfCAFZoQ/0RcgJTr5Y
        UQtwMJKuMbFTHbBVVUwy/xmzCeH6tbKX67otn+c=
X-Google-Smtp-Source: APXvYqz2nsDqUdfhsOtch5ZQiudq9UOD5dUZVG0ip3q2xijQ7cgTgStrIA/vxW5Uvj7iAyAmsArK5wOVgdC3I4I6uOI=
X-Received: by 2002:ab0:20d2:: with SMTP id z18mr7508106ual.24.1552501056981;
 Wed, 13 Mar 2019 11:17:36 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:17:15 -0700
In-Reply-To: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
Message-Id: <20190313181719.87859-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v2] lib/string.c: implement a basic bcmp
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent optimization in Clang (r355672) lowers comparisons of the
return value of memcmp against zero to comparisons of the return value
of bcmp against zero.  This helps some platforms that implement bcmp
more efficiently than memcmp. glibc simply aliases bcmp to memcmp, but
an optimized implementation is in the works.

This results in linkage failures for all targets with Clang due to the
undefined symbol.  For now, just implement bcmp as a tailcail to memcmp
to unbreak the build.  This routine can be further optimized in the
future.

Other ideas discussed:
* A weak alias was discussed, but breaks for architectures that define
their own implementations of memcmp since aliases to declarations are
not permitted (only definitions).  Arch-specific memcmp implementations
typically declare memcmp in C headers, but implement them in assembly.
* -ffreestanding also is used sporadically throughout the kernel.
* -fno-builtin-bcmp doesn't work when doing LTO.

Link: https://bugs.llvm.org/show_bug.cgi?id=41035
Link: https://code.woboq.org/userspace/glibc/string/memcmp.c.html#bcmp
Link: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13
Link: https://github.com/ClangBuiltLinux/linux/issues/416
Cc: stable@vger.kernel.org
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: James Y Knight <jyknight@google.com>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* Add declaration to include/linux/string.h.
* Reword comment above bcmp.

 include/linux/string.h |  3 +++
 lib/string.c           | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f80c..6ab0a6fa512e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -150,6 +150,9 @@ extern void * memscan(void *,int,__kernel_size_t);
 #ifndef __HAVE_ARCH_MEMCMP
 extern int memcmp(const void *,const void *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_BCMP
+extern int bcmp(const void *,const void *,__kernel_size_t);
+#endif
 #ifndef __HAVE_ARCH_MEMCHR
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..b882692bac04 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -866,6 +866,21 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 EXPORT_SYMBOL(memcmp);
 #endif
 
+#ifndef __HAVE_ARCH_BCMP
+/**
+ * bcmp - Like memcmp but a non-zero return code simply indicates a non-match.
+ * @cs: One area of memory.
+ * @ct: Another area of memory.
+ * @count: The size of the areas.
+ */
+#undef bcmp
+int bcmp(const void *cs, const void *ct, size_t count)
+{
+	return memcmp(cs, ct, count);
+}
+EXPORT_SYMBOL(bcmp);
+#endif
+
 #ifndef __HAVE_ARCH_MEMSCAN
 /**
  * memscan - Find a character in an area of memory.
-- 
2.21.0.360.g471c308f928-goog

