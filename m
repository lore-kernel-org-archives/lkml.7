Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664BC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAE42084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 06:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556952890;
	bh=JSVyGvinm9vwxtIIc7O7s071gy2qWsZnvbImhy3lmJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qzDjKPCXUZAo7T5bODBEPILqd1TAjjjhhIGZn8glQ+yxseywpdjZ0MgbeDwE/7mkx
	 MGSliFY8lSOOErrROJ2k4C2wsXO7dGadSgewlVqXs0Zr5MXcLztqTQuQKN3ZMUo6Ic
	 JuDampMPCP1P0Cc3za7IyI08itDrWbEMiLusFQ08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEDGys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 02:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfEDGys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 02:54:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB09205C9;
        Sat,  4 May 2019 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556952887;
        bh=JSVyGvinm9vwxtIIc7O7s071gy2qWsZnvbImhy3lmJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rQ3aJOLbmkbpKLZIy0Es3ld5Mh7JolzQ1HHjxrQalgKkWPfiV4PoiLRdtqhcqBKx
         vRQ8GZHzSZcGeZDdHSUrf2NVpRUqi5xFuGnN9EM+11s+2KymnuK8qFk6bvIEAPJFMN
         IifiYT0+Rk9U+ciNBSu0fvRPykNjaq5segiudb34=
