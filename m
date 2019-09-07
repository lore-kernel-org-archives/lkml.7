Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C98AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00CC218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394878AbfIGQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:08:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:35977 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbfIGQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:08:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 09:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,477,1559545200"; 
   d="scan'208";a="208536647"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2019 09:08:20 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6dG7-0007Qh-Js; Sat, 07 Sep 2019 19:08:19 +0300
Date:   Sat, 7 Sep 2019 19:08:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907160819.GH2680@smile.fi.intel.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> It is possible to store references to software nodes in the same fashion as
> other static properties, so that users do not need to define separate
> structures:
> 
> static const struct software_node gpio_bank_b_node = {
> 	.name = "B",
> };
> 
> static const struct property_entry simone_key_enter_props[] = {
> 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> 	PROPERTY_ENTRY_STRING("label", "enter"),
> 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> 	{ }
> };
> 

Thanks for an update, my comments below.

> +	} else if (src->type == DEV_PROP_REF) {
> +		/* All reference properties must be arrays */
> +		return -EINVAL;

Hmm... What about to duplicate pointer under value union and use is_array to
distinguish which one to use? Because...


> @@ -240,6 +254,7 @@ struct property_entry {
>  			const u32 *u32_data;
>  			const u64 *u64_data;
>  			const char * const *str;
> +			const struct software_node_ref_args *ref;
>  		} pointer;

> +#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
> +(struct property_entry) {						\
> +	.name = _name_,							\

> +	.length = sizeof(struct software_node_ref_args),		\

Is it correct?

> +	.type = DEV_PROP_REF,						\

> +	.is_array = true,						\

I really don't like this "cheating".

> +	.type = DEV_PROP_REF,						\
> +	.pointer.ref = &(const struct software_node_ref_args) {		\
> +		.node = _ref_,						\

> +		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\

Seems like you can drop pair of parentheses.

> +		.args = { __VA_ARGS__ },				\
> +	},								\
> +}

-- 
With Best Regards,
Andy Shevchenko


