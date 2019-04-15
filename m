Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7194C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D092087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354956;
	bh=QJwJzCoYrUbP4tRvZqzOepYq9OX3Sy1D5I+WuMo/gmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBTw2jPU+5ok6r4BBrmZqYubxpNnXTsw5rQ8kdaRfApMKWkU5/F2L4vasT+JdlA9i
	 YTqJrDkSEnqf8qlOSdaBQQcTfSVEa6Nq4sXF9L/gugBCvfhQlAB9chMhRkp9d9DWkb
	 4kqqmKxfHfCyZq6XRRqXufW8QkEPr4ysU8gjQFsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfDOTCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbfDOTCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF6920880;
        Mon, 15 Apr 2019 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354950;
        bh=QJwJzCoYrUbP4tRvZqzOepYq9OX3Sy1D5I+WuMo/gmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzD6673cu9LYFgaE3hrJyYiuN18pKhJTA23XEWkhA6cRhW0uuMyBEZPWXZaG7+Ol3
         2tmKqH6HntHj6E3i/FZbE9OiBMhrhdZ3QrHOEzHpWUob0BKeDibXiMAqCvbtJtEZ+7
         P3qrRU31lqafXqMh2C/x3Z/FDsu0mXY7F8TnQR98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/69] lib/string.c: implement a basic bcmp
Date:   Mon, 15 Apr 2019 20:58:29 +0200
Message-Id: <20190415183729.077562051@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5f074f3e192f10c9fade898b9b3b8812e3d83342 ]

A recent optimization in Clang (r355672) lowers comparisons of the
return value of memcmp against zero to comparisons of the return value
of bcmp against zero.  This helps some platforms that implement bcmp
more efficiently than memcmp.  glibc simply aliases bcmp to memcmp, but
an optimized implementation is in the works.

This results in linkage failures for all targets with Clang due to the
undefined symbol.  For now, just implement bcmp as a tailcail to memcmp
to unbreak the build.  This routine can be further optimized in the
future.

Other ideas discussed:

 * A weak alias was discussed, but breaks for architectures that define
   their own implementations of memcmp since aliases to declarations are
   not permitted (only definitions). Arch-specific memcmp
   implementations typically declare memcmp in C headers, but implement
   them in assembly.

 * -ffreestanding also is used sporadically throughout the kernel.

 * -fno-builtin-bcmp doesn't work when doing LTO.

Link: https://bugs.llvm.org/show_bug.cgi?id=41035
Link: https://code.woboq.org/userspace/glibc/string/memcmp.c.html#bcmp
Link: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13
Link: https://github.com/ClangBuiltLinux/linux/issues/416
Link: http://lkml.kernel.org/r/20190313211335.165605-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: James Y Knight <jyknight@google.com>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/string.h |  3 +++
 lib/string.c           | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 96115bf561b4..3d43329c20be 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -142,6 +142,9 @@ extern void * memscan(void *,int,__kernel_size_t);
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
index 5e8d410a93df..1530643edf00 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -865,6 +865,26 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
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
2.19.1



