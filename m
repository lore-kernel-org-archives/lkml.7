Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E7C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EF7206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="qFs3Wq0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLBKdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:33:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53706 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLBKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:33:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so21191810wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NbujNseECunLrgTOygV3gXrz0ppXeNI3Y3t4xov5aQU=;
        b=qFs3Wq0Kg112YOZw7avQOJHM8xgA3AgiXpQgSLVH8qAqlP2P9FOdMe1KhnPkbWumHh
         /mMOomRoJvOsq7gFxHk7iZw6B8vvL6N+QPVRD2SyICzbw0puBzgtLcGGLNb9yIOqPpK5
         LDFNlf74k6YtC8bprUk+4Y4PS0P/i6BPZmgUZDw68n4aF5jeo7cwkug9A0nOR1zInmts
         viOEDjPYz7vQ4mv29G+pwprrkngszcbI8nJbVqyhQr67++tDWlILKiucLPKW59XwE+Th
         WFEEcDEmOVN6ynK86H9pc0Q+LkZh7F8DexL/zfeRr8pS5+eV/SZkGp8Y0m6qmMVCJG0+
         DFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NbujNseECunLrgTOygV3gXrz0ppXeNI3Y3t4xov5aQU=;
        b=ZU94AoUIStc//ekh2lExQAsLfZU8tbsn/W4s9XS9nhoTf88o/nzmB6yeKH13xleZQs
         +JVGbmvbHvNlqZJdwNkoTvJXvSPYol1EhHzjMZKp/0S3L2KNGmfXn3U2Y8IqWRfh7UbA
         Zt20qKlgS5PmbrXMbPLrRBl/g1DWKU4NwTgSAvkXjOgW+6gZDS1qarY8HD+3MfoQ3Anv
         GjRnQ/xBJk3mw3LpLUKNLsTsn4GVXUGbZsG3hw188/ehdH5mPFN1sx7LQ5o4Ld5kd3LC
         xEAoO7UcHyLmgEL/nX504vAt7oMV7qIIKdt7T5xAPczVi+JqXH+H0uev0GhDabi2+Krs
         gGGQ==
X-Gm-Message-State: APjAAAUG3F+aMJLAQfikp0BmIYQ+z0s9QYlzOHeExylFaZFdSRKZ1WIQ
        OlFnKIug8IXbXAJ9PVyO2ulU3A==
X-Google-Smtp-Source: APXvYqx/zfGlr07Rgyo4vRcDRxmR59qe0zpo9aclFbg5OK7yOuJFdAYgGeUB8trIIQI5k1gPtsHHCw==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr25010547wmd.80.1575282785213;
        Mon, 02 Dec 2019 02:33:05 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id y20sm14961169wmi.25.2019.12.02.02.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 02:33:04 -0800 (PST)
Subject: Re: [PATCH v6 1/8] usb: dwc3: Registering a role switch in the DRD
 code.
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20191128051001.18995-1-john.stultz@linaro.org>
 <20191128051001.18995-2-john.stultz@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <4008a130-06e0-23b2-a04a-667b1cdbfeb6@nexus-software.ie>
