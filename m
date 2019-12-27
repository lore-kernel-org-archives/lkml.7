Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78870C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4561E21582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577437716;
	bh=WiktlAGtOVBzHvmn6Ql3S4fRz6o1TkBwfkOF3dLvX6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xFHuTU9RrelVcjNeWkf84XplKuZj/DzNxmbrnZJ6mDjsbY13J454er/pYMaSDHtV4
	 ynelc+NLYBlVHmqtp5/1D0GTk+ui3jbr+cpmcqzaO69eUXuqFQDZEBzcm1cUt0RhPN
	 hcc7akUEMG3R3+RHs9cUJPWY5lK64olo5YbGT8eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfL0JIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfL0JIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:08:35 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545B320828;
        Fri, 27 Dec 2019 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577437713;
        bh=WiktlAGtOVBzHvmn6Ql3S4fRz6o1TkBwfkOF3dLvX6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erPQnQUH3ZBFEGTF3vAUZAW5DwIuYk/NmJ6Y+0EOVML73gCAZ9fRqzbzFb5kJ4hLe
         nPYN+tX6IOguRSEU7TN3LGahvjYXbNjc3rdggDOd7C1KkJdppqzNko2PofbU7+X+13
         Lm4WPuIjZXm1X+SjmtueU72fspvxwuYa5fyTSQqM=
Date:   Fri, 27 Dec 2019 14:38:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 09/17] soundwire: intel: remove platform devices and
 use 'Master Devices' instead
Message-ID: <20191227090826.GM3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> Use sdw_master_device and driver instead of platform devices
> 
> To quote GregKH:
> 
> "Don't mess with a platform device unless you really have no other
> possible choice. And even then, don't do it and try to do something
> else. Platform devices are really abused, don't perpetuate it "
> 
> In addition, rather than a plain-vanilla init/exit, this patch
> provides 3 steps in the initialization (ACPI scan, probe, startup)
> which makes it easier to verify hardware support for SoundWire,
> allocate required resources as early as possible, and conversely help
> make the startup() callback lighter-weight with only hardware register
> setup.

...

> +struct sdw_md_driver intel_sdw_driver = {
> +	.probe = intel_master_probe,
> +	.startup = intel_master_startup,
> +	.remove = intel_master_remove,
>  };

...

> +extern struct sdw_md_driver intel_sdw_driver;

who uses this intel_sdw_driver? I would assumed someone would register
this with the core...

> +static struct sdw_intel_ctx
> +*sdw_intel_probe_controller(struct sdw_intel_res *res)
> +{
> +	struct sdw_intel_link_res *link;
> +	struct sdw_intel_ctx *ctx;
> +	struct acpi_device *adev;
> +	struct sdw_master_device *md;
> +	u32 link_mask;
> +	int count;
> +	int i;
> +
> +	if (!res)
> +		return NULL;
> +
> +	if (acpi_bus_get_device(res->handle, &adev))
> +		return NULL;
> +
> +	if (!res->count)
> +		return NULL;
> +
> +	count = res->count;
>  	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return NULL;
>  
> -	ctx->count = count;
> -	ctx->links = kcalloc(ctx->count, sizeof(*ctx->links), GFP_KERNEL);
> +	ctx->links = kcalloc(count, sizeof(*ctx->links), GFP_KERNEL);
>  	if (!ctx->links)
>  		goto link_err;
>  
> +	ctx->count = count;
> +	ctx->mmio_base = res->mmio_base;
> +	ctx->link_mask = res->link_mask;
> +	ctx->handle = res->handle;
> +
>  	link = ctx->links;
> +	link_mask = ctx->link_mask;
>  
>  	/* Create SDW Master devices */
> -	for (i = 0; i < count; i++) {
> -		if (link_mask && !(link_mask & BIT(i))) {
> -			dev_dbg(&adev->dev,
> -				"Link %d masked, will not be enabled\n", i);
> -			link++;
> +	for (i = 0; i < count; i++, link++) {
> +		if (link_mask && !(link_mask & BIT(i)))
>  			continue;
> -		}
>  
> +		md = sdw_md_add(&intel_sdw_driver,
> +				res->parent,
> +				acpi_fwnode_handle(adev),
> +				i);
> +
> +		if (IS_ERR(md)) {
> +			dev_err(&adev->dev, "Could not create link %d\n", i);
> +			goto err;
> +		}
> +		link->md = md;
> +		link->mmio_base = res->mmio_base;
>  		link->registers = res->mmio_base + SDW_LINK_BASE
> -					+ (SDW_LINK_SIZE * i);
> +			+ (SDW_LINK_SIZE * i);
>  		link->shim = res->mmio_base + SDW_SHIM_BASE;
>  		link->alh = res->mmio_base + SDW_ALH_BASE;
> -
> +		link->irq = res->irq;
>  		link->ops = res->ops;
>  		link->dev = res->dev;
>  
> -		memset(&pdevinfo, 0, sizeof(pdevinfo));
> -
> -		pdevinfo.parent = res->parent;
> -		pdevinfo.name = "int-sdw";
> -		pdevinfo.id = i;
> -		pdevinfo.fwnode = acpi_fwnode_handle(adev);
> -
> -		pdev = platform_device_register_full(&pdevinfo);
> -		if (IS_ERR(pdev)) {
> -			dev_err(&adev->dev,
> -				"platform device creation failed: %ld\n",
> -				PTR_ERR(pdev));
> -			goto pdev_err;
> -		}
> -
> -		link->pdev = pdev;
> -		link++;
> +		/* let the SoundWire master driver to its probe */
> +		md->driver->probe(md, link);

So you are invoking driver probe here.. That is typically role of driver
core to do that.. If we need that, make driver core do that for you!

That reminds me I am missing match code for master driver...

So we seem to be somewhere is middle wrt driver probing here! IIUC this
is not a full master driver, thats okay, but then it is not
completely transparent either...

I was somehow thinking that the driver will continue to be
'platform/acpi/of' driver and master device abstraction will be
handled in the core (for example see how the busses like i2c handle
this). The master device is created and used to represent but driver
probing etc is not done

Thoughts..?

-- 
~Vinod
