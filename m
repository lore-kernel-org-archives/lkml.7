Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD58C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF592075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574770393;
	bh=Rs4HXMcto03SyVG32tpBjRZdzHn+VYDPtYZa4E+fPrc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EcTAU8+E/1cIH7b7fTKpGFB8gdahLPa9emfIPzxBkUfzBbcvMoLTgExDdmULu5lOp
	 iNApnfWvVu18QpytiO4njUrPE3bJdOc+8qM12u2bdKWZBkM5O1aKwZKA5hpudny1Vx
	 34euql+Gf0tGSIsNYntTncxikHYwovWV3Rz4y7gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfKZMNM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:13:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728216AbfKZMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:13:11 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Lf3LCucJOjqU-xrFJNGEEw-1; Tue, 26 Nov 2019 07:13:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE1080058F;
        Tue, 26 Nov 2019 12:13:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0D160BEC;
        Tue, 26 Nov 2019 12:12:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH] perf tools: Allow to link with libbpf dynamicaly
Date:   Tue, 26 Nov 2019 13:12:53 +0100
Message-Id: <20191126121253.28253-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Lf3LCucJOjqU-xrFJNGEEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we support only static linking with kernel's
libbpf (tools/lib/bpf). This patch adds libbpf package
detection and support to link perf with it dynamically.

The libbpf package status is displayed with:

  $ make VF=1
  Auto-detecting system features:
  ...
  ...                        libbpf: [ on  ]

It's not checked by default, because it's quite new.
Once it's on most distros we can switch it on.

For the same reason it's not added to the test-all check.

Perf does not need advanced version of libbpf, so we can
check just for the base bpf_object__open function.

Adding new compile variable to detect libbpf package and
link bpf dynamically:

  $ make LIBBPF_DYNAMIC=1
    ...
    LINK     perf
  $ ldd perf | grep bpf
    libbpf.so.0 => /lib64/libbpf.so.0 (0x00007f46818bc000)

If libbpf is not installed, build stops with:

  Makefile.config:486: *** Error: No libbpf devel library found,\
  please install libbpf-devel.  Stop.

Link: http://lkml.kernel.org/n/tip-kjdr6k37nuoiwbl0yltla1nh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/Makefile.feature      |  3 ++-
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-libbpf.c |  7 +++++++
 tools/perf/Makefile.config        | 10 ++++++++++
 tools/perf/Makefile.perf          |  6 +++++-
 5 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8a19753cc26a..574c2e0b9d20 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -96,7 +96,8 @@ FEATURE_TESTS_EXTRA :=                  \
          cxx                            \
          llvm                           \
          llvm-version                   \
-         clang
+         clang                          \
+         libbpf
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 8499385365c0..f30a89046aa3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -53,6 +53,7 @@ FILES=                                          \
          test-zlib.bin                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
+         test-libbpf.bin                        \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -270,6 +271,9 @@ $(OUTPUT)test-get_cpuid.bin:
 $(OUTPUT)test-bpf.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libbpf.bin:
+	$(BUILD) -lbpf
+
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
new file mode 100644
index 000000000000..a508756cf4cc
--- /dev/null
+++ b/tools/build/feature/test-libbpf.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/libbpf.h>
+
+int main(void)
+{
+	return bpf_object__open("test") ? 0 : -1;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1783427da9b0..c90f4146e5a2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -483,6 +483,16 @@ ifndef NO_LIBELF
     ifeq ($(feature-bpf), 1)
       CFLAGS += -DHAVE_LIBBPF_SUPPORT
       $(call detected,CONFIG_LIBBPF)
+
+      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
+      $(call feature_check,libbpf)
+      ifdef LIBBPF_DYNAMIC
+        ifeq ($(feature-libbpf), 1)
+          EXTLIBS += -lbpf
+        else
+          dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
+        endif
+      endif
     endif
 
     ifndef NO_DWARF
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1cd294468a1f..eae5d5e95952 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -116,6 +116,8 @@ include ../scripts/utilities.mak
 #
 # Define TCMALLOC to enable tcmalloc heap profiling.
 #
+# Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -360,7 +362,9 @@ export PERL_PATH
 
 PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
 ifndef NO_LIBBPF
-  PERFLIBS += $(LIBBPF)
+  ifndef LIBBPF_DYNAMIC
+    PERFLIBS += $(LIBBPF)
+  endif
 endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
-- 
2.21.0

