Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0366C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542F2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhXR0ZeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfK1OgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:36:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1OgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:36:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so11953695wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKiEZcP/L0A2rXbC8H4X5BIo7afN1A6dEGoky6fB7+8=;
        b=RhXR0ZeX7CH630cBBVDoTbDoIg+bfQnEe2e5PKJaG+yclednb5kM9Y8Eng7aDWJBHD
         FU+5IR6gwHueelOoVC5PQ9vj7rTsr6WVwO/xezZKm9KcUrDbc3Y5NXad2IRnlpsxCcqK
         Gss6Um5uf+b8l7ectAJJFFZnmILUBtHFPQkOue+8KkSReFVzzVWOau+8x2QV2jTKpVYL
         nyzYgq5pEwhmLshnmQ3nFu6lftJ7Biw967BKpgd1OE56aukGAWt0nMdm00/+wDERZqc3
         DmGmmlALK+fd77in10AzgYAaYH6EW0ZfplukAUtqjF0UMXZX/qOaWtJlVTN1gUV6QRfJ
         6q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKiEZcP/L0A2rXbC8H4X5BIo7afN1A6dEGoky6fB7+8=;
        b=TbUTreM0zfatwx5Ct7Y8bofxgWw4+0QRjsUbPH5M45dKKR0Qg6YlIDlJtqQZmpxXDn
         kNy9m7aXpmqN0OPNnx4/qKMQKNSPLzNSqvsJCsnWOWacxz8scuryphMfoAlTjAXulkGL
         kVegmpOGXjq4v/ypBsp44ScFBUfyWYDaanE8E2xezQXTtF965HWwtmEdq/7GqOXohQUD
         Hx6vaviQbYmGc/zneG1/XGPy7yi3GrXrw1z/qD0ZG3weJQd2tqcdZCcUm+oZXCk9lmyY
         O/jXiRa1oObX2cz7ARIAUPUHrnSyuVRyiI1UyqtTEMnp1BXH+MulgphyA7qEZmXnaecH
         M1og==
X-Gm-Message-State: APjAAAV9LYZruePnqAbPvLJ0mniDwtBphBeWRS8JhdhvpmZnpnwvFUg+
        U47nWNvu43sJ2wO4wyubFDo=
X-Google-Smtp-Source: APXvYqz92pJeCW/D9VAvn7Uh3kFxNyM3AMWtDGRKPIpvVxERBR51hrNagMQf2h4L/AmqzwtIH2/3AA==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr10220347wml.41.1574951763538;
        Thu, 28 Nov 2019 06:36:03 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id m15sm23751006wrj.52.2019.11.28.06.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Nov 2019 06:36:02 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:16:44 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191128121644.GD2460@optiplex>
References: <20191127124638.GC5108@optiplex>
 <1ed54a69-c29f-6008-02ae-11d16f68b265@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed54a69-c29f-6008-02ae-11d16f68b265@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/19, Marc Gonzalez wrote:
> On 27/11/2019 13:46, Oliver Graute wrote:
> 
> > On 27/11/19, Marc Gonzalez wrote:
> >
> >> On 26/11/2019 15:54, Oliver Graute wrote:
> >>
> >>> this patch broke my imx8qm nfs setup. With the generic phy driver my
> >>> board is booting fine. But with the AT803X_PHY=y enabled  I'm running
> >>> into the following phy issue. So on my side it looks inverse as on
> >>> yours. What is the best proposal to fix this?
> >>>
> >>> [    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> >>> [    5.573206] Sending DHCP requests ...... timed out!
> >>> [   95.339702] IP-Config: Retrying forever (NFS root)...
> >>> [   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> >>> [   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> >>> [   99.461206] Sending DHCP requests ...... timed out!
> >>
> >> Which DTS are you using?
> > 
> > I'am using this DTS which I'am currently working on:
> > 
> > https://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/689501.html
> >>
> >> I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.
> > 
> > So what should I fix in my device tree?
> 
> In the board DTS I used to work on, I had this:
> 
> &eth0 {
> 	phy-connection-type = "rgmii-id";
> 	phy-handle = <&eth0_phy>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	/* Atheros AR8035 */
> 	eth0_phy: ethernet-phy@4 {
> 		compatible = "ethernet-phy-id004d.d072",
> 			     "ethernet-phy-ieee802.3-c22";
> 		interrupts = <37 IRQ_TYPE_EDGE_RISING>;
> 		reg = <4>;
> 	};
> };
> 
> In your DTS, you #include "imx8qm.dtsi"
> I found no such file:
> $ git ls-files | grep imx8qm

yes this file is not yet added to Shawn Guos next tree.
Latest patch can be found here:

 https://patchwork.kernel.org/patch/11248331/

> 
> In your patch:
> https://patchwork.kernel.org/patch/11211567/
> 
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-txid";
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	fsl,rgmii_rxc_dly;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <4>;
> +			at803x,eee-disabled;
> +			at803x,vddio-1p8v;
> +		};
> +	};
> +};
> 
> Try all possible 'phy-mode' (rgmii, rgmii-id, rgmii-rxid, rgmii-txid)
> Investigate 'fsl,rgmii_rxc_dly' (it's not a standard Linux DT prop)
> Documentation/devicetree/bindings/net/ethernet-controller.yaml

thx for this hint.

Best regards,

Oliver
