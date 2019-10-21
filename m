Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA441CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DC22084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="U+xeAb/J";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="U+xeAb/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJUODQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:03:16 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:55429
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728551AbfJUODQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlYmLm08HoM71Dq2zLhftn6+THIaEXH85ueIuTPgfo=;
 b=U+xeAb/JzKVwF10rnEdQYVIezu6jE1WljMMi8kMZgqXhBZdUdIGOq0wGuWVxGvwWQ8jb+iG7Z68SJx0Nw7KtD0ek92EXDuBVyAlqisvUFfKJ4SQxcr1HwBpYhOsLG5MAHdt7cqD+iWTv0ZN8rKS+40gbS/u6Z7C+fSEGHKY1h7g=
Received: from VI1PR08CA0131.eurprd08.prod.outlook.com (2603:10a6:800:d4::33)
 by DB7PR08MB3275.eurprd08.prod.outlook.com (2603:10a6:5:24::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Mon, 21 Oct
 2019 14:03:08 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR08CA0131.outlook.office365.com
 (2603:10a6:800:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 14:03:08 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 14:03:06 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Mon, 21 Oct 2019 14:03:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7c6971fbf46c02f8
X-CR-MTA-TID: 64aa7808
Received: from 92992491f1c0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7D6622F6-4759-4C40-8592-B400F17CA374.1;
        Mon, 21 Oct 2019 14:02:58 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 92992491f1c0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 21 Oct 2019 14:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuFDmzbqMaGTbuydZmFbyueIhujbKVtdO7wHY6c7sXvv2NxRIDdmy4Pm7jyoG0vN4HphG60jyoNftcVQN/lQg1P/mlo9RGjUB/TVnhMEczgR8/szcOhoy4J2qbv2gcq14RDttWQkYQapFzc5e1xL7565fv4EAihiB3XnPXmL5DIl1gjK4Z8yXUgPaYca0WJA3dm546hoyRXe5Rx2gE9GR63erDnnNnVDS/xZo5TKJmK4vDLDNpYqz2GSGb/tLp7Oe8a8U5Tv+9D26Jvhr0GSycY3K/eGGSFLitqw1AM+ZASRxg5jd6V4lFYZgEKgxDVj2gmCJ2u7+K3SJz7JBDnyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlYmLm08HoM71Dq2zLhftn6+THIaEXH85ueIuTPgfo=;
 b=WwpwVlAcSot4ye35fNg5Ir5iYJ3RJ+LWlU/vnUYpIoioXyXnwhv/sQtKpC5R6/0oPL8UaZkXN4/EpNX7qiI8wKhmF9WXDth2BfAdjdU5dSZbZPAcwZMx4zy0ICvsK7uLCLd13g7TB7nUViLKQDmRzilVraDf7vs2Rzcegf+7I4c4mYc4HtiyazCTh1Rt/VpOl6KNMnz2SRA0vqah9D6iHZ7aQxWlMf+vy1jFDyFoq0V595fVy1iTG1FG3k1tIfZS4f/kWHqO1zmBGUk6dzDlgulkF7+nGg9Gnwi68tbTiFGGdazSa/TP+Saem1J1YqazjCxhHvF1wxzbbmVVneuUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlYmLm08HoM71Dq2zLhftn6+THIaEXH85ueIuTPgfo=;
 b=U+xeAb/JzKVwF10rnEdQYVIezu6jE1WljMMi8kMZgqXhBZdUdIGOq0wGuWVxGvwWQ8jb+iG7Z68SJx0Nw7KtD0ek92EXDuBVyAlqisvUFfKJ4SQxcr1HwBpYhOsLG5MAHdt7cqD+iWTv0ZN8rKS+40gbS/u6Z7C+fSEGHKY1h7g=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3248.eurprd08.prod.outlook.com (10.171.183.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 14:02:56 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 14:02:56 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Topic: [v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Index: AQHVg/rzQgJg1rsyuUiz1kR3zevdn6dlKIKA
Date:   Mon, 21 Oct 2019 14:02:56 +0000
Message-ID: <5882846.nLqbd4GdRz@e123338-lin>
References: <20190930122231.33029-1-mihail.atanassov@arm.com>
 <20191016082255.GA18768@jamwan02-TSP300>
In-Reply-To: <20191016082255.GA18768@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0031.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::19)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ebe5627f-9dde-4905-e709-08d7562f65fd
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3248:|VI1PR08MB3248:|DB7PR08MB3275:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3275EB5233A052C40862327B8F690@DB7PR08MB3275.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(51914003)(305945005)(7736002)(6116002)(3846002)(6862004)(6246003)(4326008)(6486002)(99286004)(52116002)(71200400001)(76176011)(71190400001)(54906003)(316002)(6436002)(6512007)(9686003)(229853002)(2906002)(33716001)(25786009)(478600001)(81156014)(6636002)(81166006)(8676002)(8936002)(86362001)(446003)(14454004)(5660300002)(386003)(6506007)(102836004)(26005)(14444005)(256004)(486006)(66066001)(64756008)(66556008)(66476007)(66946007)(66446008)(11346002)(476003)(186003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3248;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5ygR+oVsRYUsPprnwRGdiui7iwDKYLUJikaHLpuErYHt9jH71UKRMiODd8QuzNA08qikMouFINWZeBNqhIcnzgmjQOQFGsHeYqt3ToSaVffMwtY3smsdTUecKKJ4wIj59FZKI4AddtUDewV8uX1rXn3PXWDRacs7zCZDoZLaCn+zCXh8VkkIXPJTe018FoxvRErvqNSUj41ms/F9ZVrzNmD1/+5mCBkIY9HxaRxYcSt+BsY5gMTgjMNXZnx0CSddphN4xj6HLGMGAqIDlAza5ANEqrS9Rx6PrBP9RwuNJMUIguR/BS8p1EBlBN2XxVHjDZUFlp+AeJKpbIZckqEq/yxWCKIKHxuExM7OR4bP6Bgzz49uhbfDHfpogvo4DuHVRQYdHKy6D0lXPhqIRf460/msl09AC1AK3NNfPBnbxxLJ4hC+5/WT9tRaQysFi8vA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DD74D089B872E4C8ABD08A6F5A8F12E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3248
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(51914003)(305945005)(97756001)(8936002)(86362001)(102836004)(46406003)(26005)(486006)(7736002)(76130400001)(386003)(8746002)(6506007)(36906005)(3846002)(6116002)(66066001)(23726003)(186003)(446003)(11346002)(14444005)(63350400001)(356004)(336012)(126002)(99286004)(2906002)(6636002)(476003)(33716001)(8676002)(54906003)(70206006)(9686003)(4326008)(26826003)(81156014)(478600001)(81166006)(6486002)(25786009)(6512007)(47776003)(5660300002)(229853002)(76176011)(316002)(6862004)(50466002)(70586007)(22756006)(14454004)(6246003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3275;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 83be254d-2d2b-4039-0fd7-08d7562f5f71
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tK3a2R5m7lauPYJTdhFqd3djCORTHdVvG5zsjIKvAiP89kS4ToJ7pYfGTLBF6GDiVMS0iNSE605Un/4EzxZ5b7fpIlDk2psOTEvc4mpLurtyc43YhDCfO6uz/mIY+3SsZkf0Sf4o1BuHNc2IB3UgvhzlzmhbfZx6FO4DtnhLttwRgJGAWetqcqVga3Iom1wi+5NOuW9wCWLcsaKy6ah3jCUauI37R6bp6ZAWyg/+6yhJ0wjqVuzjv3axmESW5a6k0c4tVcEf9XgH5H8mQ3xoyY0hIvCOKIJ6k+rr6XmlkLQZ8AvGbgi+yh+eV7DKNPROfZ++8z+tXt9v+ntdsi5aivgPCkSF0eTwVgF0ex1UFIBdk9MDshypcMyUSMl2IbV742g+Xp+DdjIvCxtlDb7LYQoLABFxng4RyPjvRdG6Mw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:03:06.9703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe5627f-9dde-4905-e709-08d7562f65fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 16 October 2019 09:23:03 BST james qian wang (Arm Technology =
China) wrote:
> On Mon, Sep 30, 2019 at 12:23:07PM +0000, Mihail Atanassov wrote:
> > Fix both the string and the struct member being printed.
> >=20
> > Changes since v1:
> >  - Now with a bonus grammar fix, too.
> >=20
> > Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 950235af1e79..2b624bfe1751 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *sp=
litter,
> >  	}
> > =20
> >  	if (!in_range(&splitter->vsize, dflow->in_h)) {
> > -		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
> > -				 dflow->in_w);
> > +		DRM_DEBUG_ATOMIC("split in_h: %d exceeds the acceptable range.\n",
> > +				 dflow->in_h);
>=20
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Thanks for the review, applied to drm-misc-fixes -
8ae501e295cce9bc6e0dd82d5204a1d5faef44f8.

> >  		return -EINVAL;
> >  	}
> > =20
>=20


--=20
Mihail



