Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC852C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62B21882
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMOpz5h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437402AbfIUATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:19:46 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42641 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437365AbfIUATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:19:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id d1so5474794plj.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aABf1eQBMP6/WvpZsyoq3EyRjH0cX7yhFaKM6+EkpH4=;
        b=PMOpz5h1AvlOt0m6YYDep8+YwUi0+uS6UYKiuBcIu67gaVLwTAUFdQKvDfK9G3EWtN
         KpkL5bmO9VK2dY335TWCcBKwtUIxGeXPzal2qhClzljYwhXymLL3BDq0KtRJT81RFT91
         vyCbacm0HPk9RVeRJygf1yjoy+X5JqNVvwvyUfteH3Nfbmpy5y8HU1ZqVyY1/0zYDxad
         HfHh6hPQTaWEcWoxlUyGb4Tr42zzSruPcUqrGzC6OKKX5qp0dGjAZ/nLNx0YZaaGt5z7
         i/8Y29qPcoxJXrESNiaulFT4uZSvTsQSoPRXPvZYfm9XEBG6yLanmX8wbRHk5htX1tD4
         d1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aABf1eQBMP6/WvpZsyoq3EyRjH0cX7yhFaKM6+EkpH4=;
        b=K5Lxv74s45dpbF0x8Nmrzr+15QnYxFtoBBTSB2Ua5Y28dSpajt6VjHRuSIXa4jzT/U
         F89av8nsCfWDZsjN9pp4n+7bHcYFoDERByjngmsqQ7EQt/2hXpau7k//0m+8pTzcXwOr
         buFbRAwVUu2Q8WuAmv1+bJuKyEANBl95f91FgAhBvKdnT9bf/WfpN1oktXeLu8tEq5r7
         UZh6iQLaSVE1RE+qiI6oob171VvRA9MtLtNX7H82xBUl2OTjlc1Rqyz4vt3JE7k64eRd
         q8ViKUTo8sdVn2Yv7URqROTDHGmtw+Aa6BqIf5sxrj6fZ1JFYBtqBM/zcEFsh9LOTHQQ
         a/wQ==
X-Gm-Message-State: APjAAAVbUamtMIV3s+rnFIPqKLxWvtfKjcDy8md2MGmQRBvnUyq+MvQR
        v26V6rLr4pXewA6jrEAO6iS8tNshGCdvDz87/ZflyQ==
X-Google-Smtp-Source: APXvYqzwGcI6oV4RJqsbxOwmibaBw72BKc+cPxbRTVIXwJjw2dMVToTXTU1oWnylc9oA8cJPUc0hE0/maVk0eMOfOWBc1A==
X-Received: by 2002:a63:5652:: with SMTP id g18mr15027188pgm.393.1569025177910;
 Fri, 20 Sep 2019 17:19:37 -0700 (PDT)
Date:   Fri, 20 Sep 2019 17:18:48 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-13-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 12/19] kunit: test: add tests for KUnit managed resources
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
        wfg@linux.intel.com, torvalds@linux-foundation.org,
        Avinash Kondareddy <akndr41@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avinash Kondareddy <akndr41@gmail.com>

Add unit tests for KUnit managed resources. KUnit managed resources
(struct kunit_resource) are resources that are automatically cleaned up
at the end of a KUnit test, similar to the concept of devm_* managed
resources.

Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/test-test.c | 228 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index e0ab4bd546ea..5ebe059d16e2 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -101,3 +101,231 @@ static struct kunit_suite kunit_try_catch_test_suite = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 kunit_test_suite(kunit_try_catch_test_suite);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+	int allocate_order[2];
+	int free_order[2];
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
+	res = kunit_alloc_and_get_resource(&ctx->test,
+					   fake_resource_init,
+					   fake_resource_free,
+					   GFP_KERNEL,
+					   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    &ctx->is_resource_initialized,
+			    (bool *) res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_PTR_EQ(test, free, res->free);
+}
+
+static void kunit_resource_test_destroy_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	KUNIT_ASSERT_FALSE(test,
+			   kunit_resource_destroy(&ctx->test,
+						  kunit_resource_instance_match,
+						  res->free,
+						  res->allocation));
+
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
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
+		resources[i] = kunit_alloc_and_get_resource(&ctx->test,
+							    fake_resource_init,
+							    fake_resource_free,
+							    GFP_KERNEL,
+							    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_mark_order(int order_array[],
+					   size_t order_size,
+					   int key)
+{
+	int i;
+
+	for (i = 0; i < order_size && order_array[i]; i++)
+		;
+
+	order_array[i] = key;
+}
+
+#define KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, order_field, key)		       \
+		kunit_resource_test_mark_order(ctx->order_field,	       \
+					       ARRAY_SIZE(ctx->order_field),   \
+					       key)
+
+static int fake_resource_2_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 2);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_2_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 2);
+}
+
+static int fake_resource_1_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_2_init,
+				     fake_resource_2_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, allocate_order, 1);
+
+	res->allocation = ctx;
+
+	return 0;
+}
+
+static void fake_resource_1_free(struct kunit_resource *res)
+{
+	struct kunit_test_resource_context *ctx = res->allocation;
+
+	KUNIT_RESOURCE_TEST_MARK_ORDER(ctx, free_order, 1);
+}
+
+/*
+ * TODO(brendanhiggins@google.com): replace the arrays that keep track of the
+ * order of allocation and freeing with strict mocks using the IN_SEQUENCE macro
+ * to assert allocation and freeing order when the feature becomes available.
+ */
+static void kunit_resource_test_proper_free_ordering(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	/* fake_resource_1 allocates a fake_resource_2 in its init. */
+	kunit_alloc_and_get_resource(&ctx->test,
+				     fake_resource_1_init,
+				     fake_resource_1_free,
+				     GFP_KERNEL,
+				     ctx);
+
+	/*
+	 * Since fake_resource_2_init calls KUNIT_RESOURCE_TEST_MARK_ORDER
+	 * before returning to fake_resource_1_init, it should be the first to
+	 * put its key in the allocate_order array.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[0], 2);
+	KUNIT_EXPECT_EQ(test, ctx->allocate_order[1], 1);
+
+	kunit_cleanup(&ctx->test);
+
+	/*
+	 * Because fake_resource_2 finishes allocation before fake_resource_1,
+	 * fake_resource_1 should be freed first since it could depend on
+	 * fake_resource_2.
+	 */
+	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 1);
+	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
+}
+
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
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
+	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
+	{}
+};
+
+static struct kunit_suite kunit_resource_test_suite = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+kunit_test_suite(kunit_resource_test_suite);
-- 
2.23.0.351.gc4317032e6-goog

