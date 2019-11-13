Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB54206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4xq2A/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMWYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:24:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33235 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:24:36 -0500
Received: by mail-yb1-f195.google.com with SMTP id i15so1727468ybq.0;
        Wed, 13 Nov 2019 14:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZeCDy9drSlcJGowK8/CoXw4Eluj2LsygpuOd8BxqQHE=;
        b=e4xq2A/P0PeFiV3Rs3Ob7o6YX0SS38LvwLqeILdpFIwd+pJ+VAAd6Iv5MmqRVDl3Zi
         bPz5vnYWTE4KJsweuOInURG8r/W4N7cjc++Zypym04cTYQs8izFdN4fg6JXH/jOtFeZJ
         /jzQHDY6aupyybuB1M5QmWpRf8qaIehasX1h+ebvSiFSxvJwhBn1fB2bKW/hiL3E9UPr
         /9kA6a/cmQRgt/P6x0SGIfzpVeTntPl8soNcvMaUTfUzoX6mAbDzDxDJSbKHbrwgIfpz
         L6RBZaBF5xwY3xXVsuQ+gEDCyog9kwiuIrBEpYhRhDrV03wBppAMizF3NehliTX2nq+J
         VQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZeCDy9drSlcJGowK8/CoXw4Eluj2LsygpuOd8BxqQHE=;
        b=FnRKzjCsRoNR+++YAgn1v6EtgzgDd90Jc4T/jxI3kRMod0ATs8guhDJ2lcqAyLM42u
         2ftjGlPVKgfG91Dr1EZvvNUiY0lIhvZcGbiEDaKYeRJU50+hAKHBy56BrofLCG8/KBtj
         2C6JlDVzFNpOERhpl8m2p2k9dAsIqvCNfA/FZQuGx/1T5Pksmr7NAMBYPJOzXaFNqoiB
         lA6afuI8Qj6OFkJsWF9mOm10XeqJaXmcvm4eWpagEmqA29s2QAzXdK0BcwOdV5rsFFvJ
         n2RHJRjSyg2TN7UKTOhnDy1TzCG/6tnD54uZXMAsSKSbm6dcI6nXVYBfMNYFuxNlmH9g
         0lkw==
X-Gm-Message-State: APjAAAUPKTFcOh4YSTCeDy0JxuH1YzY0kwfJQxHusGdSiGeHkN4bK6qz
        Iyu2R68re0HWirCdsV54p2BQ4qXe
X-Google-Smtp-Source: APXvYqyFP/kkahf4/3VBrrEHFpJSuPv6JBPKPjpOK65PtNAQC/XwFg8CsxXJHSOD+a2k7quvkRxYzQ==
X-Received: by 2002:a81:7606:: with SMTP id r6mr3631358ywc.422.1573683875193;
        Wed, 13 Nov 2019 14:24:35 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id j79sm1163949ywa.100.2019.11.13.14.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:24:34 -0800 (PST)
Subject: Re: [PATCH v2] of: property: Fix documentation for out values
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113064338.GA13274@localhost.localdomain>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ab2a2217-fb9f-f41b-689a-8478b8895ec6@gmail.com>
Date:   Wed, 13 Nov 2019 16:24:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113064338.GA13274@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 12:43 AM, Matti Vaittinen wrote:
> Property fetching functions which return number of successfully fetched
> properties should not state that out-values are only modified if 0 is
> returned. Fix this. Also, "pointer to return value" is slightly suboptimal
> phrase as "return value" commonly refers to value function returns (not via
> arguments). Rather use "pointer to found values".
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Changes from v1. Removed statement about modifying arg ptr only upon
> successful execution (as requested by Frank). Also changed "pointer to
> return value" with "pointer to found values"
> 
>  drivers/of/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index d7fa75e31f22..c1dd22ed03f3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to found values.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to found values.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to return found values.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to found values.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> 
> base-commit: 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
