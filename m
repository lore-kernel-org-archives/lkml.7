Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A6EC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BADC21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GKihMbDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgADDFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:05:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36959 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgADDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:05:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so43158558edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 19:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BX71mgvvvVJh9j5iXPwViX8nZ94MAki9yZVDXDO37LU=;
        b=GKihMbDOaV19EjeFPkZGhmjTZbw93ryUZdGEcLqWz6jSeSvH12zmcFnClKJ7lNe8wz
         fTUBYyq76Z1DXbB4ADmyiusb9Nmqg96PcnNxI8BqcVOreHjJL0JR6XGKOOtsm62xszsf
         CTF399PYOk/Qd4mv2dEgZOZbuGDWHz/2nQ9oUlfdRw2xzsiy5HGXC0JaXSFvRBtoBtx2
         wEgjNBoBFTzXbv1eqCDTctJWsd5obGUemdv+NQduZ5biriMG2NRTU/B8Ka8T8ej614BA
         SqnkTgevuhSBs9FhEFntlRPr9XUpO1+N4gK+UWQO22wkXdwiEpZerdXCwzz+uPTCHIji
         +49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX71mgvvvVJh9j5iXPwViX8nZ94MAki9yZVDXDO37LU=;
        b=Y9hBuIMqJ/JcvALpqsBI4GIhrsRJEeVLPhKXiHzIkM6zeiUtXRFsoxgZoZ0+s0xebv
         /AXZzVEalO4xL3ubFJXnDbpEfj2FEyBo+r6HlL4lxNC5QUSWjlgM3ZDp678oMj6nblqp
         hl3718g3LZvVdjhKSPk1+iD5/g719vZ1cecjyFBA1qkhuKAHRD0lz0ZOAhbnNstnvrT3
         nuglplAxquz63Tq/4BJz66Scr/mFVzjVwAImxJTWdpdfX4AN979caoBM9CM8Lot0Ei+x
         EyyYuDAGsYjIDLM5ayFjxArgglpO9P5AbjHj8tHfp8J0MTHLzAZzOPeGyejlUh8a6WI3
         r3Iw==
X-Gm-Message-State: APjAAAVM02TWiyAf05LhsJPjbsFKakKXHJx2L6qXfwhS/rkmxZODrxJg
        wi+nYN6LkuOnyB7rmMdCxrl82dB/QX3o5FHTrXkifg==
X-Google-Smtp-Source: APXvYqzZ0eubPcmwmULBhcmjqX4h6azQKzY92sBUMA+/NNA6rHzORNOjcdialMwlS8H7ALL/gObAMIdC0ceTZKJx1G8=
X-Received: by 2002:aa7:c389:: with SMTP id k9mr95278721edq.63.1578107116352;
 Fri, 03 Jan 2020 19:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20191218170603.58256-1-olof@lixom.net> <alpine.DEB.2.21.9999.2001031723310.283180@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001031723310.283180@viisi.sifive.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 3 Jan 2020 19:05:04 -0800
Message-ID: <CAOesGMir810kVTDyoTFuhK-PdFe4J2u2VM+L8jOdO8DghAELQg@mail.gmail.com>
Subject: Re: [PATCH] riscv: change CSR M/S defines to use "X" for prefix
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 5:28 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Wed, 18 Dec 2019, Olof Johansson wrote:
>
> > Commit a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs
> > machine mode") introduced new non-S/M-specific defines for some of the
> > CSRs and fields that differ for when you run the kernel in machine or
> > supervisor mode.
> >
> > One of those was "IRQ_TIMER" (instead of IRQ_S_TIMER/IRQ_M_MTIMER),
> > which was generic enough to cause conflicts with other defines in
> > drivers. Since it was in csr.h, it ended up getting pulled in through
> > fairly generic include files, etc.
> >
> > I looked at just renaming those, but for consistency I chose to rename all
> > M/S symbols to using 'X' instead of 'S'/'M' in the identifiers instead,
> > which gives them all less generic names.
> >
> > This is pretty churny, and I'm sure there'll be opinions on naming, but
> > I figured I'd do the busywork of fixing it up instead of just pointing
> > out the conflicts.
> >
> > Fixes: a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs machine mode")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Thanks for taking a stab at fixing the issue.  I queued the following
> minimal fix has been queued for v5.5-rc, adding an RV_ prefix to the IRQ_*
> macros.  It may be that we need to do the same thing to the rest of the
> CSRs.  But, based on a quick look, I think we should be OK for the moment.
> Let us know if you have a different point of view.

Sure, this does the job. I'd personally prefer consistent prefixes but
that's just bikeshed color preferences -- this is fine.

Acked-by: Olof Johansson <olof@lixom.net>

(Builds are still failing for some configs, but will be fixed if/when
you pick up https://lore.kernel.org/linux-riscv/20191217040631.91886-1-olof@lixom.net/)


-Olof
