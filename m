Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F15C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392C2206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551908621;
	bh=I8k24VApWGki4z9qimp4y8hzuSvhLqPYElOeLyPVLog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+SQVF5yBgJTmmFzaotDwHSY8RmwgNdblQg+4mMNIxoDLy5lL0DScLqEHVPdalX7J
	 sAvd3aQJJXWbYBYE1i/5w6+TjTesT+tCSzTtH5NPSFtmJmco0/xniiT9QoLq7dt/25
	 PReBHpnvzAa2ulqyjw9Yq7rC0TMdR23/CkKWQJvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCFVnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:43:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39585 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbfCFVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:43:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CCE9B22B6A;
        Wed,  6 Mar 2019 16:43:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Mar 2019 16:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=7RCtABdbAJh7ag4bDRO1qAGVOkgFNMZVsbJDyJA5Cn0=; b=AO3NbWHK
        6lDne96gU9QFipRPT9pVAckg5u8uzngqMzretn9cYKTOc35zO/tJZgccpMNy2Yj0
        Yh7zP3WAvjVigTki6u8prDUCpVt8tbOY1gv587c4xJqmlemsrU9xOYN16qQ8Z10M
        NVK8FSG8p24a3xDavjaA4p9Mms52yjff3LcH0gBKJ7O334lz8nNk9iP3b1fcGbRx
        d7OoUh17urkVDfBEyjvfneSlm+aZ0mewHfw+mun83gx6TrKVkgA5poaLGmpEJDd0
        GgRqYgJsP5Dwmc3coDQWYvV6uebVZ3ENMaW9jXZbobRogbLem4cgkH+j8OMR2zX7
        dTnstgHEaZAIqw==
X-ME-Sender: <xms:CD-AXGjvwu3aY4bEdcA3Sypr_J7PmZoRRvCvR52Q_tTrUTKh8er7Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:CD-AXOziwSuifzKKV0joLj2zfRTi_RBtnj3GPkVgsx6tEVxieIp17g>
    <xmx:CD-AXBIiXxfj93mgUEkub5Kprm8iB2ycqKwD5jLjG2GYn4Z67I3X5w>
    <xmx:CD-AXNQuR3uo0ha1p2NAFrCLYImsKN4DLZZYZVrTA7HklhTtB8Dn6Q>
    <xmx:CD-AXAAFM2rcOnZmcvRBmnadBfbNb_CdMToBQjhhJpNtEfWUiWParw>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 350A7E4240;
        Wed,  6 Mar 2019 16:43:30 -0500 (EST)
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
Subject: [PATCH v3 4/7] kselftest: Add test module framework header
Date:   Thu,  7 Mar 2019 08:42:23 +1100
Message-Id: <20190306214226.14598-5-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
References: <20190306214226.14598-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kselftest runs as a userspace process.  Sometimes we need to test things
from kernel space.  One way of doing this is by creating a test module.
Currently doing so requires developers to write a bunch of boiler plate
in the module if kselftest is to be used to run the tests.  This means
we currently have a load of duplicate code to achieve these ends.  If we
have a uniform method for implementing test modules then we can reduce
code duplication, ensure uniformity in the test framework, ease code
maintenance, and reduce the work required to create tests.  This all
helps to encourage developers to write and run tests.

Add a C header file that can be included in test modules.  This provides
a single point for common test functions/macros.  Implement a few macros
that make up the start of the test framework.

Add documentation for new kselftest header and script to kselftest
documentation.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/dev-tools/kselftest.rst      | 108 ++++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h |  48 +++++++++
 2 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kselftest_module.h

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 7756f7a7c23b..fb7790d47147 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -14,6 +14,10 @@ in safe mode with a limited scope. In limited mode, cpu-hotplug test is
 run on a single cpu as opposed to all hotplug capable cpus, and memory
 hotplug test is run on 2% of hotplug capable memory instead of 10%.
 
+kselftest runs as a userspace process.  Tests that can be written/run in
+userspace may wish to use the `Test Harness`_.  Tests that need to be
+run in kernel space may wish to use a `Test Module`_.
+
 Running the selftests (hotplug tests are run in limited mode)
 =============================================================
 
@@ -161,11 +165,111 @@ Contributing new tests (details)
 
    e.g: tools/testing/selftests/android/config
 
