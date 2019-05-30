Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48666262F7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g803IyKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE3Xee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:34:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50764 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3Xee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hz3TUVy+fk7QzxStO7gYvUeaWeWPlTOz3axkOG534dE=; b=g803IyKm/XCD6t3YsBtwE8rEE
        j/thrRuF9f8ZHHnpNh/TarPKtCum7k3InzE+013q9567uwQylEqGn37vRHeT3g7F9qFMaJIZbuMcM
        HOSDmJnT8wrOm27JeNAS2D3nk5OsHDaku302gd2MMaREbkwRVWm6z7glIXn20QyfIy5WFACfEYFm0
        H9RaEi2NfBNdrV5S15lLx13lcyYBFmq66e4XDQdHsvFZgmB9R7wrllofDc12c7L38f+X+ugELMGau
        cHcDmdagjJ2jIqQsFKWiECT4Yx9h0+CLes44vyhY/ArRX+qFaa3LRzRNcfm5AnDhIivVUQnZdYKYD
        qu6DNfcDQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38386)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWUZ3-0005ia-VJ; Fri, 31 May 2019 00:34:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWUZ1-0005nP-UE; Fri, 31 May 2019 00:34:27 +0100
Date:   Fri, 31 May 2019 00:34:27 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: smp: Include smp_plat.h from smp.h
Message-ID: <20190530233427.qbaa76ukbzuuic22@shell.armlinux.org.uk>
References: <20190530230518.4334-1-f.fainelli@gmail.com>
 <c0492b62-0ad2-3dae-7a6d-06e89afd59fe@gmail.com>
 <20190530231735.n7so5mhec72xjmhm@shell.armlinux.org.uk>
 <43c5568f-b230-0ed2-e810-7870703b54f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c5568f-b230-0ed2-e810-7870703b54f0@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 04:20:37PM -0700, Florian Fainelli wrote:
> On 5/30/19 4:17 PM, Russell King - ARM Linux admin wrote:
> > On Thu, May 30, 2019 at 04:14:28PM -0700, Florian Fainelli wrote:
> >> On 5/30/19 4:05 PM, Florian Fainelli wrote:
> >>> Hi ARM64 maintainers,
> >>>
> >>> This patch series aims at enabling irq-bcm7038-l1.c on
> >>> ARM64/ARCH_BRCMSTB, this driver makes use of cpu_logical_map[] and in
> >>> order to avoid adding a CONFIG_ARM64 conditional inclusion of
> >>> smp_plat.h, instead smp.h includes smp_plat.h, which is in turn included
> >>> by linux/smp.h.
> >>>
> >>> If you like the approach, I would suggest to carry that through the
> >>> Broadcom ARM64 SoC pull request for 5.3.
> >>
> >> ARM (32-bit) needs the same thing kind of thing so a conditional include
> >> may be appropriate after all...
> > 
> > The whole idea of the smp_plat.h vs smp.h separation is to avoid
> > including lots of arch-private stuff in the rest of the kernel
> > build, thereby exposing arch-private stuff to the world.  I'm be
> > opposed to that.
> 
> I was on the fence, sent it just in case, but ended up doing this:
> 
> https://lore.kernel.org/patchwork/patch/1082410/
> 
> will take patch #2 through the Broadcom ARM64 SoC tree once this patch
> above gets accepted.

Well, there's another alternative: we move just what is required from
smp_plat.h to smp.h.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
