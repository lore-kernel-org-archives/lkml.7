Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61D3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A693C2243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rs6UtqC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfKTKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:24:19 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:25756 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKTKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:24:18 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xAKAO6Ow017349
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 19:24:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xAKAO6Ow017349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574245447;
        bh=sud4ysXnXZF3asFVBLXhGnpMiB6/B6ueZh7o5lhc5tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rs6UtqC6NIuZI8H8e2N6qeO4lK+RoLzEBSnuYrf+m9jFGK/+YnINoGHdLw8+x23s/
         NFQbiyzU42Wgewplbal5DPGFVBUoiWTLfX0LTEAvmkJTzS2p9Qu+gBNuS/o4HSrpby
         rR0NfzUTC8zHJM8ndImAYyx43caAYPg3VGmGeBCG9TcQPc+gmiX73zAKnZMjlpKgVN
         CcWBp0kzrfpoC6REgWzuN1l/cRPYlJucFYokfVUKvekaNFE5Mi/CBjoHyinESKn5St
         uZxOO+ug6p9rz4Gf/c5HePJogmzHRpoqmEHzs3zqUAUY2GzTzd9JD3olYM4k9m7YS1
         8HVxCybRMx9MA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id m9so16481088vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 02:24:06 -0800 (PST)
X-Gm-Message-State: APjAAAUkwEGDptCviBxiikUHGbdS4fIfGKNZezoZ2XIR7AMYoOg+kj3W
        0AmUwzjYTcHJggP61oUGVqItFU2dQ+/oBJisL3I=
X-Google-Smtp-Source: APXvYqztHD5lJDgQ1BPFn0ixrl2PD1pbikc8gAA5xmMDFjugjhOEebJ8jmWBCxqAtTuHYl48HspSNNtru3VHyCh0d7k=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr1059750vsj.215.1574245445545;
 Wed, 20 Nov 2019 02:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de> <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk> <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
 <20191113170058.GP25745@shell.armlinux.org.uk> <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
 <20191120090744.GH25745@shell.armlinux.org.uk> <CAK7LNARMjaCe8spDPMAKdViUN+uUycYL9LSCXumcR8DNDNKaPA@mail.gmail.com>
 <20191120095111.GI25745@shell.armlinux.org.uk> <20191120100737.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20191120100737.GL25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Nov 2019 19:23:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZ=EAfai2y66pyMnNrCp+Szw51R+M15kxA+m2ToXftow@mail.gmail.com>
Message-ID: <CAK7LNARZ=EAfai2y66pyMnNrCp+Szw51R+M15kxA+m2ToXftow@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:07 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 20, 2019 at 09:51:11AM +0000, Russell King - ARM Linux admin wrote:
> > On Wed, Nov 20, 2019 at 06:42:52PM +0900, Masahiro Yamada wrote:
> > > Hi Russell,
> > >
> > >
> > > On Wed, Nov 20, 2019 at 6:07 PM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 06:02:13PM +0900, Masahiro Yamada wrote:
> > > > > Hi Arnd,
> > > > >
> > > > >
> > > > >
> > > > > On Thu, Nov 14, 2019 at 2:01 AM Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> > > > > > > Hi Russell,
> > > > > > >
> > > > > > > On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> > > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > > > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > > > > > > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > > > > > > > function and does not need to be exported, as shown by this warning:
> > > > > > > > > > >
> > > > > > > > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > > > > > > >
> > > > > > > > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > > >
> > > > > > > > > > Thanks for your patch!
> > > > > > > > > >
> > > > > > > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > > > > >
> > > > > > > > > > > --- a/arch/arm/kernel/return_address.c
> > > > > > > > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > > > > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > > > > > > > >                 return NULL;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Checkpatch doesn't like the empty line above:
> > > > > > > > > >
> > > > > > > > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > > > > > > > >
> > > > > > > > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > > > > > > > +
> > > > > > > > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > > > > > > > >
> > > > > > > > > > > -EXPORT_SYMBOL_GPL(return_address);
> > > > > > >
> > > > > > > > > What has happened to this patch?
> > > > > > > > >
> > > > > > > > > I still see this warning.
> > > > > > > >
> > > > > > > > Simple - it got merged, it caused build regressions, it got dropped.
> > > > > > > > A new version is pending me doing another round of patch merging.
> > > > > > >
> > > > > > > I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?
> > > > > >
> > > > > > I don't keep track of who did what, sorry.
> > > > >
> > > > >
> > > > > Arnd,
> > > > >
> > > > > I believe this patch is the correct fix.
> > > > > Could you please put it into Russell's patch tracker?
> > > > > (patches@arm.linux.org.uk)
> > > >
> > > > Is there something wrong with:
> > > >
> > > > fb033c95c94c ARM: 8918/2: only build return_address() if needed
> > > >
> > > > I haven't seen any build issues with that.
> > >
> > >
> > > Sorry, I had not checked Ben's patch because you said
> > > "Simple - it got merged, it caused build regressions, it got dropped."
> >
> > That was 8918/1.  Ben fixed his patch, and submitted an updated
> > version.
> >
> > > Yup, I've checked it right now,
> > > and it looks good to me.
> > >
> > > But, I do not see that commit in the latest linux-next
> > > (next-20191120).
> > >
> > > Could you really apply it if you have not.
> >
> > It was applied last Friday and was pushed out there and then.
> >
> > $ git ls-remote zeniv | grep for-next
> > 022eb8ae8b5ee8c5c813923c69b5ebb1e9612c4c        refs/heads/for-next
> > $ git lg for-next
> > 022eb8ae8b5e ARM: 8938/1: kernel: initialize broadcast hrtimer based
> > clock event device
> > ...
> > fb033c95c94c ARM: 8918/2: only build return_address() if needed
> >
> > I've no idea why linux-next doesn't have it.
>
> Okay, apparently linux-next _does_ have it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/arch/arm/kernel/Makefile
>
> so I think you're confused.


My brain was corrupted.

It was my mis-operation of git. I now see it.




--
Best Regards
Masahiro Yamada
