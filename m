Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11358206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pp4/DQgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfDCIqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:46:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37546 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:46:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x338k7m6026120;
        Wed, 3 Apr 2019 03:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554281167;
        bh=6laY2Wi5MjRNNz+r8PMU5WDgU/9suQRacC/iws6+X48=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Pp4/DQgzkq0Ezc+ctgZHO448TATNeCpgLXWawRJY8pahsizAy/yH/6GQxEwHbS030
         8dXRx0bM0bZ0ZQGKyMOMcI/2X7i7ObRpHfMtzSjCktH7nJlm2qiblDNjFM0Xu15TZL
         AQI7yW07vSH6nZKH3rY+PBfRTPtysPiUzkUacxzM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x338k7LT044772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 03:46:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 03:46:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 03:46:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x338k4vx040753;
        Wed, 3 Apr 2019 03:46:05 -0500
Subject: Re: [RFC PATCH 4/4] bus: ti-sysc: Ensure PRU-ICSS doesn't break
 suspend/resume
To:     Tony Lindgren <tony@atomide.com>, <s-anna@ti.com>
CC:     <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-5-rogerq@ti.com> <20190402165723.GM49658@atomide.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <f35d271e-6a5a-918e-7460-1db039064ab7@ti.com>
Date:   Wed, 3 Apr 2019 11:46:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402165723.GM49658@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 19:57, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190402 13:38]:
>> The PRU-ICSS subsystem's SYSCONFIG register is similar to
>> omap4-simple but has 2 special bits STANDBY_INIT and SUB_MWAIT.
>>
>> The STANDBY_INIT bit initiates a Standby sequence (when set) and
>> triggers a MStandby request to the SoC's PRCM module. This same
>> bit is also used to enable the OCP master ports (when cleared).
>>
>> Some PRU applications require the OCP master port access to be
>> enabled thus keeping it out of standby.
> 
> So do we need to configure this depending on the application?

Yes.
> 
>> During sustem suspend/resume we must ensure that the PRUSS is in
>> standby else it will break resume.
>>
>> NOTE:
>> 1. This patch only adds the PM callbacks with code to fix the System
>> Suspend/Resume hang issue on AM33xx/AM437x SoCs, but does not
>> implement the full context save and restore required for the PRUSS
>> drivers to work across system suspend/resume when the power domain
>> is switched off (L4PER domain is switched OFF on AM335x/AM437x
>> during system suspend/resume, so PRUSS modules do lose context).
> 
> I think we already restore the interconnect target module access
> properly on resume. If not we should fix that.
> 
> Saving and restoring the child device state is up to the device
> drivers managing the child device(s), and there's not much ti-sysc.c
> can do about it, right?

Agreed. In that case this handling should be done by pruss.c
and uio_pruss.c in their suspend/resume handlers.

Suman, do you agree?

> 
>> @@ -92,6 +93,7 @@ struct sysc {
>>  	bool enabled;
>>  	bool needs_resume;
>>  	bool child_needs_resume;
>> +	bool in_standby;
>>  	struct delayed_work idle_work;
>>  };
> 
> We should start using bitfields for the bool here, might as well
> already do it now:
> 
> unsigned long in_standby:1;
> 
> See "17) Using bool" in Documentation/process/coding-style.rst.
> 
>> @@ -1023,6 +1025,21 @@ static int __maybe_unused sysc_noirq_suspend(struct device *dev)
>>  	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
>>  		return 0;
>>  
>> +	if (ddata->cap->type == TI_SYSC_PRUSS) {
> 
> Should this test be made more generic based on the mstandby
> bit being configured?

No other module uses this bit. It is specific to PRUSS.
> 
> And can you please make these into separate functions to
> avoid cluttering the suspend and resume functions. Something
> like sysc_handle_mstandby() maybe?
> 
>> +		u32 reg, mask;
>> +		const struct sysc_regbits *regbits = ddata->cap->regbits;
>> +
>> +		mask = BIT(regbits->standby_init_shift);
>> +		reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
>> +		ddata->in_standby = reg & mask;
> 
> Hmm so could we just assume that the device drivers for child device(s)
> configure the MSTANDBY bit? Or do we need to manage it in ti-sysc?
> 

I'm in favor of managing it in the child device driver.
Let's see if Suman has any concerns.

> See for example drivers/usb/musb/omap2430.c omap2430_low_level_init()
> and omap2430_low_level_exit(). That's a separate register though.
> 

--
cheers,
-roger 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
