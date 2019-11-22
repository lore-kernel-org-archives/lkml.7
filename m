Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C565C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E36120659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxYWwUP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKVIDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:03:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40864 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKVIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:03:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so6466722wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 00:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wLk0BE1aSH237G1Tgw7p3vnCgrKdLIQM6QZZXQiln7g=;
        b=hxYWwUP6wOFR26zWqxYs5WFOVBGRnEVef33z2GPbRcJmmH/nBDWAZcqf4FLeMNmq8G
         aZ0fVbPIg7PAxY/P8KnUQl4JoTObnIdJCfUKDoli06/HsgAdyIaS3Lk5CZSQCnpwADCl
         +/182xN/e7cz+XpvSlFGZOuROwLHG69i0OgL4hpqISlKCCQGcRzs4z2zBKunma+YdYGb
         x/FTsT2/Ol9K4CWI6VIqnC7Ul5JpTbqFdZ42pdTZ1mwYhbrAs43s4/qVZhlRe3mWUU7f
         fy0831/MXxv4aFGFhI6lIi33/fGbBn8Y1qZ3/oNlZ9uihrKBMac66AlRTTSDMIdEDzAq
         PZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wLk0BE1aSH237G1Tgw7p3vnCgrKdLIQM6QZZXQiln7g=;
        b=af/6QS6FMekfOW9uG//I0lPvCoNX4GQtWT/qMc58VKCW2JHPB1Sc7lhvV9dgy+OQmo
         SdIVOj/rAp4Lf8caR/U3QSqnoL6ZbRakSprf9XxD1hS7v1rLfREhFlQxG03icvPV68sh
         vcZMBfnBC7u8r3EVgsbNxxgAKIoDEuVDyobn7MQrBT96b4/nKiLV2NtzEQvELaQIE6uJ
         n5+eKR+X0zdOB5iUxhqdDVPVDCtjd6mrcVsV24rOw35gB9ECz/7uG8xiu+UL+ftcLxhE
         EVzc1aqHuq3kSQZeNnWVSNSpQlfuMmVlHnklwpMpTp418JEMbGvmY9g+i4NiTEwslXGm
         G/rw==
X-Gm-Message-State: APjAAAU/6p6ausiycZUgH1RZdAcMwC4xoFYAdWBWysuDBWTvGzqXJQLx
        DkZp3kygMrx5jZXTxqole7kJwg==
X-Google-Smtp-Source: APXvYqyJnlc5v/98AYWZ2lSJElTmJ/mbF3TcgCfwtCd5vflxc+Gk01/GEfr7YpUpdHZWT7FXsEym/A==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr130691wmk.114.1574409813548;
        Fri, 22 Nov 2019 00:03:33 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id j7sm7082427wro.54.2019.11.22.00.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 00:03:32 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:03:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>, Akshu.Agrawal@amd.com,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert
 i2c tunnel to MFD Cell
Message-ID: <20191122080319.GC3296@dell>
References: <20191121211053.48861-1-rrangel@chromium.org>
 <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Guenter Roeck wrote:

> On Thu, Nov 21, 2019 at 1:11 PM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> > possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> > has finished initializing and setting the drvdata. This would cause a
> > NULL pointer panic.
> >
> > Converting this driver over to an MFD solves the problem and aligns with
> > where the cros_ec is going.
> >
> 
> I thought the mfd maintainer objects to the use of the mfd API outside
> drivers/mfd. Did that change recently ?

It hasn't changed, although I don't see that here?

> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > You can now see the device node lives under the mfd device.
> >
> > $ find /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/ -iname firmware_node -exec ls -l '{}' \;
> > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/i2c-9/firmware_node -> ../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.auto/i2c-9/i2c-10EC5682:00/firmware_node -> ../../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00/10EC5682:00
> >
> >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++----------------
> >  drivers/mfd/cros_ec_dev.c               | 19 +++++++++++++
> >  2 files changed, 32 insertions(+), 23 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
