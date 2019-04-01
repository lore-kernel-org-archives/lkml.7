Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C83C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DE420850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 01:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KtQNZvoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfDABFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 21:05:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23679 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfDABFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 21:05:23 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3115Ahc023159
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 10:05:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3115Ahc023159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554080711;
        bh=VcswJh4pPO40p/qkhstAY6Wwwcr4Qf2MyUnW0QBEU/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KtQNZvojLNMF/euqRT9+YA3t0KSLegmGxdWDT3gqWKpJ/ZoCjWXxf0mrAEHR7jHQa
         IClwSxuHCz59IVdbMd2bCZNhYPrVOsJ9l/V02/yP8qjMZpCce9x1gnYiqvSoJpiA8+
         ciNMidOCTAzAwGL77MveKaXRLt2DC41BtoIlbzD7ELpdoGlzcNXc4AVpvGmC7s3cpK
         qfpuCnbDwOGQshHiwaqupTwyPAxSGFg551olqdvYPhM182VV7gNgejy/iYWYs/Y3tH
         lMnm2Cq5kAIt1l2zde1bFaVKx9xjcXtRfbIHSdQ3DMGs/q3LSrt5G4dBRY6nQe+qvH
         eGiqoRKP3Oi7A==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id t78so4504274vsc.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 18:05:11 -0700 (PDT)
X-Gm-Message-State: APjAAAV/AftJ1m0qLx6b+JH8abpqogS/3rP+1suEYgSXJYyS9u/lOXlg
        NFqT4+jVBDerr3MjfLYtUQ7lUPro8wAomafAgKQ=
X-Google-Smtp-Source: APXvYqxTa6Bk1Xg0+mo6H1zjNm2tcUidt5cuYTEtH+AuqFeNatbu01GilmXLGOenoKsjDVVyT5gwtZ2Q1SkjHckpA3Q=
X-Received: by 2002:a67:74cd:: with SMTP id p196mr36469211vsc.215.1554080710039;
 Sun, 31 Mar 2019 18:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-2-andi@firstfloor.org>
 <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
In-Reply-To: <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 1 Apr 2019 10:04:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3qUuNwQFfqcjyiA3Qus1x_zUFHbvop88Y1UReRwvgHA@mail.gmail.com>
Message-ID: <CAK7LNAR3qUuNwQFfqcjyiA3Qus1x_zUFHbvop88Y1UReRwvgHA@mail.gmail.com>
Subject: Re: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc 9
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andi Kleen <andi@firstfloor.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 22, 2019 at 10:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 21, 2019 at 11:00 PM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > This warning is very noisy in a default build with gcc 9.
> > Move it into W=2 only.
> >
> > Cc: arnd@arndb.de
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
>
> I think W=2 is too aggressive. On many architectures, this finds
> real bugs and the false positives tend to be trivial to fix
> (by removing the bogus __packed annotation), which improves
> the generated code in the process.
>
> Moving it to W=1 for the moment is probably fine, but ideally
> I think we should fix the kernel to behave according to the
> C standard.
>
>       Arnd



I agree to disable this warning option
since we see a lot of instances.

The room of argument is W=1 or W=2?
I do not have a strong opinion either way.

Arnd most actively takes care of warnings like this.
If he looks into these warnings, W=1 is fine with me.


-- 
Best Regards
Masahiro Yamada
