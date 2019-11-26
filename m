Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA2C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670932071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 06:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qz5Muqb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfKZGkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 01:40:39 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:13379
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfKZGkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 01:40:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU/gZ9wxJQL38NNdV/OSPSYi0Z2RQQvIscQ5Sj/DnfIK2sq3l+dCh3rW4U8xKeqXYxQGieCP+V5VCcX9GRL8oeHaZ4E4hubQbpm7luBEnNSUZz9V1jhQHAavSmEbY3R032yVMLF/PyxVmpKLFBeOcDqndwZP2bT12BY1UeiHXRjz5FJEKW4Vj9VWTnsLuF5Z+JMePsQsw1ghB+o1BmKkPuaY9fFSP0FegKeXID1CHVsUr0EE+9fmbhuoFDMPnQAAZ8G+X/3RnpNJDve9Lfx4G1PIt7u3NQMSWRRho0SJhCPmuC0lLxKu7cC2OlpjcClWQu00I1fVLPwwjWwoSf2meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52rtOMTt2c/ADnIHWHA2V9HzE4XC4KC1ODKDDBSQWj0=;
 b=FvXvnFhbIXf1rckQx4C27zwFA0H55pe6IaefqE569QC7tJTAZPSRh/EoiSFbyJDZUr0/auFCrZzek0r91jOcl+4G9sKgP3VN0ILZsrwXgvCrptEdq4slOn5np4U8Hrg/4P0Jvv8U4jKIb0B7k8MpFBjeP5L21nWCs7xCmuz3TlrwwT4aIwGGnzVJNPLiu81TjLcJ4JAaKIYsOh/RUe6uiNv7IM/Pj9aGAEVMR4WjWXoGEldCimd/6+05H7/oubd18coXN914KzKKQEluBX2X8RY2NKc7X24vTSadD6Vs7KB3tBRZo0Y+KAy5AWhv89NjehBCEMqSpDuL5gORYMVmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52rtOMTt2c/ADnIHWHA2V9HzE4XC4KC1ODKDDBSQWj0=;
 b=qz5Muqb6cuG5g5aGRVcr80p/8liGqOy3N1Myrv/9n6IJ5veo8hh+y7xuZ7clpGnmFXF6KkzElYNxp29ke7b7HLjl8u4MzBvj4nON7fAqLxkmI4SKMYvhdHGeQqJ4DA9JrF23gQsfYiOJHH7hKdrgxUMbM3gkDL0jQPG7axixfQA=
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com (52.133.43.147) by
 AM0PR0402MB3572.eurprd04.prod.outlook.com (52.133.49.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 06:40:35 +0000
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::e885:ac97:fca8:c4e]) by AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::e885:ac97:fca8:c4e%3]) with mapi id 15.20.2495.014; Tue, 26 Nov 2019
 06:40:35 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
Thread-Topic: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
Thread-Index: AQHVojp/XO5z0jeXk0+aNgRvimpOIKedAjsw
Date:   Tue, 26 Nov 2019 06:40:35 +0000
Message-ID: <AM0PR0402MB3556804FB47D182173C6A7AAE0450@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-4-michael@walle.cc>
In-Reply-To: <20191123201317.25861-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a78e5f2-cd68-42e5-19b4-08d7723b8ae8
x-ms-traffictypediagnostic: AM0PR0402MB3572:|AM0PR0402MB3572:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3572F3C370FE82794A5AFAFEE0450@AM0PR0402MB3572.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(13464003)(189003)(199004)(76116006)(66556008)(66476007)(66946007)(64756008)(66446008)(52536014)(5660300002)(229853002)(6506007)(81156014)(8676002)(81166006)(6436002)(11346002)(2201001)(53546011)(44832011)(446003)(7696005)(74316002)(71200400001)(55016002)(4326008)(6116002)(99286004)(14454004)(186003)(33656002)(102836004)(14444005)(8936002)(256004)(2501003)(305945005)(76176011)(6306002)(316002)(966005)(3846002)(25786009)(54906003)(26005)(7736002)(2906002)(9686003)(110136005)(478600001)(6246003)(86362001)(71190400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3572;H:AM0PR0402MB3556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8T5SxB0zouHsUyMMcG1hZjNgyrxcpXIBKNOqYVdbjAiZJ9f3yGn3Thsbuu7i+HTT8hQDHAdpXm2UtBPtBu8cfin8BppFot/PHFlhcdnYsrC1b30+F7LT4AdWncbMtG/O0XRzn17x3IhkvWLJQ4Lcpb+2FvFekCY1f8TApO7RBeHsde3OpmhNjO+Bt+ftGUcAuuKJIn/DHune+PiEwvcz313JXHlgf4QcGmsXjB7Kw/low+R4UtIVr3KgDDw1aJT5t40z+z6VbQ3COsaT9iVjkGbncBXrNs2HFcVZEB0b3DAQGkNEo0CAkCoUl9+xW7JAbwNSBcrT487lQ9kssMUmDcbGpcJu4U+mE6II3C1eLtsOe8qKwg2NTi+VRlNva2v82RDOAIrXfAIzMOQyX+eAmFP0x21PwSnuwolAfB2JFgRceDmpKBQ5jjeQdtNIfBb/0pe7Fy60fQb2GHBftQLyx163JVhNLycLfQnxyTGplA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a78e5f2-cd68-42e5-19b4-08d7723b8ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 06:40:35.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZboRJDuOpG3N6HjkZ1RVHq3/Jk6/TzS5onn5bAPYQsnYiLvqYsfc8QHyFrvy00wIic8Xi2AzqTs4i2zgVVEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3572
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: devicetree-owner@vger.kernel.org <devicetree-owner@vger.kernel.org>
> On Behalf Of Michael Walle
> Sent: Sunday, November 24, 2019 1:43 AM
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Michael Walle <michael@walle.cc>
> Subject: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node

There's already a patch[1] sent upstream and is under review.
It includes dts(i) entries for LS1028. I will be sending the next version

[1] https://patchwork.kernel.org/patch/11139365/
>=20
> Caution: EXT Email
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 6730922c2d47..650b277ddd66 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -260,6 +260,19 @@
>                         status =3D "disabled";
>                 };
>=20
> +               fspi: spi@20c0000 {
> +                       compatible =3D "nxp,lx2160a-fspi";
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       reg =3D <0x0 0x20c0000 0x0 0x10000>,
> +                             <0x0 0x20000000 0x0 0x10000000>;
> +                       reg-names =3D "fspi_base", "fspi_mmap";
> +                       interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> +                       clock-names =3D "fspi_en", "fspi";
> +                       status =3D "disabled";
> +               };
> +
>                 esdhc: mmc@2140000 {
>                         compatible =3D "fsl,ls1028a-esdhc", "fsl,esdhc";
>                         reg =3D <0x0 0x2140000 0x0 0x10000>;
> --
> 2.20.1

Regards
Kuldeep

