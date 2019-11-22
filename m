Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD08C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD72206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QDvDXbAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:53:47 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36596 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m8abUx8pSYpn1hn5D1w1GLb8aL+UUj0d2TyW9NfUG1g=; b=QDvDXbAXyOJq5lNNXeptcbMNI
        k0VOOqaMtYLgAsH3CMe5FWVVhuAK2Q6LNZOjK4odsCCM1Nt3Phq7R9wp5OcXjYdvnMflj6mnI7PBH
        dreG7wO50Wn1ZumhGlCeC8+ee4x0AIVreVJfffqnZrOUdAp8rmWQn7FKqJ0zTt6qON6JBxm6hrCt1
        baCBq+6gHLQ5/6oHlov+evlBhdaxnQmYoDOR7ren/sR9HvX04+IDgURZAcqSXWAvj7spzEslGG+1J
        jWNum5v1ebB+VbwhXd7tlF/z5W43Q2emlgEDWrOQsUTIHov/zb7VRYJSryVEAPmFGjGs0rB2hZ65Y
        SdDtKL8Sg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38760)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXxCJ-0001kC-NV; Fri, 22 Nov 2019 00:53:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXxCC-0003Dm-2F; Fri, 22 Nov 2019 00:53:12 +0000
Date:   Fri, 22 Nov 2019 00:53:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, stefan@agner.ch,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>, boris.ostrovsky@oracle.com,
        Sasha Levin <sashal@kernel.org>, sstabellini@kernel.org,
        James Morris <jmorris@namei.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, alexios.zavras@intel.com,
        Thomas Gleixner <tglx@linutronix.de>, allison@lohutok.net,
        jgross@suse.com, steve.capper@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>, info@metux.net
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
Message-ID: <20191122005311.GI25745@shell.armlinux.org.uk>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com>
 <20191122002258.GD25745@shell.armlinux.org.uk>
 <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
 <20191122003403.GG25745@shell.armlinux.org.uk>
 <20191122003524.GH25745@shell.armlinux.org.uk>
 <CA+CK2bAm0r8zLMz_gdq30zF8io5RzVnbXFSV9NkyT_uUxKJwLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAm0r8zLMz_gdq30zF8io5RzVnbXFSV9NkyT_uUxKJwLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:39:22PM -0500, Pavel Tatashin wrote:
> > > That may be, but be very careful that you only use them in ARMv7-only
> > > code.  Using them elsewhere is unsafe as the domain register is used
> > > for other purposes, and merely blatting over it (as your
> > > uaccess_enable and uaccess_disable functions do) is unsafe.
> >
> > In fact, I'll turn that into a bit more than a suggestion.  I'll make
> > it a NAK on adding them to 32-bit ARM.
> >
> 
> That's fine, and I also did not want to change ARM 32-bit. But, do you
> have a suggestion how differentiate between arm64 and arm in
> include/xen/arm/hypercall.h without ugly ifdefs?

Sorry, I don't.

I'm surprised ARM64 doesn't have anything like that, but I suspect
that's because they don't need to do a save/restore type operation.
Whereas, 32-bit ARM does very much need the save/restore behaviour
(although not in this path.)

The problem is, turning uaccess_enable/disable into C code means
that it's open to being used elsewhere in the kernel (ooh, a couple
of useful looking functions that work on both architectures!  I can
use that too!) and then we end up with stuff breaking subtly.  It's
the potential for subtle breakage that is making me NAK the idea of
adding the inline C functions.

Given the two have diverged, the only answer is ifdefs, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
