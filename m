Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4F42171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDLPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:22:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46905 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:22:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id s81so5849581qke.13;
        Fri, 12 Apr 2019 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ukz7U+jqimi1cRQqkJBXLAK7ijuw2by0YMv1eq0RRiI=;
        b=ud+o6PodX7NpoGkYA7u8bqIf6AnYaxTpMoM9a6cPcdeD6KCDeBYNcu3dp3d42mVC3E
         Wmor74M2MvF6yWdsVTIdUg9ap7Jjgbn7ejA7sQPqrsNw2h8wZGBQVeE102TA0WuvKReS
         OiL1MYY79wsU5FEGRj9IL4aj90I3QnHDtDbgz1Mm8gI7K+7dtDUJiHUmZMD/2s+AlL4O
         PM0OESFXpHebsaqnZyTpIjIfLBf10JMpqVjNdZlOuQiwj2m0AJoLHHGUaOonLxWP4LqC
         MHGXgJTESUUBhaTKdjWaR7WOp+60l8T4C3brhwA8FgjBV0keKQkBofZvlGuhwiQZNQK2
         Aj9w==
X-Gm-Message-State: APjAAAUZwtin5a/KJQbwqETnGhP1qw6W88a8PDTiqFDiVhBXLShoAwNq
        MFNUL6scJK2e01hZs0n/a1qxQMVczSbJuUzbm+A=
X-Google-Smtp-Source: APXvYqzZkzfMTZFg2sumeHWFy36XGGG+FviC+ivDDxC6l3hO+Vz4wuZUyjs6/S+xBvdcXrsG2QrKXbpWUYlZ43aZEBI=
X-Received: by 2002:a37:f511:: with SMTP id l17mr45410760qkk.296.1555082569439;
 Fri, 12 Apr 2019 08:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <20190412145538.GA24473@lst.de>
In-Reply-To: <20190412145538.GA24473@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Apr 2019 17:22:32 +0200
Message-ID: <CAK8P3a0hNp39POcMD8nO5y487UAWEjmQzGyPbb4xW-o-R6HUCA@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>, mick@ics.forth.gr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 4:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 12, 2019 at 04:53:28PM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > When removing some dead big endian checks in the RISC-V code Nick
> > > suggested that we should have some generic sanity checks.  I don't think
> > > we should have thos inside the RISC-V code, but maybe it might make
> > > sense to have these in the generic byteorder headers.  Note that these
> > > are UAPI headers and some compilers might not actually define
> > > __BYTE_ORDER__, so we first check that it actually exists.
> > >
> > > Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Extra checking like this is good in general, but I'm not sure I see
> > exactly what kind of issue one might expect to prevent with this:
>
> I'm personally not worried at all. Just trying to respond to Nicks
> review comment and make it reasonable generic if we have to have these
> checks at all.  I personally would be ok without them, I just don't
> want them hidden somewhere in the RISC-V code (RISC-V is always little
> endian at least right now).

Ok, makes sense.

Note: I hope we won't ever see big-endian RISC-V, I think that ship has
sailed long ago, regardless of any personal preferences one might hold.

The architectures that allow both (arm, arc, mips, c6x, microblaze,
modern ppc64, superh) tend to just use little-endian in practice, and the
ones that are hardcoded to big-endian (sparc, parisc, m68k, h8300, s390,
ppc32, some mips) are all 25+ years old and do so only for historic
reasons, with openrisc being the notable exception.

       Arnd
