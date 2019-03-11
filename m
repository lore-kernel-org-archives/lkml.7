Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DE220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCKGEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:04:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35029 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfCKGEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:04:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id u128so2703953oie.2;
        Sun, 10 Mar 2019 23:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSapUpA0pzYCAn8Jvn+j6sg1I2riCY6Z1DgDzKtLPDY=;
        b=TzMy0/uKi1HAefI6T7CmsmnZWnHiMKoxT1TwoqHCgauAd3G0qP68qJJ2h9h2xdNBZy
         KM3+XwezumJwHPg9ZPTnhBDqROqqzLJ43H1pf8mS6AkFEJP/DlryyKQ0rn33b8rMmIOp
         +MKm32q5MQiUTo8ABxfH2T7hTw40TsMxG6cSZyilfQRv2le5Plxhi4lJ2iEDNbtST8dd
         Z89SFxKzJEPLG10q31pV2vyBDnbLN6N8j3hm3oUOUUZsk2umJ0ajmoJqTG2rt3A+o8nT
         ejV1+ZlOc3V5iyE4IKX2xNN6OUGIsZYI8a8vSyzW/KAAJ0WM4/tl2lkL/Uc8rzVJHbG4
         dUuw==
X-Gm-Message-State: APjAAAUiL3MS4ASBf2qUcVwZtuvCysht6GhOCyII+PrwjE+U+qIRvVzp
        KOttfaP/1WdyZEUM/hOrbvNP7gUU6lc6vVeIy8k=
X-Google-Smtp-Source: APXvYqxWoz7e7rREaUe8t1gTOeBvk6/faNCwCprEO/s4attHftAIcmwYcWUAfBe8wFFa8W0HOiyqDMMyoWzVVAG/anc=
X-Received: by 2002:aca:6189:: with SMTP id v131mr11170157oib.176.1552284277742;
 Sun, 10 Mar 2019 23:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch> <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com> <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
 <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
 <CAFcVECJ8G99XiqHpYYh=3Aj4Bt_2V4kfDdBmLQqpdo59BRjs-Q@mail.gmail.com>
 <CAFcVECKU7zD2ms76GH-mF2GxCtNr4RQ+2=jN_xppueQsUSq2wg@mail.gmail.com> <20190309161912.GD9000@lunn.ch>
In-Reply-To: <20190309161912.GD9000@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Mon, 11 Mar 2019 11:34:27 +0530
Message-ID: <CAFcVEC+bw6TMykW46z2MXOdx7yhWEO7SZ4AoYM27rBCzD1b15w@mail.gmail.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
On Sat, Mar 9, 2019 at 9:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Related to this, I have a query on how the DT node for gmii2rgmii should look.
> > One of the users of gmii2rgmii is Cadence macb driver. In Xilinx tree, we use
> > this piece of code to register this mdiobus:
> > + mdio_np = of_get_child_by_name(np, "mdio");
> > + if (mdio_np) {
> > + of_node_put(mdio_np);
> > + err = of_mdiobus_register(bp->mii_bus, mdio_np);
> > + if (err)
> > + goto err_out_unregister_bus;
> >
> > And the DT node looks like this:
> > ethernet {
> >     phy-mode = "gmii";
> >     phy-handle = <&extphy>;
> >
> >     mdio {
> >         extphy {
> >             reg = <x>;
> >         };
> >         gmii_to_rgmii{
> >             compatible = "xlnx,gmii-to-rgmii-1.0";
> >             phy-handle = <&extphy>;
> >             reg = <x>;
> >         };
> >     };
> > };
>
> Hi Harini
>
> You have this setup:
>
> MAC <==> GMII2RGMII <==> RGMII_PHY
>
> So you want the MAC phy-handle to point to the gmii_to_rgmii 'PHY'.
>
> Feel free to submit a patch extending
> Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt to include
> a MAC node, etc.

Thank you, will do the same.

Regards,
Harini
