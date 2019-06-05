Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FAC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4B92083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1WvdiqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEHJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:09:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:09:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so3546889wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k36dAzNmgaqwmQvMa36IwjM04BTSr/wOoDP6exbi8UY=;
        b=x1WvdiqHLGUEpygoU7klJUijn/C602Fe/bjAvlUTzjx+mANGu6SbHM0cNO6C1aYO70
         cgE5M3tcJMZUb4aa2iNdpqyoRySDK3DOzLY5GYYBvnlXRAbERMKwJvO6PChqSsf1grbr
         lM1cAbcqFEloQ76z4a+rOMaDqeqlFIZ1AcQA3BufSn6WYNLsTeUUh8XbSM7MMI7XnGbm
         IVRpU1osdykJhxWGwjYopNceGQeWq6Q1TJ+qnbrzaa5Wi+9jNVJQEWI2/ZhWPwjdPNQJ
         UxEOQm5H4edvFoHK1Wk8x3DbaytJZIvDr+N0+Ck0k1WO/AkT3w1uc00d0s0YfgenW7AP
         Nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k36dAzNmgaqwmQvMa36IwjM04BTSr/wOoDP6exbi8UY=;
        b=cu5XiQT1tUyxePZgxMjbiPfyYF2EG3YT7fR7+VRfhBopnqpi4XfcHMB2c1V4ncU2HS
         HOe3YDFc50nX+mCe9zIuPCipJ2mBiO1SqQ6CPkEsUsgf9jtxQwsZfl9Yi1zhYBZPtwmV
         WqCn0qsxOpgsNjKwLqW3VZ+W9Yr5s77NGMm2LOYB2boA/TXa1PAHzgv8uLSOj9mT+CDV
         fHuzEWH537Agn4QlpmzFtp7/mZHqOisJMN4vVUYxFxJn4mro5qCh7hGD7lAmz8N/Lvqi
         W/7QCwub5zEMcVyv72N5yYKYAIoPydesvOnEt1b/WhNHl3V8i8d1LBzngNIWBUnc9YEc
         tbJg==
X-Gm-Message-State: APjAAAW9Qn1YJh9CD5h/3uuqM42q3IV5yWCr5N0mrNHConn4/KmQQUl0
        4XysJixvw442ZXk0MDeTIanMhw==
X-Google-Smtp-Source: APXvYqxh5AFxtIbzQZRmSAlo9FC/qrjqBKRgVLtmMT2NgG+CeZHe6g4bUCTSorRYhPeYfhTb5pZX+w==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr6579006wru.93.1559718570730;
        Wed, 05 Jun 2019 00:09:30 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c129sm2405930wma.27.2019.06.05.00.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:09:30 -0700 (PDT)
Date:   Wed, 5 Jun 2019 08:09:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     alokc@codeaurora.org, kramasub@codeaurora.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/8] usb: dwc3: qcom: Add support for booting with ACPI
Message-ID: <20190605070928.GJ4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-6-lee.jones@linaro.org>
 <20190605063507.GM22737@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605063507.GM22737@tuxbook-pro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Bjorn Andersson wrote:

> On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> [..]
> > @@ -373,7 +416,7 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
> >  
> >  	qcom->num_clocks = count;
> >  
> > -	if (!count)
> > +	if (!count || ACPI_HANDLE(dev))
> >  		return 0;
> 
> Afaict you call this with count = of_count_phandle_with_args(), which
> should be 0. But why not skip calling this at all?

Actually count can be <0, which is why I must have needed it at the
beginning.  There is another patch in this set which checks for
errors, thus the ACPI_HANDLE() call should now be superfluous.  I
will test and remove it.

> >  	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
> > @@ -409,12 +452,28 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
> >  	return 0;
> >  }
> >  
> > +static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
> > +	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
> > +	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
> > +	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
> > +	.hs_phy_irq_index = 1,
> > +	.dp_hs_phy_irq_index = 4,
> > +	.dm_hs_phy_irq_index = 3,
> > +	.ss_phy_irq_index = 2
> > +};
> > +
> > +static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
> > +	{ "QCOM2430", (unsigned long)&sdm845_acpi_pdata },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
> 
> Analog to of_device_get_match_data() there seems to be a
> acpi_device_get_match_data(), if you use this you should be able to
> have you acpi_device_id array next to the of_device_id.

Do you mean "Analogous"?

I will try to group them, thanks.

> > +
> >  static int dwc3_qcom_probe(struct platform_device *pdev)
> 
> It seems that all that's left unconditional on ACPI_HANDLE() in this
> function are the optional pieces and the tail. Wouldn't it be cleaner to
> split it out in different functions?

There are ~50 lines of shared code in dwc3_qcom_probe(), most of it is
interspersed between the configuration table (DT, ACPI) pieces, which
is why it's formatted in the current way.

I can split a few things out into separate functions if you think
it'll help.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
