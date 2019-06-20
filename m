Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA76C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437420675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xS2e0vVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFTNYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:24:36 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36775 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfFTNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:24:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 92bb9596
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jun 2019 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=buuGxRbiljVQ1M+Fw4egylsWiag=; b=xS2e0v
        VWC84LB4X8si8VyMDnZ/P7BqyIFPsUnl7OBPZUInR+AXl3d0LcfwirP9Cids8P1B
        P2JQqvcNPiPaVIZAMDw92Lt68VZ2jPKZurwTZcpVp5NsshuxcDCRHzn9JPjrOa2r
        4Hk/daJuSyVYi56d5w4BFfNybz2s+iHMBgSLF4FigH+/gRMGZZ/cZqAibmEaXXvs
        l4D2LWInZhSqEZPbutEhai7/AjoqgMcVyGEjCcIJnai8WrnEIT2qwDDAA3yFCkrZ
        I6v6xpIGwGE9kZYKjjblLmKIwUbzCK9+9wcCgaCSfEnD/tg1t+1oxdLv33X2pg9e
        oHKp2+Pgj2rst+Og==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb021434 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jun 2019 12:51:18 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id f80so2158436oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:24:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXGPxPxoTpgJuT6s9uQuYB8f8TP7nn/yEJpIDEB0fytIBKvCNB7
        wSaoQ6k2Zlo533V1MHotAVxuH9QxJzP1Rc/v6Vs=
X-Google-Smtp-Source: APXvYqzL6YYexbjr9Gdc3uqo2aznO6F8wUNeJtdUFw2jM8PYeeYSv1dvItccSdmf+oRTg9BBakqGw6XePKSW28jqbz4=
X-Received: by 2002:aca:ccd2:: with SMTP id c201mr5665543oig.119.1561037073347;
 Thu, 20 Jun 2019 06:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190619142350.1985-1-Jason@zx2c4.com> <CAK8P3a10PfTOhLA9d3vMTV_YXqymKLNeqCg6r7dLiNA1BwJbmA@mail.gmail.com>
 <CAHmME9rYgKxNyLH4MFJwaj4188O5N6vjseQRHwF0n5pZhU8kuw@mail.gmail.com>
 <CAK8P3a1Wirao3s4Xz4Rgkc1FkpT4isMNuuPv7X7orwX4fcotXg@mail.gmail.com>
 <CAHmME9pk7zXMSGiofPMppzA=dy__qttg00LtwqU7oSz032jtWQ@mail.gmail.com> <CAK8P3a2oLUKjY+3Qki59ruygzSb1Vsaoo5Et3BecGzpG8-=tOA@mail.gmail.com>
In-Reply-To: <CAK8P3a2oLUKjY+3Qki59ruygzSb1Vsaoo5Et3BecGzpG8-=tOA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Jun 2019 15:24:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
Message-ID: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: get_jiffies_boot_64() for jiffies that
 include sleep time
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 10:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 19, 2019 at 10:07 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Wed, Jun 19, 2019 at 10:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > get_jiffies_boot_64 26
> > > > ktime_get_coarse_boottime 26
> > > > ktime_get_boot_fast_ns with tsc 70
> > > > ktime_get_boot_fast_ns with hpet 4922
> > > > ktime_get_boot_fast_ns with acpi_pm 1884
> > > >
> > > > As expected, hpet is really quite painful.
> > >
> > > I would prefer not to add the new interface then. We might in
> > > fact move users of get_jiffies_64() to ktime_get_coarse() for
> > > consistency given the small overhead of that function.
> >
> > In light of the measurements, that seems like a good plan to me.
> >
> > One thing to consider with moving jiffies users over that way is
> > ktime_t. Do you want to introduce helpers like
> > ktime_get_boot_coarse_ns(), just like there is already with the other
> > various functions like ktime_get_boot_ns(), ktime_get_boot_fast_ns(),
> > etc? (I'd personally prefer using the _ns variants, at least.) I can
> > send a patch for this.
>
> That sounds reasonable, but then I think we should have the full
> set of coarse_*_ns() functions, again for consistency:
>
>                 u64 ktime_get_coarse_ns(void)
>                 u64 ktime_get_coarse_boottime_ns(void)
>                 u64 ktime_get_coarse_real_ns(void)
>                 u64 ktime_get_coarse_clocktai_ns(void)
>
> and document them in Documentation/core-api/timekeeping.rst.
>
> We seem to also be lacking the basic ktime_get_coarse(), which
> seems like a major omission.
> Both ktime_get_coarse_ns and ktime_get_coarse can be wrappers
> around ktime_get_coarse_ts64() then, while the others would
> use ktime_get_coarse_with_offset().

Exactly what I had in mind. I'll have something posted fairly soon.

Jason
