Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A7C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A519223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfGWGqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:46:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41512 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388127AbfGWGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:45:58 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hpoYe-0006o3-Av
        for linux-kernel@vger.kernel.org; Tue, 23 Jul 2019 06:45:56 +0000
Received: by mail-pg1-f199.google.com with SMTP id m17so16405995pgh.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NTVFB8vKi+UKrd0lcmO2aFDnhZ2NRKgCuTiopH4B1xw=;
        b=TFI1TqUFjZLR9g2ORx3+vD5TawcSsLEbRN+wZ8e4WMdE6pknECyybqaL0sGL252+6g
         2WwJBMPzsVpdMfVIgfwa7auZuRLELULN+CGVlcytLqo+ln3MECiMnz2Ddxiuyjy+fzFJ
         d7siEA2edFvvPB74Ic9p9y1kdiPYhtjcD63AReU3FAMvRFgYgZBNP8rIuO5sf8gVf1Cq
         BEF7Vf9J7iWhefyudTTNx05EA/t5n7jfKxLoNek4ulWxR8/Z/WYWx+Rz7mEKl/eToHcv
         /LFsg4WSuaMSzH3Fj9CkhWd0Rawm5ol0aU3o48kJLKtyPi8uWX6w1ojF9TELqYBw+Oz0
         d6bA==
X-Gm-Message-State: APjAAAVr4cPZkOwE9iKzMnu/Mrn/gGJaBCMATfiijsZehFBVE3T7ux4J
        1G3P/rve8ct/S/7uxtvg6YtuDZumK6JC4N1uG3pzYQ6VVWPINQLZcXi5FZ2j3EOMM6O9EaZ5SCF
        pRlhUIftU30yGXnZI05RttZoauNaUX2xjzzulIP7zPQ==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr21729818plp.126.1563864354964;
        Mon, 22 Jul 2019 23:45:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxs9iIioNzu7vz8WW8REtE5WIODnwsxOgsmsl0xWVpe1VPwnU+RlbSnteraTcUgMOU1VRp0bA==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr21729795plp.126.1563864354561;
        Mon, 22 Jul 2019 23:45:54 -0700 (PDT)
Received: from 2001-b011-380f-3c20-e8e0-1150-3bec-1563.dynamic-ip6.hinet.net (2001-b011-380f-3c20-e8e0-1150-3bec-1563.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:e8e0:1150:3bec:1563])
        by smtp.gmail.com with ESMTPSA id s43sm50209730pjb.10.2019.07.22.23.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:45:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] Input: elantech: Enable SMBus on new (2018+) systems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190722081739.GA804@penguin>
Date:   Tue, 23 Jul 2019 14:45:51 +0800
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Your Name <you@example.com>
Content-Transfer-Encoding: 8bit
Message-Id: <9AFB67C8-12BE-4794-BA82-BF7D1AED22E8@canonical.com>
References: <20190121070258.1844-1-kai.heng.feng@canonical.com>
 <20190722074055.22427-1-kai.heng.feng@canonical.com>
 <20190722081739.GA804@penguin>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

at 16:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Kai-Heng,
>
> On Mon, Jul 22, 2019 at 03:40:55PM +0800, Kai-Heng Feng wrote:
>> There are some new HP laptops with Elantech touchpad don't support
>> multitouch.
>>
>> Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
>> supported, but in addition to firmware version, the bus type also
>> informs us if the IC can support SMBus, so also check that.
>>
>> In case of breaking old ICs, only enables SMBus on systems manufactured
>> after 2018, alongsides aforementioned checks.
>>
>> Lastly, consolidats all check into elantech_use_host_notify() and use it
>> to determine whether to use PS/2 or SMBus.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Your Name <you@example.com>
>
> I do not think "Your Name" should be signing DCO here :)

Yes I don’t know how I messed that up...

