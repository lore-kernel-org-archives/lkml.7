Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F66D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG2g/uq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfFQS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:56:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40229 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:56:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so6163918pfp.7;
        Mon, 17 Jun 2019 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=256+CBIaZgrDdUBpx7HVGfWhTIjDyF5LSlnyeLtyzBw=;
        b=kG2g/uq9Xr2Pc0CyyyFe0B6J4bLIWCATK9CfOd9BGvag8ncxAnxn7KNVSFbLrlXbRr
         VgiOIZ2KsqsamsPc+5QF5uc3U55HK8OrPWiLx89IpfVwQ/8OTp9pVxLBqVLkdJqi07Yj
         UOulN9woL9gbN0c0VQZGTAfAhnqpvdpvx91oYT6sUvrdNasWWrXfSDofTi6ngTdOCLrc
         Kqz34siW5PdTUrDXFcraiOupFthgq+cVZmmaA7gIWzRZxW/vvZ2znUyQH7YdmQueU5r2
         bowbriBVZKwuFyw1OwVx/vEtKNuoHZ+r54/gYKRWQxGE/1TxMShQlR2ZFIAWf2YwtcDX
         x5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=256+CBIaZgrDdUBpx7HVGfWhTIjDyF5LSlnyeLtyzBw=;
        b=J1QsOgfjSCE1JyrgJI4pPWySy3nzLRFVIraqF2QfoOOw/4ymvXPJTRLdb057kqttKo
         ORbjwRj6ZT6MHdRuIccVv95Tr71Hls+w81MwYAkU0WUDbSOmlcKBQInpPjo22h22EL4y
         009hxNXnTsr/nBHathiD2tXHTBAfAAu83KyUiWlzHD/HjjNNCWU+swTdseTdmtDLDptX
         1Qo3T66Lfyt14k6hpb6yAkhp2NGrshSH6oF1uuEvf9KG/uH4vRBAw8hSZ6gXn/xeVsnY
         zgEeLK0UWsomuZqUtPmiGKiVGfQbSfVNvyDFj+l8zlnSgdabR7mgtwBmkU9K/YVuLcMI
         MdHA==
X-Gm-Message-State: APjAAAWjOwSnPHf+OZhsMu8LQF31HXum3MzU/RfgDRidAWvAAELhtgST
        GMb+CTWrYdPYnPgK9kw49Og=
X-Google-Smtp-Source: APXvYqwAzLnp5l57GVA4wZ3TfOel22trPomcvzwlM5fhlBjMl7mwt5zyeIuri6tbLhdF8+HU1AsCng==
X-Received: by 2002:a62:640e:: with SMTP id y14mr111298844pfb.109.1560797771634;
        Mon, 17 Jun 2019 11:56:11 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c14sm11056019pgm.40.2019.06.17.11.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:56:11 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: hide of_ftd_match() if unused
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190617123840.911593-1-arnd@arndb.de>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5dfc29c0-0b42-16d9-b850-2cba8938d908@gmail.com>
Date:   Mon, 17 Jun 2019 11:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617123840.911593-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for catching this.

The bad news is that you are second in line, Kefeng Wang sent a patch to
do the same last week.

Thanks!

-Frank


On 6/17/19 5:38 AM, Arnd Bergmann wrote:
> The only caller of this function is built conditionally:
> 
> drivers/of/fdt.c:129:19: error: 'of_fdt_match' defined but not used [-Werror=unused-function]
> 
> Move the definition into the same #ifdef block.
> 
> Fixes: 9b4d2b635bd0 ("of/fdt: Remove dead code and mark functions with __init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/of/fdt.c | 106 +++++++++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3d36b5afd9bd..424981786c79 100644
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
> -static int __init of_fdt_match(const void *blob, unsigned long node,
> -			       const char *const *compat)
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
> @@ -522,6 +469,59 @@ void *initial_boot_params __ro_after_init;
>  
>  static u32 of_fdt_crc32;
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
>   * res_mem_reserve_reg() - reserve all memory described in 'reg' property
>   */
> 

