Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0822176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd/DEYh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRAXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:23:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRAXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:23:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so241277pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E8N0ViQoitUFgrGAJrrUPXeTZq813HsPF+2agH2rc4k=;
        b=bd/DEYh0TvGRb4+OQSk0NdPuLPi4TlqL8Drv+aABcAKLLx1IAchKdchxHqI/rBQRyX
         rA9yVTPdRxV/iEgKurCKN1r7uR2RbvkORP8o38EdeXzFCTow/3Jgee8hYYbySR80DPJP
         rjXSsweqAW6J0VyiGyTZCJAleG990bflw9Ddn49+ZaJ0rebJIkerhSRDZRKSverzOy5r
         QNWY6gD5wqiGsEbzw+D4ErmpoorX318UB0O1GrKBQwxjvHxN0D+MbkOnBb+XQ6pFSztt
         YqiugA3rYhK8EkdMiY9giaOuE89fuiumWC2J3LzGET16p0OB4fUYS9LCvDJQnLGqW+7X
         yI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8N0ViQoitUFgrGAJrrUPXeTZq813HsPF+2agH2rc4k=;
        b=lNyLskWKTIYeyLFHn6cPuiSB6a/Jqx3vKlerV6ehIbxzaXbg5icCX0FsIsLOnSo8wk
         b8y5aqSuskh/irVfubTc4AFkGhOcW3TSymgnaPgD2va9ZwwCWDgYLznT1OajuCn0Mxpn
         HGWm+gvshoh2+cNXZ28oZziMm5rcP6/hrO21m00QhXfOXzaqcsenEyKrZkfUo0QuoNjX
         aswny9aFijwimqhS7rahS78126ZpGWthQEkAUuUrzdV4QQREWhC1X5Lv6VCQi5BD6dJe
         Hc74CuNRkTPTyEPbINJhTo2VNUVJmZCbvH0cxPoZUY53uvKMOAuxAEKCfMeb3TQGnByp
         iBNQ==
X-Gm-Message-State: APjAAAVE74KBH6Umw/N82CDUk0cEmTsjC+1PHWMvnkgZ4GEiKFnZJ9q2
        uXGZLl6y0TwBLuxAP/DVwbEyYQ==
X-Google-Smtp-Source: APXvYqyi+GDqXtxIIng1ljuD/eLw/+k4E315TMllMfjOwv+IO9nGEG2aXcAmSHKYJ/hXkd28UnXuug==
X-Received: by 2002:a62:19d1:: with SMTP id 200mr585548pfz.26.1576628579897;
        Tue, 17 Dec 2019 16:22:59 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y17sm217267pfn.86.2019.12.17.16.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 16:22:59 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:22:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 04/15] remoteproc/omap: Add support to parse internal
 memories from DT
Message-ID: <20191218002257.GB16271@xps15>
References: <20191213125537.11509-1-t-kristo@ti.com>
 <20191213125537.11509-5-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213125537.11509-5-t-kristo@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:55:26PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The OMAP remoteproc driver has been enhanced to parse and store
