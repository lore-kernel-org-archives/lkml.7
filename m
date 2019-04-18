Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BCCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ADF206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g63Jrcfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfDRSO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:14:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391146AbfDRSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:14:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so1451410pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o16/LdvJgUhzxLOzJLz4tqzs41ZSZqXnYt0SCNmPbYM=;
        b=g63Jrcfpp0CpXF2CFaPR5HqCA2ZwtddghF2cRaGIrjv8hGHzvfH1BA9XAD8CC6jt0W
         zqM465FEm5g4bFAFr+9UJmI9GET9/8YToiMNWmX21CQoyUx9Eym/mjRDPV/oNUeud1oD
         UBQ6dnxgefhAj3NTMRVArkwDHH2jt2F2YE7n9eERT/zSkftQlxVxwXaKyhhmru24ZkyT
         kxQhYXAIUGzRWcf9WKe46Yi6ckQTJJJNXZ22BgUxuSIWawMbPlyCrVxkn2C2mzZUifNp
         YbERyV33RwG/f4mhGDMtnAzyWZe/aNpk2hsD03496o5eEYVySItfVMYJ8mX9OmY+EsaN
         sY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o16/LdvJgUhzxLOzJLz4tqzs41ZSZqXnYt0SCNmPbYM=;
        b=lB1V/fb62Q+6wwTl8f5CyqKeBO7rTCT9QqBraB3YRjf5Q5MZ4grxmmViivZHcoVKib
         7sGEUg/IiPNreMiFREk6Pyq7o4fICroduOnMrUo10lP1PYL/mZcSy/EIAqrHrfaLgHrP
         v1ox1WDNlK4RBLtmyONo3hdbDCWtlTgxCL3ZfAJy5ark7YJj/dwnqEc2o1tenjAKitII
         4W4MLbyCriQpTi2E/VvUXp4FvIPv52Fm2bcxcBAPH2LVSUjPg+kJm2sW8E320+T6X9CQ
         zwvQlreuzZtbwC4yZVGVIxS/XN4xku/JsGBIUyrejLvVHg4oQM0t/2CInoRAlhpaN9hl
         49+g==
X-Gm-Message-State: APjAAAUVhnasvdFu6xsd13S4LbgGk4SysBiL54qRsvDhHTMRPWj9Jd0O
        HJJA8GX4lE1rEtOysqtc+bfD2w==
X-Google-Smtp-Source: APXvYqySah2SU+varGc+UC5VL+EUx98oNt8QxAn/OemSNcn2Ar603CT9p5I3Yqp1jfE51gY+bDdkDw==
X-Received: by 2002:a63:df12:: with SMTP id u18mr90482891pgg.135.1555611291965;
        Thu, 18 Apr 2019 11:14:51 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 8sm4339349pfs.50.2019.04.18.11.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 11:14:51 -0700 (PDT)
Date:   Thu, 18 Apr 2019 12:14:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 20/36] coresight: Make device to CPU mapping generic
Message-ID: <20190418181448.GC10675@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-21-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-21-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:03PM +0100, Suzuki K Poulose wrote:
> The CoreSight components ETM and CPU-Debug are always associated
> with CPUs. Replace the of_coresight_get_cpu() with a platform
> agnostic helper, in preparation to add ACPI support.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +--
>  drivers/hwtracing/coresight/coresight-platform.c  | 18 +++++++++++++-----
>  include/linux/coresight.h                         |  7 +------
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index e8819d7..07a1367 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -572,14 +572,13 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct device *dev = &adev->dev;
>  	struct debug_drvdata *drvdata;
>  	struct resource *res = &adev->res;
> -	struct device_node *np = adev->dev.of_node;
>  	int ret;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> +	drvdata->cpu = coresight_get_cpu(dev);
>  	if (per_cpu(debug_drvdata, drvdata->cpu)) {
>  		dev_err(dev, "CPU%d drvdata has already been initialized\n",
>  			drvdata->cpu);
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 25a1838..8a86ba3 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -151,12 +151,14 @@ static void of_coresight_get_ports(const struct device_node *node,
>  	}
>  }
>  
> -int of_coresight_get_cpu(const struct device_node *node)
> +static int of_coresight_get_cpu(struct device *dev)
>  {
>  	int cpu;
>  	struct device_node *dn;
>  
> -	dn = of_parse_phandle(node, "cpu", 0);
> +	if (!dev->of_node)
> +		return 0;
> +	dn = of_parse_phandle(dev->of_node, "cpu", 0);
>  	/* Affinity defaults to CPU0 */
>  	if (!dn)
>  		return 0;
> @@ -166,7 +168,6 @@ int of_coresight_get_cpu(const struct device_node *node)
>  	/* Affinity to CPU0 if no cpu nodes are found */
>  	return (cpu < 0) ? 0 : cpu;
>  }
> -EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>  
>  /*
>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> @@ -241,8 +242,6 @@ of_get_coresight_platform_data(struct device *dev,
>  	bool legacy_binding = false;
>  	struct device_node *node = dev->of_node;
>  
> -	pdata->cpu = of_coresight_get_cpu(node);
> -
>  	/* Get the number of input and output port for this component */
>  	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>  
> @@ -294,6 +293,14 @@ of_get_coresight_platform_data(struct device *dev,
>  }
>  #endif
>  
> +int coresight_get_cpu(struct device *dev)
> +{
> +	if (is_of_node(dev->fwnode))
> +		return of_coresight_get_cpu(dev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_cpu);
> +
>  struct coresight_platform_data *
>  coresight_get_platform_data(struct device *dev)
>  {
> @@ -309,6 +316,7 @@ coresight_get_platform_data(struct device *dev)
>  
>  	/* Use device name as sysfs handle */
>  	pdata->name = dev_name(dev);
> +	pdata->cpu = coresight_get_cpu(dev);
>  
>  	if (is_of_node(fwnode))
>  		return of_get_coresight_platform_data(dev, pdata);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5b29255..a48cd9b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -291,12 +291,7 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
>  
>  #endif
>  
> -#ifdef CONFIG_OF
> -extern int of_coresight_get_cpu(const struct device_node *node);
> -#else
> -static inline int of_coresight_get_cpu(const struct device_node *node)
> -{ return 0; }
> -#endif
> +extern int coresight_get_cpu(struct device *dev);
>  
>  struct coresight_platform_data *coresight_get_platform_data(struct device *dev);

For patches 12, 13 and 15-20:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
> -- 
> 2.7.4
> 
