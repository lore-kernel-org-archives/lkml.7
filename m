Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ABC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FD6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577429678;
	bh=2weN5JX6ZnkjswoyolQKjBIPCekkLFG5RXJ35lLQBJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmIRcnWYWoUMCntWYpZtZnjTQvWqDHwd3bj2i8us5BqNUYwEZu9pRMjjwEmzc7nta
	 SgiBJdiuPTTFeDXAWz+oRB2veaH+b0VPkiLRpY1ZxG8vBQoJ5nfsQgU7sjZDwuHGmS
	 CdhdZZaP0HdyQczNJbviWUEC2ksBSXoX0HZbutX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfL0Gyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfL0Gyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:54:37 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD880206CB;
        Fri, 27 Dec 2019 06:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577429676;
        bh=2weN5JX6ZnkjswoyolQKjBIPCekkLFG5RXJ35lLQBJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTfA0fEmxzH/+1heFC/7hwhz2SR019KKApYwddkwF7ZZlsMfPpImQyG65INVEOWSn
         rZqGdhz9/b6oysNvoQLMcPFyPiWnCw8ed06QRC26ADY7OUzzyMzMmPAc+WKMU04lAx
         uqIPtym/SENW8OZXY9GAMqzWM6lQQlcBuqt/HorU=
Date:   Fri, 27 Dec 2019 12:24:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v5 02/17] soundwire: rename dev_to_sdw_dev macro
Message-ID: <20191227065430.GI3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217210314.20410-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 15:02, Pierre-Louis Bossart wrote:
> Since we want to introduce master devices, rename macro so that we
> have consistency between slave and master device access.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/base/regmap/regmap-sdw.c |  4 ++--

need ack from Mark on this...

>  drivers/soundwire/bus.c          |  2 +-
>  drivers/soundwire/bus_type.c     | 11 ++++++-----
>  drivers/soundwire/slave.c        |  2 +-
>  include/linux/soundwire/sdw.h    |  3 ++-
>  5 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index 50a66382d87d..d1fc0c22180a 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -10,7 +10,7 @@
>  static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
>  {
>  	struct device *dev = context;
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  
>  	return sdw_write(slave, reg, val);
>  }
> @@ -18,7 +18,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
>  static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct device *dev = context;
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	int read;
>  
>  	read = sdw_read(slave, reg);
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index be5d437058ed..4b22ee996a65 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -110,7 +110,7 @@ EXPORT_SYMBOL(sdw_add_bus_master);
>  
>  static int sdw_delete_slave(struct device *dev, void *data)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
>  	sdw_slave_debugfs_exit(slave);
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 370b94752662..c0585bcc8a41 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -33,7 +33,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
>  
>  static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
>  
>  	return !!sdw_get_device_id(slave, drv);
> @@ -49,7 +49,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	char modalias[32];
>  
>  	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> @@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(sdw_bus_type);
>  
>  static int sdw_drv_probe(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
>  	const struct sdw_device_id *id;
>  	int ret;
> @@ -115,8 +115,9 @@ static int sdw_drv_probe(struct device *dev)
>  
>  static int sdw_drv_remove(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
> +
>  	int ret = 0;
>  
>  	if (drv->remove)
> @@ -129,7 +130,7 @@ static int sdw_drv_remove(struct device *dev)
>  
>  static void sdw_drv_shutdown(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  	struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
>  
>  	if (drv->shutdown)
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 19919975bb6d..48a513680db6 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -9,7 +9,7 @@
>  
>  static void sdw_slave_release(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +	struct sdw_slave *slave = to_sdw_slave_device(dev);
>  
>  	kfree(slave);
>  }
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index b7c9eca4332a..5b1180f1e6b5 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -582,7 +582,8 @@ struct sdw_slave {
>  	u32 unattach_request;
>  };
>  
> -#define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
> +#define to_sdw_slave_device(d) \
> +	container_of(d, struct sdw_slave, dev)
>  
>  struct sdw_driver {
>  	const char *name;
> -- 
> 2.20.1

-- 
~Vinod
