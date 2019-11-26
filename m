Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C76C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A31B2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rADI9EYT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rADI9EYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfKZPz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:55:28 -0500
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:7597
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbfKZPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ4Shp5DNvgZrnsPgpX3VYjT6D2K6I+KjyjtOxnByyw=;
 b=rADI9EYTrY2bXRYwCL7UXiIAyB8DyoMPuc9AgW7Ur/EAaL8OrcdDLpgJUlCSelAn4OuF88zlXAg+P/XR85g0GpubYvVQoO9INQaNGRVs4Ln23zrXI317YmgOffGi+x3EUOeE7jNy2fYDs8ynKcUnK427954VPg9kNcwgUCELCiE=
Received: from DB6PR0801CA0053.eurprd08.prod.outlook.com (2603:10a6:4:2b::21)
 by DBBPR08MB4521.eurprd08.prod.outlook.com (2603:10a6:10:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Tue, 26 Nov
 2019 15:55:23 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by DB6PR0801CA0053.outlook.office365.com
 (2603:10a6:4:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Tue, 26 Nov 2019 15:55:23 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Tue, 26 Nov 2019 15:55:22 +0000
Received: ("Tessian outbound a8f166c1f585:v33"); Tue, 26 Nov 2019 15:55:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 13591cb9624bdbd3
X-CR-MTA-TID: 64aa7808
Received: from 06fdba92f32a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BEC2877C-C917-4548-836E-3297BED3AD8B.1;
        Tue, 26 Nov 2019 15:55:13 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 06fdba92f32a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 26 Nov 2019 15:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMqe7wq7K4N9JPAZrzgaR9CU7n34/1m4RS4xD1zzEPxBKnWDTYuxJLne9YyXsfBV6T5455L2A5J1pD5fzbIT/JlHceOGC1PaOew4YOuP5sO/cIPnRRQlZMldX02Tz8V+FkGpdyDmZBhU1nOxPmc1sL4StbcWcQxKxFECpBjDjSEkz6FkCMUbq4jm5dthSH3C7vyCkpJnH/7osvHZky1e/m+BCVWWnCL9DSakDOkS68BmyLw8y9+V2snyVB5JYTLQSBXDKOlFm1pnyVO65HSeaakzXVkI9wsInVbgaEYn54uFMj0LSfT2GxYBSUkt8XpXT1L4bZNmRhJ9F3rKGTruSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ4Shp5DNvgZrnsPgpX3VYjT6D2K6I+KjyjtOxnByyw=;
 b=K+hsuvDjuiBo8PRUVLf8hm5ZqVVMu68uk1oJQuFj1aj/wAsyGdJsHn0QUwpotj7byh8y2JF4fc1VTqLe8r1b7N9aFEOKDzgN+qfIjrb3+Ffrd7QicFOWmnFw+xx+G28pI2XEmkX2cSVz7uuVD5HZoe1vXZ0MrW/13JsWzVsP8C+EusqLRBSamOA2pEuPJ9cx5JIN/XpBnc4770w59ztIUF5DomlT5gCyfM9YG+J8BG9yHefU/Owj/az0oRlx+R5GSWebm0hkRrW6hg13dG06cWufwjCeBF0WrywnBKqELkxAyNt+X1DDCvRUDZZqz9fjFYpVgllz8uBThQb5qX2KXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ4Shp5DNvgZrnsPgpX3VYjT6D2K6I+KjyjtOxnByyw=;
 b=rADI9EYTrY2bXRYwCL7UXiIAyB8DyoMPuc9AgW7Ur/EAaL8OrcdDLpgJUlCSelAn4OuF88zlXAg+P/XR85g0GpubYvVQoO9INQaNGRVs4Ln23zrXI317YmgOffGi+x3EUOeE7jNy2fYDs8ynKcUnK427954VPg9kNcwgUCELCiE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2910.eurprd08.prod.outlook.com (10.175.245.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 15:55:10 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:55:10 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Index: AQHVpFukMd5nbiwRlEK6zRU7NBRujaedgi4AgAADJIA=
Date:   Tue, 26 Nov 2019 15:55:09 +0000
Message-ID: <11447519.fzG14qnjOE@e123338-lin>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-2-mihail.atanassov@arm.com>
 <20191126142610.GV29965@phenom.ffwll.local>
In-Reply-To: <20191126142610.GV29965@phenom.ffwll.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::24) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f26bad10-49b2-419e-c61a-08d772890bc2
X-MS-TrafficTypeDiagnostic: VI1PR08MB2910:|DBBPR08MB4521:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4521F4ECC4BBE0A9A0D041348F450@DBBPR08MB4521.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;OLM:2887;
x-forefront-prvs: 0233768B38
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(51914003)(6246003)(86362001)(81156014)(81166006)(66946007)(8936002)(110136005)(66476007)(5660300002)(2906002)(5024004)(316002)(6116002)(3846002)(66066001)(2501003)(386003)(66446008)(6436002)(14454004)(446003)(6486002)(99286004)(11346002)(229853002)(71190400001)(26005)(8676002)(64756008)(256004)(25786009)(478600001)(71200400001)(54906003)(66556008)(6506007)(33716001)(4326008)(76176011)(186003)(6512007)(305945005)(7736002)(102836004)(52116002)(9686003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2910;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lm9PPYYhwt78tZz7SROKCFCGCbaW8EzKd8c3/EUR2yFkfVdh+JLd/IIJ0om0iG0MZi1dJJ6nteq3MEV4Yh7vEh7E/qX1l/gvPWvqVWJUVLZthsdOnlY8lwSHNPWxj9Mcz8+rIsM43DwLWDEdbv+Qw/WzsLr+lA7v3FPyGYpJIuVuA7+NzIWUi7Illa8jILPhg2EDYtyds39Bhrp8peEuYxeGTiAexTu3x2ew+9KOh96/7+xCtW+oyfVm60bHrzbvGDIOoO8RXXAp13EgSCbAAD/QPQi5T0uY53fNk8itFoJRyhkcuTpINsMWYZPwyZUqD2GgfStHG0C+Xa9mEtC3IepfK8hOyzlNhWZ6N5OE5ebeUfl9GmtP/LNwV0Za3Z187XVd8ZGQqvg75YcKUDtuTDo/SkmvVqX34PU9fREb+Ax0/73RjZq5n47Wk/BQR6BW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0AB6B693B61AD4EBA89E26E0FF2B122@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(396003)(39860400002)(51914003)(189003)(199004)(106002)(336012)(86362001)(5024004)(102836004)(8936002)(6246003)(70586007)(5660300002)(26005)(70206006)(46406003)(186003)(8746002)(446003)(81166006)(50466002)(97756001)(11346002)(76130400001)(4326008)(76176011)(386003)(6506007)(2501003)(356004)(14454004)(54906003)(26826003)(6116002)(9686003)(23726003)(3846002)(6512007)(229853002)(305945005)(478600001)(25786009)(8676002)(81156014)(2906002)(22756006)(6486002)(99286004)(66066001)(110136005)(47776003)(7736002)(36906005)(316002)(33716001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4521;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 44746272-0f92-47ca-485f-08d7728903eb
NoDisclaimer: True
X-Forefront-PRVS: 0233768B38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tTAK13R+Z8xMsqZLqbKnqDki1aa03bY1xe1Ua8OTvVq8oVX/T5iRDSHAfx81pDmdY4PF/xouC4/xqqHjJcaeeO1BwgjE6rN05tVZ0xntmRmk+WxFuq4QhggGhKnSMTYzK1WJ28RGwcyn9VVeH3/13XyhrEKnK/HFzK/0oCsxxf0XAgOPpwqxvDSbeJ9NTDO0RCNAMwhFl1uqdN/FBx7qyoCm8DbWuhdfnxi2eZL/wvRSRSChvlSUZ2hFj0JGaAtE03Yc2Y15REqySDZI4oDlBVeT+39XVmwfcu/FL0TZMVcvGcoyk5fevv3QsWxnebJR6pui8IPNpyWdTyrgNoo9UUQGwC1seA5LUw0xveQ/1vDBuZNr+TwVTFo9AFInihP9bqk13A+PY7jv+XrRxe6c3hke25R4MdCoBdMvW7KB3WejNVPeNDyEz4rBkuAi/nm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:55:22.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26bad10-49b2-419e-c61a-08d772890bc2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for the quick review.

On Tuesday, 26 November 2019 14:26:10 GMT Daniel Vetter wrote:
> On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> > A simple convenience function to initialize the struct drm_bridge.
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> The commit message here leaves figuring out why we need this to the
> reader. Reading ahead the reasons seems to be to roll out bridge->dev
> setting for everyone, so that we can set the device_link. Please explain
> that in the commit message so the patch is properly motivated.

Ack, but with one caveat: bridge->dev is the struct drm_device that is
the bridge client, we need to add a bridge->device (patch 29 in this
series) which is the struct device that will manage the bridge lifetime.

>=20
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
> >  include/drm/drm_bridge.h     |  4 ++++
> >  2 files changed, 33 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index cba537c99e43..cbe680aa6eac 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL(drm_bridge_remove);
> > =20
> > +/**
> > + * drm_bridge_init - initialise a drm_bridge structure
> > + *
> > + * @bridge: bridge control structure
> > + * @funcs: control functions
> > + * @dev: device
> > + * @timings: timing specification for the bridge; optional (may be NUL=
L)
> > + * @driver_private: pointer to the bridge driver internal context (may=
 be NULL)
>=20
> Please also sprinkle some links to this new function to relevant places,
> I'd add at least:
>=20
> "Drivers should call drm_bridge_init() first." to the kerneldoc for
> drm_bridge_add. drm_bridge_add should also mention drm_bridge_remove as
> the undo function.
>=20
> And perhaps a longer paragraph to &struct drm_bridge:
>=20
> "Bridge drivers should call drm_bridge_init() to initialized a bridge
> driver, and then register it with drm_bridge_add().
>=20
> "Users of bridges link a bridge driver into their overall display output
> pipeline by calling drm_bridge_attach()."

Will do.

>=20
> > + */
> > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > +		     const struct drm_bridge_funcs *funcs,
> > +		     const struct drm_bridge_timings *timings,
> > +		     void *driver_private)
> > +{
> > +	WARN_ON(!funcs);
> > +
> > +	bridge->dev =3D NULL;
>=20
> Given that the goal here is to get bridge->dev set up, why not
>=20
> 	WARN_ON(!dev);
> 	bridge->dev =3D dev;

See above struct device vs struct drm_device. I add a

	bridge->device =3D dev;

in patch 29, which takes care of that. I skipped the warn since
there's a dereference of dev, but I now realized it's behind CONFIG_OF,
so I'll add it in for v2.

Yes, 'device' isn't the best of names, but I took Russell's patch
almost as-is, I didn't have any better ideas for bikeshedding.

>=20
> That should help us to really move forward with all this.
> -Daniel
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
> > index c0a2286a81e9..d6d9d5301551 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -402,6 +402,10 @@ struct drm_bridge {
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



