Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEA2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585AB208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfmTKTRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502169AbfFLQpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:45:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438189AbfFLQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:45:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so9979401pff.9;
        Wed, 12 Jun 2019 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNvoo3jeONRzL15DraIOpBMS3MEeB4hQcXGlzhydowM=;
        b=OfmTKTRM/7n0gDgqKGUSB0C+9NVD8ZEdO9Z67WXxmY8dIrWdw0RNbatSWgrwGjL9ra
         WijuqSzEmWz8ZdPEUvZT9CIchBvAlEPt07S+ZAHjICpgyS4uZ1Lzw114fD8sfXkIkwxP
         hBYvS2mYFvLGNRFa4sNdtZ6l8c7AM9vLorKvkdxUT90O8jezIqYC8lL2jGEYZLUyzm9Q
         ypNkcB6Jrh73VMJw2IVL7m3rHaIKow8+7NGRD1JWct8VRnusxhz9826UVMepKOgXINa8
         CVw+ByZWuifCtDE5N/dm07UVyHjtO2VTcN7ax+Feqte+X0A1IiQpgqqP4BnH1HVuKkMV
         BeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNvoo3jeONRzL15DraIOpBMS3MEeB4hQcXGlzhydowM=;
        b=Ih7rKLHHTZqzVSELC7qV/I/i15C4ka6xOXXZAm3Hxf0Mbm/4QrFFeVz9DAOSYOVaN3
         +5YgF0uTLlo4U42wzWsx0zVk3NYP4vfaZkmC0PWk4Uny87qpS+FlAyPe2H6u2tHjpiBB
         9wMlithWQVcb38pcIeW9aYaVemVz0MBJ53drfUwhE+mo3VxGdxTY8XorpXjaGtgSU+rC
         nQl8Y0eW3zuukyC08Ff851/VZ9j/+IghhD0XJ2Da1s+znurnQbITHyWELNqNUu/Zkw+e
         YH07hrkhGfoyFW9GZYa27+0y1x99UvDHy6r4wrN2X45cCy1AUFhGY5orUZHFPWgewltX
         PW3g==
X-Gm-Message-State: APjAAAW4p3PMTwto5goXDIhldSXZHuqISxz3wLmhtb3O62qLgYRynd+C
        AFipseeZQCHe+rmbcnAMKYg=
X-Google-Smtp-Source: APXvYqx7Ipw6PLwyfx3ectN1oUHB36RBBmTAE8CVBXQTEt2JN6+uHKYxjX27DfozZYflDtR1NTAeHQ==
X-Received: by 2002:a63:9142:: with SMTP id l63mr8466305pge.185.1560357917167;
        Wed, 12 Jun 2019 09:45:17 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id a192sm110855pfa.84.2019.06.12.09.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:45:16 -0700 (PDT)
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com>
Date:   Wed, 12 Jun 2019 09:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

If Rob agrees, I'd like to see one more change in this patch.

Since the only caller of of_fdt_match() is of_flat_dt_match(),
can you move the body of of_fdt_match() into  of_flat_dt_match()
and eliminate of_fdt_match()?

(Noting that of_flat_dt_match() consists only of the call to
of_fdt_match().)

-Frank


On 6/11/19 6:00 PM, Kefeng Wang wrote:
> When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler warning,
> 
> drivers/of/fdt.c:129:19: warning: ‘of_fdt_match’ defined but not used [-Wunused-function]
>  static int __init of_fdt_match(const void *blob, unsigned long node,
> 
> Move of_fdt_match() and of_fdt_is_compatible() under CONFIG_OF_EARLY_FLATTREE
> to fix it.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/of/fdt.c | 106 +++++++++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3d36b5afd9bd..d6afd5b22940 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -78,38 +78,6 @@ void __init of_fdt_limit_memory(int limit)
>  	}
>  }
>  
> -/**
> - * of_fdt_is_compatible - Return true if given node from the given blob has
> - * compat in its compatible list
> - * @blob: A device tree blob
> - * @node: node to test
> - * @compat: compatible string to compare with compatible list.
> - *
> - * On match, returns a non-zero value with smaller values returned for more
> - * specific compatible values.
> - */
> -static int of_fdt_is_compatible(const void *blob,
> -		      unsigned long node, const char *compat)
> -{
> -	const char *cp;
> -	int cplen;
> -	unsigned long l, score = 0;
> -
> -	cp = fdt_getprop(blob, node, "compatible", &cplen);
> -	if (cp == NULL)
> -		return 0;
> -	while (cplen > 0) {
> -		score++;
> -		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
> -			return score;
> -		l = strlen(cp) + 1;
> -		cp += l;
> -		cplen -= l;
> -	}
> -
> -	return 0;
> -}
> -
>  static bool of_fdt_device_is_available(const void *blob, unsigned long node)
>  {
>  	const char *status = fdt_getprop(blob, node, "status", NULL);
> @@ -123,27 +91,6 @@ static bool of_fdt_device_is_available(const void *blob, unsigned long node)
>  	return false;
>  }
>  
> -/**
> - * of_fdt_match - Return true if node matches a list of compatible values
> - */
> -static int __init of_fdt_match(const void *blob, unsigned long node,> -			       const char *const *compat)
> -{
> -	unsigned int tmp, score = 0;
> -
> -	if (!compat)
> -		return 0;
> -
> -	while (*compat) {
> -		tmp = of_fdt_is_compatible(blob, node, *compat);
> -		if (tmp && (score == 0 || (tmp < score)))
> -			score = tmp;
> -		compat++;
> -	}
> -
> -	return score;
> -}
> -
>  static void *unflatten_dt_alloc(void **mem, unsigned long size,
>  				       unsigned long align)
>  {
> @@ -764,6 +711,59 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
>  	return fdt_getprop(initial_boot_params, node, name, size);
>  }
>  
> +/**
> + * of_fdt_is_compatible - Return true if given node from the given blob has
> + * compat in its compatible list
> + * @blob: A device tree blob
> + * @node: node to test
> + * @compat: compatible string to compare with compatible list.
> + *
> + * On match, returns a non-zero value with smaller values returned for more
> + * specific compatible values.
> + */
> +static int of_fdt_is_compatible(const void *blob,
> +		      unsigned long node, const char *compat)
> +{
> +	const char *cp;
> +	int cplen;
> +	unsigned long l, score = 0;
> +
> +	cp = fdt_getprop(blob, node, "compatible", &cplen);
> +	if (cp == NULL)
> +		return 0;
> +	while (cplen > 0) {
> +		score++;
> +		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
> +			return score;
> +		l = strlen(cp) + 1;
> +		cp += l;
> +		cplen -= l;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * of_fdt_match - Return true if node matches a list of compatible values
> + */
> +static int __init of_fdt_match(const void *blob, unsigned long node,
> +			       const char *const *compat)
> +{
> +	unsigned int tmp, score = 0;
> +
> +	if (!compat)
> +		return 0;
> +
> +	while (*compat) {
> +		tmp = of_fdt_is_compatible(blob, node, *compat);
> +		if (tmp && (score == 0 || (tmp < score)))
> +			score = tmp;
> +		compat++;
> +	}
> +
> +	return score;
> +}
> +
>  /**
>   * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
>   * @node: node to test
> 

