Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA98C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB0D214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sn3hzJMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfLECy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:54:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39710 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLECy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:54:58 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so1999758ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 18:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Wx2vN1sbfR2KEWh0Q5FWJVtfVEAyeU1xy6cPm3pYEkQ=;
        b=Sn3hzJMiBhlnjlbDl3cQWnmVZn3CKfHiaMjRRohBzk3ad1ubx5myEHE8f2QM61tgz1
         9Wo2SESO3K+sTUNvQVRtIPk51yS67iY2jEx/b0nJL3TvixsrowhcaPdgl8xMHFzdsPJF
         /i4d1G/txICC2FzkyZQeWxpLu+Vu4F5lbBwlkDPPYPxs7AQsh/+XUZCEd8343JT/784t
         DFTEfO+yxhRX+PwnmnnjMXBKWV86dHq0RGjig4YZqYr8t7F6216CqhQUlsrN32q7OG30
         217adLUW6AwwGwX6eyEoPMcAzfcrpo71jpzu2op/iSAxe3onXnvhZKlrFxnGdF6gE1sK
         SLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Wx2vN1sbfR2KEWh0Q5FWJVtfVEAyeU1xy6cPm3pYEkQ=;
        b=KiP8rr1qR6YvuEWEyvV245vpdZI4EAtRdAMqdyO4zEkbIVv7gZWGy77EDAiWEd843c
         SVZdHRXJjPIat/SSmflJO2/WyCR8T+bWf04i2JPFRd7mOuHNQ7GxCiEv/bhSNibWZX1L
         6u49Q6GkXaeXe+1i+ww/1cw6aJxJWsjG0WF3/LOMOWy2eYqyqUR8danSxFuBafkUf4EW
         zdb74ZVDvU6DHnehhO7+GOsGQsULFHMgVs3dDmGKFarAfD47c6Zgl3ly3GxGeEKtDbKc
         SaPupk0P1B9TEBjE3wdeTqPcit6/v2TP3mtfLHxy/q1EkVmx60+/lkTkCzjA3K+hXyF7
         Qvng==
X-Gm-Message-State: APjAAAWgyYIYxPPEI6fp5/vV0DGtmYRn3DYItw7OBpfHeE/8iz6FGYBa
        W0ITmXBjXnpDYIG3I1K8fgTBc0ef06U=
X-Google-Smtp-Source: APXvYqxMpDQEvRh6dSHWsRJucpfP+RiNSViXrITtQiMiUtuG1U9XPcXXFNqowIIqL7RSH3bqzLRZjQ==
X-Received: by 2002:a5e:d50a:: with SMTP id e10mr4935722iom.83.1575514497748;
        Wed, 04 Dec 2019 18:54:57 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id k16sm2377507ila.12.2019.12.04.18.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:54:57 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:54:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "anup@brainfault.org" <anup@brainfault.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
In-Reply-To: <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>  <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>  <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>  <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
 <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Alistair Francis wrote:

> That is just not what happens though.
> 
> It is too much to expect every distro to maintain a defconfig for RISC- 
> V. 

The major Linux distributions maintain their own kernel configuration 
files, completely ignoring kernel defconfigs.  This has been so for a long 
time.

> Which is why we currently use the defconfig as a base and apply extra 
> features that distro want on top.

As you know, since you've worked on some of the distribution builder 
frameworks (not distributions) like OE and Buildroot, those build systems 
have sophisticated kernel configuration patching and override systems that 
can disable the debug options if the maintainers think it's a good idea to 
do that.

You've contributed to both Buildroot and OE meta-riscv RISC-V kernel 
configuration fragments yourself, so this shouldn't be a problem for you 
if you disagree with our choices here.  For example, here's an example of 
how to patch defconfig directives out in Buildroot:

  https://git.buildroot.net/buildroot/tree/board/qemu/csky/linux-ck807.config.fragment#n3

I'm assuming you don't need an example for meta-riscv, since you've 
already contributed RISC-V-related kernel configuration fragments to that 
repository.

> Expecting every distro to have a kernel developers level of knowledge
> about configuring Kconfigs is just unrealistic.

I think it's false that only kernel developers know how to disable debug 
options in Kconfig files.  As far as the underlying premise that one 
shouldn't expect distribution maintainers to know how to change Kconfig 
options, we'll just have to agree to disagree.

> > distros and benchmarkers will create their own Kconfigs for their
> > needs.
> 
> Like I said, that isn't true. After this patch is applied (and it makes 
> it to a release) all OE users will now have a slower RISC-V kernel.

OE doesn't have any RISC-V support upstream, so pure OE users won't notice 
any change at all.  Assuming you're talking about meta-riscv users: as 
noted above, it's simple to automatically remove Kconfig entries you 
disagree with, or add ones you want.

> Now image some company wants to investigate using a RISC-V chip for
> their embedded project. They use OE/buildroot to build a quick test
> setup and boot Linux. It now runs significantly slower then some other
> architecture and they don't choose RISC-V.

The best option for naive users who are seeking maximum performance is to 
use a vendor BSP.  This goes beyond settings in a kernel config file: it 
extends to compiler and linker optimization flags, LTO, accelerator 
firmware and libraries, non-upstreamed performance-related patches, 
vendor support, etc.

> Slowing down all users to help kernel developers debug seems like the
> wrong direction. Kernel developers should know enough to be able to
> turn on the required configs, why does this need to be the default?

It's clear you strongly disagree with the decision to do this.  It's 
certainly your right to do so.  But it's not good to spread misinformation 
about how changing the defconfigs "slow[s] down all users," or 
exaggerating the difficulty for downstream software environments to back 
this change out if they wish.


- Paul
