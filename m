Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF23C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C182070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rjLnah6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfFVGuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:50:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFVGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:50:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6olCm2010231
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:50:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6olCm2010231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186247;
        bh=g+HgSA4mjJyQkGSE20H6UFnxgHQMWJYM6g/JcZMd87o=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=rjLnah6rlUuI7qtA333YF6b11cPppTx7cDIvj45NepNhzw6Xob3RvteVk3dREjmk3
         zcfCDUgV2E7AHIk7fW6p/xgz/DFWpUruAmXIE4Oi2PDpJJ2c9b/J3ytL6zYFgW7SsJ
         ULfaNlThB/SvsTV2kQUbLJKSD6jFIy16OyCy9OsJDYDhL+0J98h4DTekMCp8/G/TIG
         U8xKO7aOICTDEOWKy2+s3mT9RGDUTo76XieN9JDC/QNibYYrqiF2wdHlbWHcS/ZqmZ
         hqVaV5hyH/n0bhMM8LTYUujVnU7VtcCdaEMgOoCgQ4FgOO2CC5lVRNrJE8kylSjCAM
         +QXx8v2bXx2nA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6olKd2010228;
        Fri, 21 Jun 2019 23:50:47 -0700
Date:   Fri, 21 Jun 2019 23:50:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-bkgtpsu3uit821fuwsdhj9gd@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, f.fainelli@gmail.com, acme@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, tglx@linutronix.de, acme@redhat.com,
          f.fainelli@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Handle slang being in /usr/include and
 in /usr/include/slang/
Git-Commit-ID: 78d6ccce03e86de34c7000bcada493ed0679e350
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  78d6ccce03e86de34c7000bcada493ed0679e350
Gitweb:     https://git.kernel.org/tip/78d6ccce03e86de34c7000bcada493ed0679e350
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Jun 2019 17:48:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Jun 2019 17:48:12 -0300

perf build: Handle slang being in /usr/include and in /usr/include/slang/

In some distros slang.h may be in a /usr/include 'slang' subdir, so use
the if slang is not explicitely disabled (by using NO_SLANG=1) and its
feature test for the common case (having /usr/include/slang.h) failed,
use the results for the test that checks if it is in slang/slang.h.

Change the only file in perf that includes slang.h to use
HAVE_SLANG_INCLUDE_SUBDIR and forget about this for good.

On a rhel6 system now we have:

  $ /tmp/build/perf/perf -vv | grep slang
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
  $ ldd /tmp/build/perf/perf | grep libslang
  	libslang.so.2 => /usr/lib64/libslang.so.2 (0x00007fa2d5a8d000)
  $ grep slang /tmp/build/perf/FEATURE-DUMP
  feature-libslang=0
  feature-libslang-include-subdir=1
  $ cat /etc/redhat-release
  CentOS release 6.10 (Final)
  $

While on fedora:29:

  $ /tmp/build/perf/perf -vv | grep slang
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
  $ ldd /tmp/build/perf/perf | grep slang
  	libslang.so.2 => /lib64/libslang.so.2 (0x00007f8eb11a7000)
  $ grep slang /tmp/build/perf/FEATURE-DUMP
  feature-libslang=1
  feature-libslang-include-subdir=1
  $
  $ cat /etc/fedora-release
  Fedora release 29 (Twenty Nine)
  $

The feature-libslang-include-subdir=1 line is because the 'gettid()'
test was added to test-all.c as the new glibc has an implementation for
that, so we soon should have it not failing, i.e. should be the common
case soon. Perhaps I should move it out till it becomes the norm...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1955c8cf5e26 ("perf tools: Don't hardcode host include path for libslang")
Link: https://lkml.kernel.org/n/tip-bkgtpsu3uit821fuwsdhj9gd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 11 ++++++++---
 tools/perf/ui/libslang.h   |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e04b7a81d221..89ac5a1f1550 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -644,9 +644,14 @@ endif
 
 ifndef NO_SLANG
   ifneq ($(feature-libslang), 1)
-    msg := $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev);
-    NO_SLANG := 1
-  else
+    ifneq ($(feature-libslang-include-subdir), 1)
+      msg := $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev);
+      NO_SLANG := 1
+    else
+      CFLAGS += -DHAVE_SLANG_INCLUDE_SUBDIR
+    endif
+  endif
+  ifndef NO_SLANG
     # Fedora has /usr/include/slang/slang.h, but ubuntu /usr/include/slang.h
     CFLAGS += -DHAVE_SLANG_SUPPORT
     EXTLIBS += -lslang
diff --git a/tools/perf/ui/libslang.h b/tools/perf/ui/libslang.h
index c0686cda39a5..991e692b9b46 100644
--- a/tools/perf/ui/libslang.h
+++ b/tools/perf/ui/libslang.h
@@ -10,7 +10,12 @@
 #ifndef HAVE_LONG_LONG
 #define HAVE_LONG_LONG __GLIBC_HAVE_LONG_LONG
 #endif
+
+#ifdef HAVE_SLANG_INCLUDE_SUBDIR
+#include <slang/slang.h>
+#else
 #include <slang.h>
+#endif
 
 #if SLANG_VERSION < 20104
 #define slsmg_printf(msg, args...) \
