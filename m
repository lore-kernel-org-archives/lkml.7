Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2817C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfHEJiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:38:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:32372 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHEJiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:38:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 02:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="167921292"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga008.jf.intel.com with ESMTP; 05 Aug 2019 02:37:31 -0700
Date:   Mon, 5 Aug 2019 15:09:23 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 21/40] soundwire: export helpers to find row and
 column values
Message-ID: <20190805093923.GC22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> +
> +int sdw_find_row_index(int row);
> +int sdw_find_col_index(int col);

We use index values only in bank switch operations to program registers. Do we
really need to export sdw_find_row_index & sdw_find_col_index?? If i understand
correctly the allocation algorithm only needs to know about cols and rows values
and not index.

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

-- 
