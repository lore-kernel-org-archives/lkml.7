Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778E52171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429621;
	bh=hjtdk3h2z7EBRl3S08IZeKstUfq2PQx9T9twO4A6Izk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7fqqDT3Q2XUUEEdrWrJ/dSevsZ5qO0GeELEoa+TYLf36jmGxYcn64nxoUTdyfJ+e
	 jPG4DF8EBWSGzBWdZFdbdCL5jYHwDPN4zMHXwgVV1fHgRmz1MKB9LcN8jGCzQooS5R
	 2zE+q8bf4I7cieqr5GxZbzLULyxcFevbpYLZFdKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfDECAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:00:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57951 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727051AbfDECAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:00:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AA40D24BF1;
        Thu,  4 Apr 2019 22:00:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2019 22:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZCPoVm3c/aDatSPSEWIy/ABm05Z1o6QsVVRHRX6rMuA=; b=fUIxs2Hn
        taDA4meVA+92wKx+osRLZFMCrqLH0hZkP/IJ7xRFp0UF3QkOOIa+NyPd563Mzd3P
        e8ERDKps7zo4qKB/oYGmzxegTwQARfDYUk5RVDrbxyQui79/ReZc+NvaFxwFDEPr
        rBAfnTi/9XWe/Qb6W/HyqBZ7Nf1QHAcv3wK9NvIlzjyJ/e5EYW/29Zq59Ngiqm3V
        6IUdYZqigtnqwavq3SMd98sCh6LOkDu+B7mdxQ/4B92bJLoyHtA8JC5k+cqU5zdS
        5XzZRmtqEpKG+r6mfQueYXDKwpY/OgFWFw5NbKIZYbqihxT04gH9lhzAgAW+nZ9a
        G9+jkIqyVouXXw==
X-ME-Sender: <xms:sramXCPR4ke_saqHD4bjh0ZYuV2W1n4Y5XuzfFMB5K13tNq1k7UvgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeigdehtdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudegledruddugedrkeeinecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedv
X-ME-Proxy: <xmx:sramXGvD4nQ0wyjb4ZqsNmJoNiGM3ktQMYZ4qVmNWzX_5K95RiJ1Wg>
    <xmx:sramXAH48eXNWobM8gkHGsRybXwLYA7YAKMozJHzNw4BvZhsoG5NZw>
    <xmx:sramXJ4VVIfDk4WGLN66w0lteedEMUeet6ydCdIwRE82YLvLiUy3vA>
    <xmx:sramXIiZltAQRAR_JyiyMmtb_7lmQRFMJQE1_Ygey39Llc7SrwEl5g>
Received: from eros.localdomain (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DAF71031A;
        Thu,  4 Apr 2019 22:00:12 -0400 (EDT)
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
Subject: [PATCH v4 3/6] kselftest: Add test module framework header
Date:   Fri,  5 Apr 2019 12:58:56 +1100
Message-Id: <20190405015859.32755-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405015859.32755-1-tobin@kernel.org>
References: <20190405015859.32755-1-tobin@kernel.org>
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

Add documentation for new kselftest header to kselftest documentation.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/dev-tools/kselftest.rst      | 94 +++++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h | 48 +++++++++++
 2 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kselftest_module.h

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index 7756f7a7c23b..c8c03388b9de 100644
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
 
@@ -161,11 +165,97 @@ Contributing new tests (details)
 
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
+    $(dirname $0)/../kselftest_module.sh "foo" test_foo
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
2.21.0

