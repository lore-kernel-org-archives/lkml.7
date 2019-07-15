Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A11C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEA2214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIEVkRA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfGOICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:02:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38068 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbfGOICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:02:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id k9so10745365vso.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iuvLGLsstyrfvORfrha76hOJIbaEdkc5waXCSHT3U28=;
        b=oIEVkRA2iKUiSROtP71CyA8BYybIftJW4gJE9GU+nIJm0SBaF5fp5l5vvUbNiXyw60
         42SCo5/Nj3mgoSpXo0t4tGsWjSAW6ZqxeyHcTbzvWydbI/DniEzHsE5m2ZfW9OVRxThJ
         olOiag19xKLJz6CAhLt0oqgOwCp+NPFNmlqkZABFsPn0/vI3LVKcjknVz0RiR+Ywltsi
         wjVCMktkiUC+J8Fq+C3nNKI6uC1eTZDxPosS7z6OSwCED1MM4Yy/n1MC/pBaR9kCd4I6
         k6qrMdPKcCGxS8Zp4Roi//B1ZYvQqxBCF2Ht+8BYpRW1an4f+rYdKo98YdHSoAFUX1hZ
         9LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iuvLGLsstyrfvORfrha76hOJIbaEdkc5waXCSHT3U28=;
        b=ukxyDHC0uZtK0gNyXh4Ft5vz91AQbFnjh6UnWnGEi7/ZvlbFEv+iW03Gt/0K8wvyL6
         DnIbC0yg5zAcBDw5d3JRcKXbprCsGdXxe55LuFgkrTZdDhqfzuNRerJ93V+Y6pn1ot0Z
         BeP+TYgL7iE/5aElfwLIh3TVxkw+DO6GG5vEjC8Y1rIiEkT6fQuoGbuRCnxU8q6IfBrM
         QvKSZ1hzMg5f/HQO71YL8peHt4TukCkjOJgYhB2qlILvqSM5TPDX4G6cgLNM330f778r
         Y7eKX9npwgpk7RZWixZBpoCJI699KeoQYt8g/ryGm4tS7dFfszCzgmiZFzTGIzRfo4Nl
         kv5g==
X-Gm-Message-State: APjAAAUBTyxJHCe9zCsmpPPWQ7U2mx6P3GG4gcicWosqhKh0V1GinIOY
        TWkyLWnlQHJ40OyS1HK7sSOHjfPb6SAJi6i7J647HQ==
X-Google-Smtp-Source: APXvYqz9I5YBxjFFkO53VilAz3vY9qzYuKTKMoBVSx7wkqVdfBCSqxzgYb9P6olM18c/3fom7byG6FaKIJC0UxNoLH4=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr15572454vsc.200.1563177754346;
 Mon, 15 Jul 2019 01:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com> <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>
 <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com> <1563176363071.36427@st.com>
In-Reply-To: <1563176363071.36427@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jul 2019 10:01:58 +0200
Message-ID: <CAPDyKFpLoqZxX=nnivt-8zF_Azen+Vyf6vE4acB+r=LGOcz=5Q@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 09:39, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Ulf
>
> like scheduled, I send you a "gentleman ping" about this series.

Thanks, I am just looking at it, again.

Kind regards
Uffe

>
> Regards,
> Ludo
> ________________________________________
> De : Ulf Hansson <ulf.hansson@linaro.org>
> Envoy=C3=A9 : jeudi 20 juin 2019 15:50
> =C3=80 : Ludovic BARRE
> Cc : Rob Herring; Srinivas Kandagatla; Maxime Coquelin; Alexandre TORGUE;=
 Linux ARM; Linux Kernel Mailing List; DTML; linux-mmc@vger.kernel.org; lin=
ux-stm32@st-md-mailman.stormreply.com
> Objet : Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc var=
iant
>
> Hi Ludovic,
>
> On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrot=
e:
> > >
> > > hi Ulf
> > >
> > > Just a "gentleman ping" about this series.
> > > I know you are busy, it's just to be sure you do not forget me :-)
> >
> > Thanks! I started briefly to review, but got distracted again. I will
> > come to it, but it just seems to take more time than it should, my
> > apologies.
>
> Alright, so I planned to review this this week - but failed. I have
> been overwhelmed with work lately (as usual when vacation is getting
> closer).
>
> I need to gently request to come back to this as of week 28, when I
> will give this the highest prio. Again apologize for the delays!
>
> Kind regards
> Uffe
>
> >
> > Br
> > Uffe
> >
> > >
> > > Regards
> > > Ludo
> > >
> > > On 6/3/19 5:55 PM, Ludovic Barre wrote:
> > > > From: Ludovic Barre <ludovic.barre@st.com>
> > > >
> > > > This patch series adds busy detect for stm32 sdmmc variant.
> > > > Some adaptations are required:
> > > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> > > >   different.
> > > > -Add hardware busy timeout with MMCIDATATIMER register.
> > > >
> > > > V3:
> > > > -rebase on latest mmc next
> > > > -replace re-read by status parameter.
> > > >
> > > > V2:
> > > > -mmci_cmd_irq cleanup in separate patch.
> > > > -simplify the busy_detect_flag exclude
> > > > -replace sdmmc specific comment in
> > > > "mmc: mmci: avoid fake busy polling in mmci_irq"
> > > > to focus on common behavior
> > > >
> > > > Ludovic Barre (3):
> > > >    mmc: mmci: fix read status for busy detect
> > > >    mmc: mmci: add hardware busy timeout feature
> > > >    mmc: mmci: add busy detect for stm32 sdmmc variant
> > > >
> > > >   drivers/mmc/host/mmci.c | 49 ++++++++++++++++++++++++++++++++++++=
+++++--------
> > > >   drivers/mmc/host/mmci.h |  3 +++
> > > >   2 files changed, 44 insertions(+), 8 deletions(-)
> > > >
