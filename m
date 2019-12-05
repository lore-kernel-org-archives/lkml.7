Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E67C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF58924659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KksCuKmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfLEXMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:12:07 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46965 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:12:06 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so5365649iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=At6HvOSlwFx69DNlcjSWSbtHuC15o2vy25oLL0IdSIs=;
        b=KksCuKmKAwHIOMrAzcR1CAT2l9X2g9xfwOqVX/z/ngLmeKNjY+cKTfDcNyEvnTkQog
         poobitaHiDJuO4KjOSN9GLmXUPVUYrRXJWRQKPbBjcL4M3dkEkCG7CCWZbxBJRLOFWkl
         /tdlsHK4Gipfh4O2e0klJSDLDsBT+9ak0oTUnIoDOF8cdGHwIQMYLPbx23SH6Kw3spJ1
         Iz/IVvYyl3Rs+kF7MQcATLFdAnCsVOYPqBKEtkTnSwbiQPFRM//hOd5d6JqagAUPafDm
         Dp5JvnSLiuKPJ/1ZW8Y/le4ek/ikkhnOZvrsS3Grcm/IF9i/2pI3vYLovdcZgIEc93mE
         pfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=At6HvOSlwFx69DNlcjSWSbtHuC15o2vy25oLL0IdSIs=;
        b=rChRepM/I1pl1mWW+WH3QkYBWXrUvBnAh7Z6M5ZUBRuyoRtL+psL93db2seyi1OnXt
         pyhLYVw2VWmDRgiBmJJ0DeBrWgPfei/6xXeOKeZcvyvhJSIUseAXM4DUjEppRBPhBTbH
         53hZofYTc8ClEZSz+aYS8reDSPw6Zm8ROWuAA646rjiLoeDTreFnk2lEM3NAehrUdTcH
         KMxtil9oZ1L8RxlhN2bq7Gk0+MjjN7BSH6gUTLTX9gThaLmvFxn0biTotjWs6GT6XTpj
         gNfY24C0H40EDBAI/ZH78wGR7E0LP5PxgTSz198Qq9yDFPvY6KzmgqsTrrFLAoHAlOXa
         lOEw==
X-Gm-Message-State: APjAAAXABvf4aFNUPAVEaxq1j1mLVdAtRE6hdWt3igRc00A3y0c+KMYx
        44dKdHJ1MxpMxSJIL0LMUeH7Mw==
X-Google-Smtp-Source: APXvYqxU9tuM56/pkySosrweH7NrZ+rnY/k0mRKp1T3IB8gtWL8a+1kzvXYs+QZ+an1cIN0xgNdUpg==
X-Received: by 2002:a5d:8cd6:: with SMTP id k22mr7983995iot.283.1575587525678;
        Thu, 05 Dec 2019 15:12:05 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id s88sm3352711ilk.79.2019.12.05.15.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:12:05 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:12:03 -0800 (PST)
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
In-Reply-To: <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1912051435130.239155@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>   <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>   <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>   <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
  <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>  <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com> <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019, Alistair Francis wrote:

> On Wed, 2019-12-04 at 18:54 -0800, Paul Walmsley wrote:
> > On Wed, 4 Dec 2019, Alistair Francis wrote:
> > 
> > > It is too much to expect every distro to maintain a defconfig for 
> > > RISC-V.
> > 
> > The major Linux distributions maintain their own kernel configuration 
> > files, completely ignoring kernel defconfigs.  This has been so for a 
> > long time.
> 
> That might be true for the traditional "desktop" distros, but embedded
> distros (the main target for RISC-V at the moment) don't generally do
> this.

Maybe in this discussion we can agree to use the common distinction 
between distributions and distribution build frameworks, where users of 
the latter need to be more technically sophisticated - as opposed to 
downloading a disk image.

> > > Which is why we currently use the defconfig as a base and apply 
> > > extra features that distro want on top.
> > 
> > As you know, since you've worked on some of the distribution builder 
> > frameworks (not distributions) like OE and Buildroot, those build 
> > systems have sophisticated kernel configuration patching and override 
> > systems that can disable the debug options if the maintainers think 
> > it's a good idea to do that.
> 
> Yes they do. As I said, we start with the defconfig and then apply
> config changes on top. Every diversion is a maintainence burden so
> where possible we don't make any changed. All of the QEMU machines
> currently don't have config changes (and hopefully never will) as it's
> a pain to maintain.

I'm open to your concerns here.  Can you help me understand why adding a 
few lines to the kernel configuration fragments to disable the debug 
options creates maintenance pain?  Isn't it just a matter of adding a few 
lines to disable the debug options, and -- since you clearly don't want 
them enabled for any platform -- just leaving them in there?

> > > > distros and benchmarkers will create their own Kconfigs for their
> > > > needs.
> > > 
> > > Like I said, that isn't true. After this patch is applied (and it 
> > > makes it to a release) all OE users will now have a slower RISC-V 
> > > kernel.
> > 
> > OE doesn't have any RISC-V support upstream, so pure OE users won't
> > notice 
> 
> That is just not true. 

After getting your response, I reviewed the OE-core tree that I have here, 
which is based on following the OE-core "getting started" instructions. 
The result is a tree with no RISC-V machine support.  Looking again at 
those instructions, I see that they check out the last release, rather 
than the current top of the tree; and the current top of tree does have a 
QEMU RISC-V machine.  So this statement of yours is correct, and I was in 
error about the current top-of-tree OE-core support.

> You talk later about misinformation but this is a blatent lie.

This isn't acceptable.  We've met each other in person, and I've 
considered you an enjoyable and trustworthy person to discuss technical 
issues with.  This is the first time that you've ever publicly accused me 
of misrepresenting an issue with intent to deceive.  There's a big 
difference between stating that someone is quoting misinformation and 
accusing someone of bad intentions.  I expect an apology from you.

> > > Slowing down all users to help kernel developers debug seems like 
> > > the wrong direction. Kernel developers should know enough to be able 
> > > to turn on the required configs, why does this need to be the 
> > > default?
> > 
> > It's clear you strongly disagree with the decision to do this.  It's 
> > certainly your right to do so.  But it's not good to spread 
> > misinformation about how changing the defconfigs "slow[s] down all 
> > users," or
> 
> What misinformation?

You've already acknowledged in your response that the major Linux 
distributions don't use defconfigs.  So it's clear that your statement is 
false, and rather than admitting that you're wrong, you're doubling down.

> > exaggerating the difficulty for downstream software environments to 
> > back this change out if they wish.
> 
> If you think it is that easy can you please submit the patches?

For my part, I'd be happy if the current RISC-V OE and Buildroot users who 
don't change the kernel configs run with the defconfig debug options 
enabled right now.   So, I don't plan to send patches for them.

> I understand it's easy to make decisions that simplfy your flow, but
> this has real negative consequences in terms of performance for users
> or complexity for maintainers. It would be nice if you take other users
> /developers into account before merging changes.

As stated earlier, I'm open to reconsidering if it indeed is onerous, and 
not just a matter of patching a few lines of kernel configuration 
fragments in OE and Buildroot once.


- Paul
