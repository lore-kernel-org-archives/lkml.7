Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FFEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09121855
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709865;
	bh=AqdzoIJJu9cpZJrqevo1aBmtgqV79O2mnfJMJkW4fZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPULiXPoy3M+rc2lt3bYLLqX9dr4w0rY6kXaLs8f5jWr/VboDWExyXxgVgEyb64jQ
	 nggXPl9U7wuB7iycpq3i2ZLJcHLhEW5m5UQHWY1aNlBCQm/TVKe2oCcpV/UwSb+Z5b
	 fYTMHwYxIqyo8Rxu4R3Z+0fW5mBVy6jDnJXz80d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbfC0SEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733210AbfC0SEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7D92184C;
        Wed, 27 Mar 2019 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709855;
        bh=AqdzoIJJu9cpZJrqevo1aBmtgqV79O2mnfJMJkW4fZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qdj1lkK0DsjFIgE1TyMKRQiXOhgrEkdTTAU0OBtHpdhoTNVKfpaf1ZLoncOTMcBnu
         ZiPcBYpoL04miJDB2M9tzKHsHAKri8PBsmr7x6QzObkWUjyC0cvyWJxfX+WZAxYPGc
         /qXKRjtT1u1DUlumTn/73YV7M/QLCZn6zUoO66Zk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 075/262] kbuild: make -r/-R effective in top Makefile for old Make versions
Date:   Wed, 27 Mar 2019 13:58:50 -0400
Message-Id: <20190327180158.10245-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 3812b8c5c5d527239ac015f1f2c7654da7fcfbba ]

Adding -rR to MAKEFLAGS is important because we do not want to
be bothered by built-in implicit rules or variables.

One problem that used to exist in older GNU Make versions is

  MAKEFLAGS += -rR

... does not become effective in the current Makefile. When you are
building with O= option, it becomes effective in the top Makefile
since it recurses via 'sub-make' target. Otherwise, the top Makefile
tries implicit rules. That is why we explicitly add empty rules for
Makefiles, but we often miss to do that.

In fact, adding -d option to older GNU Make versions shows it is
trying a bunch of implicit pattern rules.

 Considering target file `scripts/Makefile.kcov'.
  Looking for an implicit rule for `scripts/Makefile.kcov'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.o'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.c'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.cc'.
  Trying pattern rule with stem `Makefile.kcov'.
  Trying implicit prerequisite `scripts/Makefile.kcov.C'.
  ...

This issue was fixed by GNU Make commit 58dae243526b ("[Savannah #20501]
Handle adding -r/-R to MAKEFLAGS in the makefile"). So, it is no longer
a problem if you use GNU Make 4.0 or later. However, older versions are
still widely used.

So, I decided to patch the kernel Makefile to invoke sub-make regardless
of O= option. This will allow further cleanups.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 89af52ca0ba5..efec82635ac5 100644
--- a/Makefile
+++ b/Makefile
@@ -15,19 +15,6 @@ NAME = Shy Crocodile
 PHONY := _all
 _all:
 
-# Do not use make's built-in rules and variables
-# (this increases performance and avoids hard-to-debug behaviour)
-MAKEFLAGS += -rR
-
-# Avoid funny character set dependencies
-unexport LC_ALL
-LC_COLLATE=C
-LC_NUMERIC=C
-export LC_COLLATE LC_NUMERIC
-
-# Avoid interference with shell env settings
-unexport GREP_OPTIONS
-
 # We are using a recursive build, so we need to do a little thinking
 # to get the ordering right.
 #
@@ -44,6 +31,21 @@ unexport GREP_OPTIONS
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+ifneq ($(sub-make-done),1)
+
+# Do not use make's built-in rules and variables
+# (this increases performance and avoids hard-to-debug behaviour)
+MAKEFLAGS += -rR
+
+# Avoid funny character set dependencies
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
+# Avoid interference with shell env settings
+unexport GREP_OPTIONS
+
 # Beautify output
 # ---------------------------------------------------------------------------
 #
@@ -112,7 +114,6 @@ export quiet Q KBUILD_VERBOSE
 
 # KBUILD_SRC is not intended to be used by the regular user (for now),
 # it is set on invocation of make with KBUILD_OUTPUT or O= specified.
-ifeq ($(KBUILD_SRC),)
 
 # OK, Make called in directory where kernel src resides
 # Do we want to locate output files in a separate directory?
@@ -142,6 +143,13 @@ $(if $(KBUILD_OUTPUT),, \
 # 'sub-make' below.
 MAKEFLAGS += --include-dir=$(CURDIR)
 
+else
+
+# Do not print "Entering directory ..." at all for in-tree build.
+MAKEFLAGS += --no-print-directory
+
+endif # ifneq ($(KBUILD_OUTPUT),)
+
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
@@ -149,16 +157,12 @@ $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 
 # Invoke a second make in the output directory, passing relevant variables
 sub-make:
-	$(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
+	$(Q)$(MAKE) sub-make-done=1 \
+	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-# Leave processing to above invocation of make
-skip-makefile := 1
-endif # ifneq ($(KBUILD_OUTPUT),)
-endif # ifeq ($(KBUILD_SRC),)
-
+else # sub-make-done
 # We process the rest of the Makefile if this is the final invocation of make
-ifeq ($(skip-makefile),)
 
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -1757,7 +1761,7 @@ $(cmd_files): ;	# Do not try to update included dependency files
 
 endif   # ifeq ($(config-targets),1)
 endif   # ifeq ($(mixed-targets),1)
-endif	# skip-makefile
+endif   # sub-make-done
 
 PHONY += FORCE
 FORCE:
-- 
2.19.1

