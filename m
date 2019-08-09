Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF7C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B4C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565327304;
	bh=MmF6WWRL1pcs+ucuXcAxtpIt0qSzw7MHhSUeHKq1q5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MNBuRsyUKnUaD/O8Aho/+GRaqKDnJmzWDAGhiMpqwG1XHTTI5bc+bm3nklS3JVqIQ
	 2tMoB5kUN/i2Jl0YKUpZrHV+1RStYSbun1vcL8v1ftKFeVA4JKDEKkt4/xXdMy6SAR
	 rMSW2ZCQtZm2XxeCEosr7++DjWScL1LsnKMeSc2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405294AbfHIFIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIFIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:08:23 -0400
Received: from localhost (unknown [106.51.111.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF96D2166E;
        Fri,  9 Aug 2019 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565327301;
        bh=MmF6WWRL1pcs+ucuXcAxtpIt0qSzw7MHhSUeHKq1q5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2LG3OKFdiLPL4whgmcQBWk81uaHwxpG8blgifwzwTWG3z6G7YdaLKCEJrUTL46xv
         I+ia5RTgcqn6K7mmufL1DVHw7lT28u3l3BmHIRk9FnJ8Lh+QJ9PO3PggQQIDly4WW4
         vM/s77I4JfaXc2aZVmCVhDJCu3h8EGgVuIzhpYyU=
Date:   Fri, 9 Aug 2019 10:37:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for
 slave devices
Message-ID: <20190809050700.GJ12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 15:45, Srinivas Kandagatla wrote:
> This patch adds support to parsing device tree based
> SoundWire slave devices.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/bus.c   |  2 ++
>  drivers/soundwire/bus.h   |  1 +
>  drivers/soundwire/slave.c | 47 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index fe745830a261..324c54dc52fb 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -77,6 +77,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>  	 */
>  	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>  		ret = sdw_acpi_find_slaves(bus);
> +	else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
> +		ret = sdw_of_find_slaves(bus);
>  	else
>  		ret = -ENOTSUPP; /* No ACPI/DT so error out */
>  
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
> index f39a5815e25d..8ab76f5d5a56 100644
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
> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  
>  	slave->dev.release = sdw_slave_release;
>  	slave->dev.bus = &sdw_bus_type;
> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>  	slave->bus = bus;
>  	slave->status = SDW_SLAVE_UNATTACHED;
>  	slave->dev_num = 0;
> @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  }
>  
>  #endif
> +
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
> +	for_each_child_of_node(bus->dev->of_node, node) {
> +		struct sdw_slave_id id;
> +		const char *compat = NULL;
> +		int unique_id, ret;
> +		int ver, mfg_id, part_id, class_id;
> +
> +		compat = of_get_property(node, "compatible", NULL);
> +		if (!compat)
> +			continue;

Why not use of_find_compatible_node() that will return the node which is
sdw* and we dont need to checks on that..

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

empty line here please

> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
> +	}

and here as well

> +	return 0;
> +}
> -- 
> 2.21.0

-- 
~Vinod
