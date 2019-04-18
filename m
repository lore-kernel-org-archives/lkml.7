Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20104C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A1214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AL/SFOvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfDRVPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:15:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36979 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfDRVPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:15:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so4398362wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IxpSWGO1Tmz/SMG8ECwGOzCKnUr/jKuNewyS3PdDbos=;
        b=AL/SFOvhcNuLWQkzWZOabeg4MbfI3CN2NNhkNqy3ebUxXWIW/pUcs9GbtfoBS+mmdv
         2r5vZtVtnmm02o27KipYTFsMq2xj9cf6/Y7sqGWy2tt3342tm+et14zDD16iOnLxQpcd
         M47H9TtGBAlvqB+7+QlLz1jJdJdPBQOiIrioXku9CU3IlC+UXCRewOIQY8Kx1TgzmQjA
         KXQBsczramf6JAMd9IKkg+JKYupm9gP1dbTy+RTrC4OF8XCwhRFij2S/wZy2nSz0bcIB
         4fpBwmOJOKP7dmxz/37qBCitlBz0YcMK/0d2KTdJXJhNCf3Opn3GA2wpFbq6QGzAsgg6
         TDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IxpSWGO1Tmz/SMG8ECwGOzCKnUr/jKuNewyS3PdDbos=;
        b=Z50YG1umOB9hure+0xzBhc+XcuHF1Eup4pL8TJx2IbLkI+EjAiEIupj2Z1P9IA+H0X
         cXGx1RM4eRz4FDgWkh3DB9qmU1q+AdGxJ2SFn4EG+MU9+4+E+Na0/vMalV/nb9IK2KFF
         0d8rC0ZjoDvNhOkXpZmDS5ER1HEc27VkbgmlvfbzijF8T8LNoU6kpHVBG2DyEmnLTvR2
         4si4XbhJHsrEqyFKmH/pJeGIG/9DFuX+eXy3H/ew9qx4+UDE2Gk9/gr/AzgbBvB/SEfF
         KoFNCV+hXYY6SKaYtnEUIQvjXNlakWThXVjRJHm7XwIakQMC0A3w0ceio9VlFXdfR+i6
         XcRg==
X-Gm-Message-State: APjAAAUAnk/vkx0iKxr3z6dGbljVeRKhpaVfjN5QZaiiJB7nZmIHcG8e
        iGjzh161N+XP3EKy9oDVEEWNww==
X-Google-Smtp-Source: APXvYqwfvXKELWltHoybPpWO9POZf6OHiTGua/h5I6onsUHELa1XfhjIcqthQ9jT02o6JqLX4H9XBA==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr215333wmc.49.1555622123598;
        Thu, 18 Apr 2019 14:15:23 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y125sm4636450wmc.39.2019.04.18.14.15.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Apr 2019 14:15:22 -0700 (PDT)
Message-ID: <5b19d32be23fbe630339fd48f93b16e9301385d1.camel@baylibre.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Apr 2019 23:15:21 +0200
In-Reply-To: <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
         <20190417204355.469-6-jbrunet@baylibre.com>
         <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
         <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
         <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-18 at 22:53 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Thu, Apr 18, 2019 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > > 
> > > On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > Activating DDR in the Amlogic mmc controller, among other things, will
> > > > divide the output clock by 2. So by activating it with clock on, we are
> > > > creating a glitch on the output.
> > > > 
> > > > Instead, let's deal with DDR when the clock output is off, when setting
> > > > the clock.
> > > > 
> > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.
> > 
> > The error I see in your logs is with eMMC and hs200, not SD card.
> sorry, I should have been more clear that there are two errors:
> eMMC, this is what I have been seeing for a while on my Khadas VIM2
> (it's probably not related to this patch):
>   mmc1: mmc_select_hs200 failed, error -84
>   mmc1: error -84 whilst initialising MMC card

Following patches were also supposed to help the vim2. 
... something I tested numerous time on this particular board.

> 
> however, then there's this other error:
>   print_req_error: I/O error, dev mmcblk0, sector 0 flags 0
>   Buffer I/O error on dev mmcblk0, logical block 0, async page read
> as result of this the partition table cannot be read and my kernel
> cannot find the rootfs.

I don't know what the problem is (probably some CRC error - you can check the log
in interrupt for this) but I'm pretty sure it is not related to this patch.

I see in the log SD is indeed in HS mode, so not in any DDR mode.
I also see that the SDIO fails as well. There something really weird, which can't
be explained by this patch alone AFAICT.

> 
> > Either way, There is something I don't really get. eMMC should not go through
> > any DDR mode to reach HS200 (which is an SDR mode), neither should SD to reach
> > HS.
> > 
> > All this does is flipping the DDR bit (when necessary) when clock if off for
> > the mmc device, avoiding a glitch on clk line.
> > 
> > This patch should not make any difference for SDR only setup, Maybe I missed
> > something, but I don't see how it could make anything different for SDR only.
> > 
> > I (repeatedly) tested both vim1 and vim2, without seeing this issue, so I can't
> > debug this. I'll need more detail to progress, something does not make sense here.
> please let me know from which part of the driver do you want debug logs
> 
> 
> Regards
> Martin


