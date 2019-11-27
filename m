Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06455C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D06206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nPqv5vWx";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nPqv5vWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK0LCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:02:41 -0500
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:65027
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfK0LCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0IXfeC2QSb4WFW6fFjDgR/qYgQgHkshqjOKMDsu8Rg=;
 b=nPqv5vWxuWs6v0VXgFKH+caz5v6ij4AA5Cv1+g2eBQZDhvF2loj3b/XfzKgxkDvE/ZTTztWk6ljLT18RqLN5BGRUlaaCSFKgT51N/aReAwx+nolaQNPD50Y91RD+HHRw7xBuOqpeyAyIfGCAO/o2ZQtaiPFe4RS53DtJe0SVHVo=
Received: from DB6PR0801CA0047.eurprd08.prod.outlook.com (2603:10a6:4:2b::15)
 by HE1PR0802MB2460.eurprd08.prod.outlook.com (2603:10a6:3:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 27 Nov
 2019 11:02:34 +0000
Received: from AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by DB6PR0801CA0047.outlook.office365.com
 (2603:10a6:4:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 27 Nov 2019 11:02:34 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT018.mail.protection.outlook.com (10.152.16.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Wed, 27 Nov 2019 11:02:33 +0000
Received: ("Tessian outbound d825562be5de:v37"); Wed, 27 Nov 2019 11:02:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ab8922ef9b7b23e
X-CR-MTA-TID: 64aa7808
Received: from 588280519612.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B14002F1-33A1-4428-AF03-2AFE274B27D1.1;
        Wed, 27 Nov 2019 11:02:27 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 588280519612.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Nov 2019 11:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP+oA5mOEFuOq3jQHjPwNaUVXy60wWkbMWdW4LXMTgS5owVlMmOz028d4RCS46+UNmfkZRKce5J44lKXfnVSfUeGP9kqsZun08v0i9w/vfF5Z3GL0Tc5Ep6bBj6SpIOvRO2feECAYCxHuoTvFK/lRWewgoqGwZ/rRFhig1XT6Ea9yKA15Fu3Z44u0tGMXVdX1Se4tzrI1wl5ZhxsK6VWNGb5FMoPfbX1SYjvgYpHqwDlU92GmXLIvM/iH+d0fnAWmLVYv4eyxDHp++MngJh/u1xUgK9lOEF4EzHPkCEApIcI/WRoNVKtmsHSTvw0/YqOyzJOIe9N7rnFEBU3Xp4Ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0IXfeC2QSb4WFW6fFjDgR/qYgQgHkshqjOKMDsu8Rg=;
 b=nA2roJkbPPjQMt3VfhCAaKwxcaJG9QBua5MPgYkBEnMqjg8cIOVJ1PdG32OfjQMibMTlNssJ7tpoc+g8yCoDhviO8AKl3pQ13kuL6/mKfjsqw2ZtT9vLaej2CMW4K/tWszIagDtkwGfjubZP1hxQu3UcQML3kAgi/oTZ2nHCRuIIzoY8jHbHRXxxfMBquM5Y/QkxAbapCJLgWwDHXEinm5kZDn1WRmGMsGciAiZ0Cm5qd9H868nk9NsaDZwooObdhkOVw+fCNcknq3njnemEmqimmEYJjBpH7TcZfObkMHfe+utJpsW6MJ5Xz2rnZ9tug5zUcA5Pb/GGHs/IJlzRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0IXfeC2QSb4WFW6fFjDgR/qYgQgHkshqjOKMDsu8Rg=;
 b=nPqv5vWxuWs6v0VXgFKH+caz5v6ij4AA5Cv1+g2eBQZDhvF2loj3b/XfzKgxkDvE/ZTTztWk6ljLT18RqLN5BGRUlaaCSFKgT51N/aReAwx+nolaQNPD50Y91RD+HHRw7xBuOqpeyAyIfGCAO/o2ZQtaiPFe4RS53DtJe0SVHVo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3869.eurprd08.prod.outlook.com (20.178.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 11:02:25 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 11:02:25 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Thread-Topic: [PATCH 28/30] drm/sti: sti_vdo: Use drm_bridge_init()
Thread-Index: AQHVpFu0SLTgMcz7kE2lTsCMHso8OKed2TYAgAEB5wA=
Date:   Wed, 27 Nov 2019 11:02:25 +0000
Message-ID: <2161383.jsAorMfJJG@e123338-lin>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-29-mihail.atanassov@arm.com>
 <20191126193740.GC2044@ravnborg.org>
In-Reply-To: <20191126193740.GC2044@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: CWLP265CA0335.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8963e55-d6db-439c-b196-08d773294e40
X-MS-TrafficTypeDiagnostic: VI1PR08MB3869:|HE1PR0802MB2460:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB246056A7446EBBF08D2EA8C28F440@HE1PR0802MB2460.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 023495660C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(189003)(199004)(54094003)(6506007)(8936002)(81156014)(81166006)(386003)(14454004)(33716001)(478600001)(8676002)(4326008)(52116002)(305945005)(7736002)(54906003)(6916009)(316002)(6246003)(9686003)(6512007)(66066001)(3846002)(6116002)(26005)(6486002)(6436002)(2906002)(102836004)(186003)(5660300002)(25786009)(86362001)(229853002)(76176011)(66476007)(66556008)(64756008)(11346002)(66946007)(99286004)(446003)(71200400001)(71190400001)(5024004)(66446008)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3869;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: O1ScmptpU1u30QscNVg5ebSvJmHGuS7cNJ37WlhTgMmqQGcTR95AkyxNbpckAJqt0xOr5zGiAYPwmSjg0xiyX2utiLz6CRN8njX2GcwkZONPSmG19mElC91UWXnxTOE88cuAnDfl+UJ4yvpCEJyxUXo6rJURQfX/nEYKsio+PVQZxNrDHGTorCzlHA/n6CjXNqXmp/9FBqogIWIaq41M8K/BpTyBzt3Hs2jn9lwfXMLtynHqLogGx4692vb4hWK/vWGIFBiB2HbnUT7SWDfMoG0+BnLQGdoy2ul6j06hKEcQWQkZ0pqzfuHQF1WfnVHp456F/z+j9WIMGogfy5sBfVsAm3mA7HpYhtcwmenFzrnAs0bNLcmSOJXh1qXaa0K/pioAnoslKK8gjtKPC5DqUJ71kBi3P11HeKirDcEE5zuB0BBZL9n7PikU5Qgm7lzU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68E396DCF527A84CB98494944641874A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3869
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(54094003)(189003)(199004)(356004)(2906002)(8676002)(6486002)(6246003)(478600001)(14454004)(6506007)(386003)(76176011)(102836004)(5660300002)(86362001)(8936002)(54906003)(33716001)(36906005)(3846002)(6116002)(26826003)(76130400001)(6862004)(4326008)(81156014)(81166006)(70206006)(70586007)(23726003)(50466002)(25786009)(316002)(97756001)(8746002)(5024004)(106002)(66066001)(6512007)(305945005)(7736002)(47776003)(446003)(229853002)(186003)(336012)(26005)(9686003)(11346002)(22756006)(46406003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2460;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b6394968-c45e-4ec2-d79e-08d7732948d9
NoDisclaimer: True
X-Forefront-PRVS: 023495660C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXQeXIw+12DfWO6tI+ZG9IR9pcCUIi0joxxLfMZvHbCWVKh3v65xZXf6pBKWxZ3y9n1cMW8ZIAsVoKJjgoh5avBQQZokjxh/vvU/Ip0DT08QGoUr341kIi5P8SkPblNtfdFUyMi+OtrkMugtd6qSxSzpYDJlL8zfz8AWHkSOJMqJdDFH9uLtxRerpcDSt9mnybRAm4LLKc4JOWnI2llpahSV5MPS6rTg4gF5nshqqYGul/KGKVEWXPKEZv9PXYW2cXEFlJdQKQZeG6WDHsXbZYYk7purrNhWDZMSjoWsYb5RYrl6l4TQNaJ8Xy54jc7MuHtN6RmUejPI5TxlDvSCQZCIcjpsMDKoJdcukDWamHQXb7AfaXxBjdgc2W5dxol+2UMuS4QXuKTBg62H4aWyYGx1jbzzJbfudvoMOgoGBYH4yA8VsmB6pSToY+us/rkm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 11:02:33.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8963e55-d6db-439c-b196-08d773294e40
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 November 2019 19:37:40 GMT Sam Ravnborg wrote:
> Hi Mihail.

Hi Sam,

>=20
> On Tue, Nov 26, 2019 at 01:16:26PM +0000, Mihail Atanassov wrote:
> > No functional change.
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/sti/sti_dvo.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dv=
o.c
> > index 68289b0b063a..20a3956b33bc 100644
> > --- a/drivers/gpu/drm/sti/sti_dvo.c
> > +++ b/drivers/gpu/drm/sti/sti_dvo.c
> > @@ -462,9 +462,7 @@ static int sti_dvo_bind(struct device *dev, struct =
device *master, void *data)
> >  	if (!bridge)
> >  		return -ENOMEM;
> > =20
> > -	bridge->driver_private =3D dvo;
> > -	bridge->funcs =3D &sti_dvo_bridge_funcs;
> > -	bridge->of_node =3D dvo->dev.of_node;
> > +	drm_bridge_init(bridge, &dvo->dev, &sti_dvo_bridge_funcs, NULL, dvo);
> >  	drm_bridge_add(bridge);
> > =20
> >  	err =3D drm_bridge_attach(encoder, bridge, NULL);
>=20
> I can see from grepping that bridge.driver_private is used
> in a couple of other files in sti/
>=20
> Like sti_hdmi.c:
>         bridge->driver_private =3D hdmi;
>         bridge->funcs =3D &sti_hdmi_bridge_funcs;
>         drm_bridge_attach(encoder, bridge, NULL);
>=20
>=20
> I wonder if a drm_bridge_init() should be added there.
> I did not look closely - but it looked suspisiously.

My goal with drm_bridge_init() was to get devlinks sorted out for
cross-module uses of a drm_bridge (via of_drm_find_bridge()), so I only
considered locations where drm_bridge_add/remove() were used.

Would you be okay with a promise to push a cleanup of this one and the
one in sti_hda.c after patch 1/30 lands in some form? I'd rather not
make this series much longer, it's already pushing it at 30 :).

>=20
> 	Sam
>=20


--=20
Mihail



