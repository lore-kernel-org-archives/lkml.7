Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12424C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA751206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEFcVJVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfHMHUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:20:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33170 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:20:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so106870311wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jh+u0/5C9sC+jh4TIlKIxaJHuXDdftZDgr4L90RCuIA=;
        b=hEFcVJVzbO+JRAcIntpp/zkyNlS7/GvdeEjrweS18w0t6brHWY49x4M06TnFdZSwxW
         GGaQNP7MUgT/naNeXacrDjPlReBWjvfVLRj+jwnfOSnzi0OUNk5l34AoZpS5DnvuLpDl
         7cNl0BEt+sVJKtQ+LT++mw33Dm284lEGuMdRBBrFKcyC4hjm0k0kVy/4G26aCy6Fo+oY
         uRsQzWvgL5XujoH7taBtmR3FwWDy8klSb77UV1u2YiYIN/RaktD6HE0sLCjVhZ3gWcxT
         6MHB9kBjCkdbPzg7uohM0ruCkgjKBGkq74L2O7ondbwMC4ypfOyxsU8N6t9D74MVit5m
         sEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jh+u0/5C9sC+jh4TIlKIxaJHuXDdftZDgr4L90RCuIA=;
        b=C6QsPWobioSu0cTX/oFtZPjCl0DFfN9WTkmTd4IxOsvVZK2ed0Wnkg4wVZDQtf0iBQ
         p6B8OBjS+7/xF0t+4dIrj76bHgOkV2OEUIhI46eOaWr6AzNWS/R9zAqXsIKH6OVw8TZV
         Bq2wb2NIiNGei9BKgNJA97YvMqL7GHkuQkbfGht6LSIgIfEtWXk9yPiMZCSTsAA/3D/i
         qBJvYh77lKNzM7HriclsCjZs3w11wE7tLiA8CFVHSokE3jlEOnuV/Xqu/9izs8hoh+1U
         Qf3vtRYOlQvaHqjEo5C9FeJpGcAqxCJIIeStz9bOLPfxlG5ibw60YhuFKEK3OB1Qje64
         spng==
X-Gm-Message-State: APjAAAUAtsmPTMS9npCgr+9xnzqFv4cCtY+UTOgWo6mqlaHXR51Nv5X2
        lYcL59az8CMJFgh3+OTeGtTYsw==
X-Google-Smtp-Source: APXvYqwQjf7fTO6Udq8hrYKQOuwTwlMrSM8lymQq+3WwhEOVys4N9qu95PdOanYcKCvd51L3ufdJRQ==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr38762652wrr.105.1565680821103;
        Tue, 13 Aug 2019 00:20:21 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id k1sm14475486wru.49.2019.08.13.00.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 00:20:20 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:20:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: [PATCH v5 03/10] rtc: mt6397: move some common definitions into
 rtc.h
Message-ID: <20190813072018.GZ26727@dell>
References: <20190812121511.4169-1-frank-w@public-files.de>
 <20190812121511.4169-4-frank-w@public-files.de>
 <20190812151128.GV26727@dell>
 <20190812153856.GR3600@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812153856.GR3600@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Alexandre Belloni wrote:

> On 12/08/2019 16:11:29+0100, Lee Jones wrote:
> > On Mon, 12 Aug 2019, Frank Wunderlich wrote:
> > 
> > > From: Josef Friedl <josef.friedl@speed.at>
> > > 
> > > move code to separate header-file to reuse definitions later
> > > in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)
> > > 
> > > Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> > > Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > > changes since v4: none
> > > changes since v3: none
> > > changes since v2: add missing commit-message
> > > ---
> > >  drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
> > >  include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++
> > 
> > include/linux/rtc/mt6397.h?
> > 
> 
> It's just a bunch of registers and bit definitions so it may as well
> stay close to include/linux/mfd/mt6397/registers.h

Sure.  It was a weak preference.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
