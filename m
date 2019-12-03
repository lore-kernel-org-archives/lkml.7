Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB08C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA93E2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RDSjVnvc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1ZlG/a5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLCGMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:12:35 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:45459
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/4/tFEbP02vmbCIZeySfuXOQ2b8cnuJWPANXDODfOQ=;
 b=RDSjVnvc95bf45aPmf4u8zSW0kTN42AsROgyY6SNat2tL5NaC7wH22GWNYfAbghw+HKGAQwcmvbl5L3uvYGn0M7ormwlCKbB2j4405Bvg4V4LqQ3GOhMWJt5ZmrI7PlYBsOrwuUGvmSa/OHAQ7PV2ZCbY4gYPk45zWXb4qemP6Y=
Received: from VI1PR08CA0166.eurprd08.prod.outlook.com (2603:10a6:800:d1::20)
 by VI1PR0802MB2302.eurprd08.prod.outlook.com (2603:10a6:800:9e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Tue, 3 Dec
 2019 06:12:29 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0166.outlook.office365.com
 (2603:10a6:800:d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Tue, 3 Dec 2019 06:12:29 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 3 Dec 2019 06:12:29 +0000
Received: ("Tessian outbound 691822eda51f:v37"); Tue, 03 Dec 2019 06:12:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d1e07b2fb8c8bca1
X-CR-MTA-TID: 64aa7808
Received: from 49bad07b3426.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A69222EF-AAE1-4701-B770-BD1EF8F22631.1;
        Tue, 03 Dec 2019 06:12:22 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 49bad07b3426.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Dec 2019 06:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZwzbNSGZJgG4xQvdEKsUGrK9GMuytHlrRCEV0E6lPpkjmWFduKHKQMhB19849xN/JWkDlqyihu2Ij7XBITVmsR3yzwAVDW1VUcj+WgFvWr9IKE95NP5ZchCz/25wQXG38DJVh3gJXIuvHV+YqGAOW4YsZ/NmKzVYDUvdWGaMHaVYahdvbhztQmmc1DG+fOqIxDBA/tnsM0SYrn2N2MPkllzdavaWH0NWhZj2RyUqYR2s3vttaLzVR+UaB68psEYdrhsExHRQjLK8YqMqtxFgIFDzPepZYqGhRtZXlo38PcVHK+gV3v3uoR3GYWm1CbEfdizquPumosmdNJUZxwL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imz+nN4XmH+Hb1lDxtBSSmffWSXwdgcVObA1324nDS4=;
 b=czHC61qMQFbMyP7uCq2JsU2jQjTsx9L0Xm5GFAwH+LBy1HKQiL8Pnd3hjOCkAgi1+ioYEIeHvBAX/m6ab3HXRZvIZokiOQ4XBUsZTvc3g/rrVi2q6paHImf5tzs8HFZZJYARf/N2p58NzPQz4czVxslf73KBcye+R5FC1FhhgvR2W03F3+A/dyHqajFeLBI9defMwuhhX6rs531jzr2/rwYcIpE7lZGUwLerPn3Z4ikgNGu06L1D5lvR6eFIwbsLnhl/MgsaXtU6hCfmLYA/nyxLiKAg8Qs8env7bkScgAYfpWqftU/gbpJ1bXgZTZ28eQvtpzqNd0HWNBHTqD9qug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imz+nN4XmH+Hb1lDxtBSSmffWSXwdgcVObA1324nDS4=;
 b=1ZlG/a5rZUxwT2stRawqu7AEwjrbYIHZXHTenrUI4Up+mGJn7BZ+wwSfY/VRi6iKRkMJpwgvoWey64J10ceZomce/op9XnqtTSPD7UsGDhclDgDq311OyxhvRES8AXYJf5bppj7y9iI7najBYV08p7d8vfIUgjKl2rqtWpSfdHc=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4750.eurprd08.prod.outlook.com (10.255.112.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 06:12:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 06:12:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [01/30] drm: Introduce drm_bridge_init()
Thread-Topic: [01/30] drm: Introduce drm_bridge_init()
Thread-Index: AQHVqNUM0g5O7Fjga0S0liny7wKZ4KemiS2AgAFmXAA=
Date:   Tue, 3 Dec 2019 06:12:20 +0000
Message-ID: <20191203061212.GA16542@jamwan02-TSP300>
References: <20191126131541.47393-2-mihail.atanassov@arm.com>
 <20191202055459.GA25729@jamwan02-TSP300>
 <20191202084935.GW624164@phenom.ffwll.local>
In-Reply-To: <20191202084935.GW624164@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5679f8f-4843-490e-e494-08d777b7c6a7
X-MS-TrafficTypeDiagnostic: VE1PR08MB4750:|VE1PR08MB4750:|VI1PR0802MB2302:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB23021F6EC691AB38A7B5A63CB3420@VI1PR0802MB2302.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1247;OLM:1247;
x-forefront-prvs: 02408926C4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(189003)(199004)(81166006)(7736002)(305945005)(66446008)(66476007)(66066001)(66946007)(64756008)(76176011)(6116002)(52116002)(966005)(11346002)(446003)(33716001)(14454004)(26005)(66556008)(25786009)(186003)(3846002)(55236004)(102836004)(6506007)(386003)(6436002)(6306002)(8676002)(81156014)(6246003)(9686003)(6512007)(2906002)(6486002)(478600001)(2501003)(229853002)(256004)(5024004)(8936002)(33656002)(110136005)(316002)(5660300002)(1076003)(86362001)(58126008)(2201001)(99286004)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4750;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P1KH2p5oOWBRVfkSaewm+dDEaANHSN+cRtWDxUs0lnTSoYsTGb9XO3+wu5FVEMZ2Ij1FcWwV9Q5xusDOwMT1hucHUvwRGVJ2oRHS1OddL2JXOclT473Vyh+onLhCZqua/CfVdyw8g4eQRVKPalV30miF8IluVny2RD9kjr1ktG0tIVvHTNH/4mkUmi/GdmNALfEGdEj/hvfhrUZlhAGKDl7qqp3PenVQt4wxBdCZLe4ufUcUZLFcEbcx1xFxTQxUmZ4Exj3/fyUNkCEtBASRaU8a5pCJtBC3ybgVjmQUK/UoZ3hfR7EVXrF+t7/NZuRt0VBrrdQK+yXFF1M45HVLEjj3LEekYv7murRfzFBM87F+Zx8IfPokY66+K7/iUlJ3cFAV3P1ZhO8ErFBqmiRr0fVkSdDV9PZdeVP4JgZJ8c8/pUqj3gHHfNwobrTBPBvZHQib40dVqMIRSVKn1Cd5CwEfMhSSed1N1ViSUYI3UFM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0978FF761E31743A11BA43EF79098CA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4750
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(39860400002)(396003)(376002)(136003)(40434004)(189003)(199004)(356004)(26826003)(14454004)(446003)(11346002)(6306002)(76130400001)(478600001)(9686003)(6512007)(6486002)(966005)(46406003)(229853002)(336012)(81156014)(26005)(102836004)(81166006)(7736002)(14444005)(5024004)(5660300002)(25786009)(97756001)(2201001)(66066001)(186003)(8676002)(47776003)(50466002)(6246003)(386003)(2906002)(1076003)(587094005)(33716001)(8746002)(58126008)(316002)(36906005)(106002)(8936002)(76176011)(110136005)(6506007)(305945005)(70206006)(3846002)(22756006)(70586007)(86362001)(6116002)(33656002)(99286004)(2501003)(23726003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2302;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: cf7877dd-4db0-47ff-9fcc-08d777b7c13a
X-Forefront-PRVS: 02408926C4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/jku/d7myTKTVipp4jnmCsueA63PFFpQraa8IuzvBxQR8Xz2VDWxmVp/l3Pi6TeiEqhtv1+51nLnyMX3WkzjCbXRj3GTlb284ML6xnTIW/a7B8f6kna/y4EulZ1AQf93zqlkGiQFlW+LucoPqd8PKMwwxUgzYzUzGj0czR2G9F4g2xxdIG6PHSfa+xMhH5FyhcHBb5bEN+HkB1uc5BPvp9UNklG2AnmZ/lwkA13tECkPn9unYqs4bayFDXdnQp0zRt20SmbR3fvJJZWNc3mFQnjACtMuim7sti3G5/x4dqE93GS4aQC9smKX7+fyPEjX7RJ4EX85x29jrsKA/SE3YEBgT9ttN/j6kbTdoW7Kg3FKlgGtrFFN1XsBo7tOe8AA8JQPMWZuTNcVjhzZZ2TTPpGaOPvG3J7Wzu1nrPUuJJ+C+wa35f2x4g2K6TM3QdaWeYYueFWtyeQtd9NDdJi0kiPjO05lSrSdphaDII9ZwglwpMu81b48K7XQbwIXwoEPMYaG5egIXOnz0YNcpMpW5N65dx3YdDC4HEOrEtTob4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 06:12:29.0732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5679f8f-4843-490e-e494-08d777b7c6a7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:49:35AM +0100, Daniel Vetter wrote:
> On Mon, Dec 02, 2019 at 05:55:06AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> > > A simple convenience function to initialize the struct drm_bridge.
> > >
> > > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > > ---
> > >  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
> > >  include/drm/drm_bridge.h     |  4 ++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridg=
e.c
> > > index cba537c99e43..cbe680aa6eac 100644
> > > --- a/drivers/gpu/drm/drm_bridge.c
> > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
> > >  }
> > >  EXPORT_SYMBOL(drm_bridge_remove);
> > >
> > > +/**
> > > + * drm_bridge_init - initialise a drm_bridge structure
> > > + *
> > > + * @bridge: bridge control structure
> > > + * @funcs: control functions
> > > + * @dev: device
> > > + * @timings: timing specification for the bridge; optional (may be N=
ULL)
> > > + * @driver_private: pointer to the bridge driver internal context (m=
ay be NULL)
> > > + */
> > > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > > +              const struct drm_bridge_funcs *funcs,
> > > +              const struct drm_bridge_timings *timings,
> > > +              void *driver_private)
> > > +{
> > > + WARN_ON(!funcs);
> > > +
> > > + bridge->dev =3D NULL;
> > > + bridge->encoder =3D NULL;
> > > + bridge->next =3D NULL;
> > > +
> > > +#ifdef CONFIG_OF
> > > + bridge->of_node =3D dev->of_node;
> > > +#endif
> > > + bridge->timings =3D timings;
> > > + bridge->funcs =3D funcs;
> > > + bridge->driver_private =3D driver_private;
> >
> > Can we directly put drm_bridge_add() here. then
> > - User always need to call bridge_init and add together.
> > - Consistent with others like drm_plane/crtc_init which directly has
> >   drm_mode_object_add() in it.
>
> Uh no, the trouble here is that drm_bridge_add should actually be called
> _register, because it publishes the bridge to the world. I think we even
> have a todo item to rename _add to _register ... Once that's done the
> bridge can't be changed anymore, all init code must have completed. So
> often you need a bit of code between _init() and _register().
>
> drm_mode_object_add is different since for mode objects it doesn't publis=
h
> it to the world, that's done with drm_dev_register and
> drm_connector_register. drm_mode_object_add just does a bit of internal
> house keeping.
> -Daniel
>

Yes, the name _register() is more better.

And thank you for such detailed explanation.

Thanks
James

> >
> > James.
> > > +}
> > > +EXPORT_SYMBOL(drm_bridge_init);
> > > +
> > >  /**
> > >   * drm_bridge_attach - attach the bridge to an encoder's chain
> > >   *
> > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > index c0a2286a81e9..d6d9d5301551 100644
> > > --- a/include/drm/drm_bridge.h
> > > +++ b/include/drm/drm_bridge.h
> > > @@ -402,6 +402,10 @@ struct drm_bridge {
> > >
> > >  void drm_bridge_add(struct drm_bridge *bridge);
> > >  void drm_bridge_remove(struct drm_bridge *bridge);
> > > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > > +              const struct drm_bridge_funcs *funcs,
> > > +              const struct drm_bridge_timings *timings,
> > > +              void *driver_private);
> > >  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> > >  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge=
 *bridge,
> > >                 struct drm_bridge *previous);
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
