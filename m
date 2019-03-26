Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B41C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545952087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bIsS8exU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbfCZXXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:23:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732730AbfCZXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:23:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2QNMdF5129861;
        Tue, 26 Mar 2019 18:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553642559;
        bh=yu3slguIosKlC29O8XWYwfhTPBA9ZJf5E1cBmdyzzYM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bIsS8exUq44k5nkEiOod7o7gtH5KMoh+D56CjSirstjIuu9nHfALtvrFTAke/JkX9
         BYsJWzpdgcD7qMEoTrtxOiH4KG30h6yJrFz1vgZVYpkKLKBHbPHnE6hMSBlgafSrU1
         8py7ag8ArCm0u8RVKs1zUYwx9122Cb8R1JImSMjI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2QNMdPr114305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 18:22:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 18:22:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 18:22:38 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2QNMcFI064944;
        Tue, 26 Mar 2019 18:22:38 -0500
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
To:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
 <20190326231306.GC49658@atomide.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
Date:   Tue, 26 Mar 2019 18:22:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326231306.GC49658@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 3/26/19 6:13 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [190325 22:00]:
>> We should not do the reset until the clocks are enabled. Let's only init
>> restctrl in sysc_init_resets() and do the reset later on in sysc_reset().
> ...
> 
>>  static int sysc_reset(struct sysc *ddata)
>>  {
>>  	int offset = ddata->offsets[SYSC_SYSCONFIG];
>> -	int val;
>> +	int error, val;
>>  
>>  	if (ddata->legacy_mode || offset < 0 ||
>>  	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
>> -		return 0;
>> +		return sysc_rstctrl_reset_deassert(ddata, false);
>> +
>> +	error = sysc_rstctrl_reset_deassert(ddata, true);
>> +	if (error)
>> +		return error;
> 
> This change is wrong, we need to deassert rstctrl reset before
> we enable clocks, not after. Updated version below.

Hmm, are you envisioning the SYSC reset (OCP SoftReset) here or the PRCM
RSTCTRL hardresets here? The latter in general requires the clocks to be
running first (module won't be in ready status until you deassert the
hardresets with clocks running). You can look up the Warm-reset or
Cold-reset sequences in the TRMs for any of the processors.

I am working on preparing the next version of PRUSS patches with ti-sysc
on AM33xx/AM437x/AM57xx platforms, so will pick up these patches for my
testing.

regards
Suman

> 
> Regards,
> 
> Tony
> 
> 8< --------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 21 Mar 2019 11:00:21 -0700
> Subject: [PATCH] bus: ti-sysc: Move rstctrl reset to happen later
> 
> We can do the rsstctrl a bit later, but need to deassert rstctrl reset
> before the clocks are enabled if asserted. Let's only init restctrl
> in sysc_init_resets() and do the reset later on just before we enable
> the device clocks.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 61 +++++++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -339,38 +339,18 @@ static void sysc_disable_opt_clocks(struct sysc *ddata)
>  }
>  
>  /**
> - * sysc_init_resets - reset module on init
> + * sysc_init_resets - init rstctrl reset line if configured
>   * @ddata: device driver data
>   *
> - * A module can have both OCP softreset control and external rstctrl.
> - * If more complicated rstctrl resets are needed, please handle these
> - * directly from the child device driver and map only the module reset
> - * for the parent interconnect target module device.
> - *
> - * Automatic reset of the module on init can be skipped with the
> - * "ti,no-reset-on-init" device tree property.
> + * See sysc_rstctrl_reset_deassert().
>   */
>  static int sysc_init_resets(struct sysc *ddata)
>  {
> -	int error;
> -
>  	ddata->rsts =
>  		devm_reset_control_array_get_optional_exclusive(ddata->dev);
>  	if (IS_ERR(ddata->rsts))
>  		return PTR_ERR(ddata->rsts);
>  
> -	if (ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
> -		goto deassert;
> -
> -	error = reset_control_assert(ddata->rsts);
> -	if (error)
> -		return error;
> -
> -deassert:
> -	error = reset_control_deassert(ddata->rsts);
> -	if (error)
> -		return error;
> -
>  	return 0;
>  }
>  
> @@ -1031,6 +1011,35 @@ static int sysc_legacy_init(struct sysc *ddata)
>  	return error;
>  }
>  
> +/**
> + * sysc_rstctrl_reset_deassert - deassert rstctrl reset
> + * @ddata: device driver data
> + * @reset: reset before deassert
> + *
> + * A module can have both OCP softreset control and external rstctrl.
> + * If more complicated rstctrl resets are needed, please handle these
> + * directly from the child device driver and map only the module reset
> + * for the parent interconnect target module device.
> + *
> + * Automatic reset of the module on init can be skipped with the
> + * "ti,no-reset-on-init" device tree property.
> + */
> +static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
> +{
> +	int error;
> +
> +	if (!ddata->rsts)
> +		return 0;
> +
> +	if (reset) {
> +		error = reset_control_assert(ddata->rsts);
> +		if (error)
> +			return error;
> +	}
> +
> +	return reset_control_deassert(ddata->rsts);
> +}
> +
>  static int sysc_reset(struct sysc *ddata)
>  {
>  	int offset = ddata->offsets[SYSC_SYSCONFIG];
> @@ -1071,6 +1080,14 @@ static int sysc_init_module(struct sysc *ddata)
>  {
>  	int error = 0;
>  	bool manage_clocks = true;
> +	bool reset = true;
> +
> +	if (ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
> +		reset = false;
> +
> +	error = sysc_rstctrl_reset_deassert(ddata, reset);
> +	if (error)
> +		return error;
>  
>  	if (ddata->cfg.quirks &
>  	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT))
> 

