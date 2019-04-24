Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4760C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A842175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="msuNws63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfDXXNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46914 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDXXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id o7so7821085pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZuCugwZb+/GRAp2HfwR/1ziBqDVM1XVAZ/RmaQUhBGo=;
        b=msuNws63xTwU3xDReEFIk60xeSadqexwYZRxp18ms1vdZ5UDDoVCHXjBjBW5ssG4e7
         E16EVNFkdb5/tOLeML3XR/kNcV4g2M60Ag60RMJJjEhe27DYnpf0ul9MAyWwPkhVSzyn
         qhFKdLvmXqElCYnHQaqK5aW6g8o+jMEgmUjto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZuCugwZb+/GRAp2HfwR/1ziBqDVM1XVAZ/RmaQUhBGo=;
        b=BNuYmyr1QmMGKcba0s/wMsf2lb4nXgoJchK1N7ved0ha9RMVGgPaVeHGmvKRzuxMbi
         mAlNbRfpYtWfI5w6RqKdgzNwt3t9HIQsg733anVBpNqoGZOetFCtYsl2Yc4DgaedB18P
         xvUj1iYXbEwBqqsxmoBHaS2pMOLG0rouVL1X8LVIas8ry5vvbvTiziK1g/U4FVcGXMvm
         5UtS7/V7vZQXUo7dlaa04HDSJVW8GuTDVM6YGjAtYXMLGvDa1Z+gmImldNCJBfci0B2Z
         MTBgWsAfmSKqgoxsuizEHlxjJPlitoydjJ4b9ZV36g7n7qXlVZR7qEV+N4AKoEvDquFF
         WBBg==
X-Gm-Message-State: APjAAAXQQeZJ8JuQfPScozvEacN0iigfaD9kEdk9yRCSuHYTM6LOXGqw
        1pzm8FXPN/VwFEqRCRw3HvFe+g==
X-Google-Smtp-Source: APXvYqxGjazCTufdmjMBo+HpHsm2QiS4rwC/7Wqx3kyp3G6niUjUe9D3Why2pNQyCXTJaD8lbvB99w==
X-Received: by 2002:a17:902:684a:: with SMTP id f10mr9678565pln.286.1556147563691;
        Wed, 24 Apr 2019 16:12:43 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q80sm37177424pfa.66.2019.04.24.16.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] selftests: Use runner.sh for emit targets
Date:   Wed, 24 Apr 2019 16:12:31 -0700
Message-Id: <20190424231237.14776-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reuses the new runner.sh for the emit targets instead of manually
running each test via run_kselftest.sh.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/Makefile | 11 +++++------
 tools/testing/selftests/lib.mk   | 15 ++-------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f2ebf8cf4686..c5f9f736cdbd 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -176,7 +176,8 @@ ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 install:
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
-	mkdir -p $(INSTALL_PATH)
+	mkdir -p $(INSTALL_PATH)/kselftest
+	install -m 744 kselftest/runner.sh $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		make OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
@@ -186,15 +187,13 @@ ifdef INSTALL_PATH
 	echo "#!/bin/sh" > $(ALL_SCRIPT)
 	echo "BASE_DIR=\$$(realpath \$$(dirname \$$0))" >> $(ALL_SCRIPT)
 	echo "cd \$$BASE_DIR" >> $(ALL_SCRIPT)
+	echo ". ./kselftest/runner.sh" >> $(ALL_SCRIPT)
 	echo "ROOT=\$$PWD" >> $(ALL_SCRIPT)
 	echo "if [ \"\$$1\" = \"--summary\" ]; then" >> $(ALL_SCRIPT)
-	echo "  OUTPUT=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
-	echo "  cat /dev/null > \$$OUTPUT" >> $(ALL_SCRIPT)
-	echo "else" >> $(ALL_SCRIPT)
-	echo "  OUTPUT=/dev/stdout" >> $(ALL_SCRIPT)
+	echo "  logfile=\$$BASE_DIR/output.log" >> $(ALL_SCRIPT)
+	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
 	echo "export KSFT_TAP_LEVEL=1" >> $(ALL_SCRIPT)
-	echo "export skip=4" >> $(ALL_SCRIPT)
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 9d2b3c303bfa..6b2d026a94ea 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -116,24 +116,13 @@ else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
-define EMIT_TESTS
+emit_tests:
 	@test_num=`echo 0`;				\
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		test_num=`echo $$test_num+1 | bc`;	\
-		TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
-		echo "echo $$TEST_HDR_MSG";	\
-		if [ ! -x $$TEST ]; then	\
-			echo "echo \"$$TEST_HDR_MSG: Warning: file $$BASENAME_TEST is not executable, correct this.\"";		\
-			echo "echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\""; \
-		else
-			echo "(./$$BASENAME_TEST >> \$$OUTPUT 2>&1 && echo \"ok 1..$$test_num $$TEST_HDR_MSG [PASS]\") || (if [ \$$? -eq \$$skip ]; then echo \"not ok 1..$$test_num $$TEST_HDR_MSG [SKIP]\"; else echo \"not ok 1..$$test_num $$TEST_HDR_MSG [FAIL]\"; fi;)"; \
-		fi;		\
+		echo "run_one \"$$BASENAME_TEST\" \"$$test_num\"";	\
 	done;
-endef
-
-emit_tests:
-	$(EMIT_TESTS)
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
-- 
2.17.1

