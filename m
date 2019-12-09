Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C3AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C4F207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EGDMJAMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLIRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:15:12 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42672 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLIRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yDkXn8c2FrkGfy+U0MRLuXrzEaNV8CpIo/QaRFz2xmk=; b=EGDMJAMzVzZqYHI5GtOsZe0vDx
        tq8tD6m0jNbrFCUTpJbj/4Q8jHLyi8GIWgNxrZFofOGSyH4vg6mJF5LvyTMJ6XF/mmlL1xiiKgPKd
        LVAHbKb2+yDoAQvdWqny4t+JS45zWGe18sLJa+z1g2gsUBblNbqfm8XM6no+X5BudnFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ieMcm-0006d0-NV; Mon, 09 Dec 2019 18:15:08 +0100
Date:   Mon, 9 Dec 2019 18:15:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ARM i.MX6q: make sure PHY fixup for KSZ9031 is
 applied only on one board
Message-ID: <20191209171508.GD9099@lunn.ch>
References: <20191209084430.11107-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209084430.11107-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij

> This patch changes the MICREL KSZ9031 fixup, which was introduced for
> the "Data Modul eDM-QMX6" board in following patch, to be only activated
> for this specific board.

...

>  static void __init imx6q_enet_phy_init(void)
>  {
> +	/* Warning: please do not extend this fixup list. This fixups are
> +	 * applied even on boards where related PHY is not directly connected
> +	 * to the ethernet controller. For example with switch in the middle.
> +	 */
>  	if (IS_BUILTIN(CONFIG_PHYLIB)) {
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  				ksz9021rn_phy_fixup);
> -		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
> -				ksz9031rn_phy_fixup);
> +
> +		if (of_machine_is_compatible("dmo,imx6q-edmqmx6"))
> +			phy_register_fixup_for_uid(PHY_ID_KSZ9031,
> +						   MICREL_PHY_ID_MASK,
> +						   ksz9031rn_phy_fixup);
> +
>  		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffef,
>  				ar8031_phy_fixup);
>  		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,

What about the other 3 fixups? Are they not also equally broken,
applied for all boards, not specific boards?

	Andrew
