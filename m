Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7127C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E358206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gPdet3Dr";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gPdet3Dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfLCGw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:52:59 -0500
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:26468
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727192AbfLCGw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwPc1obzcvtFC7saYROwPrWBDqfQefMfeu8D/9WgGHM=;
 b=gPdet3Drd2ryKn+1hZaTHsMb+cKrMYqTDbRsZSQkkVyQfFAt9iSSMtb1Rq0MBD2sfpImbrWGrOKmM9Yf2bLgt38wYcC9dDHXM6dVspLq+nacR6jZdWTA4dkxPekRS6wLevK0CaH7wl8/PU4e7E1vvaws6mYv6wXf0VFHBxQU4a0=
Received: from VI1PR08CA0156.eurprd08.prod.outlook.com (2603:10a6:800:d5::34)
 by VI1PR08MB3263.eurprd08.prod.outlook.com (2603:10a6:803:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Tue, 3 Dec
 2019 06:52:35 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR08CA0156.outlook.office365.com
 (2603:10a6:800:d5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Tue, 3 Dec 2019 06:52:35 +0000
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
 15.20.2495.18 via Frontend Transport; Tue, 3 Dec 2019 06:52:35 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Tue, 03 Dec 2019 06:52:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3ed28b09f4b939ee
X-CR-MTA-TID: 64aa7808
Received: from 69b938dc0441.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 072356FE-DE6A-4C0A-89CA-B26836869AA3.1;
        Tue, 03 Dec 2019 06:52:29 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 69b938dc0441.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Dec 2019 06:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MybZ8DJJKbKHpXHwD4dFWK7TBkmiM1LuAroZnpl6ZN16S5JLBzrYhzmW3tIS/XL2FvAdW6M1QP6n5Caz3lKoNDKqxM8LUGLp8jHgp12vDRntHK87suIvXBlhFbo/fbsjSqAep43qiSmzPYqRku/6XAADEAgyjlYSn2czlM6MVWaRNsDz5ifNNeMMW8N+nhkxUb4LzQdHoDmo5c/uXhgkcZ753ELbB6l7I5THiVU2YRhW/4g9V/YMwhNOjkUAn8I8zI3CPJtaKnpbGAUUiK9lzELZmVhmIqC1BugAiONj7lzcKLESd1FJ3JgWbqZLf6OdVnbZ/P/qdl3g9Uyz3fFZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwPc1obzcvtFC7saYROwPrWBDqfQefMfeu8D/9WgGHM=;
 b=Nf+7erd3VJXf0nFuZAJw72ApXkl23Y3xig8QJsDjhpahG2V5FHz8R0l0V3VE1zF0NqjLuE/UXQUTIgS/I2Jv9lpUQargsHVvlcLxKFW0ant0My1F/KddkApmWfo/iMbcDyXdhZFZKeDr3hq1NYALGakNHLcz1LXN4V1uPM14dO2IHE7zWVchkPK7/xnUiQ7+e71IETIghWT/u9U4it21frIFJF831AZvOiLpjLMhFBYLKjrqBEYFaTIgU850lDqqdOEjeLPqUKpq2dxJgnMkpf3VPuVtS9u82O9e4dTt4xR7O8/7KUVbARB+WgFiisOAUMtPLE9BN0zuMWFdeUpYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwPc1obzcvtFC7saYROwPrWBDqfQefMfeu8D/9WgGHM=;
 b=gPdet3Drd2ryKn+1hZaTHsMb+cKrMYqTDbRsZSQkkVyQfFAt9iSSMtb1Rq0MBD2sfpImbrWGrOKmM9Yf2bLgt38wYcC9dDHXM6dVspLq+nacR6jZdWTA4dkxPekRS6wLevK0CaH7wl8/PU4e7E1vvaws6mYv6wXf0VFHBxQU4a0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5151.eurprd08.prod.outlook.com (20.179.31.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 06:52:27 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 06:52:27 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Topic: [PATCH v2 1/2] drm/komeda: Update the chip identify
Thread-Index: AQHVoEQj/p8RiR47xEOSjyW11KmivaemwPQAgAFK74A=
Date:   Tue, 3 Dec 2019 06:52:27 +0000
Message-ID: <20191203065221.GA17562@jamwan02-TSP300>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <20191121081717.29518-2-james.qian.wang@arm.com>
 <5936016.qkgZygMIky@e123338-lin>
In-Reply-To: <5936016.qkgZygMIky@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12b07420-157a-440c-3956-08d777bd6117
X-MS-TrafficTypeDiagnostic: VE1PR08MB5151:|VE1PR08MB5151:|VI1PR08MB3263:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3263DF5C38A74A9A43F76EFEB3420@VI1PR08MB3263.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 02408926C4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(71200400001)(6506007)(76176011)(6862004)(386003)(52116002)(6636002)(8676002)(99286004)(15650500001)(55236004)(6436002)(3846002)(33656002)(4326008)(2906002)(102836004)(305945005)(66066001)(8936002)(229853002)(6116002)(6246003)(6306002)(6512007)(9686003)(86362001)(1076003)(7736002)(6486002)(25786009)(54906003)(26005)(81156014)(81166006)(186003)(11346002)(446003)(14444005)(966005)(256004)(14454004)(33716001)(5660300002)(478600001)(66946007)(66446008)(64756008)(66476007)(66556008)(71190400001)(316002)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5151;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fLG71J11TflBT2Uz6kbhv+wxrP8+mKsYG/5DMosiWHU/1hFu9INVWNgOY58thjL6oQqRxZyC8NYZQ8iKM87J1NckGYoPLHPmi80Xv75l5iF9KSZqnBU2Nc88H+mMQaIdwlnWTh3o+zACJpARgxBEoX5VkfqGzGDOecKL7fbZMl9i8qOeJitaYf3TDx2jyD7KPFJ904vlYNe4JC5NNuOazPjKsOII2I5q108BfI9pIW4cdT577zswRMYFvGQeyf15OyYiLJv1n9XepMdleqN2QR9T1krd0NwEaqU+OOeD7NPV7vDkUzpIjPhZU/3qn8hMyHAHYVoQzSJ5UmuH59Byr0d4/GrZ4q91E+3N/mo15fh8qz38ii2HXp1vnllW1FOIxqW3ICqHytDV12QC7oYnNg5uPVXTttEuKfTdqZvntIB/2+U5qzBkaHNCyG7Crz4EAJwpJAtvZvUI1LFSLERYIpkYGv89RSS8P1CGjBx0AN8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AC3A9829D67BE4395A5DC9DEBA557F9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5151
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(81156014)(8676002)(6486002)(229853002)(2906002)(6306002)(8746002)(6862004)(6246003)(81166006)(6512007)(9686003)(1076003)(86362001)(106002)(58126008)(99286004)(356004)(33656002)(50466002)(14444005)(8936002)(5660300002)(54906003)(15650500001)(36906005)(316002)(478600001)(70206006)(47776003)(66066001)(305945005)(7736002)(25786009)(26005)(14454004)(76130400001)(386003)(6506007)(102836004)(186003)(4326008)(46406003)(23726003)(97756001)(446003)(22756006)(3846002)(76176011)(6636002)(33716001)(26826003)(11346002)(336012)(966005)(6116002)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3263;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b013925a-34cc-4d5a-1a95-08d777bd5c2a
NoDisclaimer: True
X-Forefront-PRVS: 02408926C4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBoXy6BUOSSXJ8WyXvtQT7WOv/1gyVea/eOcsOJbfhbNstvI15ayGf1527bMuxamWDxvY9aF1cWy34tn1B8XvOFiMhi9SBAfcK5UcxnmNiOX7dQBoKysSNL1bd4bNvrLgoGWecVz7eyptQw7dx0ZBrgOC/UMmfL55FP1NRBTfpHCsRVWqkORPRbYeHDE7YrIF9wKrzEzYctioMrJyVv9L8kfZVnFEPIw48sqtjhm44Jof1nkBOrbCYYBgKyPQZ9I7P0Ri/g5cJaTAlwIOt9Mw9Bz8tD7PJOBF1GH9zO0EoLdBAmgRRAof6kh1lGX5T6kMFmZTNL+P/l4Ay23z3IIdBYfIPkTlblYWe7NJoa9sYNVNizWEQtA3IGLhdblUN9Db8W51Q/lXPTlpLjiSCszP9W/wlv60gwqVGldOds5emGe3xu7lB35MPXSsKmWkzDgiJubWTKrtbJSqV/LhfcPPZbZP4kxrUpv/IgZzfPeSKs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 06:52:35.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b07420-157a-440c-3956-08d777bd6117
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:07:54AM +0000, Mihail Atanassov wrote:
> On Thursday, 21 November 2019 08:17:39 GMT james qian wang (Arm Technolog=
y China) wrote:
> > 1. Drop komeda-CORE product id comparison and put it into the d71_ident=
ify
> > 2. Update pipeline node DT-binding:
> >    (a). Skip the needless pipeline DT node.
> >    (b). Return fail if the essential pipeline DT node is missing.
> >=20
> > With these changes, for one family chips no need to change the DT.
> >=20
> > v2: Rebase
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 27 +++++++--
> >  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 60 ++++++++++---------
> >  .../gpu/drm/arm/display/komeda/komeda_dev.h   | 14 +----
> >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +--
> >  4 files changed, 58 insertions(+), 52 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers=
/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > index 822b23a1ce75..9b3bf353b6cc 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > @@ -594,10 +594,27 @@ static const struct komeda_dev_funcs d71_chip_fun=
cs =3D {
> >  const struct komeda_dev_funcs *
> >  d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
> >  {
> > -	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
> > -	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
> > -	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
> > -	chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
> > +	const struct komeda_dev_funcs *funcs;
> > +	u32 product_id;
> > =20
> > -	return &d71_chip_funcs;
> > +	chip->core_id =3D malidp_read32(reg_base, GLB_CORE_ID);
> > +
> > +	product_id =3D MALIDP_CORE_ID_PRODUCT_ID(chip->core_id);
> > +
> > +	switch (product_id) {
> > +	case MALIDP_D71_PRODUCT_ID:
> > +		funcs =3D &d71_chip_funcs;
> > +		break;
> > +	default:
> > +		funcs =3D NULL;
>=20
> [bikeshed] I'd just 'return NULL;' after printing the error...

Good idea, and then no need to check the func in the following code.

> > +		DRM_ERROR("Unsupported product: 0x%x\n", product_id);
> > +	}
> > +
> > +	if (funcs) {
>=20
> ... and save myself the branch and indent level here.
>=20
> > +		chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
> > +		chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
> > +		chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
> > +	}
> > +
> > +	return funcs;
> >  }
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index 4dd4699d4e3d..8e0bce46555b 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -116,22 +116,14 @@ static struct attribute_group komeda_sysfs_attr_g=
roup =3D {
> >  	.attrs =3D komeda_sysfs_entries,
> >  };
> > =20
> > -static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device=
_node *np)
> > +static int komeda_parse_pipe_dt(struct komeda_pipeline *pipe)
> >  {
> > -	struct komeda_pipeline *pipe;
> > +	struct device_node *np =3D pipe->of_node;
> >  	struct clk *clk;
> > -	u32 pipe_id;
> > -	int ret =3D 0;
> > -
> > -	ret =3D of_property_read_u32(np, "reg", &pipe_id);
> > -	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
> > -		return -EINVAL;
> > -
> > -	pipe =3D mdev->pipelines[pipe_id];
> > =20
> >  	clk =3D of_clk_get_by_name(np, "pxclk");
> >  	if (IS_ERR(clk)) {
> > -		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
> > +		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe->id);
> >  		return PTR_ERR(clk);
> >  	}
> >  	pipe->pxlclk =3D clk;
> > @@ -145,7 +137,6 @@ static int komeda_parse_pipe_dt(struct komeda_dev *=
mdev, struct device_node *np)
> >  		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> > =20
> >  	pipe->dual_link =3D pipe->of_output_links[0] && pipe->of_output_links=
[1];
> > -	pipe->of_node =3D of_node_get(np);
> > =20
> >  	return 0;
> >  }
> > @@ -154,7 +145,9 @@ static int komeda_parse_dt(struct device *dev, stru=
ct komeda_dev *mdev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct device_node *child, *np =3D dev->of_node;
> > -	int ret;
> > +	struct komeda_pipeline *pipe;
> > +	u32 pipe_id =3D U32_MAX;
> > +	int ret =3D -1;
> > =20
> >  	mdev->irq  =3D platform_get_irq(pdev, 0);
> >  	if (mdev->irq < 0) {
> > @@ -169,31 +162,44 @@ static int komeda_parse_dt(struct device *dev, st=
ruct komeda_dev *mdev)
> >  	ret =3D 0;
> > =20
> >  	for_each_available_child_of_node(np, child) {
> > -		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
> > -			ret =3D komeda_parse_pipe_dt(mdev, child);
> > -			if (ret) {
> > -				DRM_ERROR("parse pipeline dt error!\n");
> > -				of_node_put(child);
> > -				break;
> > +		if (of_node_name_eq(child, "pipeline")) {
> > +			of_property_read_u32(child, "reg", &pipe_id);
> > +			if (pipe_id >=3D mdev->n_pipelines) {
> > +				DRM_WARN("Skip the redundant DT node: pipeline-%u.\n",
> > +					 pipe_id);
> > +				continue;
> >  			}
> > +			mdev->pipelines[pipe_id]->of_node =3D of_node_get(child);
> >  		}
> >  	}
> > =20
> > +	for (pipe_id =3D 0; pipe_id < mdev->n_pipelines; pipe_id++) {
> > +		pipe =3D mdev->pipelines[pipe_id];
> > +
> > +		if (!pipe->of_node) {
> > +			DRM_ERROR("Omit DT node for pipeline-%d.\n", pipe->id);
>=20
> [nit] "Omit DT node" doesn't sound like an error condition. How about:
>=20
> "pipeline-%d doesn't have a DT node."

Will do it in the next version.

>=20
> > +			return -EINVAL;
> > +		}
> > +		ret =3D komeda_parse_pipe_dt(pipe);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master=
",
>=20
> Looks like this isn't based off drm-misc-next, and is instead based on
> https://patchwork.freedesktop.org/patch/341867/
>=20
> >  						   &mdev->side_by_side_master);

OK, will rebase this series directly to drm-misc-next.

> > =20
> > -	return ret;
> > +	return 0;
> >  }
> > =20
> >  struct komeda_dev *komeda_dev_create(struct device *dev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> > -	const struct komeda_product_data *product;
> > +	komeda_identify_func komeda_identify;
> >  	struct komeda_dev *mdev;
> >  	int err =3D 0;
> > =20
> > -	product =3D of_device_get_match_data(dev);
> > -	if (!product)
> > +	komeda_identify =3D of_device_get_match_data(dev);
> > +	if (!komeda_identify)
> >  		return ERR_PTR(-ENODEV);
> > =20
> >  	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
> > @@ -221,11 +227,9 @@ struct komeda_dev *komeda_dev_create(struct device=
 *dev)
> > =20
> >  	clk_prepare_enable(mdev->aclk);
> > =20
> > -	mdev->funcs =3D product->identify(mdev->reg_base, &mdev->chip);
> > -	if (!komeda_product_match(mdev, product->product_id)) {
> > -		DRM_ERROR("DT configured %x mismatch with real HW %x.\n",
> > -			  product->product_id,
> > -			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
> > +	mdev->funcs =3D komeda_identify(mdev->reg_base, &mdev->chip);
> > +	if (!mdev->funcs) {
> > +		DRM_ERROR("Failed to identify the HW.\n");
> >  		err =3D -ENODEV;
> >  		goto disable_clk;
> >  	}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.h
> > index 471604b42431..dacdb00153e9 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > @@ -58,11 +58,6 @@
> >  			    | KOMEDA_EVENT_MODE \
> >  			    )
> > =20
> > -/* malidp device id */
> > -enum {
> > -	MALI_D71 =3D 0,
> > -};
> > -
> >  /* pipeline DT ports */
> >  enum {
> >  	KOMEDA_OF_PORT_OUTPUT		=3D 0,
> > @@ -76,12 +71,6 @@ struct komeda_chip_info {
> >  	u32 bus_width;
> >  };
> > =20
> > -struct komeda_product_data {
> > -	u32 product_id;
> > -	const struct komeda_dev_funcs *(*identify)(u32 __iomem *reg,
> > -					     struct komeda_chip_info *info);
> > -};
> > -
> >  struct komeda_dev;
> > =20
> >  struct komeda_events {
> > @@ -243,6 +232,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 t=
arget)
> >  	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) =3D=3D target;
> >  }
> > =20
> > +typedef const struct komeda_dev_funcs *
> > +(*komeda_identify_func)(u32 __iomem *reg, struct komeda_chip_info *chi=
p);
> > +
> >  const struct komeda_dev_funcs *
> >  d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_drv.c
> > index d6c2222c5d33..b7a1097c45c4 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > @@ -123,15 +123,8 @@ static int komeda_platform_remove(struct platform_=
device *pdev)
> >  	return 0;
> >  }
> > =20
> > -static const struct komeda_product_data komeda_products[] =3D {
> > -	[MALI_D71] =3D {
> > -		.product_id =3D MALIDP_D71_PRODUCT_ID,
> > -		.identify =3D d71_identify,
> > -	},
> > -};
> > -
> >  static const struct of_device_id komeda_of_match[] =3D {
> > -	{ .compatible =3D "arm,mali-d71", .data =3D &komeda_products[MALI_D71=
], },
> > +	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> >  	{},
> >  };
> > =20
> >=20
>=20
> With the above two fixed (i.e. feel free to ignore the bikeshed),
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
>=20
> --=20
> Mihail
>=20
>=20
