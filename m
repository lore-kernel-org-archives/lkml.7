Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A609C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4602171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsrUUW/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405160AbfGHUmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:42:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40172 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfGHUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:42:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so8149605pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aD28nauLfDmF/sN5JeyiFdkfy649nTdS4nUjL4YoA7c=;
        b=LsrUUW/4CIIKuzb3lU+Q5ckBMxQXltpinIhwxe7expalway3X8RwKamH+gxGzmodFQ
         0Jbd5RPW8nQDhChBht8xD08+DnhrerU23yFEmOe7e0w9aCGfiIxf4QkhbOp5lQl8glyd
         KhqyIgEP2ShFufQqjgk0bw10hEJTlXMb7YjC44XYD0RUD+5ucfWVXRi1ODHUhDKuQf/C
         oLXCIFvJfRkiOD3bkpI+iMH2/SqyIhwBCtYn6Nm/nrSEwSFD7tsS+KMM1KiffOr515Mu
         nHLoXOOOqROppQ3LdAl5XDupMoK0O6Y1T3/GCR+ldEagk8O66yBTpAsBSqU9VvJe8W78
         vTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aD28nauLfDmF/sN5JeyiFdkfy649nTdS4nUjL4YoA7c=;
        b=A/9WNPivFj1PVInl/j+7LJXBDMg9RvUI3JS7yn2OJvpuiEvfAVCd58HneqVH/iKX6+
         mcRQiKeJIGnQ1wXqBczSs/BtBG73FBZDEK2JBmmlWW+4Y02ScyfiXtWMMWdSbeM8Y/E2
         qA6umHwNvqhZl7CeNwB15eeJI1/8e2FjWelsu4aHFZi6I31h3yqNxLkGaAfEUgXmBW76
         vHCYiYazNn+tzEhMkS3LGNX6LybnoMfJeoZGAsnP8sr4alK486pJWdjNlyUEL6ThpKpr
         wftc9ZFr1S0Av2DuMgWVV1/ljo2appOwxuK+MCb/0xItgMQANVnj8xpDMwyItjt4x9M5
         Z3lg==
X-Gm-Message-State: APjAAAVQTf0OfYJECSPuOhDmNXM9rSP7j7XXLv6KC3ctP3i5IbrgPjmP
        Xz7BuUnhVToaXopu3ku6b6O1mgH3
X-Google-Smtp-Source: APXvYqzsrlDqqVUZcSyVPjzmoEFxII3unyjp72UQoGSQVhNhq+D9JGp/uIZ6yhemp/9QJ5wwnJ+m2A==
X-Received: by 2002:a65:5202:: with SMTP id o2mr24151080pgp.199.1562618542786;
        Mon, 08 Jul 2019 13:42:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14sm18206053pfy.40.2019.07.08.13.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 13:42:21 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:42:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: m68k build failures in -next: undefined reference to
 `arch_dma_prep_coherent'
Message-ID: <20190708204219.GA20675@roeck-us.net>
References: <20190708170647.GA12313@roeck-us.net>
 <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
 <20190708194516.GA18304@roeck-us.net>
 <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:19:41PM +0200, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> CC Greg
> 
> On Mon, Jul 8, 2019 at 9:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Jul 08, 2019 at 09:13:02PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, Jul 8, 2019 at 7:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > I see the following build error in -next:
> > > >
> > > > kernel/dma/direct.o: In function `dma_direct_alloc_pages':
> > > > direct.c:(.text+0x4d8): undefined reference to `arch_dma_prep_coherent'
> > > >
> > > > Example: m68k:allnoconfig.
> > > >
> > > > Bisect log is ambiguous and points to the merge of m68k/for-next into
> > > > -next. Yet, I think the problem is with commit 69878ef47562 ("m68k:
> > > > Implement arch_dma_prep_coherent()") which is supposed to introduce
> > > > the function. The problem is likely that arch_dma_prep_coherent()
> > > > is only declared if CONFIG_MMU is enabled, but it is called from code
> > > > outside CONFIG_MMU.
> > >
> > > Thanks, one more thing to fix in m68k-allnoconfig (did it really build
> > > before?)...
> > >
> > > Given you say "example", does it fail in real configs, too?
> >
> > Yes, it does. All nommu builds fail. allnoconfig and tinyconfig just
> > happen to be among those.
> >
> > Building m68k:allnoconfig ... failed
> > Building m68k:tinyconfig ... failed
> > Building m68k:m5272c3_defconfig ... failed
> > Building m68k:m5307c3_defconfig ... failed
> > Building m68k:m5249evb_defconfig ... failed
> > Building m68k:m5407c3_defconfig ... failed
> > Building m68k:m5475evb_defconfig ... failed
> >
> > Error is always the same.
> 
> Thanks!
> 
> > The error started with next-20190702. Prior to that, builds were fine,
> > including m68k:allnoconfig and m68k:tinyconfig.
> 
> Yeah, it started when I queued up the DMA rework.
> I didn't double-check when Greg said it was OK for him, as it wouldn't affect
> Coldfire or mmu. Sorry for that.
> And that has just been pulled by Linus... Oops...
> 

Oh well, I would have hoped for another rc, not because of the state
of mainline but for the state of -next. The next release may be fun,
in a negative sense. From the build of next-20190705:

Build results:
	total: 158 pass: 147 fail: 11
Qemu test results:
	total: 364 pass: 41 fail: 323

People have been making lots of last-minute (ie in the week before
the commit window opens, and just before a holiday weekend) untested
changes. Unfortunately that happens a lot lately.

To be fair, most of the qemu failures are due to messed up btrfs
dependencies (or at least I hope so - hard to say with that many
failures), but still ...

Guenter
