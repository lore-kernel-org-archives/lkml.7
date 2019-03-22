Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLZDpqJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCVBQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:16:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43712 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:16:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so312540pfd.10;
        Thu, 21 Mar 2019 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pwUBku5UEiZrBRJiT3/z4l7/uCX0QYALtFeeNV8kouQ=;
        b=KLZDpqJ5hnWrfzOrEhdLsd9TpfMXW6hNnnLtOC1o+K62UY1Hae/dsH7FHjV0LajJye
         zzswpwri74xwcSjmkCLWkdwin2tqOoQLdIUr+LcBWSFn8xli8WLGRfVZZ95WNh9long5
         ax5DfB8I0MxIUhTOIpg/IOtHzPBDW/JnfNyTRm6gZqybz5G1EhPyyl2YqzPzKnPum++b
         cHOQIpamxsBGekYkanZJh1v5EkNhXEPV4dhgWX0mpqvD+zXO3M+ZZQekfGdjhZCwOZ7B
         0CqemOZMvHTcKOBPSVDYRJXntVwWPXLh0LrAoPgoxrtOvifL/cbBnL5lSCyCbOW82zZo
         kqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pwUBku5UEiZrBRJiT3/z4l7/uCX0QYALtFeeNV8kouQ=;
        b=D1Aj9KmzIxRwC0HeoEGNjN3W5YmP130eyAqLPYztV+8aqzbUzLr2xNdaSpOJPmqqoH
         bO4WykkJ0WZY1JF7fQpAAj3an5dfyrjDm/X/fhJee6gPjtFk5PX3vNWZLBlmGndpJSSH
         78Uwfqq9aO8DRpv8QhEKYInJVN7y2e2ipVh1agpth4rxNtJnYLfdE7zJSqDQfrW0NDlo
         t4AAdG8BuXPFF6RktZKiKNFnrILFIHTTMW124ubWl/3JVvRCLMBxAZYAurP6z7fHysqF
         y3oJ5GEyJ3TnASjN1ejM/yT/mA8vMoV5dh/VjLZsQSgfImzYef67NLqudPmUH1L2fqWD
         ZZXw==
X-Gm-Message-State: APjAAAXzLFgy/gfvGA716Ij8hy2UiMiI71FS/V5IW2YtkOBX4PQZ+OqY
        93LNe/EoZ5slSbP4zOvD8OE=
X-Google-Smtp-Source: APXvYqwo8Uvut4mQy4ctKr87kVV6ogl3labr7QgxJ1lP3rTGla5vVVZF58gl0RJz/1Uo85zz8Gx9oA==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr6852993plf.330.1553217366245;
        Thu, 21 Mar 2019 18:16:06 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87sm8839099pfj.20.2019.03.21.18.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:16:05 -0700 (PDT)
Subject: Re: [RFC v4 17/17] of: unittest: split up some super large test cases
To:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org,
        kieran.bingham@ideasonboard.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-18-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <09b06e6d-fd36-707e-cb7a-e935bd930510@gmail.com>
Date:   Thu, 21 Mar 2019 18:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-18-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 1:37 PM, Brendan Higgins wrote:
> Split up the super large test cases of_unittest_find_node_by_name and
> of_unittest_dynamic into properly sized and defined test cases.

I also still object to this patch.

-Frank


> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/base-test.c | 297 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 249 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/of/base-test.c b/drivers/of/base-test.c
> index 3d3f4f1b74800..7b44c967ed2fd 100644
> --- a/drivers/of/base-test.c
> +++ b/drivers/of/base-test.c
> @@ -8,10 +8,10 @@
>  
>  #include "test-common.h"
>  
> -static void of_unittest_find_node_by_name(struct kunit *test)
> +static void of_test_find_node_by_name_basic(struct kunit *test)
>  {
>  	struct device_node *np;
> -	const char *options, *name;
> +	const char *name;
>  
>  	np = of_find_node_by_path("/testcase-data");
>  	name = kasprintf(GFP_KERNEL, "%pOF", np);
> @@ -20,11 +20,21 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  			       "find /testcase-data failed\n");
>  	of_node_put(np);
>  	kfree(name);
> +}
>  
> +static void of_test_find_node_by_name_trailing_slash(struct kunit *test)
> +{
>  	/* Test if trailing '/' works */
>  	KUNIT_EXPECT_EQ_MSG(test, of_find_node_by_path("/testcase-data/"), NULL,
>  			    "trailing '/' on /testcase-data/ should fail\n");
>  
> +}
> +
> +static void of_test_find_node_by_name_multiple_components(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *name;
> +
>  	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
>  	name = kasprintf(GFP_KERNEL, "%pOF", np);
> @@ -33,6 +43,12 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  		"find /testcase-data/phandle-tests/consumer-a failed\n");
>  	of_node_put(np);
>  	kfree(name);
> +}
> +
> +static void of_test_find_node_by_name_with_alias(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *name;
>  
>  	np = of_find_node_by_path("testcase-alias");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> @@ -41,10 +57,23 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  			       "find testcase-alias failed\n");
>  	of_node_put(np);
>  	kfree(name);
> +}
>  
> +static void of_test_find_node_by_name_with_alias_and_slash(struct kunit *test)
> +{
>  	/* Test if trailing '/' works on aliases */
>  	KUNIT_EXPECT_EQ_MSG(test, of_find_node_by_path("testcase-alias/"), NULL,
> -			    "trailing '/' on testcase-alias/ should fail\n");
> +			   "trailing '/' on testcase-alias/ should fail\n");
> +}
> +
> +/*
> + * TODO(brendanhiggins@google.com): This looks like a duplicate of
> + * of_test_find_node_by_name_multiple_components
> + */
> +static void of_test_find_node_by_name_multiple_components_2(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *name;
>  
>  	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> @@ -54,17 +83,33 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  		"find testcase-alias/phandle-tests/consumer-a failed\n");
>  	of_node_put(np);
>  	kfree(name);
> +}
> +
> +static void of_test_find_node_by_name_missing_path(struct kunit *test)
> +{
> +	struct device_node *np;
>  
>  	KUNIT_EXPECT_EQ_MSG(
>  		test,
>  		np = of_find_node_by_path("/testcase-data/missing-path"), NULL,
>  		"non-existent path returned node %pOF\n", np);
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_missing_alias(struct kunit *test)
> +{
> +	struct device_node *np;
>  
>  	KUNIT_EXPECT_EQ_MSG(
>  		test, np = of_find_node_by_path("missing-alias"), NULL,
>  		"non-existent alias returned node %pOF\n", np);
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_missing_alias_with_relative_path(
> +		struct kunit *test)
> +{
> +	struct device_node *np;
>  
>  	KUNIT_EXPECT_EQ_MSG(
>  		test,
> @@ -72,12 +117,24 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  		"non-existent alias with relative path returned node %pOF\n",
>  		np);
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_option(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	np = of_find_node_opts_by_path("/testcase-data:testoption", &options);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
>  	KUNIT_EXPECT_STREQ_MSG(test, "testoption", options,
>  			       "option path test failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_option_and_slash(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	np = of_find_node_opts_by_path("/testcase-data:test/option", &options);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> @@ -90,11 +147,22 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  	KUNIT_EXPECT_STREQ_MSG(test, "test/option", options,
>  			       "option path test, subcase #2 failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_null_option(struct kunit *test)
> +{
> +	struct device_node *np;
>  
>  	np = of_find_node_opts_by_path("/testcase-data:testoption", NULL);
>  	KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, np,
>  					 "NULL option path test failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_option_alias(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	np = of_find_node_opts_by_path("testcase-alias:testaliasoption",
>  				       &options);
> @@ -102,6 +170,13 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  	KUNIT_EXPECT_STREQ_MSG(test, "testaliasoption", options,
>  			       "option alias path test failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_option_alias_and_slash(
> +		struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	np = of_find_node_opts_by_path("testcase-alias:test/alias/option",
>  				       &options);
> @@ -109,11 +184,22 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  	KUNIT_EXPECT_STREQ_MSG(test, "test/alias/option", options,
>  			       "option alias path test, subcase #1 failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_with_null_option_alias(struct kunit *test)
> +{
> +	struct device_node *np;
>  
>  	np = of_find_node_opts_by_path("testcase-alias:testaliasoption", NULL);
>  	KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(
>  			test, np, "NULL option alias path test failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_option_clearing(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	options = "testoption";
>  	np = of_find_node_opts_by_path("testcase-alias", &options);
> @@ -121,6 +207,12 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  	KUNIT_EXPECT_EQ_MSG(test, options, NULL,
>  			    "option clearing test failed\n");
>  	of_node_put(np);
> +}
> +
> +static void of_test_find_node_by_name_option_clearing_root(struct kunit *test)
> +{
> +	struct device_node *np;
> +	const char *options;
>  
>  	options = "testoption";
>  	np = of_find_node_opts_by_path("/", &options);
> @@ -130,65 +222,147 @@ static void of_unittest_find_node_by_name(struct kunit *test)
>  	of_node_put(np);
>  }
>  
> -static void of_unittest_dynamic(struct kunit *test)
> +static int of_test_find_node_by_name_init(struct kunit *test)
>  {
> +	/* adding data for unittest */
> +	KUNIT_ASSERT_EQ(test, 0, unittest_data_add());
> +
> +	if (!of_aliases)
> +		of_aliases = of_find_node_by_path("/aliases");
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_find_node_by_path(
> +			"/testcase-data/phandle-tests/consumer-a"));
> +
> +	return 0;
> +}
> +
> +static struct kunit_case of_test_find_node_by_name_cases[] = {
> +	KUNIT_CASE(of_test_find_node_by_name_basic),
> +	KUNIT_CASE(of_test_find_node_by_name_trailing_slash),
> +	KUNIT_CASE(of_test_find_node_by_name_multiple_components),
> +	KUNIT_CASE(of_test_find_node_by_name_with_alias),
> +	KUNIT_CASE(of_test_find_node_by_name_with_alias_and_slash),
> +	KUNIT_CASE(of_test_find_node_by_name_multiple_components_2),
> +	KUNIT_CASE(of_test_find_node_by_name_missing_path),
> +	KUNIT_CASE(of_test_find_node_by_name_missing_alias),
> +	KUNIT_CASE(of_test_find_node_by_name_missing_alias_with_relative_path),
> +	KUNIT_CASE(of_test_find_node_by_name_with_option),
> +	KUNIT_CASE(of_test_find_node_by_name_with_option_and_slash),
> +	KUNIT_CASE(of_test_find_node_by_name_with_null_option),
> +	KUNIT_CASE(of_test_find_node_by_name_with_option_alias),
> +	KUNIT_CASE(of_test_find_node_by_name_with_option_alias_and_slash),
> +	KUNIT_CASE(of_test_find_node_by_name_with_null_option_alias),
> +	KUNIT_CASE(of_test_find_node_by_name_option_clearing),
> +	KUNIT_CASE(of_test_find_node_by_name_option_clearing_root),
> +	{},
> +};
> +
> +static struct kunit_module of_test_find_node_by_name_module = {
> +	.name = "of-test-find-node-by-name",
> +	.init = of_test_find_node_by_name_init,
> +	.test_cases = of_test_find_node_by_name_cases,
> +};
> +module_test(of_test_find_node_by_name_module);
> +
> +struct of_test_dynamic_context {
>  	struct device_node *np;
> -	struct property *prop;
> +	struct property *prop0;
> +	struct property *prop1;
> +};
>  
> -	np = of_find_node_by_path("/testcase-data");
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +static void of_test_dynamic_basic(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +	struct property *prop0 = ctx->prop0;
>  
> -	/* Array of 4 properties for the purpose of testing */
> -	prop = kcalloc(4, sizeof(*prop), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prop);
> +	/* Add a new property - should pass*/
> +	prop0->name = "new-property";
> +	prop0->value = "new-property-data";
> +	prop0->length = strlen(prop0->value) + 1;
> +	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop0), 0,
> +			    "Adding a new property failed\n");
> +
> +	/* Test that we can remove a property */
> +	KUNIT_EXPECT_EQ(test, of_remove_property(np, prop0), 0);
> +}
> +
> +static void of_test_dynamic_add_existing_property(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +	struct property *prop0 = ctx->prop0, *prop1 = ctx->prop1;
>  
>  	/* Add a new property - should pass*/
> -	prop->name = "new-property";
> -	prop->value = "new-property-data";
> -	prop->length = strlen(prop->value) + 1;
> -	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop), 0,
> +	prop0->name = "new-property";
> +	prop0->value = "new-property-data";
> +	prop0->length = strlen(prop0->value) + 1;
> +	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop0), 0,
>  			    "Adding a new property failed\n");
>  
>  	/* Try to add an existing property - should fail */
> -	prop++;
> -	prop->name = "new-property";
> -	prop->value = "new-property-data-should-fail";
> -	prop->length = strlen(prop->value) + 1;
> -	KUNIT_EXPECT_NE_MSG(test, of_add_property(np, prop), 0,
> +	prop1->name = "new-property";
> +	prop1->value = "new-property-data-should-fail";
> +	prop1->length = strlen(prop1->value) + 1;
> +	KUNIT_EXPECT_NE_MSG(test, of_add_property(np, prop1), 0,
>  			    "Adding an existing property should have failed\n");
> +}
> +
> +static void of_test_dynamic_modify_existing_property(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +	struct property *prop0 = ctx->prop0, *prop1 = ctx->prop1;
> +
> +	/* Add a new property - should pass*/
> +	prop0->name = "new-property";
> +	prop0->value = "new-property-data";
> +	prop0->length = strlen(prop0->value) + 1;
> +	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop0), 0,
> +			    "Adding a new property failed\n");
>  
>  	/* Try to modify an existing property - should pass */
> -	prop->value = "modify-property-data-should-pass";
> -	prop->length = strlen(prop->value) + 1;
> -	KUNIT_EXPECT_EQ_MSG(
> -		test, of_update_property(np, prop), 0,
> -		"Updating an existing property should have passed\n");
> +	prop1->name = "new-property";
> +	prop1->value = "modify-property-data-should-pass";
> +	prop1->length = strlen(prop1->value) + 1;
> +	KUNIT_EXPECT_EQ_MSG(test, of_update_property(np, prop1), 0,
> +			    "Updating an existing property should have passed\n");
> +}
> +
> +static void of_test_dynamic_modify_non_existent_property(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +	struct property *prop0 = ctx->prop0;
>  
>  	/* Try to modify non-existent property - should pass*/
> -	prop++;
> -	prop->name = "modify-property";
> -	prop->value = "modify-missing-property-data-should-pass";
> -	prop->length = strlen(prop->value) + 1;
> -	KUNIT_EXPECT_EQ_MSG(test, of_update_property(np, prop), 0,
> +	prop0->name = "modify-property";
> +	prop0->value = "modify-missing-property-data-should-pass";
> +	prop0->length = strlen(prop0->value) + 1;
> +	KUNIT_EXPECT_EQ_MSG(test, of_update_property(np, prop0), 0,
>  			    "Updating a missing property should have passed\n");
> +}
>  
> -	/* Remove property - should pass */
> -	KUNIT_EXPECT_EQ_MSG(test, of_remove_property(np, prop), 0,
> -			    "Removing a property should have passed\n");
> +static void of_test_dynamic_large_property(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +	struct property *prop0 = ctx->prop0;
>  
>  	/* Adding very large property - should pass */
> -	prop++;
> -	prop->name = "large-property-PAGE_SIZEx8";
> -	prop->length = PAGE_SIZE * 8;
> -	prop->value = kzalloc(prop->length, GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prop->value);
> -	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop), 0,
> +	prop0->name = "large-property-PAGE_SIZEx8";
> +	prop0->length = PAGE_SIZE * 8;
> +	prop0->value = kunit_kzalloc(test, prop0->length, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prop0->value);
> +
> +	KUNIT_EXPECT_EQ_MSG(test, of_add_property(np, prop0), 0,
>  			    "Adding a large property should have passed\n");
>  }
>  
> -static int of_test_init(struct kunit *test)
> +static int of_test_dynamic_init(struct kunit *test)
>  {
> -	/* adding data for unittest */
> +	struct of_test_dynamic_context *ctx;
> +
>  	KUNIT_ASSERT_EQ(test, 0, unittest_data_add());
>  
>  	if (!of_aliases)
> @@ -197,18 +371,45 @@ static int of_test_init(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_find_node_by_path(
>  			"/testcase-data/phandle-tests/consumer-a"));
>  
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +	test->priv = ctx;
> +
> +	ctx->np = of_find_node_by_path("/testcase-data");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->np);
> +
> +	ctx->prop0 = kunit_kzalloc(test, sizeof(*ctx->prop0), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->prop0);
> +
> +	ctx->prop1 = kunit_kzalloc(test, sizeof(*ctx->prop1), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->prop1);
> +
>  	return 0;
>  }
>  
> -static struct kunit_case of_test_cases[] = {
> -	KUNIT_CASE(of_unittest_find_node_by_name),
> -	KUNIT_CASE(of_unittest_dynamic),
> +static void of_test_dynamic_exit(struct kunit *test)
> +{
> +	struct of_test_dynamic_context *ctx = test->priv;
> +	struct device_node *np = ctx->np;
> +
> +	of_remove_property(np, ctx->prop0);
> +	of_remove_property(np, ctx->prop1);
> +	of_node_put(np);
> +}
> +
> +static struct kunit_case of_test_dynamic_cases[] = {
> +	KUNIT_CASE(of_test_dynamic_basic),
> +	KUNIT_CASE(of_test_dynamic_add_existing_property),
> +	KUNIT_CASE(of_test_dynamic_modify_existing_property),
> +	KUNIT_CASE(of_test_dynamic_modify_non_existent_property),
> +	KUNIT_CASE(of_test_dynamic_large_property),
>  	{},
>  };
>  
> -static struct kunit_module of_test_module = {
> -	.name = "of-base-test",
> -	.init = of_test_init,
> -	.test_cases = of_test_cases,
> +static struct kunit_module of_test_dynamic_module = {
> +	.name = "of-dynamic-test",
> +	.init = of_test_dynamic_init,
> +	.exit = of_test_dynamic_exit,
> +	.test_cases = of_test_dynamic_cases,
>  };
> -module_test(of_test_module);
> +module_test(of_test_dynamic_module);
> 

