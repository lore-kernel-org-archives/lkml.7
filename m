Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6614DC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF052189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e3EDyUUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGDI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:56:36 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34444 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfGDI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=azmw62G+cXmw0plGzeXL+D/in0XfsDQPIh5bg/+cd3Q=; b=e3EDyUUBKEejsetk5uF6OP6Px
        GTlVhOIhAFk43yusPB6kuCUyfZzhaDbSi8hfQLG/tPvp6WnNmGHSSJZkMPFcpMakSALN0/oFEPLgi
        O3JDjWAIPsp9j/bw5n+v3XPSsScImDE7YaIfQyNIRhD7ooQYNvLGUCAjvkjrBYhq0xkcbG5K1VeU5
        3iEPc4yZBO+s7jOI+VKyAocg+xs6LaEc0yL4nKQv3+DNsBDA5zSRN19bQeAbTQ57SIqpPaQi3TBo8
        AVUQF5npbposV3eF1adUpcvwXLKflGoc5Xv5GNexnzIjfweukX0rr6Bvtgu16K1TRSanIIBPp1BT1
        AWgQLtyuA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59222)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hixXQ-0004cC-7E; Thu, 04 Jul 2019 09:56:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hixXJ-0006mx-Cq; Thu, 04 Jul 2019 09:56:13 +0100
Date:   Thu, 4 Jul 2019 09:56:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] ARM: Kconfig: default to AEABI w/ Clang
Message-ID: <20190704085613.dhg25m24irfuf3tx@shell.armlinux.org.uk>
References: <20190625210441.199514-1-ndesaulniers@google.com>
 <CACRpkdb+WO4WDS5S1uqPgYFHnz1ch0=DwTKaAxTF3_zid+zH4g@mail.gmail.com>
 <CAK8P3a1Oucpi0smL1poiKJj9Gc=s_6tVirTDkZwA68cuOjvB7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Oucpi0smL1poiKJj9Gc=s_6tVirTDkZwA68cuOjvB7g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:29:35AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 10:13 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Jun 25, 2019 at 11:04 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > Clang produces references to __aeabi_uidivmod and __aeabi_idivmod for
> > > arm-linux-gnueabi and arm-linux-gnueabihf targets incorrectly when AEABI
> > > is not selected (such as when OABI_COMPAT is selected).
> > >
> > > While this means that OABI userspaces wont be able to upgraded to
> > > kernels built with Clang, it means that boards that don't enable AEABI
> > > like s3c2410_defconfig will stop failing to link in KernelCI when built
> > > with Clang.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/482
> > > Link: https://groups.google.com/forum/#!msg/clang-built-linux/yydsAAux5hk/GxjqJSW-AQAJ
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > As reflecting the state of things with CLANG it's:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > But I think we in general need to have some discussion on how to
> > proceed with OABI userspaces.
> >
> > I am well aware of distributions like OpenWrt using EABI even
> > on ARMv4 with "tricks" like this:
> > https://github.com/openwrt/openwrt/blob/master/toolchain/gcc/patches/9.1.0/840-armv4_pass_fix-v4bx_to_ld.patch
> 
> I did not expect that to be necessary in gcc as long as it supports
> building for armv4 (non-t), but I might be missing something here.
> 
> > I have one OABI that I can think of would be nice to live on
> > and it's the RedHat derivative on my Foorbridge NetWinder.
> > OK I wouldn't cry if we have to kill it because it is too hard to
> > keep supporting it, but it has been running the latest kernels
> > all along so if it's not a huge effort I'd be interested in knowing
> > the options.
> 
> But do you see any problems with cross-compiling kernels to
> EABI with CONFIG_OABI_COMPAT for machines like that?

Yes, there are a few ioctls that break.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
