Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D190C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0A21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KMdtSzxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfLFDRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:17:50 -0500
Received: from ozlabs.org ([203.11.71.1]:59545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLFDRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:17:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47Td7b02k6z9sPV; Fri,  6 Dec 2019 14:17:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575602267;
        bh=zVhnYe3N8hue/+LbI+X1XqJYlxmNifUh7vkS/DHm2wo=;
        h=From:To:Cc:Subject:Date:From;
        b=KMdtSzxm8RzEsLRq4cXQcjZ817K0nGpBpsyVoJ6V+0YCxMp9KeaqwjN5VgKdG3yzl
         i9VRuShuQ6bPdil27QbLN7tot/8eBPEyFARVY+ZpxU4CNpEV/Joskq5LTIy9e2D7PQ
         Es3VQmhlSdTnBTCQGhmTm6cUNf0+bBwUnd6K7KNdLqVBIEfSB34KxdjqixoOS1gkOA
         5Bj4GtlPlFfgnb1AJNE0igL1N7pqmS0J4xeVDil8gXl3lsTYaYkAJfHM8Kd4I0CdTO
         Y4nJA4bTD2ONIxupskXZ+0tV92ggZYNuihBSYzn9T5ElGB5Eotqr4jqVuVFNbCinrJ
         F38lVixzilF5A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     shuahkh@osg.samsung.com
Cc:     linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix dangling documentation references to kselftest_module.sh
Date:   Fri,  6 Dec 2019 14:17:38 +1100
Message-Id: <20191206031738.29641-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c78fd76f2b67 ("selftests: Move kselftest_module.sh into
kselftest/") moved kselftest_module.sh but missed updating a few
references to the path in documentation.

Fixes: c78fd76f2b67 ("selftests: Move kselftest_module.sh into kselftest/")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/dev-tools/kselftest.rst       | 8 ++++----
 tools/testing/selftests/kselftest/module.sh | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ecdfdc9d4b03..61ae13c44f91 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -203,12 +203,12 @@ Test Module
 Kselftest tests the kernel from userspace.  Sometimes things need
 testing from within the kernel, one method of doing this is to create a
 test module.  We can tie the module into the kselftest framework by
-using a shell script test runner.  ``kselftest_module.sh`` is designed
+using a shell script test runner.  ``kselftest/module.sh`` is designed
 to facilitate this process.  There is also a header file provided to
 assist writing kernel modules that are for use with kselftest:
 
 - ``tools/testing/kselftest/kselftest_module.h``
-- ``tools/testing/kselftest/kselftest_module.sh``
+- ``tools/testing/kselftest/kselftest/module.sh``
 
 How to use
 ----------
@@ -247,7 +247,7 @@ Example Module
 
    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-   #include "../tools/testing/selftests/kselftest_module.h"
+   #include "../tools/testing/selftests/kselftest/module.h"
 
    KSTM_MODULE_GLOBALS();
 
@@ -276,7 +276,7 @@ Example test script
 
     #!/bin/bash
     # SPDX-License-Identifier: GPL-2.0+
-    $(dirname $0)/../kselftest_module.sh "foo" test_foo
+    $(dirname $0)/../kselftest/module.sh "foo" test_foo
 
 
 Test Harness
diff --git a/tools/testing/selftests/kselftest/module.sh b/tools/testing/selftests/kselftest/module.sh
index 18e1c7992d30..fb4733faff12 100755
--- a/tools/testing/selftests/kselftest/module.sh
+++ b/tools/testing/selftests/kselftest/module.sh
@@ -9,7 +9,7 @@
 #
 #   #!/bin/sh
 #   SPDX-License-Identifier: GPL-2.0+
-#   $(dirname $0)/../kselftest_module.sh "description" module_name
+#   $(dirname $0)/../kselftest/module.sh "description" module_name
 #
 # Example: tools/testing/selftests/lib/printf.sh
 
-- 
2.21.0

