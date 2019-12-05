Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F74C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513882245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 12:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a/fhLRre";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a/fhLRre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfLEMDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:03:03 -0500
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:41671
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbfLEMDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upJZ/1UXfJFJEq/JCwD85T4aQyewjdSi7ui43YR+mOA=;
 b=a/fhLRrer8lrVfnLeZvmzH8tHzAfDX/skF9cWbl4eNU8GdsPXaHJkFvXlagyo7IbhKQpBCV9LnUYBxcG8KAsuiynfqCRaKPTEj6wZRsRrm9pJbmpF2iU/pMKvrL6Jq15cAmUG0GdBbXSNFg+z6n7HaxML75W4BmTHlv6MAe0+WM=
Received: from VI1PR08CA0095.eurprd08.prod.outlook.com (2603:10a6:800:d3::21)
 by HE1PR0801MB1868.eurprd08.prod.outlook.com (2603:10a6:3:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Thu, 5 Dec
 2019 12:02:53 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR08CA0095.outlook.office365.com
 (2603:10a6:800:d3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 12:02:53 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT062.mail.protection.outlook.com (10.152.17.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 12:02:52 +0000
Received: ("Tessian outbound 58ad627f3883:v37"); Thu, 05 Dec 2019 12:02:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc24f7eb0faa1358
X-CR-MTA-TID: 64aa7808
Received: from e83a11f60396.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FD9F8365-1445-495C-B0BF-C4A59CA4AB38.1;
        Thu, 05 Dec 2019 12:02:47 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e83a11f60396.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 12:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvCDGPdlYDVCrKIetfBiwSEF5TT16gir1yI4jjUAw6MlwuMJERSWOsj1qh4y6G6w3aPOEmqJSS4U0gNv3r5ml2lVlv6hzU9L7yQqeVrvCpnfzTGVQBzS5c0vMdnf2oQn7ZAsCkZlxUUtjowmYpumY+C7eEg63zaGzDLnuPD2YToQvMmWJb798d/2RuvW7VoSCAIrqIVfP7UArAd5RRp1uxlVjE1+fftU7Kfci2fCAxFlUC0s906AIprwvz2MxgxEF9faYzaknaeLJ6+B9CwdO7K4ZZpQwPsL7u+qKFiF4xpLFhjs5vI+pnZl/lkLWxH7TOqnBFj5wvqli7755FhPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upJZ/1UXfJFJEq/JCwD85T4aQyewjdSi7ui43YR+mOA=;
 b=mIGQhbYyY8hBY0XilGegQ0Wthpm6LN+2MNfg4/IAYiyt5/pQsgLxa+CJRj3JboCn0T3tc24Bguc8oCVZbbTomqIKp/C+bV2bGe6XorF/m8dekMIt3vICTGLxr+3lMOgF+5Qas94f4TONoEp8ovaY0RmHwjwq25p4keCDFFIP/bXZVBRQ9foFdunwn85bIqSF+FSspzDbom5GRfZZtq8vbBq89VD9OA5QFJ31VFd+h50cetxU6matWiq421TP2nwe4PzdmSyzDekppGVmZbtljQuZoVzAoVSffaIOsOzWUl6t45bTD2UOF26GWGDAZsZTGQsPCs25owMqKUkkv5//lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upJZ/1UXfJFJEq/JCwD85T4aQyewjdSi7ui43YR+mOA=;
 b=a/fhLRrer8lrVfnLeZvmzH8tHzAfDX/skF9cWbl4eNU8GdsPXaHJkFvXlagyo7IbhKQpBCV9LnUYBxcG8KAsuiynfqCRaKPTEj6wZRsRrm9pJbmpF2iU/pMKvrL6Jq15cAmUG0GdBbXSNFg+z6n7HaxML75W4BmTHlv6MAe0+WM=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3725.eurprd08.prod.outlook.com (20.178.13.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 5 Dec 2019 12:02:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 12:02:45 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        nd <nd@arm.com>, "airlied@linux.ie" <airlied@linux.ie>,
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
Subject: Re: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQsEzx6hPV6tkqMxpVwDMM7k6emwEqAgAFJ2gCAADItgIADFfMAgAAwrYA=
Date:   Thu, 5 Dec 2019 12:02:45 +0000
Message-ID: <7467899.rIHYG2lMSP@e123338-lin>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <2125422.nYgIr5rE5T@e123338-lin> <20191205085256.GA11212@jamwan02-TSP300>
In-Reply-To: <20191205085256.GA11212@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: CWLP123CA0162.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:88::30) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25623fb4-238c-4c8b-0551-08d7797b0ea3
X-MS-TrafficTypeDiagnostic: VI1PR08MB3725:|VI1PR08MB3725:|HE1PR0801MB1868:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB186886CC723FCF168174E8908F5C0@HE1PR0801MB1868.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6512007)(4326008)(25786009)(14444005)(186003)(9686003)(6486002)(64756008)(66476007)(14454004)(66446008)(66946007)(66556008)(76176011)(316002)(6862004)(2906002)(8936002)(5660300002)(6636002)(52116002)(81156014)(81166006)(229853002)(102836004)(8676002)(305945005)(33716001)(71190400001)(26005)(11346002)(54906003)(86362001)(478600001)(99286004)(71200400001)(6506007)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3725;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: szuwdR4hvKVxwU0YtBnLtbrYtLkaUL+rv93bHNTBsemz6Yd2igfJk95xkGPqpU2wGxlEBDhAw35wbiYvcuJDMm7DT2ySccIMvFam15loX4/nHF/jPuoQOLcctDBlaeN3tR/e31rYz44k9DNvO57cX6gYgSPpUSvHF5u72q0IlmvmoNfIglE4g8WrsqEmeKFx61yw/YXY0vaJlUcfhmJNS9Ko2iXYFy9jJP35FrQH+7xJCOS5J8GiH/U9Cer0x217W6SC8e9vRO27DrHD64N70M5SOg3ZJsiJbgf+F4MwzBg26v76ypkm7XMjZlI8JGdJlygS6M/ABOQsQDWVxUHOlepKgIMtTxDdUiu5aa2t1nEzdLiK0+RtJGUao6FBTQVEiklz5xdsgcHJ2IIfl32lgZ1QGdPbSA3iEhwwmlhXK8n9n0i5uuW710P8rhByB81eFG5cwpJkFTol6HKTGXabobmdUxwNfk5pgeHl24mD+Yg6U8fsvSBFF2MX000MElVW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECD6F9AEB5D988468CF68DB631492A46@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3725
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(2906002)(6862004)(14454004)(4326008)(6512007)(6486002)(14444005)(9686003)(70586007)(186003)(22756006)(50466002)(36906005)(5660300002)(478600001)(6636002)(70206006)(99286004)(76176011)(23726003)(86362001)(26826003)(33716001)(81166006)(81156014)(336012)(46406003)(229853002)(11346002)(25786009)(6506007)(97756001)(8676002)(76130400001)(305945005)(26005)(102836004)(54906003)(316002)(8936002)(356004)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1868;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 14154fb2-83f8-4ce5-f74a-08d7797b0a05
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iqfl90fIeNEjUfmIe+vxFA1rxjFKxENYtGw1d3FgL3dd97wWx9gfkJiYGgzbrQYWFjlpe2nwBSgcZ1HdK2jLmzkLtxYWYkLlIuFJNEv9ebz2nRCn25wGtlh5zTY9ndm/JvNAfBzo3OuZpR8FH9yz9f3s+Sf8Wf//FK5i9/x1gHWLSEQ52/QUjw+o+P7opjAGmDz9JEQuKwcgiI0ratcSR6ez769doHxxFt0pf3O1lGqdJqw2pBl8MjvqNkkC+YFbV2pxqwv1SefN6NFgSRVLudyNv3oGtXyiadEi+BfQhNc9vbIOp1O4um9V44h9Krq0bXZWORxeLW/t1IeWrAbBUMYEoVSXfPS3nygd/2CqTXlGkjWPeI7RyDPpb3+lMMeJBMe9GpDW81KeOuUbHTDfIkzLafbnh8twewZfzg8ND/dHKak7nVgX3b1dgRJWtL2puAADdJDWfkyYxFsoF1SCy4UFRZOpjhTucuAcZ06UJuMvRFfUmAlVuGqzti3V0mQi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 12:02:52.8916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25623fb4-238c-4c8b-0551-08d7797b0ea3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 5 December 2019 08:53:02 GMT james qian wang (Arm Technology C=
hina) wrote:
> On Tue, Dec 03, 2019 at 09:59:57AM +0000, Mihail Atanassov wrote:
> > On Tuesday, 3 December 2019 06:46:06 GMT james qian wang (Arm Technolog=
y China) wrote:
> > > On Mon, Dec 02, 2019 at 11:07:52AM +0000, Mihail Atanassov wrote:
> > > > On Thursday, 21 November 2019 08:17:45 GMT james qian wang (Arm Tec=
hnology China) wrote:
> > > > > D32 is simple version of D71, the difference is:
> > > > > - Only has one pipeline
> > > > > - Drop the periph block and merge it to GCU
> > > > >=20
> > > > > v2: Rebase.
> > > > >=20
> > > > > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian=
.wang@arm.com>
> > > > > ---
> > > > >  .../drm/arm/display/include/malidp_product.h  |  3 +-
> > > > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > > > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-=
------
> > > > >  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
> > > > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
> > > > >  5 files changed, 44 insertions(+), 18 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h=
 b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > > index 96e2e4016250..dbd3d4765065 100644
> > > > > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > > @@ -18,7 +18,8 @@
> > > > >  #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id=
)) & 0xFF)
> > > > > =20
> > > > >  /* Mali-display product IDs */
> > > > > -#define MALIDP_D71_PRODUCT_ID   0x0071
> > > > > +#define MALIDP_D71_PRODUCT_ID	0x0071
> > > > > +#define MALIDP_D32_PRODUCT_ID	0x0032
> > > > > =20
> > > > >  union komeda_config_id {
> > > > >  	struct {
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component=
.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > index 6dadf4413ef3..c7f7e9c545c7 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > > @@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71=
_dev *d71,
> > > > > =20
> > > > >  	ctrlr =3D to_ctrlr(c);
> > > > > =20
> > > > > -	ctrlr->supports_dual_link =3D true;
> > > > > +	ctrlr->supports_dual_link =3D d71->supports_dual_link;
> > > > > =20
> > > > >  	return 0;
> > > > >  }
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > > index 9b3bf353b6cc..2d429e310e5b 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > > @@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda=
_dev *mdev)
> > > > >  		goto err_cleanup;
> > > > >  	}
> > > > > =20
> > > > > -	/* probe PERIPH */
> > > > > +	/* Only the legacy HW has the periph block, the newer merges th=
e periph
> > > > > +	 * into GCU
> > > > > +	 */
> > > > >  	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> > > > > -	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> > > > > -		DRM_ERROR("access blk periph but got blk: %d.\n",
> > > > > -			  BLOCK_INFO_BLK_TYPE(value));
> > > > > -		err =3D -EINVAL;
> > > > > -		goto err_cleanup;
> > > > > +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
> > > > > +		d71->periph_addr =3D NULL;
> > > > > +
> > > > > +	if (d71->periph_addr) {
> > > > > +		/* probe PERIPHERAL in legacy HW */
> > > > > +		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION=
_ID);
> > > > > +
> > > > > +		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2=
048;
> > > > > +		d71->max_vsize		=3D 4096;
> > > > > +		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : =
1;
> > > > > +		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
> > > > > +		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
> > > > > +	} else {
> > > > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
> > > > > +		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
> > > > > +		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
> > > > > +
> > > > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
> > > > > +		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
> > > > > +		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
> > > > > +		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
> > > > >  	}
> > > > > =20
> > > > > -	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_=
ID);
> > > > > -
> > > > > -	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 20=
48;
> > > > > -	d71->max_vsize		=3D 4096;
> > > > > -	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1=
;
> > > > > -	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : fa=
lse;
> > > > > -	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> > > > > -
> > > > >  	for (i =3D 0; i < d71->num_pipelines; i++) {
> > > > >  		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline)=
,
> > > > >  					   &d71_pipeline_funcs);
> > > > > @@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_d=
ev *mdev)
> > > > >  	}
> > > > > =20
> > > > >  	/* loop the register blks and probe */
> > > > > -	i =3D 2; /* exclude GCU and PERIPH */
> > > > > +	i =3D 1; /* exclude GCU */
> > > > >  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> > > > >  	while (i < d71->num_blocks) {
> > > > >  		blk_base =3D mdev->reg_base + (offset >> 2);
> > > > > @@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_d=
ev *mdev)
> > > > >  			err =3D d71_probe_block(d71, &blk, blk_base);
> > > > >  			if (err)
> > > > >  				goto err_cleanup;
> > > > > -			i++;
> > > > >  		}
> > > > > =20
> > > > > +		i++;
> > > >=20
> > > > This change doesn't make much sense if you want to count how many
> > > > blocks are available, since you're now counting the reserved ones, =
too.
> > >=20
> > > That's because for D32 num_blocks includes the reserved blocks.
> > >=20
> > > > On the counting note, the prior code rides on the assumption the pe=
riph
> > > > block is last in the map, and I don't see how you still handle not
> > > > counting it in the D71 case.
> > >=20
> > > Since D71 has one reserved block, and now we count reserved block.
> > >=20
> > > So now no matter D32 or D71:
> > >   num_blocks =3D n_valid_block + n_reserved_block + GCU.
> >=20
> > So at least we need that comment dropped in with the code. Future HW
> > might break your assumption here once more and it will then be useful
> > to know why this works for both products.
>=20
> OK, will add a comments like.
>=20
> /* Per HW design: num_blocks =3D n_valid_block + n_reserved_block + GCU *=
/
>=20
> And Per HW, all arch-v1.x include (d71/d32/d77) follows this rule,
> the old logic which skip the reserved-block actually not right.

Well, given this ^...

>=20
> > I'd personally abstract that a bit behind a small helper func and
> > handle different products separately. It's a bit of duplication but
> > much easier to comprehend. Saved cycles reading code =3D=3D Good Thing(=
tm).

...then my comment here ^ no longer applies. :)

I'd be a bit happier if that fix is split out into its own patch. Mind
doing that?

>=20
> Our komeda driver has two layers, common layer and chip. current we
> only have one chip folder d71 for support arch-v1.x prodcut.
> And our future products (arch-v2.x) will have its own chip folder, and
> its own chip specific code.

The point is moot now, but I meant adding a few small static functions in
the same file. Nothing to do with layering :).

>=20
> Thanks
> James
> >=20
> > >=20
> > > Thanks
> > > James
> > > >=20
> > > > >  		offset +=3D D71_BLOCK_SIZE;
> > > > >  	}
> > > > > =20
> > > > > @@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct ko=
meda_chip_info *chip)
> > > > > =20
> > > > >  	switch (product_id) {
> > > > >  	case MALIDP_D71_PRODUCT_ID:
> > > > > +	case MALIDP_D32_PRODUCT_ID:
> > > > >  		funcs =3D &d71_chip_funcs;
> > > > >  		break;
> > > > >  	default:
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/=
drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > index 1727dc993909..81de6a23e7f3 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > > @@ -72,6 +72,19 @@
> > > > >  #define GCU_CONTROL_MODE(x)	((x) & 0x7)
> > > > >  #define GCU_CONTROL_SRST	BIT(16)
> > > > > =20
> > > > > +/* GCU_CONFIGURATION registers */
> > > > > +#define GCU_CONFIGURATION_ID0	0x100
> > > > > +#define GCU_CONFIGURATION_ID1	0x104
> > > > > +
> > > > > +/* GCU configuration */
> > > > > +#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
> > > > > +#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
> > > > > +#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
> > > > > +#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
> > > > > +#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
> > > > > +#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
> > > > > +#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
> > > > > +
> > > > >  /* GCU opmode */
> > > > >  #define INACTIVE_MODE		0
> > > > >  #define TBU_CONNECT_MODE	1
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > > index b7a1097c45c4..ad38bbc7431e 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > > @@ -125,6 +125,7 @@ static int komeda_platform_remove(struct plat=
form_device *pdev)
> > > > > =20
> > > > >  static const struct of_device_id komeda_of_match[] =3D {
> > > > >  	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> > > > > +	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
> > > > >  	{},
> > > > >  };
> > > > > =20
> > > > >=20
> > > >=20
> > > >=20
> > >=20
> >=20
> >=20
>=20


--=20
Mihail



