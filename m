Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F22C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF06421835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSEPzrPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLEFgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:36:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfLEFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:36:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so1880934wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 21:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWeVLA+Lco2PS6ChZN6Zdh3HiL42eMKEtVIMaYS087k=;
        b=iSEPzrPKtrYXwDLHNsOC/7aP1sXXYyoVLr4k0hjJpp7I0+czzzGISbfd4MXNVKE/4U
         EqFJmW2hjQh9YQACl0izw6q1PETP2l8hdKrpr6xVxniLhj7ib7lQszHtDFid37kRvl+k
         22xL5G68WoD/S8Q524AlG2AWKndiWh+xUZ5ZLeNhn5i8kaYEdHj1R4PQITayApKcbJ7r
         z8XcsN8h+kBToxkaVsZfxCNqn7grswtPwjvxlYT/k7OUotxWM9R+3HdS5az3m93gG58C
         X2/jKCJJrELJfeERLHjEe93jpz6apyO0W/TwQ9pkYVkcWAcpbrx14If+gcnLOhcubyQg
         oONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWeVLA+Lco2PS6ChZN6Zdh3HiL42eMKEtVIMaYS087k=;
        b=IH/PiqNYcXvWbZPpe7fK56QC/ULM2AIq9xXIaOWVvohn3f2/02I5NJ9vCU1Jp9TxgF
         YjVmPbWuY98L/y0LWVhZCcU3r239hHB1cqnXfyHAFOL1GhKeOZMOg6IoC5L9dcMpBJBK
         /O13IV9Bdptbo7UUIOuy83mmWv5y90TjaHxKsE6FL8M0Zi0H8iHX5CD9rAF9rxciS9po
         j5LPtomJXg0BafeH0tfOeLjXaazzs2u7Yh/Vkl36hrs2gCYbxB4T96PH9xQ4akBMi3YM
         tmAOaMcM2cO0foI1pQ+jwaZ0MD8X2LAiNLMi0lJgo7uP8aSIHTa2ZhPR0GLg+5lSJBZL
         Ad3A==
X-Gm-Message-State: APjAAAU4DQNU/6iZYriFUGYx/ozfxaNyxGt8eV+X4hjD7I41npS6VuIV
        zGSwNG+I9tPJ6PeOxw5uReHx9Lok2B/2CVjUp7s=
X-Google-Smtp-Source: APXvYqx6pHHttuBMJ2/WAYkQRUg02kxzZW3kuQMKWhdKVcEHEiRn5j2iekLW7//lcjDDot2ZFb96+UxZ7mpB4pbe92w=
X-Received: by 2002:a5d:4c85:: with SMTP id z5mr7673956wrs.42.1575524169206;
 Wed, 04 Dec 2019 21:36:09 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
 <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
 <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com> <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
 <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com> <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
 <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com>
In-Reply-To: <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 5 Dec 2019 07:35:32 +0200
Message-ID: <CAEn-LTozM5K5PQY3LTqB0G2y9DGSME-7PX=jwuujZ=cvyQN6NA@mail.gmail.com>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 5:58 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Wed, 2019-12-04 at 18:54 -0800, Paul Walmsley wrote:
> > On Wed, 4 Dec 2019, Alistair Francis wrote:
> >
> > > That is just not what happens though.
> > >
> > > It is too much to expect every distro to maintain a defconfig for
> > > RISC-
> > > V.
> >
> > The major Linux distributions maintain their own kernel
> > configuration
> > files, completely ignoring kernel defconfigs.  This has been so for a
> > long
> > time.
>
> That might be true for the traditional "desktop" distros, but embedded
> distros (the main target for RISC-V at the moment) don't generally do
> this.

I can confirm that Fedora/CentOS/RHEL do not depend on default
config in kernel. Same seems to apply to Ubuntu, Arch and probably
others. We maintain our own configs.

