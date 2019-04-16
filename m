Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F29DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AEA20684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555426679;
	bh=/mQsofZ4LWY/q7XXNPCihddq7ysn99QENvzSNrtSb+k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1QV/c+d2Ws8T2uq9Nsby6YkV9U2Q9Nlab55+8oe1wx4u3Id0BIN0CMqrBqjbGRpLD
	 cWePprP/cs5PSrOOP2EgGU/JOZiB8pmB5HzAu8DV9dj2/ss4RDqGBpXIP/3Db3VYEb
	 E7zLjlTACkvWkwZOvH2ox3LpvM8ADT3WV012WZiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfDPO56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfDPO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:57:58 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7E420684;
        Tue, 16 Apr 2019 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555426676;
        bh=/mQsofZ4LWY/q7XXNPCihddq7ysn99QENvzSNrtSb+k=;
        h=From:To:Cc:Subject:Date:From;
        b=wThvFXDzv8r51LyfTy7O3R775N4i+EIDteEi/3Oe2WVPXwYFteKv/TprK7niWYucw
         E6FANlu4nZWeid//6XFkLAeR2cyvS687e3QmxPrq2X+wHTBBtYyFr+CGxjDYm7nspb
         YtJ/OheP3KvEg4092C60ik4JG2xBT4I/NOtpPNfY=
From:   Shuah Khan <shuah@kernel.org>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix headers_install circular dependency
Date:   Tue, 16 Apr 2019 08:57:55 -0600
Message-Id: <20190416145755.7972-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make kselftest" fails with "Circular Makefile.o <- prepare dependency
dropped." error, when lib.mk invokes "make headers_install".

Make level 0: Main make calls selftests run_tests target
...
Make level n: selftests lib.mk invokes main make's headers_install

The secondary level make inherits builtin-rules which will use the rule
to generate Makefile.o  and runs into "Circular Makefile.o <- prepare
dependency dropped." error, and kselftest compile fails.

Invoke headers_install target with --no-builtin-rules to avoid circular
error.

In addition, lib.mk installs headers in the default HDR_PATH, even when
build relocation is requested with O= or export KBUILD_OUTPUT. Fix the
problem by passing in INSTALL_HDR_PATH. The headers are installed under
the specified output "dir/usr".

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/Makefile | 52 +++++++++++++++++++++++++++-----
 tools/testing/selftests/lib.mk   | 34 +++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..743cd374d07d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -75,12 +75,15 @@ ifneq ($(KBUILD_SRC),)
 override LDFLAGS =
 endif
 
-BUILD := $(O)
-ifndef BUILD
-  BUILD := $(KBUILD_OUTPUT)
-endif
-ifndef BUILD
-  BUILD := $(shell pwd)
+ifneq ($(O),)
+	BUILD := $(O)
+else
+	ifneq ($(KBUILD_OUTPUT),)
+		BUILD := $(KBUILD_OUTPUT)
+	else
+		BUILD := $(shell pwd)
+		DEFAULT_INSTALL_HDR_PATH := 1
+	endif
 endif
 
 # KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
@@ -89,8 +92,41 @@ endif
 # with system() call. Export it here to cover override RUN_TESTS defines.
 export KSFT_TAP_LEVEL=`echo 1`
 
+# Prepare for headers install
+top_srcdir ?= ../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH           ?= $(SUBARCH)
+export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
-all:
+
+# set default goal to all, so make without a target runs all, even when
+# all isn't the first target in the file.
+.DEFAULT_GOAL := all
+
+# Install headers here once for all tests. KSFT_KHDR_INSTALL_DONE
+# is used to avoid running headers_install from lib.mk.
+# Invoke headers install with --no-builtin-rules to avoid circular
+# dependency in "make kselftest" case. In this case, second level
+# make inherits builtin-rules which will use the rule generate
+# Makefile.o and runs into
+# "Circular Makefile.o <- prepare dependency dropped."
+# and headers_install fails and test compile fails.
+#
+# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
+# invokes them as sub-makes and --no-builtin-rules is not necessary,
+# but doesn't cause any failures. Keep it simple and use the same
+# flags in both cases.
+# Local build cases: "make kselftest", "make -C" - headers are installed
+# in the default INSTALL_HDR_PATH usr/include.
+khdr:
+ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+else
+	make --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
+		ARCH=$(ARCH) -C $(top_srcdir) headers_install
+endif
+
+all: khdr
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
@@ -173,4 +209,4 @@ clean:
 		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
 
-.PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
+.PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 8b0f16409ed7..f888522a34e9 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,7 +3,16 @@
 CC := $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
-OUTPUT := $(shell pwd)
+    ifneq ($(O),)
+	OUTPUT := $(O)
+    else
+	ifneq ($(KBUILD_OUTPUT),)
+		OUTPUT := $(KBUILD_OUTPUT)
+	else
+		OUTPUT := $(shell pwd)
+		DEFAULT_INSTALL_HDR_PATH := 1
+	endif
+    endif
 endif
 
 # The following are built by lib.mk common compile rules.
@@ -21,9 +30,30 @@ top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
+# Invoke headers install with --no-builtin-rules to avoid circular
+# dependency in "make kselftest" case. In this case, second level
+# make inherits builtin-rules which will use the rule generate
+# Makefile.o and runs into
+# "Circular Makefile.o <- prepare dependency dropped."
+# and headers_install fails and test compile fails.
+# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
+# invokes them as sub-makes and --no-builtin-rules is not necessary,
+# but doesn't cause any failures. Keep it simple and use the same
+# flags in both cases.
+# Note that the support to install headers from lib.mk is necessary
+# when test Makefile is run directly with "make -C".
+# When local build is done, headers are installed in the default
+# INSTALL_HDR_PATH usr/include.
 .PHONY: khdr
 khdr:
-	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+ifndef KSFT_KHDR_INSTALL_DONE
+ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
+	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
+else
+	make --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
+		ARCH=$(ARCH) -C $(top_srcdir) headers_install
+endif
+endif
 
 all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 else
-- 
2.17.1

