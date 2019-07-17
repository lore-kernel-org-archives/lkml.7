Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9164C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A0217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+uzGO6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfGQSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:30:55 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36977 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389117AbfGQSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 14:30:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id i1so2757558ybo.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPbLjCPiukGzfv9R+wh5ohwWe1rNevMdJywRbomHOx4=;
        b=M+uzGO6fQ/CMTI1Il9QcFoHxa6eM4ezURly5vVITUcaslnhew6+OR5+JSQXmFamV3y
         2/mzPhHBCFCtUuwlAGSHj6L1WFlAteND+qMX2fE5pqAT/oM+kmgSIHiiN+Lop8u04TQj
         9TFAY6WFKTz09qnT3CcAylyUcMHJtniGv/M09Z/XwufzVjxl13ueDDfxgeMXinMHpklv
         mq90btak5ZyYZQLbCeEPOpuHaz5j9DvB4iLWViVLlwms1oyeIJleDIauV53gZBcGW4V8
         ab1UtO3jSYscVBq/MnqPkA8vOP/Nb4/7YTYLjQXXStdhcp8IUx1z2P383EDoPcBYAEva
         UP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPbLjCPiukGzfv9R+wh5ohwWe1rNevMdJywRbomHOx4=;
        b=s1IJyrJZl2krxR6mvSFCflD9NT0zSMFpAl4NNX8RjaJWpYUmBIEUgwPvGHoxlp+PUu
         dLgWhzQeljra47/AZgyDBN9iys+RhfN/s1qK1q6YsnRwqpLcOghUjvVRs8vwYV7x752B
         BVTwyF8BlZ0ToTzk0ev+61Vlo8fPote4d1vmhDRuOsXxi/6OIe22zr5nTEq2Q7wXQ5j8
         ZfQa7DszGNn9cj/86rClq2aYnrbHO6EEAE7f4RzlGyENNteANvjpryxe1KIkTRfj1+P0
         3OZUBzCE0LknKRiTCogtoMHA/+GCQKQY5Mp/idZU0hQJ5NcThM8UX45ithaflXwN8YcM
         hPvw==
X-Gm-Message-State: APjAAAVHgHVB/02NUcmF36IFYyE7GwSEHyim7qFyNLMsZnFufo7FZnoc
        nILJ+dCeMYkb0AeKixJoA1l+d5sWxEylOcrWA1XDYw==
X-Google-Smtp-Source: APXvYqxHDm/BVXAHW+g+yJHBAd9A4J3Au6omNUsWJeXSLPTWdz0ELdvuwmJz+UB46bvtz9xHfXZE3OKy6aTOLhUOBu8=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr24759988ybp.226.1563388253765;
 Wed, 17 Jul 2019 11:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <20190717122558.GF12119@ziepe.ca>
 <5d2f51a7.1c69fb81.6495.fbe8@mx.google.com> <20190717165628.GJ12119@ziepe.ca>
 <5d2f5570.1c69fb81.f3832.3c3f@mx.google.com> <20190717171216.GK12119@ziepe.ca>
 <5d2f594d.1c69fb81.baadd.d81d@mx.google.com> <20190717172544.GL12119@ziepe.ca>
 <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
In-Reply-To: <5d2f671b.1c69fb81.59c84.dec9@mx.google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 17 Jul 2019 11:30:42 -0700
Message-ID: <CABXOdTfh5iz3FnkRxZ=ggPNvmegz4_1gRaEPAq-9V=eNcEJPmw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Jason Gunthorpe (2019-07-17 10:25:44)
> > On Wed, Jul 17, 2019 at 10:22:20AM -0700, Stephen Boyd wrote:
> > > Quoting Jason Gunthorpe (2019-07-17 10:12:16)
> > > > On Wed, Jul 17, 2019 at 10:05:52AM -0700, Stephen Boyd wrote:
> > > > >
> > > > > Yes. The space savings comes from having the extra module 'cr50.ko' that
> > > > > holds almost nothing at all when the two drivers are modules.
> > > >
> > > > I'm not sure it is an actual savings, there is alot of minimum
> > > > overhead and alignment to have a module in the first place.
> > > >
> > >
> > > Yeah. I'm pretty sure that's why it's a bool and not a tristate for this
> > > symbol. A module has overhead that is not necessary for these little
> > > helpers.
> >
> > Linking driver stuff like that to the kernel is pretty hacky, IMHO
> >
>
> So combine lines?
>
>         obj-$(CONFIG_...) += cr50.o cr50_spi.o
>
> Sounds great.
>

Please keep in mind that cr50.c exports symbols. If cr50.o is added to
two modules, those symbols will subsequently available from both
modules. To avoid that, you might want to consider removing the
EXPORT_SYMBOL() declarations from cr50.c.

I don't know what happens if those two modules are both built into the
kernel (as happens, for example, with allyesconfig). Does the linker
try to load cr50.o twice, resulting in duplicate symbols ?

Guenter
