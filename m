Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FEA2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Pyjzk4yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfCALxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:53:32 -0500
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:25136
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727199AbfCALxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtW2pSprzLfKngYAEP8oC0fzzZA0nK75SXz9zE7rz+w=;
 b=Pyjzk4ycX3GXCU0/XrPeb/aypKMQTtYRvCAz/OaHgGbA7T+Tg6pgdeqWXid9tYC19TC1g/WBUvv7kVrZ091c2X2m/DuQ11qAen0bjU3LP6Fn+2c/nalUBWxSFi71ykYN+BWW00wVvbvLchO6lq0dhbEIrd97osHBj/biCCsa4IM=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1504.jpnprd01.prod.outlook.com (52.133.166.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 11:52:42 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 11:52:42 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Thread-Topic: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Thread-Index: AQHUrcrIDedHLsiSw0SUu7/Qdvj7uKX27qSA
Date:   Fri, 1 Mar 2019 11:52:42 +0000
Message-ID: <TYXPR01MB17755AA9CC7835B236626F42C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7bf303-4453-4f2c-8ed0-08d69e3c69aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1504;
x-ms-traffictypediagnostic: TYXPR01MB1504:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1504;20:jg2zpeK3A90SktX6rB9mbpwvAHqQX67o8/aTVLPXH6/ixJqqIRMkeNOO/CEHTwaKRUr3MEqTV4G0Ylfj+YMnW4y7Azjl0fQPnU3cn87Bea+mla/Dii4dq76VvSgvlK03r/XKf3U96UiLIiuxUjAwczoT3CH4J8Oe/kzKJs0aoZI=
x-microsoft-antispam-prvs: <TYXPR01MB15040199734B873C97911FD5C0760@TYXPR01MB1504.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(33656002)(71190400001)(7696005)(71200400001)(66066001)(105586002)(54906003)(7416002)(99286004)(97736004)(3846002)(106356001)(6116002)(76176011)(316002)(7736002)(6916009)(55016002)(81166006)(5660300002)(256004)(44832011)(9686003)(53936002)(305945005)(6246003)(25786009)(81156014)(446003)(6506007)(11346002)(26005)(86362001)(53546011)(186003)(486006)(52536013)(4326008)(476003)(229853002)(478600001)(2906002)(6436002)(8676002)(68736007)(8936002)(14454004)(74316002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1504;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U60/k+BCabS1E9mrgUZjrrgoYJXke2ciGSGIWoe71ycwOCgyHTb+2mwWsh/Fgbd2Z2SqyvFME9nKhc6KtxC9E7BBaO6P8xpKNtp3aGeH1r00HtYkxitMps2enbHqeMVKaqVxo4Eo9e7eICPuTCpbiNm1Pd7o/kQbKcgN1iYX2hP2EBOB6qFmbroWx5SRnjEGKx9xSuczmbuf+saw3oocITM2GM+Vn993UHgpwspCA2417OjV4tqkjaEgMAMynvoElicFKPdM9RDDvVfTRePX2Zqwi4u7gtzXasJ72KlTsIh9fR2eVMTiJ29PlNMkuLgn2BxoaTGZChiT2RnzZOEze6LgbcmMectKLmadDBkry5c2chQ0czNGVG6L2mnncA6A7mzZ1SI3Oq7uE/v9hzspnIu4x2ZEtS9ujeAcrsQqONI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7bf303-4453-4f2c-8ed0-08d69e3c69aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:52:42.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 16 January 2019 18:38
> Subject: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
>=20
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3
>=20
> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 7fcf501..b463e12 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -28,13 +28,8 @@ Required properties:
>=20
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> -	  devices.
> -	  phandles and clock specifiers for 3 CAN clock inputs for every other
> -	  SoC.
> -- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> -	       3 clock input name strings for every other SoC: "clkp1", "clkp2"=
,
> -	       "can_clk".
> +- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> +- clock-names: 3 clock input name strings: "clkp1", "clkp2", and "can_cl=
k".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>=20
> @@ -50,8 +45,7 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values =
are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2) (not supported by
> -				    RZ/G2 devices)
> +			    <0x1> : Peripheral clock (clkp2)
>  			    <0x3> : External input clock
>=20
>  Example
> --
> 2.7.4

