Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07929214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M28sCG1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409281AbfIXHZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:25:08 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:2725
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409259AbfIXHZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:25:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfpWthGz9LHJVxpLQFJBxWzcjrEetGhoCi6Bshp6jm54Xgg8Vh4UFmFiubSuAVrnYGYe6JTZPLaroANePiQftSjzmOiVXHO53QElmELhi+C2SJc/pw2G2QjyBKOD3bmwgWk5Ygg51rMTd50S5S+SnIqmVyR2LgDgkMNegWI9M+l0J3X66pQDZZrwoHikpdDveoMYwu3zsH2R8JgzS5Q4Ada+nXP7BO5grT+vwT0q8VbKgs0tX2/tL8yFp1iA1LWnJcKRBfDM2mvE+6zJ6x6XZ5Akqt6oVXRUPJhLjP5zJp9U45tGh6ILabmI0lXyFUpaBlBunJ3vl7R2IzWvJ8pafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XaxqetdDA1u8gAxKT+vQr0+1C8ZdfLqHJ+tQ8kP8M0=;
 b=Wj+Lz6PUZ14yZHwUzX0lqMftv0p/pDylKGLET4ZX4alDEAiVHWAt34/J9vWiBymTbWCbyKmAbwdDxLFrcr4Uudp0sQMTJOQJDLqj7IkqyN/n0HdxCkGEsNnfw4KmQYzL+lm+vii/NeIJoTXBIlYuMPSYaJKBlTxezazG09wCJyB9W143RGVwhoHQXd5WDE8IhLejcK8XNI8YaHcwfIbSvXjMky1vlIYvxU1djbc9EXc8mZqMVLYbX14ug+6/g987LPsOtvpL9w6WXniXaoX8nf7hahJSOqHWJ6XZcKUEfRcNvetMslnboBSfGTamH3nc3THbwafYRnWvebovFAEDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XaxqetdDA1u8gAxKT+vQr0+1C8ZdfLqHJ+tQ8kP8M0=;
 b=M28sCG1E/xx2GZYPPv13FueypTygATkySXD2dBFJaZLQ/ttsomdnwxPf3qb7lJj+xY+pp/UBXN7cqylwXk/Z49QbgbjlWJO2HHs8B/a0aIe4H9c151uJ+kHBAl1GFL/J5oPjXId8jT01LMcOYn0E3anIuEEepSXWNuPnE1LigDA=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB5646.eurprd04.prod.outlook.com (20.178.125.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 24 Sep 2019 07:25:03 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:25:03 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
Thread-Topic: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
Thread-Index: AQHVcqkuc39bD9SAI06v4H3kwoWIqQ==
Date:   Tue, 24 Sep 2019 07:25:03 +0000
Message-ID: <20190924072502.GA25260@fsr-ub1664-121>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
 <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
 <20190923165443.D1B1C20882@mail.kernel.org>
In-Reply-To: <20190923165443.D1B1C20882@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 822ece76-1c0a-49e0-bdcc-08d740c05136
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5646;
x-ms-traffictypediagnostic: VI1PR04MB5646:|VI1PR04MB5646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5646EC52DCB07DD55048F36DFF840@VI1PR04MB5646.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(71200400001)(71190400001)(76176011)(486006)(7416002)(5660300002)(6436002)(6486002)(229853002)(7736002)(6506007)(14454004)(476003)(81156014)(81166006)(8676002)(66556008)(66476007)(446003)(26005)(102836004)(186003)(478600001)(76116006)(91956017)(8936002)(66446008)(66946007)(64756008)(99286004)(11346002)(3846002)(6116002)(1076003)(316002)(33716001)(54906003)(44832011)(2906002)(6916009)(6246003)(14444005)(256004)(33656002)(86362001)(4326008)(66066001)(305945005)(9686003)(6512007)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5646;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +EQaK+HjhSDfoA2Yg2TIqfJXglMloBbPVFfaNAB7WosrknJ7mK7XCYmyhWmYytogcesgMYcDd8iEH8vOi/dbPkIVYWq1VUaPSHWUIjSxXn3GrtZy6C9mrZ8CYjFTJwX3XCc3sJUYXX20wJCMWSvn9VFIFrtQbuQQW3kcnoKrf+ZPqIcrPDXdtC5XER4+KzilJ2lOPy89qs7SRZFVtBdc5Eax0HUwVEoi50MMH1r6Q/yUcsDU2c8zt2UCXmEtRaxXdCNYONMqMtYTEnyPnm0MPYAEhgB50kACg2CVTbdSOvvHAts7SjH2o3n2xSePUH9GTbiy9IQGOGiQ2P75duAP3aT6KqF660xxbvCBy5XQxA9jbR2PV5Vg4cJAlvmkcMro8oEqTktFiNGRKuYuLExfdKQbKYCkElujrCzufqHn07g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AB49DD3028DE1488B72B757DD762F4E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822ece76-1c0a-49e0-bdcc-08d740c05136
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:25:03.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOnZya90RIO3YzUmPkTFbvnN5gPClkiJvht6/TYsXk8fhBr6dDCOfz6yj+O7XJ8x5gwMRe37AGTMl1VgoJ43Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 09:54:42AM -0700, Stephen Boyd wrote:
> Quoting Laurentiu Palcu (2019-09-23 07:13:19)
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mq.dtsi
> > index 52aae34..d4aa778 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -871,6 +871,31 @@
> >                                 interrupt-controller;
> >                                 #interrupt-cells =3D <1>;
> >                         };
> > +
> > +                       dcss: dcss@0x32e00000 {
>=20
> Drop the 0x prefix on node names.

Thanks, will do.
laurentiu

>=20
> > +                               #address-cells =3D <1>;
> > +                               #size-cells =3D <0>;
> > +                               compatible =3D "nxp,imx8mq-dcss";
> > +                               reg =3D <0x32e00000 0x2D000>, <0x32e2f0=
00 0x1000>;
> > +                               interrupts =3D <6>, <8>, <9>;
> > +                               interrupt-names =3D "ctx_ld", "ctxld_ki=
ck", "vblank";
> > +                               interrupt-parent =3D <&irqsteer>;
> > +                               clocks =3D <&clk IMX8MQ_CLK_DISP_APB_RO=
OT>,
> > +                                        <&clk IMX8MQ_CLK_DISP_AXI_ROOT=
>,
> > +                                        <&clk IMX8MQ_CLK_DISP_RTRM_ROO=
T>,
> > +                                        <&clk IMX8MQ_VIDEO2_PLL_OUT>,
> > +                                        <&clk IMX8MQ_CLK_DISP_DTRC>;
> > +                               clock-names =3D "apb", "axi", "rtrm", "=
pix", "dtrc";
> > +                               assigned-clocks =3D <&clk IMX8MQ_CLK_DI=
SP_AXI>,
> > +                                                 <&clk IMX8MQ_CLK_DISP=
_RTRM>,
> > +                                                 <&clk IMX8MQ_VIDEO2_P=
LL1_REF_SEL>;
> > +                               assigned-clock-parents =3D <&clk IMX8MQ=
_SYS1_PLL_800M>,
> > +                                                        <&clk IMX8MQ_S=
YS1_PLL_800M>,
> > +                                                        <&clk IMX8MQ_C=
LK_27M>;
> > +                               assigned-clock-rates =3D <800000000>,
> > +                                                          <400000000>;
> > +                               status =3D "disabled";
> > +                       };
> =
