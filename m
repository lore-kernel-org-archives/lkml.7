Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB92070D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MFQRCoIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCRKHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:07:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22928 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCRKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:07:48 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190318100745epoutp019a5149220bea1a9a8ac2b568b9e8cfba~NBagJqFvc2726127261epoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:07:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190318100745epoutp019a5149220bea1a9a8ac2b568b9e8cfba~NBagJqFvc2726127261epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552903665;
        bh=Sd8u26jRR/PCidqo1QGfI0YBbI06eqnSYQAFRFkNza8=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=MFQRCoIvW+ku1Fk3v/IRyadudA6IFgT7UcwABBy1p6fgWRuCWOy5BLzQf3nAT7oCc
         +KkYYYMp+K3zGrIZEiWn6UzfYptoMH+6WL5kfqXXFdXVvA1EcZ6dFs8++bgc+kgIjs
         Gm30ls1RVPnz+6vNo5xi27phdfYhXOfzZvNip1lg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190318100553epcas1p3fb3b924c1bff0e0c7896930aaf53cbed~NBY39Fy_X1131611316epcas1p3m;
        Mon, 18 Mar 2019 10:05:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.D8.04142.B7D6F8C5; Mon, 18 Mar 2019 19:05:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190318100546epcas1p32a6ea3b243badcd153fa885c4bf04f32~NBYxN9ZpR1610316103epcas1p3t;
        Mon, 18 Mar 2019 10:05:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190318100546epsmtrp11a1ff4174153abef31a3745f140be0ff~NBYxLPrm-3180331803epsmtrp1A;
        Mon, 18 Mar 2019 10:05:46 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-80-5c8f6d7b8250
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.E0.03692.A7D6F8C5; Mon, 18 Mar 2019 19:05:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190318100546epsmtip148dcc870ed4919a0d008882382f78c16~NBYxCGx2Y0153401534epsmtip1f;
        Mon, 18 Mar 2019 10:05:46 +0000 (GMT)
Subject: Re: [PATCH v1 1/2] extcon: intel: Split out some definitions to a
 common header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <864a0b40-96e8-ab05-705b-08d7c883b9ac@samsung.com>
Date:   Mon, 18 Mar 2019 19:05:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmvm51bn+MQeMUFovepulMFm+OA4nL
        u+awWdxuXMHmwOIx72Sgx/t9V9k8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKOSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
        xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtjwlG5gvXSFdOPLGZvYPwq2sXIySEh
        YCKxv7uZDcQWEtjBKLFmW3AXIxeQ/QnI/r+LEcL5xijxaOFDVpiO7gWH2SASexklPpyZyATh
        vGeUeLnjETNIlbBAlMT9G/dZQRIiAssZJZ7eWcIOkmAT0JLY/+IG2EJ+AUWJqz8eM4LYvAJ2
        EgcbPoDFWQRUJXrm72YBsUUFIiTeP4WweQUEJU7OfAJmcwq4S7z68g3MZhYQl7j1ZD4ThC0v
        0bx1NjPIYgmBA2wSP6dPAFrMAeS4SHz7kg3xgrDEq+Nb2CFsKYmX/W1QdrXEypNH2CB6Oxgl
        tuy/APWzscT+pZOZQOYwC2hKrN+lD7GLT+Ld1x5WiPG8Eh1tQhDVyhKXH9xlgrAlJRa3d7JB
        2B4ScxpesEACaxajRM+ULpYJjAqzkLw2C8k7s5C8Mwth8wJGllWMYqkFxbnpqcWGBUbIsb2J
        EZwatcx2MC4653OIUYCDUYmHt2FKX4wQa2JZcWXuIUYJDmYlEV57z/4YId6UxMqq1KL8+KLS
        nNTiQ4ymwJCfyCwlmpwPTNt5JfGGpkbGxsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6
        mDg4pRoY298uYfym3sver+v6kfnFXJuZE9OKNuc+0Vfyet74JVxl8cGDkaq3tYS/91+rVYip
        C6t3OX/GvFPbjyPpno3QDt5Q7nmbN1VVnjB8tnHidm/lC/PdtrNkOYXY/GN35hGVOJExbXbC
        8wUFH3LKLq3WOJj9d++JVu/1pwyXa58+uzmopyz1pnixEktxRqKhFnNRcSIAc3X8maMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnG5Vbn+MQcM+JYvepulMFm+OA4nL
        u+awWdxuXMHmwOIx72Sgx/t9V9k8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK2PCUbmC9dIV
        048sZm9g/CraxcjJISFgItG94DBbFyMXh5DAbkaJt3+Ps0MkJCWmXTzK3MXIAWQLSxw+XAxR
        85ZR4sCv+4wgNcICURL3b9xnBUmICCxnlHh8bhE7RNUsRolDX+aBTWIT0JLY/+IGG4jNL6Ao
        cfXHY7BuXgE7iYMNH8DiLAKqEj3zd7OA2KICERJ3L75ggagRlDg58wmYzSngLvHqyzcwm1lA
        XeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhg
        mJdarlecmFtcmpeul5yfu4kRHA1amjsYLy+JP8QowMGoxMN7Y1pfjBBrYllxZe4hRgkOZiUR
        XnvP/hgh3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbBZJk4OKUaGPkf
        36tzOaBSJSatt/yt7YSjXXW3mP+KiNVF77htF1y9auMVz9kfDwmXPOVlMXkg7LrabOpatY/9
        n1WV/r1KCk6NC3zWdEyk0Nlhf8mZ/pBjBzfOurKCJzrr7/z5P5cULbf0+cBy9OD3+qvqc5R0
        GrWFu8wSxJV5Vqzc2xC0dm69kWBW+W3NW0osxRmJhlrMRcWJAFypTX2CAgAA
