Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB36AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937362084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwFeYzye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfEMQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:40:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32859 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfEMQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:39:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so6753712plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOTTXWGUHuT21t+7qiQOMKOu3sooS1XgCOsDWRfKZzw=;
        b=rwFeYzyeBYmhvYRb28twRjfM2uqimkH1LwpNv/ABMxe4OuCR03MtHaSjYN4CIElAYB
         XKjTMDfrFJwvYs0H+op8Yh9wRBF1ZoLmWJGBTU//mU2ngNhc/AyCabNdsB/ZYiXs9FGa
         i4X8ncUQkUGOASf4DMpGC9tjWItlJvfyYM2BMmKhjyEUXZlXaE1rAo4feXC+LUeVHBKQ
         qhSY6Q33CaK4lG+g60Oc8ZBa1nkVrdsSpCK83F3YhsLe6mI0nSC6QLJpgMFiyQBQddbM
         ZmS2WKndKdWQr8FnnQ9ahJZSew9wP5MkxUR9/8ceosIOGVbXQ7MKgmWKyQRI3CWahmhW
         0nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOTTXWGUHuT21t+7qiQOMKOu3sooS1XgCOsDWRfKZzw=;
        b=sB1BRSviDyJWYP403qV5OGqkV+FPwXLvuHg/trPxXD8REWaUqBOksu4ix6WrhbK3ng
         FSRWzHgGH86o1Kd2+Dzsff/RX4jM92tbxxpHBudK2Oe2JvizIiFYj0AFDi5FFVjwhLe7
         PayhgQNRBbRjx+JSB63xoesxI9s4JO/vdpXf0shh2zOqSKkWUU0tqgb64DR5ZYV61BZ+
         u4jEovMgSoOfvGhGnEt/KVYMmJ2FMbSKD/awniQN9igcAAaqSloljuXzyUlxfRP1LuvB
         ZMvFyUBWsFjkyynL1rhuSV9IBHtydd7v5PcbRZ7sOX52S0zF+r1ftoFmKapurAgyGl7n
         xg/Q==
X-Gm-Message-State: APjAAAV/lNOUvIfTJMBt8j1jOiOHDamyy0ev/ReRLnpo/lXVMWvSuR9u
        ovo60vsz8XHUwpZN6nYIC3yTkA==
X-Google-Smtp-Source: APXvYqx8yWVsi0Ilg1gccIEygTNSek0fwg0zfl3bgL4s+2u7ExqHw3toQiRM3AMKO6hlr7GzDoRo4A==
X-Received: by 2002:a17:902:650f:: with SMTP id b15mr8839625plk.11.1557765598857;
        Mon, 13 May 2019 09:39:58 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v64sm19047504pfv.106.2019.05.13.09.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:39:58 -0700 (PDT)
Date:   Mon, 13 May 2019 10:39:56 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 16/30] coresight: Introduce generic platform data
 helper
