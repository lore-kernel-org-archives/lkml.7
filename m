Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06317C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C086720685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpgLXP7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDWR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:59:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43365 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:59:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id n8so7886293plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6/C6S80/bNvps6yDI1zPpR7sXzDiP/eSGJf2+LZbGpI=;
        b=MpgLXP7t/+4lOc/0vvwunCC3y08IJLih1EUz/sPPK6YxU4Zl73GdiDsIZ0/bkwTVPK
         MHxATdc8RJ+lDlzq26vnVdT7SAtAej3rLneMGovdnXi7Ll610SwrzBISEoM7MS2+ZLOx
         0N6qNgxPUjqm6PH2iUG5tsCVZJzjAzzruCFX1PHxkW609gCf88BfpiMZQ4/hGNiNkiO/
         RSZRn+P6v/Vvjbs/uhcBMCT1ok2o75YPfw/gxvTQye4dxwru9oAh6Bk4TjMX6mUVWbz5
         8gesnornO2dG15MobAEHmX7436mT7nFcdRX3wYnok+tPk2IB405ZEqTs8xWJ95U0DcdD
         /9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6/C6S80/bNvps6yDI1zPpR7sXzDiP/eSGJf2+LZbGpI=;
        b=in5vW9QQgGL/b0edAk0+Cc3drr2VL7q1BlFD0Kbt+5nTq5riJlKFjb3qiskXX2pdeE
         zbznN8QmprFw+KHEscSi+zHnd5A5TPWv3XZMKbmsYLTzGYoGa/MxOw3zeDVKyyxhnpXB
         iEUewGUtzJG3JwiJL6SW1fGJltmbuuGnJ9480PoIFWqSnDRy7sTI/tYdIJe5jZ3PX5kH
         klzPkw6JLn8C+jqKAfa1tHl2+c4chgq733N5Y4oc05G3DoWdtBPMFZToyqr/9aMZUsrX
         hg8Gt7r3eI6+fWg95mfAyT7M0LkZ7UyZeuV7hH9+nl//B1XM/wIXpIHVDH9HO2Qj4Cft
         ZG+w==
X-Gm-Message-State: APjAAAVbm/dXcWRPb4Xq/AbKw+4X2LaFslyJaRWD/DJXSiEjMgiZXv3g
        YHyN6+f3ovBeZ2kzynTWz0aYSQ==
X-Google-Smtp-Source: APXvYqwB59UTLItpFcdUz+BR2BceSkfJ1A/DX4BziQCMSWrQrrWBA155QthkJICDMGJSqwvfVgHNtQ==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr27344702plg.168.1556042356666;
        Tue, 23 Apr 2019 10:59:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s19sm21223241pfe.74.2019.04.23.10.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 10:59:15 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:59:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 31/36] coresight: stm: ACPI support for parsing
 stimulus base
Message-ID: <20190423175913.GD21070@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-32-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-32-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:14PM +0100, Suzuki K Poulose wrote:
> The stimulus base for STM device must be listed as the second memory
> resource, followed by the programming base address as described in
> "Section 2.3 Resources" in ACPI for CoreSightTM 1.0 Platform Design
> documen (DEN0067).

Thank you for adding more information.

> 
> Add support for parsing the information for ACPI.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 43 +++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 2d6ae00..7cf2fe4 100644
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
> @@ -716,10 +717,52 @@ static inline int of_stm_get_stimulus_area(struct device *dev,
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
> +	}

I would copy the description in the changelog just before the
list_for_each_entry() loop.

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

I noticed the direct access of ->of_node in patch 16 and thought it was a little
odd that is_of_node() wasn't used.

>  		return of_stm_get_stimulus_area(dev, res);
> +	else if (is_acpi_node(dev->fwnode))
> +		return acpi_stm_get_stimulus_area(dev, res);
>  	return -ENOENT;

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  }
>  
> -- 
> 2.7.4
> 