X-CMS-MailID: 20190318100546epcas1p32a6ea3b243badcd153fa885c4bf04f32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190318095232epcas5p27d6bafb732b79cf76d84f0de0fccda6c
References: <CGME20190318095232epcas5p27d6bafb732b79cf76d84f0de0fccda6c@epcas5p2.samsung.com>
        <20190318095225.69200-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks good to me. But just there is minor one comment as following:
- 2018 -> 2019

On 19. 3. 18. 오후 6:52, Andy Shevchenko wrote:
> We are going to use some definitions in the other Intel extcon drivers,
> thus, split out them to a common header file.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 21 +++++++--------------
>  drivers/extcon/extcon-intel.h        | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/extcon/extcon-intel.h
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 5ef215297101..110bd38a4d24 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -17,6 +17,8 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +#include "extcon-intel.h"
> +
>  #define CHT_WC_PHYCTRL			0x5e07
>  
>  #define CHT_WC_CHGRCTRL0		0x5e16
> @@ -65,15 +67,6 @@
>  #define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
>  #define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
>  
> -enum cht_wc_usb_id {
> -	USB_ID_OTG,
> -	USB_ID_GND,
> -	USB_ID_FLOAT,
> -	USB_RID_A,
> -	USB_RID_B,
> -	USB_RID_C,
> -};
> -
>  enum cht_wc_mux_select {
>  	MUX_SEL_PMIC = 0,
>  	MUX_SEL_SOC,
> @@ -101,9 +94,9 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
>  {
>  	switch ((pwrsrc_sts & CHT_WC_PWRSRC_USBID_MASK) >> CHT_WC_PWRSRC_USBID_SHIFT) {
>  	case CHT_WC_PWRSRC_RID_GND:
> -		return USB_ID_GND;
> +		return INTEL_USB_ID_GND;
>  	case CHT_WC_PWRSRC_RID_FLOAT:
> -		return USB_ID_FLOAT;
> +		return INTEL_USB_ID_FLOAT;
>  	case CHT_WC_PWRSRC_RID_ACA:
>  	default:
>  		/*
> @@ -111,7 +104,7 @@ static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
>  		 * the USBID GPADC channel here and determine ACA role
>  		 * based on that.
>  		 */
> -		return USB_ID_FLOAT;
> +		return INTEL_USB_ID_FLOAT;
>  	}
>  }
>  
> @@ -221,7 +214,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>  	}
>  
>  	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> -	if (id == USB_ID_GND) {
> +	if (id == INTEL_USB_ID_GND) {
>  		/* The 5v boost causes a false VBUS / SDP detect, skip */
>  		goto charger_det_done;
>  	}
> @@ -248,7 +241,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
>  		ext->previous_cable = cable;
>  	}
>  
> -	ext->usb_host = ((id == USB_ID_GND) || (id == USB_RID_A));
> +	ext->usb_host = ((id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A));
>  	extcon_set_state_sync(ext->edev, EXTCON_USB_HOST, ext->usb_host);
>  }
>  
> diff --git a/drivers/extcon/extcon-intel.h b/drivers/extcon/extcon-intel.h
> new file mode 100644
> index 000000000000..455986b2b004
> --- /dev/null
> +++ b/drivers/extcon/extcon-intel.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Intel extcon hardware
> + *
> + * Copyright (C) 2018 Intel Corporation. All rights reserved.

2018 -> 2019

> + */
> +
> +#ifndef __EXTCON_INTEL_H__
> +#define __EXTCON_INTEL_H__
> +
> +enum extcon_intel_usb_id {
> +	INTEL_USB_ID_OTG,
> +	INTEL_USB_ID_GND,
> +	INTEL_USB_ID_FLOAT,
> +	INTEL_USB_RID_A,
> +	INTEL_USB_RID_B,
> +	INTEL_USB_RID_C,
> +};
> +
> +#endif	/* __EXTCON_INTEL_H__ */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
