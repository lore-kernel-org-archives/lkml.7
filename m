Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440FFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043C2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNuXOLWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437969AbfFLKLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:11:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34557 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437611AbfFLKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:11:29 -0400
Received: by mail-vs1-f67.google.com with SMTP id q64so9889044vsd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vwwsd0tdKxa00vg2i3C1zrYsYmEGYn7C9UHSqxLUOAY=;
        b=cNuXOLWUPlPjzsuZ7Z6BuN/fwPgNEqYjZXIJhRFvcMn54FRyd3mnAeCRjTPJEmoRxx
         xDPmcvmPVRh581RobGwdUC2EsTF2EhwhYlmpZcuZ1sQCcejbMGT133Abgv/YaQPzr3CV
         ///CpGcB3drMtVF/D1a9lHuUcbiWPZGDYJrkeshfN6hkMqBjOgV60A8iRBMSAj+m6YUx
         5kpoq7HOqxzFwsqtg4spRZYFg0/dpuVf/aZaHr8rxUguZigoD5SiyuF8nBrVAclPtY/I
         ASCtN2N1+XGfiS8vxP+riDAtTtka9iDhNlbnybkrK7T2xWiFKG+OL7N38Ketqfqe1GKg
         mi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vwwsd0tdKxa00vg2i3C1zrYsYmEGYn7C9UHSqxLUOAY=;
        b=kZWAB5awbB5oP8ygBXxQZGLcY7I8vOtQtawd3Zm2a4f8WwngcQR02mvOR2D2R9jXus
         bN7o+4Xy0dQOZmX8eDIjCHUqWvR1U8I1oHFkD/cFWG3zVU4SeisT3SnfqvrtljGZh+/+
         NTnzrUszpvVDnspVi1mUV38/Kqg3CGqVGD5Y9Eg9ZvOsoaedatx0S5W/ZCtjkikpwH5J
         fsxtQIQea1bJTFL8s7/9cUmknvRJ/Ej8wpjPBd5C1Doz9D7oxWvdAM/mO1xckw+cXuZj
         V9AK09kjF93I9+vAfyVf47GKsxo0ZK+Jvm03HL9sGnCKGWA9zKrK5CWNKhxE8oy/FOh9
         3Gvg==
X-Gm-Message-State: APjAAAUzv6ROudTgOOC8wJGH7TgM8ln5L2pr/5ZZUVtm1EICGGP3MjsT
        iU5TdVev1Zhs0oVRsBZFRk4625+LZqQu2Wn3L9K6hQ==
X-Google-Smtp-Source: APXvYqz9HdjKJz1FgwE/Nx/EZT4gQSK6X7I7/l+mUBC1IPdGylVrfi3vGB2PufieZ8KgmvsoIDewFF/91qoctXVN1SA=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr9599693vsp.191.1560334287942;
 Wed, 12 Jun 2019 03:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190607223716.119277-1-dianders@chromium.org>
 <20190607223716.119277-4-dianders@chromium.org> <363DA0ED52042842948283D2FC38E4649C52F8A0@IRSMSX106.ger.corp.intel.com>
 <CAD=FV=U8eo78Ee9xjhGXJMv=8YF9o89KLX024GH3iBRnRjCRvQ@mail.gmail.com>
In-Reply-To: <CAD=FV=U8eo78Ee9xjhGXJMv=8YF9o89KLX024GH3iBRnRjCRvQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jun 2019 12:10:51 +0200
Message-ID: <CAPDyKFo=QMRTkNYUVSE2AqiZgytkTVRXF0Mvznn6trVT4-cR=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        "mka@chromium.org" <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 18:50, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jun 10, 2019 at 1:56 AM Hunter, Adrian <adrian.hunter@intel.com> wrote:
> >
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/mmc/sdio_ids.h>
> > >  #include <linux/mmc/sdio_func.h>
> > >  #include <linux/mmc/card.h>
> > > +#include <linux/mmc/core.h>
> >
> > SDIO function drivers should not really include linux/mmc/core.h
> > (Also don't know why linux/mmc/card.h is included)
>
> OK, so I guess you're requesting an extra level of "sdio_" wrappers
> for all the functions I need to call.  I don't think the wrappers buy
> us a ton other than to abstract things a little bit and make it look
> prettier.  :-)  ...but certainly I can code that up if that's what
> everyone wants.

Are the new code you refer to going to be used for anything else but
SDIO? If not, please put them in the sdio specific headers instead.

BTW, apologize for not looking at this series any earlier, but I will
come to it soon.

>
> Just to make sure, I looked in "drivers/net/wireless/" and I do see
> quite a few instances of "mmc_" functions being used.  That doesn't
> mean all these instances are correct but it does appear to be
> commonplace.  Selected examples:
>
> drivers/net/wireless/ath/ath10k/sdio.c:
>   ret = mmc_hw_reset(ar_sdio->func->card->host);

mmc_hw_reset() is already an exported function, used by the mmc block
layer. So I think this is okay.

>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:
>   mmc_set_data_timeout(md, func->card);
>   mmc_wait_for_req(func->card->host, mr);

These are not okay, none of these things calls should really be done
from an SDIO func driver.

It tells me that the func driver is a doing workaround for something
that should be managed in a common way.

>
> drivers/net/wireless/marvell/mwifiex/sdio.c:
>   mmc_hw_reset(func->card->host);

Okay.

>
> drivers/net/wireless/rsi/rsi_91x_sdio.c:
>   err = mmc_wait_for_cmd(host, &cmd, 3);

Not okay.

>
>
> ...anyway, I'll give it a few days and if nobody else chimes in then
> I'll assume you indeed want "sdio_" wrappers for things and I'll post
> a v4.  If patch #1 happens to land in the meantime then I won't
> object.  ;-)

Adrian has a very good point. We need to strive to avoid exporting
APIs to here and there and just trust that they will be used wisely.

If the above calls to mmc_wait_for_req|cmd() and
mmc_set_data_timeout() could have been avoided, we would probably have
a more proper solution by now.

Kind regards
Uffe
