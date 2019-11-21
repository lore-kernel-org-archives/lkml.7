Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325DB20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s5RDdIke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUAVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:21:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41931 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUAVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:21:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id e9so1548901oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InRuHr3W77Nv6V1yM3zDnBudo6+MLUc6w96cK0lUxNw=;
        b=s5RDdIke4ZEiA2L1vbsTbYfPBv2dMoqm5GydLq9nTf3LzpTnkhfaWCPF2sKBg8lHXG
         qXKzFZx44HST5dHAfo3edgvzRZXer+avSJm7T2AS9uVs3NAcSyMZaByGdQEkHyh+cnw0
         mFnzGJMgktA+KpQ2wr3tX8YD2zxXjz6H9NzPSafoY0NLB3RZdz/lvq6vhkZNMfegf9mf
         GBrE77QYoUymGM+8uQQD5Hx6J/bBDtpyjXFvcFH7zotDgZtN2i9WcCfZu24vBFzoSlQ/
         7z99VziPIDrz9+5BgWb+4c+nMM8nPKXtlCBpIRSc5FT/G2xHPS8MPpNLSjlLjKyTRJze
         gSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InRuHr3W77Nv6V1yM3zDnBudo6+MLUc6w96cK0lUxNw=;
        b=t+sYms5BKa3GD0V9t/imJei9QNwKpa9mZCqMQ1dNmxTO6IqIvUxO+7QI/qe9ErvX8r
         wz/vsnivwrDUcuVvJvGzBS9ZZXlA1dpJfH8/cJeXUrF9r/HHQMvWxPxbV7SJ6niqOsZ9
         wyEuWcxh9HudPsHNy8FHfiUN8PGdf0js1BhcsdCL6GZsUqB1MA1WGbcCoGknpkZONJlZ
         sukgPLpTivf7D68KtJEYvOUQBAovlW80OGiLoZFGHsvSYkpoEBVOoGBhxk4jIuUzmLPq
         X7BttDAHzFbR8c9cNLT9oYn3LY2sTLO3J7UG/dt0mbEFdmXU7yR2BTJq4NH3Ci7F1e6M
         7xJA==
X-Gm-Message-State: APjAAAVm/OEA8GZKZN1k6zgIi2VYQWstCSUppydP34nhPtqDPiQ9g3TW
        RyUB0yiCYz+m6BhHgrsfhsCUghN8ysQf/uMP+WneGQ==
X-Google-Smtp-Source: APXvYqycfhAdOODIwqfsyZfuQDL7XLgR05P7kMUtARAmo01Rk0YMv7+4vmHRY2LqoIWV2tLkOIkOpZN1HlR2HLdhfgs=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr5016276oih.73.1574295676969;
 Wed, 20 Nov 2019 16:21:16 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 16:21:05 -0800
Message-ID: <CAPcyv4g2uYjqSx3qe6g6PYzVJcRrn3HgsmksV-+vvGm-vLhY9A@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 3:19 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 10:53:39PM +0100, Borislav Petkov wrote:
> > On Wed, Nov 20, 2019 at 02:23:49PM -0700, Dave Jiang wrote:
> > > +static inline void iosubmit_cmds512(void __iomem *dst, const void *src,
> > > +                               size_t count)
> >
> > An iosubmit function which returns void and doesn't tell its callers
> > whether it succeeded or not? That looks non-optimal to say the least.
>
> That's the underlying functionality of the MOVDIR64B instruction. A
> posted write so no way to know if it succeeded. When using dedicated
> queues the caller must keep count of how many operations are in flight
> and not send more than the depth of the queue.
>
> > Why isn't there a fallback function which to call when the CPU doesn't
> > support movdir64b?
>
> This particular driver has no option for fallback. Descriptors can
> only be submitted with MOVDIR64B (to dedicated queues ... in later
> patch series support for shared queues will be added, but those require
> ENQCMD or ENQCMDS to submit).

I think
>
> The driver bails out at the beginning of the probe routine if the
> necessary instructions are not supported:
>
> +       /*
> +        * If the CPU does not support write512, there's no point in
> +        * enumerating the device. We can not utilize it.
> +        */
> +       if (!cpu_has_write512())
> +               return -ENXIO;
>
> Though we should always get past that as this PCI device ID shouldn't
> every appear on a system that doesn't have the support. Device is on
> the die, not a plug-in card.
>
> > Because then you can use alternative_call() and have the thing work
> > regardless of hardware support for MOVDIR*.
> >
> > > +{
> > > +   const u8 *from = src;
> > > +   const u8 *end = from + count * 64;
> > > +
> > > +   if (!cpu_has_write512())
> >
> > If anything, that thing needs to go and you should use
> >
> >   static_cpu_has(X86_FEATURE_MOVDIR64B)
> >
> > as it looks to me like you would care about speed on this fast path?
> > Yes, no?
>
> That might be a better.

It's meant to be identical.

The expectation was that cpu_has_write512() could be used generically
in drivers like the pmem driver that have a use for movdir64b outside
of DSA command submission use case. On x86 it would just be #define'd
to static_cpu_has(X86_FEATURE_MOVDIR64B), on other archs something
else in the future. For pmem if cpu_has_write512() is false it falls
back to talking to platform firmware for error management. Case1 from
the changelog.
