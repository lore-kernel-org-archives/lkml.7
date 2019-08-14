Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0378BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666D2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VQhycVMd";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VQhycVMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfHNKsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:48:07 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:38535
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfHNKsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhe9nDNfqtB/9Recaju4J/8R1X9wFIn1C012+Fx8Yr0=;
 b=VQhycVMdlobbz5AKVtgNeMDbVKMoNYwunu9OZSItqd7sk9AVyM/ISH/pvKFiNkaVsMuAY/AIW09ELwPZnGargtvNIMCb8hLjaESb/G27Pgd9wkXAp6JzR41L6cy5qnFrieTFNckM89li+T10+zdn+iL48OvVNWClshdK8xxFYoc=
Received: from AM6PR08CA0023.eurprd08.prod.outlook.com (2603:10a6:20b:b2::35)
 by VI1PR0802MB2606.eurprd08.prod.outlook.com (2603:10a6:800:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.13; Wed, 14 Aug
 2019 10:47:55 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM6PR08CA0023.outlook.office365.com
 (2603:10a6:20b:b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Wed, 14 Aug 2019 10:47:55 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.18 via Frontend Transport; Wed, 14 Aug 2019 10:47:54 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Wed, 14 Aug 2019 10:47:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e6b88f94a6873e97
X-CR-MTA-TID: 64aa7808
Received: from 98599fccbc79.1 (cr-mta-lb-1.cr-mta-net [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 602B7353-70E0-4F9D-9EF3-E6FD3BA545B5.1;
        Wed, 14 Aug 2019 10:47:44 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 98599fccbc79.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 14 Aug 2019 10:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrZbkP/H+7uBTXtonKtVibHZmBKUmSaOIC4AwCCgdJZaihAlcW1Y2iAaBy/ab/FeyzeVfwbjxSfbopQZo04/z1mDM9mKQDNgNph5FP3uCgHf+3VJULcOPge7lCaFipPyoSFre1D9OlG1gic6x/Rlc5QN/8KoyEPvK6r0AGky6uhSxy1ixWnSOTgViWxwXCJnHcxqQp++9lZwL2GSElWvQ9mnIItbpgak23GnGfihGYKhl0EQAKg61t17OYxctX8xN//Ud2vH4eUmk5+vyPFEwG4CoHMxWXhUpCVqe1ggEMbOJETXv1HBhRh+IirtfXIZ3n7qw19wt+0edjcWJZm/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhe9nDNfqtB/9Recaju4J/8R1X9wFIn1C012+Fx8Yr0=;
 b=dnlWV5LrHIOyQxdaZY+HIk+f03Nx9Qr8NHaOWfui5fUs85an+LpW4t394V3VPbQvBZawQhUzdhzz+OG4l3BVfhL6f071InoRO5L7AaNw7HKD0Cxa9MDr4rG/T/TQWlOdpdCvMonLG8QN2gfmvgjRgRpFirQLlH69HwSSL/aUjQvCQB8Wwk9fdAJ0i1ubE5P+o9mut70lovUbIqvmPwm2mU54/6+419PdqFU8FBtwW7JpUvlQmjMdiQZQNjL7AnZrGjYeKqwnrSC0MxCuwyDQuDyFWU5X5QfWQoLao19vD078hpQjUAgAY7aaHDhfcHPr4OJMRs81Q+P3b2zi233bFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhe9nDNfqtB/9Recaju4J/8R1X9wFIn1C012+Fx8Yr0=;
 b=VQhycVMdlobbz5AKVtgNeMDbVKMoNYwunu9OZSItqd7sk9AVyM/ISH/pvKFiNkaVsMuAY/AIW09ELwPZnGargtvNIMCb8hLjaESb/G27Pgd9wkXAp6JzR41L6cy5qnFrieTFNckM89li+T10+zdn+iL48OvVNWClshdK8xxFYoc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4302.eurprd08.prod.outlook.com (20.179.25.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 14 Aug 2019 10:47:41 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 10:47:40 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Topic: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Index: AQHVUZN2ECag5jvL6k2i3zNMwO/wrKb45t6AgAFgXgCAADD+gA==
Date:   Wed, 14 Aug 2019 10:47:40 +0000
Message-ID: <1949712.9lhcy9HeBp@e123338-lin>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
 <3902025.BCtzpz6JhW@e123338-lin> <20190814075210.GA24984@jamwan02-TSP300>
In-Reply-To: <20190814075210.GA24984@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::29) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7cbdb121-3d66-4380-7c40-08d720a4dc92
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4302;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4302:|VI1PR0802MB2606:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2606D18A6F06214993AC07988FAD0@VI1PR0802MB2606.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 01294F875B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(81156014)(64756008)(446003)(2906002)(66476007)(66446008)(66556008)(8936002)(66946007)(7736002)(5660300002)(53936002)(6636002)(476003)(25786009)(6862004)(305945005)(66066001)(6116002)(486006)(3846002)(11346002)(6436002)(256004)(6246003)(14444005)(4326008)(81166006)(71200400001)(54906003)(71190400001)(316002)(33716001)(26005)(186003)(6486002)(478600001)(99286004)(9686003)(86362001)(6506007)(386003)(102836004)(52116002)(8676002)(76176011)(6512007)(229853002)(14454004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4302;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 4dU++MoOOV9LEA5rftlj4PwfTbczZKfryHFEXnbjBtQHmiZ2kBpsdmAJx7VdCCEbobWbFWLmkSX+ai2Ea9yCsiZqHxsCzZ0E43IIMajvcD8mx7fKrUKIYYA3NWgkhOHUbiJlGHD2lPIWzMuM7EihEywmHSGVrB0MMIhpODor10OIJjy5pWKt8O2LjYX9Ft7bt4MBd2+xNY9f4OeJ2hl2C0Vr4Mv99kgc7Xu+uMumcb7IH6dCqqNi9GG/z8G3JgDnbEij3auT0xLisJ9yrFdsoTcdJ5rShOavrEUB6hk1xFf/V3sBwmXFhr9TnVd8boiCqytQ1/7ahQ0hWch5GY7JcFDXAmFAr9kizPgEEubyF6M9aMYiE+ZYB0F4E3HMTyY2gUGEcIFuRRyv5pnCpn3rkfJbYbUmoP4K5srPfhetwFs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52FC38613245E64C92730C8445838E27@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4302
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(186003)(54906003)(70586007)(66066001)(33716001)(47776003)(4326008)(36906005)(316002)(22756006)(70206006)(14444005)(356004)(6486002)(386003)(50466002)(6506007)(7736002)(26005)(305945005)(63370400001)(486006)(63350400001)(6512007)(81156014)(26826003)(76176011)(478600001)(23726003)(9686003)(6116002)(102836004)(81166006)(86362001)(6246003)(25786009)(476003)(14454004)(11346002)(446003)(8746002)(8936002)(99286004)(76130400001)(3846002)(8676002)(97756001)(336012)(2906002)(46406003)(6636002)(229853002)(126002)(6862004)(5660300002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2606;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ed06a30-939c-4cab-702a-08d720a4d461
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0802MB2606;
NoDisclaimer: True
X-Forefront-PRVS: 01294F875B
X-Microsoft-Antispam-Message-Info: LdFnAsbAoWPiNLachJq+ExcqB2y67GNvkUSJOo8Fk2jYVhhUI5B6isfKPnvzFkpZkMFo1QxXboLKfJvlsqppmtTm6MGPHrTUaJ4cWw2htVP99gqjMV2IfyWm4vZkdDuQb8q9WRJQc/V5tk7Sxx5rWE3ybR6tt7RNkHrcZ1VzpjvQJ0ZpXomIDJJed9AS4193up0nmDiPjA18bQMSgbL9nnsQumMRhvpgusWoUqk1WQJJ5qqCRE7cM3OjpEorgprY+UqWbFrpHYKuyNimsCG54EgEFUPhjAe29nXgezpQo9hzRMxc0itrFskW2JmJ09n/Ujm6ktmG31NmihIP6NBk+XWyUyb9+eraQhKLRGHyRQX48YBH+GpT6SYF9+CqpcIVKW534UrfnNxy/GRLyao6M1gQOJNWMelG/at0ZSyh3S8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 10:47:54.1826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbdb121-3d66-4380-7c40-08d720a4dc92
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 14 August 2019 08:52:18 BST james qian wang (Arm Technology C=
hina) wrote:
> On Tue, Aug 13, 2019 at 09:51:08AM +0000, Mihail Atanassov wrote:
> > Hi James,
> >=20
> > On Tuesday, 13 August 2019 05:56:07 BST james qian wang (Arm Technology=
 China) wrote:
> > > Many komeda component support color management like layer and IPS, so
> > > komeda_color_manager/state are introduced to manager gamma, csc and d=
egamma
> > > together for easily share it to multiple componpent.
> > >=20
> > > And for komeda_color_manager which:
> > > - convert drm 3d gamma lut to komeda specific gamma coeffs
> > > - gamma table management and hide the HW difference for komeda-CORE
> > >=20
> > > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wan=
g@arm.com>
> > > ---
> > >  .../arm/display/komeda/komeda_color_mgmt.c    | 126 ++++++++++++++++=
++
> > >  .../arm/display/komeda/komeda_color_mgmt.h    |  32 ++++-
> > >  2 files changed, 156 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > index 9d14a92dbb17..bf2388d641b9 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > > @@ -4,7 +4,9 @@
> > >   * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > >   *
> > >   */
> > > +#include <drm/drm_print.h>
> > > =20
> > > +#include "malidp_utils.h"
> > >  #include "komeda_color_mgmt.h"
> > > =20
> > >  /* 10bit precision YUV2RGB matrix */
> > > @@ -65,3 +67,127 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color=
_encoding, u32 color_range)
> > > =20
> > >  	return coeffs;
> > >  }
> > > +
> > > +struct gamma_curve_sector {
> > > +	u32 boundary_start;
> > > +	u32 num_of_segments;
> > > +	u32 segment_width;
> > > +};
> > > +
> > > +struct gamma_curve_segment {
> > > +	u32 start;
> > > +	u32 end;
> > > +};
> > > +
> > > +static struct gamma_curve_sector sector_tbl[] =3D {
> > > +	{ 0,    4,  4   },
Max LUT precision (see full response below) is determined by your
smallest segment, which is 4.
> > > +	{ 16,   4,  4   },
> > > +	{ 32,   4,  8   },
> > > +	{ 64,   4,  16  },
> > > +	{ 128,  4,  32  },
> > > +	{ 256,  4,  64  },
> > > +	{ 512,  16, 32  },
> > > +	{ 1024, 24, 128 },
> > > +};
> > > +
> > > +static struct gamma_curve_sector igamma_sector_tbl[] =3D {
> > > +	{0, 64, 64},
> > > +};
> > > +
> > > +static void
> > > +drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
> > > +		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
> > > +{
> > > +	struct drm_color_lut *lut;
> > > +	u32 i, j, in, num =3D 0;
> > > +
> > > +	if (!lut_blob)
> > > +		return;
> > > +
> > > +	lut =3D lut_blob->data;
> > > +
> > > +	for (i =3D 0; i < num_sectors; i++) {
> > > +		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
> > > +			in =3D sector_tbl[i].boundary_start +
> > > +			     j * sector_tbl[i].segment_width;
> > > +
> > > +			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
> > > +						KOMEDA_COLOR_PRECISION);
> > > +		}
> > > +	}
> > > +
> > > +	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
> > > +}
> > > +
> > > +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u3=
2 *coeffs)
> > > +{
> > > +	drm_lut_to_coeffs(lut_blob, coeffs,
> > > +			  igamma_sector_tbl, ARRAY_SIZE(igamma_sector_tbl));
> > > +}
> > > +
> > > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u3=
2 *coeffs)
> > > +{
> > > +	drm_lut_to_coeffs(lut_blob, coeffs,
> > > +			  sector_tbl, ARRAY_SIZE(sector_tbl));
> > > +}
> > > +
> > > +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coef=
fs)
> > > +{
> > > +	struct drm_color_ctm *ctm;
> > > +	u32 i;
> > > +
> > > +	if (!ctm_blob)
> > > +		return;
> > > +
> > > +	ctm =3D ctm_blob->data;
> > > +
> > > +	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; ++i) {
> > > +		/* Convert from S31.32 to Q3.12. */
> > > +		s64 v =3D ctm->matrix[i];
> > > +
> > > +		coeffs[i] =3D clamp_val(v, 1 - (1LL << 34), (1LL << 34) - 1) >> 20=
;
> > CTM matrix values are S31.32, i.e. sign-magnitude, so clamp_val won't
> > give you the right result for negative coeffs. See
> > malidp_crtc_atomic_check_ctm for the sign-mag -> 2's complement
> > conversion.
>=20
> Thank you Mihail for pointing this out.
>=20
> No matter our user or kernel all assume this s31.32 as 2's complement.=20
> we need to correct them both.
>=20
> > > +	}
> > > +}
> > > +
> > > +void komeda_color_duplicate_state(struct komeda_color_state *new,
> > > +				  struct komeda_color_state *old)
> > [bikeshed] not really a _duplicate_state if all it does is refcounts.
> > kmemdup here and return a pointer (with ERR_PTR on fail), or memcpy if
> > you want to keep the signature?
>=20
> Yes, the dup mostly should return a new ptr from a old, the dup name here
> is not accurate.
> the reason is the color_state is not a separated structure but always
> embedded into layer_state, but I want to make all color_state operation
> into a func.
> Do you have any suggestion ?
>=20
After looking at the follow-up patch, not really (at least not any
good ones). I did tag it with [bikeshed] after all, it's not that
big a deal.

