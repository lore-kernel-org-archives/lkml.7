Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C3C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49070207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NGQHlcSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503083AbfIWV2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:28:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44699 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfIWV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:28:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so8936888oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyHYr4tKJV5lm5mCsroazIfQVv/o2NZykn1ewMncF1E=;
        b=NGQHlcSav/bgAy0eYIW53+dy/MJrBGnm/wJo/dyC6cSQz2MBKGA+ojlsAtSmF+sNqx
         VDe35TDuB3eR9akecJZqu0672y6M1btk3QjNhM0W5H03Av5y2+aoRQtBIsjRU+xVE5VC
         1UBa1ee6GuKxKeg/pk+O6mETUjjJe9JhyaORgmMk7BJIEZb92MqzJMI3CY3IKgltjkcz
         RzBefvQMUpmHq5pmUTkUtc8uN3Q4s4nbbD0eHMU+35Tlhq493UsRICNmI61PMnY9yhcD
         8C9QXUMyy24XJIb9siYolXYHhgLtn3sS+fBYKxNXpq5mpgJSCZV9fkeDvNuLj0crF7Nf
         maRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyHYr4tKJV5lm5mCsroazIfQVv/o2NZykn1ewMncF1E=;
        b=ZXUos9wnSfWpQolm6mIoSlE/0+fWEsSrVDsF05LNlSkiZKIWmWY2q73DfWhxV0Rb1y
         p0HMJ3xbww95Qfu8YktEZhqaehs/KjH537lKa0SkdHVi/p0MoqWaljzuamJjgPUX4Uug
         y2DpDpFZbBSaNyEkqgpp2X4Yfmg2dhwuDzdZ1mHhFDGiPhBV/tIv5/k0vcDBJ4k/U8oE
         RPXjIZFulLB70lO11/gxExRutqzfx00oYepEQV45NoZFxLKBNP/TBqlM/ZkvaggDAC3K
         sShPeuW3woO4gmipcUSBdbrtI6Q/QsPOSfDmSjvvDMXfIe9puOIcwdCtG/lIVIAytmHK
         6TYA==
X-Gm-Message-State: APjAAAUFkYdh54HQY2E0BRwxofufut9jfVb8YswWZs2NCDSqQEBHRH0H
        hCA6KsvJaMg9DDaUjuh7K63CRXnp14db9UzS/DN6pg==
X-Google-Smtp-Source: APXvYqwPptlgnNLhw8/JNeUDzZMDmvZaQh9W9r9dY79Z4Drq6xjXrXwxYv3zs9ifbmG3vIRSplJeJvadjfJHqOqkkLc=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr1856981oia.70.1569274082986;
 Mon, 23 Sep 2019 14:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com>
 <1569003478.5576.202.camel@lca.pw> <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
 <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
In-Reply-To: <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Sep 2019 14:27:52 -0700
Message-ID: <CAPcyv4hSjL+kjR1is3O5BPp8K4763SvDhuUzSTc6O6JNtfW2ew@mail.gmail.com>
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
To:     Michael Ellerman <michael@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 5:04 AM Michael Ellerman <michael@ellerman.id.au> wrote:
>
>
>
> On 21 September 2019 4:31:16 am AEST, Dan Williams <dan.j.williams@intel.com> wrote:
> >On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
> >> > Qian Cai <cai@lca.pw> writes:
> >> >
> >> > > The linux-next commit "libnvdimm/dax: Pick the right alignment
> >default when
> >> > > creating dax devices" causes powerpc failed to build with this
> >config. Reverted
> >> > > it fixed the issue.
> >> > >
> >> > > ERROR: "hash__has_transparent_hugepage"
> >[drivers/nvdimm/libnvdimm.ko] undefined!
> >> > > ERROR: "radix__has_transparent_hugepage"
> >[drivers/nvdimm/libnvdimm.ko]
> >> > > undefined!
> >> > > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
> >> > > make: *** [Makefile:1305: modules] Error 2
> >> > >
> >> > > [1] https://patchwork.kernel.org/patch/11133445/
> >> > > [2]
> >https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> >> >
> >> > Sorry for breaking the build. How about?
> >>
> >> It works fine.
> >
> >Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
> >default when creating dax devices" until after -rc1 to allow Michael
> >time to ack/nak this new export.
>
> Thanks Dan. It looks fine to me:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks Michael. Aneesh, care to resend with this ack, but also reword
the changelog to say that this patch is a pre-requisite for the follow
on patch to pick dax device alignment? In other words, lets hide this
compile breakage from git-bisect by merging this export before the
consumer patch.
