Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E792064A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAWrooa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfHTXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:22:27 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55625 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHTXVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:21:14 -0400
Received: by mail-pl1-f201.google.com with SMTP id h3so249933plr.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8/RELIk14kWBv27EgIXLTSHUSZfhnU4HitpJgSxlsJc=;
        b=lAWrooa4yqef6YwjzOvxJntjecrUtTH8a8l/75KgzyNQtOLIKkKDscG8VAKUjTxSCS
         P6LNRlxuAPRkCP+EcO7Qy0qbcO4jt1n5FVMHBUlxuCi74I9CAdFmnwbHMKP0Ysra1yWq
         6L+TBW5YEX6cPTBoyHgz+5Ke23bViLMOiDM5vHTrJQFhcWjjg5cSbW+LuNmxYxiOy1Nz
         E5T6kQ2VBP2YYSozKtkz15gM+f/arZFkJmR+TmNbnzdMfjXdzbGjYiJdAOcndlgZIXhm
         /S+XneK0CsFc/sa+cYIFVQqUCUeuX+p7W9pVc0JsplIvEwdJrzCcGPHEwpWT0bgiyipQ
         f8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8/RELIk14kWBv27EgIXLTSHUSZfhnU4HitpJgSxlsJc=;
        b=YvizJjyMlapkz6FKzGs5MLfDbVucUbP3vVYzrtd0H7CKHlYTWAWyPqC2LGb/Nno/pL
         mEhg7wAZmyeizI3GkDbhshgRm8BSTKumAQRHubZq/bjM12JWI2HMAA8yZzQPEfQ35smj
         dzD/I9Q9ZTpIy/cSzZqg92Kx3qZ9rhLCVcMEh0qL8L1xDmQH3Bp+O24HSeyBK7fuJA3m
         wHp4rC94JNwhiqW0QbIJVDP6mQAVofAmDBz01MK/fMzXd+BtyQ18QtfmMeucJIH885Su
         /2LJShnaiSvNbFK1Uv3Qsrs+LYo7TQ/Z05IX0TlH6j8klgXcCDzW9JM2lBxnilgrASMn
         DYHw==
X-Gm-Message-State: APjAAAWTiWP7rpAeDP2LM3CemXfRCsb/ED8Sd8/kflGeC3jShseCuwd6
        prbGOsOUyPgX3r3VR5vRnUfgsVTq3RoZb7y4KK1iBg==
X-Google-Smtp-Source: APXvYqwmhtTK8Q+n2DmxPlzT1DPPG+2JJVoouOrVXR+wIMLY3pfV1BusEPPhYk1QQvZ0xIUyEZCTN+kg44EW3GkFAHVyFQ==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr27331741pgk.363.1566343272807;
 Tue, 20 Aug 2019 16:21:12 -0700 (PDT)
Date:   Tue, 20 Aug 2019 16:20:35 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 07/18] kunit: test: add initial tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for string stream along with a simpler example.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 kunit/Kconfig              | 21 +++++++++
 kunit/Makefile             |  4 ++
 kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
 kunit/string-stream-test.c | 52 ++++++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 kunit/example-test.c
 create mode 100644 kunit/string-stream-test.c

diff --git a/kunit/Kconfig b/kunit/Kconfig
index 330ae83527c23..8541ef95b65ad 100644
--- a/kunit/Kconfig
+++ b/kunit/Kconfig
@@ -14,4 +14,25 @@ config KUNIT
 	  architectures. For more information, please see
 	  Documentation/dev-tools/kunit/.
 
+config KUNIT_TEST
+	bool "KUnit test for KUnit"
+	depends on KUNIT
+	help
+	  Enables the unit tests for the KUnit test framework. These tests test
+	  the KUnit test framework itself; the tests are both written using
+	  KUnit and test KUnit. This option should only be enabled for testing
+	  purposes by developers interested in testing that KUnit works as
+	  expected.
+
+config KUNIT_EXAMPLE_TEST
+	bool "Example test for KUnit"
+	depends on KUNIT
+	help
+	  Enables an example unit test that illustrates some of the basic
+	  features of KUnit. This test only exists to help new users understand
+	  what KUnit is and how it is used. Please refer to the example test
+	  itself, kunit/example-test.c, for more information. This option is
+	  intended for curious hackers who would like to understand how to use
+	  KUnit for kernel development.
+
 endmenu
