Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32439C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041D020640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569452713;
	bh=JoSURJN9nfPTAWGCif6gHkumAieRcJwU+wuPl9DVk3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1GsqHK7CJ3/nDa+bSIgO7yEZzHTU+2r1M/ONwRJ2xhXSc7/81sUvZqARqFnNn8b1
	 Nley7KPO2eZhmZdvj92LUsYt97qnqlm6KcVYVOQJiMaapOf6qeY+kfXk3LVXefxplH
	 1IQ8AxcKLD9f25Ilg+w1V/hI3ZtayMnGlvGG2OPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfIYXFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:05:12 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:42321 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbfIYXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:05:09 -0400
Received: by mail-io1-f41.google.com with SMTP id n197so1296989iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1YMz9ksrdQ7cPPABsA09urm67yr9R6IZjmvoUPzxwJQ=;
        b=iXN5gYJ5HULpGN4jiBNeGuKrRsjjPCDh0f9k1OxW4Nd2WYGpXycEP3lfZM7IOa5V7u
         zt9TqVjh2B9U+yS6H3EZEzn/YQrfGuLWwf5fAhfYC+MY1xW744IuTr1tyfLVi9r881CN
         Mv+6lnH86+wahkV4TiXZQFpSCgltvSkdS2irA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1YMz9ksrdQ7cPPABsA09urm67yr9R6IZjmvoUPzxwJQ=;
        b=oIvbDpWADzpegpGSQA6QXJs/7aT4OmpWr21kFDqfvJpmdRURXKgLkT3eZ81ekycuCL
         Q5MbkNK48+PqfT5o3vyjOdaQDMGV4ps4XTs2vua+FSVMdoVQcvFZRhmhgt34UqlSCLNo
         0EVKd5eog6nNJN1D00pjjfY4+90zfnqJ0ujBGPo2kYYiHTbcbq2CwVzSmSDhU375PGwN
         lVUdiGtO8wrZ3jRlzzOIoVCOEi1o6nGMwsvN7/ohANHDS1Q6ZWi7LX5UTGZ8gIRD0lxX
         9u9WsuSdJo9yU0NiQGY18eHMWDhJHcJZ6/ud26SdBJWC2VI0fJNtD4vNUhQyLfufF3BQ
         0/yg==
X-Gm-Message-State: APjAAAUeK2Z/cfhX2J1axaBPWuaUs+jZap0kqpf30/jsMfkHJUgseDR8
        scRGIFYa8G3RN9OxjWiTken8M5gk3HI=
X-Google-Smtp-Source: APXvYqxI6iUzKkSoQdTbZKd/TguAGEr6qe3KDzCOI+oNx8oHTnXanpvdTBRS99Rbw71WZEkv3zpnmg==
X-Received: by 2002:a5d:9a16:: with SMTP id s22mr521750iol.79.1569452709196;
        Wed, 25 Sep 2019 16:05:09 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f23sm70767ioc.36.2019.09.25.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:05:08 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: Add kselftest_install target to main Makefile
Date:   Wed, 25 Sep 2019 17:04:35 -0600
Message-Id: <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1569452305.git.skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kselftest_install target to install tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

This change addresses requests from developers and testers to add
support for installing kselftest from the main Makefile.

In addition, make the install directory the same when install is
run using "make kselftest_install" or by running kselftest_install.sh.
Also fix the INSTALL_PATH variable conflict between main Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile                                     | 4 ++++
 tools/testing/selftests/Makefile             | 8 ++++++--
 tools/testing/selftests/kselftest_install.sh | 4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ac4af6fc4b50..65c62af6b6fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1241,6 +1241,10 @@ PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
+PHONY += kselftest_install
+kselftest_install:
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests install
+
 PHONY += kselftest-clean
 kselftest-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..bad18145ed1a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -171,9 +171,12 @@ run_pstore_crash:
 # 1. output_dir=kernel_src
 # 2. a separate output directory is specified using O= KBUILD_OUTPUT
 # 3. a separate output directory is specified using KBUILD_OUTPUT
+# Avoid conflict with INSTALL_PATH set by the main Makefile
 #
-INSTALL_PATH ?= $(BUILD)/install
-INSTALL_PATH := $(abspath $(INSTALL_PATH))
+KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
+KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
+# Avoid changing the rest of the logic here and lib.mk.
+INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 
 install: all
@@ -203,6 +206,7 @@ ifdef INSTALL_PATH
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
+		echo -n "Emit Tests for $$TARGET\n"; \
 		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
index ec304463883c..e2e1911d62d5 100755
--- a/tools/testing/selftests/kselftest_install.sh
+++ b/tools/testing/selftests/kselftest_install.sh
@@ -24,12 +24,12 @@ main()
 		echo "$0: Installing in specified location - $install_loc ..."
 	fi
 
-	install_dir=$install_loc/kselftest
+	install_dir=$install_loc/kselftest_install
 
 # Create install directory
 	mkdir -p $install_dir
 # Build tests
-	INSTALL_PATH=$install_dir make install
+	KSFT_INSTALL_PATH=$install_dir make install
 }
 
 main "$@"
-- 
2.20.1