Date:   Mon, 2 Dec 2019 10:33:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128051001.18995-2-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2019 05:09, John Stultz wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.
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
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: Ibd89b7eb3e59688895a2d317f3515e6d2705c6f3
> ---
> v2: Fix role_sw and role_switch_default_mode descriptions as
>      reported by kbuild test robot <lkp@intel.com>
> 
> v3: Split out the role-switch-default-host logic into its own
>      patch
> 
> v5: Drop selecting CONFIG_USB_ROLE_SWITCH & ifdef dependent code
> 
> v6: Fix build issue Reported-by: kbuild test robot <lkp@intel.com>
> ---
>   drivers/usb/dwc3/core.h |  3 ++
>   drivers/usb/dwc3/drd.c  | 77 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1c8b349379af..6f19e9891767 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -25,6 +25,7 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>   #include <linux/usb/otg.h>
> +#include <linux/usb/role.h>
>   #include <linux/ulpi/interface.h>
>   
>   #include <linux/phy/phy.h>
> @@ -951,6 +952,7 @@ struct dwc3_scratchpad_array {
>    * @hsphy_mode: UTMI phy mode, one of following:
>    *		- USBPHY_INTERFACE_MODE_UTMI
>    *		- USBPHY_INTERFACE_MODE_UTMIW
> + * @role_sw: usb_role_switch handle
>    * @usb2_phy: pointer to USB2 PHY
>    * @usb3_phy: pointer to USB3 PHY
>    * @usb2_generic_phy: pointer to USB2 PHY
> @@ -1084,6 +1086,7 @@ struct dwc3 {
>   	struct extcon_dev	*edev;
>   	struct notifier_block	edev_nb;
>   	enum usb_phy_interface	hsphy_mode;
> +	struct usb_role_switch	*role_sw;
>   
>   	u32			fladj;
>   	u32			irq_gadget;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index c946d64142ad..3b57d2ddda93 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -476,6 +476,73 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>   	return edev;
>   }
>   
> +#ifdef CONFIG_USB_ROLE_SWITCH
> +#define ROLE_SWITCH 1
> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
> +{
> +	struct dwc3 *dwc = dev_get_drvdata(dev);
> +	u32 mode;
> +
> +	switch (role) {
> +	case USB_ROLE_HOST:
> +		mode = DWC3_GCTL_PRTCAP_HOST;
> +		break;
> +	case USB_ROLE_DEVICE:
> +		mode = DWC3_GCTL_PRTCAP_DEVICE;
> +		break;
> +	default:
> +		mode = DWC3_GCTL_PRTCAP_DEVICE;
> +		break;
> +	}
> +
> +	dwc3_set_mode(dwc, mode);
> +	return 0;
> +}
> +
> +static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
> +{
> +	struct dwc3 *dwc = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	enum usb_role role;
> +
> +	spin_lock_irqsave(&dwc->lock, flags);
> +	switch (dwc->current_dr_role) {
> +	case DWC3_GCTL_PRTCAP_HOST:
> +		role = USB_ROLE_HOST;
> +		break;
> +	case DWC3_GCTL_PRTCAP_DEVICE:
> +		role = USB_ROLE_DEVICE;
> +		break;
> +	case DWC3_GCTL_PRTCAP_OTG:
> +		role = dwc->current_otg_role;
> +		break;
> +	default:
> +		role = USB_ROLE_DEVICE;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&dwc->lock, flags);
> +	return role;
> +}
> +
> +static int dwc3_setup_role_switch(struct dwc3 *dwc)
> +{
> +	struct usb_role_switch_desc dwc3_role_switch = {NULL};
> +
> +	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
> +	dwc3_role_switch.set = dwc3_usb_role_switch_set;
> +	dwc3_role_switch.get = dwc3_usb_role_switch_get;
> +	dwc->role_sw = usb_role_switch_register(dwc->dev, &dwc3_role_switch);
> +	if (IS_ERR(dwc->role_sw))
> +		return PTR_ERR(dwc->role_sw);
> +
> +	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +	return 0;
> +}
> +#else
> +#define ROLE_SWITCH 0
> +#define dwc3_setup_role_switch(x) 0
> +#endif
> +
>   int dwc3_drd_init(struct dwc3 *dwc)
>   {
>   	int ret, irq;
> @@ -484,7 +551,12 @@ int dwc3_drd_init(struct dwc3 *dwc)
>   	if (IS_ERR(dwc->edev))
>   		return PTR_ERR(dwc->edev);
>   
> -	if (dwc->edev) {
> +	if (ROLE_SWITCH &&
> +	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
> +		ret = dwc3_setup_role_switch(dwc);
> +		if (ret < 0)
> +			return ret;
> +	} else if (dwc->edev) {
>   		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>   		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
>   					       &dwc->edev_nb);
> @@ -531,6 +603,9 @@ void dwc3_drd_exit(struct dwc3 *dwc)
>   {
>   	unsigned long flags;
>   
> +	if (dwc->role_sw)
> +		usb_role_switch_unregister(dwc->role_sw);
> +
>   	if (dwc->edev)
>   		extcon_unregister_notifier(dwc->edev, EXTCON_USB_HOST,
>   					   &dwc->edev_nb);
> 

This again I've used on the qcs404 and it works nicely.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
