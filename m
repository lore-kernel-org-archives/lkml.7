Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA414C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D3206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dD6+CSQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfKMRBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:01:18 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43744 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfKMRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WQADSNrI4d/HxzMxBtQ+iwGnK4AsKuPRvo12BLZ2hYY=; b=dD6+CSQ/oWdT8C4qLFqsDE0HV
        dzp2WMa/ykoPKGfI05NSUeIQ+iabkCgAM4fJTJfRioHfdk/Uvp9zA3QUFH/h5g5g9bJxUKbgsV8tb
        q0yD4DgGXvvwf2hCbQeo0Nq4KkDMbkql0xiyDXMFSZ2QUAmvO7uC/U4+x410VSM3xs++hQ2MKguQV
        4k/jdBjPcrynl8RtDX8K8lrB3uDv4LulPiB4KQ4lFYZ2HNkynl1Uga58/xzSD1YRTQyPeX5rcYG98
        NfnJv75jyVDK436ZZ5LwLHRMnhsiDuA1Ocv05Xv1gV/4ENT7xE9QkT7OFejCUzWFHfliMLIds8Awo
        Zv8VRqbYw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39168)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iUw0s-0005cw-MT; Wed, 13 Nov 2019 17:01:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iUw0o-0002bS-Np; Wed, 13 Nov 2019 17:00:58 +0000
Date:   Wed, 13 Nov 2019 17:00:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: don't export unused return_address()
Message-ID: <20191113170058.GP25745@shell.armlinux.org.uk>
References: <20190906154706.2449696-1-arnd@arndb.de>
 <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk>
 <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > function and does not need to be exported, as shown by this warning:
> > > > >
> > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > >
> > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > >
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > > --- a/arch/arm/kernel/return_address.c
> > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > >                 return NULL;
> > > > >  }
> > > > >
> > > >
> > > > Checkpatch doesn't like the empty line above:
> > > >
> > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > >
> > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > +
> > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > >
> > > > > -EXPORT_SYMBOL_GPL(return_address);
> 
> > > What has happened to this patch?
> > >
> > > I still see this warning.
> >
> > Simple - it got merged, it caused build regressions, it got dropped.
> > A new version is pending me doing another round of patch merging.
> 
> I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?

I don't keep track of who did what, sorry.

> 
> [*] Commit 0b0617e5a610fe12 ("ARM: 8918/1: only build return_address() if
>     needed"), which I discovered in next-20191031 when checking if Arnd's
>     patch was applied....
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
