Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E8C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0730B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP3G1VGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfIJLjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:39:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfIJLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:39:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so14798014wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxMynZw2F7Q544maYoP/CgIIEkMi90NAQ2LdnqF+ByE=;
        b=PP3G1VGp5vvb8+v3qhss/sZ8dRo2B7iDpAFhzvLaFAGTodqeiFl2dp0M3y35k/WrZC
         Bjz/XwLZxSJJ1wP3rVVqUOimycZg9BXErFrX8eq/Mu+yjMGZ9iOlv7ZJA0qDRr0EZBIj
         Ywt2Z0QlyMyRc2eHuLdiiowoAcjzP1yDIKSOPcB1L7jMBcQPgPy4KaGD64ZoijBbaMCm
         ojHbXSRGQjlFOwvjXkYZEpJTxtHa8zx54fqvw5n+lTxKtBjJyrhUaNvlfA2GKYXomTRJ
         pyva6P6BvmuyId2mj0sdIDvk0ZBfWERjsFryms9TD2cY+76DUv37b+YdNWUv2n2RpXvS
         F5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxMynZw2F7Q544maYoP/CgIIEkMi90NAQ2LdnqF+ByE=;
        b=f0afgInwVpgghf1FVaRci81VCH2WRqqUtQbDE0RJ/l8L6GJrw59Slv7yoa+O9+1xkR
         DkcTmAna4Ehajgil5CBQTCoOYPaFWD7ixkvxazeOwD9BDoxoLcWWCsWDgftvKbyY/XyG
         YvIGTucsgwUEvHqmw9os9yePHgMTncaWAM450EwTvMblrTX8eKwAint+WQ/MaHcTW8ff
         Ji+w7hA0tM1ty6f7e05Fs2oR7W3H3FcWeiyr3mVH3aokfDIR9sE9J2hoKzsKoqe04cUs
         RYg6Ktg3jAmU0KPUdjfpNOct/1MYa+HlXMBGkjI8Mcb+Sq77Stmruj8oVcohouJFhRuL
         nt+w==
X-Gm-Message-State: APjAAAWWqGA+K/UMGvqv0YYDLj7dEPXvO4Tc0bVYuKySh7RqKJ6GkfIv
        Lk8njn583Fm8YgqKMQbFzvmEcw==
X-Google-Smtp-Source: APXvYqyk3I+kSou33suv8fQxHSSiTS7dJTAZIL43yKwUZQ8eakcf/Ter2j5rrM4u/z/RW0qKVc9aww==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr24912506wrx.156.1568115574148;
        Tue, 10 Sep 2019 04:39:34 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a190sm3861146wme.8.2019.09.10.04.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:39:33 -0700 (PDT)
Date:   Tue, 10 Sep 2019 12:39:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dridevel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v5 4/4] backlight: add led-backlight driver
Message-ID: <20190910113931.4epumos2yaublv2t@holly.lan>
References: <20190910105946.23057-1-jjhiblot@ti.com>
 <20190910105946.23057-5-jjhiblot@ti.com>
 <20190910112622.iflmknh5qplbfoyu@holly.lan>
 <8c80495a-440e-05c6-22c8-cf05d4f6b611@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c80495a-440e-05c6-22c8-cf05d4f6b611@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 01:38:18PM +0200, Jean-Jacques Hiblot wrote:
> 
> On 10/09/2019 13:26, Daniel Thompson wrote:
> > 
> > >   endmenu
> > > diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> > > index 63c507c07437..2a67642966a5 100644
> > > --- a/drivers/video/backlight/Makefile
> > > +++ b/drivers/video/backlight/Makefile
> > > @@ -57,3 +57,4 @@ obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
> > >   obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
> > >   obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
> > >   obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
> > > +obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
> > > diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> > > new file mode 100644
> > > index 000000000000..a72456e11fb9
> > > --- /dev/null
> > > +++ b/drivers/video/backlight/led_bl.c
> > > @@ -0,0 +1,264 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
> > > + * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > + *
> > > + * Based on pwm_bl.c
> > > + */
> > > +
> > > +#include <linux/backlight.h>
> > > +#include <linux/gpio/consumer.h>
> > Maybe this is a nitpick but it is one I have now raised three times and
> > I don't recall any response, what symbols from this header are used in
> > this file?
> > 
> > AFAICT everything defined in this header includes the string "gpio" and
> > that string doesn't appear anywhere in the file (except this line).
> > 
> > 
> > > +#include <linux/leds.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > Come to think of it, are you sure you need this include? devm_kzalloc()
> > doesn't comes from this file.
> > 
> > 
> > > +#define BKL_FULL_BRIGHTNESS 255
> > This is unused. Please remove.
> > 
> > 
> > Other than that, looks good!
> 
> Thanks for the quick review. I forgot to cleanup the headers. I'll fix that
> now

I felt I owed it to this patch series after my performance so far this
dev cycle!


Daniel.
