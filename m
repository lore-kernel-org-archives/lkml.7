Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EFD20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXOVtHwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfC1Ul5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:41:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44451 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfC1Ulz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:41:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so5768332pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8By5OSotSuT4GJqP67uaJWemZ0EgShCc8LjQId4k3Rc=;
        b=tXOVtHwDPUUtgapGGO9kXhC64m6Muf9WfJvydhPhC4nkOGrxKkEx41Daatgf0ejBle
         IFImpN15g33BQTTAoDlV3ihA4wXCtldSyT3dy5jiluo8H+Jt2nn0OAQsEWvtIfgJHfme
         reHuIo62eIM9eldUVz3y5MY1L5zzXta5mIRbIg4cS5kr/u+5u8J6Cb9VOhhB162AexHW
         kWwt4YGW+8D1GgWEt0bUODXbzU9pYedUXKtJPvZ0quEkw1x3fY54r7Ygdu7KTkJmx6eT
         rL7sIgrLMkqs2sTJqFwzpRvUW+J3SVrnR7r9sleviRUy0NWp/JvA0F33aRoOa9w3lwDb
         UFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8By5OSotSuT4GJqP67uaJWemZ0EgShCc8LjQId4k3Rc=;
        b=hLlw/P2mlUSWLi/ddaOKOR/Jknm/epvi20CtLE1SJNYbFThrLcg5JamZ7x1Z5uG5+q
         gwfexfKxVH/Lg69S4POLGwTHSZwWV0Q3nLvhhmTeO1dzyC2kDHsczawaGfVWwBYeVKYa
         XRv/pMi0qSXPjLEXpcWrSq2I47CMTvzWl4U3ocJpgj8AV3vmMUa1H8NiklQb4KfPEhDX
         Czp4XBYes8WvvviYGF8bP3sHNWI6SN+6z5x9Seu5neFtmXZko6TixpNy8VS43MXmMiBy
         NJDyr3ws7PonhNGWMiqWqs+uaKmNGmhw9WIn3FRB6pQQXCptgy2jz9VH8krQqQ7S+wE/
         CWSw==
X-Gm-Message-State: APjAAAX1tlEc2ipdERS/rzQGr7DlrDVA+b6Xaqc5zAR1A4lFS1oie2wX
        FXHy15EupeIOMtizACBP+bJhCg==
X-Google-Smtp-Source: APXvYqzuvOHSRpY6JBeyHb6ix0zBYaSPOK/RbkLGW9cxfwyk2KtngBHMB1hIV4IOfdJP6y+ZaUujKQ==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr2995307pgs.373.1553805714899;
        Thu, 28 Mar 2019 13:41:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q11sm63621pgs.94.2019.03.28.13.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 13:41:54 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:41:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 23/25] coresight: stm: ACPI support for parsing stimulus
 base
Message-ID: <20190328204151.GA7163@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:40PM +0000, Suzuki K Poulose wrote:
> The stimulus base for STM device must be listed as the second memory
> resource, followed by the programming base address. Add support for
> parsing the information for ACPI.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index d94ae22..995443a 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -16,6 +16,7 @@
>   * (C) 2015-2016 Chunyan Zhang <zhang.chunyan@linaro.org>
>   */
>  #include <asm/local.h>
> +#include <linux/acpi.h>
>  #include <linux/amba/bus.h>
>  #include <linux/bitmap.h>
>  #include <linux/clk.h>
> @@ -717,10 +718,52 @@ static inline int of_stm_get_stimulus_area(struct device *dev,
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
> +{
> +	int rc;
> +	bool found_base = false;
> +	struct resource_entry *rent;
> +	LIST_HEAD(res_list);
> +
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (!adev)
> +		return -ENODEV;
> +	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = -ENOENT;
> +	list_for_each_entry(rent, &res_list, node) {
> +		if (resource_type(rent->res) != IORESOURCE_MEM)
> +			continue;
> +		if (found_base) {
> +			*res = *rent->res;
> +			rc = 0;
> +			break;
> +		}
> +
> +		found_base = true;

Is the ACPI binding crystal clear on the fact that the second resource region
has to be for stimulus ports?

> +	}
> +
> +	acpi_dev_free_resource_list(&res_list);
> +	return rc;
> +}
> +#else
> +static inline int acpi_stm_get_stimulus_area(struct device *dev,
> +					     struct resource *res)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +
>  static int stm_get_stimulus_area(struct device *dev, struct resource *res)
>  {
>  	if (dev->of_node)

Wouldn't it be better to use is_of_node()?

>  		return of_stm_get_stimulus_area(dev, res);
> +	else if (is_acpi_node(dev->fwnode)

is_acpi_device_node()?

> +		return acpi_stm_get_stimulus_area(dev, res);
>  	return -ENOENT;
>  }
>  
> -- 
> 2.7.4
> 
