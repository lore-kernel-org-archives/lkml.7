Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE404C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8828720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfCKM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:27:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:27:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id t7so3715226otk.8;
        Mon, 11 Mar 2019 05:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MivUfwAF8id8U4PNcmDQ+n5SKWGtEZQQuDAkhjyNSU4=;
        b=S1zYTeaCAGqfGVh6jUULr5kwjZt9mjuD/Ad3N/anP2ofQcrsiY+KTgS24U3m38ooIx
         o6zuEDPAdqftnnGI27UW2HL+9utXLOezq3bO+PPtczx/Ui1DpdPo/Lkz0umjBJF37u/C
         qw3Uyztd5RMjg8jMpSsutWZEDIYdZymmcTbCk33FSzzkdZYFCPaJOkL1jLuXams+FAbm
         3S98YJLMYyL6Kvart/pQ9YWrUmPOmmk+Eke1DgF17JxOjMHQwurMgzEI4ZGwfdn1M1Bn
         usyA8Y6Btg/jaihsDrksE7wvahPJBrJvZDfUM4MLXV3u4NsCMY2JYmdjDvqfNU45lZzD
         biyw==
X-Gm-Message-State: APjAAAUIMUvAMmPTcgXVtTnNvmyACPjsS6LGm2Wy+2gwY7G3dUVNox7R
        0buidLiSuAQTjaCtsMf43lbrbMBtChYeeTdgMs0ftQ==
X-Google-Smtp-Source: APXvYqwviYo5FaxZ68ViyFe0INvhdNNQf2ibgq5R6z9EwF+fU2Gp2TaNZ+g2MORWs+dMDUsZphcN3gPUaopiMHiQnW4=
X-Received: by 2002:a9d:58c6:: with SMTP id s6mr20790606oth.122.1552307235001;
 Mon, 11 Mar 2019 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch> <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com> <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
 <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
 <CAFcVECJ8G99XiqHpYYh=3Aj4Bt_2V4kfDdBmLQqpdo59BRjs-Q@mail.gmail.com>
 <CAFcVECKU7zD2ms76GH-mF2GxCtNr4RQ+2=jN_xppueQsUSq2wg@mail.gmail.com>
 <20190309161912.GD9000@lunn.ch> <CAFcVEC+bw6TMykW46z2MXOdx7yhWEO7SZ4AoYM27rBCzD1b15w@mail.gmail.com>
In-Reply-To: <CAFcVEC+bw6TMykW46z2MXOdx7yhWEO7SZ4AoYM27rBCzD1b15w@mail.gmail.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Mon, 11 Mar 2019 17:57:03 +0530
Message-ID: <CAFcVECK8=6WMi4uDU-HBxzPxUwU=rRXM385wUup_fd9bHQvwwQ@mail.gmail.com>
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
On Mon, Mar 11, 2019 at 11:34 AM Harini Katakam <harinik@xilinx.com> wrote:
>
> Hi Andrew,
> On Sat, Mar 9, 2019 at 9:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Related to this, I have a query on how the DT node for gmii2rgmii should look.
> > > One of the users of gmii2rgmii is Cadence macb driver. In Xilinx tree, we use
> > > this piece of code to register this mdiobus:
> > > + mdio_np = of_get_child_by_name(np, "mdio");
> > > + if (mdio_np) {
> > > + of_node_put(mdio_np);
> > > + err = of_mdiobus_register(bp->mii_bus, mdio_np);
> > > + if (err)
> > > + goto err_out_unregister_bus;
> > >
> > > And the DT node looks like this:
> > > ethernet {
> > >     phy-mode = "gmii";
> > >     phy-handle = <&extphy>;
> > >
> > >     mdio {
> > >         extphy {
> > >             reg = <x>;
> > >         };
> > >         gmii_to_rgmii{
> > >             compatible = "xlnx,gmii-to-rgmii-1.0";
> > >             phy-handle = <&extphy>;
> > >             reg = <x>;
> > >         };
> > >     };
> > > };
> >
> > Hi Harini
> >
> > You have this setup:
> >
> > MAC <==> GMII2RGMII <==> RGMII_PHY
> >
> > So you want the MAC phy-handle to point to the gmii_to_rgmii 'PHY'.
> >
> > Feel free to submit a patch extending
> > Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt to include
> > a MAC node, etc.
>
> Thank you, will do the same.

Thanks again for your input. So, I did some testing with this change.
But the issue is that, if I point the phy-handle to gmi2rgmii,
of_phy_connect will be called from the MAC and it will fail because gmii2rgmii
is not a PHY driver and it does not have a standard PHY register set or ID.
Which goes back to the discussion above whether this needs to changed in the IP.

But right now, it is a bridge device on the MDIO bus and has no PHY
functionality.
Moreover, any MAC is capable of accessing the external PHY with no interference
in the MDIO path (the gmii2rgmii bridge just acts like another device
on a common bus).

What Michal suggested below in uboot is that they register gmii2rgmii
with a dummy
PHY ID and then attach the external phy driver in its probe. I'm not
sure if this will work
in linux i.e. calling phy_connect_direct inside the gmii2rgmii probe.

Regards,
Harini
