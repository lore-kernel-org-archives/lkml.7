Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80070FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75021925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c6Br0+7X";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c6Br0+7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407331AbfJQDIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:08:18 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:10406
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406976AbfJQDIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK5T9lqaEMmbAY1/p8Kv6ayAzyAhiFFVil3VzbJtgqs=;
 b=c6Br0+7XdpUT/5OXSYQeugEPjgDoEMXtT2XMCezoSeNkm3UuZxaiFgnryf3EOVn9Z7qbRTOroDY/Im5YN6cWpkNRcmf0cXEcxfZc6GgwE87j9Vk/iEZ2dwVX4dQGp1jeSD+k80EsRP4RF5quWg9aTmsrl6IDyzgZrpPTLkwFkyI=
Received: from DB7PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:5:16::27) by
 DB6PR0801MB1862.eurprd08.prod.outlook.com (2603:10a6:4:75::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 17 Oct 2019 03:08:13 +0000
Received: from AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by DB7PR08CA0014.outlook.office365.com
 (2603:10a6:5:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22 via Frontend
 Transport; Thu, 17 Oct 2019 03:08:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT050.mail.protection.outlook.com (10.152.17.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 17 Oct 2019 03:08:11 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Thu, 17 Oct 2019 03:08:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1d455d727c1ca7d6
X-CR-MTA-TID: 64aa7808
Received: from 14a2a1833df7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E637B13B-7FA7-41DA-98BD-3E76CF9EB6C8.1;
        Thu, 17 Oct 2019 03:08:02 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 14a2a1833df7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 17 Oct 2019 03:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcFMCLTmcgrnKhRrsDipnCOd61uZ8PGJcdnZXrwEVLazcC9bo9s2T1j1qkRc4ru8/GpxLQlZESo5y2E4j4vxGBp4c0b/NHaK1J3Yo+IMQNwh7vWCZ3UBYNdhjiqwln0HCPVMMYSeEFeG+Hprkcv3r1+zT5/Xign7UkjxWO3aS3yBeZL0Ohgrq9xyWEDNXZTkqfFdlE7PRNEF8eJAhMMb4SUQYFxlVKzCD9WPSgDEmp00sZR32w93ekkkOym4vlQv08ymgIsbSIgoNLL3M9SPWPhynvzYjiWi1qrkYQt7pY40tQ+pCv4t4iCX5l8lugQrp0DUcM9lw0jE5MJ/4PeyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK5T9lqaEMmbAY1/p8Kv6ayAzyAhiFFVil3VzbJtgqs=;
 b=kh72TuVqgOYX678z9tY9rdTpTTDkHM7KXeMaAmxWBhp/30ss8DbWnTA7FEhyKC/+Qi61J7FQTbKMtBnXZpCrE8FvHyfU/TNwosOQ0UgvVloWM4FPy0NAtP94/igV7BmC5htG5PR0GZpyN1MSy68Is2+boo2CDOS+AavYLnSZ38i2bDLIrnonIM51xemMEawMvjQ/RrVtyGTcujLtr4bTOECTJRftbF7mYHVu4W5KaLxu6KDLr/JTggVh6hssF+iWNROmMz8/5ym6x/NEDUqL+KeJTpEVS0ohk4jaTeNCZ4eE3A37n8Jwel8HjBSFJzs2hc416OtsmHQIHQBZNWthuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK5T9lqaEMmbAY1/p8Kv6ayAzyAhiFFVil3VzbJtgqs=;
 b=c6Br0+7XdpUT/5OXSYQeugEPjgDoEMXtT2XMCezoSeNkm3UuZxaiFgnryf3EOVn9Z7qbRTOroDY/Im5YN6cWpkNRcmf0cXEcxfZc6GgwE87j9Vk/iEZ2dwVX4dQGp1jeSD+k80EsRP4RF5quWg9aTmsrl6IDyzgZrpPTLkwFkyI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5117.eurprd08.prod.outlook.com (20.179.30.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 03:07:59 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 03:07:59 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmX7+sBzYHhR8EiYyRUjNjETp6dddmWAgAAIg4CAALRsAA==
Date:   Thu, 17 Oct 2019 03:07:59 +0000
Message-ID: <20191017030752.GA3109@jamwan02-TSP300>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ed2c9280-6e1e-45e6-d001-08d752af3e6b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5117:|VE1PR08MB5117:|DB6PR0801MB1862:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1862B4B065E8535C20602E85B36D0@DB6PR0801MB1862.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01930B2BA8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(9686003)(8936002)(386003)(6512007)(229853002)(6486002)(6116002)(66946007)(5660300002)(3846002)(52116002)(1076003)(66446008)(64756008)(66556008)(66476007)(6436002)(55236004)(102836004)(76176011)(186003)(478600001)(26005)(6506007)(33656002)(316002)(446003)(11346002)(4326008)(256004)(5024004)(6246003)(476003)(81156014)(14454004)(33716001)(6636002)(2906002)(8676002)(7736002)(71190400001)(71200400001)(486006)(58126008)(66066001)(81166006)(54906003)(99286004)(305945005)(6862004)(25786009)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5117;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: T/Twa6JiLN1M7H1Aoiz1fCb5J9aKLR0tOSZ/uryze05Arc+8SCe/YRFfAHQE9Z32Ag9BRPED0cMxW5RhroI4aEpXVIgKY3qbV3F8jtQTZAVmuC7DFxixobs7Ba6ecj6CWmgylwRuBWf3vInHot4JqgrsCen2njQ9KPx16YcIYHfb1cQzzkRwKRE7Yp7C4eVO3/fJ+EmwalddQEZfChfwXCJCo41ItVblWdPV7wUwopXu30i5mMmkc/U8XKaVHvz8n4hkg1YRbdxCMmJFVwR53qcRB9xFCxrlF1RHfTv+6bDI1VES0BjAF30WLoRx4kabZ3hndGTll9ofdUoRZ2ftfHlAYmPupZIR+dTpB21zi0zD6k0RPDOeTWF98+p86Z6SAaWAPI8eGJ81dlYUqhNJyinyTjaoPypmtPbb5/UpIIA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B18A2B58726BD49AB01AA6B36E63070@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5117
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(186003)(14454004)(336012)(126002)(99286004)(476003)(50466002)(4326008)(446003)(5024004)(97756001)(63350400001)(11346002)(2906002)(356004)(23726003)(6862004)(486006)(25786009)(26005)(386003)(102836004)(6486002)(6506007)(3846002)(76176011)(9686003)(229853002)(6512007)(6246003)(107886003)(6116002)(5660300002)(36906005)(86362001)(478600001)(26826003)(76130400001)(70206006)(305945005)(58126008)(316002)(54906003)(6636002)(33716001)(22756006)(70586007)(47776003)(1076003)(81156014)(8936002)(8676002)(8746002)(33656002)(81166006)(46406003)(66066001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1862;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c219b026-b6b4-48e7-55f9-08d752af36b3
NoDisclaimer: True
X-Forefront-PRVS: 01930B2BA8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10qgp3xwQEjZqKTr6aUGSpx7tCpfPdA+zlI26ldflPXghU+zRf8IBfMmAl8tKdfk4PuHqbs4aYSHmZ22z/FqctIu36O+gPzhHO7ibXYXv2QCjGGtbJqI+q5AIUtUmjlJuKSk7ml9OIL8W9fpYx7xC4huJjlHO0SufY8dQxrxA/+3YIM209LE+sNRpHfUt7xU+jqPqfHAiBrQ+jluL7nMr6TW1rTVOPxHl3EFZbKqpFcZQ0yVbIF++2iInIQqyajhJHA6rOWBScHvNTwkta27zLK+vdguuxAI2CFnMy/IXjYd7Fa5vAjLquvJs8fAbVyZahvrG54IHEaWgr8t7wImCKTVlcUtzcJAMufz2qKFlUObYgTgeOJS/DaIueLW4gGMzVKuFfg+yWnvBiovzrPZVMdJFbQ433gFqh6olNiGd5c=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 03:08:11.5661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2c9280-6e1e-45e6-d001-08d752af3e6b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> Hi,
>=20
> On Wed, Oct 16, 2019 at 03:51:39PM +0000, Mihail Atanassov wrote:
> > Hi James,
> >=20
> > On Wednesday, 9 October 2019 06:54:15 BST james qian wang (Arm Technolo=
gy China) wrote:
> > > On Fri, Oct 04, 2019 at 02:34:42PM +0000, Mihail Atanassov wrote:
> > > > To support transmitters other than the tda998x, we need to allow
> > > > non-component framework bridges to be attached to a dummy drm_encod=
er in
> > > > our driver.
> > > >=20
> > > > For the existing supported encoder (tda998x), keep the behaviour as=
-is,
> > > > since there's no way to unbind if a drm_bridge module goes away und=
er
> > > > our feet.
> > > >=20
> > > > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > > > ---
> > > >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
> > > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  58 ++++++--
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 133 ++++++++++++++=
+++-
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
> > > >  4 files changed, 187 insertions(+), 14 deletions(-)
> > > >=20
> > > > [snip]
> > > > =20
> > > > +static void komeda_encoder_destroy(struct drm_encoder *encoder)
> > > > +{
> > > > +	drm_encoder_cleanup(encoder);
> > > > +}
> > > > +
> > > > +static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
> > > > +	.destroy =3D komeda_encoder_destroy,
> > > > +};
> > > > +
> > > > +bool komeda_remote_device_is_component(struct device_node *local,
> > > > +				       u32 port, u32 endpoint)
> > > > +{
> > > > +	struct device_node *remote;
> > > > +	char const * const component_devices[] =3D {
> > > > +		"nxp,tda998x",
> > >=20
> > > I really don't think put this dummy_encoder into komeda is a good
> > > idea.
> > >=20
> > > And I suggest to seperate this dummy_encoder to a individual module
> > > which will build the drm_ridge to a standard drm encoder and componen=
t
> > > based module, which will be enable by DT, totally transparent for kom=
eda.
> > >=20
> > > BTW:
> > > I really don't like such logic: distingush the SYSTEM configuration
> > > by check the connected device name, it's hard to maintain and code
> > > sharing, and that's why NOW we have the device-tree.
>=20
> It's not ideal to have such special cases, for sure. However, I don't
> see this approach causing us any issues. tda998x really is "special",
> and as far as I can see the code here scales to other devices pretty
> easily.
>=20
> >=20
> > +Cc Brian
> >=20
> > I didn't think DT is the right place for pseudo-devices.
>=20
> I agree. DT should represent the HW, not the structure of the
> linux kernel subsystem.
>=20
> > The tda998x
> > looks to be in a small group of drivers that contain encoder +
> > bridge + connector; my impression of the current state of affairs is
> > that the drm_encoder tends to live where the CRTC provider is rather
> > than representing a HW entity (hence why drm_bridge based drivers
> > exist in drivers/gpu/drm/bridge). See the overview DOC comment in
> > drm_encoder.c ("drivers are free to use [drm_encoder] however they
> > wish"). I may be completely wrong, so would appreciate some
> > context and comment from others on the Cc list.
> >=20
> > In any case, converting a do-nothing dummy encoder into its own
> > component-module will add a lot more bloat compared to the current
> > ~10 SLoC implementation of the drm_encoder. probe/remove/bind/unbind,
> > a few extra structs here and there, yet another object file, DT
> > bindings, docs for the same, and maintaining all of that? It's a hard
> > sell for me. I'd prefer if we went ahead with the code as-is and fix it
> > up later if it really proves unwieldy and too hard to maintain. Could
> > this patch be improved? Sure! Can we improve it in follow-up work
> > though, as I think this is valuable enough on its own without any major
> > drawbacks?
> >=20
>=20
> Even if we implemented a separate component encoder, as far as I can
> tell there's no way to use it without either:
>=20
> a) sticking it in DT
> b) invoking it from komeda based on a "of_device_is_compatible" list
>=20
> IMO a) isn't acceptable, and b) doesn't have any advantages over this
> approach.
>=20
> > As per my cover letter, in an ideal world we'd have the encoder locally
> > and do drm_bridge_attach() even for tda998x, but the lifetime issues
> > around bridges inside modules mean that doing that now is a bit of a
> > step back for this specific case.
> >=20
>=20
> Yeah, my feeling is that being able to keep tda998x as a component
> (for the superior bind/unbind behaviour) is worth the slight ugliness,
> at least until bridges get the same functionality.
>=20
> If James is strongly against merging this, maybe we just swap
> wholesale to bridge? But for me, the pragmatic approach would be this
> stop-gap.
>

This is a good idea, and I vote +ULONG_MAX :)

and I also checked tda998x driver, it supports bridge. so swap the
wholesale to brige is perfect. :)

Thanks
James.

> Cheers,
> -Brian
>=20
> > >=20
> > > Thanks
> > > James
> > >=20
> > > > [snip]
> > >=20
> >=20
> > --=20
> > Mihail
> >=20
> >=20
> >=20
