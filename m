Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933B821873
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 03:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1rWmquY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCXDho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 23:37:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45811 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXDho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 23:37:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so3215501pfi.12;
        Sat, 23 Mar 2019 20:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZdnWU8H1n2w3qlfjTQNLhGu3vhvAcS3owxVA/UeG0w=;
        b=K1rWmquYoIgE7cS6A4dxyE1I68p2TVMBOEeK0SY3ws5oo9juhJyujhrFJe0/LR9Cp/
         vE7Vt5cOb7QUdoQkrX+XH9I99DsNNx8ZiNT6lgS+6B52lDx1eGOpBnaRl3SFyyzGsuLU
         EfCENTtIbJcHOmaQ+i0MXznQkJfTDkhlfeW5fM5xF/lUcdUUDRwVdgv8z19oSfoat68G
         tyi7H8p6pclfTAJGAZvuGa3fXW+Ht41YOeI1guYNVFCqsaW0yKHPRSXezzCrijMQZGZO
         8/rqg1r/rhRJHF8DopTqJBKmzy0FPyIGEho3vLqRise+kPdQMIPrkw3OdrkbjwiIAez9
         I5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZdnWU8H1n2w3qlfjTQNLhGu3vhvAcS3owxVA/UeG0w=;
        b=dO22+6+oU7kpDpc1siOp4bZDtpOK2J1X34Fx4Z6VsnT7YQP3pFRaJtVhmggN3Ak0Wj
         BEzd04leC6bNEKLheNgttoOV29QBuGw/0rMpRk9fM1u07uEZhiymW6gpJ8epgbldCKI4
         cmp83CitpOndKsp2vHVWD9A4lXqY8YL03JSejy7vh2OU4yLZW/S3Nzy3gWXi6tLpstEz
         25L50m4lMTlxaNHdhWD/sCcbSjlUsomjvFGPFn0dclyzmeRCNxOziQ3X69ra5SMEq8wf
         1aFv1jkhjUHbMsspV2b7lJVK+XTsA7xhZ7eg6Mv1NlCfN72lDoIYTQk5uBsUr2kKVTce
         0vqQ==
X-Gm-Message-State: APjAAAXNImaF2H9WHUAg7G+PNz9BozWJ0e4CeXYLIQlpZPh+M7cRwAps
        qR44oWgtJCMxxU3MYUXjta8=
X-Google-Smtp-Source: APXvYqwosod2n0oiTyFxUlLhX8i3d1o9NhNcrAgvwyfQhGLpt0UjmX2pcnK1IpxGTs0h2B/08CY34Q==
X-Received: by 2002:a17:902:2983:: with SMTP id h3mr18521320plb.332.1553398662944;
        Sat, 23 Mar 2019 20:37:42 -0700 (PDT)
