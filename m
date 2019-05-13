Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84540C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3282085A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ6ygksW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfEMLuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:50:32 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37741 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbfEMLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:50:31 -0400
Received: by mail-it1-f193.google.com with SMTP id l7so19771021ite.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ghfMy6obv1hrpZpCwIJ2TJb+OktMKKHOCaRgouBZNU=;
        b=RQ6ygksWQIZXg92jHryig/GzewJP/tQhrxquLavPhVBu0Y2wASBIuqsa+HGqF88A6F
         O+rpZdrLF7sxwiQspnZGxb6Y5DPFZTj0I2Nz7vFJshQCpB2PoElVv0MvXbkETGwCwSLe
         HCxPwApZSxtMvzLe4hqx+XfVSbogEkrUeU8wIZ371zkoDF3Rrpe8mJZCOlSV/9H60wUH
         GoIE6K7V+lSdLJb3xjsJpBen0dHq89nE1v6CNMEGE2JQEoDnFef2WlsEvw7JOgZZI1cm
         SLksF16OHOQLUUs/V/xSCRZRWP9YT8ia9aSVG249Txp1MJ2ydmq9/7jNJJcPj9Z7GOZd
         f0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ghfMy6obv1hrpZpCwIJ2TJb+OktMKKHOCaRgouBZNU=;
        b=cSNHTNYPltBdZS1+TvupIrwPkgyIMWjiZrmfFH8CdvpJk2P+HtN4A8dhg5H1yTRg+E
         heF7pVa9LP+FfaSszlLfiW+rs2FVVzvJ3QNcp0PwgaSMZdsYVsz+AHxiwho0rHtNoj8W
         BuzAAUGHCTvQdP+Iq+OIPB/Q4eVO9gNKZgK5g7UCmulPMGgoSluUORMK3MzXsqpL2cS/
         kIUqgX9/CbKE2yTYt5jDNV9tjfSoFEInn8o6eXspqvx58oGd/u8AKtjB78shDca3qIV6
         CwE5ZAPoKu2Q5b4aSX7XMIUNOJ4xps/DuUH5jdAPcZx6YDe6+vLFCjECS6o8OrT/9cPX
         JWNg==
X-Gm-Message-State: APjAAAX9zHdp4oebLLuwUUdXC8x4HUJw9HM9xLxSI0qNzCO2/JpBkId9
        OW8MesR/d833K3rDpNQQfslElTmkZb0dAek9Q/hf0g==
X-Google-Smtp-Source: APXvYqwCpb/dVYCrrcvfOEBMqYrddeQJKCrNmIoP+Lnj3ljNYuESeWa8kIYaOWHaeDVEpbuKQnDmFYg8XkabJ4V7PyY=
X-Received: by 2002:a02:1384:: with SMTP id 126mr17144580jaz.72.1557748230654;
 Mon, 13 May 2019 04:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
 <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
 <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com> <87woiutwq4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87woiutwq4.fsf@concordia.ellerman.id.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 May 2019 13:50:19 +0200
Message-ID: <CACT4Y+YT52wGuARxe9RqUsMYGNZTwaBowWWUUawyqTBq4G1NDg@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, May 13, 2019 at 1:33 PM
To: Dmitry Vyukov, Arnd Bergmann
Cc: Nick Kossifidis, Christoph Hellwig, Linus Torvalds, Andrew Morton,
linux-arch, Linux Kernel Mailing List, linuxppc-dev

> Dmitry Vyukov <dvyukov@google.com> writes:
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Sat, May 11, 2019 at 2:51 AM
> > To: Dmitry Vyukov
> > Cc: Nick Kossifidis, Christoph Hellwig, Linus Torvalds, Andrew Morton,
> > linux-arch, Linux Kernel Mailing List, linuxppc-dev
> >
> >> On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >> > >
> >> > > I think it's good to have a sanity check in-place for consistency.
> >> >
> >> >
> >> > Hi,
> >> >
> >> > This broke our cross-builds from x86. I am using:
> >> >
> >> > $ powerpc64le-linux-gnu-gcc --version
> >> > powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
> >> >
> >> > and it says that it's little-endian somehow:
> >> >
> >> > $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
> >> > #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
> >> >
> >> > Is it broke compiler? Or I always hold it wrong? Is there some
> >> > additional flag I need to add?
> >>
> >> It looks like a bug in the kernel Makefiles to me. powerpc32 is always
> >> big-endian,
> >> powerpc64 used to be big-endian but is now usually little-endian. There are
> >> often three separate toolchains that default to the respective user
> >> space targets
> >> (ppc32be, ppc64be, ppc64le), but generally you should be able to build
> >> any of the
> >> three kernel configurations with any of those compilers, and have the Makefile
> >> pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
> >> depending on the kernel configuration. It seems that this is not happening
> >> here. I have not checked why, but if this is the problem, it should be
> >> easy enough
> >> to figure out.
> >
> >
> > Thanks! This clears a lot.
> > This may be a bug in our magic as we try to build kernel files outside
> > of make with own flags (required to extract parts of kernel
> > interfaces).
> > So don't spend time looking for the Makefile bugs yet.
>
> OK :)
>
> We did have some bugs in the past (~1-2 y/ago) but AFAIK they are all
> fixed now. These days I build most of my kernels with a bi-endian 64-bit
> toolchain, and switching endian without running `make clean` also works.

For the record, yes, it turn out to be a problem in our code (a latent
bug). We actually used host (x86) gcc to build as-if ppc code that can
run on the host, so it defined neither LE no BE macros. It just
happened to work in the past :)
+Andrew
