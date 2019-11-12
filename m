Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C23C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AC420656
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ah4mAq6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKLO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:56:04 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53616 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfKLO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CC6CDOjq53lam0n3yDiGEmY1dG4I1rOGEfq4W7Fmwjw=; b=Ah4mAq6xeMy0RJp4jo/JkpuRf
        8hfsp1qtuvNn+wWx+lc6z+YAcUxqHvrqbqBkYnd0Vhpffd5Ooy3oI9PmOFUFwAMf2MCZ0E8bkKWVy
        qnql9BefveI2ESRbHqnV5FTIPK5//sb8dTaZDdyOdrr2NweIC/cfBF3c3k4NmRMVy3Yh4TaQmWYU3
        PcyMMv5qmWCXrjX9FkzlbLHIkSXCfMGRlPEsfq7/069xjqRVs79HJXIZ596SjfcGMgnFloIR3WDZQ
        N4FzaSiG2ev1S5TbOdBMSyg6WDvC7yDskKCTdHP02N6XRAFDBqw3fl9IQGZXvOsHaZn/7Inls3ms/
        A7jqS2qhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38692)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iUXaC-0006Gb-1Q; Tue, 12 Nov 2019 14:55:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iUXa1-0001Td-TE; Tue, 12 Nov 2019 14:55:41 +0000
Date:   Tue, 12 Nov 2019 14:55:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] arm: kernel: initialize broadcast hrtimer based clock
 event device
Message-ID: <20191112145541.GK25745@shell.armlinux.org.uk>
References: <20191112120625.20173-1-benjamin.gaignard@st.com>
 <alpine.DEB.2.21.1911121547490.1833@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911121547490.1833@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:48:10PM +0100, Thomas Gleixner wrote:
> On Tue, 12 Nov 2019, Benjamin Gaignard wrote:
> 
> > On platforms implementing CPU power management, the CPUidle subsystem
> > can allow CPUs to enter idle states where local timers logic is lost on power
> > down. To keep the software timers functional the kernel relies on an
> > always-on broadcast timer to be present in the platform to relay the
> > interrupt signalling the timer expiries.
> > 
> > For platforms implementing CPU core gating that do not implement an always-on
> > HW timer or implement it in a broken way, this patch adds code to initialize
> > the kernel hrtimer based clock event device upon boot (which can be chosen as
> > tick broadcast device by the kernel).
> > It relies on a dynamically chosen CPU to be always powered-up. This CPU then
> > relays the timer interrupt to CPUs in deep-idle states through its HW local
> > timer device.
> > 
> > Having a CPU always-on has implications on power management platform
> > capabilities and makes CPUidle suboptimal, since at least a CPU is kept
> > always in a shallow idle state by the kernel to relay timer interrupts,
> > but at least leaves the kernel with a functional system with some working
> > power management capabilities.
> > 
> > The hrtimer based clock event device is unconditionally registered, but
> > has the lowest possible rating such that any broadcast-capable HW clock
> > event device present will be chosen in preference as the tick broadcast
> > device.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks.  Benjamin, please put it in the patch system, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
