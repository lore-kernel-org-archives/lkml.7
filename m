Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D282C742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B3920863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pxG2ppYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGLI4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:56:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49344 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfGLI4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ye7QJTr/VL6E13dVCzENZu/bqsS/Cpo3ATNqw8M0Wbk=; b=pxG2ppYhl5upfZIplcnu4BB/J
        C8O72GDBPB+mMJlIgQuFVo8voDRw0gWSSzD9M/au+DXaQXF2Qnqyo6KJ/2XbNhDrln110BxavS8HW
        /jEHpLHkwOrPTZh0SL0E+EMRYGdWN3XuwJo9nnmA1W+QX0VJHJuYY+cABCL9CGPliDF8TpE5hO/3X
        4Xm5DJi9NHh02iMQu78LT+p/u2yOFOWdUc9xl5+wTFasXX/+iVSUBshgElltYL/W41vFkrzSVj8Ua
        V/I8xHMcaE1IoF3UGXj7GhlzNXLG2tb4H+le/43Bj4/aQzT2yigHtan9nv02+SN1uyXTJXwjcr1yS
        93AjNjfKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60362)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hlrLc-0000p6-7n; Fri, 12 Jul 2019 09:56:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hlrLX-0005XL-2W; Fri, 12 Jul 2019 09:56:03 +0100
Date:   Fri, 12 Jul 2019 09:56:02 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "info@metux.net" <info@metux.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Message-ID: <20190712085602.v2tncu5tsngtvbww@shell.armlinux.org.uk>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
 <14f02e29-77b2-29d9-a9f4-7f89ad0194f6@arm.com>
 <1562900298.1345.12.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562900298.1345.12.camel@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:58:18AM +0000, Raslan, KarimAllah wrote:
> On Fri, 2019-07-12 at 08:06 +0530, Anshuman Khandual wrote:
> > 
> > On 07/12/2019 03:51 AM, KarimAllah Ahmed wrote:
> > > 
> > > Some valid RAM can live outside kernel control (e.g. using mem= kernel
> > > command-line). For these regions, pfn_valid would return "false" causing
> > > system RAM to be mapped as uncached. Use memblock instead to identify RAM.
> > 
> > Once the remaining memory is outside of the kernel (as the admin would have
> > intended with mem= command line) what is the particular concern regarding
> > the way those get mapped (cached or not) ? It is not to be used any way.
> 
> They can be used by user-space which might lead to them being used by the 
> kernel. One use-case would be using them as guest memory for KVM as I detailed 
> here:
> 
> https://lwn.net/Articles/778240/

From the 32-bit ARM point of view...

What if someone's already doing something similar with a non-coherent
DSP and is relying on the current behaviour?  This change is a user
visible behavioural change that could end up breaking userspace.

In other words, it isn't something we should rush into.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
