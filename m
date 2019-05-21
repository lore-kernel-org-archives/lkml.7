Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29032173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5EyexQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfEUH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:56:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43877 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfEUH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:56:47 -0400
Received: by mail-vs1-f66.google.com with SMTP id d128so10569871vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtQxjrgLrdOuTSlhu4LkRzwqAzUSzK8W0aKxAbgs+38=;
        b=F5EyexQaa0bp0wPObS0GOV2fVBnRHWOPre4mgWtyFd+AZ2jy1wnr/0x0uDEiuWGeJ2
         x54itVgHoIeRfX64D+f8f1ov2JNjm4z9MqJRfzHEdo1QXpZz7GslDUsVAFoSyLagjPrT
         ugwOXDGmwSI5O4Hf9N/TIwdjo3inNrzlsS7ATtZiBJilOcfV2RKJX2F3yjhL3wh0pn7z
         1gJIeiyPYxdIs8kS2q6MkhiVdjsS69JS3nx6xEQ46SMXWxpeaz+KJrawK4ANuLNH/Syy
         x0UMQXrOgL+Y83N/WwWNWxek6DqXC6/mKTFZlj4O9kk3v/z5QlEKUir+Jb1IHzUGMHHJ
         /RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtQxjrgLrdOuTSlhu4LkRzwqAzUSzK8W0aKxAbgs+38=;
        b=IYj2D/vDHXPLsy2fzOWhaaKaZHhhQvcSqONyErtl45tcN5IFVCDyqXcnbOkxb/e8nv
         xwnXtFcc6uzggZiZrfGG8tvo2HM1BzWr76X08Ir9yUYrAwsF+v/5TbY3SiWma/Xrm4EH
         6slXMloZ3ataI9BJidAhCNSXQwoieOopmfKET8JPbge1ZELLj5O03INWE/irzVyvJ7C7
         2Jh/NZgGVFH1//XmaaaPvrbT+Bj3Y5a9qwkQX0epX7Rcx+JkCBbEHknYvT3l5MAR9EKV
         ffk5+JWTMpRgoELZTB+B2B7XipgNkk5XAUn9XQfuc3xZjWVQlt3Z+T4GZmqLnloyULiG
         FhqQ==
X-Gm-Message-State: APjAAAXNB75irFIZA7mHLyFyHEw8SusAJkc0zu8jX6PMhSYZQZHMcqnT
        1AHE5SdexG3P3lAZwgnW1eYFebWgqiFBOMiOSiL9pw==
X-Google-Smtp-Source: APXvYqxy+vnW+gDM9sIawmZ1xfypyZ+973iUhEqyUgGr8DtqjIiEFy8/ahRDodOxF5dcpTZCuXdm3fwUb+Nvl/aPNSQ=
X-Received: by 2002:a67:3046:: with SMTP id w67mr21968255vsw.165.1558425406507;
 Tue, 21 May 2019 00:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
 <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com> <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
 <e884b614-14d4-1cae-5b77-c6aacabb764a@st.com>
In-Reply-To: <e884b614-14d4-1cae-5b77-c6aacabb764a@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 May 2019 09:56:09 +0200
Message-ID: <CAPDyKFo4Y9PF_QL47rO2c_szUHahPMuzHV=j_SL9dxvAzst17w@mail.gmail.com>
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

On Tue, 21 May 2019 at 09:38, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> Just a "gentleman ping" about the rest of series.
> "mmc: mmci: add busy detect for stm32 sdmmc variant"

Thanks!

It's been a busy period and I am currently traveling. My plan is to
look at in detail beginning of next week when get back home. I hope
that's okay.

Kind regards
Uffe

>
> Regards
> Ludo
>
> On 5/3/19 3:29 PM, Ulf Hansson wrote:
> > On Tue, 30 Apr 2019 at 14:06, Ludovic BARRE <ludovic.barre@st.com> wrote:
> >>
> >>
> >>
> >> On 4/30/19 1:13 PM, Ulf Hansson wrote:
> >>> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>>>
> >>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>
> >>>> This patch series adds busy detect for stm32 sdmmc variant.
> >>>> Some adaptations are required:
> >>>> -Avoid to check and poll busy status when is not expected.
> >>>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> >>>>    different.
> >>>> -Add hardware busy timeout with MMCIDATATIMER register.
> >>>>
> >>>> V2:
> >>>> -mmci_cmd_irq cleanup in separate patch.
> >>>> -simplify the busy_detect_flag exclude
> >>>> -replace sdmmc specific comment in
> >>>> "mmc: mmci: avoid fake busy polling in mmci_irq"
> >>>> to focus on common behavior
> >>>>
> >>>> Ludovic Barre (5):
> >>>>     mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
> >>>>     mmc: mmci: avoid fake busy polling in mmci_irq
> >>>>     mmc: mmci: fix clear of busy detect status
> >>>>     mmc: mmci: add hardware busy timeout feature
> >>>>     mmc: mmci: add busy detect for stm32 sdmmc variant
> >>>>
> >>>>    drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
> >>>>    drivers/mmc/host/mmci.h |  3 +++
> >>>>    2 files changed, 51 insertions(+), 13 deletions(-)
> >>>>
> >>>> --
> >>>> 2.7.4
> >>>>
> >>>
> >>> Ludovic, just wanted to let you know that I am reviewing and testing
> >>> this series.
> >>>
> >>> However, while running some tests on Ux500 for validating the busy
> >>> detection code, even without your series applied, I encounter some odd
> >>> behaviors. I am looking into the problem to understand better and will
> >>> let you know as soon as I have some more data to share.
> >>
> >> Oops, don't hesitate to share your status, if I could help.
> >
> > Thanks! Good and bad news here, then.
> >
> > I now understand what is going on - and there is certainly room for
> > improvements here, but more importantly the actual mmci busy detection
> > works as expected.
> >
> > When it comes to improvements, the main issue I have found is how we
> > treat DATA WRITES. In many cases we simply don't use the HW busy
> > detection at all, but instead rely on the mmc core to send CMD13 in a
> > loop to poll. Well, then if the polling would have consisted of a
> > couple of CMD13s that wouldn't be an issue, but my observations is
> > rather that the numbers of CMD13 sent to poll is in the range or
> > hundreds/thousands - per each WRITE request!
> >
> > I am going to send a patch (or two) that improves the behavior. It
> > might even involve changing parts in core layer, not sure how the end
> > result will look like yet.
> >
> > In any case, I have applied patch 1 and patch2 for next, as the tests
> > turned out well at my side. I also took the liberty of updating some
> > of the comments/changelogs, please have look and tell if there is
> > something you want to change.
> >
> > I will continue with the rest of series next week.
> >
> > Kind regards
> > Uffe
> >