>
> >
> > > Which is why we currently use the defconfig as a base and apply
> > > extra
> > > features that distro want on top.
> >
> > As you know, since you've worked on some of the distribution builder
> > frameworks (not distributions) like OE and Buildroot, those build
> > systems
> > have sophisticated kernel configuration patching and override systems
> > that
> > can disable the debug options if the maintainers think it's a good
> > idea to
> > do that.
>
> Yes they do. As I said, we start with the defconfig and then apply
> config changes on top. Every diversion is a maintainence burden so
> where possible we don't make any changed. All of the QEMU machines
> currently don't have config changes (and hopefully never will) as it's
> a pain to maintain.
>
> >
> > You've contributed to both Buildroot and OE meta-riscv RISC-V kernel
> > configuration fragments yourself, so this shouldn't be a problem for
> > you
> > if you disagree with our choices here.  For example, here's an
> > example of
> > how to patch defconfig directives out in Buildroot:
> >
> >
> > https://git.buildroot.net/buildroot/tree/board/qemu/csky/linux-ck807.config.fragment#n3
> >
> > I'm assuming you don't need an example for meta-riscv, since you've
> > already contributed RISC-V-related kernel configuration fragments to
> > that
> > repository.
>
> As I stated, this is possible. It's just a pain to maintain and for the
> QEMU machines will probably not happen.
>
> We are trying to remove RISC-V specific changes, not add more.
>
> >
> > > Expecting every distro to have a kernel developers level of
> > > knowledge
> > > about configuring Kconfigs is just unrealistic.
> >
> > I think it's false that only kernel developers know how to disable
> > debug
> > options in Kconfig files.  As far as the underlying premise that one
> > shouldn't expect distribution maintainers to know how to change
> > Kconfig
> > options, we'll just have to agree to disagree.
>
> Do you really expect every disto to follow all of the kernel changes
> and generate their own config based on what happened in the kernel tree
> since the last release? We don't all just spend our days adjusting to
> the Linux kernel.

I cannot talk for all distros (there are too many), but major desktop
distributions do that. For the 1st few RCs of a new kernel version I
will be adjusting Fedora/RISCV configuration based on whatever
changes land.

Of course looking at default defconfig is part of that process.

>
> This is espicially true for RISC-V as it's new and constantly changing.
>
> >
> > > > distros and benchmarkers will create their own Kconfigs for their
> > > > needs.
> > >
> > > Like I said, that isn't true. After this patch is applied (and it
> > > makes
> > > it to a release) all OE users will now have a slower RISC-V kernel.
> >
> > OE doesn't have any RISC-V support upstream, so pure OE users won't
> > notice
>
> That is just not true. You talk later about misinformation but this is
> a blatent lie.
>
> > any change at all.  Assuming you're talking about meta-riscv users:
> > as
> > noted above, it's simple to automatically remove Kconfig entries you
> > disagree with, or add ones you want.
> >
> > > Now image some company wants to investigate using a RISC-V chip for
> > > their embedded project. They use OE/buildroot to build a quick test
> > > setup and boot Linux. It now runs significantly slower then some
> > > other
> > > architecture and they don't choose RISC-V.
> >
> > The best option for naive users who are seeking maximum performance
> > is to
> > use a vendor BSP.  This goes beyond settings in a kernel config file:
> > it
> > extends to compiler and linker optimization flags, LTO, accelerator
> > firmware and libraries, non-upstreamed performance-related patches,
> > vendor support, etc.
>
> What? How many people actually do this for embedded systems.
>
> I agree that if you really want to maximise it as much as you can you
> will go to this effort, but I don't think most people do. I think we
> all know that lots of times embedded Linux is just hacked until it
> works and then shipped. In this case defaults are very important.
>
> >
> > > Slowing down all users to help kernel developers debug seems like
> > > the
> > > wrong direction. Kernel developers should know enough to be able to
> > > turn on the required configs, why does this need to be the default?
> >
> > It's clear you strongly disagree with the decision to do this.  It's
> > certainly your right to do so.  But it's not good to spread
> > misinformation
> > about how changing the defconfigs "slow[s] down all users," or
>
> What misinformation?
>
> Anup shared benchmarking results indicating that this change has a 12%
> performance decrease for everyone who uses the defconfig without
> removing this change.
>
> That is everyone who doesn't decide to remove config options from the
> default config supplied by the people who wrote the code are now stuck
> with a large performance hit. Passing the buck and saying that people
> should be changing the defconfig cannot be the right solution here.
>
> > exaggerating the difficulty for downstream software environments to
> > back
> > this change out if they wish.
>
> If you think it is that easy can you please submit the patches?
>
> I understand it's easy to make decisions that simplfy your flow, but
> this has real negative consequences in terms of performance for users
> or complexity for maintainers. It would be nice if you take other users
> /developers into account before merging changes.

I would prefer to have a separate config for debug (that's what we do in
Fedora). Why not use config fragment here (e.g. call it debug.config like
in powerpc)?

See:
https://github.com/torvalds/linux/commit/c1bc6f93f95970f917caaac544a374862e84df52
https://elinux.org/images/3/39/Managing-Linux-Kernel-Configurations-with-Config-Fragments-Darren-Hart-VMware.pdf

david

>
> Alistair
>
> >
> >
> > - Paul
