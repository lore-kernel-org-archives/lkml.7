Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF1C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287C20821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555707450;
	bh=KlbRKB9GU202DsocgIU4dZrSHqRRzgS4R4c9hoyDTfY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0QCYeSgNQkbfdlvdyt46rup2JRFQdkRJktkYVToN+C9Wb9G28wPfBdfNTDKdiAqm6
	 fNsOiZCRCvLaHZ8/OgBipruoXYpSVgCxjsH7UeCLRrtK5Yxpk9At6aR5Blocx+DrcZ
	 XUTGGBwm59755t4ZWi3OLYrPqotGqUJ1U1JCJyaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDSU53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:57:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33478 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfDSU51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:57:27 -0400
Received: by mail-it1-f195.google.com with SMTP id v8so11184757itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3pvgHdPn+EnNNgquwHhpEAcSFkVPjKX6k7ahUQM/gQ=;
        b=V7dPGmMBZIvZ/gdong7ExLntcG76MjdGGJ4G90crc+zcs0JrlovD7UYiLEkx7IM5rz
         pnVQS91/tss8qcFB9uzhMsTMqdcrrpZNR36cOU8hi6qiIJoq6g1YoO4n5/KarsxB6NZ/
         UnP1CB2wQltSalrlRJX/cgyq9nHn03xUyh48A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3pvgHdPn+EnNNgquwHhpEAcSFkVPjKX6k7ahUQM/gQ=;
        b=OW/fRrBhCWofdsHrtJysAAIoX/AapNLEkLuKJVprCo/WVgP1OyZV9T3tN9ZaND79h9
         LPmgBLFBy/AFuc3wUzAAkZqhjPW9uudZMnG9/TR1CZe8FeUEYOA1piSdwFLiSUHiZQ8C
         p2aS/JY0jME/30C5CVFRR7UG9TnCj3LQe9kq4NNIip9rewu8X8X6pk8BjucjjLmu7R03
         xsMocQcRAQjzesijoXupTYT4O5pb00OMu7BFB4cF/Xp3SR3kpGi1xJyDGks3DU8qdLOt
         1AlZ7Nm+wAvWwXaK9PDQCESWsdXtXBALO/P3ENsdMc5jqxFS+QBR3j+uvSTtr/VMczbv
         ME6g==
X-Gm-Message-State: APjAAAUniekEiVoj0HW4fU7NsusxNUh+rsC10dS27eJtFQJ0/ZJKkLyp
        THIKFUNF0RPE9cMpM6pxLTAL7w==
X-Google-Smtp-Source: APXvYqxXH5N2knSsmatyGQR0Nna797VPKBVkxIv0Vvq5Cf1D11OZztTIXhVDR9CM9fdwJPi4dfJ2KQ==
X-Received: by 2002:a24:ca44:: with SMTP id k65mr4722982itg.175.1555707446667;
        Fri, 19 Apr 2019 13:57:26 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m137sm2828706itb.27.2019.04.19.13.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 13:57:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: fix headers_install circular dependency
Date:   Fri, 19 Apr 2019 14:57:23 -0600
Message-Id: <20190419205723.3414-1-skhan@linuxfoundation.org>
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

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
lib.mk needs DEFAULT_GOAL to run all

 tools/testing/selftests/Makefile | 52 +++++++++++++++++++++++++++-----
 tools/testing/selftests/lib.mk   | 38 +++++++++++++++++++++--
 2 files changed, 80 insertions(+), 10 deletions(-)

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
index 8b0f16409ed7..5979fdc4f36c 100644
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
@@ -21,9 +30,34 @@ top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH		?= $(SUBARCH)
 
+# set default goal to all, so make without a target runs all, even when
+# all isn't the first target in the file.
+.DEFAULT_GOAL := all
+
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

