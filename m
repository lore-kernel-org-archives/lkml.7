Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7032173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zlwxkvKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfDQKbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:31:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50772 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfDQKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mlspx2F3hquyjaWbJCFMBJqDbcOeqhgLomei92f1A3Y=; b=zlwxkvKb2XrzTEXnY0P1LO/lt
        2sF6JLnyGuXvfpCe0SX7ucnnXsifKSWkYWvB1SlEl6qlX8HTyhY3uCoH6XZwE9SppsuzN7T05XISD
        JpoMsQV0PJ9vkvRNRCi2L3FBUQuXuNoI0f594pU1HtXk83d2yulRtKFEUqI0SlgJjRlnh4dYEVDc7
        MXv8youhQtNvnHJ5u/aY1SiVJ13+4n5t7AqxILPsBwr/2daNZTTcHzutjH3d5Ud7Y6lqW0l+5HTUG
        pAaq4Hqd2GpG7xcnB5jbcrB7ZicQHY/fGXRim+jZACtmvB+UBFhOGZ2bq8hlZgOvEvZTaq/PA/a+u
        iHeXNcstw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52140)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hGhqL-00011w-7N; Wed, 17 Apr 2019 11:31:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hGhqJ-0000mJ-1Z; Wed, 17 Apr 2019 11:31:03 +0100
Date:   Wed, 17 Apr 2019 11:31:02 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] arm: mm: Export __sync_icache_dcache() for
 xen-privcmd
Message-ID: <20190417103102.rl33skdknnqshcoj@shell.armlinux.org.uk>
References: <20190413163052.11407-1-xypron.glpk@gmx.de>
 <20190415055109.GB9279@infradead.org>
 <20190417094137.2gkbtinldiwbkvwy@shell.armlinux.org.uk>
 <20190417100351.oix3df7hwwivgf7k@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417100351.oix3df7hwwivgf7k@mbp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:03:51AM +0100, Catalin Marinas wrote:
> On Wed, Apr 17, 2019 at 10:41:37AM +0100, Russell King wrote:
> > On Sun, Apr 14, 2019 at 10:51:09PM -0700, Christoph Hellwig wrote:
> > > On Sat, Apr 13, 2019 at 06:30:52PM +0200, Heinrich Schuchardt wrote:
> > > > This patch avoids
> > > > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> > > > observed when compiling v4.19.34.
> > > > 
> > > > The xen-privcmd driver, which can be modular, calls set_pte_at()
> > > > which in turn may call __sync_icache_dcache().
> > > 
> > > Maybe that really is a sign that it should not be modular..
> > 
> > This issue has been discussed several times, and this URL gives a list
> > of all messages on linux-arm-kernel that mention __sync_icache_dcache:
> > 
> > https://archive.armlinux.org.uk/lurker/search/20380101.000000.00000000@ml:linux-arm-kernel,sb:__sync_icache_dcache.en.html
> > 
> > At the beginning of March, Boris Ostrovsky pointed that another solution
> > is available that does not need architecture private symbols to be
> > exported.
> > 
> > Since I've already said in a previous thread that I don't want this
> > function exported, it seems the way forward is pretty obvious.
> 
> Arnd submitted a patch, not sure what happened to it:
> 
> https://lore.kernel.org/lkml/20190304204826.2414365-1-arnd@arndb.de/

Thanks Catalin, this is the "another solution" that I referred to above.
(You'll find the exact same URL in Boris' email.)

> I think this boils down to whether set_pte_at() is allowed to be called
> from loadable modules. If yes, __sync_icache_dcache() needs exporting,
> otherwise Arnd's patch makes the relevant code built-in (and, if merged,
> I'm happy to revert the similar export on arm64).

I think I've clearly expressed my opinion on that.  Hence why "the way
forward is pretty obvious."  I don't understand why we still have the
problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
