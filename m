Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98880FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493D5218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dkkaZbR/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dkkaZbR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405871AbfJPPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:52:01 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:13955
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726985AbfJPPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZbVpZtfiiA2DR1kpvsvhXiK9/FbADvXQvh7uCMgeK4=;
 b=dkkaZbR/EtjiJE+k96tcE/tpsww1ThQp9coLcs7CIaFo5x8LeIuJxKTx5VQKxl94q9T8e+GnKEgP3hayiPt1ql58IY7fRu4usyqfILRmrkDlRCmBvqH6g6D0aPS+OP9F76vFqf67QRnwSGl3ONuMfo7VFF305VhjjtoFtzq9TyE=
Received: from DB7PR08CA0033.eurprd08.prod.outlook.com (2603:10a6:5:16::46) by
 DB8PR08MB4154.eurprd08.prod.outlook.com (2603:10a6:10:b1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 15:51:53 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by DB7PR08CA0033.outlook.office365.com
 (2603:10a6:5:16::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Wed, 16 Oct 2019 15:51:53 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 15:51:52 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Wed, 16 Oct 2019 15:51:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ddf0f4e3a676208
X-CR-MTA-TID: 64aa7808
Received: from d874fc66564d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0B763A77-1BB2-4316-B307-659D2645088B.1;
        Wed, 16 Oct 2019 15:51:41 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d874fc66564d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 15:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1MTLh+iX3nFtDDLvWqCsynC5gmkyofpk1e0W7h8dtUZpPnuhOt95glQpfYtYZXCbD5xresmIL9QzQ1wJey9v187/XsolwRSr/D/SrPqpYUfdaLoMvBP32/Lysx0AGbjQbKewOIxt56iwbs2Mq8cPaClX57X1z4iBJ5usZ37OUFtUtBlKAE2Mx8GqekuCNAvtTpYNKCsQs/GIIKOdypbLjRyaM+lN3PWcWFaIH5nv0x5bFdN0yDy4HrufVs0K505I1wj4lAZ1enAuvl1LGhyxB0bm666PisQJiA59Xs4kd8yYPAbz+5L+iHmIFWbMu8QP31b2B17ZMg9RzZKiWFtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZbVpZtfiiA2DR1kpvsvhXiK9/FbADvXQvh7uCMgeK4=;
 b=G61fGd0mm3nVRJKZokAjNYja8jFC4aCBXYnDl/q8/K831wQT2lCjlyd623ohegkLmZYTK7skXN6/2xMAWhZnGKhfa9KvAyo7riM7sWONqoVmnrtgUx4HE2h8ZPufNzB26l0eTFjfzgWFnwmo037RD9Jk3oxkmk49D7eFkb1lV0FxLoths7pJ+gW0apFt+TsHLTML8/S7dWVVTfKR9E9PCYfjcAI2XGrkx6vbS3CCFGJ0c+AXEYxLAy7/F2r3OUk0QqZwo+GDWvhWPeZboKbo4F0jywQ6JVLanhfZTl0aBYjdP6vIGgMiS9E4qlN6B+wgO37lO1G621ZAPfVN9PGuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZbVpZtfiiA2DR1kpvsvhXiK9/FbADvXQvh7uCMgeK4=;
 b=dkkaZbR/EtjiJE+k96tcE/tpsww1ThQp9coLcs7CIaFo5x8LeIuJxKTx5VQKxl94q9T8e+GnKEgP3hayiPt1ql58IY7fRu4usyqfILRmrkDlRCmBvqH6g6D0aPS+OP9F76vFqf67QRnwSGl3ONuMfo7VFF305VhjjtoFtzq9TyE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3440.eurprd08.prod.outlook.com (20.177.59.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 15:51:39 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 15:51:39 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>,
        Brian Starkey <Brian.Starkey@arm.com>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVfmYCVHmeR23TD0SRvLooFH2IJKdddlmA
Date:   Wed, 16 Oct 2019 15:51:39 +0000
Message-ID: <5390495.Gzyn2rW8Nj@e123338-lin>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300>
In-Reply-To: <20191009055407.GA3082@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: SN6PR0102CA0014.prod.exchangelabs.com (2603:10b6:805:1::27)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dad1a971-1b5c-43c1-46d6-08d75250c375
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3440:|VI1PR08MB3440:|DB8PR08MB4154:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4154BECF3830791A828411688F920@DB8PR08MB4154.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(6636002)(71200400001)(26005)(7736002)(305945005)(186003)(86362001)(99286004)(71190400001)(33716001)(66446008)(64756008)(66476007)(14454004)(66946007)(66556008)(66066001)(5660300002)(54906003)(386003)(316002)(5024004)(6512007)(8936002)(6862004)(478600001)(6506007)(6116002)(76176011)(102836004)(256004)(3846002)(2906002)(476003)(446003)(25786009)(11346002)(486006)(9686003)(52116002)(81166006)(4326008)(6246003)(6486002)(81156014)(6436002)(229853002)(8676002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3440;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n9iKC3K2iGL+73yPf7Qa68bDVCLNuxXb0b9aMG3xoVJ8cmgUkgZtuEVM78G3zJk97tQZtyjrDCGTrbhRbZXUrm34Vs7pih3NLFp9XZLBJBKATj+8yQhm+KgO2MTv/4paRin2B6mORCfadoxyx2BRK/3Cs17B3guxGhZbtQGuN5lxaih4TyIljJ2K2l7hD+5K6Hmu0w446dtXRvR6XMlwmkqKQb+Iqn3sOV8ohBYtUJ/brrlF+MJAROzKK+c+/V5TVDOVYepKycaIzYP0MoU275H+UeSRx+r/4aHri5O2hJPSNXS+DvFn+7LrSbiVFQLBHRCHf2UDGoeucz7BkS6A85aaXqJc+/Kf0VEcztCGzD8l6426kgjudJT9lRWX5R+il2fFbaTMqJBfb1QhaYJ1Y0aTR1WXUwklELQ7QpSp+JM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD65661515A0694984EC433BFC445A10@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3440
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(2906002)(25786009)(186003)(86362001)(126002)(63350400001)(356004)(97756001)(486006)(6636002)(26826003)(478600001)(476003)(336012)(446003)(5024004)(26005)(8746002)(8676002)(81156014)(81166006)(8936002)(6246003)(22756006)(6862004)(46406003)(33716001)(9686003)(6512007)(229853002)(6486002)(305945005)(76176011)(386003)(11346002)(99286004)(6116002)(47776003)(6506007)(7736002)(102836004)(50466002)(76130400001)(70206006)(4326008)(54906003)(70586007)(316002)(66066001)(5660300002)(14454004)(23726003)(3846002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4154;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0401189e-caa2-485c-796b-08d75250bb3f
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8LKBsd5Vyc9R8hYk5w2j6KQFhCk8RDnZiedqwTHCgasDjgS1f9laCPZzXkVZL7NvsRXncx5PiSkG0UEQdl4SooevHaTP6cmEHE0ni5rLz5v6VvYkSlQRk6qf8TIG+Me/TqRYFDkXebp8aa3rP/ASCijGMiTia4CQMnSNB8nTy+mDybu8tsu9jmLTYFOskJuA0Jh8VvNUHhy5x3KvfSjW+4rYZtxyARtWUpTCtp9LLvY4AIJiVf2rFnCgdz5fplMGKVSz1nzLBeQhTzhskkTThpm20NIVe+tz9dYsYSFj7Nl/SsIrjlO9woq2Y6lvcr26DsAuG71eIUWbbqZTjjgIWvC1RWZBSIGKvvr1CM9YKEumB022kTJX+DJ0qzp9axmyyeT6Z/JoFCbLzGDW/5BrEq3nzlBAQ89w8gKYnH/1ZE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 15:51:52.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad1a971-1b5c-43c1-46d6-08d75250c375
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wednesday, 9 October 2019 06:54:15 BST james qian wang (Arm Technology C=
hina) wrote:
> On Fri, Oct 04, 2019 at 02:34:42PM +0000, Mihail Atanassov wrote:
> > To support transmitters other than the tda998x, we need to allow
> > non-component framework bridges to be attached to a dummy drm_encoder i=
n
> > our driver.
> >=20
> > For the existing supported encoder (tda998x), keep the behaviour as-is,
> > since there's no way to unbind if a drm_bridge module goes away under
> > our feet.
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
> >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  58 ++++++--
> >  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 133 +++++++++++++++++-
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
> >  4 files changed, 187 insertions(+), 14 deletions(-)
> >=20
> > [snip]
> > =20
> > +static void komeda_encoder_destroy(struct drm_encoder *encoder)
> > +{
> > +	drm_encoder_cleanup(encoder);
> > +}
> > +
> > +static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
> > +	.destroy =3D komeda_encoder_destroy,
> > +};
> > +
> > +bool komeda_remote_device_is_component(struct device_node *local,
> > +				       u32 port, u32 endpoint)
> > +{
> > +	struct device_node *remote;
> > +	char const * const component_devices[] =3D {
> > +		"nxp,tda998x",
>=20
> I really don't think put this dummy_encoder into komeda is a good
> idea.
>=20
> And I suggest to seperate this dummy_encoder to a individual module
> which will build the drm_ridge to a standard drm encoder and component
> based module, which will be enable by DT, totally transparent for komeda.
>=20
> BTW:
> I really don't like such logic: distingush the SYSTEM configuration
> by check the connected device name, it's hard to maintain and code
> sharing, and that's why NOW we have the device-tree.

+Cc Brian

I didn't think DT is the right place for pseudo-devices. The tda998x
looks to be in a small group of drivers that contain encoder +
bridge + connector; my impression of the current state of affairs is
that the drm_encoder tends to live where the CRTC provider is rather
than representing a HW entity (hence why drm_bridge based drivers
exist in drivers/gpu/drm/bridge). See the overview DOC comment in
drm_encoder.c ("drivers are free to use [drm_encoder] however they
wish"). I may be completely wrong, so would appreciate some
context and comment from others on the Cc list.

In any case, converting a do-nothing dummy encoder into its own
component-module will add a lot more bloat compared to the current
~10 SLoC implementation of the drm_encoder. probe/remove/bind/unbind,
a few extra structs here and there, yet another object file, DT
bindings, docs for the same, and maintaining all of that? It's a hard
sell for me. I'd prefer if we went ahead with the code as-is and fix it
up later if it really proves unwieldy and too hard to maintain. Could
this patch be improved? Sure! Can we improve it in follow-up work
though, as I think this is valuable enough on its own without any major
drawbacks?

As per my cover letter, in an ideal world we'd have the encoder locally
and do drm_bridge_attach() even for tda998x, but the lifetime issues
around bridges inside modules mean that doing that now is a bit of a
step back for this specific case.

>=20
> Thanks
> James
>=20
> > [snip]
>=20

--=20
Mihail



