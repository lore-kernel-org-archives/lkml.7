Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8016C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76497218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B9wEMfNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfB1Jgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:36:37 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45430 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfB1Jgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7y9xwG/CRNbW3l4I71tOuUDLnb461h3PL9eNliEsxkY=; b=B9wEMfNwMMlkg39faULMRI4lp
        4OdKeBgV8bJvFvgk9s27XqB56w4uAf1l+CGHI6/e0EfTjDKIivQULsXosOcG7Qfox4zyY0wlhH1Bo
        QOwS8U14yy10Tzk5hF0XXa+ESsfQYWDu9N/gmXPy3Ru4nPsUU49wzwrYcBq+jEFNcyidJn/1oZANf
        T1NIjQs9p0L1b458AmpCJ75thoDWiuIfl4DxYHj2p2nmsf6k7FcBVd3A4oomCm+RpGrohL711rI24
        dQLTCgUAoZtnPOweuH+CvsGISC2QknL9Y0k6FQTBtIMVRBk0VfWTuh/Nyd9GEQlRbdUITcq1nYe2I
        li2A4GIOQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37166)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gzI7E-0007tY-3J; Thu, 28 Feb 2019 09:36:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gzI79-0007Hx-U4; Thu, 28 Feb 2019 09:36:27 +0000
Date:   Thu, 28 Feb 2019 09:36:27 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, antoine.tenart@bootlin.com,
        jaz@semihalf.com, gregory.clement@bootlin.com, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, tn@semihalf.com, stefanc@marvell.com,
        davem@davemloft.net
Subject: Re: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE frames
Message-ID: <20190228093627.vtfglsl2djenohlm@shell.armlinux.org.uk>
References: <1551289652-7377-1-git-send-email-mw@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551289652-7377-1-git-send-email-mw@semihalf.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:47:32PM +0100, Marcin Wojtas wrote:
> Current version of the driver was configuring XLG MAC
> in a way to wait 3 IDLE frames before allowing for the
> link-up interrupt to be triggered. This resulted in an
> issue, preventing to detect the link change during RX
> traffic on the interface. Fix that.

What about noise sensitivity?  Does this now mean that on boards such as
Macchiatobin Single Shot or Clearfog GT9k where the serdes is connected
directly to a SFP cage, that noise on the serdes lines triggers a link
indication?

> 
> Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 16066c2..f1378f9 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4532,8 +4532,7 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
>  		ctrl0 |= MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
>  
>  	ctrl4 &= ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
> -	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
> -		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
> +	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
>  
>  	writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
>  	writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
> -- 
> 2.7.4
> 
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
