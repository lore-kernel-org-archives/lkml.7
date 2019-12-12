Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B34C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C12067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkqrboVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfLLPIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:08:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41565 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfLLPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:08:02 -0500
Received: by mail-vs1-f67.google.com with SMTP id f8so1767551vsq.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zbYuLohJ6uz9IV3uB+nuAd8APjXTFVTSFGSirgS84Fw=;
        b=pkqrboVtNyI5GfSeksmn9z5PnU5TgHPwW8EtQ28nj33hzudbVH9SuoYaMsPTPRIgK5
         Eqp/3oIW6uUE4++T9Mj7TzjbQVgb7UC+hw4/pxWH8PYZ5u0kbc6O8eVmn//rz5aTQjKV
         LvnklEtIK4gpufnMuZelStusOrqeQFUhrVcDtUa2c5qB/zC2el+WhNR1eOvWGcC9SION
         Hk0ue7RAmyWIELLCOGkDVdtEF4DVFtZUBK5v2mxCV3MXD6tPUmvejYAdc7Q4wp3f42D3
         a3nwTSWD+upAi+wOj1E3pl5atpf7VUwWRmypPWUiCHH8mQFqEOqg/0K5HZcYFxqA92a2
         4XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zbYuLohJ6uz9IV3uB+nuAd8APjXTFVTSFGSirgS84Fw=;
        b=KY3jO7GbsdvheFD103eao24mRlj3lG0y2QhRl0FkDX3aLSBik2D6a4SmJx7BLsAmlJ
         AIWuxovNcuDeBUJbAyagoWSnBMIFj2DNGcndaoU1564eUixs7GdYpqNYvwVkKIGd68O8
         bjxeEr21izokGsmOnrZGKHeBLGAK+PQzzq2TX7SbwkpNHSKGVOfiS+qlodhneoKZwI54
         wlTZ9t0xee/rlnQad7KJokZ4nF6o/j17a8n9+xWEnpsDaZHjxWedwIwpKpTV6tNIvwna
         NkfJV75uvrrh77Nh4nfWMMWN70FVByPwrVpanCftRRbnN/ogePm4sF87atVPPwNqD7Qd
         FKpg==
X-Gm-Message-State: APjAAAUZOUYz+urlWlsne3OQJHGvPqTiAdn3ir8GBKeSqWIck6GXJ2dX
        QuZeu0pBuWnpbIt0WiVmtKoeY8bd1fsfLi5AQgKShQ==
X-Google-Smtp-Source: APXvYqw8Cxw8goN18pz+XIVG0ArSx5rkSvWM5IzHtNml4ttcHm9tifgGxLAx++YkwezG41U68dvM6EO/SuWVRkgPtZ0=
X-Received: by 2002:a67:b649:: with SMTP id e9mr7320111vsm.34.1576163280703;
 Thu, 12 Dec 2019 07:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20191210014011.21987-1-digetx@gmail.com> <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
 <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com> <CAPDyKFpWO_McZEoefX1T=SE=RYm_GU3S+LgYZrgJY_SJgv7egA@mail.gmail.com>
 <44f99e56-468e-c3f9-3785-73c2cf8ba118@gmail.com> <d4933cb1-d2c1-8055-e0f4-f6fcbe9973bc@gmail.com>
