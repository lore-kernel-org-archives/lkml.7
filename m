Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86219C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3829921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9n+TJNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCMSCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:02:48 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:43322 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCMSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:02:47 -0400
Received: by mail-it1-f202.google.com with SMTP id w200so2262463itc.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ir6qodWEKUGzfEu3dnv9XwT0+RGg2i7HMOiUS/XMmXo=;
        b=Q9n+TJNzKkNb/rSOdojaBaog4VNI8l71TA/uaacPn4jlsMLyCYMlDAgV/+yho0MDHn
         2ClBTQqe40n+MYnxeJzaztxYzozoYghadvvVaQuNLP99ohDEVEuH3qshBSNmRgNX3VAV
         ukI70OK5p7RJoOrx4nhpbFuae2HRYll0OlP8vivK6+INJHeknbxAjf+T2Ck97LQjD++i
         L0UraldynMQxniAEa3PuOYAQoIO+pbQ8d4MQjSQh68sDYtFlIdn9eHXUy5R75mZB2hSx
         PNYlyOdefReuUtYha/hVGKaxg8my/9yer9DwZjM7GD4FR/VCJOtl8Cht0K302qHesLcG
         cecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ir6qodWEKUGzfEu3dnv9XwT0+RGg2i7HMOiUS/XMmXo=;
        b=E0YdXWxznr1a4FtTg40lXUjbIOrNn2fNc4rtFemIwvDNtHON4ds9Jk8FrEJZ3a3WGG
         ymDqlb9qaGGjs0aNxb80GqUHgR3+eURheO53Ob+ypgnNW1t1TTZR8XobZBkhQyKjHay1
         ip8F3gbd1KNSkO8uH3jV7w/ssE1rNajj1ui2/12kR6qRo/4QbIlAGvslQk03d85HVO9M
         vHGy7brGIgShblXM4A5vVAak8xlX52qm4UnmnXfwnXx6EnTGPxaeW3hWFKpv4TE8Ly2N
         Z9i76jhYM9Bz1VoB/gSPHNQuiLKv+khIZPJfHlRtagxJGnAzf7m0lKpt1HnE+YikqwP/
         XX3w==
X-Gm-Message-State: APjAAAXdPtUSULP+faGAIu/ZuYNqiI7idD2aKDgxtwsBy+dGZhYmSFav
        D1b0wM+UbAI/VapgTC9C9/mV3FAcXX2y6NcNYw4=
X-Google-Smtp-Source: APXvYqzzxI2FB9oRNRJk4tGUx4ZVBAWC2Zh7YbubeYCUtq/jyNsNDL60ZiEOuL65YZF7uSwAZg38xdfP3iY0SMu2CB0=
X-Received: by 2002:a24:c546:: with SMTP id f67mr2627294itg.28.1552500165874;
 Wed, 13 Mar 2019 11:02:45 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:02:38 -0700
In-Reply-To: <CAKwvOd=8rAZi3ZT8qEupmS6xY2U10cKT7kPtB=gYfWsJEJ0GSQ@mail.gmail.com>
Message-Id: <20190313180239.261938-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=8rAZi3ZT8qEupmS6xY2U10cKT7kPtB=gYfWsJEJ0GSQ@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH] lib/string.c: implement a basic bcmp
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
 lib/string.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e757..5b2377d7143f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -866,6 +866,21 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 EXPORT_SYMBOL(memcmp);
 #endif
 
+#ifndef __HAVE_ARCH_BCMP
+/**
+ * bcmp - Like memcmp but the return code simply indicates a non-match.
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

