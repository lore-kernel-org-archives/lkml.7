Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A47C24656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576222131;
	bh=+niX70uV+yPF/oKnmdkLlo2kitdtTy/DXb5H25cB5w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lrhvBUO0hpizoN5/TjcaIB2qgX44tucuRCp2NE+DLqfSmhNPnVMDJLfGC2owjB6Gs
	 /eeSdaLOVn3/tnlTgCnB0i5pUyc7t1tnEw+kWdnmDhoNgU0zWBG84iPi65/8a7CUA/
	 e0s2MUbvrdnvE8lj//BfBwCUBTVcmijjmteKlxdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLMH2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:28:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLMH2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:28:49 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5F622527;
        Fri, 13 Dec 2019 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576222128;
        bh=+niX70uV+yPF/oKnmdkLlo2kitdtTy/DXb5H25cB5w0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYKrOiMI/Nqdsc/Xg42qiUTyoR+F/KAKK6aIRJsw0OlRDnLTDvIHSicpVWFTDy1He
         wL3Vjx6+f1sN0VP2LfFbWUgFlUFUN16ROzbnuRNydtuILYWcJpVKU2QR1jKXPzS/MC
         pdlOJk3LwOAPsEQybRoqFOFoGTqZSfuSX11nkFPg=
Date:   Fri, 13 Dec 2019 08:28:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 08/15] soundwire: add initial definitions for
 sdw_master_device
Message-ID: <20191213072844.GF1750354@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:04:02PM -0600, Pierre-Louis Bossart wrote:
> Since we want an explicit support for the SoundWire Master device, add
> the definitions, following the Grey Bus example.

"Greybus"  All one word please.

> 
> Unlike for the Slave device, we do not set a variable when dealing
> with the master uevent.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile         |  2 +-
>  drivers/soundwire/bus_type.c       |  7 +++-
>  drivers/soundwire/master.c         | 62 ++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h      | 35 +++++++++++++++++
>  include/linux/soundwire/sdw_type.h |  9 +++++
>  5 files changed, 112 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/soundwire/master.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 563894e5ecaf..89b29819dd3a 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  #Bus Objs
> -soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
> +soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o stream.o
>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>  
>  ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 5c18c21545b5..df1271f6db61 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -59,9 +59,12 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  
>  		if (add_uevent_var(env, "MODALIAS=%s", modalias))
>  			return -ENOMEM;
> +	} else if (is_sdw_md(dev)) {

Ok, "is_sdw_md()" is a horrid function name.  Spell it out please, this
ends up in the global namespace.

Actually, why are you not using module namespaces here for this new
code?  That would help you out a lot.


> +		/* this should not happen but throw an error */
> +		dev_warn(dev, "uevent for Master device, unsupported\n");

Um, what?  This is supported as it will happen when you create such a
device.  It's an issue of "I didn't write the code yet", not that it is
not "supported".

> +		return -EINVAL;
>  	} else {
> -		/* only Slave device type supported */
> -		dev_warn(dev, "uevent for unknown Soundwire type\n");
> +		dev_warn(dev, "uevent for unknown device\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
> new file mode 100644
> index 000000000000..6210098c892b
> --- /dev/null
> +++ b/drivers/soundwire/master.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)

Still with the crazy dual license?  I thought we went over this all
before.

You can not do this for code that touches driver core stuff, like this.
Please stop and just make all of this GPLv2 like we discussed months
ago.

> +// Copyright(c) 2019 Intel Corporation.
> +
> +#include <linux/device.h>
> +#include <linux/acpi.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_type.h>
> +#include "bus.h"
> +
> +static void sdw_md_release(struct device *dev)
> +{
> +	struct sdw_master_device *md = to_sdw_master_device(dev);
> +
> +	kfree(md);
> +}
> +
> +struct device_type sdw_md_type = {
> +	.name =		"soundwire_master",
> +	.release =	sdw_md_release,
> +};
> +
> +struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,

Bad function names, please spell things out, you have plenty of
characters to go around.


> +				     struct device *parent,
> +				     struct fwnode_handle *fwnode,
> +				     int link_id)
> +{
> +	struct sdw_master_device *md;
> +	int ret;
> +
> +	if (!driver->probe) {
> +		dev_err(parent, "mandatory probe callback missing\n");

The callback is missing for the driver you passed in, not for the
parent, right?

> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	md = kzalloc(sizeof(*md), GFP_KERNEL);
> +	if (!md)
> +		return ERR_PTR(-ENOMEM);
> +
> +	md->link_id = link_id;
> +
> +	md->driver = driver;
> +
> +	md->dev.parent = parent;
> +	md->dev.fwnode = fwnode;
> +	md->dev.bus = &sdw_bus_type;
> +	md->dev.type = &sdw_md_type;
> +	md->dev.dma_mask = md->dev.parent->dma_mask;
> +	dev_set_name(&md->dev, "sdw-master-%d", md->link_id);
> +
> +	ret = device_register(&md->dev);
> +	if (ret) {
> +		dev_err(parent, "Failed to add master: ret %d\n", ret);
> +		/*
> +		 * On err, don't free but drop ref as this will be freed
> +		 * when release method is invoked.
> +		 */
> +		put_device(&md->dev);

But you still return a valid pointer?  Why????

> +	}
> +
> +	return md;
> +}
> +EXPORT_SYMBOL(sdw_md_add);

EXPORT_SYMBOL_GPL()?


> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 5b1180f1e6b5..af0a72e7afdf 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -585,6 +585,16 @@ struct sdw_slave {
>  #define to_sdw_slave_device(d) \
>  	container_of(d, struct sdw_slave, dev)
>  
> +struct sdw_master_device {
> +	struct device dev;
> +	int link_id;
> +	struct sdw_md_driver *driver;
> +	void *pdata; /* core does not touch */

Core of what?

> +};
> +
> +#define to_sdw_master_device(d)	\
> +	container_of(d, struct sdw_master_device, dev)
> +
>  struct sdw_driver {
>  	const char *name;
>  
> @@ -599,6 +609,26 @@ struct sdw_driver {
>  	struct device_driver driver;
>  };
>  
> +struct sdw_md_driver {
> +	/* initializations and allocations */
> +	int (*probe)(struct sdw_master_device *md, void *link_ctx);
> +	/* hardware enablement, all clock/power dependencies are available */
> +	int (*startup)(struct sdw_master_device *md);
> +	/* hardware disabled */
> +	int (*shutdown)(struct sdw_master_device *md);
> +	/* free all resources */
> +	int (*remove)(struct sdw_master_device *md);
> +	/*
> +	 * enable/disable driver control while in clock-stop mode,
> +	 * typically in always-on/D0ix modes. When the driver yields
> +	 * control, another entity in the system (typically firmware
> +	 * running on an always-on microprocessor) is responsible to
> +	 * tracking Slave-initiated wakes
> +	 */
> +	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
> +					    bool state);
> +};

Use kerneldoc comments for this to make it easier to understand and for
others to read?

thanks,

greg k-h
