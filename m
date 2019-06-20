Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA686C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02D02085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnBfFGGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfFTNvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:51:05 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36347 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfFTNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:51:04 -0400
Received: by mail-ua1-f68.google.com with SMTP id v20so1682359uao.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IFwlqbKib7dWbeVbv8X2YweFdeF4XDbaSTOpsTFt9E=;
        b=cnBfFGGl3pJdpKp1MmBsF47mWvkNWCygNpH36R5cENrnDyoojF55rqerYfDLfwbbTj
         RFNj58C5CUCULzDhnJhuuGUawX8GzXHIVIZhOz7jX/xVeIdC14e76z4ee9EhQzScRn3r
         yZyPrtDQwDjqyu6vqRuq4CLTKqp19vhLDP1kzyZlJral0qqZUmCvS5srHMy+sgfXo7OX
         8J3/HDJJtVqUJPoO9R3c2uQaBqDPo5Hb8yFlY4a3lZNrdJXrZ2uvs7wDiEP1uZSr6Jfu
         RATefM9/IOvINHrRt3pDF9AMIZimpQikwZUjdX3vOvvUC0JBvtUIxqFbJK3SbyUB77sX
         swNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IFwlqbKib7dWbeVbv8X2YweFdeF4XDbaSTOpsTFt9E=;
        b=iD0er6Kywd7CFhvH/O5XKooUN89xeof9bohyQYuAX4X83T3ILNZGu3RMSUNgWnkl06
         dn03oBvfYE2jzub2C1rpMr+DUoqNgnzmai+o9ok1mshFi3e2ZKWUPlSwYP8FhR6oRQyL
         e/9/tQW/XHd/GxA5iuFKaP1w56XRABEXYdp6x5dOh3W57Tzq8mCy2YX64YC+esZ827M+
         SoVhpsnbST14Eyf6FJvApByxjAiAnmj0PkmtNPnbk6w0Qa11EOAd80Jgecj0DOTMbp3Z
         gg3hXhxOfUXYMl9zgmmqS5UpF/TmVHIk+Zux5HJwi02K+vVjUdFOiY8asyee+Uqe6o6J
         U+SQ==
X-Gm-Message-State: APjAAAUAEL5RozifVXmBaruxGq97W2oQLtSZpkfV+l8uZNqAz5lpGN7f
        L2jp6EaEUohSsMLEyALS9kV1PFbRK3hv4oVRevIwWg==
X-Google-Smtp-Source: APXvYqyZXCFrwLLbuKH87ntBoB1uPTcKE017Mrw8Z9+j3VOUxMLwq/g1pwfocngRvtK/nHu4TYQODtwzbAxVOv/4r8s=
X-Received: by 2002:a9f:242e:: with SMTP id 43mr8151929uaq.100.1561038663128;
 Thu, 20 Jun 2019 06:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com> <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
In-Reply-To: <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 15:50:26 +0200
Message-ID: <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
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

Hi Ludovic,

On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:
> >
> > hi Ulf
> >
> > Just a "gentleman ping" about this series.
> > I know you are busy, it's just to be sure you do not forget me :-)
>
> Thanks! I started briefly to review, but got distracted again. I will
> come to it, but it just seems to take more time than it should, my
> apologies.

Alright, so I planned to review this this week - but failed. I have
been overwhelmed with work lately (as usual when vacation is getting
closer).

I need to gently request to come back to this as of week 28, when I
will give this the highest prio. Again apologize for the delays!

Kind regards
Uffe

>
> Br
> Uffe
>
> >
> > Regards
> > Ludo
> >
> > On 6/3/19 5:55 PM, Ludovic Barre wrote:
> > > From: Ludovic Barre <ludovic.barre@st.com>
> > >
> > > This patch series adds busy detect for stm32 sdmmc variant.
> > > Some adaptations are required:
> > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> > >   different.
> > > -Add hardware busy timeout with MMCIDATATIMER register.
> > >
> > > V3:
> > > -rebase on latest mmc next
> > > -replace re-read by status parameter.
> > >
> > > V2:
> > > -mmci_cmd_irq cleanup in separate patch.
> > > -simplify the busy_detect_flag exclude
> > > -replace sdmmc specific comment in
> > > "mmc: mmci: avoid fake busy polling in mmci_irq"
> > > to focus on common behavior
> > >
> > > Ludovic Barre (3):
> > >    mmc: mmci: fix read status for busy detect
> > >    mmc: mmci: add hardware busy timeout feature
> > >    mmc: mmci: add busy detect for stm32 sdmmc variant
> > >
> > >   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
> > >   drivers/mmc/host/mmci.h |  3 +++
> > >   2 files changed, 44 insertions(+), 8 deletions(-)
> > >
