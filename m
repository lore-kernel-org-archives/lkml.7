Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D664C43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF74206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="FRWIy0Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLBKb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:31:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32991 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLBKbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:31:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so13902733wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g6dP6ry74SEyd5dt7pE6fUowydAenmGxZnWV3bHJzlY=;
        b=FRWIy0LcmognG1qfwrTGSr0PLfZcbrji5ZkGhbvmL9+t5Z/1tkWpUJWpg4LbR/u722
         G3G0iev2HvWqjWawHkbYyLH0J+/EzVoarvqvFa5OiCCrMeLBpI+dElbXhO9v5hMxk3HQ
         PpOxzCHtpjunyLTRE2C3SUQHBQY45W6fVIJPtTUl6GULbJ6KrYBW2hmM1tKyTfWM4QDI
         0vsEXerQ3h2xjj6m4bW0HGeazo4BxoPk+rVg0WgvpLHxtDDhDBtoYCW7WDWtEbyeAAX8
         L/gYWyPPNI6lVfVFvi5nklBlHiZq/sACEUi3VGP6WIKF+iywnenX4aDy2hEUiARmzugT
         Zq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6dP6ry74SEyd5dt7pE6fUowydAenmGxZnWV3bHJzlY=;
        b=gYhq3LguVYtcHRzYsTU1aIOZUIqax5R7FLsu8rZKylhzhgjGwUO6eG570U+B3e10mX
         jNFhg1FmnRwvo59W5QnyzkzQHEcx3Ud5NpCkzGvrvKyua0RoJzLLgoXuT+dSjykPz0eZ
         rFAo4cNLp2sWXICSMdxL6vJC8pPeSHadzJAkza0or9XZdlYBtn0JuXgVO1cJnjvEuBAv
         JiftQS59+Yce908GZad8T+GicVOqgh/zk8iIr1yGnW1gTLXY7zBNcyd9J7qAgpR7O7Bb
         QcwON2lZe5jl2eDky0zyGnjqEUrBkeSYNHamn5wq4ZWnzznffHyh0gu3bW+UzZWgEU7y
         Wl8g==
X-Gm-Message-State: APjAAAWOmSq9bnaJoCO2J6mqM1s1NS593LKoTa+QYLHx+F5BV/kyTm53
        XWC8IJF3KIPpNPkQzZ4WYv0o/Q==
X-Google-Smtp-Source: APXvYqwxxamKKpWPDGivG9vzv+yfja23o3nFH428n+VhPLbFMuZGIE4T7Mjif3hWLOBklnYIMymxfA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr9589645wrq.396.1575282713284;
        Mon, 02 Dec 2019 02:31:53 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i127sm24352606wma.35.2019.12.02.02.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 02:31:52 -0800 (PST)
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
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <97d3570e-2b4f-b32e-fe1a-bf0f49603238@nexus-software.ie>
Date:   Mon, 2 Dec 2019 10:32:07 +0000
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

I've used this on a qcs404 - it works for me.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
