Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB3C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150B7208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRyKF7ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfH3Biy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:38:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfH3Bix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:38:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id n2so4274025wmk.4;
        Thu, 29 Aug 2019 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1j9LHjuAqXPfCkdFDTq6GuQQpzubrWokzlwRyLgeIE=;
        b=cRyKF7ln8tAobkPAhbdHIIRgPgGVpzUPE2QldGpyGtX3oP6wMGDkfMqjltHHtJIl6w
         fO3Ko22tco9czVh6kSUTiMKcVpjweU4xXGVMohO6phrnMAUuH7vQujFJaEDEG6j5juIn
         ct1VO0P49OCPiThtTL3pZI9wtb6b6gx2TxtXloV6dI3hivDEi6FuGIT5M+W55YgbRzXq
         fs9WP1OtddSP1TC15ga2kiEdH45rlWk//O70Ea4IyjO1TJQTvvRqAi10x+tAO21jb9RT
         OGe2phtgq/85BeI3B5iW2fKYFaGnX7JwJGRJmuarXhuQXLPWGSzn408f1R0AgD5bf5gY
         VrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1j9LHjuAqXPfCkdFDTq6GuQQpzubrWokzlwRyLgeIE=;
        b=il3sHQaRi8CUBZAyxdwz/NOP/n+tzZMWUNh1BMa5a67Am4PWBjWLMhukGCZKcY5oac
         nEzDXKdI7Om4Vs8Sjb+Wr9vLIOfs488+zJLI4NqvDeSZXgj2qqt8YXxF80mThWXf6RAi
         2r7NVaG3SiWy4uasoYKIqVgauHg0nVsUPhZuziOV7ySamOGKUcxWK5YkCBXJxlIelgns
         QKkhEwvYwuCVtoQNnUvM+rywDakrCcykdljMFx5wjva4kx1S9j/4WcN73OsocwYHVwWm
         12OB/C0ewem2Aakz+RetjMGQUrxbkh+qMMHcN713HLgTA4ErHDUtv3VX/dOLIT3LnaTT
         9uGw==
X-Gm-Message-State: APjAAAWklecNBtOnBZMLXM2jy7Wxn5OEUNIJ5UZRn3id6Xu1nzQahwge
        GHLctMS1hPK4qXBewhB12Bi/xPaIYYZRH6mHkWG8Ug==
X-Google-Smtp-Source: APXvYqxs8tsKKjtfCGPf7Wr+IGE9qJedDSBF/3HY1XGN6CR4aoYnZKNWPDsMOHC4WiZaNyYlWfHxYvsouQJc1rkZRAI=
X-Received: by 2002:a1c:7a10:: with SMTP id v16mr14386926wmc.2.1567129131520;
 Thu, 29 Aug 2019 18:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190829014645.4479-1-zhang.lyra@gmail.com> <CAPDyKFp_+YuPOjURiE0YhT0uotZi=P2sRVYNr3ejgZmrMaN=tA@mail.gmail.com>
In-Reply-To: <CAPDyKFp_+YuPOjURiE0YhT0uotZi=P2sRVYNr3ejgZmrMaN=tA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 30 Aug 2019 09:38:15 +0800
Message-ID: <CAAfSe-uVsy8vieTRP0hfbkuyDFF+8n1m7UnNdMd-raPQMnLY5g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] a few fixes for sprd's sd host controller
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 17:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 29 Aug 2019 at 03:47, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > With this patch-set, both sd card and mmc can be setup.  This patch-set was
> > verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
> >
> > Changes from v1:
> > - Added Reviewed-by and Tested-by of Baolin;
> > - Added fixes tag for all patches in this series.
> >
> > Chunyan Zhang (5):
> >   mmc: sdhci-sprd: fixed incorrect clock divider
> >   mmc: sdhci-sprd: add get_ro hook function
> >   mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
> >   mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
> >   mmc: sdhci-sprd: clear the UHS-I modes read from registers
> >
> >  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > --
> > 2.20.1
> >
>
> Thanks, but I amended the current applied patches, assuming the only
> change change you did was to put the fixes tag on one single line (for
> each patch).

Yes and right, thanks!

Chunyan

>
> Kind regards
> Uffe
