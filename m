Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B94206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908614;
	bh=4y0+lwTNBaUXIjzozvETVmejGsMR33NTrkXIOdtXAO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQfsEeCgDEcVndiTE1kT3QZapncXpzqXubmkFTebNOTzoD1sj9uiYOQoDPLshM3nO
	 OkQdmw0ykK4ADHb+3HnFNC64tf9XBFnaPbnvNHGyPx64v5+lTgffheOhR3vWjpL5/u
	 pzhirKBGglcQKVu7+qgGx5rol36proAzooNxLVFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCFVnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35425 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfCFVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:32 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DEB5C21F6E;
        Wed,  6 Mar 2019 16:43:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YRu6pq+hbZsbA/uLHOfn3mnS6TXv4s3dfV60FY65kB8=; b=Afutobdr
        pYFXO595NWJJh+gpGhupvEFASZ994DrszqkrM+GWgYY4cYy7TXDOxUA61GR8Ok8i
        qGRPkKc89YUSrjXetSMj5ZYxuU69z3fdH+FYVkrsxqCMX3IaNuWLFf6+thH97GUm
        HEe4oT4K+GRsHewI8KZo+yFWIXteu+67vusLFrh2uSSEMdYVE4c28TbmH2uLqLlC
        k2+4GC9UggT40nVvVsjUUAzYVoLUrzDGRy3azH1SVAKV7hCeTADX+sTMDFgHK6sa
        b5ay6SIpuKXB5rE2E0odMDs3aUlIcSJhw2Dum4xUeg8kqWkR5WXuP39dROnIEJD0
        3ao/VlSZX0hs9A==
X-ME-Sender: <xms:Aj-AXMFbQLENBobDgXKLjJxiId4wqx7uKiHnWJMSmpXkyQsv4vAZaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:Aj-AXBv3on8-ReWmx18nYPJLPkX2zcCSMctwhy9DTEWdF3b2etOWIQ>
    <xmx:Aj-AXKkJBTwJqT0mpvYEFC7TFpBgp5xp6YR_Uf2m9BhKc0Fe77r3Hw>
    <xmx:Aj-AXMMH1BH_FdFPUSyccFb54d6rv2YUPj8U5SShc0ZZGPPFGsSNmQ>
    <xmx:Aj-AXDDEZPDUDFBEW3yuO3C4eCBZhV6C7z0LRODP-JGY1jcc4ObuMA>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 379DAE4240;
        Wed,  6 Mar 2019 16:43:24 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] kselftest/lib: Use new shell runner to define tests
Date:   Thu,  7 Mar 2019 08:42:22 +1100
Message-Id: <20190306214226.14598-4-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just added a new script kselftest_module.sh that can be used to
define kselftest tests that run tests within a kernel module.  We can
use it to reduce code duplication in all of the test runner scripts in
tools/testing/selftests/lib/.

Use new shell runner tools/testing/selftests/kselftest_module.sh to
define test runner scripts.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/testing/selftests/lib/bitmap.sh        | 25 ++++++++++----------
 tools/testing/selftests/lib/prime_numbers.sh | 23 +++++++++---------
 tools/testing/selftests/lib/printf.sh        | 25 ++++++++++----------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index 5a90006d1aea..ed4180ea0021 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,19 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+module=test_bitmap
+description="bitmap"
 
-# Runs bitmap infrastructure tests using test_bitmap kernel module
-if ! /sbin/modprobe -q -n test_bitmap; then
-	echo "bitmap: module test_bitmap is not found [SKIP]"
-	exit $ksft_skip
-fi
+#
+# Shouldn't need to edit anything below here.
+#
 
-if /sbin/modprobe -q test_bitmap; then
-	/sbin/modprobe -q -r test_bitmap
-	echo "bitmap: ok"
-else
-	echo "bitmap: [FAIL]"
-	exit 1
+file="kselftest_module.sh"
+path="../$file"
+if [[ ! $KBUILD_SRC == "" ]]; then
+    path="${KBUILD_SRC}/tools/testing/selftests/$file"
 fi
+
+$path $module $description
+
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 78e7483c8d60..6f782386d897 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -2,18 +2,17 @@
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+module=prime_numbers
+description="prime_numbers"
 
-if ! /sbin/modprobe -q -n prime_numbers; then
-	echo "prime_numbers: module prime_numbers is not found [SKIP]"
-	exit $ksft_skip
-fi
+#
+# Shouldn't need to edit anything below here.
+#
 
-if /sbin/modprobe -q prime_numbers selftest=65536; then
-	/sbin/modprobe -q -r prime_numbers
-	echo "prime_numbers: ok"
-else
-	echo "prime_numbers: [FAIL]"
-	exit 1
+file="kselftest_module.sh"
+path="../$file"
+if [[ ! $KBUILD_SRC == "" ]]; then
+    path="${KBUILD_SRC}/tools/testing/selftests/$file"
 fi
+
+$path $module $description
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 45a23e2d64ad..89717915d028 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,19 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Runs printf infrastructure using test_printf kernel module
+# Tests the printf infrastructure using test_printf kernel module.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+module=test_printf
+description="printf"
 
-if ! /sbin/modprobe -q -n test_printf; then
-	echo "printf: module test_printf is not found [SKIP]"
-	exit $ksft_skip
-fi
+#
+# Shouldn't need to edit anything below here.
+#
 
-if /sbin/modprobe -q test_printf; then
-	/sbin/modprobe -q -r test_printf
-	echo "printf: ok"
-else
-	echo "printf: [FAIL]"
-	exit 1
+file="kselftest_module.sh"
+path="../$file"
+if [[ ! $KBUILD_SRC == "" ]]; then
+    path="${KBUILD_SRC}/tools/testing/selftests/$file"
 fi
+
+$path $module $description
-- 
2.20.1

