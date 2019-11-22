Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CE420672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BLzrPF7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKVAeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:34:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36278 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YL9UjrFzkCb8yeKfLOoIaW9TGt9+B8/y4tvJ5xKe8SE=; b=BLzrPF7JJVK/eQcSltF4pPT2H
        PNsjDKHbMyIPQt75OFD/xgt3Tran+t5t0JIl5n6NN5YV+rxoah/hQUcmbGwTcSHpVcL8gAB0ZqiSR
        3LqM+kxQu/0Oku48ZcpF17NSbkzCJmq5Vwcd8iGwI8tAxol1gULqUV8XJ1m924k97RK9bv/kGXFqb
        uKWRfp0mFUtW70cmQpzJSn8pqHW+NhtKzsSeMGZ1Qkwjc8tEbfYH6pv6aE+rZdLv8Io+sskEYleRZ
        rXGierSb3mbTZWA/k+2Mr4QKfJSorBdj9NjjUl56cMpEgCbwNXsOh0MU7deZIV5PBv7LQKlaozHFA
        ADu5Y77EA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42888)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXwth-0001eL-2J; Fri, 22 Nov 2019 00:34:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXwtf-0003CX-5J; Fri, 22 Nov 2019 00:34:03 +0000
Date:   Fri, 22 Nov 2019 00:34:03 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
Message-ID: <20191122003403.GG25745@shell.armlinux.org.uk>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com>
 <20191122002258.GD25745@shell.armlinux.org.uk>
 <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDtADA2eVwJAUEPhpic8vXWegh8yLjo6Q6WmXZDxAfJpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:30:41PM -0500, Pavel Tatashin wrote:
> > > +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> > > +static __always_inline void uaccess_enable(void)
> > > +{
> > > +     unsigned long val = DACR_UACCESS_ENABLE;
> > > +
> > > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > > +     isb();
> > > +}
> > > +
> > > +static __always_inline void uaccess_disable(void)
> > > +{
> > > +     unsigned long val = DACR_UACCESS_ENABLE;
> 
> Oops, should be DACR_UACCESS_DISABLE.
> 
> > > +
> > > +     asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> > > +     isb();
> > > +}
> >
> > Rather than inventing these, why not use uaccess_save_and_enable()..
> > uaccess_restore() around the Xen call?
> 
> Thank you for suggestion: uaccess_enable() and uaccess_disable() are
> common calls with arm64, so I will need them, but I think I can use
> set_domain() with DACR_UACCESS_DISABLE /DACR_UACCESS_ENABLE inside
> these inlines.

That may be, but be very careful that you only use them in ARMv7-only
code.  Using them elsewhere is unsafe as the domain register is used
for other purposes, and merely blatting over it (as your
uaccess_enable and uaccess_disable functions do) is unsafe.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
