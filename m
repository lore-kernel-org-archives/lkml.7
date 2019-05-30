Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE872630C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ROS5L4Ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE3XRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:17:44 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50570 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfE3XRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aEc6ykxVWtoFlsoR9RzSRB7dyu5aRF0W+qRG3bvM/DI=; b=ROS5L4ZeqWRKJITipcJ0uftDf
        WOdDNP4RmpLF/2/UEnn+vuyDpTopw0+I19WAAqdLQkZ52Krg6KH4N8VxhjrQ/a5zwCfmG+xegBPP9
        xucwVi5FbHesiYS6y2SfIM8jQ4bkr81etYxucwggDoDQVbCQ0BzuJ6MwzGSBhWGyXwObUN9hwBTDs
        14QLSVXJ93ucjokginRWqBt1nyQlPtN+3sqEPTQNMekx+BcDtaAIp473a9JGeANdSrSV0c1rfwNPu
        IgJAvf69klEWbeK4I7kMI9lBi6og64RQPu1rAFNFaxJFXkIr51zHufWCY8k81SxWVkeqr3wPj0O71
        S99ARoxZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52728)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWUIk-0005eE-57; Fri, 31 May 2019 00:17:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWUIh-0005n8-F3; Fri, 31 May 2019 00:17:35 +0100
Date:   Fri, 31 May 2019 00:17:35 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH 0/2] arm64: smp: Include smp_plat.h from smp.h
Message-ID: <20190530231735.n7so5mhec72xjmhm@shell.armlinux.org.uk>
References: <20190530230518.4334-1-f.fainelli@gmail.com>
 <c0492b62-0ad2-3dae-7a6d-06e89afd59fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0492b62-0ad2-3dae-7a6d-06e89afd59fe@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:14:28PM -0700, Florian Fainelli wrote:
> On 5/30/19 4:05 PM, Florian Fainelli wrote:
> > Hi ARM64 maintainers,
> > 
> > This patch series aims at enabling irq-bcm7038-l1.c on
> > ARM64/ARCH_BRCMSTB, this driver makes use of cpu_logical_map[] and in
> > order to avoid adding a CONFIG_ARM64 conditional inclusion of
> > smp_plat.h, instead smp.h includes smp_plat.h, which is in turn included
> > by linux/smp.h.
> > 
> > If you like the approach, I would suggest to carry that through the
> > Broadcom ARM64 SoC pull request for 5.3.
> 
> ARM (32-bit) needs the same thing kind of thing so a conditional include
> may be appropriate after all...

The whole idea of the smp_plat.h vs smp.h separation is to avoid
including lots of arch-private stuff in the rest of the kernel
build, thereby exposing arch-private stuff to the world.  I'm be
opposed to that.

> 
> > 
> > Thank you!
> > 
> > Florian Fainelli (2):
> >   arm64: smp: Include smp_plat.h from smp.h
> >   arm64: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB
> > 
> >  arch/arm64/Kconfig.platforms      | 1 +
> >  arch/arm64/include/asm/smp.h      | 1 +
> >  arch/arm64/include/asm/smp_plat.h | 1 +
> >  3 files changed, 3 insertions(+)
> > 
> 
> 
> -- 
> Florian
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
