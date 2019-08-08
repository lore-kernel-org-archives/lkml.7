Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D4FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131A821874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfHHPAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:00:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:31177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfHHPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:00:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="182617457"
Received: from spenceke-mobl1.amr.corp.intel.com (HELO [10.251.157.200]) ([10.251.157.200])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 08:00:40 -0700
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
Date:   Thu, 8 Aug 2019 10:00:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>   
>   	slave->dev.release = sdw_slave_release;
>   	slave->dev.bus = &sdw_bus_type;
> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));

shouldn't this protected by
#if IS_ENABLED(CONFIG_OF) ?

>   	slave->bus = bus;
>   	slave->status = SDW_SLAVE_UNATTACHED;
>   	slave->dev_num = 0;
> @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>   }
>   
>   #endif
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

I am confused here.
If you have two identical devices on the same link, isn't this property 
required and that should be a real error instead of a continue?

> +		}
> +
> +		id.sdw_version = ver - 0xF;

maybe a comment in the code would help to make the encoding 
self-explanatory, as you did in the DT bindings

   Version number '0x10' represents SoundWire 1.0
   Version number '0x11' represents SoundWire 1.1

> +		id.unique_id = unique_id;
> +		id.mfg_id = mfg_id;
> +		id.part_id = part_id;
> +		id.class_id = class_id;
> +		sdw_slave_add(bus, &id, of_fwnode_handle(node));
> +	}
> +	return 0;
> +}
> 
