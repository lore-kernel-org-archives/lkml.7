Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CC9C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984F52089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPlP4wts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEAXEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:04:33 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:47117 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEAXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:04:31 -0400
Received: by mail-ot1-f74.google.com with SMTP id 94so285467ots.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OvFsjJX2Uyffa7cEX+3tzIASfZRboLmkTB5evz5SdF8=;
        b=qPlP4wtsZ4AQcatp9BF+OrCpLj05h8DEI/0tQy+x1kv62wInQV0ExwEGLaSfmw4wfx
         vw6ztQSToC85b77HPNuG6YPhcRe0VFLQbcP0C/R1n6r629R/7oepiRk83g6gb7uqUAJU
         x14XDp7hhyem57L5ZmWaQpCTC4n6fOPvcu7bARwPtL5iDm7KlAjijzVRvklVx5yPNctL
         XBOagQedBEK5DjJEdzWuRUIWOF/83Nj815rfBHZy2kbBvKLDAanbKfijUzWAe9klznKB
         RZeGENHbw5NMnYDuLHKUvQCi3lF7/v6gdZ3ySbcQdAiu336KQzA3HXAE7rqRLgY7Ls3v
         J8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OvFsjJX2Uyffa7cEX+3tzIASfZRboLmkTB5evz5SdF8=;
        b=Yb2qw5LgFRTnyu4mbYkRB0onRMPdtsxwCrVjI2HOxXzsKH4FRJ1EsP2Kgr7lqc9w8T
         r07MsZNN8APLnweyXzciNocc/x5UB7O1ULvp+p66N7vF56QFLfZLpF0oqBS3k1qw/js2
         qEHfRuDLk4n49Ct6lgQRCfDT+NeellKHTg9dumGft9iagmZa+CKED9Z7O/AcObx3SIWk
         XiffwdQwVhDtWEQvQpaGdb8940UGRLoVFLUv77W3Qt2sl4IEX7lwYIEOuP6RAELd1p8o
         OXcdJfFvjAj1xF8NxjKAXcwM7wAWszZQymlayAn8EoJhdtdPpefEgxHrUZzGAJXI7DbG
         0j7Q==
X-Gm-Message-State: APjAAAVRzwZPUn/QMr3LekF/eld74HrnChuAXf5MyYRzaX72iiFvQmVk
        aR59eImn88AA5jaRSkX66LZlZL+sKG/mnt7+LX5z4g==
X-Google-Smtp-Source: APXvYqwURwsTc0EBmXs/5Frvf/VNd5IIE0WpLM5wqVrJUnNg2ceQ9OXpweFVzu+hmZ8XaVWtbRFH9X4o3/ZG9dzoOx/vwg==
X-Received: by 2002:aca:d557:: with SMTP id m84mr506901oig.50.1556751870612;
 Wed, 01 May 2019 16:04:30 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:20 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 11/17] kunit: test: add test managed resource tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avinash Kondareddy <akndr41@gmail.com>

Tests how tests interact with test managed resources in their lifetime.

Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/test-test.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 4bd7a34d0a6cb..54add8ca418a0 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -135,3 +135,125 @@ static struct kunit_module kunit_try_catch_test_module = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 module_test(kunit_try_catch_test_module);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_resource(&ctx->test,
+				   fake_resource_init,
+				   fake_resource_free,
+				   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_EQ(test, &ctx->is_resource_initialized, res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_free_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_resource(&ctx->test,
+							  fake_resource_init,
+							  fake_resource_free,
+							  ctx);
+
+	kunit_free_resource(&ctx->test, res);
+
+	KUNIT_EXPECT_EQ(test, false, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[5];
+
+	for (i = 0; i < ARRAY_SIZE(resources); i++) {
+		resources[i] = kunit_alloc_resource(&ctx->test,
+						    fake_resource_init,
+						    fake_resource_free,
+						    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_free_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	{},
+};
+
+static struct kunit_module kunit_resource_test_module = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+module_test(kunit_resource_test_module);
-- 
2.21.0.593.g511ec345e18-goog

