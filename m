Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C8C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9C221537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="07wh6UTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGIJR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:17:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56822 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfGIJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xqgAuKvy8GWlTYQeWcjTc9XmHRHeaV4psPeCFTBL620=; b=07wh6UTIMM3GoBMRNUq/wNVd5
        602onDbjkZYuryHrHAVl/rxfT8HnaYaGIfJSSsi12vB+m7gUguLkYn1l2D8jDLlIJc3lIpXzIsNOp
        nRtpDGuQ45OaF5AWssFisPcqr42gg0e1pVx1YXT9LnqoBHG2fJhr+D5JPmsF4NnB2IWi29Ko75DKa
        bNMxVwhGZfl3ygoqfZMqHN3DEKa1BYhKuX6VmM1w0oCm9IT6w71R41/uYNEzd/Oeg0lMQvwawUMD6
        CqvtH4vbIEGMK2ocUNg/INhO/T+xpJ7WEMYL9i13zwy4wVc9XRw8yeuPe72nfPvLlhtZe2i8gTH+3
        HNDnHqaKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60292)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hkmFy-0008Gh-3B; Tue, 09 Jul 2019 10:17:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hkmFv-0002rm-RQ; Tue, 09 Jul 2019 10:17:47 +0100
Date:   Tue, 9 Jul 2019 10:17:47 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, clang-built-linux@googlegroups.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
Message-ID: <20190709091747.cg3cqmzdfpzks2vx@shell.armlinux.org.uk>
References: <20190708203049.3484750-1-arnd@arndb.de>
 <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:41:05AM +0200, Linus Walleij wrote:
> I guess this brings up the old question whether the compiler should
> be worked around or just considered immature, but as it happens this
> other day I was grep:ing around to find "the 8 NOP" that is so
> compulsively inserted in ARM executables (like at the very start of
> the kernel execution)

The NOPs at the start of the kernel executable have nothing what so ever
to do with this.  They are there to align the kernel entry with the old
a.out format that was used (which had a 32 byte header).  Consequently,
there are boot loaders around that jump to 32 bytes into the kernel
header.

There are other places that we insert 10 NOPs (at cpu_relax()) due to a
CPU errata (otherwise a tight loop basically stalls other CPUs.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