diff --git a/kunit/Makefile b/kunit/Makefile
index 6dcbe309036b8..4e46450bcb3a8 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1,3 +1,7 @@
 obj-$(CONFIG_KUNIT) +=			test.o \
 					string-stream.o \
 					assert.o
+
+obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/example-test.c b/kunit/example-test.c
new file mode 100644
index 0000000000000..f64a829aa441f
--- /dev/null
+++ b/kunit/example-test.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test to show how to use KUnit.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This is the most fundamental element of KUnit, the test case. A test case
+ * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
+ * any expectations or assertions are not met, the test fails; otherwise, the
+ * test passes.
+ *
+ * In KUnit, a test case is just a function with the signature
+ * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
+ * information about the current test.
+ */
+static void example_simple_test(struct kunit *test)
+{
+	/*
+	 * This is an EXPECTATION; it is how KUnit tests things. When you want
+	 * to test a piece of code, you set some expectations about what the
+	 * code should do. KUnit then runs the test and verifies that the code's
+	 * behavior matched what was expected.
+	 */
+	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
+}
+
+/*
+ * This is run once before each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static int example_test_init(struct kunit *test)
+{
+	kunit_info(test, "initializing\n");
+
+	return 0;
+}
+
+/*
+ * Here we make a list of all the test cases we want to add to the test suite
+ * below.
+ */
+static struct kunit_case example_test_cases[] = {
+	/*
+	 * This is a helper to create a test case object from a test case
+	 * function; its exact function is not important to understand how to
+	 * use KUnit, just know that this is how you associate test cases with a
+	 * test suite.
+	 */
+	KUNIT_CASE(example_simple_test),
+	{}
+};
+
+/*
+ * This defines a suite or grouping of tests.
+ *
+ * Test cases are defined as belonging to the suite by adding them to
+ * `kunit_cases`.
+ *
+ * Often it is desirable to run some function which will set up things which
+ * will be used by every test; this is accomplished with an `init` function
+ * which runs before each test case is invoked. Similarly, an `exit` function
+ * may be specified which runs after every test case and can be used to for
+ * cleanup. For clarity, running tests in a test suite would behave as follows:
+ *
+ * suite.init(test);
+ * suite.test_case[0](test);
+ * suite.exit(test);
+ * suite.init(test);
+ * suite.test_case[1](test);
+ * suite.exit(test);
+ * ...;
+ */
+static struct kunit_suite example_test_suite = {
+	.name = "example",
+	.init = example_test_init,
+	.test_cases = example_test_cases,
+};
+
+/*
+ * This registers the above test suite telling KUnit that this is a suite of
+ * tests that need to be run.
+ */
+kunit_test_suite(example_test_suite);
diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
new file mode 100644
index 0000000000000..75229e267c323
--- /dev/null
+++ b/kunit/string-stream-test.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for struct string_stream.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+#include <linux/slab.h>
+
+static void string_stream_test_empty_on_creation(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_not_empty_after_add(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+
+	string_stream_add(stream, "Foo");
+
+	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
+}
+
+static void string_stream_test_get_string(struct kunit *test)
+{
+	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
+	char *output;
+
+	string_stream_add(stream, "Foo");
+	string_stream_add(stream, " %s", "bar");
+
+	output = string_stream_get_string(stream);
+	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
+}
+
+static struct kunit_case string_stream_test_cases[] = {
+	KUNIT_CASE(string_stream_test_empty_on_creation),
+	KUNIT_CASE(string_stream_test_not_empty_after_add),
+	KUNIT_CASE(string_stream_test_get_string),
+	{}
+};
+
+static struct kunit_suite string_stream_test_suite = {
+	.name = "string-stream-test",
+	.test_cases = string_stream_test_cases
+};
+kunit_test_suite(string_stream_test_suite);
-- 
2.23.0.rc1.153.gdeed80330f-goog

