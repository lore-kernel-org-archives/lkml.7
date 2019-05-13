Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C274C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E37920873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufpnXMjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfEMRWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:22:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfEMRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:22:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so7543378pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E86U/OIq74Doq/AcvzrkKbLtbu6NqHfBiDf8ceyGPzM=;
        b=ufpnXMjj3Ze0G4KfMCgpi48jxwKVpdK5ymTvdzOnrQWfrHx9VicBsLGwPpPbnrBJqr
         wQnBYCgyqTuaZrJhHhVSu5IWAo97gPKaN2+UNtXs8aYTnY1uCJfOljPi9ZHCTF2LioBY
         LBk2RKNsvc/yeb4A9w1CFQRe3sle5rCrOa9U7f/z07OBkPvEujmL4PZhl0mlcYQzz9sd
         HtZofTufNC7VQgq23OX4F/AOo3VGEW9abUpb4fM46HQ7u94VjMewnjpn6o/gc/cNMq1V
         Gtn7kgtYfQJ8HulmqiU25AvoU41m0z7ZYxM1WKPdrQbzbIS+Se5qDoHi83f8Me9ST3+J
         oHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E86U/OIq74Doq/AcvzrkKbLtbu6NqHfBiDf8ceyGPzM=;
        b=FoX9Dj58GYAsMHwMHJ/p0v4YR1Zeli3H0L2qPUFkasy6S6yOuUyD8GtH0N/MlQEahH
         sgg5MYFK2QijQB4UhG1igQt5kOaeZFol1PD/RU8BeaxwZ04mObcUX1U2Jev8m5WLnVyD
         cWtJdU/VORH4jlX6IPQUaFlKQmvLi2WrdtgrOaG44HR0/XFCKsdQj+qWi4IMTeM/XGMI
         P3vjRdVZZBTiHDqQpkm5DYuq3yAQzFQh3btx/oVPUuOxDJIDdhz76/CUOE/xku+bC674
         kHBUJe+WroZXeVIfm57OEZJ4gT2Dk8NkqfeHuXscd4wpuifAZGAqdoG/ROlCBZZTXbOm
         u8KQ==
X-Gm-Message-State: APjAAAU1zFTkP2rCgx5sJjovjGN/WdASTPNiFd/l1/OqEYJdjaBlg4Il
        v29ShL58AnG6jkqmZVL6fhKj3Q==
X-Google-Smtp-Source: APXvYqw8ofyCfK4wZzU5CyY1sc1HePTBiSZxBwF5gS+T8vTW3It9lCKsEOmy451skw99VYMwHECrQQ==
X-Received: by 2002:a62:4595:: with SMTP id n21mr35393430pfi.79.1557768120764;
        Mon, 13 May 2019 10:22:00 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 10sm17383690pfh.14.2019.05.13.10.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:21:59 -0700 (PDT)
Date:   Mon, 13 May 2019 11:21:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, rjw@rjwysocki.net
Subject: Re: [PATCH v3 22/30] coresight: Rearrange platform data probing
Message-ID: <20190513172157.GC16162@xps15>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
 <1557226378-10131-23-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557226378-10131-23-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:52:49AM +0100, Suzuki K Poulose wrote:
