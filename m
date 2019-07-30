Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BECC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A876620882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrtCq5Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfG3ENI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:13:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36417 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfG3ENI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:13:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so29114786pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dIdr0oee/yzISErhJRxkq09mvv2TBOhcmQ09wO6m0E=;
        b=OrtCq5Snu5fXUnizDVa0OuKzMhTHKT7s5OK7tU318dlfyuG3bM8RYHmuV7nP3E8a+/
         +yOlv35ESIfJr+g4pd9yjM6q41lvTW01/7heaskQI8d33iLkSP72SzxWG8aVo3W3u+ZW
         dlCPkfjpEZYFugUKH4EwVM50JS3i9vV3dshDL2KJChMPBmBzi26W0ceSNsth5kCjs3ZC
         eunZDBKEX1l8ogrLuX2V/aXyizny3TO8NSczp/xzmsx9f680i9TQH6sws+AnLECXDaiq
         Nz3tHjZnvmu8y3C3vgW2fEbRXakmRB+5d3ZWZnaOx/4227/5+FKR1sBYP+srlkJTAm+G
         jCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dIdr0oee/yzISErhJRxkq09mvv2TBOhcmQ09wO6m0E=;
        b=K1ZXjSlhorUo+rz+XIS0WB84TmROBIm3s2RRFBTXvY9+fw0GwSuQPdwKn4738Mjhpl
         ePzslQzNKCPj5w+a+xAxHC3cBZDVnW0GUyG8H1J0QBaK7OCVvLnI3P5ejWT7yxALYZaC
         H/ai8dh3TpPbG4HPzFo0q60/axRepurxRjplWavHVP2G85pjUIOftiLlOD9WhiTwviFn
         /bugz/TyiEM9pDC7bk4cDUWcXA6T3jk1jMaz+zlztTcQvGxFQSBD3WYIb7C8JsNpxcmk
         LrfmFDVAL8ZC2KGDIQr6ONTXy319AKCK21VBBw65faIqd89PuThgyATyvqz0cEVLWPbc
         NIvA==
X-Gm-Message-State: APjAAAWxGMCxxEnsYdf3E3HaPTa2GAtZnxr50AbrHPUy2xyl4ac7xppa
        7SjliDcENBU/J87ZvtQNpIak
X-Google-Smtp-Source: APXvYqz5yPeIopb8Zi5XBaN/Wi6+Py+XNWnQJqU+IjLr28mzLvamVAUeAbUgGvxcXYv4TzlNrw5ZMA==
X-Received: by 2002:a62:770e:: with SMTP id s14mr38606145pfc.150.1564459987428;
        Mon, 29 Jul 2019 21:13:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:704e:cda4:ddd4:6d08:8469:b0f0])
        by smtp.gmail.com with ESMTPSA id h9sm76306769pgk.10.2019.07.29.21.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:13:06 -0700 (PDT)
Date:   Tue, 30 Jul 2019 09:42:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org
Cc:     robh+dt@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, c.barrett@framos.com,
        a.brela@framos.com
Subject: Re: [PATCH 0/3] Add IMX290 CMOS image sensor support
Message-ID: <20190730041253.GA3178@Mani-XPS-13-9360>
References: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:32:27AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds support for IMX290 CMOS image sensor from Sony.
> Sensor can be programmed through I2C and 4-wire interface but the
> current driver only supports I2C interface. Also, the sensor is
> capable of outputting frames in following 3 interfaces:
> 
> * CMOS logic parallel SDR output
> * Low voltage LVDS serial DDR output
> * CSI-2 serial data output
> 
> But the current driver only supports CSI-2 output available from 4 lanes.
> In the case of sensor resolution, driver only supports 1920x1080 and
> 1280x720 at mid data rate of 445.5 Mpbs.
> 
> The driver has been validated using Framos IMX290 module interfaced to
> 96Boards Dragonboard410c.
> 

Ping on the patchset!

Thanks,
Mani

> Thanks,
> Mani
> 
> Manivannan Sadhasivam (3):
>   dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
>   media: i2c: Add IMX290 CMOS image sensor driver
>   MAINTAINERS: Add entry for IMX290 CMOS image sensor driver
> 
>  .../devicetree/bindings/media/i2c/imx290.txt  |  51 ++
>  MAINTAINERS                                   |   8 +
>  drivers/media/i2c/Kconfig                     |  11 +
>  drivers/media/i2c/Makefile                    |   1 +
>  drivers/media/i2c/imx290.c                    | 845 ++++++++++++++++++
>  5 files changed, 916 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
>  create mode 100644 drivers/media/i2c/imx290.c
> 
> -- 
> 2.17.1
> 
