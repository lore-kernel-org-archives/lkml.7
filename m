Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761D0218D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEhdfpNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfDDWKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:10:30 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56429 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbfDDWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:10:25 -0400
Received: by mail-vk1-f201.google.com with SMTP id m191so1657846vka.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xZZA9ZO9AvyPyc8p0zQtlzF4UjcXTNGJSsk4IccYADM=;
        b=jEhdfpNF9fIhHEFGb+2Hb1WpC2tWeQVpmsIjrKxlKtxxKK45b3nD38N6Q9BdQQ5S9N
         iPulwAlBtlLdcEkMVo5/gHv3iPs1Lxaaez2S+/wwRxG64kcJn7YemK0zQwllCcWoeqCr
         DeArPRbK/pb05ZveeFW5855Igl2I7HKQln5xHD3uxuyrny7k0ESwp+Uq7Ys6lfjpfbN5
         wKsDmqjwKuo8PEJMy7SmRPXsTvVkrlEO3S/r0/I9MSey1R0/IiTcwHVTlP1qsACygkKw
         VwxsvBkbA0VbFbR7yGfc4d7nU930uIsUtPxr7TsZFK5MxOA3mOHwFRdYiLjLlfGRVQwe
         BM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xZZA9ZO9AvyPyc8p0zQtlzF4UjcXTNGJSsk4IccYADM=;
        b=Sn+9hpD5Mdx3zvRTv6AoDGbJpyaevqlAMNNRUgIkWhQVJ1uPBSKdFtP4QF7K9FGFl4
         PzwHJbDfyQijK+Lr9PokzmVmgN+X1jHKQfjwrCQCFrN5+3XKJwuGfcjUdFwzVYELKeTu
         etFOB0n1rBrcnnY4oFzhQNCN5WfdqmWYA0bOt6YGEwQWhY2AunfMtNPQYLdb8gRSZFTp
         mb8KL4RcL9sJmRTSM/lYdgtckt12kOWW+x6skSv+ih8T0yA/8W4kukuEN8HR/A9aiRfa
         i3yOQ3xBVYDYyGteNKrNScBzU3FmFXxbSpzowB86D4v53Zp1f1+Mjekkunn/6dnwq/Ht
         kwpg==
X-Gm-Message-State: APjAAAUnrcqnY76NvGz9sOhMM7FLYYrn0CkAQH7aVm9ud0doh7u3Gq3H
        APLNnwW+QO4+03+AFf+Z5k8cuv6M8WSsWdDmqDVZXg==
X-Google-Smtp-Source: APXvYqw5zqt5BfIYiqLiD+3uGQUj6vjyxtH1hOI7tiv6C1Z2ysFXMOBQPmEJXA5iKToUpOIh/OTNwicicPoPz8BM0mbDuQ==
X-Received: by 2002:ab0:74d5:: with SMTP id f21mr1060439uaq.27.1554415823838;
 Thu, 04 Apr 2019 15:10:23 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:06:44 -0700
In-Reply-To: <20190404220652.19765-1-brendanhiggins@google.com>
Message-Id: <20190404220652.19765-10-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v1 09/17] kunit: test: add tests for kunit test abort
From:   Brendan Higgins <brendanhiggins@google.com>
To:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KUnit tests for the KUnit test abort mechanism (see preceding
commit). Add tests both for general try catch mechanism as well as
non-architecture specific mechanism.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/Makefile    |   3 +-
 kunit/test-test.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 kunit/test-test.c

diff --git a/kunit/Makefile b/kunit/Makefile
index 1f7680cfa11ad..533355867abd2 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			test.o \
 					kunit-stream.o \
 					try-catch.o
 
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
+obj-$(CONFIG_KUNIT_TEST) +=		test-test.o \
+					string-stream-test.o
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
diff --git a/kunit/test-test.c b/kunit/test-test.c
new file mode 100644
index 0000000000000..c81ae6efb959f
--- /dev/null
+++ b/kunit/test-test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for core test infrastructure.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+#include <kunit/test.h>
+
+struct kunit_try_catch_test_context {
+	struct kunit_try_catch *try_catch;
+	bool function_called;
+};
+
+void kunit_test_successful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+void kunit_test_no_catch(void *data)
+{
+	struct kunit *test = data;
+
+	KUNIT_FAIL(test, "Catch should not be called.\n");
+}
+
+static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_successful_try,
+			     kunit_test_no_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+void kunit_test_unsuccessful_try(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_throw(try_catch);
+	KUNIT_FAIL(test, "This line should never be reached.\n");
+}
+
+void kunit_test_catch(void *data)
+{
+	struct kunit *test = data;
+	struct kunit_try_catch_test_context *ctx = test->priv;
+
+	ctx->function_called = true;
+}
+
+static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	kunit_try_catch_init(try_catch,
+			     test,
+			     kunit_test_unsuccessful_try,
+			     kunit_test_catch);
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_generic_try_catch_successful_try_no_catch(
+		struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	try_catch->test = test;
+	kunit_generic_try_catch_init(try_catch);
+	try_catch->try = kunit_test_successful_try;
+	try_catch->catch = kunit_test_no_catch;
+
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static void kunit_test_generic_try_catch_unsuccessful_try_does_catch(
+		struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx = test->priv;
+	struct kunit_try_catch *try_catch = ctx->try_catch;
+
+	try_catch->test = test;
+	kunit_generic_try_catch_init(try_catch);
+	try_catch->try = kunit_test_unsuccessful_try;
+	try_catch->catch = kunit_test_catch;
+
+	kunit_try_catch_run(try_catch, test);
+
+	KUNIT_EXPECT_TRUE(test, ctx->function_called);
+}
+
+static int kunit_try_catch_test_init(struct kunit *test)
+{
+	struct kunit_try_catch_test_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	test->priv = ctx;
+
+	ctx->try_catch = kunit_kmalloc(test,
+				       sizeof(*ctx->try_catch),
+				       GFP_KERNEL);
+
+	return 0;
+}
+
+static struct kunit_case kunit_try_catch_test_cases[] = {
+	KUNIT_CASE(kunit_test_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_try_catch_unsuccessful_try_does_catch),
+	KUNIT_CASE(kunit_test_generic_try_catch_successful_try_no_catch),
+	KUNIT_CASE(kunit_test_generic_try_catch_unsuccessful_try_does_catch),
+	{},
+};
+
+static struct kunit_module kunit_try_catch_test_module = {
+	.name = "kunit-try-catch-test",
+	.init = kunit_try_catch_test_init,
+	.test_cases = kunit_try_catch_test_cases,
+};
+module_test(kunit_try_catch_test_module);
-- 
2.21.0.392.gf8f6787159e-goog

