Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEEEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90449206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVN3K5FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVCsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:48:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39091 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:48:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id t8so6188709qtc.6;
        Thu, 21 Nov 2019 18:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kcTUf2TDslgtfE0mrOTBMX2KCORD2HShVFksqMj/7OU=;
        b=bVN3K5FGwZdk81xHSTnUk8DyzV8+J2Ui1N59igzM9LKSic8pC7zBOZLGg8Fs1KZYJ6
         c6xGGIz7pSTAxBl+dD5sfhu1Di0ZHAcGh9TuuLTvfBKf5UrPK1RrUfQQOTW5i22yreiq
         mUrMOiPzoE7fPMQQaLApKVfYyh9FgZNqdly6tXnR1U5vbJzVGWnsu9Ju06ThLp/FjQz4
         OS5XuDtFyCShNwN4+JvG/0p+d6NZt2mS5OmH3PgsCqxalLDOBa0KuRU8euu3OtXU7Lha
         PSzr0EG3ZTCWdpVI9yYBJxYPxQ8+NCTYDmbzFXtqO034W+l+GWO9/lVCAGQkpazDDJgH
         +H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kcTUf2TDslgtfE0mrOTBMX2KCORD2HShVFksqMj/7OU=;
        b=fVcOVsv5QNOUblaSoMHKLqLdV4swZ1Hv+tRfdI4zy/1+np1tPkuqQGlWoPVtv1ciU/
         J7I+WcTk6H9kFgbwRsl6SlFrHT1ZRdeOMHfCSoWtPbqBHj3K42ZjT4V/XaFFD/9FjYG6
         FOdXRcwsg98gEd1w+gsn2hyqmj2hKtSoGrH+YWQxlbv1zpXkA0/arIUGHaaItT4/jRkj
         CshEdgkkfLIvmgiSiDQ/HmkyAPPGoYnbk3NLlDHJaLdja70hUkmZzPEtCyV7k8TPR/Dx
         AFSZVzdcEHTfaekNh4IuwxDLlPpgORF4WET8rUcAVc2Dr/kFQF7lBahkpTLKxKm1n6DH
         j9Pg==
X-Gm-Message-State: APjAAAU//tmQdZRSZvjse3fjy5vjw7gT/MTiMP6p3kJ6cua4xPgWT2qt
        Tc094Wtx7bDAa8+x6YhNDYVEGTCHWB3/5F6/JGs=
X-Google-Smtp-Source: APXvYqwhsbac3UJkuATVMCvOKUJHDGuFPAH/+wmphHO3f7ImjfzwCk5Np3Jdaiw+7WBV1H/QhvlD13ohb2a635elWM8=
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr12124199qtu.28.1574390899451;
 Thu, 21 Nov 2019 18:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20190808173028.1930-1-yamada.masahiro@socionext.com>
 <CAEbi=3cZ29rmO55DcZSi8PmELay08HByabPETu_UOgXKZPk0cw@mail.gmail.com> <CAK7LNATw0V8yzh=62QefN+hHvUfaHNW1ZtSmLhtVJHJDqvbXMA@mail.gmail.com>
In-Reply-To: <CAK7LNATw0V8yzh=62QefN+hHvUfaHNW1ZtSmLhtVJHJDqvbXMA@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 22 Nov 2019 10:47:42 +0800
Message-ID: <CAEbi=3e1WcdD2fkpoyPi6FjWpBD+kFNZtpucmrHtKPj4WvucGA@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unneeded clean-files for DTB
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nickhu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B411=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:24=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, Nov 21, 2019 at 6:46 PM Greentime Hu <green.hu@gmail.com> wrote:
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B4=
8=E6=9C=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:31=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > >
> > > These patterns are cleaned-up by the top-level Makefile
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  arch/nds32/boot/dts/Makefile | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makef=
ile
> > > index fff8ade7a84f..f84bd529b6fd 100644
> > > --- a/arch/nds32/boot/dts/Makefile
> > > +++ b/arch/nds32/boot/dts/Makefile
> > > @@ -5,5 +5,3 @@ else
> > >  BUILTIN_DTB :=3D
> > >  endif
> > >  obj-$(CONFIG_OF) +=3D $(BUILTIN_DTB)
> > > -
> > > -clean-files :=3D *.dtb *.dtb.S
> >
> > Thanks, Masahiro.
> > Acked-by: Greentime Hu <green.hu@gmail.com>
>
>
> Would you apply this to the nds32 tree?

Yes, it will be queued in the nds32 next branch.
