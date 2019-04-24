Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6C6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8hjbWX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbfDXTA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:00:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37608 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:00:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so21585782qtn.4;
        Wed, 24 Apr 2019 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/FZy59f9HL2X3MbfHJ0G6hsGqO3psViqlKPPUuR6fNo=;
        b=q8hjbWX2/Rq8XC2LdcrnlAoOXnEfA1kmjBBoylIKum+3GuPG+zohCguBwww/MCJ27F
         oqJ0YEK1RBIjN8M28mclgqIGpx9KY4vsqtgcI4QZmFwm862SeoLxoe0jow7+T+KUQu27
         WLQTZvoXEz67t5F2LIeQNdpvHdwucTr9N2E17CKBc4M6eRwl5SVW3s961l4+qfXcRKu5
         7F7X9P4gKJ8e/9KCahWT1BVt9mNNLy9NDfwdyz4glnUCLytljhJ567AOR4LOutX2xGY+
         gnCR/16WqvnZT+26eBlWypqTiBPvPYfdNlQCiGYfJ6AEySKTmO8iYKjTZbFUMU9eUkvN
         iXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/FZy59f9HL2X3MbfHJ0G6hsGqO3psViqlKPPUuR6fNo=;
        b=Ynec4lVb/eKIVDVWtdjPsNs5cnXvvnAU9KiS9X/4NuYfIy2tLvPFKHEoAhBWz4y+Z+
         XRha2H3m7+EqxT1vyDHmRO/Cxon4yD97n+F7Wss1X6Cx9AQilRxjSOUKHYOBQ4vduJp3
         3doBCGL7lRgDSMUMmjL7geRbXW+OxNCwkIAXWg16TH7e4wB9bm8EvQz9Pfn7QevoxhFv
         YiSAkSn6V7zcrAUKuRY1FlLbqiJKF/j8xLmqVhvCGHM9+pPG5w65FtUyXCmd6+EGl04h
         yxSgZNoTwb36N7Oepd+QnLp80BdTx98ze0grVkNeC8KAPU90rOkrFoQdftdTtaPffiAb
         xj5Q==
X-Gm-Message-State: APjAAAVgobMPsNL4XYr4q1yYpkOA9+qsXoOkuOtjSPWcz05OEpqLTBg6
        AsZaOnOtpJCWGvL0eaEWnQ==
X-Google-Smtp-Source: APXvYqzUa37EIznTuZsKVCE0rtxzmrSbjNdVJfiGIZUk8HNfZfY91SDsdlfuvH2z2xBujvCQv9HiBQ==
X-Received: by 2002:aed:35fa:: with SMTP id d55mr3416038qte.169.1556132424044;
        Wed, 24 Apr 2019 12:00:24 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z85sm9183651qka.18.2019.04.24.12.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:00:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:00:20 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com,
        pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
        dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
        joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Tim.Bird@sony.com, Avinash Kondareddy <akndr41@gmail.com>,
        linux-um@lists.infradead.org, rostedt@goodmis.org,
        julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 11/17] kunit: test: add test managed resource tests
Message-ID: <20190424190019.wvljyeo3y7gd24p5@gabell>
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-12-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404220652.19765-12-brendanhiggins@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:06:46PM -0700, Brendan Higgins wrote:
> From: Avinash Kondareddy <akndr41@gmail.com>
> 
> Tests how tests interact with test managed resources in their lifetime.
> 
> Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  kunit/test-test.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
> 
> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 4bd7a34d0a6cb..54add8ca418a0 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
> @@ -135,3 +135,125 @@ static struct kunit_module kunit_try_catch_test_module = {
>  	.test_cases = kunit_try_catch_test_cases,
>  };
>  module_test(kunit_try_catch_test_module);
> +
> +/*
> + * Context for testing test managed resources
> + * is_resource_initialized is used to test arbitrary resources
> + */
> +struct kunit_test_resource_context {
> +	struct kunit test;
> +	bool is_resource_initialized;
> +};
> +
> +static int fake_resource_init(struct kunit_resource *res, void *context)
> +{
> +	struct kunit_test_resource_context *ctx = context;
> +
> +	res->allocation = &ctx->is_resource_initialized;
> +	ctx->is_resource_initialized = true;
> +	return 0;
> +}
> +
> +static void fake_resource_free(struct kunit_resource *res)
> +{
> +	bool *is_resource_initialized = res->allocation;
> +
> +	*is_resource_initialized = false;
> +}
> +
> +static void kunit_resource_test_init_resources(struct kunit *test)
> +{
> +	struct kunit_test_resource_context *ctx = test->priv;
> +
> +	kunit_init_test(&ctx->test, "testing_test_init_test");
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> +}
> +
> +static void kunit_resource_test_alloc_resource(struct kunit *test)
> +{
> +	struct kunit_test_resource_context *ctx = test->priv;
> +	struct kunit_resource *res;
> +	kunit_resource_free_t free = fake_resource_free;
> +
> +	res = kunit_alloc_resource(&ctx->test,
> +				   fake_resource_init,
> +				   fake_resource_free,
> +				   ctx);
> +

> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);

	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, res);

Thanks!
Masa
