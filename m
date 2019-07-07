Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67F6C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9FA2064B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK6dD2Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGGItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 04:49:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39950 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGGItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 04:49:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so10280241oie.7;
        Sun, 07 Jul 2019 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NqawE/+yTi4YYh6osFCXw80KqHxF0kMOsNxC0SIfQXk=;
        b=iK6dD2Z2DEhhBXKpfqfVni6HWx9nM6ELJeAN4hOwPv6dR/0G6Pem/X7JaFuqLXKNq8
         TToT05Kh87pPnXb4odFGTXHaBfZR2KPh4iGCZ0lB5YlNC1MdiKBLqdzzCDepw2Ncp/8c
         2PYTbbqFRwbj8udEa6QfpJ1eVjOEKgtma3Ya9KyLIV0rRwsLSVBfXfvnbHQ0211dftWB
         5mrxe99UjUUf+ZO258Vf/ki/zMmLudpGZNy13bQo2ruzav/Jbdvoqw/VbtK4W/0A3atm
         Wo4GrKWBVAx0aVuN7X1PRCgOfziqHs9xiFG7Wp0mm/VX8Y6n96CcDcQnHnKeOo0s0E+z
         sLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NqawE/+yTi4YYh6osFCXw80KqHxF0kMOsNxC0SIfQXk=;
        b=KORzdeyaoUZV2xRno6pqDMeZVVEwzAYwwjZ0RcKpN2DhMr/Y6ffNJH2UIVsYsP24Uh
         U/UE5qdqJt6QZnQeY7X9DSlcAjAa3xD5OGuf7v4cieN03hNHH4rUQqVuiwGc6TLt82iA
         OfcPZn2rOYrnNXgE7zU9Xb4L1cpTDKrmSGlw+qDowJivKSjfTFQZUXAWWCsU8s/2IClC
         fs7WndurTl9yMsNT90PKJCL4IGKiRc9vgCYCDNulQ4BNLVMHePTnGUgPlCG8v2xtz2lS
         ggrOIsDfmDRn7BvmdWDdCX3zLulP6uLVXoz4QfkmxrX6wTIRFNhwVZr7Ns2+mfv6eUJz
         SXIg==
X-Gm-Message-State: APjAAAUSkkRhAKUWBK4nFuKMmmAc2AWbbay58f/qpaXCRPfWEya0N1e6
        /uRHdrFcE6CdpB7qXDLyX+kFYLb7I2X7aUVLzPM=
X-Google-Smtp-Source: APXvYqzCcNJqDAxQPRmN4iKsMTBUthBDhw13ChmcaGv6tUAWv+9Y+Q61G12uyCWid7QmlFw0Ijla3EVqmGqKJgTq/U4=
X-Received: by 2002:aca:1b04:: with SMTP id b4mr6197172oib.157.1562489338923;
 Sun, 07 Jul 2019 01:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190605053006.14332-1-yamada.masahiro@socionext.com>
 <20190706203745.af0bf9bd5dd46e94fa5e1ff9@linux-foundation.org>
 <CAK7LNARCjucs=0BD=00SD8Ljh+a0GtCUNHF4En=eSM1+VG0-4g@mail.gmail.com>
 <CAKFNMonV+Bsyc6HGP3qSXjrKnQMjhUmQjajt1Dwp0ng7qJaVYA@mail.gmail.com> <CAK7LNATj1=eRJU_-0cz6rSD01CROvqUb+JVWjNpsKvKarvwA5w@mail.gmail.com>
In-Reply-To: <CAK7LNATj1=eRJU_-0cz6rSD01CROvqUb+JVWjNpsKvKarvwA5w@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 7 Jul 2019 17:48:46 +0900
Message-ID: <CAKFNMokG-5_wCnSe-AcbG9X=jiRqh9je4DttBecUyind0urtAQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu()
 in uapi header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
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

Yamada-san,

> To automate this testing, I will merge the following for 5.3-rc1:
> https://patchwork.kernel.org/patch/11024715/

Thank you.  I could get the series through linux-next tree, and
could reproduce the build error by enabling the new coverage test
for nilfs2_ondisk.h.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Regards,
Ryusuke Konishi

2019=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 15:42 Masahiro Yamada <yamada.=
masahiro@socionext.com>:

>
> Konishi-san,
>
>
> On Sun, Jul 7, 2019 at 3:11 PM Ryusuke Konishi
> <konishi.ryusuke@lab.ntt.co.jp> wrote:
> >
> > Yamada-san,
> >
> > I'm sorry for not being able to follow.
> >
> > Could you tell me how did you find the build error?
> > Still I cannot reproduce the error in my environment.
>
>
> "You can compile UAPI headers in kernel-space" does not necessarily mean
> "you can compile them in user-space".
>
> To make sure UAPI headers can be included from libc etc.
> you must compile them after 'make headers_install',
> but people often miss to test that.
>
> To automate this testing, I will merge the following for 5.3-rc1:
> https://patchwork.kernel.org/patch/11024715/
>
> Once it lands in upstream, all the new breakage
> will be caught by 0-day bot.
>
> Currently, nilfs2_ondisk.h is excluded from the test coverage
> since it is broken.
>
> Thanks.
> Masahiro Yamada
>
>
>
> > Or, if it's right that we should not use
> > cpu_to_le{16,32,64}/le{16,32,64}_to_cpu() in UAPI  header files,
> > I will acknowledge the change and modify nilfs utilities to comply
> > with the guideline.
> >
> > Thanks,
> > Ryusuke Konishi
> >
> > 2019=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=97=A5) 13:31 Masahiro Yamada <yam=
ada.masahiro@socionext.com>:
> > >
> > > Hi Andrew,
> > >
> > > On Sun, Jul 7, 2019 at 12:38 PM Andrew Morton <akpm@linux-foundation.=
org> wrote:
> > >
> > > >
> > > > Seems fairly serious.  I'm thinking this needs a cc:stable?
> > >
> > >
> > > Ah, yes.
> > >
> > >
> > > Cc: linux-stable <stable@vger.kernel.org> # 4.9
> > > Fixes: e63e88bc53ba ("nilfs2: move ioctl interface and disk layout to
> > > uapi separately")
> > >
> > >
> > > Thanks.
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada
