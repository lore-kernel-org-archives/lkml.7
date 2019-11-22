Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DFBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E3520672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L+ozNyJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKVAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:35:45 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36360 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVAfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aNyMrZGi1ytX4T6Y1L2udQxbuMw2fttK87FjgMDAYUk=; b=L+ozNyJ+BLJds7rUUZwTGmJ7R
        5e4PdATY1wuc72kBvYhSNqzWkMLSHsiNJaRKKZ+QW6c/CaPxnlL0mM/RPN1bk4jPOFZREl6QSpL4L
        U3SAD87N8NAF8bzJqfo9CxhGXIHbgmAZZDd6BRqC9ys8sxVq7Xz172xTF71hYopdiv8Ho/rc7y1Yp
        9U9/ujkr8zeakeK8TCVh42YDuJelKERsJKDzxphKgN/A7SiBXQtk6Xcx/3Op+FveXgSucAFoCOSum
        XMJNkFyEpvPjQWNAF0yn6kqWii0P0XsxVVkOtrF7xV1CzBDQeXXUUFjx0ebt5BwyPw9NsN4yUw2ZV
        6LjfuU4/g==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38750)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXwuz-0001fH-G7; Fri, 22 Nov 2019 00:35:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXwuy-0003Cf-Q2; Fri, 22 Nov 2019 00:35:24 +0000
Date:   Fri, 22 Nov 2019 00:35:24 +0000
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
Message-ID: <20191122003524.GH25745@shell.armlinux.org.uk>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com>
 <20191122002258.GD25745@shell.armlinux.org.uk>
 <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
 <20191122003403.GG25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122003403.GG25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:34:03AM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Nov 21, 2019 at 07:30:41PM -0500, Pavel Tatashin wrote:
> > > > +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> > > > +static __always_inline void uaccess_enable(void)
> > > > +{
> > > > +     unsigned long val = DACR_UACCESS_ENABLE;
> > > > +
> > > > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > > > +     isb();
> > > > +}
> > > > +
> > > > +static __always_inline void uaccess_disable(void)
> > > > +{
> > > > +     unsigned long val = DACR_UACCESS_ENABLE;
> > 
> > Oops, should be DACR_UACCESS_DISABLE.
> > 
> > > > +
> > > > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > > > +     isb();
> > > > +}
> > >
> > > Rather than inventing these, why not use uaccess_save_and_enable()..
> > > uaccess_restore() around the Xen call?
> > 
> > Thank you for suggestion: uaccess_enable() and uaccess_disable() are
> > common calls with arm64, so I will need them, but I think I can use
> > set_domain() with DACR_UACCESS_DISABLE /DACR_UACCESS_ENABLE inside
> > these inlines.
> 
> That may be, but be very careful that you only use them in ARMv7-only
> code.  Using them elsewhere is unsafe as the domain register is used
> for other purposes, and merely blatting over it (as your
> uaccess_enable and uaccess_disable functions do) is unsafe.

In fact, I'll turn that into a bit more than a suggestion.  I'll make
it a NAK on adding them to 32-bit ARM.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
