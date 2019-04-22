Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10820C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CF82177B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2HQNuLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDVSKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:10:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45526 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfDVSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:10:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so6192047pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMCbWBaYlQJk7bxbnZxD2sVOCCmrXtHRb7Njxd4iLXE=;
        b=B2HQNuLRel9IMKzuEi+9sw5D98aq9ors0RDpdXu/fkIAgbIhR2NshUX9oTM0rD/qnL
         DXSdwY5tIFFILIUObP/SNIyL3uZQK+ny75ZUzn2mPHhAGa+zLVKcOndwqpKn1xuzFyqp
         57xxo4ByhIAGRnVTv+L9huyF3VuHk8yNTiT//T+tXa9JPAjqYs+riw1evX9er0kPikWZ
         DzPX/hK7ctjiWUzFVGwYdXoAPUVR9DV1fP3wXeu1ijw7vUYwKhyuBAINI3o0ETj4qTjz
         6oSP5QhAJ+yrvWuuSV52S/0xg9yR9BIlrsZFqE/fTCKb6fKDSQDe6kKLepvcMIoO/PEv
         +6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMCbWBaYlQJk7bxbnZxD2sVOCCmrXtHRb7Njxd4iLXE=;
        b=mYSQ1/bgpyIr7Z5k0iQrkFdLcPvB5DVcwSvfQ7pJKXoCB1Po4gm8ceRpE7VyhwkpAo
         2gELU8c7tuVlYt94aHZwK3FfcfXflAMLenQEIymLSPTp/P49wLOEiUw+CQVnLTR7cM4D
         jVpWYl0mxGdwukN4tnj4et4s1eF+a/VTnQSbAknxHfPT1mnhZXcwuQqsKW5YMgEY9MyQ
         syOivDBEukWSHUCIKf/9AWAiibVLCsPBRcxuEJ3VosgQrq/r1hkwceeVwO7aPsUIUMyy
         2HYXhubRK8AiyGvGDz0hBZBfM6kdMdNsHOGZqYifGmZHuBHDq8eupdNDforPo6g9/zSm
         AkwQ==
X-Gm-Message-State: APjAAAWuHq+zByqMU24oacmiLV2U9ythQstuZo3dy1dY5+qMTM5Ws9rZ
        RQAv6wHHfH/VOLDD1g7B1WO+iw==
X-Google-Smtp-Source: APXvYqzdMVkhijgcEy/uhzhl38Y60MzKjEu8Mt0eFNY9dMRQiU9yjLbxGeG9q182I3ALXcJyWyERGA==
X-Received: by 2002:aa7:8694:: with SMTP id d20mr21641600pfo.81.1555956600420;
        Mon, 22 Apr 2019 11:10:00 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d11sm15328617pgq.6.2019.04.22.11.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:09:59 -0700 (PDT)
Date:   Mon, 22 Apr 2019 12:09:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 19/36] coresight: Introduce generic platform data
 helper
Message-ID: <20190422180957.GC6402@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-20-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-20-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Apr 15, 2019 at 05:04:02PM +0100, Suzuki K Poulose wrote:
> So far we have hard coded the DT platform parsing code in
> every driver. Introduce generic helper to parse the information
> provided by the firmware in a platform agnostic manner, in preparation
> for the ACPI support.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c       | 13 +++-----
>  drivers/hwtracing/coresight/coresight-etb10.c      | 11 +++----
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 12 +++-----
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 11 +++----
>  drivers/hwtracing/coresight/coresight-funnel.c     | 11 +++----
>  drivers/hwtracing/coresight/coresight-platform.c   | 36 ++++++++++++++++------
>  drivers/hwtracing/coresight/coresight-replicator.c | 12 +++-----
>  drivers/hwtracing/coresight/coresight-stm.c        | 11 +++----
>  drivers/hwtracing/coresight/coresight-tmc.c        | 13 +++-----
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 11 +++----
>  include/linux/coresight.h                          |  7 ++---
>  11 files changed, 66 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 14d1cf5..65b86ec 100644
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
> index 6e6e9aa..cd61b54 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -681,14 +681,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
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
> index 75b923f..998b9f3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -976,18 +976,15 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
> index 1085f31..2590744 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -185,14 +185,11 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct funnel_drvdata *drvdata;
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
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 4c31299..25a1838 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -230,23 +230,17 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  	return ret;
>  }
>  
> -struct coresight_platform_data *
> +static struct coresight_platform_data *
>  of_get_coresight_platform_data(struct device *dev,
> -			       const struct device_node *node)
> +			       struct coresight_platform_data *pdata)
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
> @@ -298,5 +292,27 @@ of_get_coresight_platform_data(struct device *dev,
>  
>  	return pdata;
>  }
> -EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
>  #endif
> +
> +struct coresight_platform_data *
> +coresight_get_platform_data(struct device *dev)
> +{
> +	struct coresight_platform_data *pdata;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return NULL;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Use device name as sysfs handle */
> +	pdata->name = dev_name(dev);
> +
> +	if (is_of_node(fwnode))
> +		return of_get_coresight_platform_data(dev, pdata);

Now that I'm looking a patch 26, returning a coresight_platform_data pointer is
a little weird here.  Function of_get_coresight_platform_data() simply fills in
the pdata and should probably be returning an error code rather than a
pointer.  If of_get_coresight_platform_data() returns 0 then pdata is returned.

Mathieu

> +
> +	return ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_platform_data);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 8bbb008..7eb3bf7 100644
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
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> @@ -213,7 +210,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	}
>  
>  	dev_set_drvdata(dev, drvdata);
> -
>  	desc.type = CORESIGHT_DEV_TYPE_LINK;
>  	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>  	desc.ops = &replicator_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index a0690be..eae0094 100644
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
> index c470b81..7dbdf59 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -395,16 +395,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
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
> index 96af7d5..eea7fd1 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -120,14 +120,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
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
> index 7b87965..5b29255 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -293,14 +293,11 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
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
> -- 
> 2.7.4
> 
