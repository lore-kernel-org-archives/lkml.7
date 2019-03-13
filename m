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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B17C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DC0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVx8Cdn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCMUhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:37:51 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:53858 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:37:50 -0400
Received: by mail-ot1-f73.google.com with SMTP id h10so1354424otl.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8HB51ltATTSFxrkKUn27F32DnBWWX1A5orTg6yCiOwk=;
        b=JVx8Cdn4Ohqbx6G4FMQBhLTgsdin8muSSnuiMoHKCJBOqYlKSfJF2NuZk4mK4gmjhc
         OBSTJr2GDoreZ53iauDU9qux56ei152bzSYTX4/hLVQLW8P/S5940Cr+5oS/Qm7UTNSf
         Jor3ILoCz/hilhwYhHYIwywgaUW3JuTKzygXd+Ote+5NQZMWAvgBI+KDwPbwNPtE2ZOQ
         6OG3Bnuz9F5RIwJ/Po8hiilPK1l4zFxrGKN/cpFlPJOJMN0X5GkaXYaFGZLtLpSI3vIg
         hmJtkvxQ/yTpDMHy9mVI26pysegV5zsuK/r+UuYdrFKIpHIor3ZOOC8XHo8eO8RV4LTG
         VnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8HB51ltATTSFxrkKUn27F32DnBWWX1A5orTg6yCiOwk=;
        b=QdXNySf96fnRCzl1anBHodoE/SPAWigRUu08v3+Zfz+4CGI2p6hgRqrZTH6mFcFMcD
         3s9kSO36JHSTC4QUk/x1T3X9QzNgy7P2aEgJ6Ack6RmVVSEeERlIudn6INIAeXWqUCLO
         pUTYrmpTXDgDkxGiz3FBxO5YVHGWtRXm5yDgnxwu2hdf1Vm0uaWkqe5QczWSaCO/R5j0
         BqRTOL7iQfmXnRNZK3zlMURNKwBuSK+vRMpzZjWH0UrQ3/4Zowk7pvA3Tn60fCx1uQVH
         F8r5Q3bHBAGrPdg0nYRMsPaZ/n8oXkVgsCIIfz7fNQR8EUT+9/enCcBfCGjdI+IzOAuk
         9rwQ==
X-Gm-Message-State: APjAAAWPfpfTTUvvPAXv2bsnNHYYtoXyPgdWPTiXHRkfrgXoi8yBRscC
        bol9bzvtfsnsAS79DbNfkSWQihAVCyS3B//cjoQ=
X-Google-Smtp-Source: APXvYqy8rPYkhjA6+/nL4T7P745g01Bb3rvA7boGj+VCpW2DI1HGxoaUE0Hq2JxQpXPUOWnURu58me69OQPHjqGr7kM=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr24715818otl.65.1552509469760;
 Wed, 13 Mar 2019 13:37:49 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:37:37 -0700
In-Reply-To: <20190313161221.41797313@gandalf.local.home>
Message-Id: <20190313203741.142380-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190313161221.41797313@gandalf.local.home>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v3] lib/string.c: implement a basic bcmp
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Changes V2 -> V3:
* Adjust comment as per Steven to Rasmus' sugguestion.
* Pick up Steven's Ack.
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
index 38e4ca08e757..48a43a42d3f2 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -866,6 +866,21 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 EXPORT_SYMBOL(memcmp);
 #endif
 
+#ifndef __HAVE_ARCH_BCMP
+/**
+ * bcmp - returns 0 if and only if the buffers have identical contents.
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

