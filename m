Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ADE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1buLVrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfLTVr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:47:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32872 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:47:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5601655pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SCnpICgEJeNeCv47il/wnhnHnvIZwSGzZQhEEwYiGvo=;
        b=b1buLVrcIi2WUUxWLFoeLQb9FVcK1qgS9/fBzOXy6UhFYggw0shBZ1DqaV/Bsj0d8s
         5pT6WYnteJrzsDqr7s+PqHusfKSAa49ZtKdwFSzgdgLcgiKmVUcxeaPkQgqTl7SeCaEu
         +HRk+myRoT900y/IzJdXsRLKaVx1VPsm5X6CSfrwnFqUSnwDdlosV7JDPSPPiXN5aFtu
         2c260ZOjgZENiZ6tICIFwYInxRejB1puQ6hKEmhv4lEJDHqQ94qNwBdI7212s+XohNMn
         Cz15+VxW7lP2DaBPRMqEHkfta2iiQInxCPhhWPmCFqFAdI4fwSjEsQ+msR6aG3yDu1pA
         Q4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCnpICgEJeNeCv47il/wnhnHnvIZwSGzZQhEEwYiGvo=;
        b=WudkYEZ1aYH0TrQvZzAgiPW4AiXlr9UPk3IJMQuLHBFBXJUjP+qF5TWfFORmMFshhd
         R+Ba+6fBc0JFglgJMJ7A/yvu/iEr/7gS3hyValsERJIJWwVf4oxnP7JRQjerCAkBelcN
         qQw270e+00vTLQ3+AZ+VTgubv2QzU2pBbPSshh0jxeppGjdH1HL8Ex2gJF2MFAmJ7ZgJ
         R9HDSihBzi+9BY7dwdypfKWtF8Us3p4k+BD1hrRUBkg4RUTxriJZHKcnBHM7LcIrxxjz
         J0tEkmk4yB5u2q4XWIjLn6Q27hNQLEnH+2snAUiC7rpMj7pf16P/z0DOupywNvrNGBrT
         jHgw==
X-Gm-Message-State: APjAAAWwge386Kyvx4ULtgujtHXS7ip/IBxbjMIAjbHsfMapvaVLuB4u
        8UypqtVHOZXcQCXTPmVKO5A=
X-Google-Smtp-Source: APXvYqy1Jp9AL+dJzZ9QrF/l/Ro8FMCkBcW7GQQLLHu27AU9qj0cPqfcIxSyuddz+LVjjATjVmZGhA==
X-Received: by 2002:a65:5242:: with SMTP id q2mr4224476pgp.74.1576878475976;
        Fri, 20 Dec 2019 13:47:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z64sm14237771pfz.23.2019.12.20.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:47:54 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:47:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220214752.GB8314@dtor-ws>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
 <9be1d523-e92c-836b-b79d-37e880d092a0@arm.com>
 <CY4PR1201MB012011E554FC69F7B074B7E2A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
 <20191220202346.GT2827@hirez.programming.kicks-ass.net>
 <CY4PR1201MB0120C3727E907005D24F5A03A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1201MB0120C3727E907005D24F5A03A12D0@CY4PR1201MB0120.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 09:02:24PM +0000, Alexey Brodkin wrote:
> Hi Peter,
> 
> > > Well it somehow used to work for quite some time now with the data-buffer
> > > being allocated with 4 words offset (which is 16 bytes for 32-bit platform
> > 
> > 3 words, devres_node is 3 words.
> 
> Correct, but 4th word was implicitly there due to the fact
> on most of 32-bit arches "long long" is aligned by 2 words.
>  
> > Which is exactly why we had to change it, the odd alignment caused ARC
> > to explode.
> 
> I know that better than anybody else as it was my pain & grief :)
>  
> > > and 32 for 64-bit which is still much less than mentioned 128 bytes).
> > > Or we just never managed to identify those rare cases when data corruption
> > > really happened?
> > 
> > The races are rather rare methinks, you'd have to get a list-op
> > concurrently with a DMA.
> > 
> > If you get the list corrupted, I'm thinking the crash is fairly likely,
> > albeit really difficuly to debug.
> 
> So that alone IMHO is a good reason to not allow that thing to happen even
> in theory.
> 
> > > > No matter which way round you allocate devres and data, by necessity
> > > > they're always going to consume the same total amount of memory.
> > >
> > > So then the next option I guess is to separate meta-data from data buffers
> > > completely. Are there any reasons to not do that
> > 
> > Dunno, should work just fine I think.
> > 
> > > other than the hack we're
> > > discussing here (meta-data in the beginning of the buffer) used to work OK-ish?
> > 
> > If meta-data at the beginngin used to work, I don't see why meta-data at
> > the end wouldn't work equally well. They'd be equally broken.

No, not really. With data being ARCH_KMALLOC_MINALIGN and coming after
the devres private stuff, given that the another allocation will also be
aligned to ARCH_KMALLOC_MINALIGN (because that's what k*alloc will give
us) we are guaranteed that DMA will not stomp onto any unrelated data.
With devres private coming after data and not having any alignment
constraints we may very well clobber it when doing DMA.

BTW, I am not sure where the page size restriction you mentioned earlier
is coming from. We have been using kmalloc()ed memory as buffers
suitable for DMA since forever, and we only need to make sure such data
is isolated from other data CPU might be accessing by ARCH_DMA_MINALIGN
which is usually L1 cache size.

From Documentation/DMA-API-HOWTO.txt:

2) ARCH_DMA_MINALIGN

   Architectures must ensure that kmalloc'ed buffer is
   DMA-safe. Drivers and subsystems depend on it. If an architecture
   isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
   the CPU cache is identical to data in main memory),
   ARCH_DMA_MINALIGN must be set so that the memory allocator
   makes sure that kmalloc'ed buffer doesn't share a cache line with
   the others. See arch/arm/include/asm/cache.h as an example.

   Note that ARCH_DMA_MINALIGN is about DMA memory alignment
   constraints. You don't need to worry about the architecture data
   alignment constraints (e.g. the alignment constraints about 64-bit
   objects).

> 
> Agree. But if we imagine devm allocations are not used for DMA
> (which is yet another case of interface usage which was never designed for
> but alas this happens left and right) then move of the meta-data to the end of
> the buffers solves [mostly my] problem... but given that DMA case we discuss
> exists I'm not sure if this move actually worth spending time on.

Well, there is a metric ton of devm users that do not allocate memory
buffers, but other objects, and for which we do not need to worry about
alignment.

Thanks.

-- 
Dmitry
