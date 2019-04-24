Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656BB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLotHtY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388362AbfDXS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:58:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33974 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:58:25 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so11540744qka.1;
        Wed, 24 Apr 2019 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UctWeOPYH7gh4xbfG1yAVrMDrr9BA28kij+L+zI8ew=;
        b=CLotHtY+q8bXpvMX/SmQYLYdHZDyptDBtVd2cOQxdfaESxO2GsaKBrVF49T8XhHBCG
         Szqjxn5y7AoftBOAS7GPEHxEAWyzpAK2xrGl2bZBmHGrZ+rjWzBZObsUloOpGA8UTEQZ
         kZQUgRbPVKQ9r3GhKJgmOXE/mrXnfkT0RfZRB7ybzGmJPsfAwouSLyKmAjjiJGiqn7OP
         Cvt7SiavnNk5zXR6a6jFgB4tjsojrv5Az9VpqVXcJjpKcJ14M55qHMrYQDwyBrPy9xu8
         GzkveWV12G8hWu9HkoHepAdt5dv7rStCnYO8qRP82Q9471RkyW7m8IH6sRVxInSuA1aC
         4yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UctWeOPYH7gh4xbfG1yAVrMDrr9BA28kij+L+zI8ew=;
        b=NncOPWAGT+Z8jhL/FERUSTVw/VKvHpIn12dCtptDgpquk4nRvGUJapk6OYrdX+jkl2
         tYxAILOgKytuqj/AxcClc6gZgCsBpliuIopH6YQTFXDdUZ076ERcbTSRuZCQi7heOz5V
         0WBCkB3DY1acKNkCFcJtvArsIwvLZoGwWifOIGXIl02/DLUIa9BxZMbR7OqVUGG2ccLA
         XIxXHrdvz/oKwh2kH/XiCs+7KuX4pTdglapqX2r4q4DWdED9VaMcm8shPtTaSr1IfCVX
         +3pP27y50SjFxokzPUf1zX3ACgI8mGhmjK4XpmY1ySQQYFEM4kC3H+w7t0Q3seDKkqul
         LYpA==
X-Gm-Message-State: APjAAAUdpBQt/v3GhraOCdcXin0DuaUN9a7NwLIKSiqlkngaPMMOJM1d
        o4emcW5O73WTObtKSC4nnqxuUHk=
X-Google-Smtp-Source: APXvYqySASYIr0SDVnE1yI4p69ruXx8VnZB5EJq1r5YfXGQ2XGY2NfeGtV1O8ehNtrYV+VmNpea+aA==
X-Received: by 2002:a05:620a:1334:: with SMTP id p20mr1205504qkj.244.1556132304679;
        Wed, 24 Apr 2019 11:58:24 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h189sm564936qkc.89.2019.04.24.11.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 11:58:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:58:14 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com,
        pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
        dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        khilman@baylibre.com, knut.omang@oracle.com,
        Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
        joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Tim.Bird@sony.com, linux-um@lists.infradead.org,
        rostedt@goodmis.org, julia.lawall@lip6.fr,
        kunit-dev@googlegroups.com, richard@nod.at,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 14/17] Documentation: kunit: add documentation for
 KUnit
Message-ID: <20190424185813.xabwr4lt6aunvpsd@gabell>
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-15-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404220652.19765-15-brendanhiggins@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

KUNIT_ASSERT_NOT_ERR_OR_NULL() should be replaced to
KUNIT_EXPECT_NOT_ERR_OR_NULL(), right?

On Thu, Apr 04, 2019 at 03:06:49PM -0700, Brendan Higgins wrote:
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

<snip>

> diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
> new file mode 100644
> index 0000000000000..5cdba5091905e
> --- /dev/null
> +++ b/Documentation/kunit/start.rst

<snip>

> +Assertions
> +~~~~~~~~~~
> +
> +KUnit also has the concept of an *assertion*. An assertion is just like an
> +expectation except the assertion immediately terminates the test case if it is
> +not satisfied.
> +
> +For example:
> +
> +.. code-block:: c
> +
> +	static void mock_test_do_expect_default_return(struct kunit *test)
> +	{
> +		struct mock_test_context *ctx = test->priv;
> +		struct mock *mock = ctx->mock;
> +		int param0 = 5, param1 = -5;
> +		const char *two_param_types[] = {"int", "int"};
> +		const void *two_params[] = {&param0, &param1};
> +		const void *ret;
> +
> +		ret = mock->do_expect(mock,
> +				      "test_printk", test_printk,
> +				      two_param_types, two_params,
> +				      ARRAY_SIZE(two_params));

> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);

		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);

> +		KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
> +	}
> +
> +In this example, the method under test should return a pointer to a value, so
> +if the pointer returned by the method is null or an errno, we don't want to
> +bother continuing the test since the following expectation could crash the test

> +case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if

  +case. `KUNIT_EXPECT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if

Thanks!
Masa
