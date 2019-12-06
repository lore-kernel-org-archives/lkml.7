Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B3FC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327B206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JFNs+AnP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JFNs+AnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFLZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:25:59 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:9030
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbfLFLZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4l55pUyOAXuY2cen35wYBWiUE46tQGOPLaBiaj5Ueg=;
 b=JFNs+AnPAsnT+b7YgEmsDqJd2dD77gbM9R0XrifcT3Qtx3ox+KWc0kMTcyCfMhxRKdf7SStupmW1MuOcAmKSBz8LW6ZOwfTJZ+5Z99xmtnR/knllIvm8Qz0k04emzpOxagSe/4asLicPVkwsmTa+cqigAGa4HntCNyfyeZ6CGrc=
Received: from VI1PR08CA0097.eurprd08.prod.outlook.com (2603:10a6:800:d3::23)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Fri, 6 Dec
 2019 11:25:49 +0000
Received: from AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by VI1PR08CA0097.outlook.office365.com
 (2603:10a6:800:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.15 via Frontend
 Transport; Fri, 6 Dec 2019 11:25:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT050.mail.protection.outlook.com (10.152.17.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Fri, 6 Dec 2019 11:25:49 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Fri, 06 Dec 2019 11:25:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2752da43eb2202ad
X-CR-MTA-TID: 64aa7808
Received: from f69a5100e271.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D3F66049-35D0-499B-A384-8E0358DCFF2E.1;
        Fri, 06 Dec 2019 11:25:43 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f69a5100e271.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 06 Dec 2019 11:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZnA5n1HbEdlzG8DR5Zy+8G4vwAtcxU7Jkuwod1zAaHgjgmRmn6SaY/U/jByQsu2IUA35A38TFxvrrgRmaf/nae3D6jOqeS+6985NyfprNCl5ymLO5+YXzk11uUOno6LHpYwU2G91AXbvnRFma4h+mT/4rQA/m4BmF8ccXwLY0QWFU1LUerhHgpQqvlB/9dknHv6vaExsV84/pRHf2jdVHkW5FuwfaJYZSL+qalCejknlp9triPl8ND9rgIeCBMvZfe5M54vNenoHXvZl37/WuF4Ds0MUBdAA1840zpinC6ko35gKFsuMCXhrJB2PGjhbvXllvmz1U98bk+lFQXoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4l55pUyOAXuY2cen35wYBWiUE46tQGOPLaBiaj5Ueg=;
 b=iZhuK2Ct0H6TCvPqbJPEGLmK0s4eD6lYN0IjIpynxxitcuOcKQINSqpk9ThWXn4lHYereFDmtDnnOVGlAB2AD9W9mgIBflfHjdUrIcZQGqYe5y88qz3igzX/Wwch8fof4CW4V0vAt73ncCSAhGjEBpPBg4GljKVtUczKR31XZf6xbJKOrecyUpD7LkXl/dQGS/2bdSf0uQgGLEV+fmJm9BoI7/aGuQoBc8tLettibNuHwAGdeduWArFdRifhzWMQ2SOV4zInb7vrpj8kzElvvDHG2BUWwBHvlxqjwcnCCN3kknc3e+BjqQFwPZtewRah3zov9vXXiPdHEqn0fdr89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4l55pUyOAXuY2cen35wYBWiUE46tQGOPLaBiaj5Ueg=;
 b=JFNs+AnPAsnT+b7YgEmsDqJd2dD77gbM9R0XrifcT3Qtx3ox+KWc0kMTcyCfMhxRKdf7SStupmW1MuOcAmKSBz8LW6ZOwfTJZ+5Z99xmtnR/knllIvm8Qz0k04emzpOxagSe/4asLicPVkwsmTa+cqigAGa4HntCNyfyeZ6CGrc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3503.eurprd08.prod.outlook.com (20.177.58.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 11:25:40 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 11:25:40 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Topic: [PATCH] drm: Rename drm_bridge->dev to drm
Thread-Index: AQHVq4lXPN/wPtLXyE2pxOrtyWLc3Ker2ioAgAEef4A=
Date:   Fri, 6 Dec 2019 11:25:40 +0000
Message-ID: <2561507.RTQXCEk2uY@e123338-lin>
References: <20191205163028.19941-1-mihail.atanassov@arm.com>
 <e73974c0-19ae-1592-ed37-26f386f37a2f@suse.de>
In-Reply-To: <e73974c0-19ae-1592-ed37-26f386f37a2f@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3074539-36a1-49a6-a8b9-08d77a3f0b8f
X-MS-TrafficTypeDiagnostic: VI1PR08MB3503:|AM6PR08MB4849:
X-Microsoft-Antispam-PRVS: <AM6PR08MB48496C878A56B675DAB9F9628F5F0@AM6PR08MB4849.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;OLM:2887;
x-forefront-prvs: 0243E5FD68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(316002)(30864003)(8936002)(8676002)(81166006)(81156014)(54906003)(110136005)(4326008)(99286004)(478600001)(52116002)(2906002)(25786009)(76176011)(11346002)(229853002)(33716001)(305945005)(9686003)(14454004)(102836004)(71190400001)(6512007)(6506007)(71200400001)(966005)(6486002)(186003)(5660300002)(86362001)(66476007)(66556008)(66446008)(64756008)(26005)(66946007)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3503;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ov1E2qkaiij850vk7SldFO1s2WE4UpG4ixjDyBWWVQGkBwCTX1tuJGEdPrrBy1ZiMppZJJARYmDLy7xScWfcWa9ASQg5KqUzD/kPsQcQcnNjubc7is57fL3gEqF3vZqd8/oFgwmDdpgJnKB6CArE3wkREx0nZynIrn8PfjqiV275W4Urjj5i7pojTkGsBFYFro0h8v13FAfvuZ/MPhdS82Q9Gl/91M5DJ9aXpyGUxBWOGjU4iolJfLU59leCeN+DCoGQWmuVuaVyahbKucyeH7elDPHpxR3OntnzlzhyQ3SWx3P7jYBnnk6d22y/TbQbVCYNVbRLfgv6ghJ8zHRlt9y6tVtEx+w8bbIbob83xLonw/oHhXdBKheCd5i4pSj6wieRSxHc3vezKP0g/aNW5qiB6xGUL7GyaTAWS6+kEt3kcNSTeJFjBy9AeleRTVGUIDmEx1t16GkK5bPAYau8vY2roP1FymgoHyWYoArCsXoTem5jixERVmECUYhJrfopSfVqJ7I4eVcpe0YtMWaThi6pcZF9tnNOFCdQMJOSJ3w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E7443FFB015DD4387DDA2FE7327FA65@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3503
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(8936002)(81166006)(81156014)(14454004)(6512007)(186003)(97756001)(70206006)(5660300002)(8676002)(76130400001)(9686003)(30864003)(26826003)(86362001)(305945005)(36906005)(76176011)(316002)(336012)(966005)(11346002)(26005)(6506007)(110136005)(102836004)(99286004)(478600001)(54906003)(33716001)(25786009)(4326008)(46406003)(356004)(50466002)(6486002)(70586007)(229853002)(2906002)(23726003)(22756006)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4849;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e7249e1a-eeb1-4ebd-4eff-08d77a3f0640
NoDisclaimer: True
X-Forefront-PRVS: 0243E5FD68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSg3NWkqXRAYBktdRknMROjeeF5hBMF9A3peWBAMUvJGxKnP3DDY5et3tSdGXlWCpSm+1F5ue08QKugWXJKdUB2JyAxg4Uzawxet1CyHZe5wgUjmUi3KOsAukHGrUDJ+Y9XatHo4oAT5by7xCn1EGfCCCpY3u2ESdwlvNCHJ6j6myzY0Uvhl72ye3R/vlcZR6lJ4P8BCvgrOZczIe4fnl3umliK7tnlQH1IwDb5twXHyG6G6BzhzcxSaoi35U02w44vx7Kju4Hteyr6BayLX8uGxOjn1HoiXIrnBiVLrz9eiwi/OXhdF4Hkyxuk99PewNAPGJ14Uiq7OyA2Ly87lg0wbOW56ajZiTOm8iw480v16waMjWluOCfQAciAqGXepJ3BH9+uClOyDlkkn6CmoNR/nD6s96il3AUtidkfvhxDiG4JrPWK7LscqasVRK2P0D8AuefY0WEXo6SRA0TLlP1S2tajyK+O6FwZnQfImOUTvLfur+t7R39pZrn+sRAwL1O9UZptj2XldbzNG9+OJDl5Ph6KvYkLHfKttpNp96hk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 11:25:49.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3074539-36a1-49a6-a8b9-08d77a3f0b8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Thomas,

On Thursday, 5 December 2019 18:20:06 GMT Thomas Zimmermann wrote:
> Hi
>=20
> Am 05.12.19 um 17:30 schrieb Mihail Atanassov:
> > The 'dev' name causes some confusion with 'struct device' [1][2], so us=
e
> > 'drm' instead since this seems to be the prevalent name for 'struct
> > drm_device' members.
> >=20
> > [1] https://patchwork.freedesktop.org/patch/342472/?series=3D70039&rev=
=3D1
> > [2] https://patchwork.freedesktop.org/patch/343643/?series=3D70432&rev=
=3D1
>=20
> I read through the provided links, but can't see why is it called 'drm'.
> That sounds like a reference to a DRM driver structure to me.

There are about 550 hits on 'struct drm_device *drm', so I gathered that
it's the most common alternative to just naming it 'dev' (at about 4.5k
hits in the codebase). There's also 'ddev', 'drm_dev', 'drmdev' with
few hits.

>=20
> What about attached_dev or consumer_dev or encoder_dev?

Those would be more descriptive, if you think it's worth sidestepping
the above convention a bit. I don't mind either way.

>=20
> Best regards
> Thomas
>=20
> >=20
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |  2 +-
> >  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c   |  2 +-
> >  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c   |  2 +-
> >  drivers/gpu/drm/bridge/cdns-dsi.c                    |  2 +-
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c                |  2 +-
> >  .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c |  2 +-
> >  drivers/gpu/drm/bridge/nxp-ptn3460.c                 |  2 +-
> >  drivers/gpu/drm/bridge/panel.c                       |  2 +-
> >  drivers/gpu/drm/bridge/parade-ps8622.c               |  2 +-
> >  drivers/gpu/drm/bridge/sii902x.c                     |  6 +++---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c            |  6 +++---
> >  drivers/gpu/drm/bridge/tc358764.c                    |  4 ++--
> >  drivers/gpu/drm/bridge/tc358767.c                    |  6 +++---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c                |  2 +-
> >  drivers/gpu/drm/bridge/ti-tfp410.c                   |  6 +++---
> >  drivers/gpu/drm/drm_bridge.c                         | 12 ++++++------
> >  drivers/gpu/drm/i2c/tda998x_drv.c                    |  2 +-
> >  drivers/gpu/drm/mcde/mcde_dsi.c                      |  2 +-
> >  drivers/gpu/drm/msm/edp/edp_bridge.c                 |  2 +-
> >  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c               |  4 ++--
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c                  |  2 +-
> >  include/drm/drm_bridge.h                             |  4 ++--
> >  22 files changed, 38 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index 9e13e466e72c..db7d01cb0923 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -863,7 +863,7 @@ static int adv7511_bridge_attach(struct drm_bridge =
*bridge)
> >  		adv->connector.polled =3D DRM_CONNECTOR_POLL_CONNECT |
> >  				DRM_CONNECTOR_POLL_DISCONNECT;
> > =20
> > -	ret =3D drm_connector_init(bridge->dev, &adv->connector,
> > +	ret =3D drm_connector_init(bridge->drm, &adv->connector,
> >  				 &adv7511_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_HDMIA);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drive=
rs/gpu/drm/bridge/analogix/analogix-anx6345.c
> > index b4f3a923a52a..0e3508aeaa6c 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > @@ -541,7 +541,7 @@ static int anx6345_bridge_attach(struct drm_bridge =
*bridge)
> >  		return err;
> >  	}
> > =20
> > -	err =3D drm_connector_init(bridge->dev, &anx6345->connector,
> > +	err =3D drm_connector_init(bridge->drm, &anx6345->connector,
> >  				 &anx6345_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_eDP);
> >  	if (err) {
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drive=
rs/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > index 41867be03751..d5722bc28933 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> > @@ -908,7 +908,7 @@ static int anx78xx_bridge_attach(struct drm_bridge =
*bridge)
> >  		return err;
> >  	}
> > =20
> > -	err =3D drm_connector_init(bridge->dev, &anx78xx->connector,
> > +	err =3D drm_connector_init(bridge->drm, &anx78xx->connector,
> >  				 &anx78xx_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_DisplayPort);
> >  	if (err) {
> > diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge=
/cdns-dsi.c
> > index 3a5bd4e7fd1e..f6d7e97de66e 100644
> > --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> > +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> > @@ -651,7 +651,7 @@ static int cdns_dsi_bridge_attach(struct drm_bridge=
 *bridge)
> >  	struct cdns_dsi *dsi =3D input_to_dsi(input);
> >  	struct cdns_dsi_output *output =3D &dsi->output;
> > =20
> > -	if (!drm_core_check_feature(bridge->dev, DRIVER_ATOMIC)) {
> > +	if (!drm_core_check_feature(bridge->drm, DRIVER_ATOMIC)) {
> >  		dev_err(dsi->base.dev,
> >  			"cdns-dsi driver is only compatible with DRM devices supporting ato=
mic updates");
> >  		return -ENOTSUPP;
> > diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/br=
idge/dumb-vga-dac.c
> > index cc33dc411b9e..30b5e54df381 100644
> > --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> > @@ -112,7 +112,7 @@ static int dumb_vga_attach(struct drm_bridge *bridg=
e)
> > =20
> >  	drm_connector_helper_add(&vga->connector,
> >  				 &dumb_vga_con_helper_funcs);
> > -	ret =3D drm_connector_init_with_ddc(bridge->dev, &vga->connector,
> > +	ret =3D drm_connector_init_with_ddc(bridge->drm, &vga->connector,
> >  					  &dumb_vga_con_funcs,
> >  					  DRM_MODE_CONNECTOR_VGA,
> >  					  vga->ddc);
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b=
/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index e8a49f6146c6..ab06394cfff7 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -223,7 +223,7 @@ static int ge_b850v3_lvds_attach(struct drm_bridge =
*bridge)
> >  	drm_connector_helper_add(connector,
> >  				 &ge_b850v3_lvds_connector_helper_funcs);
> > =20
> > -	ret =3D drm_connector_init(bridge->dev, connector,
> > +	ret =3D drm_connector_init(bridge->drm, connector,
> >  				 &ge_b850v3_lvds_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_DisplayPort);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bri=
dge/nxp-ptn3460.c
> > index 57ff01339559..714cb954522a 100644
> > --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > @@ -247,7 +247,7 @@ static int ptn3460_bridge_attach(struct drm_bridge =
*bridge)
> >  	}
> > =20
> >  	ptn_bridge->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > -	ret =3D drm_connector_init(bridge->dev, &ptn_bridge->connector,
> > +	ret =3D drm_connector_init(bridge->drm, &ptn_bridge->connector,
> >  			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> >  	if (ret) {
> >  		DRM_ERROR("Failed to initialize connector with drm\n");
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pa=
nel.c
> > index f4e293e7cf64..7ed3b3e85f03 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -67,7 +67,7 @@ static int panel_bridge_attach(struct drm_bridge *bri=
dge)
> >  	drm_connector_helper_add(connector,
> >  				 &panel_bridge_connector_helper_funcs);
> > =20
> > -	ret =3D drm_connector_init(bridge->dev, connector,
> > +	ret =3D drm_connector_init(bridge->drm, connector,
> >  				 &panel_bridge_connector_funcs,
> >  				 panel_bridge->connector_type);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/b=
ridge/parade-ps8622.c
> > index b7a72dfdcac3..18cc693734b3 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> > @@ -487,7 +487,7 @@ static int ps8622_attach(struct drm_bridge *bridge)
> >  	}
> > =20
> >  	ps8622->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > -	ret =3D drm_connector_init(bridge->dev, &ps8622->connector,
> > +	ret =3D drm_connector_init(bridge->drm, &ps8622->connector,
> >  			&ps8622_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> >  	if (ret) {
> >  		DRM_ERROR("Failed to initialize connector with drm\n");
> > diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/=
sii902x.c
> > index b70e8c5cf2e1..3d8b3e1eb0aa 100644
> > --- a/drivers/gpu/drm/bridge/sii902x.c
> > +++ b/drivers/gpu/drm/bridge/sii902x.c
> > @@ -402,7 +402,7 @@ static void sii902x_bridge_mode_set(struct drm_brid=
ge *bridge,
> >  static int sii902x_bridge_attach(struct drm_bridge *bridge)
> >  {
> >  	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> > -	struct drm_device *drm =3D bridge->dev;
> > +	struct drm_device *drm =3D bridge->drm;
> >  	int ret;
> > =20
> >  	drm_connector_helper_add(&sii902x->connector,
> > @@ -820,8 +820,8 @@ static irqreturn_t sii902x_interrupt(int irq, void =
*data)
> > =20
> >  	mutex_unlock(&sii902x->mutex);
> > =20
> > -	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.dev)
> > -		drm_helper_hpd_irq_event(sii902x->bridge.dev);
> > +	if ((status & SII902X_HOTPLUG_EVENT) && sii902x->bridge.drm)
> > +		drm_helper_hpd_irq_event(sii902x->bridge.drm);
> > =20
> >  	return IRQ_HANDLED;
> >  }
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi.c
> > index dbe38a54870b..7a549cce8536 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -2346,7 +2346,7 @@ static int dw_hdmi_bridge_attach(struct drm_bridg=
e *bridge)
> > =20
> >  	drm_connector_helper_add(connector, &dw_hdmi_connector_helper_funcs);
> > =20
> > -	drm_connector_init_with_ddc(bridge->dev, connector,
> > +	drm_connector_init_with_ddc(bridge->drm, connector,
> >  				    &dw_hdmi_connector_funcs,
> >  				    DRM_MODE_CONNECTOR_HDMIA,
> >  				    hdmi->ddc);
> > @@ -2554,8 +2554,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev=
_id)
> >  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> >  		dev_dbg(hdmi->dev, "EVENT=3D%s\n",
> >  			phy_int_pol & HDMI_PHY_HPD ? "plugin" : "plugout");
> > -		if (hdmi->bridge.dev)
> > -			drm_helper_hpd_irq_event(hdmi->bridge.dev);
> > +		if (hdmi->bridge.drm)
> > +			drm_helper_hpd_irq_event(hdmi->bridge.drm);
> >  	}
> > =20
> >  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> > diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge=
/tc358764.c
> > index db298f550a5a..1744d7daa534 100644
> > --- a/drivers/gpu/drm/bridge/tc358764.c
> > +++ b/drivers/gpu/drm/bridge/tc358764.c
> > @@ -352,7 +352,7 @@ static void tc358764_enable(struct drm_bridge *brid=
ge)
> >  static int tc358764_attach(struct drm_bridge *bridge)
> >  {
> >  	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
> > -	struct drm_device *drm =3D bridge->dev;
> > +	struct drm_device *drm =3D bridge->drm;
> >  	int ret;
> > =20
> >  	ctx->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > @@ -378,7 +378,7 @@ static int tc358764_attach(struct drm_bridge *bridg=
e)
> >  static void tc358764_detach(struct drm_bridge *bridge)
> >  {
> >  	struct tc358764 *ctx =3D bridge_to_tc358764(bridge);
> > -	struct drm_device *drm =3D bridge->dev;
> > +	struct drm_device *drm =3D bridge->drm;
> > =20
> >  	drm_connector_unregister(&ctx->connector);
> >  	drm_fb_helper_remove_one_connector(drm->fb_helper, &ctx->connector);
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge=
/tc358767.c
> > index 8029478ffebb..fccacd12bb53 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -1407,7 +1407,7 @@ static int tc_bridge_attach(struct drm_bridge *br=
idge)
> >  {
> >  	u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> >  	struct tc_data *tc =3D bridge_to_tc(bridge);
> > -	struct drm_device *drm =3D bridge->dev;
> > +	struct drm_device *drm =3D bridge->drm;
> >  	int ret;
> > =20
> >  	/* Create DP/eDP connector */
> > @@ -1514,7 +1514,7 @@ static irqreturn_t tc_irq_handler(int irq, void *=
arg)
> >  		dev_err(tc->dev, "syserr %x\n", stat);
> >  	}
> > =20
> > -	if (tc->hpd_pin >=3D 0 && tc->bridge.dev) {
> > +	if (tc->hpd_pin >=3D 0 && tc->bridge.drm) {
> >  		/*
> >  		 * H is triggered when the GPIO goes high.
> >  		 *
> > @@ -1528,7 +1528,7 @@ static irqreturn_t tc_irq_handler(int irq, void *=
arg)
> >  			h ? "H" : "", lc ? "LC" : "");
> > =20
> >  		if (h || lc)
> > -			drm_kms_helper_hotplug_event(tc->bridge.dev);
> > +			drm_kms_helper_hotplug_event(tc->bridge.drm);
> >  	}
> > =20
> >  	regmap_write(tc->regmap, INTSTS_G, val);
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 43abf01ebd4c..23576c3fac9f 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -275,7 +275,7 @@ static int ti_sn_bridge_attach(struct drm_bridge *b=
ridge)
> >  						   .node =3D NULL,
> >  						 };
> > =20
> > -	ret =3D drm_connector_init(bridge->dev, &pdata->connector,
> > +	ret =3D drm_connector_init(bridge->drm, &pdata->connector,
> >  				 &ti_sn_bridge_connector_funcs,
> >  				 DRM_MODE_CONNECTOR_eDP);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridg=
e/ti-tfp410.c
> > index aa3198dc9903..cae9fd584ff1 100644
> > --- a/drivers/gpu/drm/bridge/ti-tfp410.c
> > +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
> > @@ -135,7 +135,7 @@ static int tfp410_attach(struct drm_bridge *bridge)
> > =20
> >  	drm_connector_helper_add(&dvi->connector,
> >  				 &tfp410_con_helper_funcs);
> > -	ret =3D drm_connector_init_with_ddc(bridge->dev, &dvi->connector,
> > +	ret =3D drm_connector_init_with_ddc(bridge->drm, &dvi->connector,
> >  					  &tfp410_con_funcs,
> >  					  dvi->connector_type,
> >  					  dvi->ddc);
> > @@ -179,8 +179,8 @@ static void tfp410_hpd_work_func(struct work_struct=
 *work)
> > =20
> >  	dvi =3D container_of(work, struct tfp410, hpd_work.work);
> > =20
> > -	if (dvi->bridge.dev)
> > -		drm_helper_hpd_irq_event(dvi->bridge.dev);
> > +	if (dvi->bridge.drm)
> > +		drm_helper_hpd_irq_event(dvi->bridge.drm);
> >  }
> > =20
> >  static irqreturn_t tfp410_hpd_irq_thread(int irq, void *arg)
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index cba537c99e43..80f7a1aa969e 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -119,19 +119,19 @@ int drm_bridge_attach(struct drm_encoder *encoder=
, struct drm_bridge *bridge,
> >  	if (!encoder || !bridge)
> >  		return -EINVAL;
> > =20
> > -	if (previous && (!previous->dev || previous->encoder !=3D encoder))
> > +	if (previous && (!previous->drm || previous->encoder !=3D encoder))
> >  		return -EINVAL;
> > =20
> > -	if (bridge->dev)
> > +	if (bridge->drm)
> >  		return -EBUSY;
> > =20
> > -	bridge->dev =3D encoder->dev;
> > +	bridge->drm =3D encoder->dev;
> >  	bridge->encoder =3D encoder;
> > =20
> >  	if (bridge->funcs->attach) {
> >  		ret =3D bridge->funcs->attach(bridge);
> >  		if (ret < 0) {
> > -			bridge->dev =3D NULL;
> > +			bridge->drm =3D NULL;
> >  			bridge->encoder =3D NULL;
> >  			return ret;
> >  		}
> > @@ -151,13 +151,13 @@ void drm_bridge_detach(struct drm_bridge *bridge)
> >  	if (WARN_ON(!bridge))
> >  		return;
> > =20
> > -	if (WARN_ON(!bridge->dev))
> > +	if (WARN_ON(!bridge->drm))
> >  		return;
> > =20
> >  	if (bridge->funcs->detach)
> >  		bridge->funcs->detach(bridge);
> > =20
> > -	bridge->dev =3D NULL;
> > +	bridge->drm =3D NULL;
> >  }
> > =20
> >  /**
> > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/td=
a998x_drv.c
> > index a63790d32d75..fa430e43f5ad 100644
> > --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> > +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> > @@ -1360,7 +1360,7 @@ static int tda998x_bridge_attach(struct drm_bridg=
e *bridge)
> >  {
> >  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
> > =20
> > -	return tda998x_connector_init(priv, bridge->dev);
> > +	return tda998x_connector_init(priv, bridge->drm);
> >  }
> > =20
> >  static void tda998x_bridge_detach(struct drm_bridge *bridge)
> > diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcd=
e_dsi.c
> > index 42fff811653e..4ef14d5cdcb6 100644
> > --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> > +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> > @@ -846,7 +846,7 @@ static void mcde_dsi_bridge_disable(struct drm_brid=
ge *bridge)
> >  static int mcde_dsi_bridge_attach(struct drm_bridge *bridge)
> >  {
> >  	struct mcde_dsi *d =3D bridge_to_mcde_dsi(bridge);
> > -	struct drm_device *drm =3D bridge->dev;
> > +	struct drm_device *drm =3D bridge->drm;
> >  	int ret;
> > =20
> >  	if (!drm_core_check_feature(drm, DRIVER_ATOMIC)) {
> > diff --git a/drivers/gpu/drm/msm/edp/edp_bridge.c b/drivers/gpu/drm/msm=
/edp/edp_bridge.c
> > index 2950bba4aca9..a329c7a79d8d 100644
> > --- a/drivers/gpu/drm/msm/edp/edp_bridge.c
> > +++ b/drivers/gpu/drm/msm/edp/edp_bridge.c
> > @@ -47,7 +47,7 @@ static void edp_bridge_mode_set(struct drm_bridge *br=
idge,
> >  		const struct drm_display_mode *mode,
> >  		const struct drm_display_mode *adjusted_mode)
> >  {
> > -	struct drm_device *dev =3D bridge->dev;
> > +	struct drm_device *dev =3D bridge->drm;
> >  	struct drm_connector *connector;
> >  	struct edp_bridge *edp_bridge =3D to_edp_bridge(bridge);
> >  	struct msm_edp *edp =3D edp_bridge->edp;
> > diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/m=
sm/hdmi/hdmi_bridge.c
> > index ba81338a9bf8..0add3c88a13e 100644
> > --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> > @@ -20,7 +20,7 @@ void msm_hdmi_bridge_destroy(struct drm_bridge *bridg=
e)
> > =20
> >  static void msm_hdmi_power_on(struct drm_bridge *bridge)
> >  {
> > -	struct drm_device *dev =3D bridge->dev;
> > +	struct drm_device *dev =3D bridge->drm;
> >  	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
> >  	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> >  	const struct hdmi_platform_config *config =3D hdmi->config;
> > @@ -56,7 +56,7 @@ static void msm_hdmi_power_on(struct drm_bridge *brid=
ge)
> > =20
> >  static void power_off(struct drm_bridge *bridge)
> >  {
> > -	struct drm_device *dev =3D bridge->dev;
> > +	struct drm_device *dev =3D bridge->drm;
> >  	struct hdmi_bridge *hdmi_bridge =3D to_hdmi_bridge(bridge);
> >  	struct hdmi *hdmi =3D hdmi_bridge->hdmi;
> >  	const struct hdmi_platform_config *config =3D hdmi->config;
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar=
-du/rcar_lvds.c
> > index 8c6c172bbf2e..12fcfbf31968 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > @@ -622,7 +622,7 @@ static int rcar_lvds_attach(struct drm_bridge *brid=
ge)
> >  	if (!lvds->panel)
> >  		return 0;
> > =20
> > -	ret =3D drm_connector_init(bridge->dev, connector, &rcar_lvds_conn_fu=
ncs,
> > +	ret =3D drm_connector_init(bridge->drm, connector, &rcar_lvds_conn_fu=
ncs,
> >  				 DRM_MODE_CONNECTOR_LVDS);
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index c0a2286a81e9..795860200ebf 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -376,8 +376,8 @@ struct drm_bridge_timings {
> >   * struct drm_bridge - central DRM bridge control structure
> >   */
> >  struct drm_bridge {
> > -	/** @dev: DRM device this bridge belongs to */
> > -	struct drm_device *dev;
> > +	/** @drm: DRM device this bridge belongs to */
> > +	struct drm_device *drm;
> >  	/** @encoder: encoder to which this bridge is connected */
> >  	struct drm_encoder *encoder;
> >  	/** @next: the next bridge in the encoder chain */
> >=20
>=20
>=20


--=20
Mihail



