Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E3C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07EB20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UDRfkb10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfFRNwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:52:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46938 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/q4mYeWbhzG4mluYOK3emQt6O9KB4g3lyR9lno6o9Y=; b=UDRfkb10GftxLU8/5KRFfjN3B
        w/GohzNcLQPqzrUmdtGo2A6hO2NNQf9WgSI3u4kDq/jIwmxFBJNMwAC14m18MW2y1/jYiZYBr3Nh+
        LFsVKsj7AWOBxJGLEYgEkJFsIywahuGspOJD1QKM0JxMkPxOntbPETb3fnaHYKXOzod/khT3JybqT
        qoFOzGhrcavv2e4yLDhFPLNUV4vg/QdopjFdQhAyCaLfOgdbSAMWGNp8vL7PH2pS2aiIyKNkQjCOQ
        +79OeJNKHbK4ej+Qls3G4YvEgnJaZFajHUOGw+An5N7SX6OY7625AijjtYbk8ZyPghb5pGe4Vqgg4
        qZo6gDnVQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58900)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hdEXO-0002SS-Ns; Tue, 18 Jun 2019 14:52:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hdEXM-0000Vq-Bq; Tue, 18 Jun 2019 14:52:36 +0100
Date:   Tue, 18 Jun 2019 14:52:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        jun.nie@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Arm: zx: remove redundant dev_err message
Message-ID: <20190618135236.32qjlxfgt5rcety5@shell.armlinux.org.uk>
References: <1560843541-11611-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <20190618134634.GL1959@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618134634.GL1959@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:46:36PM +0800, Shawn Guo wrote:
> On Tue, Jun 18, 2019 at 03:39:01PM +0800, Ding Xiang wrote:
> > devm_ioremap_resource already contains error message, so remove
> > the redundant dev_err message
> > 
> > Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Arnd, Olof,
> 
> Can you please apply it to arm-soc tree?  Thanks.
> 
> Shawn
> 
> > ---
> >  arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
> > index 7a08bf9d..ac44ea8 100644
> > --- a/arch/arm/mach-zx/zx296702-pm-domain.c
> > +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> > @@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	pcubase = devm_ioremap_resource(&pdev->dev, res);
> > -	if (IS_ERR(pcubase)) {
> > -		dev_err(&pdev->dev, "ioremap fail.\n");
> > +	if (IS_ERR(pcubase))
> >  		return -EIO;

Shouldn't the error return also get fixed?

> > -	}
> >  
> >  	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
> >  		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
> > -- 
> > 1.9.1
> > 
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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
