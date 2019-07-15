Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8DEC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AF221537
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198880;
	bh=w2jROTzT3sCunZFjQYCk4wA0ydx1xlMp+Dfi9whhrj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvbYcxSe+x3s5iDHxBOUeW8nxOF4D7K6Vn1YQ4mWMfARciVsQffwvcjCy0QOKhJdO
	 TTTHCiQUrzON8XybUB4z0chkq+dt6VQ2v+uco+LhGKIBZzXV83yjcBpFY2yqYxloik
	 NFFXOaHa18u/W3okRHDpse7me/ig0hqnS0sYVA3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfGONyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbfGONyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:54:36 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68DD2081C;
        Mon, 15 Jul 2019 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198875;
        bh=w2jROTzT3sCunZFjQYCk4wA0ydx1xlMp+Dfi9whhrj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOrD5hijrqAS9kSOzVMXsckQIE40BtZIOuclcnZERZ6JgQv9iB2jSJeFmgxJPcYEy
         fM3aDCreRpV9FrF8+rmEWjxocOobDNqk/hv3489BY3APEC1QPunzSSRD5pHV/+DkXj
         yXEs90bRcLg38QKU296VtNzK1XG6Eejej/9fO4Kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 125/249] perf build: Handle slang being in /usr/include and in /usr/include/slang/
Date:   Mon, 15 Jul 2019 09:44:50 -0400
Message-Id: <20190715134655.4076-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 78d6ccce03e86de34c7000bcada493ed0679e350 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 11 ++++++++---
 tools/perf/ui/libslang.h   |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 85fbcd265351..17b81bc403e4 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -637,9 +637,14 @@ endif
 
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
     CFLAGS += -I/usr/include/slang
     CFLAGS += -DHAVE_SLANG_SUPPORT
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

