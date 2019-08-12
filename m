Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5E720820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDlrxKQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfHLVAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:00:11 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:16650
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbfHLVAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfSFNc5Rbf9fz0Z23mBx03hDJDkLg0TbCgZvwLDRScGwfcriIObBq+u6yoW8T9OG0jQVclBuYqE7wMoDfPJOKvVn46Rmwuzo1jQJwje/lyVRZ5Zu7brf/K95ASnn/uTvmpVRQCYZLupe1i032VjDKDj/17FK8m/YD1VRqsyu8eRlfYvClXz23aqQZVJpNYJweyKX8SDkrYFUO6DN9p1Ob5x8h4kr3W0oKbx59wHuG8cd+5xICFDRHjcQxcF1iuoLob+e3+Wk5Sc+4Z1rJz2GfR3cBZ8l4+14Nhui9t1Gcn5Br65flpvLCkXOFcB+TQyeM3f3p70PPg3Cs0p8TCVAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ueLC5WdPKDO4ejphAo0fTxLqSnGHuSttB5HNb4rsNU=;
 b=b3LMMhEIyPfkS41z96elvBp9dNIPZpzrmQr/x8EylEPNvOS88AACz/QBh/DwQ8wdgpnOGJAd95rTZJsXs7YBUws6s9u6ahFJdbwcJYkl26X2URVvvy5I/jD5elLNdZLagKk0jJk5mQvC0LF3BgMlXRO3R9TyfGFCb4+meEFHUHURx+OhRrgm2uFTJ9xR4wLChgb0fBIUvFyQo5NEKEDoAd9EBiGbo4MiWxp6bc480bAFVYi3RQLTzV7owYKcBTFEdB5mcICD9YYeiYzOhjV/xoQzxdpSdhPl1smFGeW5rmZ+xB394pTY7NOWT1RMk5IdOz4wCxdrR+gXJkNe6VQa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ueLC5WdPKDO4ejphAo0fTxLqSnGHuSttB5HNb4rsNU=;
 b=WDlrxKQPCqzM35+PCfeI/YeWFBtQTCJoYMoRcNlv6bYJiswW8q7ZCoz2i2G2kU5ab/aXTiLK9g6mBVeDvPPgqookkiB78SM2po7miIC6MpEXstOkypcb4q5Vd+5Kq3q27Buc3H6+Evz+sKz8m+ZhHWENM0yPfzVGzwAs6/ei9Jo=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.235.152) by
 VE1PR04MB6365.eurprd04.prod.outlook.com (10.255.118.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 12 Aug 2019 20:59:24 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::3d61:6e52:a83c:7c59]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::3d61:6e52:a83c:7c59%6]) with mapi id 15.20.2136.018; Mon, 12 Aug 2019
 20:59:24 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Chuanhua Han <chuanhua.han@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] arm64: dts: ls1088a: Fix incorrect I2C clock divider
Thread-Topic: [PATCH 1/4] arm64: dts: ls1088a: Fix incorrect I2C clock divider
Thread-Index: AQHVTDQ4Ae8WN9+9zkCguoEFMcJTHKb3mOoAgABwPWA=
Date:   Mon, 12 Aug 2019 20:59:24 +0000
Message-ID: <VE1PR04MB66871BA9508765C03449E2598FD30@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190806084223.23543-1-chuanhua.han@nxp.com>
 <20190812141722.GJ27041@X250>
In-Reply-To: <20190812141722.GJ27041@X250>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec6a755-dead-46ed-e885-08d71f67f50d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6365;
x-ms-traffictypediagnostic: VE1PR04MB6365:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6365BD6B5C115B8E49785C208FD30@VE1PR04MB6365.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(13464003)(33656002)(81156014)(55016002)(86362001)(71190400001)(7696005)(6506007)(7736002)(9686003)(53936002)(6436002)(186003)(102836004)(52536014)(74316002)(476003)(53546011)(486006)(6246003)(8676002)(76176011)(25786009)(316002)(229853002)(110136005)(26005)(5660300002)(305945005)(4326008)(99286004)(446003)(6636002)(11346002)(54906003)(3846002)(6116002)(64756008)(71200400001)(66446008)(14454004)(14444005)(66066001)(66946007)(478600001)(76116006)(8936002)(66476007)(256004)(66556008)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6365;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wGZ+/bBOzNvwQBWUBrjFqhlIVrzmvnawTXatTZPvRBI4H+1QNhapFsAL9YYiK3eioL10OR+z3eb2vGN6uV8vvJzGO/PclXxBUaCqdcKtFTeVCQ1wvmDsfLpxbKXyrSwtS4XmY/P2lakbWvWmrY8jkuCbTgLQuJsEj34lHU9YDCHbwByp0v8AIukOCTSe//uCobi+wDt9IgjJdFjI1iEZeKtVqvfGZ9JffGldMKmqkPt4rwZ9tkhkTlJeaJSQed55jVoOJahgaBWdxEl9oHNmolr0DhNrO7aH0SHr95nJC2Fys6hFcN3F0hhKB5qi1HJv5jiTjsVktJ/bejqH6PFirbpZxWo0FQAZpQ6BkXdcOrBMPwE/rEC3d9f+GLlrabiiOBXMJhoCNYE33yASzOcrNwMBWoheK5Oc0LQF/VvEXtY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec6a755-dead-46ed-e885-08d71f67f50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 20:59:24.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, August 12, 2019 9:17 AM
> To: Chuanhua Han <chuanhua.han@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] arm64: dts: ls1088a: Fix incorrect I2C clock div=
ider
>=20
> On Tue, Aug 06, 2019 at 04:42:20PM +0800, Chuanhua Han wrote:
> > Ls1088a platform, the i2c input clock is actually platform pll CLK / 8
> > (this is the hardware connection), other clock divider can not get the
> > correct i2c clock, resulting in the output of SCL pin clock is not
> > accurate.
> >
> > Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
>=20
> @Leo, looks good?

Yes.

Acked-by: Li Yang <leoyang.li@nxp.com>

>=20
> Shawn
>=20
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > index 20f5ebd..30b760e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -324,7 +324,7 @@
> >  			#size-cells =3D <0>;
> >  			reg =3D <0x0 0x2000000 0x0 0x10000>;
> >  			interrupts =3D <0 34 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks =3D <&clockgen 4 3>;
> > +			clocks =3D <&clockgen 4 7>;
> >  			status =3D "disabled";
> >  		};
> >
> > @@ -334,7 +334,7 @@
> >  			#size-cells =3D <0>;
> >  			reg =3D <0x0 0x2010000 0x0 0x10000>;
> >  			interrupts =3D <0 34 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks =3D <&clockgen 4 3>;
> > +			clocks =3D <&clockgen 4 7>;
> >  			status =3D "disabled";
> >  		};
> >
> > @@ -344,7 +344,7 @@
> >  			#size-cells =3D <0>;
> >  			reg =3D <0x0 0x2020000 0x0 0x10000>;
> >  			interrupts =3D <0 35 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks =3D <&clockgen 4 3>;
> > +			clocks =3D <&clockgen 4 7>;
> >  			status =3D "disabled";
> >  		};
> >
> > @@ -354,7 +354,7 @@
> >  			#size-cells =3D <0>;
> >  			reg =3D <0x0 0x2030000 0x0 0x10000>;
> >  			interrupts =3D <0 35 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks =3D <&clockgen 4 3>;
> > +			clocks =3D <&clockgen 4 7>;
> >  			status =3D "disabled";
> >  		};
> >
> > --
> > 2.9.5
> >
