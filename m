Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E3FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B822466
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKMNPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:15:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34514 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:15:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so1736511oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LsJtr1PNcSnBPGBMynNzdA/gHMuqYJl/SBPbEL/69o=;
        b=paFaYhWXZOZA0RMBsX5B2BqXhPQJNb7RLJj8DAxLxKuIGVOs3XROj86lHNGMB2wQzo
         7gqaOrD6jNIhjCr4mGTdtiwPjQZ4EuFZ5Y9qaLPUELvMRrOrg0AcHfzposfyIUQOxDHT
         Z75XLCOWNhyjBK7BFLT7kWQKzLz8xMgqsXSUMyCenrAQef+8ycdgWWzhHssCks2PUM+K
         BYeZ8xjtF+q8LOI5PlbIw8R1VuL1wGJnyaZbliO4wydivVEccRyUBB1R1YfHqVxh/0Su
         slXclhophFNCzncyV6M8Xo1lI/2uh1vxMJgEZvIyZm1ZqCNQslff6IDK5+YWi5bsUZ6V
         OTxQ==
X-Gm-Message-State: APjAAAWnLh/JNOai8mbOVmxXb2ZKpPK+GNQub0x87q8cNuQgWUsVetWY
        hmims7PEQvzkMHFWfZyapj4PGqpDKx84ckZWpN6Obg==
X-Google-Smtp-Source: APXvYqyM/oA6MPvFbvIg5Isimq4Sz0kXH4KEF+ORf/pR9QFBmMOSRbP5mK01Ix5qXwoymFBUpHe2p4U8Hu2RwHD37Rc=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr2968696oii.153.1573650911540;
 Wed, 13 Nov 2019 05:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de> <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com> <20191113114517.GO25745@shell.armlinux.org.uk>
In-Reply-To: <20191113114517.GO25745@shell.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Nov 2019 14:15:00 +0100
Message-ID: <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > Without the frame pointer enabled, return_address() is an inline
> > > > function and does not need to be exported, as shown by this warning:
> > > >
> > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > >
> > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Thanks for your patch!
> > >
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > --- a/arch/arm/kernel/return_address.c
> > > > +++ b/arch/arm/kernel/return_address.c
> > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > >                 return NULL;
> > > >  }
> > > >
> > >
> > > Checkpatch doesn't like the empty line above:
> > >
> > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > >
> > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > +
> > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > >
> > > > -EXPORT_SYMBOL_GPL(return_address);

> > What has happened to this patch?
> >
> > I still see this warning.
>
> Simple - it got merged, it caused build regressions, it got dropped.
> A new version is pending me doing another round of patch merging.

I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?

[*] Commit 0b0617e5a610fe12 ("ARM: 8918/1: only build return_address() if
    needed"), which I discovered in next-20191031 when checking if Arnd's
    patch was applied....


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