> > > +{
> > > +	new->igamma =3D komeda_coeffs_get(old->igamma);
> > > +	new->fgamma =3D komeda_coeffs_get(old->fgamma);
> > > +}
> > > +
> > > +void komeda_color_cleanup_state(struct komeda_color_state *color_st)
> > > +{
> > > +	komeda_coeffs_put(color_st->igamma);
> > > +	komeda_coeffs_put(color_st->fgamma);
> > > +}
> > > +
> > > +int komeda_color_validate(struct komeda_color_manager *mgr,
> > > +			  struct komeda_color_state *st,
> > > +			  struct drm_property_blob *igamma_blob,
> > > +			  struct drm_property_blob *fgamma_blob)
> > > +{
> > > +	u32 coeffs[KOMEDA_N_GAMMA_COEFFS];
> > > +
> > > +	komeda_color_cleanup_state(st);
> > > +
> > > +	if (igamma_blob) {
> > > +		drm_lut_to_igamma_coeffs(igamma_blob, coeffs);
> > > +		st->igamma =3D komeda_coeffs_request(mgr->igamma_mgr, coeffs);
> > > +		if (!st->igamma) {
> > > +			DRM_DEBUG_ATOMIC("request igamma table failed.\n");
> > > +			return -EBUSY;
> > > +		}
> > > +	}
> > > +
> > > +	if (fgamma_blob) {
> > > +		drm_lut_to_fgamma_coeffs(fgamma_blob, coeffs);
> > > +		st->fgamma =3D komeda_coeffs_request(mgr->fgamma_mgr, coeffs);
> > > +		if (!st->fgamma) {
> > > +			DRM_DEBUG_ATOMIC("request fgamma table failed.\n");
> > > +			return -EBUSY;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b=
/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > > index a2df218f58e7..41a96b3b540f 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > > @@ -4,14 +4,42 @@
> > >   * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > >   *
> > >   */
> > > -
> > >  #ifndef _KOMEDA_COLOR_MGMT_H_
> > >  #define _KOMEDA_COLOR_MGMT_H_
> > > =20
> > >  #include <drm/drm_color_mgmt.h>
> > > +#include "komeda_coeffs.h"
> > > =20
> > >  #define KOMEDA_N_YUV2RGB_COEFFS		12
> > > +#define KOMEDA_N_RGB2YUV_COEFFS		12
> > > +#define KOMEDA_COLOR_PRECISION		12
> > > +#define KOMEDA_N_GAMMA_COEFFS		65
> > > +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
>=20
> > I don't see how the number of LUT entries has anything to do with the
> > bit-precision of each entry.
>=20
> Because our komeda color is 12-bit precison, and for 1 vs 1 loopup
> table, we need BIT(12) entries.
>=20
> Thank you
> James
>=20
But your maximum possible precision in HW is 4 times less. You only
really need one LUT entry per segment (its start) in order to
define it (and the slope, but you get the idea). I.e. at your current
4K-sized LUT table, the conversion to the internal representation only
_really_ needs to access offsets 0, 4, etc. and even less often as
it goes. If you make your table 1K entries instead, you save yourself
24KiB every time the (i)gamma changes.

TL;DR: you don't need 1:1 lookup, you need a lossless conversion from
the LUT to the HW format.

> > > +#define KOMEDA_N_CTM_COEFFS		9
> > > +
> > > +struct komeda_color_manager {
> > > +	struct komeda_coeffs_manager *igamma_mgr;
> > > +	struct komeda_coeffs_manager *fgamma_mgr;
> > > +	bool has_ctm;
> > > +};
> > > +
> > > +struct komeda_color_state {
> > > +	struct komeda_coeffs_table *igamma;
> > > +	struct komeda_coeffs_table *fgamma;
> > > +};
> > > +
> > > +void komeda_color_duplicate_state(struct komeda_color_state *new,
> > > +				  struct komeda_color_state *old);
> > > +void komeda_color_cleanup_state(struct komeda_color_state *color_st)=
;
> > > +int komeda_color_validate(struct komeda_color_manager *mgr,
> > > +			  struct komeda_color_state *st,
> > > +			  struct drm_property_blob *igamma_blob,
> > > +			  struct drm_property_blob *fgamma_blob);
> > > +
> > > +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u3=
2 *coeffs);
> > > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u3=
2 *coeffs);
> > > +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coef=
fs);
> > > =20
> > >  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 colo=
r_range);
> > > =20
> > > -#endif
> > > +#endif /*_KOMEDA_COLOR_MGMT_H_*/
> > >=20
> >=20
> > BR,
> > Mihail
> >=20
> >=20
>=20

BR,
Mihail



