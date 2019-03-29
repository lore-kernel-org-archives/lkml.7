Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C9DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2FB21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ln8pCRJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfC2Vpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:45:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37659 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbfC2Vps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:45:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so3480836otn.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0OFsvlxEQNd0+haHfsVo0YdMyMm7iz+X8iwm5qqJGw=;
        b=ln8pCRJDI582zd9uMCAAliHnXOsO+68A2KPuCuwp8QrWe4kUAhw/qVOqpm4u2p/Ajr
         jix8y1jGwT7MSqswVuWFG+Uc2oILC2RifyiSgvKImoSitxjcY22GIZGpcXwrKa7ww/Md
         cslQCGlxb7c4jOaHJe2YvELdzt3LcI7R3ViEj2jvlUMEaz9I3x9s0Z68X+MOsx5oOBvw
         bYwnCI1kRqRTHMqlbXwiY+5e8sneFjZZi1TI9jyxhboWJJSZgkmzuKbkFFYbYUcSzxfk
         6xtuAXfWNWb6xXRZQna0P2IbP4nk3hKanttBhMoEH24Y3fsRJjkYZ82Kl4jcxdEqY+mZ
         fHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0OFsvlxEQNd0+haHfsVo0YdMyMm7iz+X8iwm5qqJGw=;
        b=Df7B3ARgYiwR0GsGJU6IXVFG3oaMrhXY3keh2rvRXnplKuteRNN5qO96Rbg8LGU7Gr
         OShGOiQyK78rmYSPjfu26LtCgm1F2mw8E0ZcM5lZAg0ZFRwV027wtaao8l3kVzvrL5kM
         hGI4PMWHRvgaMRaodWCUDqJbQqRgMApeihg5xL3errDasOeTIV7WdEap3FrHtRn3TOA6
         rIgYNGFkU9JTL8hr61ezkacRScqcR6dGnXyu72qoROoYqCG5sALleK9IF2x8dYF4JEZe
         60XQHGGwgYoam32z3IpV1HQlnSxIJNiCxzrDGmmS5FzyTcw/LPHo30OrSB0pryPN0+Lk
         Rrow==
X-Gm-Message-State: APjAAAUhjhOKxeGE/QNUvgVy4cZnmRwnSRyagr+sPYeBwStmfecgyqnj
        qzDgAD9h/KMd+CN+Los98m3EXvxsCoINTsyt1IDyBg==
X-Google-Smtp-Source: APXvYqy7qiyEoOGfaBqNCv3CZ9h6mKRBUjCwoysY6ysi4M3b765oEIVK3Vr+MBXBiq/xMiJ1iOHPBTZgwMPNmdN2nuM=
X-Received: by 2002:a9d:309:: with SMTP id 9mr35244289otv.230.1553895947677;
 Fri, 29 Mar 2019 14:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190328225925.241998-1-jannh@google.com> <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
In-Reply-To: <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 22:45:21 +0100
Message-ID: <CAG48ez01TR7xBRgdAyvoHBjttn-ffr-8KBS8sJ904TDm4FLH+Q@mail.gmail.com>
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
> On 3/29/2019 4:29 AM, Jann Horn wrote:
> > The sparse checker attempts to ensure that all conversions between
> > fixed-endianness numbers and numbers with native endianness are explicit.
> > However, the calgary code reads and writes big-endian numbers from/to IO
> > memory using {read,write}{l,q}(), which return native-endian numbers.
> >
> > This could be addressed by putting __force casts all over the place, but
> > that would kind of defeat the point of the warning. Instead, create new
> > helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
> > native endianness.
> >
> > Most of this patch is a straightforward conversion; the following parts
> > aren't just mechanical replacement:
> >
> >   - ->tar_val is now a native-endian number instead of big-endian
> >   - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
> >     intended to do `be32_to_cpu(readl(target))` (but that has no actual
> >     effects outside of type warnings)
> >
> > This gets rid of 108 lines of sparse warnings.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > compile-tested only
> >
> >   arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++-------------
> >   1 file changed, 64 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
> > index c70720f61a34..36cd66d940fb 100644
> > --- a/arch/x86/kernel/pci-calgary_64.c
> > +++ b/arch/x86/kernel/pci-calgary_64.c
> > @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short device)
> >       return (is_calgary(device) || is_calioc2(device));
> >   }
>
>
> Can the existing api's not be used here like iowrite64be/ioread64be/ or
> similar variant in "include/asm-generic/io.h"

Given what Logan said, I think it probably makes sense to keep the patch as-is?
