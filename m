Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6ECC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01246218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLakc87r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGYVhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:37:20 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:44094 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfGYVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:37:18 -0400
Received: by mail-vs1-f41.google.com with SMTP id v129so34702549vsb.11;
        Thu, 25 Jul 2019 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTd7Gz7s5jeydJlwaOBlP9FrkJ567NK9DmXJEKGyG6M=;
        b=sLakc87rb4hOGU1OSbrdA/rxHkU9VGvNHdokH17C0h+S/MM4VZc22b26ghLIFXfFqF
         de2J6+4XQ/o0MCoT1uWQ6MX03H3gRKcPVqpJNZdeiw4/Q52YetknhBxXemjFBbGHRhCj
         aomsoPv7lp/6pQGfHThsX8QT/eGb/1SfmjxYxJS/8JXEefNPaUrvDJvRHNtFeuLwvnd3
         if4beGnXXlchmVW/GPpaYGwYW2IKBnzu7mM6C194XzIh+sg6NIxslUy8O58cI5macwJN
         x4zhKLVJDz657AjIgfXPFqq0+4X8q6lnyOKRAB9+VazOaJX/nal9r3X6UJ1yZn07OVor
         9a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTd7Gz7s5jeydJlwaOBlP9FrkJ567NK9DmXJEKGyG6M=;
        b=toPmCzCZRAKUr0Df5ibVzcQJVPAH+zVJlsFQtEt5FyySDUdzQIW3RkKW6qUr3oiaqH
         BLb7/+nVxnCQqKm68yOhC5mXMIXWfdLtrF8G+4Jr6bNbhbRLEOSErK+oIOyyQa4AQV0M
         /dTMdT8GTbMps4UNB7tHLlnfKXpyQNa08l9f0Z/rF31ubUW4soWlGzQNi+DAlhcOL2wa
         gy6DNx+CiOTbwTXcQqC7+NDdIe+9DKXslZxsEp28GJ0FblPKYPw0zLgX8zJaMPWSSehe
         U3fsCtDJI66uTMJeK6b27JxRmpVrI4M5milfjjUtg/0ZTWZEsEAjP2f9T1Qb9l7kcBnp
         iDwA==
X-Gm-Message-State: APjAAAWoEpb6bUzIig+LS+xZgTPLXOJYjGejsSluLI8P9wNGMz/bPiRc
        J9nDlX7pkcdKjch1czU6fUgU/uiaEicylH720Gc3kQ==
X-Google-Smtp-Source: APXvYqz3a02ATq/pR9r7nMgVe4KmjnjpMVrJmVLsq5f/GDIc7uwqG508wbsHkpB2z864qpcXIi3M0dFsAqAN7UUavVg=
X-Received: by 2002:a67:edcf:: with SMTP id e15mr57616507vsp.75.1564090636593;
 Thu, 25 Jul 2019 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
 <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com> <CAOGqxeVR3XzAQ-yTH35hyT3KpL11nTwMY1Ca96ZW=K=PiWMnHA@mail.gmail.com>
 <23ce5519-cb4b-4d85-4bfc-3e438212ec7f@intel.com>
In-Reply-To: <23ce5519-cb4b-4d85-4bfc-3e438212ec7f@intel.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Thu, 25 Jul 2019 17:37:47 -0400
Message-ID: <CAOGqxeVjj9Leok-Oph-kNA92fKhdBHzwJZ643uND8GV_8VaHCw@mail.gmail.com>
Subject: Re: Issue with sequence to switch to HS400
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's an even better solution and it gets my HS400 mode working.
Will you add this change or should I?

Thanks
Al

On Thu, Jul 25, 2019 at 3:33 AM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 23/07/19 3:34 PM, Alan Cooper wrote:
> > On Tue, Jul 23, 2019 at 1:21 AM Adrian Hunter <adrian.hunter@intel.com>=
 wrote:
> >>
> >> On 23/07/19 1:31 AM, Alan Cooper wrote:
> >>> I'm having a problem with a new SD/MMC controller and PHY in our
> >>> latest SoC's. The issue I'm seeing is that I can't switch into HS400
> >>> mode. This looks like something the driver is doing that doesn't meet
> >>> the JEDEC spec. In the "HS400 timing mode selection" section of the
> >>> JEDEC spec , in step 7 it states:
> >>>
> >>> 7) Set the =E2=80=9CTiming Interface=E2=80=9D parameter in the HS_TIM=
ING [185] field
> >>> of the Extended CSD register to 0x1 to switch to High Speed mode and
> >>> then set the clock frequency to a value not greater than 52 MHz.
> >>>
> >>> In the function mmc_select_hs400() in mmc.c, I see that a switch
> >>> command is done to set the eMMC device to HS mode and then
> >>> mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
> >>> controller to HS mode. The problem is that the "SD Host Controller
> >>> Standard Specification" states that "UHS Mode Select" field of the
> >>> "Host Control 2 Register" controls the mode when the "1.8V Signaling
> >>> Enable" bit in the same register is set, so mmc_set_timing() is
> >>> actually leaving the controller in SDR12 mode and mmc_select_hs400()
> >>> will then set the clock to 52MHz. This causes our PHY to detect an
> >>> illegal combination and return an error.
> >>>
> >>> I think the easiest fix would be to change mmc_set_timing(card->host,
> >>> MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
> >>> MMC_TIMING_UHS_SDR25). The other possibility would be to change
> >>> mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
> >>> I'll submit a patch based on the feedback I get.
> >>
> >> eMMC is governed by JEDEC specs not SD specs.
> >
> > My understanding is that JEDEC does not have a host controller spec so
> > this driver uses the "SD Host Controller Standard Specification".
>
> There is no spec for using eMMC with SDHCI.
>
> >
> >>
> >> Please consider making a change in your driver instead.  For example, =
hook
> >> ->set_ios() and if 1.8V is enabled and timing is set to MMC_TIMING_MMC=
_HS
> >> then change it to MMC_TIMING_UHS_SDR25.
> >
> > That's an easy fix, but it still leaves all other drivers/systems
> > temporarily using SDR12 at 52MHz during the switch to HS400.
>
> Yes, I changed my mind.  Does this work:
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 59acf8e3331e..f9d241458dcd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1849,7 +1849,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *hos=
t, unsigned timing)
>                 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104;
>         else if (timing =3D=3D MMC_TIMING_UHS_SDR12)
>                 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
> -       else if (timing =3D=3D MMC_TIMING_UHS_SDR25)
> +       else if (timing =3D=3D MMC_TIMING_SD_HS ||
> +                timing =3D=3D MMC_TIMING_MMC_HS ||
> +                timing =3D=3D MMC_TIMING_UHS_SDR25)
>                 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
>         else if (timing =3D=3D MMC_TIMING_UHS_SDR50)
>                 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50;