In-Reply-To: <d4933cb1-d2c1-8055-e0f4-f6fcbe9973bc@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Dec 2019 16:07:24 +0100
Message-ID: <CAPDyKFq26Wcd9f3VJ1afxv9TVDJQu4wi+yLS-4Pi1bYnFLyWsg@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 at 15:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 11.12.2019 19:29, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 11.12.2019 19:10, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> On Wed, 11 Dec 2019 at 16:46, Dmitry Osipenko <digetx@gmail.com> wrote=
:
> >>>
> >>> Hello Ulf,
> >>>
> >>> 11.12.2019 11:11, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On Tue, 10 Dec 2019 at 02:40, Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >>>>>
> >>>>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are a=
ffected
> >>>>> by a problem where WiFi chip reports CCCR v1.10, while it should v1=
.20.
> >>>>> In a result high-speed mode isn't enabled for the WiFi card and thi=
s
> >>>>> results in a malfunctioning SDIO communication.
> >>>>
> >>>> Does that also mean SDIO_SPEED_SHS bit is set when reading SDIO_CCCR=
_SPEED?
> >>>
> >>> Yes, the SDIO_SPEED_SHS bit is set.
> >>>
> >>>>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 fai=
led: -84
> >>>>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send =
NAK
> >>>>>
> >>>>> Downstream kernels are overriding card's CCCR info in SDHCI driver =
to fix
> >>>>> the problem, let's do the same in upstream.
> >>>>>
> >>>>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC dr=
iver,
> >>>>> which overrides card's info for the TI wl1251 WiFi.
> >>>>
> >>>> This is a temporary solution and should be replaced by doing the DT
> >>>> parsing during
> >>>>
> >>>> So, yes, let's see if we can use a card quirk instead. That's the fi=
rst option.
> >>>>
> >>>> A second option is simply to parse the DT subnode for a new DT
> >>>> property during mmc_sdio_init_card(). Along the lines of what we do
> >>>> for the broken-hpi DT binding for eMMC.
> >>>
> >>> Let's try the first option. My understanding is that the problem affe=
cts
> >>> only the specific model of the WiFi chip and it's not a board-specifi=
c
> >>> problem. I'll add Broadcom driver people to CC for the next version o=
f
> >>> the patch, maybe they'll have something to say.
> >>
> >> Okay, sounds reasonable. By looking at your latest attempt for a fix,
> >> I have two minor nitpicks, otherwise it looks good.
> >>
> >> The nitpicks:
> >> I suggest to rename MMC_QUIRK_HIGH_SPEED_CARD to MMC_QUIRK_HIGH_SPEED
> >> and mmc_card_need_high_speed_toggle() to mmc_card_quirk_hs().
> >
> > I'll take it into account, thanks.
>
> Looks like I managed to figure out what's really going on:
>
>   1. The BCM4329 doc clearly states that High Speed is supported, see
> page 49 (Section 11: WLAN Interfaces, SDIO v1.2)
>
> https://www.cypress.com/file/298626/download
>
>   2. I googled for performance results of the BCM4329 SDIO WiFi and came
> to a conclusion that ~40 Mbit/s is a realistic maximum of the WiFi-data
> throughput for NVIDIA Tegra20 boards due to antenna configuration
> limitations and whatever.

Okay.

>
>   3. The Tegra's SDHCI clock is pre-configured to 48MHz at the time of
> kernel's boot-up.
>
>   4. IIUC, the maximum clock rate for the legacy SD signaling mode is
> ~25MHz and that is more than enough for a 4-lane SDIO data-bus that
> allows up to 100 Mbit/s for the WiFi which is capped to 40 Mbit/s anyways=
.

Yes, I see.

>
>   5. Apparently MMC core doesn't limit the clock rate for the Normal
> Speed cards.

It should, else it's a bug (I would be really surprised if that's the
case, but who knows).

>
>
> So, I added "max-frequency =3D <25000000>;" to the SDHCI node of the
> board's device-tree and ta-da! WiFi works absolutely fine without the
> quirk! Thus the SDIO card quirk isn't really needed and I'm dropping it
> for now.
>
> Ulf, do you know if it's a bug or a feature of the MMC core that it
> doesn't limit clock rate for the Normal Speed cards?

It should limit the speed, else it's a bug. Can you perhaps check what
the requested clock rate is via some debug prints in the host ops
->set_ios()? And also what the real rate becomes after dividers.

If it's not a bug in the core, I suspect that there may be generic
problem dealing with initialization frequencies for sdhci-tegra.

For example, mmc_rescan_try_freq() tries to initialize the SDIO card
at 400KHz, then 300, then 200 then 100 (in that order, and note
*KHz*). When a frequency is successful, initialization continues and
later on the clock rate should be increased to 25MHz, for legacy speed
mode.

Kind regards
Uffe
