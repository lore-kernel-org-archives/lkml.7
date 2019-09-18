Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFFDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9B320640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UjMlD6D3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EEqJyMgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfIRIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:23:52 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:44963
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfIRIXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2ZoNr+Ou/ZJOL/24jH+rFnDSrD7x8dMNOCdJ+10V6Q=;
 b=UjMlD6D3OoNonz9imPErCGI81iwVhHXc1elrTKa3MKkRcmVIoETBCKxCa2L9Mfq9A7u/vxUdcKe4aMt9yfMYFyLYoA6YKMrr+i7C/AvytRMf+tRhmkxsXBt51Z+D1dAXPZ94hUjYDTaO6dwf5/rO4rBOig0Mu46nsIbZF7A+0SM=
Received: from VI1PR0801CA0078.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::22) by DBBPR08MB4331.eurprd08.prod.outlook.com
 (2603:10a6:10:c7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Wed, 18 Sep
 2019 08:23:41 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VI1PR0801CA0078.outlook.office365.com
 (2603:10a6:800:7d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19 via Frontend
 Transport; Wed, 18 Sep 2019 08:23:41 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Wed, 18 Sep 2019 08:23:40 +0000
Received: ("Tessian outbound 968ab6b62146:v31"); Wed, 18 Sep 2019 08:23:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 16f3fff491149b4d
X-CR-MTA-TID: 64aa7808
Received: from eceba24666ae.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E9046880-420B-46B2-9BF4-DE19991287FC.1;
        Wed, 18 Sep 2019 08:23:31 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eceba24666ae.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 18 Sep 2019 08:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTNCJB+/f+F6gNgAuYynWkBbuLm0ISChu4FtNQYxQaLuFjiWhDtV6cOW5KZWjB/CZWeokEcr2OTWQcFy9sdqeUVaE+//8vaKpRyz/12c22ltV7hmsjWFXA8vbe6zWvhFj6zxrSFP/6lqIS6Rac7Z91hdURoi5UlaPreJpy9DDOAPgPCmTNAvnwzdmxHIx7SQHzZ+naiROzm2/AKs5GJHc6KUaerTZWzCPoV0Jue/drEJA6p9C2oWtIw/xxLVlV5jhB0HN2Yq7i9teLjjHjWNQT+yvTgIAeXJDJe8OU+Oj7yPkyRMdt3cfHd++lBKg8/du/C7tJzQDj9sG4Pkb98/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DqFiMYBmjpxkd1u3CIiau0OWaG9keBuqDN/odWzY5c=;
 b=D2F8bLs+lVX7SqF+5P95aqlNTJv3MoxBX2qsKZFj0sprd/7egEoiHxm7AD+ICs92vrJFUExmBnU/bV4wW0aeXLVEDNgJRPnTvC7ombPOwKZYIMX6aZf5mLQsR5y3ixCQ/YufAE6GM/NA77otGH+F/61hDA+o/wvlbMdLKai91dt4e7FJ+lGXixqz86EQTuaO9txA20FB/QbRBV6ukbLNKmNq9xsPXg38D0rv/WZ257i/aK6R4nc1bGsde+9YvbsBx+hyngg4R1M61SsMee3bmInZbBPKX/vsUdSwsSfhZhtCK1H0AZy31by/kcAkLj53IS2pl6WWd9/iSyZOURhCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DqFiMYBmjpxkd1u3CIiau0OWaG9keBuqDN/odWzY5c=;
 b=EEqJyMgZCdrS5HwLiwayURjBYFukqAodOPFbY7lGw9Ob1rxLkuHVOq+e6mP4BYfosFAuUJciC0zIUZzhl9jMGFhlStyf56z5egwk1S2dBIuS7AaRE9Xhr3z3asxbM0J/vL9yLwEZUonxpowrZCGa1XJeV07+TKx1UOjslkSehlU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5230.eurprd08.prod.outlook.com (10.255.27.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Wed, 18 Sep 2019 08:23:28 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 08:23:28 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Remove in-code use of ifdef
Thread-Topic: [PATCH] drm/komeda: Remove in-code use of ifdef
Thread-Index: AQHVbWlTUdep0ag1GkKUK45fY3+NxacxEzeAgAAGoQA=
Date:   Wed, 18 Sep 2019 08:23:28 +0000
Message-ID: <20190918082322.GA16813@jamwan02-TSP300>
References: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
 <20190917150314.20892-1-mihail.atanassov@arm.com>
 <20190918075939.GZ3958@phenom.ffwll.local>
In-Reply-To: <20190918075939.GZ3958@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1a6bc1bd-db0d-4983-dc3f-08d73c11832f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB5230;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5230:|VE1PR08MB5230:|DBBPR08MB4331:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB43313F166776670214D83EB3B38E0@DBBPR08MB4331.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3631;OLM:3631;
x-forefront-prvs: 01644DCF4A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(305945005)(6246003)(8936002)(14454004)(229853002)(66556008)(81156014)(256004)(476003)(6506007)(2501003)(76176011)(446003)(81166006)(316002)(8676002)(1076003)(386003)(966005)(99286004)(33656002)(6436002)(2906002)(9686003)(33716001)(6512007)(186003)(6486002)(11346002)(3846002)(52116002)(26005)(58126008)(66946007)(64756008)(55236004)(102836004)(110136005)(86362001)(6306002)(25786009)(486006)(7736002)(71190400001)(71200400001)(5660300002)(478600001)(66066001)(2201001)(66476007)(6116002)(66446008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5230;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: MH/ysoNtl7qmQnCcsgqlGHuoWz8pwgVyUxK+PI1qphNHJOjKBwLcMl1jjZxd6QeE5RURkSSaVrTB3qCkCJ6v/BoqeP6pJO4lwsVhbxvFasALI2hlZDKNEtETTh+uy+15rzEOhJVeDcHYgGiGbqApA46I6FoLIkHI1D1cZgcu6S52Qwk1es080BmnqNpB+wGWwCM/yYvm5i34+2OaTxyJjfQdM0/UGYIcJUazby3NYJ5RXaFCdDspMPeidv8RS9VcU1aJCWtv2FZYy/KLocOw+WlXUiOgJcP0w4EHNrLj62uLHNkRlXmlDr2+Wtf6eUMM+leT0cMJ2a+sKWC6DNE4CQqQZVEp1WWCsjDUTi3M+eiOAxSaFQw5hIdvQKXxLFWdK+n7HFaOq34ddceST2YWJu9brq6MvC2oJQvacdnI+XM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3733FE332526344DB26E4F8ABE8F68DA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5230
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40434004)(189003)(199004)(8676002)(81166006)(8746002)(81156014)(8936002)(336012)(22756006)(6116002)(47776003)(3846002)(25786009)(23726003)(2906002)(7736002)(66066001)(6512007)(97756001)(6246003)(1076003)(356004)(58126008)(5660300002)(305945005)(316002)(110136005)(36906005)(9686003)(46406003)(6306002)(26826003)(229853002)(76130400001)(70206006)(70586007)(478600001)(33656002)(486006)(126002)(966005)(14454004)(587094005)(86362001)(2501003)(2201001)(5024004)(14444005)(76176011)(386003)(6506007)(50466002)(11346002)(63350400001)(26005)(476003)(446003)(186003)(99286004)(33716001)(102836004)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4331;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89b63ca2-aa69-4f2e-c0ea-08d73c117bcb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DBBPR08MB4331;
X-Forefront-PRVS: 01644DCF4A
X-Microsoft-Antispam-Message-Info: rUBTNauTirtcxRjWvu20AQRG52qQha9wmv0EoM88o73hcmC24FCBohcsGC/4xypQbp6Hn1oUjV3h9doa6b7viVVLClLqW7rFIh0pwear0Q0RtaV1Mn0ZIPf5mgx4s32pGPXk/JB9Hn2tO3GN6HF825uk8dkhFB0c0RTWnBvQaIZ29T9wF038oIe8lO+sQcv9KABndJPoMxq8nYVhocjTKmTckeQSS1zISlI9dx1O0WdGp4MSQXNncR4RtMSVH9md+QJTEFZFQ1nVC8l80RfW5C3eGxksP/Qw7MyYQzIyzWQWgKxQpFk7aCF0ATfXtp5P86YwLgCpWXrzcAQeb97JmPI8rLGaS8/xiMq/3yZ0NPuRfSXio3XBBzIwqxQPasGGaEaEUzMa6b+dIM2Ed4O6+ZDBTKTeSeS3GpucI9BuSAU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2019 08:23:40.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6bc1bd-db0d-4983-dc3f-08d73c11832f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:59:39AM +0200, Daniel Vetter wrote:
> On Tue, Sep 17, 2019 at 03:05:08PM +0000, Mihail Atanassov wrote:
> > Provide a dummy static inline function in the header instead.
> >
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Lowry Li (Arm Technology China) <Lowry.Li@arm.com>
> > Cc: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> > Fixes: 4d74b25ee395 ("drm/komeda: Adds error event print functionality"=
)
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Hi Mihail:

Thank you for the patch, and I'll push it to drm-misc

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

Thanks
James

> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 2 --
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.h
> > index e28e7e6563ab..8acf8c0601cc 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -220,6 +220,8 @@ struct komeda_dev *dev_to_mdev(struct device *dev);
> >
> >  #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> >  void komeda_print_events(struct komeda_events *evts);
> > +#else
> > +static inline void komeda_print_events(struct komeda_events *evts) {}
> >  #endif
> >
> >  #endif /*_KOMEDA_DEV_H_*/
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 18d7e2520225..dc85c08e614d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -47,9 +47,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, vo=
id *data)
> >     memset(&evts, 0, sizeof(evts));
> >     status =3D mdev->funcs->irq_handler(mdev, &evts);
> >
> > -#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> >     komeda_print_events(&evts);
> > -#endif
> >
> >     /* Notify the crtc to handle the events */
> >     for (i =3D 0; i < kms->n_crtcs; i++)
> > --
> > 2.23.0
> >
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
