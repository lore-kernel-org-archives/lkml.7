Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF65C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8CB21781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK1JLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:11:54 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48048 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfK1JLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:11:53 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 136C42056B;
        Thu, 28 Nov 2019 10:11:52 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E3DF120234;
        Thu, 28 Nov 2019 10:11:51 +0100 (CET)
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?UTF-8?Q?Andr=c3=a9_Draszik?= <git@andred.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
References: <20191127124638.GC5108@optiplex>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1ed54a69-c29f-6008-02ae-11d16f68b265@free.fr>
Date:   Thu, 28 Nov 2019 10:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127124638.GC5108@optiplex>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Nov 28 10:11:52 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2019 13:46, Oliver Graute wrote:

> On 27/11/19, Marc Gonzalez wrote:
>
>> On 26/11/2019 15:54, Oliver Graute wrote:
>>
>>> this patch broke my imx8qm nfs setup. With the generic phy driver my
>>> board is booting fine. But with the AT803X_PHY=y enabled  I'm running
>>> into the following phy issue. So on my side it looks inverse as on
>>> yours. What is the best proposal to fix this?
>>>
>>> [    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
>>> [    5.573206] Sending DHCP requests ...... timed out!
>>> [   95.339702] IP-Config: Retrying forever (NFS root)...
>>> [   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
>>> [   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
>>> [   99.461206] Sending DHCP requests ...... timed out!
>>
>> Which DTS are you using?
> 
> I'am using this DTS which I'am currently working on:
> 
> https://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/689501.html
>>
>> I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.
> 
> So what should I fix in my device tree?

In the board DTS I used to work on, I had this:

&eth0 {
	phy-connection-type = "rgmii-id";
	phy-handle = <&eth0_phy>;
	#address-cells = <1>;
	#size-cells = <0>;

	/* Atheros AR8035 */
	eth0_phy: ethernet-phy@4 {
		compatible = "ethernet-phy-id004d.d072",
			     "ethernet-phy-ieee802.3-c22";
		interrupts = <37 IRQ_TYPE_EDGE_RISING>;
		reg = <4>;
	};
};

In your DTS, you #include "imx8qm.dtsi"
I found no such file:
$ git ls-files | grep imx8qm
drivers/pinctrl/freescale/pinctrl-imx8qm.c
include/dt-bindings/pinctrl/pads-imx8qm.h

In your patch:
https://patchwork.kernel.org/patch/11211567/

+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-txid";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	fsl,rgmii_rxc_dly;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			at803x,eee-disabled;
+			at803x,vddio-1p8v;
+		};
+	};
+};

Try all possible 'phy-mode' (rgmii, rgmii-id, rgmii-rxid, rgmii-txid)
Investigate 'fsl,rgmii_rxc_dly' (it's not a standard Linux DT prop)
Documentation/devicetree/bindings/net/ethernet-controller.yaml

Regards.
