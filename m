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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E44213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/pSU9gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCMVNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:13:43 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37856 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfCMVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:13:42 -0400
Received: by mail-qt1-f202.google.com with SMTP id y12so3292508qti.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xxgbuqf7isoEHZ4jDhfd3oMpETiU0v/Wg5TD8vE91LY=;
        b=J/pSU9gh1NUZYhxzb6IeE5OUy80tX0UwGfQgfF9wHhKV52BLRhIgGAJiHsMpYLDld/
         YQT613MPnsom9WwPb7cEqbHYz/4y9oG4kuSi+lsOQyBhTl3MgUMLd6/JTEITiD/9ESyW
         SfZ9bUO12EeFwzc9weGEW/3y0DbzyBk9lZL3l84J0lXPkHdEA1153Fco1rAxwSsYF1Vg
         Uw6g5fYmAqr00//C/ePmBzH21mLugJJ/cXBYIiNI3RRmBs3+bxYSX2t2n/HBo8kN2QG8
         qFZqAjwIzkPF187I8xA+uLGMm9/x7QFK6uHulcs3BlXwspDGIaNgPxEERSFt+yMWUfZM
         G7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xxgbuqf7isoEHZ4jDhfd3oMpETiU0v/Wg5TD8vE91LY=;
        b=kkpXGiba8ah+F9boHkvQpTvFFGC85N8dd650yCAozCtuUvmcH1zoKq6Jed1TNfXfHW
         UMmnhLltamK5vxzPxgy3WUCyN1bVJxls++EvKvJM5j9teOGrYJN+WuMTrM9uWk8Yog5r
         zxYfStsqYDThm4RgrfXdNKIpH/Sm9M/DzXLd6EcDScWfEBN9Bv1sp9cPyHgdatRh9Iv8
         QXJ1cSiUV4mdmt7Ne3cZpI3TuUcCtU6aAjcwy/HqL/hpO1U/WI5yHHilpNMr6o6rcmnr
         b2ZhZhi4x9qJhGiDsA+dJGGtne8n048aEMiw+vkrv1h8+TFcpESI/oHQ7mHFcBBhUXxs
         YyAQ==
X-Gm-Message-State: APjAAAWE31r5UgINRLABnS9NTj+ht6YTMi/FrhvGRCRUNAAF2BmNc3xI
        C9Qwiul6DplBWuyKzjp5mpCg9N+ItalwQ+aodI8=
X-Google-Smtp-Source: APXvYqzUXfqziWkWrEQIoCYqJeGtAxIqA1+MDoWXQ0VdqMGhYbL2+RNiEwqLFhyDWaOaCCQqepk6SxJ1gGFeAdfbYDc=
X-Received: by 2002:aed:3a42:: with SMTP id n60mr25119356qte.62.1552511621353;
 Wed, 13 Mar 2019 14:13:41 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:13:31 -0700
In-Reply-To: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
Message-Id: <20190313211335.165605-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <7549EE7E-4172-467D-815A-63664A33D410@goodmis.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v4] lib/string.c: implement a basic bcmp
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
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes V3 -> V4:
* Include the entirety of Rasmus' sugguestion, as per Steven.
* Change formal parameter identifiers to match the comment.
Changes V2 -> V3:
* Adjust comment as per Steven to Rasmus' sugguestion.
* Pick up Steven's Ack.
Changes V1 -> V2:
* Add declaration to include/linux/string.h.
* Reword comment above bcmp.

 include/linux/string.h |  3 +++
 lib/string.c           | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index 38e4ca08e757..3ab861c1a857 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -866,6 +866,26 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 EXPORT_SYMBOL(memcmp);
 #endif
 
+#ifndef __HAVE_ARCH_BCMP
+/**
+ * bcmp - returns 0 if and only if the buffers have identical contents.
+ * @a: pointer to first buffer.
+ * @b: pointer to second buffer.
+ * @len: size of buffers.
+ *
+ * The sign or magnitude of a non-zero return value has no particular
+ * meaning, and architectures may implement their own more efficient bcmp(). So
+ * while this particular implementation is a simple (tail) call to memcmp, do
+ * not rely on anything but whether the return value is zero or non-zero.
+ */
+#undef bcmp
+int bcmp(const void *a, const void *b, size_t len)
+{
+	return memcmp(a, b, len);
+}
+EXPORT_SYMBOL(bcmp);
+#endif
+
 #ifndef __HAVE_ARCH_MEMSCAN
 /**
  * memscan - Find a character in an area of memory.
-- 
2.21.0.360.g471c308f928-goog

