Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E464B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fruMnBfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfDWRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:38:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfDWRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:38:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so7834561pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v1aAeFl/jPeY1rYXszEh2/tXQlJ7Je6uR0yQmXh58PM=;
        b=fruMnBfbqOW9/1Wv2sLOcLyYPSBr3QvBPrNbxc7hMo0ioXr5XWyhQJqcJ257WVR9mW
         I5BrB6Gzw5Ig0bUcL3wIPgB0o5wLlwtnDAU/nDkiQOG2ZcTRIx95LrssDICnZ58xGUMh
         kBewNwI8njShs/l/ifStYOarkyvd0rGgHwNyCTMrl7VYKMFNVeACS4CUwdZs6TRZRVBC
         HEfKOysdbAKK4Z9EO/7NHa5rXd/y/QDKqAI985AExpYpmEQg9NaKlwvN4ePQZXnjBXN3
         tJPt6dfjGd76MlSbZ7Ho0eip1o7YG5xjJWKH50fgf6gwEIT4OrnbYnEuAQQfOBRHaL1D
         /Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v1aAeFl/jPeY1rYXszEh2/tXQlJ7Je6uR0yQmXh58PM=;
        b=Qw3McMxxTOA6RmwcF6NvgqVrUnyOQKMZ5WswULkqeQxkXcviXY3cxlmCcgbd8vj9BP
         8Zuo2XIbwECq6Ak/9LbGj/SCqA9vnS1JOE8vnmxm8bO/2tcUnKbYjH00479dDFm8UNLy
         epBYOWnc+vRsTr9n3mbO+PmG0nKbfGof30eTzapX8104RT52VvxYuARyE/zve0I3948Y
         AqPRimttbVcwNiuYgPr8olHZbWiKCGB6zvBwqFl0OkBDnkkBZiowQbasF/pLWS4D4ZUL
         K/umNNnvJgUcT8OtMWYy1Ggs26f6OGajtCBSN9azqrL/5a9SjQ8os1lojuDXV9MRzvq+
         qNEw==
X-Gm-Message-State: APjAAAUl5mpAgqV0sNAkW6HztUMa/NpmRJu+EpDXHHDXKdz50EBkURoX
        P75VKgptyxeaZDEv8NatBjiXtw==
X-Google-Smtp-Source: APXvYqzQ5j9XonryPg5Ou53O6a9vvfqq6o1JaSUrb4FZhM3E7nVVy034CDs6xd3o4/iTMUps61akrg==
X-Received: by 2002:a65:4048:: with SMTP id h8mr25456692pgp.6.1556041121258;
        Tue, 23 Apr 2019 10:38:41 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k3sm17272851pfb.175.2019.04.23.10.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 10:38:40 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:38:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 30/36] coresight: Use platform agnostic names
Message-ID: <20190423173837.GC21070@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-31-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-31-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:13PM +0100, Suzuki K Poulose wrote:
> So far we have reused the name of the "platform" device for
> the CoreSight device. But this is not very intuitive when
> we move to ACPI. Also, the ACPI device names have ":" in them
> (e.g, ARMHC97C:01), which the perf tool doesn't like very much.
> This patch introduces a generic naming scheme, givin more intuitive

s/givin/"and gives"

