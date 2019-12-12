Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BBC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F1F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfLLOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:47:54 -0500
Received: from foss.arm.com ([217.140.110.172]:49364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbfLLOry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:47:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85557DA7;
        Thu, 12 Dec 2019 06:47:53 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7613F6CF;
        Thu, 12 Dec 2019 06:47:51 -0800 (PST)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cf5b3dee-061e-a476-7219-aa08c2977488@arm.com>
Date:   Thu, 12 Dec 2019 14:47:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 1:53 pm, Marc Gonzalez wrote:
> On 11/12/2019 23:28, Dmitry Torokhov wrote:
> 
>> On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
>>
>>> What is the rationale for the devm_add_action API?
>>
>> For one-off and maybe complex unwind actions in drivers that wish to use
>> devm API (as mixing devm and manual release is verboten). Also is often
>> used when some core subsystem does not provide enough devm APIs.
> 
> Thanks for the insight, Dmitry. Thanks to Robin too.
> 
> This is what I understand so far:
> 
> devm_add_action() is nice because it hides/factorizes the complexity
> of the devres API, but it incurs a small storage overhead of one
> pointer per call, which makes it unfit for frequently used actions,
> such as clk_get.
> 
> Is that correct?
> 
> My question is: why not design the API without the small overhead?

Probably because on most architectures, ARCH_KMALLOC_MINALIGN is at 
least as big as two pointers anyway, so this "overhead" should mostly be 
free in practice. Plus the devres API is almost entirely about being 
able to write simple robust code, rather than absolute efficiency - I 
mean, struct devres itself is already 5 pointers large at the absolute 
minimum ;)

In summary: the email client in which I'm writing this is currently 
using 2.3GB of my workstation's 64GB of RAM; welcome to 21st century 
software... :P

Robin.

> Proof of concept below:
> 
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 0bbb328bd17f..76392dd6273b 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
>   }
>   EXPORT_SYMBOL_GPL(devres_release_group);
>   
> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> +{
> +	void *data = devres_alloc(func, size, GFP_KERNEL);
> +
> +	if (data) {
> +		memcpy(data, arg, size);
> +		devres_add(dev, data);
> +	} else
> +		func(dev, arg);
> +
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(devm_add);
> +
>   /*
>    * Custom devres actions allow inserting a simple function call
>    * into the teadown sequence.
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index be160764911b..8db671823126 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -4,6 +4,11 @@
>   #include <linux/export.h>
>   #include <linux/gfp.h>
>   
> +static void __clk_put(struct device *dev, void *data)
> +{
> +	clk_put(*(struct clk **)data);
> +}
> +
>   static void devm_clk_release(struct device *dev, void *res)
>   {
>   	clk_put(*(struct clk **)res);
> @@ -11,19 +16,11 @@ static void devm_clk_release(struct device *dev, void *res)
>   
>   struct clk *devm_clk_get(struct device *dev, const char *id)
>   {
> -	struct clk **ptr, *clk;
> -
> -	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct clk *clk = clk_get(dev, id);
>   
> -	clk = clk_get(dev, id);
> -	if (!IS_ERR(clk)) {
> -		*ptr = clk;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (!IS_ERR(clk))
> +		if (!devm_add(dev, __clk_put, &clk, sizeof(clk)))
> +			clk = ERR_PTR(-ENOMEM);
>   
>   	return clk;
>   }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e226030c1df3..5acb61ec39ab 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -970,6 +970,7 @@ void __iomem *devm_of_iomap(struct device *dev,
>   			    resource_size_t *size);
>   
>   /* allows to add/remove a custom action to devres stack */
> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size);
>   int devm_add_action(struct device *dev, void (*action)(void *), void *data);
>   void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
>   void devm_release_action(struct device *dev, void (*action)(void *), void *data);
> 
