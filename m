Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281AEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDF32173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564765890;
	bh=QX8zarL9xs/sdJj6CwsMrJvzbNZlO0B+Y3GtFRwGZWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q/METk+bzf56WaULw416fvJ5Lw7LK06uZEhrvqLzW8LTVi/oj782YNanrg4EoPHzT
	 D/j3/FAET/NJNpRQ0gpNmgcfsb0jEUUWpvEbhtO3l7v7bFPTTvEFk7jIVnPjptDtUe
	 +WlPf6SuxwIEnkx8rZzJqeBhMnWZKfmd1ovX7xw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404400AbfHBRL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731936AbfHBRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:11:28 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6530820880;
        Fri,  2 Aug 2019 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564765887;
        bh=QX8zarL9xs/sdJj6CwsMrJvzbNZlO0B+Y3GtFRwGZWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VT+JmgKbJKSnvIX98qfvmzfwNnnvVDBIyqpghg/xYPlHM20pKmU8bCzwI6o2ziHet
         oRFUexQ+r1aXOggFwINFoNlptA94kbem7TtOZb8kiGRkH+V5wLOdhsUnJZ9l+LgIlB
         ZA947UbeHau7rzjIhmygZk4j+cfo1aEV1inEj7T0=
Date:   Fri, 2 Aug 2019 22:40:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 24/40] soundwire: cadence_master: use BIOS defaults
 for frame shape
Message-ID: <20190802171014.GZ12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Remove hard-coding and use BIOS values. If they are wrong use default

BIOS :) this is cadence, am sure this can be used outside BIOS :D

It would be better to say firmware (ACPI/DT)

> 48x2 frame shape.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 442f78c00f09..d84344e29f71 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -175,7 +175,6 @@
>  /* Driver defaults */
>  
>  #define CDNS_DEFAULT_CLK_DIVIDER		0
> -#define CDNS_DEFAULT_FRAME_SHAPE		0x30
>  #define CDNS_DEFAULT_SSP_INTERVAL		0x18
>  #define CDNS_TX_TIMEOUT				2000
>  
> @@ -954,6 +953,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  }
>  EXPORT_SYMBOL(sdw_cdns_pdi_init);
>  
> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
> +{
> +	u32 val;
> +	int c;
> +	int r;

This can be in single line!

> +
> +	r = sdw_find_row_index(n_rows);
> +	c = sdw_find_col_index(n_cols);
> +
> +	val = (r << 3) | c;

Magic 3?

-- 
~Vinod
