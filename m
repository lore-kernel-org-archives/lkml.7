Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9751E218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfGZOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:43:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:29269 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGZOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:43:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="369551174"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.35.244])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 07:43:27 -0700
Date:   Fri, 26 Jul 2019 16:43:25 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 21/40] soundwire: export helpers to find
 row and column values
Message-ID: <20190726144325.GH16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:13PM -0500, Pierre-Louis Bossart wrote:
> Add a prefix for common tables and export 2 helpers to set the frame
> shapes based on row/col values.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h    |  7 +++++--
>  drivers/soundwire/stream.c | 14 ++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 06ac4adb0074..c57c9c23f6ca 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -73,8 +73,11 @@ struct sdw_msg {
>  
>  #define SDW_DOUBLE_RATE_FACTOR		2
>  
> -extern int rows[SDW_FRAME_ROWS];
> -extern int cols[SDW_FRAME_COLS];
> +extern int sdw_rows[SDW_FRAME_ROWS];
> +extern int sdw_cols[SDW_FRAME_COLS];

So these arrays actually have to be exported? In the current (5.2) sources they
seem to only be used in stream.c, maybe make them static there?

> +
> +int sdw_find_row_index(int row);
> +int sdw_find_col_index(int col);
>  
>  /**
>   * sdw_port_runtime: Runtime port parameters for Master or Slave
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index a0476755a459..53f5e790fcd7 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -21,37 +21,39 @@
>   * The rows are arranged as per the array index value programmed
>   * in register. The index 15 has dummy value 0 in order to fill hole.
>   */
> -int rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
> +int sdw_rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
>  			96, 100, 120, 128, 150, 160, 250, 0,
>  			192, 200, 240, 256, 72, 144, 90, 180};
>  
> -int cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
> +int sdw_cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
>  
> -static int sdw_find_col_index(int col)
> +int sdw_find_col_index(int col)
>  {
>  	int i;
>  
>  	for (i = 0; i < SDW_FRAME_COLS; i++) {
> -		if (cols[i] == col)
> +		if (sdw_cols[i] == col)
>  			return i;
>  	}
>  
>  	pr_warn("Requested column not found, selecting lowest column no: 2\n");
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_find_col_index);
>  
> -static int sdw_find_row_index(int row)
> +int sdw_find_row_index(int row)
>  {
>  	int i;
>  
>  	for (i = 0; i < SDW_FRAME_ROWS; i++) {
> -		if (rows[i] == row)
> +		if (sdw_rows[i] == row)
>  			return i;
>  	}
>  
>  	pr_warn("Requested row not found, selecting lowest row no: 48\n");
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_find_row_index);
>  
>  static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>  					  struct sdw_slave *slave,
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
