Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B54CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A10208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JQnCETd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE1PwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:52:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36279 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:52:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id 94so8124873uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wS8hoqDHHdUU+aVRiUjUMRbeoVex4X+b9To5bYeyjZ8=;
        b=JQnCETd2IGwTVEqh1W9deTB9fYhcQJX6SMUGhSDGjkZYZLhB0pKmx6lNWyqBBg4T3k
         YnYqFvYU1x9cmheUMM9BwRitTXwwaV9CqogdqQxH/UUbtvQx/7yZoICE1RcfqiQFYjjc
         SM3QyVkgaOPA7sDG30y2oiu2Ruha/g0sxwzKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wS8hoqDHHdUU+aVRiUjUMRbeoVex4X+b9To5bYeyjZ8=;
        b=ZgUJLc4jaZlWdp1Orj+orjQzEp0WAaSsEP5gs7/98BtaElgvcL1Fv4Z+nVZUMGCC/Z
         Cx3FdAJz1+EvGW+scGzzt5sA43rxZIfLr4EqMfjfBslLE08dmwhUr01prbMoOCrhER7w
         OyznPWdp2/4Ppq6h6NIF2uNCoY35XcFStz8+KmFtfkhKghu6wxyttsij/VRbfUjxNk5Y
         8Da94cXsDtEmRkx4FAN62fUOySiDIfCyuS15QkIFxiWANw0H/VrbK2RFX2YKFIEBcntb
         2QoYXQhdYKoDmecopMGouUCbYITiIC8VMSf95qmdddqnrnvRu6QWlJZTGM/3wifQwooI
         JecA==
X-Gm-Message-State: APjAAAWbWdJUe3qYCwpuCh69kQJpflZRHdI6l3HM2O7mqMcuUdf9PlIG
        +yTDDM5awk11qae3Bw8xF2xGWoUNyxc=
X-Google-Smtp-Source: APXvYqwK6vbr07wUO4ZFmPeLWsyKpBIvCEdA4m5RSLJ1LNAyEYtxpFMdhggZrPnpxtFDF8S7z+R0gw==
X-Received: by 2002:a9f:37c8:: with SMTP id q66mr836643uaq.119.1559058729894;
        Tue, 28 May 2019 08:52:09 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id s78sm6513302vke.1.2019.05.28.08.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:52:08 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id c24so464297vsp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:52:05 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr57926194vso.87.1559058725303;
 Tue, 28 May 2019 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-2-dianders@chromium.org> <20190528121833.7D3A460A00@smtp.codeaurora.org>
In-Reply-To: <20190528121833.7D3A460A00@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 May 2019 08:51:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
Message-ID: <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for
 BRCM 4354
To:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com, Double Lo <double.lo@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 5:18 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
> > sdio_aos") we disabled something called "command decode in sdio_aos"
> > for a whole bunch of Broadcom SDIO WiFi parts.
> >
> > After that patch landed I find that my kernel log on
> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
> >   brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> >
> > This seems to happen every time the Broadcom WiFi transitions out of
> > sleep mode.  Reverting the part of the commit that affects the WiFi on
> > my boards fixes the problem for me, so that's what this patch does.
> >
> > Note that, in general, the justification in the original commit seemed
> > a little weak.  It looked like someone was testing on a SD card
> > controller that would sometimes die if there were CRC errors on the
> > bus.  This used to happen back in early days of dw_mmc (the controller
> > on my boards), but we fixed it.  Disabling a feature on all boards
> > just because one SD card controller is broken seems bad.  ...so
> > instead of just this patch possibly the right thing to do is to fully
> > revert the original commit.
> >
> > Fixes: 29f6589140a1 ("brcmfmac: disable command decode in sdio_aos")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I don't see patch 2 in patchwork and I assume discussion continues.

Apologies.  I made sure to CC you individually on all the patches but
didn't think about the fact that you use patchwork to manage and so
didn't ensure all patches made it to all lists (by default each patch
gets recipients individually from get_maintainer).  I'll make sure to
fix for patch set #2.  If you want to see all the patches, you can at
least find them on lore.kernel.org linked from the cover:

https://lore.kernel.org/patchwork/cover/1075373/


> Please resend if/when I need to apply something.
>
> 2 patches set to Changes Requested.
>
> 10948785 [1/3] brcmfmac: re-enable command decode in sdio_aos for BRCM 4354

As per Arend I'll change patch #1 to a full revert instead of a
partial revert.  Arend: please yell if you want otherwise.

-Doug
