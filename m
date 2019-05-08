Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB7214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uq0eTtmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfEHGVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:21:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39835 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfEHGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:21:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id v10so277049wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IxpIywyLKQBnJeFERaRsNuyr6beLjjROmJrDYYr4g80=;
        b=Uq0eTtmA4eAMi7pwAP0IBF51d9+0w5gjracj4O2wrlOaxlYKkfto+tyvFnPPYn8UH+
         6pqY34zhG9mGKUvWEGN2DaVGCbSL6AEr5HUYM0Ho0V4fPa2UlpPQR+/tdCmv3zON2yt9
         50M5ei7sD16bcZsKeLUYARwjTAZgXv+H6GE67mhrhmkPnNh1H0mZ3Jhu4uGmKn6w6fBc
         5xjMmXFXANUGsJsDDVekvbbi23GdXc4rrzOSuBf1OT3yeqLEkw+amfTESikjKiIMTaLv
         GaipL8vkJR71CUfX4HtWjDEoeUGiRo6je3bH5Q9701WJisQZDJl+jDbaB/VJPMERVN12
         dNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IxpIywyLKQBnJeFERaRsNuyr6beLjjROmJrDYYr4g80=;
        b=WnRfmTJlPYwuoxy0eiTbk0Mi/d2WxxOJl/wVay+XDnJDiPm39ssNZQtQC+hEYyR4r1
         yrvQuuERUg8RJFv9cUwU1Wx6NB4SCngN/vCIvetXTo1pPls/2cYJLE3PqpkvcnzmBcWt
         8f5OH6wpjqEdfD8ixh8A1pzepP6pma+wu+4bG5rIV6g6/QTXL3lmhjhxngBxkxpbyy4h
         wZ53hsYmI20cD/onm9ejO7X6kYCS3dRZw/HisuagAReXlwksGY2S0npXDA8qtTMZ97zH
         xUepXOjVfqxPkd7HSNHb0FNOlWTfHzhOhASmETXQyEABSUziPvP79vWHBqZVrrcxo5ZL
         X3gA==
X-Gm-Message-State: APjAAAW01H/No1LL6uD/KNRvnyz86qAdRNwCRVyS1sqqArdGnD1rRbac
        4jCabuoZPImisDncX32j7+RZXOxRhVQ=
X-Google-Smtp-Source: APXvYqxqJRUTmdCNQIUkExSABPDRdpSRp4eRvCnOlO4H0Yz3b2gIgBZuWvldFknjK1OFyJ1FvIEokA==
X-Received: by 2002:adf:8068:: with SMTP id 95mr24762121wrk.174.1557296467607;
        Tue, 07 May 2019 23:21:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d17sm2764602wrw.73.2019.05.07.23.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 23:21:06 -0700 (PDT)
Date:   Wed, 8 May 2019 07:21:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] LMU Common code intro
Message-ID: <20190508062104.GC7627@dell>
References: <20190430191730.19450-1-dmurphy@ti.com>
 <34088323-9b40-7dea-5449-6a01bb721c00@gmail.com>
 <8166c0c1-facf-14da-7c71-5bc5a3cc23f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8166c0c1-facf-14da-7c71-5bc5a3cc23f7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 May 2019, Jacek Anaszewski wrote:

> Ekhm, I forgot to add the main recipient.
> 
> Adding Lee.
> 
> On 5/1/19 12:05 AM, Jacek Anaszewski wrote:
> > Hi Lee,
> > 
> > This patch set has dependency on the previous one for lm3532, which
> > also touches ti-lmu.txt bindings, and for which I already created
> > immutable branch. Now if I created another immutable branch for
> > this patch set we would have to resolve conflicts between the two,
> > as they would both be based on 5.1-rc1. Adds much overhead and
> > is error prone. Therefore I propose to apply this patch set on
> > top of my merge of LED tree with the immutable branch for lm3532.
> > 
> > Please let me know if you see it differently. I'll wait for your
> > response until Friday, and then proceed with the above as I think
> > it should be harmless for MFD.

Looks like this set wasn't sent until -rc6 which is when I normally
stop applying significant patches.  I think it's best that we wait
until the next rotation.  That way all this dependency related
hoop-jumping just goes away.

> > On 4/30/19 9:17 PM, Dan Murphy wrote:
> > > Hello
> > > 
> > > I have added the Reviewed-by for dt bindings as well as made the
> > > Kconfig change
> > > pointed out for the common code flag
> > > 
> > > Dan
> > > 
> > > Dan Murphy (7):
> > >    dt-bindings: mfd: LMU: Fix lm3632 dt binding example
> > >    dt-bindings: mfd: LMU: Add the ramp up/down property
> > >    dt-bindings: mfd: LMU: Add ti,brightness-resolution
> > >    leds: TI LMU: Add common code for TI LMU devices
> > >    dt-bindings: ti-lmu: Modify dt bindings for the LM3697
> > >    mfd: ti-lmu: Remove support for LM3697
> > >    leds: lm3697: Introduce the lm3697 driver
> > > 
> > >   .../devicetree/bindings/leds/leds-lm3697.txt  |  73 ++++
> > >   .../devicetree/bindings/mfd/ti-lmu.txt        |  56 ++-
> > >   drivers/leds/Kconfig                          |  15 +
> > >   drivers/leds/Makefile                         |   2 +
> > >   drivers/leds/leds-lm3697.c                    | 395 ++++++++++++++++++
> > >   drivers/leds/ti-lmu-led-common.c              | 155 +++++++
> > >   drivers/mfd/Kconfig                           |   2 +-
> > >   drivers/mfd/ti-lmu.c                          |  17 -
> > >   include/linux/mfd/ti-lmu-register.h           |  44 --
> > >   include/linux/mfd/ti-lmu.h                    |   1 -
> > >   include/linux/ti-lmu-led-common.h             |  47 +++
> > >   11 files changed, 712 insertions(+), 95 deletions(-)
> > >   create mode 100644
> > > Documentation/devicetree/bindings/leds/leds-lm3697.txt
> > >   create mode 100644 drivers/leds/leds-lm3697.c
> > >   create mode 100644 drivers/leds/ti-lmu-led-common.c
> > >   create mode 100644 include/linux/ti-lmu-led-common.h
> > > 
> > 
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
