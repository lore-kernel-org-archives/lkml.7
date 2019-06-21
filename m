Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40743C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119E2215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138897;
	bh=2NSvVoEmOQn4ssSg5BbvsPREhDCEtvM8C7WmFYOtenw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OHF9UfEM0M94x82uOIVLca5QjhSfNseXFr1A/YasrU9+n0/y6b/rjtqestY0AU/Qk
	 1ZDmdJd/OIxu1lnyjcxoUjWJdcPVzsPbH1917O+BQeJ/BMw2bUNfbRkGOsq5/LPI/P
	 ZMVd2N7FtdVtUg4qxC+9sYR7uicE+WERjuZrajB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfFURlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfFURld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:41:33 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2374B208CA;
        Fri, 21 Jun 2019 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138892;
        bh=2NSvVoEmOQn4ssSg5BbvsPREhDCEtvM8C7WmFYOtenw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtD0xUzDLA3JuS29Ntox9LBnitVI1TZ1pAYAZIdDWd9pRjj3jbkyk9bO14ecaZEcT
         A0UUPdesxkJU7++MA8k7tCppJwuat23LFHmG4b7BhQfUkoKg5ULcUCOZAXiTeIW+Ub
         gRhZvDUXmNMhsohGs1BPgJ/M9pSTL2KrXplirgFI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 24/25] perf build: Handle slang being in /usr/include and in /usr/include/slang/
Date:   Fri, 21 Jun 2019 14:38:30 -0300
Message-Id: <20190621173831.13780-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

