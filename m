Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EDAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42451206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XULbgrv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfKTJnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:43:43 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:17596 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfKTJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:43:42 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xAK9hT0d008463
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 18:43:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xAK9hT0d008463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574243010;
        bh=gaeqdtznjjafg+M5Fz5ihzkuP1zCT1Ut14Jc/U3kO0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XULbgrv5bAU/hwre0092fkHZT1E1/voN+/IkerXZNfbhu2pzTE7f60xDllS2iY0V4
         8jBnWGI/vsZ9Df54OKBDQ9hMRutr54N1BdeHJwajUQD1cjEjBe4oDxgzIOTBqaTRY1
         NiZeQ/b19cWhjOtu/6k7Bn0ascxp8CgVZGQ+mNvXHDoWuEMATCNTr3ql2LSAp0kGOs
         8OU0O8AmYZnotBjY5SMYRMPUTQ42wqrFqpuTZnjitieZspbAXDYlNIo1slmAjeZyou
         Z4vblX/K2lumxtQSMk5FeCPBSDdm3tQS5j4bZThBKW9kBYK1CD2GdBtyJHjXWT/wXv
         5mOD6Lspz3Vlg==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id 190so16386212vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 01:43:30 -0800 (PST)
X-Gm-Message-State: APjAAAXnxemKGXGYw0hqm20anNGuzywl0wJw1DdIZYW6xq6StPyULcRm
        BAOd/ZTFW3RLc8jic/WMlaVGswIV1ApwOPVfqCE=
X-Google-Smtp-Source: APXvYqydF4O542U4LQETZ4wHBOQur8BMF1qbkuAzzOgrIMLs4fbi4o6BnIuLJQm4CI1YMqKWZQIgo1eUGiIKHyX2trE=
X-Received: by 2002:a05:6102:726:: with SMTP id u6mr884537vsg.179.1574243008839;
 Wed, 20 Nov 2019 01:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de> <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk> <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
 <20191113170058.GP25745@shell.armlinux.org.uk> <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
 <20191120090744.GH25745@shell.armlinux.org.uk>
In-Reply-To: <20191120090744.GH25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Nov 2019 18:42:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMjaCe8spDPMAKdViUN+uUycYL9LSCXumcR8DNDNKaPA@mail.gmail.com>
Message-ID: <CAK7LNARMjaCe8spDPMAKdViUN+uUycYL9LSCXumcR8DNDNKaPA@mail.gmail.com>
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

Hi Russell,


On Wed, Nov 20, 2019 at 6:07 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 20, 2019 at 06:02:13PM +0900, Masahiro Yamada wrote:
> > Hi Arnd,
> >
> >
> >
> > On Thu, Nov 14, 2019 at 2:01 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> > > > Hi Russell,
> > > >
> > > > On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > > > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > > > > function and does not need to be exported, as shown by this warning:
> > > > > > > >
> > > > > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > > > >
> > > > > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > > > > >
> > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > >
> > > > > > > Thanks for your patch!
> > > > > > >
> > > > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > >
> > > > > > > > --- a/arch/arm/kernel/return_address.c
> > > > > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > > > > >                 return NULL;
> > > > > > > >  }
> > > > > > > >
> > > > > > >
> > > > > > > Checkpatch doesn't like the empty line above:
> > > > > > >
> > > > > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > > > > >
> > > > > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > > > > +
> > > > > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > > > > >
> > > > > > > > -EXPORT_SYMBOL_GPL(return_address);
> > > >
> > > > > > What has happened to this patch?
> > > > > >
> > > > > > I still see this warning.
> > > > >
> > > > > Simple - it got merged, it caused build regressions, it got dropped.
> > > > > A new version is pending me doing another round of patch merging.
> > > >
> > > > I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?
> > >
> > > I don't keep track of who did what, sorry.
> >
> >
> > Arnd,
> >
> > I believe this patch is the correct fix.
> > Could you please put it into Russell's patch tracker?
> > (patches@arm.linux.org.uk)
>
> Is there something wrong with:
>
> fb033c95c94c ARM: 8918/2: only build return_address() if needed
>
> I haven't seen any build issues with that.


Sorry, I had not checked Ben's patch because you said
"Simple - it got merged, it caused build regressions, it got dropped."


Yup, I've checked it right now,
and it looks good to me.

But, I do not see that commit in the latest linux-next
(next-20191120).

Could you really apply it if you have not.

Thanks!



--
Best Regards
Masahiro Yamada