Received: from icarus ([2001:268:c0a4:5125:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id i21sm15101081pfa.14.2019.03.23.20.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 20:37:42 -0700 (PDT)
Date:   Sun, 24 Mar 2019 12:38:29 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        yamada.masahiro@socionext.com, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 10/10] thermal: intel: intel_soc_dts_iosf: Utilize
 for_each_set_clump8 macro
Message-ID: <20190324033747.GA7697@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <a240216a143782e3cfecf6f963578067b68b6007.1552566114.git.vilhelm.gray@gmail.com>
 <20190322190243.GA9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322190243.GA9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 09:02:43PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 14, 2019 at 09:32:57PM +0900, William Breathitt Gray wrote:
> > Utilize for_each_set_clump8 macro, and the bitmap_set_value8 and
> > bitmap_get_value8 functions, where appropriate. In addition, remove the
> > now unnecessary temp_mask and temp_shift members of the
> > intel_soc_dts_sensor_entry structure.
> 
> One comment below, otherwise
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Thanks!

Thank you for testing out the patch. I'll fix the bug your pointed out
and add the Tested-by line.

I have a couple minor comments below.

> 
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/thermal/intel/intel_soc_dts_iosf.c | 29 +++++++++++++---------
> >  drivers/thermal/intel/intel_soc_dts_iosf.h |  2 --
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > index e0813dfaa278..b66f554670f7 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > @@ -15,6 +15,7 @@
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/interrupt.h>
> > @@ -111,6 +112,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
> >  {
> >  	int status;
> >  	u32 temp_out;
> > +	unsigned long update_ptps;
> >  	u32 out;
> >  	u32 store_ptps;
> >  	u32 store_ptmc;
> > @@ -129,8 +131,9 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
> >  	if (status)
> >  		return status;
> >  
> > -	out = (store_ptps & ~(0xFF << (thres_index * 8)));
> > -	out |= (temp_out & 0xFF) << (thres_index * 8);
> > +	update_ptps = store_ptps;
> > +	bitmap_set_value8(&update_ptps, 32, temp_out & 0xFF, thres_index * 8);

I chose to hardcode a bitmap width of 32 here because that is the width
of the store_ptps variables, but I don't think we necessarily use all 32
bits here. Would the actual width of store_ptps be the number of
writable trip count bits (writable_trip_count * 8)?

> > +	out = update_ptps;
> >  	status = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> >  				SOC_DTS_OFFSET_PTPS, out);
> >  	if (status)
> > @@ -232,6 +235,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> >  	u32 out;
> >  	struct intel_soc_dts_sensor_entry *dts;
> >  	struct intel_soc_dts_sensors *sensors;
> > +	unsigned long temp_raw;
> >  
> >  	dts = tzd->devdata;
> >  	sensors = dts->sensors;
> > @@ -240,7 +244,8 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> >  	if (status)
> >  		return status;
> >  
> > -	out = (out & dts->temp_mask) >> dts->temp_shift;
> > +	temp_raw = out;
> > +	out = bitmap_get_value8(&temp_raw, 32, dts->id * 8);

Same question as above: what is the maximum bitmap width here if not 32?

William Breathitt Gray

> >  	out -= SOC_DTS_TJMAX_ENCODING;
> >  	*temp = sensors->tj_max - out * 1000;
> >  
> > @@ -290,10 +295,13 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  {
> >  	char name[10];
> >  	int trip_count = 0;
> > +	int writable_trip_count = 0;
> >  	int trip_mask = 0;
> >  	u32 store_ptps;
> >  	int ret;
> > -	int i;
> > +	unsigned int i;
> > +	unsigned long trip;
> > +	unsigned long ptps;
> >  
> >  	/* Store status to restor on exit */
> >  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> > @@ -302,11 +310,10 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  		goto err_ret;
> >  
> >  	dts->id = id;
> > -	dts->temp_mask = 0x00FF << (id * 8);
> > -	dts->temp_shift = id * 8;
> >  	if (notification_support) {
> >  		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
> > -		trip_mask = BIT(trip_count - read_only_trip_cnt) - 1;
> > +		writable_trip_count = trip_count - read_only_trip_cnt;
> > +		trip_mask = GENMASK(writable_trip_count - 1, 0);
> >  	}
> >  
> >  	/* Check if the writable trip we provide is not used by BIOS */
> > @@ -315,11 +322,9 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> >  	if (ret)
> >  		trip_mask = 0;
> >  	else {
> > -		for (i = 0; i < trip_count; ++i) {
> > -			if (trip_mask & BIT(i))
> > -				if (store_ptps & (0xff << (i * 8)))
> > -					trip_mask &= ~BIT(i);
> > -		}
> > +		ptps = store_ptps;
> > +		for_each_set_clump8(i, trip, ptps, writable_trip_count * 8)
> 
> It seems you didn't notice gcc warnings, the ptps should be pointer, i.e. &ptps.
> After changing here manually seems working.
> 
> > +			trip_mask &= ~BIT(i / 8);
> >  	}
> >  	dts->trip_mask = trip_mask;
> >  	dts->trip_count = trip_count;
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
> > index 625e37bf93dc..d0362d7acdef 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.h
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
> > @@ -33,8 +33,6 @@ struct intel_soc_dts_sensors;
> >  
> >  struct intel_soc_dts_sensor_entry {
> >  	int id;
> > -	u32 temp_mask;
> > -	u32 temp_shift;
> >  	u32 store_status;
> >  	u32 trip_mask;
> >  	u32 trip_count;
> > -- 
> > 2.21.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
