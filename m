Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB6C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8412073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DmalEv2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfDQJlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:41:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50150 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qym8A+lk+OJXy+EiiKGGUP9ArSACqfkoezGfablkRyI=; b=DmalEv2Ut0Tk1nd30aTfgPMCs
        651pZyQxnvNu2WwLV+2vEDyO7xVPcthBTmvhnUZlEEXpyIjeyFTMJn+SSqjZVuspzQ+Qu5U1HyXZX
        nmpjVDyUprdpJ/m+sv1dmkveR1aNQQ4FIPmd+tbSLS46s3pk5WRFTbWToAjlAF0OrOpc3imjsb5Os
        UP6FcnBMveTVqUR5cwJG+3L3NlDvlRowUae2MT1nar4eOrhXKnEzDMdnqq/7dN8JKZniprAMmzdIu
        pB53rfjlYJEalRb/tPKlA8oVH0ugyeLZaNijqHB9O0YXlH9KFfbYwoDWJucE9IipyHo9upQ2ef4pF
        6m5p9NlZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52138)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hGh4U-0000mN-T4; Wed, 17 Apr 2019 10:41:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hGh4T-0000ku-NJ; Wed, 17 Apr 2019 10:41:37 +0100
Date:   Wed, 17 Apr 2019 10:41:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: mm: Export __sync_icache_dcache() for
 xen-privcmd
Message-ID: <20190417094137.2gkbtinldiwbkvwy@shell.armlinux.org.uk>
References: <20190413163052.11407-1-xypron.glpk@gmx.de>
 <20190415055109.GB9279@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415055109.GB9279@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 10:51:09PM -0700, Christoph Hellwig wrote:
> On Sat, Apr 13, 2019 at 06:30:52PM +0200, Heinrich Schuchardt wrote:
> > This patch avoids
> > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> > observed when compiling v4.19.34.
> > 
> > The xen-privcmd driver, which can be modular, calls set_pte_at()
> > which in turn may call __sync_icache_dcache().
> 
> Maybe that really is a sign that it should not be modular..

This issue has been discussed several times, and this URL gives a list
of all messages on linux-arm-kernel that mention __sync_icache_dcache:

https://archive.armlinux.org.uk/lurker/search/20380101.000000.00000000@ml:linux-arm-kernel,sb:__sync_icache_dcache.en.html

At the beginning of March, Boris Ostrovsky pointed that another solution
is available that does not need architecture private symbols to be
exported.

Since I've already said in a previous thread that I don't want this
function exported, it seems the way forward is pretty obvious.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
