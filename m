Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9038021D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HmhgVhLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKGXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:39:35 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59868 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKGXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1qs3twHrOv8/gUtMmC9w6XFHjj/oevpNdMaw8wOsiFs=; b=HmhgVhLYU5zOEYAsJyAWNV36y
        qtTI1yT+j4t0goRi19K2HC9r/j7qFLN5Yd9Z06xCTd7nYkf9QuD+f3mDY5Zo6o3kLFr/440S5v+YX
        VpDoyLub0gM0XtTv1Ta4bGPWIJqrFYhGqnYe/qFPnk/6ViWCPh9mNOFR9JFl78fXF9slInV08y2aW
        SvVj3uGMwsgyoXuFwshkdXHwXQ8QgEpWwYyfTkZCTKBXHNGmn8HyQgWvcdrWaaqn41sWrOu2aiN9/
        YUKIZMoyoU2ER4/xYUqckW3JnuEtT/YRKkVwTil2PoMKPKCP5vdZkmqMJQN29lImcz3IP1dJDo/OM
        dXYUkrTfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36606)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iSrN4-0006Zz-HV; Thu, 07 Nov 2019 23:39:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iSrMw-0005P4-BS; Thu, 07 Nov 2019 23:39:14 +0000
Date:   Thu, 7 Nov 2019 23:39:14 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     megous@megous.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, kishon@ti.com, paul.kocialkowski@bootlin.com,
        linux-sunxi@googlegroups.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191107233914.GW25745@shell.armlinux.org.uk>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191107204645.13739-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107204645.13739-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Spotted while trying to add compile time checks of GENMASK arguments.
> Patch has only been compile tested.

My feeling, personally, is that GENMASK() really isn't worth the pain
it causes.  Can we instead get rid of this thing and just use easier
to understand and less error-prone hex masks please?

I don't care what anyone else says, personally I'm going to stick with
using hex masks as I find them way easier to get right first time than
a problematical opaque macro - and I really don't want the effort of
finding out that I've got the arguments wrong when I build it.  It's
just _way_ easier and less error prone to use a hex mask straight off.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
