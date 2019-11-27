Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E40C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1D20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gbR63fcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfK0QJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:09:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44570 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:09:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id a67so20084134edf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVh7tTi5rObsII1vRb5KH/Kj99TQG5j4kV172FFYaNU=;
        b=gbR63fcLJRi/WLgkSC3biBeSS5ksFa+SgBNncFI/dtnu6JomxUFkEypKo6Hde4vGot
         YLEamBKO3NHi3MEiQhVD1VJ4Zd4YNbkgRwzuK3F+qQo35SAO10ZOP94oMfC6WY6/Wh/U
         0eKrxx18EfmCr04w4Gqxt2XGo46PBzhuFnQsl2l2UcZ/0xLjG/PGnelMJoYElJM5pyp4
         tvt0Np+1js8hOTW2NFTqQaugebPGC6rxkL/ADeoJv7eyygV5BDFyATPfvj8v+A0BWw7r
         Kp3ix1Ofv6QK+yQq/Zlr0cnpeMqh8iDM9Y9JJ5A/IMywhztDuC2O6mUHpjN7w2VaAD6S
         qlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVh7tTi5rObsII1vRb5KH/Kj99TQG5j4kV172FFYaNU=;
        b=pMcW995QCRJTg1ZqYfpoGI+ybojqMzqtLa7MheZwc4FSd0/KWqCjkwO05hNYfioIvD
         iA9HTlSxijiggck+/wg5ybDSJrSDXSoF3OPE4rfhS307oQXBdlVZyQpPTYnBHWjD0029
         0V242SIwULH/XftruRrgoygmY3meZdPahsqXrnqCHuLH6JdKd90R0xsApwCVQCTMUsva
         5fMOnGVvk/JrHfwIa2Dx3NK9ghLJSygaZ/LFaevaY6C1AM+PsLJqA0+ZK7YWCLEZ6uds
         jfMp6YziXJhR5yM0pdwrJo0W5LQhZ9KhTAw8N5lLbcCGhR9PXSu9ZIlLk7tlSntmFGUE
         oM0Q==
X-Gm-Message-State: APjAAAVUmVbR+vU+9dOsGmCMArgUA4A0se7eMzU9ZLLRbyKvOkAOwOzl
        6zWaIv3mR0E5zkShF13E4mdhJFbWMCozIxGKemnYVA==
X-Google-Smtp-Source: APXvYqyGvrGVufQv8/trojtgiiYMTMZNR892vMYV853ZwD/Xo8IVHZPoSX4tMMrkndkbkHl7S1A5sUcM3uaSQGcM8Lo=
X-Received: by 2002:a50:9e22:: with SMTP id z31mr7697426ede.258.1574870986619;
 Wed, 27 Nov 2019 08:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-4-pasha.tatashin@soleen.com> <20191127151154.GC51937@lakrids.cambridge.arm.com>
 <CA+CK2bDDom_pwLC-ABwDw66ynyELH3f3NdjUEdhr1LYLkgWJvg@mail.gmail.com> <20191127160342.GF51937@lakrids.cambridge.arm.com>
In-Reply-To: <20191127160342.GF51937@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Nov 2019 11:09:35 -0500
Message-ID: <CA+CK2bBszdMYbneQ1UiYxSndN8zmoVwbTVJ20NeajYPehT_X5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: remove the rest of asm-uaccess.h
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 11:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Nov 27, 2019 at 10:31:54AM -0500, Pavel Tatashin wrote:
> > On Wed, Nov 27, 2019 at 10:12 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 09:24:06PM -0500, Pavel Tatashin wrote:
> > > > The __uaccess_ttbr0_disable and __uaccess_ttbr0_enable,
> > > > are the last two macros defined in asm-uaccess.h.
> > > >
> > > > Replace them with C wrappers and call C functions from
> > > > kernel_entry and kernel_exit.
> > >
> > > For now, please leave those as-is.
> > >
> > > I don't think we want to have out-of-line C wrappers in the middle of
> > > the entry assembly where we don't have a complete kernel environment.
> > > The use in entry code can also assume non-preemptibility, while the C
> > > functions have to explcitily disable that.
> >
> > I do not understand, if C function is called form non-preemptible
> > context it stays non-preemptible. kernel_exit already may call C
> > functions around the time __uaccess_ttbr0_enable is called (it may
> > call post_ttbr_update_workaround), and that C functions does not do
> > explicit preempt disable:
>
> Sorry, I meant that IRQs are disabled here.
>
> The C wrapper calls __uaccess_ttbr0_enable(), which calls
> local_irq_save() and local_irq_restore(). Those are pointless in the
> bowels of the entry code, and potentially expensive if IRQ prio masking
> is in use.
>
> I'd rather not add more out-of-line C code calls here right now as I'd
> prefer to factor out the logic to C in a better way.

Ah, yes, this makes sense. I could certainly factor out C calls in a
better way, or is this something you want to work on?

Without removing these assembly macros I do not think we want to
address this suggestion from Kees Cook:
https://lore.kernel.org/lkml/CA+CK2bCBS2fKOTmTFm13iv3u5TBPwpoCsYeeP352DVE-gs9GJw@mail.gmail.com/

Thank you,
Pasha
