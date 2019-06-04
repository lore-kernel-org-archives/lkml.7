Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48ADC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQPGFwKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfFDQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:08:27 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34585 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfFDQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:08:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id 7so8010750uah.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJnKTszq0LucT9tff8aVBNiTlpqFIuwICl/wZRuN/SM=;
        b=GQPGFwKdD+yYos6fP+5thtoEjgvr0MNDy0yHYc8fZz73MyW879mUUBZAhYk/YR5/zU
         9hIznQ03ADry6HE/yWZjoTrxElltsqKGduoZz2kRZMN1cCWbM/+RGRexzWI62NcqV19V
         CocEHM4nD9FB9MbHrma4vtmwngw3CVYG9b9VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJnKTszq0LucT9tff8aVBNiTlpqFIuwICl/wZRuN/SM=;
        b=CM+tYUY1O3cHJZt9b5jJ/mEOp0rURvN2jYjOm1NUEf2CF8ebFj8EzyxZU6iWNajdQa
         aL01xFB9eHUr8S3E3U2Vhw7cWBqKLOPx1068QszNDa6eZp12jKZT+/0Z+Y/4qbFVyotE
         KGDdWdiVrMiAgsH+s9+QrXetnFmAgrwBvZ5eqTBDCzjIgFXjvLMEsb+YCnjfbr93ubui
         Ukl1FlZzfk5d1L6DQ8chWYLBbBxuA5s+lRu7blWGf60810qyf4P2q0I2/hC+RreX0NjJ
         aMq6LHBp5D7AZhI6tixB2Q66rnqYSUWI0JB50W2A6/mJ6/T7HJTKXuca3YWZpDKnYQKW
         FN8g==
X-Gm-Message-State: APjAAAX0hxKCkOzdR8A3lz8BGXr0QH9g8Tl9tFEkHVgXqUEkQmXeZ7py
        KvT+z9sdZ53x520QwFiPR+S+fOPtwiA=
X-Google-Smtp-Source: APXvYqyNUrYoXq9Nvaxmaz/emnUbSL/MohPAg7QLul3tq7PHDmuegUNr74CQa3OfIJmbel8Jx+VHHw==
X-Received: by 2002:ab0:13e2:: with SMTP id n31mr4724069uae.61.1559664505219;
        Tue, 04 Jun 2019 09:08:25 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 66sm1237043vko.27.2019.06.04.09.08.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:08:25 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id n2so8002160uad.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:08:25 -0700 (PDT)
X-Received: by 2002:ab0:5ad0:: with SMTP id x16mr15793093uae.124.1559664085104;
 Tue, 04 Jun 2019 09:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-2-dianders@chromium.org>
 <20190528121833.7D3A460A00@smtp.codeaurora.org> <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
 <16aff33f3e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <16aff358a20.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <40587a64-490b-8b1e-8a11-1e1aebdab2f3@cypress.com>
In-Reply-To: <40587a64-490b-8b1e-8a11-1e1aebdab2f3@cypress.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Jun 2019 09:01:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
Message-ID: <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for
 BRCM 4354
To:     Wright Feng <Wright.Feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Naveen Gupta <Naveen.Gupta@cypress.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Double Lo <Double.Lo@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 3, 2019 at 8:20 PM Wright Feng <Wright.Feng@cypress.com> wrote:
>
> On 2019/5/29 =E4=B8=8A=E5=8D=88 12:11, Arend Van Spriel wrote:
> > On May 28, 2019 6:09:21 PM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >
> >> On May 28, 2019 5:52:10 PM Doug Anderson <dianders@chromium.org> wrote=
:
> >>
> >>> Hi,
> >>>
> >>> On Tue, May 28, 2019 at 5:18 AM Kalle Valo <kvalo@codeaurora.org> wro=
te:
> >>>>
> >>>> Douglas Anderson <dianders@chromium.org> wrote:
> >>>>
> >>>> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
> >>>> > sdio_aos") we disabled something called "command decode in sdio_ao=
s"
> >>>> > for a whole bunch of Broadcom SDIO WiFi parts.
> >>>> >
> >>>> > After that patch landed I find that my kernel log on
> >>>> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
> >>>> >   brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep
> >>>> state -110
> >>>> >
> >>>> > This seems to happen every time the Broadcom WiFi transitions out =
of
> >>>> > sleep mode.  Reverting the part of the commit that affects the
> >>>> WiFi on
> >>>> > my boards fixes the problem for me, so that's what this patch does=
.
> >>>> >
> >>>> > Note that, in general, the justification in the original commit
> >>>> seemed
> >>>> > a little weak.  It looked like someone was testing on a SD card
> >>>> > controller that would sometimes die if there were CRC errors on th=
e
> >>>> > bus.  This used to happen back in early days of dw_mmc (the
> >>>> controller
> >>>> > on my boards), but we fixed it.  Disabling a feature on all boards
> >>>> > just because one SD card controller is broken seems bad.  ...so
> >>>> > instead of just this patch possibly the right thing to do is to fu=
lly
> >>>> > revert the original commit.
> >>>> >
> Since the commit 29f6589140a1 ("brcmfmac: disable command decode in
> sdio_aos") causes the regression on other SD card controller, it is
> better to revert it as you mentioned.
> Actually, without the commit, we hit MMC timeout(-110) and hanged
> instead of CRC error in our test.

Any chance I can convince you to provide some official tags like
Reviewed-by or Tested-by on the revert?

> Would you please share the analysis of
> dw_mmc issue which you fixed? We'd like to compare whether we got the
> same issue.

I'm not sure there's any single magic commit I can point to.  When I
started working on dw_mmc it was terrible at handling error cases and
would often crash / hang / stop all future communication upon certain
classes or efforts.  There were dozens of problems we've had to fix
over the years.  These problems showed up when we started supporting
HS200 / UHS since the tuning phase really stress the error handling of
the host controller.

I searched and by the time we were supporting Broadcom SDIO cards the
error handling was already pretty good.  ...but if we hadn't already
made the error handling more robust for UHS tuning then we would have
definitely hit these types of problems.  The only problem I remember
having to solve in dw_mmc that was unique to Broadcom was commit
0bdbd0e88cf6 ("mmc: dw_mmc: Don't start commands while busy").  Any
chance that could be what you're hitting?

What host controller are you having problems with?

-Doug
