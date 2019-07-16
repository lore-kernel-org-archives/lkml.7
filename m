Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45BC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNhhCU0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfGPAZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:25:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45095 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbfGPAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:25:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so8483020pgp.12;
        Mon, 15 Jul 2019 17:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wziVWxT4jhj1YL8MMH30E+O5fO28fTjFNy0DUs9/y1M=;
        b=pNhhCU0WdmDHPzkx3id10YV8KvhlTnul/T/fw1cvtTE+/KR/OemboYLXwHm+RntFYQ
         8UPfv1y8j0/Vcnp+mXmyDsqydJMSCBwuxQJus+8rtmcmpI2b/0IRF7sSOP1OJm3rRyFh
         Rf+WI3tWvQRi5scHRYvY4nlqf9JGpIXPbPrvJ3YrfJ3enb4nucOnh4ST6pIA7MaZ0W70
         eL1msne9/MM1yL4r6lLsngthbyihpeI9wy7j5qD4FAlk5z41STRLQofweERKkxclfhlB
         ZjD5kXOHZyLO3bsSgbCR1jVrn6VPs9EqWASM9K9H2Cf7g2Slau4KTDvFAxtJij47rUag
         DKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wziVWxT4jhj1YL8MMH30E+O5fO28fTjFNy0DUs9/y1M=;
        b=Hg+OI1EqW2+NgfdglgLIWdpcnD3aK0vACgP2j6ToP8GihJ28AcJmgoA295Mf0itkXp
         ZFVi1nIh/qTqrtfmr8sr3JSLnHLLw5OZzRSuY+KZMKGmLUtL+eKFd3o7gVNMnP+A0EdB
         3OGZo58lJhXWeYwtS3mRtKfW5dr8HkE+QUnq1UUqjvRodVAkVcsOw4PENk4oofk2407S
         ZGRHzSJAUbmhs1GaecihpR8p45ekIB00ht9TNVShG9MTHgjLGM9Ytzbr4qS5jV+WKFzi
         m5PNOc/VSj7Onwvwt7yOPJq37HHFIoYFK4fC1M8rM7imzKOwnt6E4QC3a43A4rQoeFVP
         4pqg==
X-Gm-Message-State: APjAAAXaxhAJeFFJSwFQjXlybSOYlk+8nb/S7QbAdd0jYW6y0q9K99yE
        fmL3rr9DjgCJLJjpaDLE8tQ=
X-Google-Smtp-Source: APXvYqyuHVbVfZ8StWX41YbbWpLtqcDnHpI5sEG4SXtKgAtUKZE/UTskQ6J871vMsOkwWeYlsWDETQ==
X-Received: by 2002:a63:20a:: with SMTP id 10mr29639653pgc.226.1563236723240;
        Mon, 15 Jul 2019 17:25:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm17204256pjv.21.2019.07.15.17.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 17:25:21 -0700 (PDT)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ec00d8d0-6551-274c-8a8d-a9d4c5b45d7c@roeck-us.net>
Date:   Mon, 15 Jul 2019 17:25:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/19 8:34 AM, Marc Gonzalez wrote:
> Provide devm variants for automatic resource release on device removal.
> probe() error-handling is simpler, and remove is no longer required.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Again ?

https://lore.kernel.org/patchwork/patch/755667/

This must be at least the third time this is tried. I don't think anything changed
since the previous submissions. I long since gave up and use devm_add_action_or_reset()
in affected drivers instead.

Guenter

> ---
>   Documentation/driver-model/devres.rst |  3 +++
>   drivers/clk/clk.c                     | 24 ++++++++++++++++++++++++
>   include/linux/clk.h                   |  8 ++++++++
>   3 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.rst b/Documentation/driver-model/devres.rst
> index 1b6ced8e4294..9357260576ef 100644
> --- a/Documentation/driver-model/devres.rst
> +++ b/Documentation/driver-model/devres.rst
> @@ -253,6 +253,9 @@ CLOCK
>     devm_clk_hw_register()
>     devm_of_clk_add_hw_provider()
>     devm_clk_hw_register_clkdev()
> +  devm_clk_prepare()
> +  devm_clk_enable()
> +  devm_clk_prepare_enable()
>   
>   DMA
>     dmaenginem_async_device_register()
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..5e85548357c0 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
>   }
>   EXPORT_SYMBOL_GPL(clk_prepare);
>   
> +static void unprepare(void *clk)
> +{
> +	clk_unprepare(clk);
> +}
> +
> +int devm_clk_prepare(struct device *dev, struct clk *clk)
> +{
> +	int rc = clk_prepare(clk);
> +	return rc ? : devm_add_action_or_reset(dev, unprepare, clk);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_prepare);
> +
>   static void clk_core_disable(struct clk_core *core)
>   {
>   	lockdep_assert_held(&enable_lock);
> @@ -1136,6 +1148,18 @@ int clk_enable(struct clk *clk)
>   }
>   EXPORT_SYMBOL_GPL(clk_enable);
>   
> +static void disable(void *clk)
> +{
> +	clk_disable(clk);
> +}
> +
> +int devm_clk_enable(struct device *dev, struct clk *clk)
> +{
> +	int rc = clk_enable(clk);
> +	return rc ? : devm_add_action_or_reset(dev, disable, clk);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_enable);
> +
>   static int clk_core_prepare_enable(struct clk_core *core)
>   {
>   	int ret;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 3c096c7a51dc..d09b5207e3f1 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -895,6 +895,14 @@ static inline void clk_restore_context(void) {}
>   
>   #endif
>   
> +int devm_clk_prepare(struct device *dev, struct clk *clk);
> +int devm_clk_enable(struct device *dev, struct clk *clk);
> +static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)
> +{
> +	int rc = devm_clk_prepare(dev, clk);
> +	return rc ? : devm_clk_enable(dev, clk);
> +}
> +
>   /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
>   static inline int clk_prepare_enable(struct clk *clk)
>   {
> 

