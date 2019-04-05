Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A44CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39FB2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429614;
	bh=PD6taVZ0dW7tlw6PmNmnXPsy40bqBz5mRFAdd8OoCNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IxPbvZxqb0JK5//yDIPSoAWUyMZc+38H4WB5OIi5j7Fel2IKcpOU/5LCfk4/nXAQ3
	 Cg9aIzSnT9x9fI3Wgu5BNEGX3OksMFz6Ygl6vuMbJp3r1JfgyvNF5NtNXuFEOMrB8T
	 C+aDsTiVh0kHAJj69x6k04xO4pYZgvj2h5ZJeifw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfDECAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36571 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E15FC24962;
        Thu,  4 Apr 2019 22:00:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 22:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LuxwcA2TQYJNnoyAr3NXG34releY26e4OP8jY85HShk=; b=b2KY/vpY
        T0xFDc17InaPlNelj/FEwFtQB8suyQM2y0q4ureRkALeB9q+Q4vAX0hm6/akkGUg
        RngyQPZQTjsZLL3n77KaAzg6MqSVcOA8aRGv0CSWoVnAHNnAh5I4R41VHFd786wW
        M8PHuzFz4pI305YDSAMk1oKTF9zQMlM/AQZpQLTEkJSHKFkugAI/PCfdyaTs62lt
        bTG+mmgzdZoNSJMLJyx/27jb9VPMOOULzKPijXDZIAFZKw0+Fd6c4Z2jqntmXho/
        gS2vG+RB/aA7ajX3gy9aMaxbEv2XB/XRhnCpzUl6UJsYPytbb/8SkUe2BbIwue02
        kbHAk0qhNWb73A==
X-ME-Sender: <xms:q7amXMviTrbSA6UBBBsNFqpW2IqqwZf3bWfu5a0Va3qT4lJGHjM5Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedu
X-ME-Proxy: <xmx:q7amXDsrbji_dEfoQFebVpT5g0eQBYpFDqtJlqgTlYy5TAzWIsLLwA>
    <xmx:q7amXGsWaAP-UfdH4eg4I46x0Dj9u36kMiE3ljSkXMZXXWwLNbJRZA>
    <xmx:q7amXG3MWIqnCMG3hCtseZ2veFGLeIEWK9D0UtPeFmav2n1lU89yHw>
    <xmx:q7amXLYcWFM7FACoM_hqPBqky6cOYIizemlRg_u3cAzcQDiwPVZ7AQ>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id C27651039B;
        Thu,  4 Apr 2019 22:00:05 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v4 2/6] kselftest: Add test runner creation script
Date:   Fri,  5 Apr 2019 12:58:55 +1100
Message-Id: <20190405015859.32755-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we wish to use kselftest to run tests within a kernel
module we write a small script to load/unload and do error reporting.
There are a bunch of these under tools/testing/selftests/lib/ that are
all identical except for the test name.  We can reduce code duplication
and improve maintainability if we have one version of this.  However
kselftest requires an executable for each test.  We can move all the
script logic to a central script then have each individual test script
call the main script.

Oneliner to call kselftest_module.sh courtesy of Kees, thanks!

