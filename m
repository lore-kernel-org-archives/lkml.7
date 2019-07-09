Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A3AC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41E214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pskAPKBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfGIM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:26:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58898 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfGIMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GvMLu3D5SDi1KJdt5el5d+XQuPw1oygK/f6LNrT+0YI=; b=pskAPKBLg7tkZY0DhnAw61D/a
        UqqwwvfjNpbvptt8wh6CULtcob61iNxD9kRkY0Wf3QH9S3Gqp4yzlGn0d6BpsCCc/hLtAVOPNYhCT
        +uF/ZDGlc+zEj3KEF5JsCB3vm3NOxZeotCrnY2+ggftPi+HMQlQbCeOSg9Q41sq0/jrlwGII3/ZAb
        IXcpR4zgYt2ek926Qbwj5PChRTusnFcmHw/Fb9zOPrIK9FaWKIcS4lw3GGvqMJWXsB2nurNNBkUMy
        /6pb9uPgrPwPClonV010rkRJjkGzh3fQyyRTriFdwU8ZEvJ0RsSMwmZFeUJb9dmTX9ZHqXOr7N18d
        XdM03zd5w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60294)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hkpBx-0000ab-3o; Tue, 09 Jul 2019 13:25:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hkpBv-0002yZ-20; Tue, 09 Jul 2019 13:25:51 +0100
Date:   Tue, 9 Jul 2019 13:25:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
Message-ID: <20190709122550.nau44z32valjd5ir@shell.armlinux.org.uk>
References: <20190708203049.3484750-1-arnd@arndb.de>
 <CACRpkdZO6to2UsJ64FCYi3aOC79PEb9pxOBABBkgcmR_d82dYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZO6to2UsJ64FCYi3aOC79PEb9pxOBABBkgcmR_d82dYg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:17:58PM +0200, Linus Walleij wrote:
> On Mon, Jul 8, 2019 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > -#define xip_iprefetch()        do { asm volatile (".rep 8; nop; .endr"); } while (0)
> > +#define xip_iprefetch()        do {                                            \
> > +        asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");      \
> > +} while (0)                                                            \
> 
> This is certainly an OK fix since we use a row of inline nop at
> other places.
> 
> However after Russell explained the other nops I didn't understand I located
> these in boot/compressed/head.S as this in __start:
> 
>                 .rept   7
>                 __nop
>                 .endr
> #ifndef CONFIG_THUMB2_KERNEL
>                 mov     r0, r0
> #else
> 
> And certainly this gets compiled, right?
> 
> So does .rept/.endr work better than .rep/.endr, is it simply mis-spelled?
> 
> I.e. s/.rep/.rept/g
> ?
> 
> In that case we should explain in the commit that .rep doesn't work
> but .rept does.

According to the info pages for gas:

7.96 `.rept COUNT'
==================

Repeat the sequence of lines between the `.rept' directive and the next
`.endr' directive COUNT times.

So yes, ".rep" is mis-spelled, and it brings up the obvious question:
why isn't gas issuing an error for ".rep"?  There is no mention of
".rep" in the manual.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
