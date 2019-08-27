Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BFE21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t5tRKOdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfH0Ogj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:36:39 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40330 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfH0Ogi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vhzf+dZDreIumgSd/qgIOrRav/zwhEMSkCEy/wY4MGU=; b=t5tRKOdOnczH2Hp+z218qFN8+
        Q6wWgCMBppznidCK3hI63kFTn7KvDPLsVRYWSRJ3U+i7fZZbXNF6UAbbCIOyaiwNszYvHF/G8g2Rv
        DstzRoKm5aVvHtIkRA/CD7ixm0rnM4FErN8Mj+JWDFNP5bNXO/rSEaRRi7GqoFU7r9SZj44Co6y9N
        1JpRW8mRZFDM+uNGTnD/AKX77SlKBCDbpDhOSz1MVRnrOuHIUIYJiPyYUHmKwD6WGcxlLF8Q0Ka4R
        NfcQGOM1W0GAQeajTvp09XKvuEpbFkyeHzyNfeIdYnc6PzkRQpeVm0rAbzu5tGXfUvr5gflfWs+C6
        v2BBQdvQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38660)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2caJ-0004zg-HP; Tue, 27 Aug 2019 15:36:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2caI-0005om-AW; Tue, 27 Aug 2019 15:36:34 +0100
Date:   Tue, 27 Aug 2019 15:36:34 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Continuous SD IO causes hung task messages
Message-ID: <20190827143634.GL13294@shell.armlinux.org.uk>
References: <20190827134337.GK13294@shell.armlinux.org.uk>
 <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:55:23PM +0200, Ulf Hansson wrote:
> On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > Hi,
> >
> > While dd'ing the contents of a SD card, I get hung task timeout
> > messages as per below.  However, the dd is making progress.  Any
> > ideas?
> >
> > Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> > for the card?
> 
> Is it a regression?
> 
> There not much of recent mmc core and mmc block changes, that I can
> think of at this point.

No idea - I just repaired the SD socket after the D2 line became
disconnected, and decided to run that command as a test.

> > ARM64 host, Macchiatobin, uSD card.
> 
> What mmc host driver is it? mmci?

sdhci-xenon.

I'm just trying with one CPU online, then I'll try with two.  My
suspicion is that there's a problem in the ARM64 arch code where
unlocking a mutex doesn't get noticed on other CPUs.

Hmm, I thought I'd try bringing another CPU online, but it seems
like the ARM64 CPU hotplug code is broken:

[ 3552.029689] CPU1: shutdown
[ 3552.031099] psci: CPU1 killed.
[ 3949.835212] CPU1: failed to come online
[ 3949.837753] CPU1: failed in unknown state : 0x0

which means I can only take CPUs down, I can't bring them back
online without rebooting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
