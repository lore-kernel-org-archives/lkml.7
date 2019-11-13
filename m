Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EEEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F197C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEmKDvRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKMAcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:32:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46100 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:32:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id v15so246652ybp.13;
        Tue, 12 Nov 2019 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Q2W42moV2mcIIo6Rx/FBh+2Gk6dSmvg33UDVUt0qXw=;
        b=nEmKDvRWPecToVawO6mXvgAJL5tz/QZVmKRi4mz3MXyoK7N7RaMwMYBigtP/+1fBNQ
         BwZafln08/j94TFfzjZYP+zGfjT9tqTpq7FM5onTVExFpvbH0qMLMbQbbZ3c0+I+b1KU
         mDpqIlbssgz4OC5XYBCcVc7jEbUEsTJ/0k37/Ugti31KC3LD61aGAmon8DMT5rpXZMul
         8g0ekEdq5cjNDc5WoZVKPDtMUtNNsTlcd+EpCstQVCj7MlkEQ+qundQcozjkCb1k6ZZI
         86rBHOnwO00VUB3m7W1j99R1+UI5GsHXnRh6w96KQSXl7NkVjl3tD6bcVym8T1K1NiNr
         ypFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Q2W42moV2mcIIo6Rx/FBh+2Gk6dSmvg33UDVUt0qXw=;
        b=ZJPF2FRmRu0lMUvcfe1cOMvF1Zwb+N/uVrFp7hkrxQvzJ+XJMmPXjY/jRDTX8OhrQI
         qoNbYm/mc1ihjk36fdWAsnKY5hIEHF9v4nq6wddhIVnqJAArZjP1h7MQzMhVaQ7w/7KS
         iW4clJXrI2furbQugDr2ZONTp9TWE8NmGQ1o7Cj/MDnVBervmUatNFtsUcm6lRPnYDlw
         lZh0oyRBf5d9yc7831nn9V6rUOCjsj4pWO7aUitff/fzCE9EGvpts0PvyRYGH2hM7lAK
         vKtXUMiH38FfK4o66JLKPlIIaJdU5vN8+CVLeUTLlexIwIr+JT1J0TH+qLIt9ij4/M9q
         QZHw==
X-Gm-Message-State: APjAAAVHIVdO7cBbFaYloecjwi2odD7fPfvwCGOunJdRdj0TAuoHNdwR
        vv4DM5Va4zULNdzmR4u5b6hTAntc
X-Google-Smtp-Source: APXvYqwxua4n09IZ/ysgn43BSsa6gYsNIsKafVt5k3uoK1Onlwyk9RkBUd4tsIlnBMq92gvrXKlXag==
X-Received: by 2002:a25:700a:: with SMTP id l10mr610620ybc.79.1573605139455;
        Tue, 12 Nov 2019 16:32:19 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 23sm153137ywf.91.2019.11.12.16.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 16:32:19 -0800 (PST)
Subject: Re: [PATCH] of: property: Fix documentation for out values
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191112081726.GA8291@localhost.localdomain>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b1e7e17e-bf58-70af-b3de-7e8138d578ad@gmail.com>
Date:   Tue, 12 Nov 2019 18:32:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112081726.GA8291@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On 11/12/19 2:17 AM, Matti Vaittinen wrote:
> Property fetching functions which return number of successfully fetched
> properties should not state that out-values are only modified if 0 is
> returned. Fix this.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/of/property.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index d7fa75e31f22..4aae93cdc1ce 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -164,7 +164,8 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to return value, modified only if return value is
> + *		greater than 0.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -212,7 +213,8 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to return value, modified only if return value is
> + *		greater than 0.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -260,7 +262,8 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to return value, modified only if return value is
> + *		greater than 0.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> @@ -334,7 +337,8 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
>   *
>   * @np:		device node from which the property value is to be read.
>   * @propname:	name of the property to be searched.
> - * @out_values:	pointer to return value, modified only if return value is 0.
> + * @out_values:	pointer to return value, modified only if return value is
> + *		greater than 0.
>   * @sz_min:	minimum number of array elements to read
>   * @sz_max:	maximum number of array elements to read, if zero there is no
>   *		upper limit on the number of elements in the dts entry but only
> 

Thanks for catching each of these cases of incorrect documentation.

Instead of correcting each of the descriptions, please just remove the incorrect
portion.  So for each case, remove ", modified only if return value is 0."

The reference to return value of 0 is a left over from another set of functions
which were modified to call the set of functions that you fix above.

Thanks,

Frank
