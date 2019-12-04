Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1392073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xAwbsMb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfLDXqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:46:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDXqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:46:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so1243394wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyGjF/rkwWS2ExVqCvEb3Z2JEo92ZJuKNi25eoJBxHc=;
        b=xAwbsMb9aGoP+r+OnPfZiWzavaYkWeAUkslEMZ5t8lulO827ECG9YLZf/4V0X+QTEq
         +fcAR+I+bFz4gn4MgmF6Yjcmar85AxQ34GcwUGYxKDUcJtIJSkrmVANDtIOAhqkp8oMD
         Umbje+bIHdpMhEoASH2A34tyT6xaMolpvsghDsXwE1Sxj2C4j9hwo8wYDws8fYkzbgt/
         Wsj9pB2I7lqJgzBJfRp7L+wIx5B6zNkNVMIUU8tE97/hdKBFnWBBw4VYnojJ011/3+P0
         wG+y3keXvprViGb2tt+aM5E/QqCDAxI/NachcjtP/whXFNEH+qBqGeZHsTbvUUdl5Aq2
         cxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyGjF/rkwWS2ExVqCvEb3Z2JEo92ZJuKNi25eoJBxHc=;
        b=WZXNrBxB36u023kP9W0UC7RrspGdrp3c4UVYYe/VaEUiGtJZzIiRcSxR5+FFF/gIo7
         EP+8VqkWsDImev+9JoK3gLw68sQi9uIIjkwpZEarvPhwRT1FO4md9AgrIa6dJSsfED1J
         WjiLqR2NOSoxQKTSMl2fK06bSU3ZPy+y9KY0T0BGuwuhMscp1L53P14VhUCDAQsVMnxl
         ghu1rQoPplEsnOpdKJ5W5cdygEHl+X3TAAkozdfaS8Y269FjeZK38g0j5BHlAOWmln6/
         JhT7OXY3+k+0DdFzk7JWvCzulTL72aF5saCAOnDiU1MVYl0jKF0CcYVneJgYXiWp92Hd
         s0ZA==
X-Gm-Message-State: APjAAAUyREYRA6/g/aRduNOt7n8voInQw4hBuFDOUUCimYyzaq9GCrP/
        Pzuq68wf0aeGY7wf27anZJamumVpgsCTsat8pYUkyw==
X-Google-Smtp-Source: APXvYqzbuVfNGh5XRBrOq8FbFMia6iU8j+JSQQYBokkifbU6uegHzqiCIV16VOfXrmTaR5k6tR5UELbQb5Ra2iDYlqk=
X-Received: by 2002:adf:d850:: with SMTP id k16mr6450667wrl.96.1575503172158;
 Wed, 04 Dec 2019 15:46:12 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
 <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
 <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com> <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
 <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>
In-Reply-To: <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 5 Dec 2019 05:16:00 +0530
Message-ID: <CAAhSdy1WRKV7WoXH1ij+yfnjg5z6JidAy1zo26XCnUhOfSE4+g@mail.gmail.com>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 1:20 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Wed, 2019-12-04 at 11:38 -0800, Paul Walmsley wrote:
> > Alistair, Anup,
> >
> > On Wed, 4 Dec 2019, Alistair Francis wrote:
> >
> > > On Wed, 2019-12-04 at 18:22 +0530, Anup Patel wrote:
> > >
> > > > I had commented on your patch but my comments are still
> > > > not addressed.
> > > >
> > > > Various debug options enabled by this patch have performance
> > > > impact. Instead of enabling these debug options in primary
> > > > defconfigs, I suggest to have separate debug defconfigs with
> > > > these options enabled.
> > >
> > > +1
> > >
> > > OE uses the defconfig (as I'm sure other distros do) and slowing
> > > down
> > > users seems like a bad idea.
> >
> > While I respect your points of view, our defconfigs are oriented
> > towards
> > kernel developers.  This is particularly important when right now the
> > only
>
> That is just not what happens though.
>
> It is too much to expect every distro to maintain a defconfig for RISC-
> V. There are constantly new features that need to be enabled/disabled
> in the configs and it isn't always clear to outsiders. Which is why we
> currently use the defconfig as a base and apply extra features that
> distro want on top.
>
> Expecting every distro to have a kernel developers level of knowledge
> about configuring Kconfigs is just unrealistic.
>
> > RISC-V hardware on the market are test chips.  Our expectation is
> > that
>
> Treating RISC-V as a test architecture seems like a good way to make
> sure that is all it ever is.
>
> > distros and benchmarkers will create their own Kconfigs for their
> > needs.
>
> Like I said, that isn't true. After this patch is applied (and it makes
> it to a release) all OE users will now have a slower RISC-V kernel.
> This also applies to buildroot and probably other distos.
>
> Now image some company wants to investigate using a RISC-V chip for
> their embedded project. They use OE/buildroot to build a quick test
> setup and boot Linux. It now runs significantly slower then some other
> architecture and they don't choose RISC-V.
>
> Slowing down all users to help kernel developers debug seems like the
> wrong direction. Kernel developers should know enough to be able to
> turn on the required configs, why does this need to be the default?

I quickly tried hackbench on SiFive Unleashed board with latest Linus
tree master branch (having your patch) and I am seeing 12% slowdown.

I am sure if I try more heavier benchmarks (such as stress-ng) then
the slowdown will be even more.

Here are the detailed numbers:

Command: ./hackbench 32
Number of Tasks: 32*40 (== 1280)
Average Time (without debug options): 3.10525
Average Time (with debug options): 3.471 (11.78% slower)

Command: ./hackbench 64
Number of Tasks: 64*40 (== 2560)
Average Time (without debug options): 6.3015
Average Time (with debug options): 7.05875 (12.017% slower)

Command: ./hackbench 128
Number of Tasks: 128*40 (== 5120)
Average Time (without debug options): 12.6275
Average Time (with debug options): 14.1455 (12.0214% slower)

It is this performance impact due to which other architectures (such as
x86 and ARM64) don't have these debug options enabled in their defconfigs.

I will send a patch to move these debug options to separate debug
defconfigs so that people have a way to build a debug kernel.

Regards,
Anup
