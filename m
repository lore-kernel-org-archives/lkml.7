Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90138C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695A4217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561962060;
	bh=StqomvvpXflnRhDKL1dnp4Cn8wLcNE+ioYBf5EJMvSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I24i8D3lfuqNXFnFP3pjYYnG7f1ThEqomdvDvlt2buLQU4tHHiWhImGHnPVXes44E
	 laZXrPbs9VWlJpbOI68kOZYuuGKmWGNbyWa/TC8JEWN5lfjTpTmNP20z7/iBiCJe7J
	 90XwFQ8XSql1UT4207A2brH52wJWS6tK+UbYx4Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfGAGU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfGAGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:20:56 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D3C20B7C;
        Mon,  1 Jul 2019 06:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561962055;
        bh=StqomvvpXflnRhDKL1dnp4Cn8wLcNE+ioYBf5EJMvSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qhdnkx3NMl/OHo0W8jfSJlvavK54m9wt+kzowzosr+VKbbTez0psR/3NasyeR6f0v
         MlPxTCL58hYRS1tO+jFj0z7MK3WIXILIEkzL8Id+8R112wvw26PTCMX0ZQix5pGYay
         PiCd+55IRc/33wtU7duuPBEEiHt+/+7EtYec9C74=
Date:   Mon, 1 Jul 2019 11:47:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
Subject: Re: [RFC PATCH 2/5] soundwire: core: add device tree support for
 slave devices
Message-ID: <20190701061745.GK2911@vkoul-mobl>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611104043.22181-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-19, 11:40, Srinivas Kandagatla wrote:
> This patch adds support to parsing device tree based
> SoundWire slave devices.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/bus.c   |  2 +-
>  drivers/soundwire/bus.h   |  1 +
>  drivers/soundwire/slave.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index fe745830a261..20f26cf4ba74 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -78,7 +78,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>  		ret = sdw_acpi_find_slaves(bus);
>  	else
> -		ret = -ENOTSUPP; /* No ACPI/DT so error out */
> +		ret = sdw_of_find_slaves(bus);
>  
>  	if (ret) {
>  		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 3048ca153f22..ee46befedbd1 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  }
>  #endif
>  
> +int sdw_of_find_slaves(struct sdw_bus *bus);
>  void sdw_extract_slave_id(struct sdw_bus *bus,
>  			  u64 addr, struct sdw_slave_id *id);
>  
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..6e7f5cfeb854 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -2,6 +2,7 @@
>  // Copyright(c) 2015-17 Intel Corporation.
>  
>  #include <linux/acpi.h>
> +#include <linux/of.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
> @@ -28,13 +29,14 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	slave->dev.parent = bus->dev;
>  	slave->dev.fwnode = fwnode;
>  
> -	/* name shall be sdw:link:mfg:part:class:unique */
> +	/* name shall be sdw:link:mfg:part:class */

nope we are not changing dev_set_name below so this comment should not
be modified

>  	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
>  		     bus->link_id, id->mfg_id, id->part_id,
>  		     id->class_id, id->unique_id);
>  
>  	slave->dev.release = sdw_slave_release;
>  	slave->dev.bus = &sdw_bus_type;
> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>  	slave->bus = bus;
>  	slave->status = SDW_SLAVE_UNATTACHED;
>  	slave->dev_num = 0;
> @@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  }
>  
>  #endif
> +
> +#if IS_ENABLED(CONFIG_OF)
> +/*
> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
> + * @bus: SDW bus instance
> + *
> + * Scans Master DT node for SDW child Slave devices and registers it.
> + */
> +int sdw_of_find_slaves(struct sdw_bus *bus)
> +{
> +	struct device *dev = bus->dev;
> +	struct device_node *node;
> +
> +	if (!bus->dev->of_node)
> +		return 0;

this should be error, otherwise next condition of checking slaves wont
be triggered..

> +
> +	for_each_child_of_node(bus->dev->of_node, node) {
> +		struct sdw_slave_id id;
> +		const char *compat = NULL;
> +		int unique_id, ret;
> +		int ver, mfg_id, part_id, class_id;
> +		compat = of_get_property(node, "compatible", NULL);
> +		if (!compat)
> +			continue;
> +
> +		ret = sscanf(compat, "sdw%x,%x,%x,%x",
> +			     &ver, &mfg_id, &part_id, &class_id);
> +		if (ret != 4) {
> +			dev_err(dev, "Manf ID & Product code not found %s\n",
> +				compat);
> +			continue;
> +		}
> +
> +		ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
> +		if (ret) {
> +			dev_err(dev, "Instance id not found:%d\n", ret);
> +			continue;
> +		}
> +
> +		id.sdw_version = ver - 0xF;
> +		id.unique_id = unique_id;
> +		id.mfg_id = mfg_id;
> +		id.part_id = part_id;
> +		id.class_id = class_id;
> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
> +	}
> +	return 0;
> +}
> +
> +#endif
> -- 
> 2.21.0

-- 
~Vinod
