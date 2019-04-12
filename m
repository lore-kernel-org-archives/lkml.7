Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF70C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0235F20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H6/GfcCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDLB5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:57:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:27230 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDLB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:57:04 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3C1unqB016899;
        Fri, 12 Apr 2019 10:56:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3C1unqB016899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555034210;
        bh=ejeZsSTuD3b+smCcUAT/EWi3KZP8JO5b+MEsJhLR+fs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H6/GfcCx8JTColq7LwnkH7+gDVVeft2HmQOya5ZDl76WPblNgM1kMC7W64Ah55rTl
         R6DQzqDFVhOz4RPBN/qkIJ1J79xZNqQD1H2+JYJceQowYDv6yzd4WsbH5ZHRn22Muq
         eA50cj4zYJOUZtDLGopbQAl/fMrS2UKnzYWlrgFlYcSD8b/uz9kgVkukyazOdomZMu
         3xKmhUBsv/vGqmuEQYZE+gWZykXf7LlhfCgTyvzH6grkkdqCY7I93tdcnVtLJZ7+w6
         vUmXRl+r+1tXNW/QGPQManbZl1N8+LEXHuojvkXkZyYF5z0WOScgAIThE2lM6AJT4A
         reLI38Cep9NVg==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id w140so1823071vkd.3;
        Thu, 11 Apr 2019 18:56:49 -0700 (PDT)
X-Gm-Message-State: APjAAAU/jReMZfjuWA5L4IOFNEW0TC1hPXQX1wmnv2HUh+CBPiMP3VOo
        EvS6r3jcp2J75LZXiC7+jbiDGKsY1YHF4YsqtI8=
X-Google-Smtp-Source: APXvYqxWIm2CE6j4fw+nd/jKgq2zOuG0nEoBRQg1lQHrrwvxPxYBl5Noj2PzZEPW1ksDmH1lkNZwj7zg6jz2siQvqhM=
X-Received: by 2002:a1f:793:: with SMTP id 141mr17625984vkh.31.1555034208720;
 Thu, 11 Apr 2019 18:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATPU9DJaOMP=8oOMjeGSuAqWSTh2rSesvvfhjXx4HfxRg@mail.gmail.com> <CAK7LNAQ5g6pFronkmaJrVTvOnep+f_z-LeemDC8_SJAnYz=ZzQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQ5g6pFronkmaJrVTvOnep+f_z-LeemDC8_SJAnYz=ZzQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Apr 2019 10:56:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrEB++GWXce6_uJWkGEPLNCBRU5UBxOO5dn=j2VW=HhA@mail.gmail.com>
Message-ID: <CAK7LNAQrEB++GWXce6_uJWkGEPLNCBRU5UBxOO5dn=j2VW=HhA@mail.gmail.com>
Subject: Re: [PATCH 0/3] media: clean-up header search paths and add
 $(srctree)/ prefix
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Patrice Chotard <patrice.chotard@st.com>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abylay Ospan <aospan@netup.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sergey Kozlov <serjk@netup.ru>, Mike Isely <isely@pobox.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 1:02 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Mauro,
>
>
> On Mon, Feb 18, 2019 at 1:41 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Mauro,
> >
> > On Fri, Jan 25, 2019 at 4:00 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > My main motivation is to get rid of crappy header search path manipulation
> > > from Kbuild core.
> > >
> > > Before that, I want to do as many treewide cleanups as possible.
> > >
> > > If you are interested in the big picture of this work,
> > > the full patch set is available at:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test
> >
> >
> > Could you take a look at this series, please?
>
> Ping.

Ping, 3rd time.



>
>
>
> > >
> > >
> > >
> > > Masahiro Yamada (3):
> > >   media: coda: remove -I$(src) header search path
> > >   media: remove unneeded header search paths
> > >   media: prefix header search paths with $(srctree)/
> > >
> > >  drivers/media/common/b2c2/Makefile            | 4 ++--
> > >  drivers/media/dvb-frontends/cxd2880/Makefile  | 2 --
> > >  drivers/media/i2c/smiapp/Makefile             | 2 +-
> > >  drivers/media/mmc/siano/Makefile              | 3 +--
> > >  drivers/media/pci/b2c2/Makefile               | 2 +-
> > >  drivers/media/pci/bt8xx/Makefile              | 5 ++---
> > >  drivers/media/pci/cx18/Makefile               | 4 ++--
> > >  drivers/media/pci/cx23885/Makefile            | 4 ++--
> > >  drivers/media/pci/cx88/Makefile               | 4 ++--
> > >  drivers/media/pci/ddbridge/Makefile           | 4 ++--
> > >  drivers/media/pci/dm1105/Makefile             | 2 +-
> > >  drivers/media/pci/mantis/Makefile             | 2 +-
> > >  drivers/media/pci/netup_unidvb/Makefile       | 2 +-
> > >  drivers/media/pci/ngene/Makefile              | 4 ++--
> > >  drivers/media/pci/pluto2/Makefile             | 2 +-
> > >  drivers/media/pci/pt1/Makefile                | 4 ++--
> > >  drivers/media/pci/pt3/Makefile                | 4 ++--
> > >  drivers/media/pci/smipcie/Makefile            | 5 ++---
> > >  drivers/media/pci/ttpci/Makefile              | 4 ++--
> > >  drivers/media/platform/coda/Makefile          | 2 --
> > >  drivers/media/platform/coda/coda-h264.c       | 3 ++-
> > >  drivers/media/platform/coda/trace.h           | 2 +-
> > >  drivers/media/platform/sti/c8sectpfe/Makefile | 5 ++---
> > >  drivers/media/radio/Makefile                  | 2 --
> > >  drivers/media/spi/Makefile                    | 4 +---
> > >  drivers/media/usb/as102/Makefile              | 2 +-
> > >  drivers/media/usb/au0828/Makefile             | 4 ++--
> > >  drivers/media/usb/b2c2/Makefile               | 2 +-
> > >  drivers/media/usb/cx231xx/Makefile            | 5 ++---
> > >  drivers/media/usb/em28xx/Makefile             | 4 ++--
> > >  drivers/media/usb/go7007/Makefile             | 2 +-
> > >  drivers/media/usb/pvrusb2/Makefile            | 4 ++--
> > >  drivers/media/usb/siano/Makefile              | 2 +-
> > >  drivers/media/usb/tm6000/Makefile             | 4 ++--
> > >  drivers/media/usb/ttusb-budget/Makefile       | 2 +-
> > >  drivers/media/usb/usbvision/Makefile          | 2 --
> > >  36 files changed, 50 insertions(+), 64 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
