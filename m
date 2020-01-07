Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE5AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8982077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKnu1Uhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgAGKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:18:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:18:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so53247419wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5OSpiBgLmyZRMYClNdG6v/2d9HzZ4xtRsYnQ1Jt34tg=;
        b=cKnu1Uhpwa9RJbuLbSDrHf3Wgs0qUh32dyk3Vf3CNLB3H+XFgRV3LYY++WjzX50qqR
         asC3BHLKYzx4cJHTxSmnxNhaNXxBRxS+rRC9lQ1tELV30j6JWutWLaA06W1pl9vIwwpa
         otlIUVVVWP0bY1TtRMeiK+mJuwzsjJW5tODutbCpXvg/Qov6F015M5N+HG1+I68wKkZo
         QHWI2FWglN5WoSGINA4ckO2KpqkGwfAgD+0tz0zfUYGxegUvboV9AglfWks09IEwjVVt
         aCDXpv0kOSa4Q42pp2W6XbYdp2WiL7L2OMBQu2jzs0axxf+QfoCJWgtfAxhGb//eudJw
         4iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5OSpiBgLmyZRMYClNdG6v/2d9HzZ4xtRsYnQ1Jt34tg=;
        b=Qc88Lv6x3f2utwFWfTqLC/k9IR6stU7imTZ3ACcozTnOjJMX0WB9O82ZCEPt44o0cZ
         H+9hgY6M33BNvkicgra0FpNz1C6XcrW5KlhdAQVG7mjeGTxyUbapQa5E+hnMvX3z1WGt
         gP3ICmoKiLdy2qU/xO1A1iOlbDTzIabq4ISlXuwYZBBC1CYPs70n77qx+RI7vc2kTe6J
         B8YBAQor5I9WDp17oM/TEkKukf5zyiNTpWYKN/Osz7SowbR63mImkS4SENX1jAS0PmXl
         +EydFWavDfVqQnYfHFfmv2zIissCezzPYG4Uaxkf8WuS1+tAhjwebVTUYo4dzOXv44tP
         c0ag==
X-Gm-Message-State: APjAAAX7vrLxmcYJ3fHtK2bSZyYqHUT9A1T/UYWWIuvNgl4IC8GoiXNh
        TdbdEHmJOVrDZVh+ALgrk02O6Q==
X-Google-Smtp-Source: APXvYqz3Re5MwhTSC/BuabUjWdObG0LJv2kUstc3b+oywJXytPI+74gf5zIuTS4NULpii+z9mZXgwQ==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr112714781wrm.62.1578392335397;
        Tue, 07 Jan 2020 02:18:55 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id u14sm75650587wrm.51.2020.01.07.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:18:54 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:18:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     boris.brezillon@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sam@ravnborg.org, peda@axentia.se, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mfd: atmel-hlcdc: return in case of error
Message-ID: <20200107101859.GD14821@dell>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576672109-22707-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, Claudiu Beznea wrote:

> For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
> ATMEL_HLCDC_SR needs to be polled before applying new config. In case of
> timeout there is no indicator about this, so, return in case of timeout
> and also print a message about this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/atmel-hlcdc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Patch applied and pull-request sent, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