> names for the devices that appear on the CoreSight bus.
> The names follow the pattern "prefix" followed by "index" (e.g, etm5).
> We maintain a list of allocated devices per "prefix" to make sure
> we don't allocate a new name when it is reprobed (e.g, due to
> unsatisifed device dependencies). So, we maintain the list
> of "fwnodes" of the parent devices to allocate a consistent name.
> All devices except the ETMs get an index allocated in the order
> of probing. ETMs get an index based on the CPU they are attached to.
> 
> TMC devices are named using "tmc_etf", "tmc_etb", and "tmc_etr"
> prefixes depending on the configuration of the device.
> 
> The replicators are not classified as dynamic/static anymore.
> One could easily figure that out by checking the presence of
> "mgmt" registers under sysfs.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c       |  7 ++-
>  drivers/hwtracing/coresight/coresight-etb10.c      |  7 ++-
>  drivers/hwtracing/coresight/coresight-etm3x.c      |  4 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c      |  5 +-
>  drivers/hwtracing/coresight/coresight-funnel.c     |  7 ++-
>  drivers/hwtracing/coresight/coresight-replicator.c |  7 ++-
>  drivers/hwtracing/coresight/coresight-stm.c        | 12 +++--
>  drivers/hwtracing/coresight/coresight-tmc.c        | 15 +++++-
>  drivers/hwtracing/coresight/coresight-tpiu.c       |  7 ++-
>  drivers/hwtracing/coresight/coresight.c            | 58 ++++++++++++++++++++++
>  include/linux/coresight.h                          | 25 +++++++++-
>  11 files changed, 142 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index f249be6..e0637fc 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -28,6 +28,8 @@
>  #define catu_dbg(x, ...) do {} while (0)
>  #endif
>  
> +DEFINE_CORESIGHT_DEVLIST(catu_devs, "catu");
> +
>  struct catu_etr_buf {
>  	struct tmc_sg_table *catu_table;
>  	dma_addr_t sladdr;
> @@ -505,6 +507,10 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct device *dev = &adev->dev;
>  	void __iomem *base;
>  
> +	catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
> +	if (!catu_desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata) {
>  		ret = -ENOMEM;
> @@ -551,7 +557,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>  	catu_desc.type = CORESIGHT_DEV_TYPE_HELPER;
>  	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>  	catu_desc.ops = &catu_ops;
> -	catu_desc.name = dev_name(dev);
>  
>  	drvdata->csdev = coresight_register(&catu_desc);
>  	if (IS_ERR(drvdata->csdev))
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index e5b46c7..8361b91 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -62,6 +62,8 @@
>  #define ETB_FFSR_BIT		1
>  #define ETB_FRAME_SIZE_WORDS	4
>  
> +DEFINE_CORESIGHT_DEVLIST(etb_devs, "etb");
> +
>  /**
>   * struct etb_drvdata - specifics associated to an ETB component
>   * @base:	memory mapped base address for this component.
> @@ -682,6 +684,10 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> +	desc.name = coresight_alloc_device_name(&etb_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -723,7 +729,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &etb_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  	desc.groups = coresight_etb_groups;
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev))
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index f2d4616..bed7291 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -815,6 +815,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> +	desc.name  = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
> +	if (!desc.name)
> +		return -ENOMEM;
>  
>  	cpus_read_lock();
>  	etmdrvdata[drvdata->cpu] = drvdata;
> @@ -856,7 +859,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &etm_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  	desc.groups = coresight_etm_groups;
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7c53fb2..5c13a04 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -993,6 +993,10 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	spin_lock_init(&drvdata->spinlock);
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> +	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
> +	if (!desc.name)
> +		return -ENOMEM;
> +

One newline too many.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	cpus_read_lock();
>  	etmdrvdata[drvdata->cpu] = drvdata;
> @@ -1034,7 +1038,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.pdata = pdata;
>  	desc.dev = dev;
>  	desc.groups = coresight_etmv4_groups;
> -	desc.name = dev_name(dev);
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
>  		ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 38af045..9b820b1 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -27,6 +27,8 @@
>  #define FUNNEL_HOLDTIME		(0x7 << FUNNEL_HOLDTIME_SHFT)
>  #define FUNNEL_ENSx_MASK	0xff
>  
> +DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
> +
>  /**
>   * struct funnel_drvdata - specifics associated to a funnel component
>   * @base:	memory mapped base address for this component.
> @@ -186,6 +188,10 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> +	desc.name = coresight_alloc_device_name(&funnel_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -216,7 +222,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &funnel_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  	desc.groups = coresight_funnel_groups;
>  	drvdata->csdev = coresight_register(&desc);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 8fbc028..2eb489c 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -22,6 +22,8 @@
>  #define REPLICATOR_IDFILTER0		0x000
>  #define REPLICATOR_IDFILTER1		0x004
>  
> +DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
> +
>  /**
>   * struct replicator_drvdata - specifics associated to a replicator component
>   * @base:	memory mapped base address for this component. Also indicates
> @@ -179,6 +181,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	struct coresight_desc desc = { 0 };
>  	void __iomem *base;
>  
> +	desc.name = coresight_alloc_device_name(&replicator_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -217,7 +223,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	desc.ops = &replicator_cs_ops;
>  	desc.pdata = dev->platform_data;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 5c7fc4a..2d6ae00 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -107,6 +107,8 @@ struct channel_space {
>  	unsigned long		*guaranteed;
>  };
>  
> +DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
> +
>  /**
>   * struct stm_drvdata - specifics associated to an STM component
>   * @base:		memory mapped base address for this component.
> @@ -810,6 +812,10 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
>  
> +	desc.name = coresight_alloc_device_name(&stm_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -854,11 +860,12 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	spin_lock_init(&drvdata->spinlock);
>  
>  	stm_init_default_data(drvdata);
> -	stm_init_generic_data(drvdata, dev_name(dev));
> +	stm_init_generic_data(drvdata, desc.name);
>  
>  	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
>  		dev_info(dev,
> -			 "stm_register_device failed, probing deferred\n");
> +			 "%s : stm_register_device failed, probing deferred\n",
> +			 desc.name);
>  		return -EPROBE_DEFER;
>  	}
>  
> @@ -874,7 +881,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &stm_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  	desc.groups = coresight_stm_groups;
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 94d3ebf..8b7b5d0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -25,6 +25,10 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>  
> +DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
> +DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
> +DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
> +
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>  	/* Ensure formatter, unformatter and hardware fifo are empty */
> @@ -395,6 +399,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct tmc_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> +	struct coresight_dev_list *dev_list = NULL;
>  
>  	ret = -ENOMEM;
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> @@ -425,13 +430,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	desc.dev = dev;
>  	desc.groups = coresight_tmc_groups;
> -	desc.name = dev_name(dev);
>  
>  	switch (drvdata->config_type) {
>  	case TMC_CONFIG_TYPE_ETB:
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>  		desc.ops = &tmc_etb_cs_ops;
> +		dev_list = &etb_devs;
>  		break;
>  	case TMC_CONFIG_TYPE_ETR:
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
> @@ -441,11 +446,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  					 coresight_get_uci_data(id));
>  		if (ret)
>  			goto out;
> +		dev_list = &etr_devs;
>  		break;
>  	case TMC_CONFIG_TYPE_ETF:
>  		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
>  		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>  		desc.ops = &tmc_etf_cs_ops;
> +		dev_list = &etf_devs;
>  		break;
>  	default:
>  		pr_err("%s: Unsupported TMC config\n", desc.name);
> @@ -453,6 +460,12 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto out;
>  	}
>  
> +	desc.name = coresight_alloc_device_name(dev_list, dev);
> +	if (!desc.name) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	pdata = coresight_get_platform_data(dev);
>  	if (IS_ERR(pdata)) {
>  		ret = PTR_ERR(pdata);
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 39a509f..0404434 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -46,6 +46,8 @@
>  #define FFCR_FON_MAN		BIT(6)
>  #define FFCR_STOP_FI		BIT(12)
>  
> +DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
> +
>  /**
>   * @base:	memory mapped base address for this component.
>   * @dev:	the device entity associated to this component.
> @@ -121,6 +123,10 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  
> +	desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
>  		return -ENOMEM;
> @@ -153,7 +159,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.ops = &tpiu_cs_ops;
>  	desc.pdata = pdata;
>  	desc.dev = dev;
> -	desc.name = dev_name(dev);
>  	drvdata->csdev = coresight_register(&desc);
>  
>  	if (!IS_ERR(drvdata->csdev)) {
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 5169ce1..e3b9321 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1289,3 +1289,61 @@ void coresight_unregister(struct coresight_device *csdev)
>  	device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);
> +
> +
> +/*
> + * coresight_search_device_idx - Search the fwnode handle of a device
> + * in the given dev_idx list. Must be called with the coresight_mutex held.
> + *
> + * Returns the index of the entry, when found. Otherwise, -ENOENT.
> + */
> +static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
> +					      struct fwnode_handle *fwnode)
> +{
> +	int i;
> +
> +	for (i = 0; i < dict->nr_idx; i++)
> +		if (dict->fwnode_list[i] == fwnode)
> +			return i;
> +	return -ENOENT;
> +}
> +
> +/*
> + * coresight_alloc_device_name - Get an index for a given device in the
> + * device index list specific to a driver. An index is allocated for a
> + * device and is tracked with the fwnode_handle to prevent allocating
> + * duplicate indices for the same device (e.g, if we defer probing of
> + * a device due to dependencies), in case the index is requested again.
> + */
> +char *coresight_alloc_device_name(struct coresight_dev_list *dict,
> +				  struct device *dev)
> +{
> +	int idx;
> +	char *name = NULL;
> +	struct fwnode_handle **list;
> +
> +	mutex_lock(&coresight_mutex);
> +
> +	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
> +	if (idx < 0) {
> +		/* Make space for the new entry */
> +		idx = dict->nr_idx;
> +		list = krealloc(dict->fwnode_list,
> +				(idx + 1) * sizeof(*dict->fwnode_list),
> +				GFP_KERNEL);
> +		if (ZERO_OR_NULL_PTR(list)) {
> +			idx = -ENOMEM;
> +			goto done;
> +		}
> +
> +		list[idx] = dev_fwnode(dev);
> +		dict->fwnode_list = list;
> +		dict->nr_idx = idx + 1;
> +	}
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
> +done:
> +	mutex_unlock(&coresight_mutex);
> +	return name;
> +}
> +EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 188e759..d6367a0 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -168,6 +168,28 @@ struct coresight_device {
>  	struct dev_ext_attribute *ea;
>  };
>  
> +/*
> + * coresight_dev_list - Mapping for devices to "name" index for device
> + * names.
> + *
> + * @nr_idx:		Number of entries already allocated.
> + * @pfx:		Prefix pattern for device name.
> + * @fwnode_list:	Array of fwnode_handles associated with each allocated
> + *			index, upto nr_idx entries.
> + */
> +struct coresight_dev_list {
> +	int			nr_idx;
> +	const char		*pfx;
> +	struct fwnode_handle	**fwnode_list;
> +};
> +
> +#define DEFINE_CORESIGHT_DEVLIST(var, dev_pfx)				\
> +static struct coresight_dev_list (var) = {				\
> +						.pfx = dev_pfx,		\
> +						.nr_idx = 0,		\
> +						.fwnode_list = NULL,	\
> +}
> +
>  #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
>  
>  #define source_ops(csdev)	csdev->ops->source_ops
> @@ -260,7 +282,8 @@ extern int coresight_claim_device_unlocked(void __iomem *base);
>  
>  extern void coresight_disclaim_device(void __iomem *base);
>  extern void coresight_disclaim_device_unlocked(void __iomem *base);
> -
> +extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
> +					 struct device *dev);
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> -- 
> 2.7.4
> 
