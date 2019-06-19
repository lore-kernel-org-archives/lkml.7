Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E59C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB85B214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560946700;
	bh=yhxv7AgwzvhlNQSVBLS6wZ1SselhU4cEOOFs1fJpxDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VpDRqdr+7rGic5vUam7T7O6UVg+0lMC/os/ArMvQnTiSz3xKckTtFLl4ev5INpDyM
	 RvS/EiuZG072/bQzg9pp+8Onh1wx1EvvjpSwBnNSbfGpCUESq27oPs9cAr9YzrtEU/
	 nBn9uKpW3LM3UsHISIfVxK0PNYlqCHB9OCtbZk50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfFSMST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:18:18 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4859C21743
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560946697;
        bh=yhxv7AgwzvhlNQSVBLS6wZ1SselhU4cEOOFs1fJpxDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZMiqI8mCi4evJQcYbolWFw0wyCpQPmy2G+Hb5PKLNhNmRtNecRI+6q89w5OJsc8qc
         0uIZ37uH9jzLWnIN0Amvcwyx6Uh8a3/6gfMVMF3B6gI70L1a/+0tTyniMwP/Zdbra7
         V9JB0No19qxSDpgkuWn3j35uD4TnLbqjkoH21P3E=
Received: by mail-wr1-f43.google.com with SMTP id c2so3140496wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:18:17 -0700 (PDT)
X-Gm-Message-State: APjAAAX37wPBYElEC+2HDpIyt4MMdxxOt6d3lU9R7qn/WwLrO8k9TEcm
        86E5HnRVVLarpIoAcB3f1R3EsWqghyYpxhHfvM4=
X-Google-Smtp-Source: APXvYqxLToImvuhSDmD1nIS+ES6oreQ4KIoRUvyJ5x3WUN76K0k7xm92MrDOXh+M6q9Y86BgYAoCufZoBHRQw/MmFGQ=
X-Received: by 2002:adf:9bd3:: with SMTP id e19mr8408054wrc.38.1560946695784;
 Wed, 19 Jun 2019 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com> <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com> <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com> <20190619091219.GB7767@fuggles.cambridge.arm.com>
In-Reply-To: <20190619091219.GB7767@fuggles.cambridge.arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 19 Jun 2019 20:18:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
Message-ID: <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net, Atish.Patra@wdc.com,
        hch@infradead.org, paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 5:12 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Jun 19, 2019 at 09:54:21AM +0100, Julien Grall wrote:
> > On 6/19/19 9:07 AM, Guo Ren wrote:
> > > You forgot CCing C-SKY folks :P
> >
> > I wasn't aware you could be interested :).
> >
> > > Move arm asid allocator code in a generic one is a agood idea, I've
> > > made a patchset for C-SKY and test is on processing, See:
> > > https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
> > >
> > > If you plan to seperate it into generic one, I could co-work with you.
> >
> > Was the ASID allocator work out of box on C-Sky? If so, I can easily move
> > the code in a generic place (maybe lib/asid.c).
>
> This is one place where I'd actually prefer not to go down the route of
> making the code generic. Context-switching and low-level TLB management
> is deeply architecture-specific and I worry that by trying to make this
> code common, we run the real risk of introducing subtle bugs on some
> architecture every time it is changed.
"Add generic asid code" and "move arm's into generic" are two things.
We could do
first and let architecture's maintainer to choose.

> Furthermore, the algorithm we use
> on arm64 is designed to scale to large systems using DVM and may well be
> too complex and/or sub-optimal for architectures with different system
> topologies or TLB invalidation mechanisms.
It's just a asid algorithm not very complex and there is a callback
for architecture to define their
own local hart tlb flush. Seems it has nothing with DVM or tlb
broadcast mechanism.

>
> It's not a lot of code, so I don't see that it's a big deal to keep it
> under arch/arm64.
Yes, I think that's ok for arm64.

Hi Arnd,
What do you think about adding generic asid code for arch selection?

Best Regards
 Guo Ren
