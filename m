Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9BAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6432089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7rIyByj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfECN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:29:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41667 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfECN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:29:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so3570159vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEzlUuM/Jwfv3VSJhIT2L6SyOU5GgzPaBEeFYcaGzrM=;
        b=O7rIyByj0jiAE4VnV24ZNn4Y1ylqkbfa1D8NaLihBPvQ6hc0TJ2Yiy69ux3icHlntZ
         OCoH1ySYRhckrmy+z0+u6WAjbTpS0gkWASmQrpvYQgV/WpkxcJajl0m0eEXXnR6El4qO
         zp9xSCHg2saZNiLmfNcuKvOI+3RH2fSU/GIakpBrVvCM90SOEC5Uu3Atgw7fatqZKTz+
         TbcUVhgAnKl+cp2XqrMVvd24D00wH5XOCIw/MaSWcFvEHbdiaDUmvIzmeVFLqFXhD5jm
         hNpu+BGi6tZULhQWflurRJiLW6GXpCEhr9PuyqeHVKcpiM0CCsFcKfvBSN1tTnWLtZgo
         2nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEzlUuM/Jwfv3VSJhIT2L6SyOU5GgzPaBEeFYcaGzrM=;
        b=bZkhcatesvVy/8UA3y9kqLiDROZNgskxvch0gM57TqfuEGUpkaN8ckb9NcAXrH4zbR
         MhupdNGK/Agj1SHMIL+1zAV/8MJTb4sLM8QM4Rv+nyE7uuxSrSOCqQJt3BBY9c3OCKDh
         wh5sCCkNZtvX8g00KfCV9c4TNMjEaIXQrrakHOHAnSz98fmN3BUuCcgy3cxlmQZCQqCc
         Pn4Urs2LGau1JoJy0IYKk5bZTTkyokpE5b4+bJa/bw0CZZ2ezAuyrkY0mLaMfzLvC7fX
         2CETlOIcN7tRs2leVrSe49DKNFqYBc7DeJkhX6vlrKGYIilNM4e+rRS5X+Rs57uC3y0I
         P9JQ==
X-Gm-Message-State: APjAAAVOINRBR/9KkxgGN751AI/JEfH/cw2gZLn0fe/oJ9vYcIEclLwS
        HcJ80UGZtN1qGjsxmDPGpcJ0N5ShlXiwuRBHkPAMUQ==
X-Google-Smtp-Source: APXvYqy046Z/3iX9LlO9h/cYF4oWBVlij//f74AP7T9sKj+fNTyl+4O4+eLgNyusHCiXL4EPY2iMVAE5FFUMIfSAp/E=
X-Received: by 2002:a67:b44d:: with SMTP id c13mr5650144vsm.165.1556890191428;
 Fri, 03 May 2019 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com> <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
In-Reply-To: <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:29:15 +0200
Message-ID: <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 at 14:06, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
>
> On 4/30/19 1:13 PM, Ulf Hansson wrote:
> > On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>
> >> From: Ludovic Barre <ludovic.barre@st.com>
> >>
> >> This patch series adds busy detect for stm32 sdmmc variant.
> >> Some adaptations are required:
> >> -Avoid to check and poll busy status when is not expected.
> >> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> >>   different.
> >> -Add hardware busy timeout with MMCIDATATIMER register.
> >>
> >> V2:
> >> -mmci_cmd_irq cleanup in separate patch.
> >> -simplify the busy_detect_flag exclude
> >> -replace sdmmc specific comment in
> >> "mmc: mmci: avoid fake busy polling in mmci_irq"
> >> to focus on common behavior
> >>
> >> Ludovic Barre (5):
> >>    mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
> >>    mmc: mmci: avoid fake busy polling in mmci_irq
> >>    mmc: mmci: fix clear of busy detect status
> >>    mmc: mmci: add hardware busy timeout feature
> >>    mmc: mmci: add busy detect for stm32 sdmmc variant
> >>
> >>   drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
> >>   drivers/mmc/host/mmci.h |  3 +++
> >>   2 files changed, 51 insertions(+), 13 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> >
> > Ludovic, just wanted to let you know that I am reviewing and testing
> > this series.
> >
> > However, while running some tests on Ux500 for validating the busy
> > detection code, even without your series applied, I encounter some odd
> > behaviors. I am looking into the problem to understand better and will
> > let you know as soon as I have some more data to share.
>
> Oops, don't hesitate to share your status, if I could help.

Thanks! Good and bad news here, then.

I now understand what is going on - and there is certainly room for
improvements here, but more importantly the actual mmci busy detection
works as expected.

When it comes to improvements, the main issue I have found is how we
treat DATA WRITES. In many cases we simply don't use the HW busy
detection at all, but instead rely on the mmc core to send CMD13 in a
loop to poll. Well, then if the polling would have consisted of a
couple of CMD13s that wouldn't be an issue, but my observations is
rather that the numbers of CMD13 sent to poll is in the range or
hundreds/thousands - per each WRITE request!

I am going to send a patch (or two) that improves the behavior. It
might even involve changing parts in core layer, not sure how the end
result will look like yet.

In any case, I have applied patch 1 and patch2 for next, as the tests
turned out well at my side. I also took the liberty of updating some
of the comments/changelogs, please have look and tell if there is
something you want to change.

I will continue with the rest of series next week.

Kind regards
Uffe