Message-ID: <20190513163956.GB16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-17-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-17-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:43AM +0100, Suzuki K Poulose wrote:
> So far we have hard coded the DT platform parsing code in
> every driver. Introduce generic helper to parse the information
> provided by the firmware in a platform agnostic manner, in preparation
> for the ACPI support.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Use int error code for of_get_coresight_platform_data() [Mathieu]
> ---
>  drivers/hwtracing/coresight/coresight-catu.c       | 13 ++---
>  drivers/hwtracing/coresight/coresight-etb10.c      | 11 ++--
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 12 ++---
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 11 ++--
>  drivers/hwtracing/coresight/coresight-funnel.c     | 11 ++--
>  drivers/hwtracing/coresight/coresight-platform.c   | 58 ++++++++++++++++------
>  drivers/hwtracing/coresight/coresight-replicator.c | 11 ++--
>  drivers/hwtracing/coresight/coresight-stm.c        | 11 ++--
>  drivers/hwtracing/coresight/coresight-tmc.c        | 13 ++---
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 11 ++--
>  include/linux/coresight.h                          |  7 +--
>  11 files changed, 83 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 63109c9..799ba1d 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -503,17 +503,14 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct coresight_desc catu_desc;
>  	struct coresight_platform_data *pdata = NULL;
>  	struct device *dev = &adev->dev;
> -	struct device_node *np = dev->of_node;
>  	void __iomem *base;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata)) {
> -			ret = PTR_ERR(pdata);
> -			goto out;
> -		}
> -		dev->platform_data = pdata;
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out;
>  	}
> +	dev->platform_data = pdata;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata) {
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 3b333fb..612f1e9 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -725,14 +725,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct etb_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		adev->dev.platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	adev->dev.platform_data = pdata;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index fa2f141..fa2164f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -790,20 +790,16 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct etm_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -
> -		adev->dev.platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
>  
> +	adev->dev.platform_data = pdata;
>  	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
>  	dev_set_drvdata(dev, drvdata);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 77d1d83..4355b2e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1084,18 +1084,15 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct etmv4_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		adev->dev.platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	adev->dev.platform_data = pdata;
>  
>  	dev_set_drvdata(dev, drvdata);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 3423042..fc033fd 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -187,14 +187,11 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  	struct coresight_platform_data *pdata = NULL;
>  	struct funnel_drvdata *drvdata;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = dev->of_node;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		dev->platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	dev->platform_data = pdata;
>  
>  	if (is_of_node(dev_fwnode(dev)) &&
>  	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 4c31299..5d78f4f 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -230,23 +230,16 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  	return ret;
>  }
>  
> -struct coresight_platform_data *
> -of_get_coresight_platform_data(struct device *dev,
> -			       const struct device_node *node)
> +static int of_get_coresight_platform_data(struct device *dev,
> +					  struct coresight_platform_data *pdata)
>  {
>  	int ret = 0;
> -	struct coresight_platform_data *pdata;
>  	struct coresight_connection *conn;
>  	struct device_node *ep = NULL;
>  	const struct device_node *parent = NULL;
>  	bool legacy_binding = false;
> +	struct device_node *node = dev->of_node;
>  
> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return ERR_PTR(-ENOMEM);
> -
> -	/* Use device name as sysfs handle */
> -	pdata->name = dev_name(dev);
>  	pdata->cpu = of_coresight_get_cpu(node);
>  
>  	/* Get the number of input and output port for this component */
> @@ -254,11 +247,11 @@ of_get_coresight_platform_data(struct device *dev,
>  
>  	/* If there are no output connections, we are done */
>  	if (!pdata->nr_outport)
> -		return pdata;
> +		return 0;
>  
>  	ret = coresight_alloc_conns(dev, pdata);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
>  
>  	parent = of_coresight_get_output_ports_node(node);
>  	/*
> @@ -292,11 +285,46 @@ of_get_coresight_platform_data(struct device *dev,
>  		case 0:
>  			break;
>  		default:
> -			return ERR_PTR(ret);
> +			return ret;
>  		}
>  	}
>  
> -	return pdata;
> +	return 0;
> +}
> +#else
> +static inline int
> +of_get_coresight_platform_data(struct device *dev,
> +			       struct coresight_platform_data *pdata)
> +{
> +	return -ENOENT;
>  }
> -EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
>  #endif
> +
> +struct coresight_platform_data *
> +coresight_get_platform_data(struct device *dev)
> +{
> +	int ret = -ENOENT;
> +	struct coresight_platform_data *pdata;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +
> +	if (IS_ERR_OR_NULL(fwnode))
> +		goto error;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Use device name as sysfs handle */
> +	pdata->name = dev_name(dev);
> +
> +	if (is_of_node(fwnode))
> +		ret = of_get_coresight_platform_data(dev, pdata);
> +
> +	if (!ret)
> +		return pdata;
> +error:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_platform_data);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 7e05145..054b335 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -177,15 +177,12 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	struct coresight_platform_data *pdata = NULL;
>  	struct replicator_drvdata *drvdata;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = dev->of_node;
>  	void __iomem *base;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		dev->platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	dev->platform_data = pdata;
>  
>  	if (is_of_node(dev_fwnode(dev)) &&
>  	    of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 3992a35..9faa1ed 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -809,14 +809,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource ch_res;
>  	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		adev->dev.platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	adev->dev.platform_data = pdata;
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 9c5e615..be0bd98 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -397,16 +397,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct tmc_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata)) {
> -			ret = PTR_ERR(pdata);
> -			goto out;
> -		}
> -		adev->dev.platform_data = pdata;
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out;
>  	}
> +	adev->dev.platform_data = pdata;
>  
>  	ret = -ENOMEM;
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 4dd3e7f..aec0ed7 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -124,14 +124,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct tpiu_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> -	struct device_node *np = adev->dev.of_node;
>  
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		adev->dev.platform_data = pdata;
> -	}
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	dev->platform_data = pdata;
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 62a520d..e2b95e0 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -294,14 +294,11 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
>  
>  #ifdef CONFIG_OF
>  extern int of_coresight_get_cpu(const struct device_node *node);
> -extern struct coresight_platform_data *
> -of_get_coresight_platform_data(struct device *dev,
> -			       const struct device_node *node);
>  #else
>  static inline int of_coresight_get_cpu(const struct device_node *node)
>  { return 0; }
> -static inline struct coresight_platform_data *of_get_coresight_platform_data(
> -	struct device *dev, const struct device_node *node) { return NULL; }
>  #endif
>  
> +struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
> +
>  #endif

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
