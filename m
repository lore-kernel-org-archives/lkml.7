Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A612080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3gty6y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfJaS74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:59:56 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:12941
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbfJaS74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK3zVpYD9idLJsK3ZaVezV+LWZRALT9cSwAFolZIBpwZzKThtkiGNVLKBBZiiSDhl6zs9P49Bv9jxz6D1i5Q+pLrjIDC6Ec9mPPaoB5q4uEQt16Mx/3tjiCQ533S4HE5uFtEZe7Gz/bXbmFtJF/HEufbNzyYszWzprgC1WLhLLKMOf3qYvopUzlLpcL4o8rOQ55PREi98vFD6rN+rVGmxJTqIUGJTUWgdIE6BsMbmxLXMXC4TKi+kqZsFvxVxiuRKZWvfZuXLa0tQMcrqQYtVurxzP0V1n0hfVIoexfHXsPdjf7OWFxJyPzzaFiHnBviP28awPHyKW1yzzyykAmBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMLu3E8kxrU9QotbLYp1xVEQD1NbeopbsrfdAFANlA=;
 b=kqoWbJbdIkm6kZMRjCol147lBraFaemNh9YyYn6nAsLPxMk/Z35L3zyK1j7kMfboEDZUPJni81M7qksQ1su+tQ1E5ZFdfLtrm+f8d/MJ/iZj6BPxjx4fi9mCvPt0vvI4tHgr2/DWSRIGBpzQnS5cgtz7a30m5xuW2TujQ9v/S2IUXKNzXVBB/pqhd7UKXNT42a+IheEE39YLjau6jwKZ/Hfz6Bp5V0m6J5bIXWTu4gYt8Gubc+A8cg+7CkMsJQVvP2/jNSBA/dmmVZQi11Emii56MbEccpQWld740mcKSgqHV4XTM8f5cvACLgbSKG1lGwkRRyXDXmGUIvDuD4hM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AMLu3E8kxrU9QotbLYp1xVEQD1NbeopbsrfdAFANlA=;
 b=M3gty6y7ujEcFty170GriH6HyGEOkEcC7czWHdGJV7nzWJ1hVk29hb0avcvR5lIYdSFqz8lic/aHo5jMZQ6STCYcW+KUj1vRypDTHsfWk39d/4Fc+1pMwyk5vRAXh18bXo1VKOSmRpyC5yPxyS02RWX/K4ir9aYiE1IAcl6l+Pw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5038.eurprd04.prod.outlook.com (20.177.51.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Thu, 31 Oct 2019 18:59:51 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 18:59:51 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Thread-Topic: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Thread-Index: AQHVh/j+k1XoWkwF8kWzRGGsNvXoFQ==
Date:   Thu, 31 Oct 2019 18:59:51 +0000
Message-ID: <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b70f40ea-6da6-452e-1dd8-08d75e348262
x-ms-traffictypediagnostic: VI1PR04MB5038:|VI1PR04MB5038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB503832DA64F49051CBAB4DA2EE630@VI1PR04MB5038.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(26005)(86362001)(99286004)(6116002)(305945005)(6506007)(66066001)(186003)(14454004)(256004)(2501003)(4326008)(7696005)(102836004)(2906002)(110136005)(54906003)(3846002)(53546011)(74316002)(7736002)(316002)(76176011)(8676002)(478600001)(91956017)(66946007)(6436002)(6246003)(64756008)(44832011)(81166006)(52536014)(33656002)(76116006)(486006)(446003)(71200400001)(81156014)(66476007)(9686003)(476003)(66446008)(8936002)(55016002)(66556008)(25786009)(71190400001)(229853002)(5660300002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5038;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cI1E9xjhXUhTimmnhaTzTugMCOV6CreyZENQM7UEjcQPv9bM4ia19l8QHvtCBbpeEFlktzM60g3TjNCoQogMGEvsc/pmlNMJzkeU+vc6cPttrdBsmi+0YFEGKfWABqLLc7sAF7OloKClVUg3RmmUbGutwecfDd+BYM2118tcZ3brUBPgdT3y0nZuth/HvIZcSf/sWx5jEJNj8af4TwbrmklHiWEL1qbu2VePDzy1gvpdf6CGz70e2gz0cVmwGZXUaFIPX+fkvAyRUxKXz28JmpEHNWPUhA+p3RrgL2Ia89acIIxJtd4PFMlH2TXp/vW4VHaIJk9YeP5cNaKnZEtMcSU2hT5VtrgK49K5ASrWVx5x8MdgVLTz/+dj3cePVad0R2Iw/RDO9u8jNDj8S2mGF1jGxXkqPMMUtN4uiEzTfj5GqLwdIq0cpIIHTyZBLY2+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70f40ea-6da6-452e-1dd8-08d75e348262
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 18:59:51.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gzy1hvxwGphpPab87wVwFJKvQZIa0R8mRyR47HU12I9+2I8Gmfm2dhAj+o8Polr38mdUZNVP9jR4Yf/7D1QojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.2019 13:19, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> We should not rely on bootloader to configure the phy reset.=0A=
> So introduce phy-reset-gpios property to let Linux handle phy reset=0A=
> itself.=0A=
> =0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>=0A=
=0A=
This broke NFS boot for me in next-20191031: board now hangs on DHCP.=0A=
=0A=
It can be fixed by reverting this DT patch or by setting =0A=
CONFIG_AT803X_PHY to y instead of m.=0A=
=0A=
Needing a phy module is not a bug but everybody will need to either =0A=
adjust .config or build modules into an initramfs somehow.=0A=
=0A=
> ---=0A=
> =0A=
> V2:=0A=
>   U-Boot->bootloader=0A=
>   Add R-b tag=0A=
> =0A=
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mm-evk.dts=0A=
> index faefb7182af1..e4d66f7db09d 100644=0A=
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts=0A=
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts=0A=
> @@ -80,6 +80,7 @@=0A=
>   	pinctrl-0 =3D <&pinctrl_fec1>;=0A=
>   	phy-mode =3D "rgmii-id";=0A=
>   	phy-handle =3D <&ethphy0>;=0A=
> +	phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;=0A=
>   	fsl,magic-packet;=0A=
>   	status =3D "okay";=0A=