> the kernel mappings for different internal RAM memories that may
> be present within each remote processor IP subsystem. Different
> devices have varying memories present on current SoCs. The current
> support handles the L2RAM for all IPU devices on OMAP4+ SoCs. The
> DSPs on OMAP4/OMAP5 only have Unicaches and do not have any L1 or
> L2 RAM memories.
> 
> IPUs are expected to have the L2RAM at a fixed device address of
> 0x20000000, based on the current limitations on Attribute MMU
> configurations.
> 
> NOTE:
> The current logic doesn't handle the parsing of memories for DRA7
> remoteproc devices, and will be added alongside the DRA7 support.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [t-kristo: converted to parse mem names / device addresses from pdata]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 86 ++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index d80f5d7b5931..844703507a74 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -39,11 +39,27 @@ struct omap_rproc_boot_data {
>  	unsigned int boot_reg;
>  };
>  
> +/*
> + * struct omap_rproc_mem - internal memory structure
> + * @cpu_addr: MPU virtual address of the memory region
> + * @bus_addr: bus address used to access the memory region
> + * @dev_addr: device address of the memory region from DSP view
> + * @size: size of the memory region
> + */
> +struct omap_rproc_mem {
> +	void __iomem *cpu_addr;
> +	phys_addr_t bus_addr;
> +	u32 dev_addr;
> +	size_t size;
> +};
> +
>  /**
>   * struct omap_rproc - omap remote processor state
>   * @mbox: mailbox channel handle
>   * @client: mailbox client to request the mailbox channel
>   * @boot_data: boot data structure for setting processor boot address
> + * @mem: internal memory regions data
> + * @num_mems: number of internal memory regions
>   * @rproc: rproc handle
>   * @reset: reset handle
>   */
> @@ -51,6 +67,8 @@ struct omap_rproc {
>  	struct mbox_chan *mbox;
>  	struct mbox_client client;
>  	struct omap_rproc_boot_data *boot_data;
> +	struct omap_rproc_mem *mem;
> +	int num_mems;
>  	struct rproc *rproc;
>  	struct reset_control *reset;
>  };
> @@ -59,10 +77,14 @@ struct omap_rproc {
>   * struct omap_rproc_dev_data - device data for the omap remote processor
>   * @device_name: device name of the remote processor
>   * @has_bootreg: true if this remote processor has boot register
> + * @mem_names: memory names for this remote processor
> + * @dev_addrs: device addresses corresponding to the memory names
>   */
>  struct omap_rproc_dev_data {
>  	const char *device_name;
>  	bool has_bootreg;
> +	const char * const *mem_names;
> +	const u32 *dev_addrs;

Bunching these two in a new structure like omap_rproc_mem_data would clean
things up.  That way the two arrays in the next hunk get merged and there can't
be a difference in sizes, somthing that will sturdy the main loop in
omap_rproc_of_get_internal_memories() below. 

>  };
>  
>  /**
> @@ -216,6 +238,14 @@ static const struct rproc_ops omap_rproc_ops = {
>  	.kick		= omap_rproc_kick,
>  };
>  
> +static const char * const ipu_mem_names[] = {
> +	"l2ram", NULL
> +};
> +
> +static const u32 ipu_dev_addrs[] = {
> +	0x20000000,
> +};
> +
>  static const struct omap_rproc_dev_data omap4_dsp_dev_data = {
>  	.device_name	= "dsp",
>  	.has_bootreg	= true,
> @@ -223,6 +253,8 @@ static const struct omap_rproc_dev_data omap4_dsp_dev_data = {
>  
>  static const struct omap_rproc_dev_data omap4_ipu_dev_data = {
>  	.device_name	= "ipu",
> +	.mem_names	= ipu_mem_names,
> +	.dev_addrs	= ipu_dev_addrs,
>  };
>  
>  static const struct omap_rproc_dev_data omap5_dsp_dev_data = {
> @@ -232,6 +264,8 @@ static const struct omap_rproc_dev_data omap5_dsp_dev_data = {
>  
>  static const struct omap_rproc_dev_data omap5_ipu_dev_data = {
>  	.device_name	= "ipu",
> +	.mem_names	= ipu_mem_names,
> +	.dev_addrs	= ipu_dev_addrs,
>  };
>  
>  static const struct of_device_id omap_rproc_of_match[] = {
> @@ -311,6 +345,54 @@ static int omap_rproc_get_boot_data(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int omap_rproc_of_get_internal_memories(struct platform_device *pdev,
> +					       struct rproc *rproc)
> +{
> +	struct omap_rproc *oproc = rproc->priv;
> +	struct device *dev = &pdev->dev;
> +	const struct omap_rproc_dev_data *data;
> +	struct resource *res;
> +	int num_mems;
> +	int i;
> +
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	if (!data->mem_names)
> +		return 0;
> +
> +	for (num_mems = 0; data->mem_names[num_mems]; num_mems++)
> +		;

Instead of doing this function of_property_count_elems_of_size() can be used on
the "reg" property.

In the loop below a check should be done to see if data->mem_data[i] (see above
comment) is valid before calling platform_get_resource_byname().  If not then
an error can be returned.

I'm running out of time for today - I will continue reviewing the other patches
tomorrow.

> +
> +	oproc->mem = devm_kcalloc(dev, num_mems, sizeof(*oproc->mem),
> +				  GFP_KERNEL);
> +	if (!oproc->mem)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_mems; i++) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   data->mem_names[i]);
> +		oproc->mem[i].cpu_addr = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(oproc->mem[i].cpu_addr)) {
> +			dev_err(dev, "failed to parse and map %s memory\n",
> +				data->mem_names[i]);
> +			return PTR_ERR(oproc->mem[i].cpu_addr);
> +		}
> +		oproc->mem[i].bus_addr = res->start;
> +		oproc->mem[i].dev_addr = data->dev_addrs[i];
> +		oproc->mem[i].size = resource_size(res);
> +
> +		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
> +			data->mem_names[i], &oproc->mem[i].bus_addr,
> +			oproc->mem[i].size, oproc->mem[i].cpu_addr,
> +			oproc->mem[i].dev_addr);
> +	}
> +	oproc->num_mems = num_mems;
> +
> +	return 0;
> +}
> +
>  static int omap_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -350,6 +432,10 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  	/* All existing OMAP IPU and DSP processors have an MMU */
>  	rproc->has_iommu = true;
>  
> +	ret = omap_rproc_of_get_internal_memories(pdev, rproc);
> +	if (ret)
> +		goto free_rproc;
> +
>  	ret = omap_rproc_get_boot_data(pdev, rproc);
>  	if (ret)
>  		goto free_rproc;
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
