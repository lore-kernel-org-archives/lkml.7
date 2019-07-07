Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E5C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B7F208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="H7dXqGji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfGGGmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 02:42:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43909 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGGGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 02:42:05 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x676fv60005211;
        Sun, 7 Jul 2019 15:41:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x676fv60005211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562481718;
        bh=LddZA2kZHpmw/iDNZuSU0U5CnFfMo3Z/xtH9eTXkW14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H7dXqGjiqDI1P7iiUi7enEIEQQAiXFBp1yh27YuU+vgcvEz/VRdYIySA/t7dijNCb
         OIQOS0FWCzIO8RWwXZmWBDZbG80aUFGT/uNgRROCOOqJ2+4v4IAS9iWgDrpoSYEAPO
         q2OFUnrHQxM18EWPLSpY2iwXZg55RaeUwfphXJOxbTL3oXWUFQmtPszFUiaLiRmUwl
         2irpIy4wLZtyqL30FYprTmetKus+9JCTYd6Cii7nANOzc8KAaPeVx8DAV2FN7RRxGp
         xBse/VhPEwtj8ZMm9JECttShg/SxnoUsisesA4gw0h9YU854Cczvq8emWEjBrXoXAp
         tSdtqSG//Nmjw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id h28so6247836vsl.12;
        Sat, 06 Jul 2019 23:41:57 -0700 (PDT)
X-Gm-Message-State: APjAAAX221d+WmFSnJraJHuOg5Xoq6LwuLRSJtKzKC2ssbwzkXhSdn4O
        Fi7V8Sb9+B6LvhCs22at8VrXBqfu8aKIjq2R0+8=
X-Google-Smtp-Source: APXvYqzN25MgIM65h4khdflzeTEEhr9dnGQ7RpWbobGa8POkBLBZBkYXWQ6tloxVEDn8JcvrG6nlY63VCtgfZbWdYVQ=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr6637293vsq.179.1562481716656;
 Sat, 06 Jul 2019 23:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190605053006.14332-1-yamada.masahiro@socionext.com>
 <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org>
 <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com> <CAKFNMonV+Bsyc6HGP3qSXjrKnQMjhUmQjajt1Dwp0ng7qJaVYA@mail.gmail.com>
In-Reply-To: <CAKFNMonV+Bsyc6HGP3qSXjrKnQMjhUmQjajt1Dwp0ng7qJaVYA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Jul 2019 15:41:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj1=eRJU_-0cz6rSD01CROvqUb+JVWjNpsKvKarvwA5w@mail.gmail.com>
Message-ID: <CAK7LNATj1=eRJU_-0cz6rSD01CROvqUb+JVWjNpsKvKarvwA5w@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu()
 in uapi header
To:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konishi-san,


On Sun, Jul 7, 2019 at 3:11 PM Ryusuke Konishi
<konishi.ryusuke@lab.ntt.co.jp> wrote:
>
> Yamada-san,
>
> I'm sorry for not being able to follow.
>
> Could you tell me how did you find the build error?
> Still I cannot reproduce the error in my environment.


"You can compile UAPI headers in kernel-space" does not necessarily mean
"you can compile them in user-space".

To make sure UAPI headers can be included from libc etc.
you must compile them after 'make headers_install',
but people often miss to test that.

To automate this testing, I will merge the following for 5.3-rc1:
https://patchwork.kernel.org/patch/11024715/

Once it lands in upstream, all the new breakage
will be caught by 0-day bot.

Currently, nilfs2_ondisk.h is excluded from the test coverage
since it is broken.

Thanks.
Masahiro Yamada



> Or, if it's right that we should not use
> cpu_to_le{16,32,64}/le{16,32,64}_to_cpu() in UAPI  header files,
> I will acknowledge the change and modify nilfs utilities to comply
> with the guideline.
>
> Thanks,
> Ryusuke Konishi
>
> 2019=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 13:31 Masahiro Yamada <yamad=
a.masahiro@socionext.com>:
> >
> > Hi Andrew,
> >
> > On Sun, Jul 7, 2019 at 12:38 PM Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> >
> > >
> > > Seems fairly serious.  I'm thinking this needs a cc:stable?
> >
> >
> > Ah, yes.
> >
> >
> > Cc: linux-stable <stable@vger.kernel.org> # 4.9
> > Fixes: e63e88bc53ba ("nilfs2: move ioctl interface and disk layout to
> > uapi separately")
> >
> >
> > Thanks.
> >
> > --
> > Best Regards
> > Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
