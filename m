Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FA8214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N4f9rcB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438078AbfIXH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:29:52 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:61206
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfIXH3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH2lO+vRf9HLaBHGwQRBWne/DKcVRFD4p4fy/wBDOZRhy98nuUXvSCyMZsi47OyFZ+9LgN/sKQiGaTdIJkhN9yioBhCuj25rhJTMbE/ruwOKcmm+QFSvSu5H0eLf0kxdVGnbz5isdnQsnaxbwnqHEWLFBU1LGdNfMjnZEC0J5lQMDGWmxwaQc/0RhJB/9csaznZVCe0TIVY2+H5Ix08u8fZK2fCNHASqMEjbPXRn1CJtHN9LOO2GvTCm5mof5AL97piPR9uvjko/Whlh9nS0lBwYfv8GwauyVAAm03PFG1imRz+Yj8AA6SLhFf0By2WG2mhELpKIjFYRKW//vQCjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3b9upYoTaeUk9bsGSP+/UDu6EB3kCExUqD9fW7lnK4=;
 b=FMy9irviXLfNQBQMfUpaMRk9UwHK1NNtiYEGCmlaKV1z1lKe6oGT9z0S6d25LcOK74jrNafoiEtQvEPl9T4/vDA1W5KGLT6/cPzL6g2/7AEGKHL2hxwmKhvVGhcuqsH/KFNNXLqx8zXLVQrpDgrfxF2K0ufO0JijU325igvTYFbXsFdkq/A8m1vL4uHi9Tal0+dfCJTQz0mwy7j5it/gGz0ybKbUrJqoNOyon7j21aj+nD4o2y2mQ4aQuiv9H66o6oL/PtkLpZSmUZTymfyCIFNa60ckbPTSPFjJW8TbKNhecIgf72UH7Fam3OD7qGNBskrAIflGy8FN7NO/kk3cDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3b9upYoTaeUk9bsGSP+/UDu6EB3kCExUqD9fW7lnK4=;
 b=N4f9rcB06BWE+q6T3XyLRAro8Qzsb5w24Dx0Rx0bWylJSSjtBFB6G3HAlawxCKuwl6k2afJawhY4Il6m8dJP0Mwe5jqrC01zFxhUb4YZeOXRZSIBmckO1523b6fVEPmsRlBE01pd90jZRHlyU2uG5BbdhKauD+A5SyOG5JLzul0=
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) by
 VI1PR04MB5584.eurprd04.prod.outlook.com (20.178.123.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 07:29:46 +0000
Received: from VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485]) by VI1PR04MB6237.eurprd04.prod.outlook.com
 ([fe80::c887:7d43:1e17:9485%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:29:46 +0000
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
Thread-Topic: Re: [PATCH 5/5] arm64: dts: imx8mq: add DCSS node
Thread-Index: AQHVcqnXLHpdfPMJ/UmLEZxa2CZIFQ==
Date:   Tue, 24 Sep 2019 07:29:46 +0000
Message-ID: <20190924072945.GB25260@fsr-ub1664-121>
References: <1569248002-2485-1-git-send-email-laurentiu.palcu@nxp.com>
 <1569248002-2485-6-git-send-email-laurentiu.palcu@nxp.com>
 <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com>
In-Reply-To: <CAOMZO5AOVfBpz2Azh65iT_W3CBZUxf9KnqA=kdow7XWd4j--Qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18ff87f7-0649-42f5-5001-08d740c0f9c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5584;
x-ms-traffictypediagnostic: VI1PR04MB5584:|VI1PR04MB5584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB55843BEFE0AAA0FE43120154FF840@VI1PR04MB5584.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(6486002)(7736002)(14454004)(316002)(186003)(102836004)(81166006)(6506007)(53546011)(6246003)(446003)(6916009)(76176011)(6512007)(229853002)(33716001)(4744005)(2906002)(26005)(25786009)(8676002)(44832011)(6436002)(81156014)(4326008)(3846002)(478600001)(256004)(305945005)(1076003)(71190400001)(9686003)(11346002)(86362001)(71200400001)(476003)(33656002)(5660300002)(6116002)(54906003)(66066001)(99286004)(76116006)(91956017)(66476007)(66946007)(66446008)(1411001)(486006)(64756008)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5584;H:VI1PR04MB6237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WH6U6Wo+lynr4JlIn0L5LgmhS/vPxssRsb9jLr5zZv1Ry40NPPwAAJyhU3AZ0mc2wvdv4b8ZIdJrSrX7LVKCYJc8Gg19S5ZuSagmqW9UInum1MWUMmlnKYwqRp4dl52SYwQblRyU9GYHH9LM85NlbS+VTELJIgMl4JzdYQRVCYRVyQB9wfpuz5FLHiWHiEo5A0JyiTsipcdKgEqKNqMlPXKlDftCAtO/GlF32KS4lcRYqS2g6jsE/n2LENCJ2szrfzuG5vGJwnW3NzbDTXGCuwUrMG1EfSteVlIUMgGNe2EgIi0rGGbHGlkEF3E6DIas4+BQP8ybNgK+89lBPPfmyDbv9cAhdxDd7RSxv4b+Wmwtnw4/ySaUhq2YYQweBKhT+QXunfzuZ0dfOs+QkST85l67vP9i3zWnUlaigVvyaag=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A2FB6DA96285D2448B3353184E71BB06@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff87f7-0649-42f5-5001-08d740c0f9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:29:46.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX5NSESuUOOKUk9WupBHLBwXTXJBK/1dKWQdX/Wjr57Lp9V6ovZR8A4lu5Cy93hN7gzXScSIfINAmq0XtDMczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Mon, Sep 23, 2019 at 01:12:42PM -0300, Fabio Estevam wrote:
> Hi Laurentiu,
>=20
> On Mon, Sep 23, 2019 at 11:14 AM Laurentiu Palcu
> <laurentiu.palcu@nxp.com> wrote:
>=20
> > +
> > +                       dcss: dcss@0x32e00000 {
>=20
> Node names should be generic, so:
>=20
> dcss: display-controller@32e00000

fair enough, done.

>=20
> > +                               #address-cells =3D <1>;
> > +                               #size-cells =3D <0>;
> > +                               compatible =3D "nxp,imx8mq-dcss";
> > +                               reg =3D <0x32e00000 0x2D000>, <0x32e2f0=
00 0x1000>;
>=20
> 0x2d000 for consistency.

will change this as well.

Thanks,
laurentiu


>=20
> > +                               interrupts =3D <6>, <8>, <9>;
>=20
> The interrupts are passed in the <GIC_SPI xxx IRQ_TYPE_LEVEL_HIGH> format=
.=