>
>> +static bool elantech_use_host_notify(struct psmouse *psmouse,
>> +				     struct elantech_device_info *info)
>> +{
>> +	bool host_notify = false;
>> +
>> +	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> +		host_notify = true;
>> +	else {
>> +		switch (info->bus) {
>> +		case ETP_BUS_PS2_ONLY:
>> +			/* expected case */
>> +			break;
>> +		case ETP_BUS_SMB_ALERT_ONLY:
>> +			/* fall-through  */
>> +		case ETP_BUS_PS2_SMB_ALERT:
>> +			psmouse_dbg(psmouse, "Ignoring SMBus provider  
>> through alert protocol.\n");
>> +			break;
>> +		case ETP_BUS_SMB_HST_NTFY_ONLY:
>> +			/* fall-through  */
>> +		case ETP_BUS_PS2_SMB_HST_NTFY:
>> +			/* SMbus implementation is stable since 2018 */
>> +			if (dmi_get_bios_year() >= 2018)
>> +				host_notify = true;
>> +			break;
>> +		default:
>> +			psmouse_dbg(psmouse,
>> +				    "Ignoring SMBus bus provider %d.\n",
>> +				    info->bus);
>> +		}
>> +	}
>
> I think this is way too verbose. How about a bit more condensed form:

The one revised by you is more succinct. Please use yours instead :)

Thanks!

Kai-Heng

>
>
> Input: elantech - enable SMBus on new (2018+) systems
>
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> There are some new HP laptops with Elantech touchpad that don't support
> multitouch.
>
> Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is  
> supported,
> but in addition to firmware version, the bus type also informs us whether  
> the IC
> can support SMBus. To avoid breaking old ICs, we will only enable SMbus  
> support
> based the bus type on systems manufactured after 2018.
>
> Lastly, let's consolidate all checks into elantech_use_host_notify() and  
> use it
> to determine whether to use PS/2 or SMBus.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/elantech.c |   54 +++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c  
> b/drivers/input/mouse/elantech.c
> index 2d8434b7b623..73544776a9ed 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1827,6 +1827,30 @@ static int elantech_create_smbus(struct psmouse  
> *psmouse,
>  				  leave_breadcrumbs);
>  }
>
> +static bool elantech_use_host_notify(struct psmouse *psmouse,
> +				     struct elantech_device_info *info)
> +{
> +	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> +		return true;
> +
> +	switch (info->bus) {
> +	case ETP_BUS_PS2_ONLY:
> +		/* expected case */
> +		break;
> +	case ETP_BUS_SMB_HST_NTFY_ONLY:
> +	case ETP_BUS_PS2_SMB_HST_NTFY:
> +		/* SMbus implementation is stable since 2018 */
> +		if (dmi_get_bios_year() >= 2018)
> +			return true;
> +	default:
> +		psmouse_dbg(psmouse,
> +			    "Ignoring SMBus bus provider %d\n", info->bus);
> +		break;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * elantech_setup_smbus - called once the PS/2 devices are enumerated
>   * and decides to instantiate a SMBus InterTouch device.
> @@ -1846,7 +1870,7 @@ static int elantech_setup_smbus(struct psmouse  
> *psmouse,
>  		 * i2c_blacklist_pnp_ids.
>  		 * Old ICs are up to the user to decide.
>  		 */
> -		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
> +		if (!elantech_use_host_notify(psmouse, info) ||
>  		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
>  			return -ENXIO;
>  	}
> @@ -1866,34 +1890,6 @@ static int elantech_setup_smbus(struct psmouse  
> *psmouse,
>  	return 0;
>  }
>
> -static bool elantech_use_host_notify(struct psmouse *psmouse,
> -				     struct elantech_device_info *info)
> -{
> -	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
> -		return true;
> -
> -	switch (info->bus) {
> -	case ETP_BUS_PS2_ONLY:
> -		/* expected case */
> -		break;
> -	case ETP_BUS_SMB_ALERT_ONLY:
> -		/* fall-through  */
> -	case ETP_BUS_PS2_SMB_ALERT:
> -		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert  
> protocol.\n");
> -		break;
> -	case ETP_BUS_SMB_HST_NTFY_ONLY:
> -		/* fall-through  */
> -	case ETP_BUS_PS2_SMB_HST_NTFY:
> -		return true;
> -	default:
> -		psmouse_dbg(psmouse,
> -			    "Ignoring SMBus bus provider %d.\n",
> -			    info->bus);
> -	}
> -
> -	return false;
> -}
> -
>  int elantech_init_smbus(struct psmouse *psmouse)
>  {
>  	struct elantech_device_info info;
>
> Thanks.
>
> -- 
> Dmitry


