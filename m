Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A48C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3621019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCNO0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:26:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:54148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfCNO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:26:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 07:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="307200592"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2019 07:26:41 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h4RJg-0005ge-3U; Thu, 14 Mar 2019 16:26:40 +0200
Date:   Thu, 14 Mar 2019 16:26:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 10/10] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Message-ID: <20190314142640.GZ9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 09:32:57PM +0900, William Breathitt Gray wrote:
> Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> bitmap_get_value8 functions, where appropriate. In addition, remove the
> now unnecessary temp_mask and temp_shift members of the
> intel_soc_dts_sensor_entry structure.

I think you need to Cc thermal maintainers.

I will test this next week.
Thanks!

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Suggested-by?

> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/thermal/intel/intel_soc_dts_iosf.c | 29 +++++++++++++---------
>  drivers/thermal/intel/intel_soc_dts_iosf.h |  2 --
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> index e0813dfaa278..b66f554670f7 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -15,6 +15,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> @@ -111,6 +112,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
>  {
>  	int status;
>  	u32 temp_out;
> +	unsigned long update_ptps;
>  	u32 out;
>  	u32 store_ptps;
>  	u32 store_ptmc;
> @@ -129,8 +131,9 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
>  	if (status)
>  		return status;
>  
> -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> -	out |= (temp_out & 0xFF) << (thres_index * 8);
> +	update_ptps = store_ptps;
> +	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);
> +	out = update_ptps;
>  	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
>  				SOC_DTS_OFFSET_PTPS, out);
>  	if (status)
> @@ -232,6 +235,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
>  	u32 out;
>  	struct intel_soc_dts_sensor_entry *dts;
>  	struct intel_soc_dts_sensors *sensors;
> +	unsigned long temp_raw;
>  
>  	dts = tzd->devdata;
>  	sensors = dts->sensors;
> @@ -240,7 +244,8 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
>  	if (status)
>  		return status;
>  
> -	out = (out & dts->temp_mask) >> dts->temp_shift;
> +	temp_raw = out;
> +	out = bitmap_get_value8(&temp_raw, 32, dts->id * 8);
>  	out -= SOC_DTS_TJMAX_ENCODING;
>  	*temp = sensors->tj_max - out * 1000;
>  
> @@ -290,10 +295,13 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>  {
>  	char name[10];
>  	int trip_count = 0;
> +	int writable_trip_count = 0;
>  	int trip_mask = 0;
>  	u32 store_ptps;
>  	int ret;
> -	int i;
> +	unsigned int i;
> +	unsigned long trip;
> +	unsigned long ptps;
>  
>  	/* Store status to restor on exit */
>  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> @@ -302,11 +310,10 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>  		goto err_ret;
>  
>  	dts->id = id;
> -	dts->temp_mask = 0x00FF << (id * 8);
> -	dts->temp_shift = id * 8;
>  	if (notification_support) {
>  		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
> -		trip_mask = BIT(trip_count - read_only_trip_cnt) - 1;
> +		writable_trip_count = trip_count - read_only_trip_cnt;
> +		trip_mask = GENMASK(writable_trip_count - 1, 0);
>  	}
>  
>  	/* Check if the writable trip we provide is not used by BIOS */
> @@ -315,11 +322,9 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>  	if (ret)
>  		trip_mask = 0;
>  	else {
> -		for (i = 0; i < trip_count; ++i) {
> -			if (trip_mask & BIT(i))
> -				if (store_ptps & (0xff << (i * 8)))
> -					trip_mask &= ~BIT(i);
> -		}
> +		ptps = store_ptps;
> +		for_each_set_clump8(i, trip, ptps, writable_trip_count * 8)
> +			trip_mask &= ~BIT(i / 8);
>  	}
>  	dts->trip_mask = trip_mask;
>  	dts->trip_count = trip_count;
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
> index 625e37bf93dc..d0362d7acdef 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.h
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
> @@ -33,8 +33,6 @@ struct intel_soc_dts_sensors;
>  
>  struct intel_soc_dts_sensor_entry {
>  	int id;
> -	u32 temp_mask;
> -	u32 temp_shift;
>  	u32 store_status;
>  	u32 trip_mask;
>  	u32 trip_count;
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


