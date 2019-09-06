Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BAAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ADF214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404673AbfIFM1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:27:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:49013 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403993AbfIFM1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:27:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 05:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="383238151"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2019 05:27:44 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6DL5-0006Qi-Ns; Fri, 06 Sep 2019 15:27:43 +0300
Date:   Fri, 6 Sep 2019 15:27:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] software node: implement reference properties
Message-ID: <20190906122743.GQ2680@smile.fi.intel.com>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:38:07PM -0700, Dmitry Torokhov wrote:
> It is possible to store references to software nodes in the same fashion as
> other static properties, so that users do not need to define separate
> structures:
> 
> const struct software_node gpio_bank_b_node = {
> 	.name = "B",
> };

Why this can't be __initconst?

> const struct property_entry simone_key_enter_props[] __initconst = {
> 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> 	PROPERTY_ENTRY_STRING("label", "enter"),
> 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> 	{ }
> };

So it's basically mimics the concept of phandle, right?

> +		ref_args = prop->is_array ?
> +				&prop->pointer.ref[index] : &prop->value.ref;

Better to do if with explicit 'if ()' as it's done in the rest of the code.

	if (prop->is_array)
		ref_args = ...;
	else
		ref_args = ...;

> -	DEV_PROP_MAX,
> +	DEV_PROP_MAX

It seems it wasn't ever used, so, can be dropped completely.

> @@ -240,6 +255,7 @@ struct property_entry {
>  			const u32 *u32_data;
>  			const u64 *u64_data;
>  			const char * const *str;
> +			const struct software_node_ref_args *ref;
>  		} pointer;
>  		union {
>  			u8 u8_data;
> @@ -247,6 +263,7 @@ struct property_entry {
>  			u32 u32_data;
>  			u64 u64_data;
>  			const char *str;
> +			struct software_node_ref_args ref;

Hmm... This bumps the size of union a lot for each existing property_entry.
Is there any other way? Maybe we can keep pointer and allocate memory for it
when copying?

>  		} value;

> +#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)			\
> +(struct property_entry) {					\
> +	.name = _name_,						\
> +	.length = ARRAY_SIZE(_val_) *				\
> +			sizeof(struct software_node_ref_args),	\

I would rather leave it on one line and shift right all \:s in this macro.

> +	.is_array = true,					\
> +	.type = DEV_PROP_REF,					\
> +	.pointer.ref = _val_,					\
> +}
> +

> +#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)			\
> +(struct property_entry) {					\
> +	.name = _name_,						\
> +	.length = sizeof(struct software_node_ref_args),	\
> +	.type = DEV_PROP_REF,					\
> +	.value.ref.node = _ref_,				\

> +	.value.ref.nargs =					\
> +		ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\

Ditto.

> +	.value.ref.args = { __VA_ARGS__ },			\
> +}

-- 
With Best Regards,
Andy Shevchenko


