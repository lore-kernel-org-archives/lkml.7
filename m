Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE3206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5BjUOZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLBKeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:34:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34386 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfLBKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:34:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id f4so5547924wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mJKajnqhtQ4VFh36m+UlyF2xEEUhH3v2ORgay45sbSA=;
        b=x5BjUOZhdFg4RDmgImDZXRwNVl4P4SSu7T+Bm2IUeYoTtGneyEkFfatl8waIvczgdo
         2RzioLi2De7ExBSouFPlvaeAhd1oBeiHid2yJiArQXQIxKzq9IxDdO7x3eAFpK1ayInt
         QcarC0MHurT6CCuY3ShBDdo3f44QnvQLCpJjmD1O0dcpc9aENIRp+N2hwxJyKSdDkEdm
         EjJLebsg672C6b2VcfNOE7c8ibDoIXXNn7xnP8u0Jgj9wV3syeuD+8XupVcxpy7MiLVz
         5xNm4gaMTpuyXNgPy1mGzADszjpoRds+4X8w6LuUmubh2x1zl87pbWx6c0Ld1nlK33GG
         KApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mJKajnqhtQ4VFh36m+UlyF2xEEUhH3v2ORgay45sbSA=;
        b=BUUh20s2AJTc7Aj8oqsBdVZSwM46Pat4V2wmOzP5sFv3jevE5NMpdNpoMXDn8iR/em
         y+DaZsmAkviudUQaKdcCX9FWKKf0/xdlQnCXKmQH7cznFuyz8HURhcrBM8YK2rIvPIrG
         WBrbmPOWU0JZNLDTrJ4ki9A9rDjONsmH9vRtNaz7d+PbsvMmEy12TDxm8KZd1Np5Y9Tc
         X+ecI/vlW+mTXV2PW1ybVUHL2DcjJY/9YMrOSiBDTmJCTWhUbYk7FST6/EPpX3iO7+SP
         bZEXtEJK8zeSyVvCfMfmZ7SQKwohEdpZsDOPMcvnO9PXUVCSNLVXYfRHZ4JG5zQuDJ5g
         TGBQ==
X-Gm-Message-State: APjAAAXsCbh9SrrowOaWyCw44dk5MwN8n+RxE9JoSeW54CMr6OwfsnAy
        OM5x4YXFEgD+kjLlratj9RZsvQ==
X-Google-Smtp-Source: APXvYqw/2GHBIiqx+bJGKsuK70KVLl3QsXrx6M32+D806GKBB9cXpnuNP1yKHbtB4AmxdaVZV+CvZQ==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr26464570wmj.106.1575282842250;
        Mon, 02 Dec 2019 02:34:02 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k20sm22134737wmj.10.2019.12.02.02.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 02:34:01 -0800 (PST)
Subject: Re: [PATCH v6 3/8] usb: dwc3: Add support for
 role-switch-default-mode binding
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20191128051001.18995-1-john.stultz@linaro.org>
 <20191128051001.18995-4-john.stultz@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <c3730c01-9675-1cc7-c82e-1ce3a51be404@linaro.org>
Date:   Mon, 2 Dec 2019 10:34:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128051001.18995-4-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2019 05:09, John Stultz wrote:
> Support the new role-switch-default-mode binding for configuring
> the default role the controller assumes as when the usb role is
> USB_ROLE_NONE
> 
> This patch was split out from a larger patch originally by
> Yu Chen <chenyu56@huawei.com>
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: Ic6e4df1109b350deaecdc69f667d49ce91d599f3
> ---
> v3: Split this patch out from addition of usb-role-switch
>      handling
> v5: Reworked to use string based role-switch-default-mode
> ---
>   drivers/usb/dwc3/core.h |  3 +++
>   drivers/usb/dwc3/drd.c  | 25 ++++++++++++++++++++++---
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 6f19e9891767..3c879c9ab1aa 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -953,6 +953,8 @@ struct dwc3_scratchpad_array {
>    *		- USBPHY_INTERFACE_MODE_UTMI
>    *		- USBPHY_INTERFACE_MODE_UTMIW
>    * @role_sw: usb_role_switch handle
> + * @role_switch_default_mode: default operation mode of controller while
> + *			usb role is USB_ROLE_NONE.
>    * @usb2_phy: pointer to USB2 PHY
>    * @usb3_phy: pointer to USB3 PHY
>    * @usb2_generic_phy: pointer to USB2 PHY
> @@ -1087,6 +1089,7 @@ struct dwc3 {
>   	struct notifier_block	edev_nb;
>   	enum usb_phy_interface	hsphy_mode;
>   	struct usb_role_switch	*role_sw;
> +	enum usb_dr_mode	role_switch_default_mode;
>   
>   	u32			fladj;
>   	u32			irq_gadget;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 3b57d2ddda93..865341facece 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -491,7 +491,10 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
>   		mode = DWC3_GCTL_PRTCAP_DEVICE;
>   		break;
>   	default:
> -		mode = DWC3_GCTL_PRTCAP_DEVICE;
> +		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
> +			mode = DWC3_GCTL_PRTCAP_HOST;
> +		else
> +			mode = DWC3_GCTL_PRTCAP_DEVICE;
>   		break;
>   	}
>   
> @@ -517,7 +520,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
>   		role = dwc->current_otg_role;
>   		break;
>   	default:
> -		role = USB_ROLE_DEVICE;
> +		if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
> +			role = USB_ROLE_HOST;
> +		else
> +			role = USB_ROLE_DEVICE;
>   		break;
>   	}
>   	spin_unlock_irqrestore(&dwc->lock, flags);
> @@ -527,6 +533,19 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
>   static int dwc3_setup_role_switch(struct dwc3 *dwc)
>   {
>   	struct usb_role_switch_desc dwc3_role_switch = {NULL};
> +	const char *str;
> +	u32 mode;
> +	int ret;
> +
> +	ret = device_property_read_string(dwc->dev, "role-switch-default-mode",
> +					  &str);
> +	if (ret >= 0  && !strncmp(str, "host", strlen("host"))) {
> +		dwc->role_switch_default_mode = USB_DR_MODE_HOST;
> +		mode = DWC3_GCTL_PRTCAP_HOST;
> +	} else {
> +		dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
> +		mode = DWC3_GCTL_PRTCAP_DEVICE;
> +	}
>   
>   	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
>   	dwc3_role_switch.set = dwc3_usb_role_switch_set;
> @@ -535,7 +554,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
>   	if (IS_ERR(dwc->role_sw))
>   		return PTR_ERR(dwc->role_sw);
>   
> -	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +	dwc3_set_mode(dwc, mode);
>   	return 0;
>   }
>   #else
> 

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
