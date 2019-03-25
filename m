Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6895C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RKe2l4BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfCYIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:33:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCYIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:33:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id o1so8967184wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=UQc7JVoMwQeYDpqym1Nx/ay+lb26qPg/1ZxgbgrSL3E=;
        b=RKe2l4BIlrKdaa2balbCoScwbIjvEWTWpJYjPYxbr1buCJMMv58D3FVO3lE1fhcLGO
         8dYUFMRuRju3Jhyk6jbtV1hYcNoms3NqhN5dv2x2H3paZHjXMzekA2nikBAHj3o+FxS5
         PVDkZMZhCYmweaVPKZSiex1M/DlynQhv3R0So6hAD0FM/fYLgajoM0Htfz1oJqV3syvH
         H0IVaTjb7wtvu0/lRZ4n20l9uoJpUlmXwiWVj5dHMBMEQWSPagI6RfI+UyEcY9dbO068
         YZAyy0L4VvPdVr41m/SRwcVSvUVb77/b4mhoIx87MddH8upO7k+if9lAaL0/nKgVDwA+
         5lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=UQc7JVoMwQeYDpqym1Nx/ay+lb26qPg/1ZxgbgrSL3E=;
        b=UbHrmwYj41R5jPEclP6bp+5DEwBT8hr5fFLxPTppufpEIZQMnH4kekz+haHIBiX06/
         EUzflfreJLJbpqLeFLciwMw71iy88oFj4RpULfCENmJ5XiO6K+t6wPDRFUUfdGNcRZTC
         Xhl0uRqnOLpVPQqEq4A1Sjce3ZP1fkxlKsL9tYf5kUU6EldNOOoO6CDmrJRIrqNrNvjF
         YFnYiXkOZz1bB5rP6Gh1Ugl7BMHeJH5jhf10E8Hjvj35DnTFdvOkZZ+ga2VdAnihH2BD
         wRMnLw7mfvYwKxWTpUSrqi6V1XzZ29genPvITdKkCHwCBhoAPIylpP3T2AWKg5f66CMH
         PU6A==
X-Gm-Message-State: APjAAAWmxASlb3OnFJhxcret4nJBLnNT9KLNWj+PP5S9mpTfE59VIoCh
        v2BGbv4z48LijOFDhVQu2TL3aX9qX5Q=
X-Google-Smtp-Source: APXvYqxiAC60ROGSm1laEnaWGAVAU13ukQUga13Zzk+G1R6J3htYI0hs9ldzFjYI3RzIy+1Rn/AE/A==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr15539574wru.164.1553502796751;
        Mon, 25 Mar 2019 01:33:16 -0700 (PDT)
Received: from [192.168.1.102] ([80.214.154.164])
        by smtp.gmail.com with ESMTPSA id k14sm12807031wmj.26.2019.03.25.01.33.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 01:33:16 -0700 (PDT)
Message-ID: <5C989247.6090709@baylibre.com>
Date:   Mon, 25 Mar 2019 09:33:11 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     maxime.ripard@bootlin.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wens@csie.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to suppress
 loading CEC driver
References: <20190324212144.3652-1-jernej.skrabec@siol.net> <20190324212144.3652-2-jernej.skrabec@siol.net> <20190325013531.GB4540@pendragon.ideasonboard.com>
In-Reply-To: <20190325013531.GB4540@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/03/2019 02:35, Laurent Pinchart a écrit :
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Sun, Mar 24, 2019 at 10:21:42PM +0100, Jernej Skrabec wrote:
>> DW HDMI controller on some Allwinner SoCs has support for CEC, but due
>> to additional logic put between CEC controller and pins, it doesn't work
>> correctly, at least not with a lot of instrusive changes. Fortunately,
>> it's still possible to bitbang protocol.
>>
>> For such cases, add a platform option to suppress loading CEC driver. If
>> DW HDMI CEC driver would be loaded, it wouldn't work anyway and only
>> cause a confusion with multiple /dev entries.
>>
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>>  include/drm/bridge/dw_hdmi.h              | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index a63e5f0dae56..fdda26f8b056 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2634,7 +2634,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  		hdmi->audio = platform_device_register_full(&pdevinfo);
>>  	}
>>  
>> -	if (config0 & HDMI_CONFIG0_CEC) {
>> +	if (!plat_data->is_cec_unusable && (config0 & HDMI_CONFIG0_CEC)) {
>>  		cec.hdmi = hdmi;
>>  		cec.ops = &dw_hdmi_cec_ops;
>>  		cec.irq = irq;
>> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
>> index 66e70770cce5..764b8bcfa62c 100644
>> --- a/include/drm/bridge/dw_hdmi.h
>> +++ b/include/drm/bridge/dw_hdmi.h
>> @@ -144,6 +144,8 @@ struct dw_hdmi_plat_data {
>>  	int (*configure_phy)(struct dw_hdmi *hdmi,
>>  			     const struct dw_hdmi_plat_data *pdata,
>>  			     unsigned long mpixelclock);
>> +
>> +	unsigned int is_cec_unusable : 1;
> 
> Strictly speaking your CEC controller isn't unusable, it's just a bit
> difficult to use it according to your commit message. Would disable_cec
> be a more appropriate field name ? 

Actually, it would be useful to have in for Amlogic SoCs also, the dw-hdmi
is configured with the CEC engine, but isn't connected to an external I/O.
And we have easy way to disable it unless disabling the DW-HDMI CEC driver...
With a more appropriate name,
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

> And how difficult would it be to
> support the hardware CEC controller, would that result in changes that
> could be useful to other vendors too ?
> 
>>  };
>>  
>>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
> 
