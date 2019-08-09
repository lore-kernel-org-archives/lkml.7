Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B352084D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406495AbfHILGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:06:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39180 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406272AbfHILGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:06:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id e16so1325622edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 04:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xMfMLN5n9NvXBMPK4Z+02UCjCT+IDFZNmUQWYyXvps=;
        b=Kt8IA2lpJppeEakM8liCtYspBQwNKo127VD6PbKtsK2mosUdXxtzxGMm03I9F+w7lE
         GUjMlgPg+7IMpztowbfnZ5MOmW3OC71LfbaDWbwHCIe2kUjW3ZTY+TafGId8AUU+KFeD
         HQ4nMhIc95qArbD3nf8Ihhh/6U8MOAHhln6cJ6TlCUlnxlAzDUCLFE6MbHqhffDWXaSK
         PAtdkkZ65i9+XymZdeQyAaHNjhndxJRREnWHaxZLzbPLRwurr0MEZiikEtm8Kq1pgFTv
         88UB5gIBuEI4qmbnmjj/2l6bYXcRpGP29y/mXFVURUqA4/kygpqdSZT72CMSBJTXP0/P
         2aZA==
X-Gm-Message-State: APjAAAUCFUCew6LUtGkQL1niKRUvgVHDgVpqFooplXml3FKV1+bp2+J5
        pyP51rIJS9O2d/GXPpZHxAydnQ==
X-Google-Smtp-Source: APXvYqziQCq15NyoQmGg7IA4VdqjjKmJ5ahYUASWddAObX+FQ83zvRjVHKzSYF8TdPbAQj7hgpZ+sQ==
X-Received: by 2002:a50:eb4d:: with SMTP id z13mr21172946edp.271.1565348772094;
        Fri, 09 Aug 2019 04:06:12 -0700 (PDT)
Received: from localhost.localdomain ([62.140.137.140])
        by smtp.gmail.com with ESMTPSA id a67sm22197012edf.6.2019.08.09.04.06.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:06:11 -0700 (PDT)
Subject: Re: [PATCH] extcon-intel-cht-wc: Don't reset USB data connection at
 probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190808220129.2737-1-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fbe20a5f-0f64-cadf-2c1e-88a468d54a07@redhat.com>
Date:   Fri, 9 Aug 2019 13:06:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808220129.2737-1-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/19 12:01 AM, Yauhen Kharuzhy wrote:
> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> PMIC at driver probing for further charger detection. This causes reset of
> USB data sessions and removing all devices from bus. If system was
> booted from Live CD or USB dongle, this makes system unusable.
> 
> Check if USB ID pin is floating and re-route data lines in this case
> only, don't touch otherwise.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>   drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 9d32150e68db..3ae573e93e6e 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>   	struct cht_wc_extcon_data *ext;
>   	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
> +	int pwrsrc_sts, id;
>   	int irq, ret;
>   
>   	irq = platform_get_irq(pdev, 0);
> @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>   		goto disable_sw_control;
>   	}
>   
> -	/* Route D+ and D- to PMIC for initial charger detection */
> -	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> +	if (ret) {
> +		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> +		goto disable_sw_control;
> +	}
> +
> +	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> +
> +	/* If no USB host or device connected, route D+ and D- to PMIC for
> +	 * initial charger detection
> +	 */
> +	if (id == INTEL_USB_ID_FLOAT)
> +		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);

The check here should be != INTEL_USB_ID_GND, when we are connected as
device we are charging from the host we are connected to and the port
we are connected to may be a CDP (charging downstream port) instead of
a SDP (standard downstream port) allowing us to charge at 1.5A instead
of 0.5A, also != INTEL_USB_ID_GND matches the condition used in
cht_wc_extcon_pwrsrc_event to determine if we should continue with
charger detection there.

Like your other patch I will try to give this one a  test-run tomorrow.

Regards,

Hans


>   
>   	/* Get initial state */
>   	cht_wc_extcon_pwrsrc_event(ext);
> 
