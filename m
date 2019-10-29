Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA14C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5338B20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 02:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYXgJtgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfJ2Cs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:48:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43364 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfJ2Cs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:48:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so4492901wra.10;
        Mon, 28 Oct 2019 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gteraG87XCdj5xSgInB/PvpzdZKgoT7TtTZ9+9ieQnY=;
        b=KYXgJtgop4xEAbJ5U1sDVAAOoFj+g+2/3RxYykRDsFMlUNtjtSnnULpJApifFpS1F/
         nRmou4871/MmQQ9ysAKm5FqNeQGG8kX1/mzKsX21kaeZw9C89wrnk8wx5XG3GsbIe3em
         So/+8DdijXhe5gsZcmF2xO7NFlcTVLj7mdV1FgGXSkI+FEk37Ce8NzQyXdnp99ofWgj1
         X054yld+7l2G57BpTVXp6ikjfZyJ1Q5+/8Yj/mXLXuAydorFc4jr+aXoAGthRP2GGESh
         ri8fDPLvfL5WJLkWEjBVVAkZhgWvNUTt11IUyGRnsHFsQrssOkFksFEOYG79rrGoZ11w
         ojlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gteraG87XCdj5xSgInB/PvpzdZKgoT7TtTZ9+9ieQnY=;
        b=LD5EQ7zjKSLXjYBMSjVWK9u60yjti6LQLXlVS5S939va0MVyWGSaFhLSyIlk4njyiC
         AHzr37EQLl9e0Lhmn2O5P4pNJUnSBaM5605lO17nl3UN0+ynP7CYp62Fv7il6HglM3N6
         BkVxGn7D9kyMDR4R/AkmrSIUpUewYrd3PzWlX/lmhPQqqh56Av/TaR9zdbpzR9UTyLdu
         shTW2hVLwKwkR208U9Ij8/kM/SuYncUB0wVWeEYLNMPJxTKyezbTEJ8Vq6YApega5Eqv
         l0jLJebKaJ8YRWZuu5VIsVuMU1ZFyDs/Oia/mTRsQbjavptZ30bxA6AnMs8q/hFnnZLC
         E9WA==
X-Gm-Message-State: APjAAAVhQ1tt2FO/HkYXFXyoNeAOA7z6BJvNhe//CzEAGU23Xfo748tQ
        4Bt0tVP2o7jHPmuBvBw5HJOdVORp0toC2ryE8JU=
X-Google-Smtp-Source: APXvYqyCnGBv7rgt4wt2fvjFkhPMhg3/hSA/t9Nk3hOEOwreIo3dDyDVdayfbU1xUEfSkz5mRqAK9ayZBItouzgdpyk=
X-Received: by 2002:a5d:6281:: with SMTP id k1mr17999142wru.69.1572317304467;
 Mon, 28 Oct 2019 19:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-2-chunyan.zhang@unisoc.com> <CA+H2tpHkYwQLEO7ftLebErsEXBQnRS37gFOoKoG+_jnt5+0r-A@mail.gmail.com>
In-Reply-To: <CA+H2tpHkYwQLEO7ftLebErsEXBQnRS37gFOoKoG+_jnt5+0r-A@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 29 Oct 2019 10:47:48 +0800
Message-ID: <CAAfSe-uz396tvOSa6g-BJpwzARDi2uaPrCsP01f3A-Jww_c7BA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: Add a new compatible string for SC9863A
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2019 at 10:11, Orson Zhai <orsonzhai@gmail.com> wrote:
>
> Hi Chunyan,
>
> On Fri, Oct 25, 2019 at 6:30 PM Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
> >
> >
> > SC9863A use the same serial device which SC9836 uses.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  Documentation/devicetree/bindings/serial/sprd-uart.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > index 9607dc616205..0a9f8a7809e1 100644
> > --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> > @@ -4,6 +4,7 @@ Required properties:
> >  - compatible: must be one of:
> >    * "sprd,sc9836-uart"
> >    * "sprd,sc9860-uart", "sprd,sc9836-uart"
> > +  * "sprd,sc9863-uart", "sprd,sc9836-uart"
>
> Duplicated 9836 with above line?

We can just use "sprd,sc9836-uart" for SC9860 and SC9863 SoCs though,
added a new compatible string in case we'll have some difference for
serial on SC9863A in the furture.

Thanks,
Chunyan

>
> -Orson
>
> >
> >  - reg: offset and length of the register set for the device
> >  - interrupts: exactly one interrupt specifier
> > --
> > 2.20.1
> >
> >
