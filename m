Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC2F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TFn0zfb0";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TFn0zfb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLJR2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:28:19 -0500
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:15938
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbfLJR2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XO9FqGc6EhQqGVQa+EOcQ6ucIotbgttEtouJX6wz8=;
 b=TFn0zfb0jEgLmrnZ8q26669RPBEuLV2wMwy7OkLw4FYD5DDNb5zu2hSy/aPBc2XFwV8gLDoboLvRw4Ny95H9o1VMLnSDciZQf16EHMeBQQFm1A25r8mw6oF+Cqvg/UzMn9AEz3y2A0+LHO/ICxi+IhXOKc5I9V9XGdyX27lP2vY=
Received: from VI1PR0802CA0033.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::19) by AM6PR08MB3752.eurprd08.prod.outlook.com
 (2603:10a6:20b:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Tue, 10 Dec
 2019 17:28:15 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0802CA0033.outlook.office365.com
 (2603:10a6:800:a9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Tue, 10 Dec 2019 17:28:15 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT017.mail.protection.outlook.com (10.152.20.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 10 Dec 2019 17:28:14 +0000
Received: ("Tessian outbound 45a30426f8e4:v37"); Tue, 10 Dec 2019 17:28:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b5729deecd66b141
X-CR-MTA-TID: 64aa7808
Received: from b4241bf44f5d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A548F763-10C0-4918-9B96-8C27EAC6C6C6.1;
        Tue, 10 Dec 2019 17:28:09 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b4241bf44f5d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Dec 2019 17:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9pufVfUYdQN/e7hXahY0Oz84IZh4ENO/8N/b+/TKIvzfrYqXHxIc3/BkJspyMAvIdd6aeP1mJJLeLLGXALzsbptoqjO4uN+/D9IZ7tVJGkstjbbAvwKGbPJw0yXPU4UhHEoprv+41jUp3nofm79svLyh6VeaiWVAuVeHacAOq1Ru/RzmatwGc6NF0HlbfwL11WWufKr5qq/aOBaoIiHOAks0mCC8LwGzU5fZ/L7Ep2cLuLfHhVyIzoMnyAncC4yQaOv1q3kMZ509/53wjHHe/wz/SJ0QSf0EAu+JhyH/DA61ZpGSsnZajF7428qNbXeeGgRImfuCQjITeNXxcTXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XO9FqGc6EhQqGVQa+EOcQ6ucIotbgttEtouJX6wz8=;
 b=I9CHGAHKILsSR/Y10PmWh7wnKTDCrGHwCY/+r0nba4I2A/iisRM/rFeqNt5JqB87v+ct2gMtW39BpRwcCCK4eYO3Jqe3K3sT5rLw+okthQBR/zTHxx/iRd39Vo3e35LKBinW7vHy9RLAkC7Ru5S9LhXxtN0JwEfEP0grAeDJQzrsib5p0q/EJwbVXmWsYENdfvcHq80nnErlgxsF6Ea8jGEc55e1j+lSbBIjB8njuECJnrl1B1Yl6eHGIIr8BNJBIfvKqmmZ7gUsKN8d3/lYDXOSeaHQDNJayf05fdsTaC85u+hD1M+nSwyiI7pVBIdH+VCwRQD2ZFTgkMwAKU13KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XO9FqGc6EhQqGVQa+EOcQ6ucIotbgttEtouJX6wz8=;
 b=TFn0zfb0jEgLmrnZ8q26669RPBEuLV2wMwy7OkLw4FYD5DDNb5zu2hSy/aPBc2XFwV8gLDoboLvRw4Ny95H9o1VMLnSDciZQf16EHMeBQQFm1A25r8mw6oF+Cqvg/UzMn9AEz3y2A0+LHO/ICxi+IhXOKc5I9V9XGdyX27lP2vY=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3247.eurprd08.prod.outlook.com (52.134.30.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 17:28:07 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:28:07 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Walleij <linux.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: panel: export drm_panel_bridge_connector
Thread-Topic: [PATCH] drm/bridge: panel: export drm_panel_bridge_connector
Thread-Index: AQHVr2juqWlk00ywj0COPSlRR1t0m6ezjmqAgAARIIA=
Date:   Tue, 10 Dec 2019 17:28:07 +0000
Message-ID: <2826541.zeyClDNUlX@e123338-lin>
References: <20191207140353.23967-5-sam@ravnborg.org>
 <20191210144834.27491-1-mihail.atanassov@arm.com>
 <20191210162647.GA5211@pendragon.ideasonboard.com>
In-Reply-To: <20191210162647.GA5211@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LNXP265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::30) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f6faf25-a2c6-4607-4823-08d77d9656b1
X-MS-TrafficTypeDiagnostic: VI1PR08MB3247:|AM6PR08MB3752:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3752BEDB440949355E9855048F5B0@AM6PR08MB3752.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 02475B2A01
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(316002)(71200400001)(26005)(8676002)(6506007)(6486002)(33716001)(66556008)(66446008)(86362001)(478600001)(81156014)(54906003)(81166006)(4326008)(64756008)(52116002)(5660300002)(110136005)(8936002)(6512007)(7416002)(66946007)(186003)(9686003)(2906002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3247;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tNXagoSMVyHtq06mvEAOrj3JY0bVVcNeqLDTDE3VZo2g+tFcmNOPRpgvAYACgHH/jOhPTm123RZl1c5zMVP3UWVxCzIzVPwYAI9bKtkphzHBvnL/YacvfVpo6TOh7IvcMlRY+EfzstVFlRhbCXxB16Uy9IYee9Me2L0U6V1Qde3+8doZLGoqX4awaLkweWSrbZt65f04f86gR7Xsn3PcAuW0g0/TRMMt+e7gc/E7WtBjUAaO3Rezmet3s6RNS+cK43lhU67lKP23iAshXi0WRokvXWXK9jrDsc8TSzWlH9G1izKzdfgyRgGv0a/ZbCzf1D9uGozseFXgEIXiR/4QMTWIk5cASDJssOtN5uHiLx0E3ghQ4iot1tNiTfVfDe/zfrkjSC9buo24XApUlJeA/BBL13sTVZmpAUaBJfnYKoFs4mnfhpkhxKBxWT+nXiWZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4DDAF795D42F04ABBEE14B3EAB0B754@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3247
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(33716001)(356004)(76130400001)(6512007)(9686003)(26826003)(336012)(6486002)(70206006)(70586007)(110136005)(54906003)(8936002)(5660300002)(316002)(2906002)(478600001)(6506007)(186003)(4326008)(26005)(8676002)(86362001)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3752;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: abc1e8ca-286c-42e4-8820-08d77d965242
NoDisclaimer: True
X-Forefront-PRVS: 02475B2A01
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyhV73MaqrcY6CUNS+CXd6CH6ZKfuZU0fBZiyAc8DYmAte5fBpqCMJZCCC0zy3XWsbDd+fViHIOB7sT8N1wmAmU9NGraLN7Puch5VFIPmKoXIhjgYkx6AqfJj1v7jNNL/YXEmkUvxpspmamhhW+kf1eHugtp0Z6yiX5urOGg9dYSa2GQlKZF8dsMbbFGw8QwkYZdSKJuFY+Se4GNS6AV2lfOnZpwJ+JlOiS//ahV3w4/xORdF35pBXe6Ai0lcYwK+pTHzqJbBb6sF2p+rvpwx50yS+vnNcY6Pj0jmfpL6aBfBOZ3KXdHsgRBaDLo3j0yJSLCBbByJMOf5SGK3vwo0vQt+bCQu8ktq30QygIAx0C/U2i7sZnFfivK5JJ992Dyv02s7Jsijc4T9kgVip7D5qG9qRzoCWwjQUg5nxuuAVduEsPmjh1xgL5/My7OZtMv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 17:28:14.8469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6faf25-a2c6-4607-4823-08d77d9656b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 10 December 2019 16:26:47 GMT Laurent Pinchart wrote:
> Hi Mihail,
>=20
> Thank you for the patch.
>=20
> On Tue, Dec 10, 2019 at 02:48:49PM +0000, Mihail Atanassov wrote:
> > The function was unexported and was causing link failures for pl111 (an=
d
> > probably the other user tve200) in a module build.
> >=20
> > Fixes: d383fb5f8add ("drm: get drm_bridge_panel connector via helper")
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Linux Walleij <linux.walleij@linaro.org>
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20

Thanks, applied to drm-misc-next.

> > ---
> >  drivers/gpu/drm/bridge/panel.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pa=
nel.c
> > index 1443897f999b..f66777e24968 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -306,3 +306,4 @@ struct drm_connector *drm_panel_bridge_connector(st=
ruct drm_bridge *bridge)
> > =20
> >  	return &panel_bridge->connector;
> >  }
> > +EXPORT_SYMBOL(drm_panel_bridge_connector);
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20


--=20
Mihail



