Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29173CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 06:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A512084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572762888;
	bh=TTaEmdSMoXFvWJB8M9tF7dDrCSl0UeZB4Ed8rEoKX+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQ457yWuq+G4L3S9tgGJ6XaRif6cw5IZ8nCRfb9EuPH/xsOrpRpj2st3Hx1JlUbck
	 Ab14+wTeLxMNEWNrXuOZkgigsNIx0dfXI5yDnTYGHXqP2GO/TGn8M9kd3yU0u04HHn
	 83lqJhhYQkPgvMhY4w/8hgpTSN4okSb6/x++7vjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKCGa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 01:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKCGa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:30:59 -0500
Received: from localhost (unknown [106.206.31.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16892084D;
        Sun,  3 Nov 2019 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572762658;
        bh=TTaEmdSMoXFvWJB8M9tF7dDrCSl0UeZB4Ed8rEoKX+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9Vs1KFVvTRE29YW4iQUNjc5yulAUWAWx7E9qgfAEIoK9iDbYiYW0/6lmNH39iV47
         q4lQIa3d7XE2ukY4rdyctuAAFZf6I4V/EqOgS8mRDucr2waG1rPWGgtTfpyRYaN18n
         V8fB9LecZMCZQA1acVt/BkeIJ3nArcij2sJy99eY=
Date:   Sun, 3 Nov 2019 12:00:51 +0530
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
Subject: Re: [PATCH 07/14] soundwire: add initial definitions for
 sdw_master_device
Message-ID: <20191103063051.GJ2695@vkoul-mobl.Dlink>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023212823.608-8-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
> Since we want an explicit support for the SoundWire Master device, add
> the definitions, following the Grey Bus example.
> 
> Open: do we need to set a variable when dealing with the master uevent?

I dont think we want that or we need that!

And to prevent that rather than adding a variable, can you please
modify the device_type and use separate ones for master_device and
slave_device

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile         |  2 +-
>  drivers/soundwire/bus_type.c       | 16 +++++---
>  drivers/soundwire/master.c         | 62 ++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h      | 35 +++++++++++++++++
>  include/linux/soundwire/sdw_type.h |  9 +++++
>  5 files changed, 117 insertions(+), 7 deletions(-)
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
> index 5df095f4e12f..cf33f63773f0 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -49,21 +49,25 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> +	struct sdw_master_device *md;
>  	struct sdw_slave *slave;
>  	char modalias[32];
>  
> -	if (is_sdw_slave(dev)) {
> +	if (is_sdw_md(dev)) {
> +		md = to_sdw_master_device(dev);

md seems unused?

> +		/* TODO: do we need to call add_uevent_var() ? */
> +	} else if (is_sdw_slave(dev)) {
>  		slave = to_sdw_slave_device(dev);
> +
> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
> +
> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> +			return -ENOMEM;
>  	} else {
>  		dev_warn(dev, "uevent for unknown Soundwire type\n");
>  		return -EINVAL;
>  	}
>  
> -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> -
> -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> -		return -ENOMEM;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
> new file mode 100644
> index 000000000000..6210098c892b
> --- /dev/null
> +++ b/drivers/soundwire/master.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
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
> +				     struct device *parent,
> +				     struct fwnode_handle *fwnode,
> +				     int link_id)
> +{
> +	struct sdw_master_device *md;
> +	int ret;
> +
> +	if (!driver->probe) {
> +		dev_err(parent, "mandatory probe callback missing\n");
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
> +	}
> +
> +	return md;
> +}
> +EXPORT_SYMBOL(sdw_md_add);
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index d6e5a0e42819..6f8b6a0cbcb7 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -573,6 +573,16 @@ struct sdw_slave {
>  #define to_sdw_slave_device(d) \
>  	container_of(d, struct sdw_slave, dev)
>  
> +struct sdw_master_device {
> +	struct device dev;
> +	int link_id;
> +	struct sdw_md_driver *driver;
> +	void *pdata; /* core does not touch */

what is the use for this, also please add kernel-doc style comments for
core structs

> +};
> +
> +#define to_sdw_master_device(d)	\
> +	container_of(d, struct sdw_master_device, dev)
> +
>  struct sdw_driver {
>  	const char *name;
>  
> @@ -587,6 +597,26 @@ struct sdw_driver {
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
> +
>  #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
>  	{ .mfg_id = (_mfg_id), .part_id = (_part_id), \
>  	  .driver_data = (unsigned long)(_drv_data) }
> @@ -776,6 +806,11 @@ struct sdw_bus {
>  int sdw_add_bus_master(struct sdw_bus *bus);
>  void sdw_delete_bus_master(struct sdw_bus *bus);
>  
> +struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
> +				     struct device *parent,
> +				     struct fwnode_handle *fwnode,
> +				     int link_id);
> +
>  /**
>   * sdw_port_config: Master or Slave Port configuration
>   *
> diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
> index c681b3426478..463d6d018d56 100644
> --- a/include/linux/soundwire/sdw_type.h
> +++ b/include/linux/soundwire/sdw_type.h
> @@ -6,15 +6,24 @@
>  
>  extern struct bus_type sdw_bus_type;
>  extern struct device_type sdw_slave_type;
> +extern struct device_type sdw_md_type;
>  
>  static inline int is_sdw_slave(const struct device *dev)
>  {
>  	return dev->type == &sdw_slave_type;
>  }
>  
> +static inline int is_sdw_md(const struct device *dev)
> +{
> +	return dev->type == &sdw_md_type;
> +}
> +
>  #define to_sdw_slave_driver(_drv) \
>  	container_of(_drv, struct sdw_driver, driver)
>  
> +#define to_sdw_md_driver(_drv) \
> +	container_of(_drv, struct sdw_md_driver, driver)
> +
>  #define sdw_register_slave_driver(drv) \
>  	__sdw_register_slave_driver(drv, THIS_MODULE)
>  
> -- 
> 2.20.1

-- 
~Vinod