> We are about to introduce methods to clean up the platform data
> as we switch to tracking the device reference from "name" to "fwnode
> handles" for device connections. This requires us to drop the fwnode
> handle references when the data is no longer required - i.e, when
> the device probe fails or the device gets unregistered.
> 
> In order to consolidate the invocation of the cleanup, we delay the
> platform probing to the very last minute, possibly before invoking
> the coresight_register. Then, we leave the coresight core code to
> do the clean up. i.e, if the coresight_register fails, it takes
> care of freeing the data. Otherwise, coresight_unregister will
> do the necessary operations.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c       | 14 +++++++-------
>  drivers/hwtracing/coresight/coresight-etb10.c      | 10 +++++-----
>  drivers/hwtracing/coresight/coresight-etm3x.c      | 12 +++++++-----
>  drivers/hwtracing/coresight/coresight-etm4x.c      | 12 +++++++-----
>  drivers/hwtracing/coresight/coresight-funnel.c     | 12 +++++++-----
>  drivers/hwtracing/coresight/coresight-replicator.c | 12 +++++++-----
>  drivers/hwtracing/coresight/coresight-stm.c        | 11 +++++++----
>  drivers/hwtracing/coresight/coresight-tmc.c        | 16 ++++++++--------
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 10 +++++-----
>  9 files changed, 60 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 05c7304..1c1ad12 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -505,13 +505,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct device *dev = &adev->dev;
>  	void __iomem *base;
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata)) {
> -		ret = PTR_ERR(pdata);
> -		goto out;
> -	}
> -	dev->platform_data = pdata;
> -
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata) {
>  		ret = -ENOMEM;
> @@ -544,6 +537,13 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (ret)
>  		goto out;
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out;
> +	}
> +	dev->platform_data = pdata;
> +
>  	drvdata->base = base;
>  	catu_desc.pdata = pdata;
>  	catu_desc.dev = dev;
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 5e7ecc6..09df827 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -726,11 +726,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	adev->dev.platform_data = pdata;
> -
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -765,6 +760,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	/* This device is not associated with a session */
>  	drvdata->pid = -1;
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	adev->dev.platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_SINK;
>  	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>  	desc.ops = &etb_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 101fb01..f2d4616 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -795,11 +795,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -
> -	adev->dev.platform_data = pdata;
>  	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
>  	dev_set_drvdata(dev, drvdata);
>  
> @@ -849,6 +844,13 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	etm_init_trace_id(drvdata);
>  	etm_set_default(&drvdata->config);
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto err_arch_supported;
> +	}
> +	adev->dev.platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
>  	desc.ops = &etm_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 8adc148..1609da1 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1089,11 +1089,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	adev->dev.platform_data = pdata;
> -
>  	dev_set_drvdata(dev, drvdata);
>  
>  	/* Validity for the resource is already checked by the AMBA core */
> @@ -1136,6 +1131,13 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	etm4_init_trace_id(drvdata);
>  	etm4_set_default(&drvdata->config);
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto err_arch_supported;
> +	}
> +	adev->dev.platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
>  	desc.ops = &etm4_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index ded33f5..75fa2d3 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -188,11 +188,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  	struct funnel_drvdata *drvdata;
>  	struct coresight_desc desc = { 0 };
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	dev->platform_data = pdata;
> -
>  	if (is_of_node(dev_fwnode(dev)) &&
>  	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
>  		pr_warn_once("Uses OBSOLETE CoreSight funnel binding\n");
> @@ -224,6 +219,13 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  
>  	dev_set_drvdata(dev, drvdata);
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out_disable_clk;
> +	}
> +	dev->platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_LINK;
>  	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
>  	desc.ops = &funnel_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index f28bafd..64dfde7 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -179,11 +179,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	struct coresight_desc desc = { 0 };
>  	void __iomem *base;
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	dev->platform_data = pdata;
> -
>  	if (is_of_node(dev_fwnode(dev)) &&
>  	    of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
>  		pr_warn_once("Uses OBSOLETE CoreSight replicator binding\n");
> @@ -215,6 +210,13 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  
>  	dev_set_drvdata(dev, drvdata);
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out_disable_clk;
> +	}
> +	dev->platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_LINK;
>  	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>  	desc.ops = &replicator_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 02031d9..03528f3 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -810,10 +810,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	adev->dev.platform_data = pdata;
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -866,6 +862,13 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  		return -EPROBE_DEFER;
>  	}
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto stm_unregister;
> +	}
> +	adev->dev.platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE;
>  	desc.ops = &stm_cs_ops;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 44a5719..212630e 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -398,13 +398,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata)) {
> -		ret = PTR_ERR(pdata);
> -		goto out;
> -	}
> -	adev->dev.platform_data = pdata;
> -
>  	ret = -ENOMEM;
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> @@ -434,7 +427,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	else
>  		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
>  
> -	desc.pdata = pdata;
>  	desc.dev = dev;
>  	desc.groups = coresight_tmc_groups;
>  	desc.name = dev_name(dev);
> @@ -467,6 +459,14 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata)) {
> +		ret = PTR_ERR(pdata);
> +		goto out;
> +	}
> +	adev->dev.platform_data = pdata;
> +	desc.pdata = pdata;
> +
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
>  		ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index d8a2e39..b699d61 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -125,11 +125,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> -	pdata = coresight_get_platform_data(dev);
> -	if (IS_ERR(pdata))
> -		return PTR_ERR(pdata);
> -	dev->platform_data = pdata;
> -
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -152,6 +147,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	/* Disable tpiu to support older devices */
>  	tpiu_disable_hw(drvdata);
>  
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	dev->platform_data = pdata;
> +
>  	desc.type = CORESIGHT_DEV_TYPE_SINK;
>  	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PORT;
>  	desc.ops = &tpiu_cs_ops;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
