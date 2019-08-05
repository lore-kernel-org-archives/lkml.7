Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A94C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FB2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfHERBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:01:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:51650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbfHERBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:01:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 09:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="257772967"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga001.jf.intel.com with ESMTP; 05 Aug 2019 09:52:29 -0700
Date:   Mon, 5 Aug 2019 22:24:22 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 27/40] soundwire: Add Intel resource management
 algorithm
Message-ID: <20190805165422.GB24889@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:19PM -0500, Pierre-Louis Bossart wrote:
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> This implementation is optimal for Intel platforms. Developers can
> also implement their own .compute_params() callback for specific
> resource management algorithm.
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.
> 
> FIXME: remove checkpatch report
> WARNING: Reusing the krealloc arg is almost always a bug
> +			group->rates = krealloc(group->rates,
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/Makefile                  |   2 +-
>  drivers/soundwire/algo_dynamic_allocation.c | 403 ++++++++++++++++++++
>  drivers/soundwire/bus.c                     |   3 +
>  drivers/soundwire/bus.h                     |  46 ++-
>  drivers/soundwire/stream.c                  |  20 +
>  include/linux/soundwire/sdw.h               |   5 +
>  6 files changed, 476 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/soundwire/algo_dynamic_allocation.c
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 88990cac48a7..f59a9d4a28fd 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -5,7 +5,7 @@
>  
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o \
> -			debugfs.o
> +			debugfs.o algo_dynamic_allocation.o
>  
>  obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>  
> diff --git a/drivers/soundwire/algo_dynamic_allocation.c b/drivers/soundwire/algo_dynamic_allocation.c
> new file mode 100644
> index 000000000000..89edb39162b8
> --- /dev/null
> +++ b/drivers/soundwire/algo_dynamic_allocation.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2015-18 Intel Corporation.
> +
> +/*
> + * Bandwidth management algorithm based on 2^n gears
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +#include <linux/soundwire/sdw.h>
> +#include "bus.h"
> +
> +#define SDW_STRM_RATE_GROUPING		1
> +
> +struct sdw_group_params {
> +	unsigned int rate;
> +	int full_bw;
> +	int payload_bw;
> +	int hwidth;
> +};
> +
> +struct sdw_group {
> +	unsigned int count;
> +	unsigned int max_size;
> +	unsigned int *rates;
> +};
> +
> +struct sdw_transport_data {
> +	int hstart;
> +	int hstop;
> +	int block_offset;
> +	int sub_block_offset;
> +};
> +
> +
> +/**
> + * sdw_compute_port_params: Compute transport and port parameters
> + *
> + * @bus: SDW Bus instance
> + */
> +static int sdw_compute_port_params(struct sdw_bus *bus)
> +{
> +	struct sdw_group_params *params = NULL;
> +	struct sdw_group group;
> +	int ret;
> +
> +	ret = sdw_get_group_count(bus, &group);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (group.count == 0)
> +		goto out;
> +
> +	params = kcalloc(group.count, sizeof(*params), GFP_KERNEL);
> +	if (!params) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Compute transport parameters for grouped streams */
> +	ret = sdw_compute_group_params(bus, params,
> +				       &group.rates[0], group.count);
> +	if (ret < 0)
> +		goto out;
> +
> +	_sdw_compute_port_params(bus, params, group.count);
> +
> +out:
> +	kfree(params);
> +	kfree(group.rates);
> +
> +	return ret;
> +}
> +
> +static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
> +{
> +	struct sdw_master_prop *prop = &bus->prop;
> +	int frame_int, frame_freq;
> +	int r, c;
> +
> +	for (c = 0; c < SDW_FRAME_COLS; c++) {
> +		for (r = 0; r < SDW_FRAME_ROWS; r++) {
> +			if (sdw_rows[r] != prop->default_row ||
> +			    sdw_cols[c] != prop->default_col)
> +				continue;

Are we only supporting default rows and cols?

> +
> +			frame_int = sdw_rows[r] * sdw_cols[c];
> +			frame_freq = clk_freq / frame_int;
> +
> +			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
> +			    bus->params.bandwidth)
> +				continue;
> +
> +			bus->params.row = sdw_rows[r];
> +			bus->params.col = sdw_cols[c];
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> -- 
> 2.20.1
> 

-- 
