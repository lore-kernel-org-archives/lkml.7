Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6125EC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2481820844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ItYNfLB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGJIXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:23:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44106 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KHsCceUwFj0VCBCJ1Vn7vA7gOHS6l0320ELVzrYcy0s=; b=ItYNfLB/DBiyNIjWV16Va8Z1f
        Fs9GQxDleXj1+NXT7leCxwbEop+GSMzry4rYr2+vRFeDNGvbaANfdKR7cOiHACIpGi7caj50WqLBl
        K3/YuUwW3hWGeBzzSDwevFMfkuJef4r2awS5mR0Ze8tCsYJF2UURZQF99paE8Hp8ssBgJQRNJId+k
        JlQenguNGzCYWSIrER9udcRetVnztBSUWq5oDr+6ChDphkOaJkEev4rlRhrJAA3VjeKvLsrQ7U3O2
        ZipWkDIUtDJLqQmwvikvie6Y8nenzzue5nCGMMRE+HW8uRp65CBNhZKYRaQFfS7+wyAYurC+XLUKN
        6kcufbp8w==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59328)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hl7t3-0005Zi-VT; Wed, 10 Jul 2019 09:23:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hl7t1-0003km-Hp; Wed, 10 Jul 2019 09:23:35 +0100
Date:   Wed, 10 Jul 2019 09:23:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Subject: Re: Question about ARM FASTFPE
Message-ID: <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk>
References: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:30:24PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> I have a question about the following code
> in arch/arm/Makefile:
> 
> 
> # Do we have FASTFPE?
> FASTFPE :=arch/arm/fastfpe
> ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> FASTFPE_OBJ :=$(FASTFPE)/
> endif
> 
> 
> Since arch/arm/fastfpe does not exist in the upstream tree,
> I guess this is a hook to compile downstream source code.
> 
> If a user puts arch/arm/fastfpe/ into their local source tree,
> Kbuild is supposed to compile the files in it.
> 
> Is this correct?
> 
> 
> If so, I am afraid this would not work for O= building.
> 
> $(wildcard ...) checks if this directory exists in the *objtree*,
> while scripts/Makefile.build needs to include
> arch/arm/fastfpe/Makefile from *srctree*.
> 
> I think the correct code should be like follows:
> 
> # Do we have FASTFPE?
> FASTFPE :=arch/arm/fastfpe
> ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
> FASTFPE_OBJ :=$(FASTFPE)/
> endif
> 
> 
> Having said that, I am not sure this code is worth fixing.
> 
> This code was added around v2.5.1.9,

... as a _result_ of a discussion and deciding not to upstream it,
but to still allow its use.  Fastfpe is faster than nwfpe (so has
a definite advantage for FP intensive applications) but we decided
we didn't want two FP emulation codes in the kernel.  However, if
someone wants to use it, it has to be built into the kernel, it
can't be modular.

> and the actual source code for arch/arm/fastfpe/
> was never upstreamed.
> 
> 
> In general, we do not care much about the downstream code support.
> 
> What should we do about this?
> Fix and keep maintaining? Delete?
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