Add test runner creation script.  Convert
tools/testing/selftests/lib/*.sh to use new test creation script.

Testing
-------

Configure kselftests for lib/ then build and boot kernel.  Then run
kselftests as follows:

  $ cd /path/to/kernel/tree
  $ sudo make O=$output_path -C tools/testing/selftests TARGETS="lib" run_tests

and also

  $ cd /path/to/kernel/tree
  $ cd tools/testing/selftests
  $ sudo make O=$output_path TARGETS="lib" run_tests

and also

  $ cd /path/to/kernel/tree
  $ cd tools/testing/selftests
  $ sudo make TARGETS="lib" run_tests

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/testing/selftests/kselftest_module.sh  | 84 ++++++++++++++++++++
 tools/testing/selftests/lib/bitmap.sh        | 18 +----
 tools/testing/selftests/lib/prime_numbers.sh | 17 +---
 tools/testing/selftests/lib/printf.sh        | 19 +----
 4 files changed, 88 insertions(+), 50 deletions(-)
 create mode 100755 tools/testing/selftests/kselftest_module.sh

diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
new file mode 100755
index 000000000000..18e1c7992d30
--- /dev/null
+++ b/tools/testing/selftests/kselftest_module.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+
+#
+# Runs an individual test module.
+#
+# kselftest expects a separate executable for each test, this can be
+# created by adding a script like this:
+#
+#   #!/bin/sh
+#   SPDX-License-Identifier: GPL-2.0+
+#   $(dirname $0)/../kselftest_module.sh "description" module_name
+#
+# Example: tools/testing/selftests/lib/printf.sh
+
+desc=""				# Output prefix.
+module=""			# Filename (without the .ko).
+args=""				# modprobe arguments.
+
+modprobe="/sbin/modprobe"
+
+main() {
+    parse_args "$@"
+    assert_root
+    assert_have_module
+    run_module
+}
+
+parse_args() {
+    script=${0##*/}
+
+    if [ $# -lt 2 ]; then
+	echo "Usage: $script <description> <module_name> [FAIL]"
+	exit 1
+    fi
+
+    desc="$1"
+    shift || true
+    module="$1"
+    shift || true
+    args="$@"
+}
+
+assert_root() {
+    if [ ! -w /dev ]; then
+	skip "please run as root"
+    fi
+}
+
+assert_have_module() {
+    if ! $modprobe -q -n $module; then
+	skip "module $module is not found"
+    fi
+}
+
+run_module() {
+    if $modprobe -q $module $args; then
+	$modprobe -q -r $module
+	say "ok"
+    else
+	fail ""
+    fi
+}
+
+say() {
+    echo "$desc: $1"
+}
+
+
+fail() {
+    say "$1 [FAIL]" >&2
+    exit 1
+}
+
+skip() {
+    say "$1 [SKIP]" >&2
+    # Kselftest framework requirement - SKIP code is 4.
+    exit 4
+}
+
+#
+# Main script
+#
+main "$@"
diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
index 5a90006d1aea..5511dddc5c2d 100755
--- a/tools/testing/selftests/lib/bitmap.sh
+++ b/tools/testing/selftests/lib/bitmap.sh
@@ -1,19 +1,3 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# Runs bitmap infrastructure tests using test_bitmap kernel module
-if ! /sbin/modprobe -q -n test_bitmap; then
-	echo "bitmap: module test_bitmap is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q test_bitmap; then
-	/sbin/modprobe -q -r test_bitmap
-	echo "bitmap: ok"
-else
-	echo "bitmap: [FAIL]"
-	exit 1
-fi
+$(dirname $0)/../kselftest_module.sh "bitmap" test_bitmap
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
index 78e7483c8d60..43b28f24e453 100755
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ b/tools/testing/selftests/lib/prime_numbers.sh
@@ -1,19 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Checks fast/slow prime_number generation for inconsistencies
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if ! /sbin/modprobe -q -n prime_numbers; then
-	echo "prime_numbers: module prime_numbers is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q prime_numbers selftest=65536; then
-	/sbin/modprobe -q -r prime_numbers
-	echo "prime_numbers: ok"
-else
-	echo "prime_numbers: [FAIL]"
-	exit 1
-fi
+$(dirname $0)/../kselftest_module.sh "prime numbers" prime_numbers selftest=65536
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
index 45a23e2d64ad..2ffa61da0296 100755
--- a/tools/testing/selftests/lib/printf.sh
+++ b/tools/testing/selftests/lib/printf.sh
@@ -1,19 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Runs printf infrastructure using test_printf kernel module
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if ! /sbin/modprobe -q -n test_printf; then
-	echo "printf: module test_printf is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q test_printf; then
-	/sbin/modprobe -q -r test_printf
-	echo "printf: ok"
-else
-	echo "printf: [FAIL]"
-	exit 1
-fi
+# Tests the printf infrastructure using test_printf kernel module.
+$(dirname $0)/../kselftest_module.sh "printf" test_printf
-- 
2.21.0

