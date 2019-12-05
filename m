Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7286FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B4206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VO0xD4rM";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VO0xD4rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfLEOZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:25:20 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:26828
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbfLEOZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJtvfZsldqtIlUTMNq33x3RIOAnle4BfQNeSJvULHP8=;
 b=VO0xD4rMq/fpNWn2aJbRLCOMVtN9sqFzLVtJX6xPRq4Il4yMvQ367hVc+stoYq2M/kkmdFB8uWMbRgxF/typ4xg08jAIabmoXbobwPx+n2vq/qFbXYSHXCznulLbhn5A1ZRpLOqVPkGHuDN03p4BiA+urpXYgADoTT6ae57b8NQ=
Received: from DB6PR0801CA0050.eurprd08.prod.outlook.com (2603:10a6:4:2b::18)
 by DB8PR08MB5241.eurprd08.prod.outlook.com (2603:10a6:10:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Thu, 5 Dec
 2019 14:25:11 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by DB6PR0801CA0050.outlook.office365.com
 (2603:10a6:4:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 14:25:11 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 14:25:10 +0000
Received: ("Tessian outbound 25173d5f5683:v37"); Thu, 05 Dec 2019 14:25:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8d132f69c51e5f41
X-CR-MTA-TID: 64aa7808
Received: from 6099433ef415.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B0D85104-A995-47C7-8473-587911C9D8E1.1;
        Thu, 05 Dec 2019 14:25:05 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6099433ef415.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 14:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmf1Gl0VXt0SFqFQeq1m4oEhzCQyRnBVonkFTbMxxsZXg4dnhKa6aSUQjWzn8xsneTZyy/cZH7JIPYlZo6oy8NtjBcGWm9TJd8xHaaNeG8Xmsx1TKcQD2FVo0bAsTCk1YSa49qH9rxHbeG/0n80OduRZz7CTnVede3azKZ2Uro7Eh4x5/U3e2hZf4LLq0Xv2hcqsFx9uzm+l6fsaOfZL1aaJAl7aGADD0vJ7dKs/oZpySMHnbgZFdd/o6dKFfkGaxUCGe3JOfgJbuVH1711Sj5bqSzKyBk657zfs3h4/+BJoRfQfaV5ySkpyPJ8I0O2ypqvLk9MYax+S1Ggl9YqkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJtvfZsldqtIlUTMNq33x3RIOAnle4BfQNeSJvULHP8=;
 b=O0LRMp8ALZJmaPqImaaFb1NAtrh9n08KHiFCJ9HhLnh1/bMwF+K/6AoXlkoMY3pu0JgwgnUDLb2FgbToktiriVOEec1UB1XvHoFMglxVdysYwgxsCwEJ3du/sRrhMyJ0rZQIoy88StCWkJyxJZ8L12vL0II4Kw+nBZV9P+/wjMQYwpHh3p0taSiM6jMVb89Et70Wx7tsV2oBy6CE4t7YIUJr9NaqO99/u4jR7d8kVEEx/g8CHjkYzGSWhnAwfQCIUZohB11Nmgqqvcewh9MiQPy+5xgVWgXXlj8vUkCBM55XOXhz6jk+FAAOesPY8+JOxr6Aj9AJkYtEBJv2c1KOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJtvfZsldqtIlUTMNq33x3RIOAnle4BfQNeSJvULHP8=;
 b=VO0xD4rMq/fpNWn2aJbRLCOMVtN9sqFzLVtJX6xPRq4Il4yMvQ367hVc+stoYq2M/kkmdFB8uWMbRgxF/typ4xg08jAIabmoXbobwPx+n2vq/qFbXYSHXCznulLbhn5A1ZRpLOqVPkGHuDN03p4BiA+urpXYgADoTT6ae57b8NQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4462.eurprd08.prod.outlook.com (20.179.26.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 5 Dec 2019 14:25:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 14:25:03 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH v2 01/28] drm: Introduce drm_bridge_init()
Thread-Index: AQHVqpiuVXCS0RRq1UGHN2fVy/u6K6erfSAAgAAaBwA=
Date:   Thu, 5 Dec 2019 14:25:03 +0000
Message-ID: <1769361.msXMbpdiVO@e123338-lin>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
 <20191204114732.28514-2-mihail.atanassov@arm.com>
 <20191205124022.GA16034@pendragon.ideasonboard.com>
In-Reply-To: <20191205124022.GA16034@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa38897f-93a6-43d1-c315-08d7798eefbb
X-MS-TrafficTypeDiagnostic: VI1PR08MB4462:|DB8PR08MB5241:
X-Microsoft-Antispam-PRVS: <DB8PR08MB5241B985D351CE945E062E658F5C0@DB8PR08MB5241.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:272;OLM:272;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(189003)(199004)(51914003)(14454004)(99286004)(5660300002)(9686003)(71200400001)(71190400001)(66556008)(186003)(66476007)(52116002)(33716001)(11346002)(66446008)(6512007)(54906003)(316002)(86362001)(229853002)(2906002)(478600001)(81166006)(25786009)(102836004)(14444005)(8676002)(6506007)(81156014)(305945005)(966005)(6486002)(64756008)(66946007)(4326008)(6916009)(26005)(8936002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4462;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uZoOwzpLWsSwCAdIpXRl5DX0DKrLQIQUr3nDv7p4vcRdQFs8GyVv5iUfQUSsOoKYJi3X1jJ7Nmo4rMl4MNU+sHC/k7iB53m1vWW46VZc1wFfSSFMflanmAyeJo6M3M6rxO/nqBD1fKKnRxadvlIyEodH2WbGlnJRklxZWmHLGyVwnj6ELT4dc5RI+Hyyz860cEMJDMYLPNuuCUJP+3ceQvJBabilUAm4pS1PShB+FvMcFNKSMYRG3fZlL2rDiEUiyQi1ipvUqO+i5p46P+MDHdScLr+boBimYC0AywHDpCVH8SPsAbUvyIf8bGIBLv/0+C1IFbwqLzcn4oPCmQ5opIu7lN9dPX3YxZIUFd0sdU3HUDI3/0Jx4LrBMwYmcqbAwUXB2qbbcZ+8lgydd5TSeKYdMv4s8AnireC98d41T5jOVSLtv2YuYJKX2KF03+GX1uXonOvGlyeW+kk4LdLxJsJ64MoIFhSx+HfLBkxNvFSEc99gOMP5kEE3hwUGMaZCec3VXLoaqCB0V6odhUxAy8EHeN7/sF5A+85pGHslJj0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D4E8321A104A64B8D1F0D662D5D9C49@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4462
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(136003)(376002)(346002)(51914003)(199004)(189003)(102836004)(14454004)(4326008)(33716001)(76176011)(76130400001)(305945005)(26005)(81156014)(6506007)(356004)(81166006)(14444005)(99286004)(11346002)(8936002)(2906002)(229853002)(6486002)(70206006)(5660300002)(50466002)(23726003)(22756006)(966005)(97756001)(36906005)(26826003)(478600001)(6512007)(9686003)(54906003)(70586007)(186003)(8676002)(46406003)(336012)(6862004)(86362001)(316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5241;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 36f45192-e8c1-4f80-238a-08d7798eeae1
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2bHi492EcNm5szYh4C1hz4ir60uZrN3qmm88hYP7zJxOa8k1+URXf/IaZIBPxzzP0l6S9UBEWHLZlcmdPFg6W/Pv7p8skMoxWfZc5OIoNmvzszP4FWX0avg1f+rBh1xfndimTBwb55+pWN4ckZPA4dKf02TGr0UscdT1DijvPFxKQy/PtYn98Fl/fs1Qh6pczF7yDkZ9sayV7zLp5DDpVCuQl7S5nRoJvMVVZKC50dhbnQ7evBOEiMaH8Y07SDT/lGkfBeGbjoMHAAsNNdrWONWU+unVKUqQJjzUQqZUPGU5PbVVvqY2nQWaq+1bLzo99kmcenX4WtHC+D2PGma9umb7RPJJa4v5w7Z4AuBL47/hI8LNcYm/ZOpaFOMojMSliz8vhkB7s/+hKW4RSqrFmYZ3Mcgwu/v9r66Hz9clQ6dJ6aXbwlVJACigb2O5IikzNWZbYBtFc7az3p3/NoUUUZtnMsFKTcil58uZ3YedkD6S5Leltcbd53CPKjDR63nUlenBERZDxcv1Nyi/tlD2Swtvx9MSmnDuVANr88i5Dc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 14:25:10.9440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa38897f-93a6-43d1-c315-08d7798eefbb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thursday, 5 December 2019 12:40:22 GMT Laurent Pinchart wrote:
> Hi Mihail,
>=20
> Thank you for the patch.

Thanks for the quick reviews :).

>=20
> On Wed, Dec 04, 2019 at 11:48:02AM +0000, Mihail Atanassov wrote:
> > A simple convenience function to initialize the struct drm_bridge. The
> > goal is to standardize initialization for any bridge registered with
> > drm_bridge_add() so that we can later add device links for consumers of
> > those bridges.
> >=20
> > v2:
> >  - s/WARN_ON(!funcs)/WARN_ON(!funcs || !dev)/ as suggested by Daniel
> >  - expand on some kerneldoc comments as suggested by Daniel
> >  - update commit message as suggested by Daniel
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 34 +++++++++++++++++++++++++++++++++-
> >  include/drm/drm_bridge.h     | 15 ++++++++++++++-
> >  2 files changed, 47 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index cba537c99e43..50e1c1b46e20 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -64,7 +64,10 @@ static DEFINE_MUTEX(bridge_lock);
> >  static LIST_HEAD(bridge_list);
> > =20
> >  /**
> > - * drm_bridge_add - add the given bridge to the global bridge list
> > + * drm_bridge_add - add the given bridge to the global bridge list.
>=20
> You add a final period here and in the documentation of struct
> drm_bridge, but the new function you're adding doesn't have one :-) I'd
> drop the period here and for drm_bridge to be consistent with the rest
> of the code.
>=20
> > + *
> > + * Drivers should call drm_bridge_init() prior adding it to the list.
>=20
> s/should/shall/
> s/prior adding it/prior to adding the bridge/
>=20
> > + * Drivers should call drm_bridge_remove() to clean up the bridge list=
.
>=20
> I'd replace this sentence with "Before deleting a bridge (usually when
> the driver is unbound from the device), drivers shall call
> drm_bridge_remove() to remove it from the global list."
>=20

> >   *
> >   * @bridge: bridge control structure
> >   */
> > @@ -89,6 +92,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL(drm_bridge_remove);
> > =20
> > +/**
> > + * drm_bridge_init - initialise a drm_bridge structure
>=20
> initialise or initialize ? :-)

I have absolutely no clue :). Judging by the question I'm guessing the
correct answer for the kernel is US spelling.

>=20
> > + *
> > + * @bridge: bridge control structure
> > + * @funcs: control functions
> > + * @dev: device associated with this drm_bridge
>=20
> dev goes before funcs
>=20
> > + * @timings: timing specification for the bridge; optional (may be NUL=
L)
> > + * @driver_private: pointer to the bridge driver internal context (may=
 be NULL)
>=20
> I'm not too sure about the last two parameters. Having NULL, NULL in
> most callers is confusing, and having a void * as one of the parameters
> means that the compiler won't catch errors if the two parameters are
> reversed. I think this is quite error prone.
>=20
> There are very few drivers using driver_private (I count 6 of them, with
> 2 additional drivers that set driver_private but never use it). How
> about embedding the bridge structure in those 6 drivers and getting rid
> of the field altogether ? This could be part of a separate series, but
> in any case I'd drop driver_private from drm_bridge_init().

Ok, I'll do that first before refreshing this series.

>=20
> > + */
> > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > +		     const struct drm_bridge_funcs *funcs,
> > +		     const struct drm_bridge_timings *timings,
> > +		     void *driver_private)
> > +{
> > +	WARN_ON(!funcs || !dev);
> > +
> > +	bridge->dev =3D NULL;
>=20
> NULL ? Shouldn't this be dev ?

Hehe, Daniel got caught on that one, too :). This is the drm_device pointer
for the bound consumer, not the struct device that the bridge's lifetime
is tied to. I was planning to rename them with my (eventual) device_links
addition (some discussion around it here:
https://patchwork.freedesktop.org/patch/342472/?series=3D70039&rev=3D1).

I guess if I do the drm_device part of the rename first, this patch will
look less confusing, so I'll do that too.

>=20
> > +	bridge->encoder =3D NULL;
> > +	bridge->next =3D NULL;
> > +
> > +#ifdef CONFIG_OF
> > +	bridge->of_node =3D dev->of_node;
> > +#endif
> > +	bridge->timings =3D timings;
> > +	bridge->funcs =3D funcs;
> > +	bridge->driver_private =3D driver_private;
> > +}
> > +EXPORT_SYMBOL(drm_bridge_init);
> > +
> >  /**
> >   * drm_bridge_attach - attach the bridge to an encoder's chain
> >   *
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index c0a2286a81e9..949e4f401a53 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -373,7 +373,16 @@ struct drm_bridge_timings {
> >  };
> > =20
> >  /**
> > - * struct drm_bridge - central DRM bridge control structure
> > + * struct drm_bridge - central DRM bridge control structure.
> > + *
> > + * Bridge drivers should call drm_bridge_init() to initialize a bridge
> > + * driver, and then register it with drm_bridge_add().
>=20
> s/bridge driver/bridge structure/ (or drm_bridge structure)
>=20
> > + *
> > + * Users of bridges link a bridge driver into their overall display ou=
tput
> > + * pipeline by calling drm_bridge_attach().
> > + *
> > + * Modular drivers in OF systems can query the list of registered brid=
ges
> > + * with of_drm_find_bridge().
> >   */
> >  struct drm_bridge {
> >  	/** @dev: DRM device this bridge belongs to */
> > @@ -402,6 +411,10 @@ struct drm_bridge {
> > =20
> >  void drm_bridge_add(struct drm_bridge *bridge);
> >  void drm_bridge_remove(struct drm_bridge *bridge);
> > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > +		     const struct drm_bridge_funcs *funcs,
> > +		     const struct drm_bridge_timings *timings,
> > +		     void *driver_private);
> >  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> >  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *=
bridge,
> >  		      struct drm_bridge *previous);
>=20
>=20


--=20
Mihail



