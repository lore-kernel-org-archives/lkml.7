Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE3C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732420656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AKOla1SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfGIWZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:25:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37528 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jA8jFJl6t6YBcdU5tfSev8pjWrcLeSVuPnk8tfxl0aM=; b=AKOla1SFPezDtSxsxCvwxu1gx
        Nf71HgprPGbDC8gVtIcVhjEbejdyvhZ8uy5iVHXqRG/ksfKp6zKFfFxT31DASkn/mNir2fswHELDi
        mZxuDip3duVJkYwZAWmlZG0X1oh3utTVjTRRV+jmKlLDRfZ5R2EXfLvjTeb/FSPKf5zwimPB4NZd2
        mxpx3eiOctXLU2qKY+2BL8+fSXymGCPJixuGbTahDvuxoE+7QcBGsFN4Ih9O4O6v1J2yc59mN38E4
        fbOT6ybXaogG/FvbOh60K/pY6DdF8Vihca9eaKgo9bBcbvzPwWo+19BWkSHQEHSgvX6v7bBjw/R7k
        5vObQ5jag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60312)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hkyY8-00033I-1M; Tue, 09 Jul 2019 23:25:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hkyY1-0003NQ-Jv; Tue, 09 Jul 2019 23:25:17 +0100
Date:   Tue, 9 Jul 2019 23:25:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
Message-ID: <20190709222517.c3nn6fgrz2eost3s@shell.armlinux.org.uk>
References: <20190708203049.3484750-1-arnd@arndb.de>
 <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
 <CAKwvOdnm6rd4pOJvRbAghLxfd2QL5VJ+ODiMyRh1ri3pmmz0yg@mail.gmail.com>
 <CAK8P3a2anB0hD5J0JfPpJ_Gjc=NjoNC4k9nJ=t9H5AOBbdnfqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2anB0hD5J0JfPpJ_Gjc=NjoNC4k9nJ=t9H5AOBbdnfqg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 08:40:51PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 9, 2019 at 8:08 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > On Tue, Jul 9, 2019 at 1:41 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > I guess this brings up the old question whether the compiler should
> > > be worked around or just considered immature, but as it happens this
> >
> > Definitely a balancing act; we prioritize work based on what's
> > feasible to work around vs must be implemented.  A lot of my time is
> > going into validation of asm goto right now, but others are ramping up
> > on the integrated assembler (clang itself can be invoked as a
> > substitute for GNU AS; but there's not enough support to do `make
> > AS=clang` for the kernel just yet).
> 
> Note that this bug is the same with both gas and AS=clang, which also
> indicates that clang implemented the undocumented .rep directive
> for compatibility.
> 
> Overall I think we are at the point where building the kernel with clang-8
> is mature enough that we should work around bugs like this where it is
> easy enough rather than waiting for clang-9.

While both assemblers seem to support both .rept and .rep, might it
be an idea to check what the clang-8 situation is with .rept ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
