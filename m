Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA95BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C920B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aywESScd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfHEIbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:31:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42463 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:31:47 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so32601303iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9onNqSu8H6T4t+v8bvPux5C3Ze/nalI4ApJroQRttg=;
        b=aywESScdkNjlGJf+foMrGaH30r3yFivVONl+3QF/vs9mPZxQ7Z9lCSqAyevZxfhXBV
         p8Y71cVlfFNUQTlqv3fAISo5KNCajOU6OqFY8zXEiQwtgIDNHjm1JLQM8mcmBfK/Essk
         Vs1iZN+Zd9qsQCZfwGrN71p0/vxpdh1yVob0V5Kddk+Z/nd7sQKhLstCHf0Usgxwwjk9
         EJQmEKFdpnBimhSdaDaq4sVIY93TaBb8vY1+OPKgg+jhPAp0s/NgDOZ5ohrGB3Cz7R22
         +L0+ioeTc9pYBSuDbEdoGHFvdgHuYL79kuicaVTPqh+hvyhAcJoXbtOht/1sFRJngb0w
         qquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9onNqSu8H6T4t+v8bvPux5C3Ze/nalI4ApJroQRttg=;
        b=Zpq9hNLlnoMkVrKohONRrrigPXMNn3KbWbpaaNXnoC2TxRv5Pfz10QsuGaWaEfjvoP
         guX7iBRtUeUdZXydbGwoAN6IsiqrSnkNfYj7KcEHRVCcPb+Y5cSHc8kCfvzvFasnG4Bm
         S/r+aQlqCu2DDbsNExumzJWQh5BRmMaKPqElBMjUeBLLXspXXM9LE6M/qrH8ICRsFWkE
         Rf7u79KiGEmq/1RVGVMP4qiq1Xzkkk+8D+J8ph0rP/FTNVp2rXwcl9pf+/uSarrCMsez
         qG3lZKYdDEQWpkeLuidwcaUHGFOKYlfJPrmonOuJVUlNhlubcPRkmry0fnrt6da7J+VV
         mNeg==
X-Gm-Message-State: APjAAAWh+K8K3uwa//iVReqLmQqSqZrlrTgy5cO97VVScirMHU0X/r4F
        ntZt0nCBaHXjap8Ou9keczDwlaLckz+k9+hEppupkg==
X-Google-Smtp-Source: APXvYqwdH5YrXmNOdQLqeqaHrEbB41XdZAI+QgVn/WPhGXhazC5gC+vdAsxaH69ckpH1PS09DzXuJmzKdsOLUZS7P9M=
X-Received: by 2002:a02:5b05:: with SMTP id g5mr147889176jab.114.1564993906173;
 Mon, 05 Aug 2019 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190725131257.6142-1-brgl@bgdev.pl> <CAK8P3a1FXyRRi5q48h-=egFjgoRJvy6_zuO9MQaAOMA-bsJKRA@mail.gmail.com>
In-Reply-To: <CAK8P3a1FXyRRi5q48h-=egFjgoRJvy6_zuO9MQaAOMA-bsJKRA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Aug 2019 10:31:35 +0200
Message-ID: <CAMRc=Me_7aw_RvU_tZnVUgduN2wWYGqJ7hQirQ2RLzxGiPujvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: make DaVinci part of the ARM v5 multiplatform build
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 25 lip 2019 o 16:57 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> On Thu, Jul 25, 2019 at 3:13 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series makes DaVinci part of the multiplatform build for ARM v5.
> >
> > First three patches fix build errors spotted and fixed by Arnd with v1.
> >
> > The fourth patch adds necessary bits and pieces for davinci to support
> > multiplatform build and the last one actually adds all davinci boards
> > to multi_v5_defconfig.
> >
> > Tested on da850-lcdk with both multi_v5 as well as davinci_all defconfi=
gs.
> >
> > v1 -> v2:
> > - added patches from Arnd that fix build errors spotted when building
> >   random configurations (much appreciated)
> > - rebased on top of v5.3-rc1
>
> > Arnd Bergmann (3):
> > staging: media/davinci_vpfe: fix pinmux setup compilation
> >  media: davinci-vpbe: remove obsolete includes
> >  davinci: fix sleep.S build error on ARMv4
> >
> > Bartosz Golaszewski (2):
> >  ARM: davinci: support multiplatform build for ARM v5
> >  ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform=
 build
>
>
> Thanks a lot for reposting the series!
>
> I wonder how we shoud deal with the dependencies now that the two media
> patches got merged in the linux-media tree.
>
> It would be tempting to just merge the arch/arm/ changes, but that create=
s
> a bisection problem when the vpbe driver is enabled. I don't care
> about the staging driver really as that one is broken anyway, but includi=
ng
> the "media: davinci-vpbe: remove obsolete includes" fix would be better
> here.
>
> Mauro, any idea for how to handle that? Should we apply an identical
> patch to the davinci tree, or maybe only have it the ARM tree and you
> drop it from your tree (I don't know if you have a rule against rebasing)=
.
> Sorry for not coordinating with Bartosz before I sent the patch again
> earlier this week.
>
>
>       Arnd

Hi Arnd,

is there any action required from me for this series?

Bart
