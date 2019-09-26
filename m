Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF67C352AB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441B4207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569537619;
	bh=B9BxP5kAtbjPr2/2hrJnyPzOPbf4Rhpulc0tA8j50G4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vpRzXrmQOjjyCqMp0WuQTvRDax96DmlrxxwsxYTYroSPO1DZ1lxVIj1CSO6BTpiYB
	 l4Lrpf/nMJ8cXTYBPwB4VivVBzz91iR+yYk+UG4n7BX3RYn2qyTF2OVhvLqG3ovWdk
	 ayZjyW92IBd+nPlKyrkQ7gPgv9tL9VIgqlqwbMPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfIZWkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:40:18 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38493 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfIZWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:40:18 -0400
Received: by mail-io1-f54.google.com with SMTP id u8so10903700iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRBrES6OXe6mAupynRdyMTCoPmyYs41wvldB7LkXBu4=;
        b=XCmr6puVVPyEobymUL0+RsE2FErfwLgMhiaP74snpgl4A64MMTQyo7Cx2pzlG+cNTd
         Jf/8eypsox0EwAIyZdYVklRt+WrBcomgxkkwrN4/dMGUNCmPpKKGGRrKsnZ5Bvnvs8xN
         ZV4zbHHR2cO4bMLzupuC3HFxaobP14yDlguy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRBrES6OXe6mAupynRdyMTCoPmyYs41wvldB7LkXBu4=;
        b=FokBAGQr2uEp2GuxTJgnlYTUezU3LUeHe7HyQa9on5EYU9qDO3mOzI0xwHMD6SOsn/
         3Owq7SBzITK8qyR7sgsrKBHMmd/1UknJPkk4t6gpUJl0l9PR5AT0bNf+s9otaymyvSAO
         zf8rutz8+zhNjSY8+aiUZMidBB3tAMjsCpimc1lR4zmkcZld/l/MLiqGy/Zo9xmfACv6
         xMT9F0xH47ZgQnYj+P1aSE/hhtkw0AlXNjhI1S3QFf0PTNyMgKVfdzIInee7eOXEmuBS
         Yeb9x4R/qZVzv4Y2jZe2oUygqFp70J1B6/rwAud5sDUeFCm2ShhG8C+3fZG9++9JUO/U
         M24w==
X-Gm-Message-State: APjAAAUHgujtkQCZaWZ7V66EPakib9qytfQz1n+TA4IPv2zhJ1B1JMK0
        zTkuI/N0+i3iwYgA5GCfDZ3rqQ==
X-Google-Smtp-Source: APXvYqyV8/rLOlYVMt0omstgu3VSz3zBvI5/Ju/jqPZtz3uWdB6tPAczH0I34DB8A1coHZRONv5DYg==
X-Received: by 2002:a02:a999:: with SMTP id q25mr5932710jam.27.1569537617222;
        Thu, 26 Sep 2019 15:40:17 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o16sm301303ilf.80.2019.09.26.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 15:40:16 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: Add kselftest-all and kselftest-install targets
Date:   Thu, 26 Sep 2019 16:40:14 -0600
Message-Id: <20190926224014.28910-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kselftest-all target to build tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

Current kselftest target builds and runs tests on a development
system which is a developer use-case.

Add kselftest-install target to install tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

This change addresses requests from developers and testers to add
support for installing kselftest from the main Makefile.

In addition, make the install directory the same when install is
run using "make kselftest-install" or by running kselftest_install.sh.
Also fix the INSTALL_PATH variable conflict between main Makefile and
selftests Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
- Collpased two patches that added separate targets to
  build and install into one patch using pattern rule to
  invoke all, install, and clean targets from main Makefile.

 Makefile                                     | 5 ++---
 tools/testing/selftests/Makefile             | 8 ++++++--
 tools/testing/selftests/kselftest_install.sh | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index d456746da347..ec296c60c1af 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,9 +1237,8 @@ PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
 
-PHONY += kselftest-clean
-kselftest-clean:
-	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
+kselftest-%: FORCE
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
 
 PHONY += kselftest-merge
 kselftest-merge:
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