+Test Module
+===========
+
+Kselftest tests the kernel from userspace.  Sometimes things need
+testing from within the kernel, one method of doing this is to create a
+test module.  We can tie the module into the kselftest framework by
+using a shell script test runner.  ``kselftest_module.sh`` is designed
+to facilitate this process.  There is also a header file provided to
+assist writing kernel modules that are for use with kselftest:
+
+- ``tools/testing/kselftest/kselftest_module.h``
+- ``tools/testing/kselftest/kselftest_module.sh``
+
+How to use
+----------
+
+Here we show the typical steps to create a test module and tie it into
+kselftest.  We use kselftests for lib/ as an example.
+
+1. Create the test module
+
+2. Create the test script that will run (load/unload) the module
+   e.g. ``tools/testing/selftests/lib/printf.sh``
+
+3. Add line to config file e.g. ``tools/testing/selftests/lib/config``
+
+4. Add test script to makefile  e.g. ``tools/testing/selftests/lib/Makefile``
+
+5. Verify it works:
+
+.. code-block:: sh
+
+   # Assumes you have booted a fresh build of this kernel tree
+   cd /path/to/linux/tree
+   make kselftest-merge
+   make modules
+   sudo make modules_install
+   make TARGETS=lib kselftest
+
+Example Module
+--------------
+
+A bare bones test module might look like this:
+
+.. code-block:: c
+
+   // SPDX-License-Identifier: GPL-2.0+
+
+   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+   #include "../tools/testing/selftests/kselftest_module.h"
+
+   KSTM_MODULE_GLOBALS();
+
+   /*
+    * Kernel module for testing the foobinator
+    */
+
+   static int __init test_function()
+   {
+           ...
+   }
+
+   static void __init selftest(void)
+   {
+           KSTM_CHECK_ZERO(do_test_case("", 0));
+   }
+
+   KSTM_MODULE_LOADERS(test_foo);
+   MODULE_AUTHOR("John Developer <jd@fooman.org>");
+   MODULE_LICENSE("GPL");
+
+Example test script
+-------------------
+
+.. code-block:: sh
+
+    #!/bin/bash
+    # SPDX-License-Identifier: GPL-2.0+
+
+    module_name="test_foo"		# Module name (without the .ko).
+    description="foo"			# Output prefix.
+
+    #
+    # Shouldn't need to edit anything below here.
+    #
+
+    file="kselftest_module.sh"
+    path="../$file"
+    if [[ ! $KBUILD_SRC == "" ]]; then
+        path="${KBUILD_SRC}/tools/testing/selftests/$file"
+    fi
+
+    $path $module_name $description
+
+
 Test Harness
 ============
 
-The kselftest_harness.h file contains useful helpers to build tests.  The tests
-from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as example.
+The kselftest_harness.h file contains useful helpers to build tests.  The
+test harness is for userspace testing, for kernel space testing see `Test
+Module`_ above.
+
+The tests from tools/testing/selftests/seccomp/seccomp_bpf.c can be used as
+example.
 
 Example
 -------
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
new file mode 100644
index 000000000000..e8eafaf0941a
--- /dev/null
+++ b/tools/testing/selftests/kselftest_module.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __KSELFTEST_MODULE_H
+#define __KSELFTEST_MODULE_H
+
+#include <linux/module.h>
+
+/*
+ * Test framework for writing test modules to be loaded by kselftest.
+ * See Documentation/dev-tools/kselftest.rst for an example test module.
+ */
+
+#define KSTM_MODULE_GLOBALS()			\
+static unsigned int total_tests __initdata;	\
+static unsigned int failed_tests __initdata
+
+#define KSTM_CHECK_ZERO(x) do {						\
+	total_tests++;							\
+	if (x) {							\
+		pr_warn("TC failed at %s:%d\n", __func__, __LINE__);	\
+		failed_tests++;						\
+	}								\
+} while (0)
+
+static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
+{
+	if (failed_tests == 0)
+		pr_info("all %u tests passed\n", total_tests);
+	else
+		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
+
+	return failed_tests ? -EINVAL : 0;
+}
+
+#define KSTM_MODULE_LOADERS(__module)			\
+static int __init __module##_init(void)			\
+{							\
+	pr_info("loaded.\n");				\
+	selftest();					\
+	return kstm_report(total_tests, failed_tests);	\
+}							\
+static void __exit __module##_exit(void)		\
+{							\
+	pr_info("unloaded.\n");				\
+}							\
+module_init(__module##_init);				\
+module_exit(__module##_exit)
+
+#endif	/* __KSELFTEST_MODULE_H */
-- 
2.20.1