Date:   Sat, 4 May 2019 08:54:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 2/7] soundwire: add Slave sysfs support
Message-ID: <20190504065444.GC9770@kroah.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 08:00:25PM -0500, Pierre-Louis Bossart wrote:
> Add DisCo Slave properties as device attributes.
> Add a device for Data Port 0 which adds Dp0 properties as attributes.
> Add devices for Source and Sink Data Ports, and add Dp-N
> properties as attributes.
> 
> The Slave, DP0 and DPn cases are intentionally handled in separate
> files to avoid conflicts with attributes having the same names at
> different levels.
> 
> Audio modes are not supported for now. Depending on the discussions
> the SoundWire Device Class, we may add it later as is or follow the
> new specification.
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile          |   2 +-
>  drivers/soundwire/bus.c             |   2 +
>  drivers/soundwire/bus.h             |   2 +
>  drivers/soundwire/bus_type.c        |   5 +
>  drivers/soundwire/slave.c           |   1 +
>  drivers/soundwire/sysfs.c           | 213 ++++++++++++++++++++++++++++
>  drivers/soundwire/sysfs_local.h     |  42 ++++++
>  drivers/soundwire/sysfs_slave_dp0.c | 112 +++++++++++++++
>  drivers/soundwire/sysfs_slave_dpn.c | 168 ++++++++++++++++++++++
>  include/linux/soundwire/sdw.h       |   5 +
>  10 files changed, 551 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soundwire/sysfs_local.h
>  create mode 100644 drivers/soundwire/sysfs_slave_dp0.c
>  create mode 100644 drivers/soundwire/sysfs_slave_dpn.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 787f1cbf342c..a72a29731a28 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -4,7 +4,7 @@
>  
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o \
> -			sysfs.o
> +			sysfs.o sysfs_slave_dp0.o sysfs_slave_dpn.o
>  obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>  
>  #Cadence Objs
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 38de7071e135..dd9181693554 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -113,6 +113,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
> +	sdw_sysfs_slave_exit(slave);
> +
>  	mutex_lock(&bus->bus_lock);
>  
>  	if (slave->dev_num) /* clear dev_num if assigned */
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 3048ca153f22..0707e68a8d21 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -18,6 +18,8 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  void sdw_extract_slave_id(struct sdw_bus *bus,
>  			  u64 addr, struct sdw_slave_id *id);
>  
> +extern const struct attribute_group *sdw_slave_dev_attr_groups[];
> +
>  enum {
>  	SDW_MSG_FLAG_READ = 0,
>  	SDW_MSG_FLAG_WRITE,
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 2655602f0cfb..f68fe45c1037 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -97,6 +97,11 @@ static int sdw_drv_probe(struct device *dev)
>  	if (slave->ops && slave->ops->read_prop)
>  		slave->ops->read_prop(slave);
>  
> +	/* init the sysfs as we have properties now */
> +	ret = sdw_sysfs_slave_init(slave);
> +	if (ret < 0)
> +		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
> +
>  	/*
>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
>  	 * 300ms
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..bad73a267fdd 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -34,6 +34,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  		     id->class_id, id->unique_id);
>  
>  	slave->dev.release = sdw_slave_release;
> +	slave->dev.groups = sdw_slave_dev_attr_groups;
>  	slave->dev.bus = &sdw_bus_type;
>  	slave->bus = bus;
>  	slave->status = SDW_SLAVE_UNATTACHED;
> diff --git a/drivers/soundwire/sysfs.c b/drivers/soundwire/sysfs.c
> index 7b6c3826a73a..734e2c8bc5cd 100644
> --- a/drivers/soundwire/sysfs.c
> +++ b/drivers/soundwire/sysfs.c
> @@ -8,6 +8,7 @@
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
> +#include "sysfs_local.h"
>  
>  struct sdw_master_sysfs {
>  	struct device dev;
> @@ -160,3 +161,215 @@ void sdw_sysfs_bus_exit(struct sdw_bus *bus)
>  	put_device(&master->dev);
>  	bus->sysfs = NULL;
>  }
> +
> +/*
> + * Slave sysfs
> + */
> +
> +/*
> + * The sysfs for Slave reflects the MIPI description as given
> + * in the MIPI DisCo spec
> + *
> + * Base file is device
> + *	|---- mipi_revision
> + *	|---- wake_capable
> + *	|---- test_mode_capable
> + *	|---- simple_clk_stop_capable
> + *	|---- clk_stop_timeout
> + *	|---- ch_prep_timeout
> + *	|---- reset_behave
> + *	|---- high_PHY_capable
> + *	|---- paging_support
> + *	|---- bank_delay_support
> + *	|---- p15_behave
> + *	|---- master_count
> + *	|---- source_ports
> + *	|---- sink_ports
> + *	|---- dp0
> + *		|---- max_word
> + *		|---- min_word
> + *		|---- words
> + *		|---- flow_controlled
> + *		|---- simple_ch_prep_sm
> + *		|---- device_interrupts
> + *	|---- dpN
> + *		|---- max_word
> + *		|---- min_word
> + *		|---- words
> + *		|---- type
> + *		|---- max_grouping
> + *		|---- simple_ch_prep_sm
> + *		|---- ch_prep_timeout
> + *		|---- device_interrupts
> + *		|---- max_ch
> + *		|---- min_ch
> + *		|---- ch
> + *		|---- ch_combinations
> + *		|---- modes
> + *		|---- max_async_buffer
> + *		|---- block_pack_mode
> + *		|---- port_encoding
> + *		|---- audio_modeM
> + *				|---- bus_min_freq
> + *				|---- bus_max_freq
> + *				|---- bus_freq
> + *				|---- max_freq
> + *				|---- min_freq
> + *				|---- freq
> + *				|---- prep_ch_behave
> + *				|---- glitchless
> + *
> + */
> +
> +#define sdw_slave_attr(field, format_string)			\
> +static ssize_t field##_show(struct device *dev,			\
> +			    struct device_attribute *attr,	\
> +			    char *buf)				\
> +{								\
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);		\
> +	return sprintf(buf, format_string, slave->prop.field);	\
> +}								\
> +static DEVICE_ATTR_RO(field)
> +
> +sdw_slave_attr(mipi_revision, "0x%x\n");
> +sdw_slave_attr(wake_capable, "%d\n");
> +sdw_slave_attr(test_mode_capable, "%d\n");
> +sdw_slave_attr(clk_stop_mode1, "%d\n");
> +sdw_slave_attr(simple_clk_stop_capable, "%d\n");
> +sdw_slave_attr(clk_stop_timeout, "%d\n");
> +sdw_slave_attr(ch_prep_timeout, "%d\n");
> +sdw_slave_attr(reset_behave, "%d\n");
> +sdw_slave_attr(high_PHY_capable, "%d\n");
> +sdw_slave_attr(paging_support, "%d\n");
> +sdw_slave_attr(bank_delay_support, "%d\n");
> +sdw_slave_attr(p15_behave, "%d\n");
> +sdw_slave_attr(master_count, "%d\n");
> +sdw_slave_attr(source_ports, "%d\n");
> +sdw_slave_attr(sink_ports, "%d\n");
> +
> +static ssize_t modalias_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> +
> +	return sdw_slave_modalias(slave, buf, 256);
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
> +static struct attribute *slave_dev_attrs[] = {
> +	&dev_attr_mipi_revision.attr,
> +	&dev_attr_wake_capable.attr,
> +	&dev_attr_test_mode_capable.attr,
> +	&dev_attr_clk_stop_mode1.attr,
> +	&dev_attr_simple_clk_stop_capable.attr,
> +	&dev_attr_clk_stop_timeout.attr,
> +	&dev_attr_ch_prep_timeout.attr,
> +	&dev_attr_reset_behave.attr,
> +	&dev_attr_high_PHY_capable.attr,
> +	&dev_attr_paging_support.attr,
> +	&dev_attr_bank_delay_support.attr,
> +	&dev_attr_p15_behave.attr,
> +	&dev_attr_master_count.attr,
> +	&dev_attr_source_ports.attr,
> +	&dev_attr_sink_ports.attr,
> +	&dev_attr_modalias.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sdw_slave_dev_attr_group = {
> +	.attrs	= slave_dev_attrs,
> +};
> +
> +const struct attribute_group *sdw_slave_dev_attr_groups[] = {
> +	&sdw_slave_dev_attr_group,
> +	NULL
> +};

ATTRIBUTE_GROUP()?


> +
> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> +{
> +	struct sdw_slave_sysfs *sysfs;
> +	unsigned int src_dpns, sink_dpns, i, j;
> +	int err;
> +
> +	if (slave->sysfs) {
> +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
> +		err = -EIO;
> +		goto err_ret;
> +	}
> +
> +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);

Same question as patch 1, why a new device?

thanks,

greg k-h
