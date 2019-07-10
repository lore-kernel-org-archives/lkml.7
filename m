Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE015C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9819020665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MyEPM7fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGJK0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:26:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45614 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v7EIF64Wkq9L2U08cgfJ9QXJ/QICE1LcS3K3e2v/4c4=; b=MyEPM7fw/XW5Lt3m9+rpuMph9
        QwBfKkpHSu5UkP561Kk8ywf0HtzkNrLfMvQQHJHZYdTcVmlPINSB9Ul4273RDB1Fr92xoxyHanSXK
        JnYOzBdjHyXcHWYyfu/x2m9WX1HcsDuSzoNtWHs1WN64RfnH1TvY26RUvYRLbD5whMq8RRtRwUWMM
        MRtQGcVeNcLdcBWxsnQFs3yRDPqvwNNsKprWyfozj3/jcQ++ekZWHsSwCdpuQgMvaoUBlJ0fOGSBG
        hAFMlOzqbaWnqnjKvG/krh4YJZ634GTzEqgLrIhfOdh5rGjB8hhh/Hr305Ya4Fg1BrW/EQe40C3JO
        P9t9FT5UQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59430)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hl9nn-00066F-An; Wed, 10 Jul 2019 11:26:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hl9nl-0003pO-Sx; Wed, 10 Jul 2019 11:26:17 +0100
Date:   Wed, 10 Jul 2019 11:26:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about ARM FASTFPE
Message-ID: <20190710102617.nhbsm4lpby3mtfc6@shell.armlinux.org.uk>
References: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
 <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk>
 <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
 <20190710100206.yls4piu36wciefbz@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710100206.yls4piu36wciefbz@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:02:06AM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Jul 10, 2019 at 06:54:06PM +0900, Masahiro Yamada wrote:
> > On Wed, Jul 10, 2019 at 5:23 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Wed, Jul 10, 2019 at 01:30:24PM +0900, Masahiro Yamada wrote:
> > > > $(wildcard ...) checks if this directory exists in the *objtree*,
> > > > while scripts/Makefile.build needs to include
> > > > arch/arm/fastfpe/Makefile from *srctree*.
> > > >
> > > > I think the correct code should be like follows:
> > > >
> > > > # Do we have FASTFPE?
> > > > FASTFPE :=arch/arm/fastfpe
> > > > ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
> > > > FASTFPE_OBJ :=$(FASTFPE)/
> > > > endif

That does indeed work for split object builds.
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
