Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68733C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292D2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3e2kTX06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfCIQTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:19:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50616 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfCIQTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3LaHrgLeaPGmxpLltQIlj1BIy7Ub2V76F5fHZgYA9yQ=; b=3e2kTX068ob6pitnIyEMKyB0jx
        XrbDAYjnhL9a+DZTAGIkc7kTZK6PABqhSkMEuNG3obXbxmmO0SF8thb3lxeXW1IRarX2MtsrO2Mlr
        +cC/DOxycfLmoJmg3H6CRuC2c6wVVbR08DqndYWABa94BtIb3PWy2IkqZO48ssMiuQfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h2egq-00018t-Dt; Sat, 09 Mar 2019 17:19:12 +0100
Date:   Sat, 9 Mar 2019 17:19:12 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harinik@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
Message-ID: <20190309161912.GD9000@lunn.ch>
References: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com>
 <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
 <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
 <CAFcVECJ8G99XiqHpYYh=3Aj4Bt_2V4kfDdBmLQqpdo59BRjs-Q@mail.gmail.com>
 <CAFcVECKU7zD2ms76GH-mF2GxCtNr4RQ+2=jN_xppueQsUSq2wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcVECKU7zD2ms76GH-mF2GxCtNr4RQ+2=jN_xppueQsUSq2wg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Related to this, I have a query on how the DT node for gmii2rgmii should look.
> One of the users of gmii2rgmii is Cadence macb driver. In Xilinx tree, we use
> this piece of code to register this mdiobus:
> + mdio_np = of_get_child_by_name(np, "mdio");
> + if (mdio_np) {
> + of_node_put(mdio_np);
> + err = of_mdiobus_register(bp->mii_bus, mdio_np);
> + if (err)
> + goto err_out_unregister_bus;
> 
> And the DT node looks like this:
> ethernet {
>     phy-mode = "gmii";
>     phy-handle = <&extphy>;
> 
>     mdio {
>         extphy {
>             reg = <x>;
>         };
>         gmii_to_rgmii{
>             compatible = "xlnx,gmii-to-rgmii-1.0";
>             phy-handle = <&extphy>;
>             reg = <x>;
>         };
>     };
> };

Hi Harini

You have this setup:
  
MAC <==> GMII2RGMII <==> RGMII_PHY

So you want the MAC phy-handle to point to the gmii_to_rgmii 'PHY'.

Feel free to submit a patch extending
Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt to include
a MAC node, etc.

   Andrew
