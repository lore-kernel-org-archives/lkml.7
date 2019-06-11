Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5B7C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126682173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKzewkqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405765AbfFKWdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:33:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33766 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405570AbfFKWdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:33:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so5741189plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rheF1XeHr+TBtp29Z8BqnMhDdcbdifoVvsMUnTVTQ0w=;
        b=QKzewkqqr14aegyj9+KanpTXPALGWcAhgyKlFkPm+hIUpaiT5vfVCHwLDQjJnicRB4
         jWOVMCSmyMs7lj97v8kBr5AIAjLEtAYARRhQvSIdJl6dY8M8BIMwu6hXtzBO/6hQAAVZ
         R/3aJvCS5f1cpoXdCsmvWLdPJctFcP3gL7lhMRFa2f04l87qEV3sG+LctemNIIutyiz0
         coO2IFn//1n30Y5C3x2psChDUceRjUq3sahJi0y3yAlHV+XXZsp9XT/sRIA/UjAFFgGJ
         VuUO6M6OzU+lbVMu8QhXHbQzabAHnK3JcUwmnUhN5ilGVa3HtEDaHSJuGg4zy3T9ddsl
         /2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rheF1XeHr+TBtp29Z8BqnMhDdcbdifoVvsMUnTVTQ0w=;
        b=C1o7kM19kes1yDSbkNmBG3WdZov4zQepcbFepcGzKRpyhgDpybIEgYj5+lE/adc2U1
         GZpyKwbAJcGlvjZd7sRq66ZUYgmTDoBXuwoKxjHZKjJIQOl7C5v9VIZNhq4CjfeEwk5X
         ZX66YzwxvCk2bU50KjaFTfMPgHoNE9XlnBQTqCc5JsjXK5Hv1Az2cDYC/JSu3E14CCYM
         fDZaT2+AHZbQ38bdVGPeLu6DjGkr9h6wypd76kCZHLORz0aL8oNSqP8Wzrd0ORuxaGU6
         QQHUdsLWvmc4DZT61YGtbB0lD2XxTS8qHBMNaIdSbsTcAgH5stwS82CRF1vyfxP8/VEJ
         q2eA==
X-Gm-Message-State: APjAAAVgqbxmB/IudgmqIgmzum38Nbfn0YXFGr9fPSjKFSfnxtZcZ2Lz
        AQ4kc+OYPrPz+bOQAaWSA9a4ow==
X-Google-Smtp-Source: APXvYqzOrGp2e1lCEgBy09sDw+6XFk1Cp1xh3ZSUOlQ7lXvCww/YU+McON7j6rpV8WQzMMdtV7Kusw==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr40878255pld.16.1560292432547;
        Tue, 11 Jun 2019 15:33:52 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w4sm18222973pfw.97.2019.06.11.15.33.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:33:51 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:33:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        linus.walleij@linaro.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the
 SDM845
Message-ID: <20190611223349.GS4814@minitux>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610084213.1052-7-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Jun 01:42 PDT 2019, Lee Jones wrote:

> When booting with Device Tree, the current default boot configuration
> table option, the request to boot via 'host mode' comes from the
> 'dr_mode' property.

As I said in my previous review, the default mode for SDM845 is OTG. For
the MTP specifically we specify the default mode to be peripheral (was
host).


The remaining thing that worries me with this patch is that I do expect
that at least one of the USB-C ports is OTG. But I am not able to
conclude anything regarding this and host-only is a good default for
this type of device, so I suggest that we merge this.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> A property of the same name can be used inside
> ACPI tables too.  However it is missing from the SDM845's ACPI tables
> so we have to supply this information using Platform Device Properties
> instead.
> 
> This does not change the behaviour of any currently supported devices.
> The property is only set on ACPI enabled platforms, thus for H/W
> booting DT, unless a 'dr_mode' property is present, the default is
> still OTG (On-The-Go) as per [0].  Any new ACPI devices added will
> also be able to over-ride this implementation by providing a 'dr_mode'
> property in their ACPI tables.  In cases where 'dr_mode' is omitted
> from the tables AND 'host mode' should not be the default (very
> unlikely), then we will have to add some way of choosing between them
> at run time - most likely by ACPI HID.
> 
> [0] Documentation/devicetree/bindings/usb/generic.txt
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 1e1f12b7991d..55ba04254e38 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -444,6 +444,11 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>  	return 0;
>  }
>  
> +static const struct property_entry dwc3_qcom_acpi_properties[] = {
> +	PROPERTY_ENTRY_STRING("dr_mode", "host"),
> +	{}
> +};
> +
>  static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom 	*qcom = platform_get_drvdata(pdev);
> @@ -488,6 +493,13 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	ret = platform_device_add_properties(qcom->dwc3,
> +					     dwc3_qcom_acpi_properties);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add properties\n");
> +		goto out;
> +	}
> +
>  	ret = platform_device_add(qcom->dwc3);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to add device\n");
> -- 
> 2.17.1
> 
