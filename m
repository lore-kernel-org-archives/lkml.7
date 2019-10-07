Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F67C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAD720679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFJtBjNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfJGPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:53:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42725 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfJGPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:53:10 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so29606537iod.9;
        Mon, 07 Oct 2019 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0+KKOJG+TisZYwANPRDxoGgI9F6Pi0RrxyV+mcRIhQ=;
        b=jFJtBjNcMzZT/dfV5DNd+SYdyhKORKldayK714j3ON/TvF4lEz54VZg0ohvI4G5pqF
         lAWdRi7RPMXntGegumJYq6RIQrmDTg4porBhN27Lbv7Sk/7cJgqCZaCS2KEFkh/DrEaU
         LG9AUPnMp1r3a8dLLYjdd+V1jld8BVZ4BY6JSnKVz+X5a0nXZfoiM5bwiQsJKqde/8BI
         c6rJAW38SVFX+bvt4NqsXXg8Ra1WppUYCjZnx8ruBLTXBoEM9uhU1ezFtSRJV7TsPrkG
         f5rSu/ObEDrsieCcbZrOtmnVt1Yi4ZHZt2KRd5ih6mqMcCroRAGJqtnXERea7kprkZ4t
         JJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0+KKOJG+TisZYwANPRDxoGgI9F6Pi0RrxyV+mcRIhQ=;
        b=SyqkjtRaNyBk/ZxH/yFtIw+prJM/i1k6eICvIADoz8sivbJ2O4xXmPWUY6HPm+h/kM
         jnWHe96eAmE70ZZVEEK1v2qjcxdp9FBh5Q4tZshDTDc0yZjwZF/mxqHdJpNKj3fX7UbJ
         7QC2qhst52idZQFt2+OyyotrpV5v1h275mslSEVWyubNViAyxAk74efBddVrYj5SmQ+A
         J9arjHLa3oR0PjcPdVaWgBGi6q9KwNHQGdFhiayEfxlz9IXuj1RIdbPcIcS+Y5k7apob
         pGbyPXd11ArtPPXIsgi3Z5qEBLebukzgW+8ZSQTjlAp/Aw3z1+Yo4galRaaHnyJympPK
         +Z3A==
X-Gm-Message-State: APjAAAWCPZLwABn6cLhN57LXQqV3jqAc5MgMNPejqmPGK/7csskqJy3m
        DsqqpKfIsuqSZGVc61RTQX/Yammf6OvHva/Z+TA=
X-Google-Smtp-Source: APXvYqwUmomEUUz3nspO76GFofpEr9Y5lkrzEIBCKloUqkS8g5O/eiwEu29XJ6ktN11Av8YdVnKFAgPHLckXUaGYYDE=
X-Received: by 2002:a02:245:: with SMTP id 66mr2498022jau.30.1570463588898;
 Mon, 07 Oct 2019 08:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <74ab98c7-0071-60e9-7613-56d15ad8c0ab@baylibre.com>
In-Reply-To: <74ab98c7-0071-60e9-7613-56d15ad8c0ab@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 7 Oct 2019 21:22:56 +0530
Message-ID: <CANAwSgRStPUi=naKOw+E=X-b699DnZ0Q0hYAGrUB8VKtN-fFqQ@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 7 Oct 2019 at 19:55, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 07/10/2019 15:16, Anand Moon wrote:
> > Using microSD card we cannot get the mainline kernel to boot
>
> What's the link with microSD card here ?

Well I thought that the PWM failed stop's booting further on linux kernel.
But looking into kernelcli.org it seem to be working fine, but not at my end.
[0] https://storage.kernelci.org/media/master/v5.4-rc1-82-gc0e284ccfeda/arm64/defconfig/gcc-8/lab-baylibre/boot-meson-g12b-odroid-n2.txt

>
> > using mainline u-boot it fails with below logs.
> > Build PWM_MESSON as build-in solve the issue.
> >
> > [    1.569240] meson-gx-mmc ffe05000.sd: Got CD GPIO
> > [    1.599227] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
> > [    1.600605] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
> > [    1.607166] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
> > [    1.613273] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
> > [    1.619931] hctosys: unable to open rtc device (rtc0)
> >
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Odroid N2 Schematics says "GPIOC_6 should not pulled low if GPIOC is not
> > work as SDCARD"
>
> Sorry, what's the link with the PWM build-in, and your case ?
>

Sorry I linked two issues with this commit message.

> This comment is linked to the comment in the datasheet:
> ""
> If GPIOC is not work as SDIO port, please do not pull CARD_DET(GPIOC_6) low when system booting
> up, to avoid romcode trying to boot from SD CARD.
> ""
> Seems pretty explicit for me.
>

Ok I will recheck this at my end.

> > Is their any other approch to help resolve this issue.
> >
> > Boot log failed with cold boot:
> > [0] https://pastebin.com/cEtWq2iX
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index c9a867ac32d4..72f6a7dca0d6 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -774,7 +774,7 @@ CONFIG_MPL3115=m
> >  CONFIG_PWM=y
> >  CONFIG_PWM_BCM2835=m
> >  CONFIG_PWM_CROS_EC=m
> > -CONFIG_PWM_MESON=m
> > +CONFIG_PWM_MESON=y
> >  CONFIG_PWM_RCAR=m
> >  CONFIG_PWM_ROCKCHIP=y
> >  CONFIG_PWM_SAMSUNG=y
> >
>
> For these changes without the microSD fail description in the commit log :
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks. I will rephrase this without linking the microSD card, with
better commit message.

Best Regards
-Anand
