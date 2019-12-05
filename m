Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08FC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17A24648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8qxyH1mi";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8qxyH1mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfLEIxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:53:21 -0500
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:1134
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfLEIxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXDfAQ8ZqwuYaMoIouNhcfirddFXMrV/He5r86420kY=;
 b=8qxyH1miwiUqYphPSFAtZSg1NjlfIHbmmscBvvAP71bCUuuBgV/cR9a3vxFAim6b2RWgc4j+s1v+gEXYJ0j0oaC1IT3q6zfIb5YNo55abPI7F0GF3RtBDsmTfAzxjstev+shmNUbUbu1x3yTR5mwtj/76DP08h5nmpSHYqRLC0c=
Received: from VI1PR08CA0190.eurprd08.prod.outlook.com (2603:10a6:800:d2::20)
 by AM6PR08MB3910.eurprd08.prod.outlook.com (2603:10a6:20b:6f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Thu, 5 Dec
 2019 08:53:10 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0190.outlook.office365.com
 (2603:10a6:800:d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 08:53:10 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:53:10 +0000
Received: ("Tessian outbound 1e3e4a1147b7:v37"); Thu, 05 Dec 2019 08:53:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4be44e811d08ee72
X-CR-MTA-TID: 64aa7808
Received: from 4ef3277b09ea.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1061346F-8102-4005-9A60-57FDDC9DE735.1;
        Thu, 05 Dec 2019 08:53:04 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4ef3277b09ea.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNV4BadoukXlOFRHuZ0NbPkhZZvwgXPv88zomHygjgLtyKTsaJ7cTz7YLz4IgKdCpy4c86tLmZsxgOJMiyo4OwAVtoOcl4l3XDRV8MNRFiutCmSwbkO4Vmdnw3hcaq4lGQ/7CBjhoFjyBNF1bhIn8T8fWFV3Ia4JLf9jV/yrO8PJk1tWMT1GjXvx6Z0gTDqFD0Pdqt7Rtyq0JIS6Rw3we9i5sg/iGSHqjMNtQc0i0v61trDE5I7KkKBs7gwn0sPp8AyXFYgMp8CdCJHKr7JC14ibGbTI1VXroP5AtYDDEEowmWDZ+KW/NS/UCqa9bmoPREAEP9Hp3DJt/L5s7nz+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXDfAQ8ZqwuYaMoIouNhcfirddFXMrV/He5r86420kY=;
 b=nR4gdnQulaiV8E+vQx7z2d+pI6wP6pT9C+yjvSDTu7QNJvKFyqDFW2Uic70jWJCCdFhh9a2No5QjSV8sV5kG/O6UeqZ1BlQqGw1y885Y27i8u8e7/fwPoCwnOXOaL/odMYX9M8Uks1scJgh8ayAX+syw1tJwsTnLzTXWQQKropkrdo8Ue0nMAhnNJs5Qb89N3zqL0ZBrACzdlYduqCT731boJBe+v3QM+W6j7Pv7cQ/GPpjW0LShIz2gWsdxdzsZRarD9Hy9e4x6o+SEc9QJXBSRMvNYAZfGETWF5QDsC0aAuRBRIZAkDb5uMz0sRRcED8RRyu/PRWmg7wLZdVlQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXDfAQ8ZqwuYaMoIouNhcfirddFXMrV/He5r86420kY=;
 b=8qxyH1miwiUqYphPSFAtZSg1NjlfIHbmmscBvvAP71bCUuuBgV/cR9a3vxFAim6b2RWgc4j+s1v+gEXYJ0j0oaC1IT3q6zfIb5YNo55abPI7F0GF3RtBDsmTfAzxjstev+shmNUbUbu1x3yTR5mwtj/76DP08h5nmpSHYqRLC0c=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5151.eurprd08.prod.outlook.com (20.179.31.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 08:53:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:53:03 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>, nd <nd@arm.com>,
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
Subject: Re: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQnHODp0nh43k+zk6WDkpPTxKemwPIAgAFJKYCAADYygIADEfAA
Date:   Thu, 5 Dec 2019 08:53:02 +0000
Message-ID: <20191205085256.GA11212@jamwan02-TSP300>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <15788924.1fOzIsmBsr@e123338-lin> <20191203064559.GA17018@jamwan02-TSP300>
 <2125422.nYgIr5rE5T@e123338-lin>
In-Reply-To: <2125422.nYgIr5rE5T@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1695b376-52d3-4e2b-a9ac-08d779608e1a
X-MS-TrafficTypeDiagnostic: VE1PR08MB5151:|VE1PR08MB5151:|AM6PR08MB3910:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB39107C949F377DB03CCCA54CB35C0@AM6PR08MB3910.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(66556008)(66476007)(66946007)(64756008)(66446008)(8936002)(33656002)(81156014)(6636002)(26005)(81166006)(8676002)(2906002)(86362001)(305945005)(229853002)(6436002)(7736002)(6486002)(5660300002)(6512007)(9686003)(3846002)(6116002)(1076003)(4326008)(6862004)(76176011)(11346002)(25786009)(33716001)(99286004)(52116002)(316002)(58126008)(6246003)(186003)(54906003)(14454004)(6506007)(71190400001)(55236004)(102836004)(14444005)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5151;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DsGM2b4UKqJv0HCqi/z0SBr5HMDe3qyrxTJ+Gb53Sr0Mj6vYuTDIeuvi7lnZDIEscxmwdxcY/91X7wQqmOfgyCijg0ohgut1Vaz1HmbT8B67vqOIP1jCBkaYjGS7FDH6ql9gpIQUqJHfyBcFrPYxkDmUfPAVva47ftaqJ3+xd2fjKxkYi803xaLmY0nMc2aHQlaRwXK8ix1ihR3SXcgmiyLu8/RY0Aq0BqNwK2EtbcxWCKUbBdWUBBzQn4CW8oEJq2Q3rBA8kM+3FilnA3IiJowSs1tcKa+359TtFEo8JC+s7I9+Woq+wNBQoZZGwWMn/LvMZOwpgDmFmx9QbRciYyvyi7BK/VjNWKDHbrzzKDorUshobAXZVZINJ2tFIh7oI4NAwek+ceg4P3VrU7BEusKHgtk0LjGlwXT4KDKo7P8HBvNO1/XQ3qfjJNoeWN4R
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3205F69480ACE44B1635AD6C259A461@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5151
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(102836004)(11346002)(336012)(478600001)(26826003)(26005)(14454004)(186003)(50466002)(76176011)(6636002)(4326008)(6862004)(6246003)(25786009)(97756001)(99286004)(76130400001)(6486002)(6512007)(14444005)(229853002)(54906003)(9686003)(3846002)(36906005)(70586007)(58126008)(6506007)(70206006)(6116002)(305945005)(7736002)(23726003)(86362001)(316002)(2906002)(22756006)(5660300002)(46406003)(8676002)(356004)(81166006)(81156014)(1076003)(33716001)(8936002)(8746002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3910;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a4ce101-22ae-4b97-f32a-08d779608976
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1b6p7vIlZp5ph2jN3cJRmMKsL7px+u242Y+cUUwM7eaGo87njsGzPXglUJe/DXWIxgvHG2pwSul+yzLzz3i3Lu22OXQJR5TjnEGMg3xHsN0t4FBtzgpvsl46RIDt/z2tbswznrT7t+40zcCVzyeK9MminLFj4B1YrTE1IlNHh+PO6PLqUcBkh5iLCYGaYJ0+qUNJT9mspuCc7kveT00ptpjRsm6X6usDVvW5r2WnO0lxYaUKbb2JPy4S9XPCPDN7EB0msKB913fitvCzzNh8vtH3OkKbh4pZF/if6fPS3W9fyGZoN2bZ8YCqEN3I1noUBOds142GiXiGZBgC4SnOIyxSrKWUogGSonuXnicDRvIZMiKFM1GClrcAd+lx2uLFWQEZtK3/iTSpEJzFHPj0k7QGTrf7AY6q5+sgPNtS6EdRBrEtCYzt+Objw3dnE5+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:53:10.2676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1695b376-52d3-4e2b-a9ac-08d779608e1a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 09:59:57AM +0000, Mihail Atanassov wrote:
> On Tuesday, 3 December 2019 06:46:06 GMT james qian wang (Arm Technology =
China) wrote:
> > On Mon, Dec 02, 2019 at 11:07:52AM +0000, Mihail Atanassov wrote:
> > > On Thursday, 21 November 2019 08:17:45 GMT james qian wang (Arm Techn=
ology China) wrote:
> > > > D32 is simple version of D71, the difference is:
> > > > - Only has one pipeline
> > > > - Drop the periph block and merge it to GCU
> > > >=20
> > > > v2: Rebase.
> > > >=20
> > > > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.w=
ang@arm.com>
> > > > ---
> > > >  .../drm/arm/display/include/malidp_product.h  |  3 +-
> > > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++---=
----
> > > >  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
> > > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
> > > >  5 files changed, 44 insertions(+), 18 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b=
/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > index 96e2e4016250..dbd3d4765065 100644
> > > > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > > @@ -18,7 +18,8 @@
> > > >  #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id))=
 & 0xFF)
> > > > =20
> > > >  /* Mali-display product IDs */
> > > > -#define MALIDP_D71_PRODUCT_ID   0x0071
> > > > +#define MALIDP_D71_PRODUCT_ID	0x0071
> > > > +#define MALIDP_D32_PRODUCT_ID	0x0032
> > > > =20
> > > >  union komeda_config_id {
> > > >  	struct {
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c=
 b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > index 6dadf4413ef3..c7f7e9c545c7 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > @@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71_d=
ev *d71,
> > > > =20
> > > >  	ctrlr =3D to_ctrlr(c);
> > > > =20
> > > > -	ctrlr->supports_dual_link =3D true;
> > > > +	ctrlr->supports_dual_link =3D d71->supports_dual_link;
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > index 9b3bf353b6cc..2d429e310e5b 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > > @@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_d=
ev *mdev)
> > > >  		goto err_cleanup;
> > > >  	}
> > > > =20
> > > > -	/* probe PERIPH */
> > > > +	/* Only the legacy HW has the periph block, the newer merges the =
periph
> > > > +	 * into GCU
> > > > +	 */
> > > >  	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> > > > -	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> > > > -		DRM_ERROR("access blk periph but got blk: %d.\n",
> > > > -			  BLOCK_INFO_BLK_TYPE(value));
> > > > -		err =3D -EINVAL;
> > > > -		goto err_cleanup;
> > > > +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
> > > > +		d71->periph_addr =3D NULL;
> > > > +
> > > > +	if (d71->periph_addr) {
> > > > +		/* probe PERIPHERAL in legacy HW */
> > > > +		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_I=
D);
> > > > +
> > > > +		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 204=
8;
> > > > +		d71->max_vsize		=3D 4096;
> > > > +		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > > > +		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
> > > > +		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
> > > > +	} else {
> > > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
> > > > +		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
> > > > +		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
> > > > +
> > > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
> > > > +		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
> > > > +		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
> > > > +		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
> > > >  	}
> > > > =20
> > > > -	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID=
);
> > > > -
> > > > -	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048=
;
> > > > -	d71->max_vsize		=3D 4096;
> > > > -	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > > > -	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : fals=
e;
> > > > -	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> > > > -
> > > >  	for (i =3D 0; i < d71->num_pipelines; i++) {
> > > >  		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
> > > >  					   &d71_pipeline_funcs);
> > > > @@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_dev=
 *mdev)
> > > >  	}
> > > > =20
> > > >  	/* loop the register blks and probe */
> > > > -	i =3D 2; /* exclude GCU and PERIPH */
> > > > +	i =3D 1; /* exclude GCU */
> > > >  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> > > >  	while (i < d71->num_blocks) {
> > > >  		blk_base =3D mdev->reg_base + (offset >> 2);
> > > > @@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_dev=
 *mdev)
> > > >  			err =3D d71_probe_block(d71, &blk, blk_base);
> > > >  			if (err)
> > > >  				goto err_cleanup;
> > > > -			i++;
> > > >  		}
> > > > =20
> > > > +		i++;
> > >=20
> > > This change doesn't make much sense if you want to count how many
> > > blocks are available, since you're now counting the reserved ones, to=
o.
> >=20
> > That's because for D32 num_blocks includes the reserved blocks.
> >=20
> > > On the counting note, the prior code rides on the assumption the peri=
ph
> > > block is last in the map, and I don't see how you still handle not
> > > counting it in the D71 case.
> >=20
> > Since D71 has one reserved block, and now we count reserved block.
> >=20
> > So now no matter D32 or D71:
> >   num_blocks =3D n_valid_block + n_reserved_block + GCU.
>=20
> So at least we need that comment dropped in with the code. Future HW
> might break your assumption here once more and it will then be useful
> to know why this works for both products.

OK, will add a comments like.

/* Per HW design: num_blocks =3D n_valid_block + n_reserved_block + GCU */

And Per HW, all arch-v1.x include (d71/d32/d77) follows this rule,
the old logic which skip the reserved-block actually not right.

> I'd personally abstract that a bit behind a small helper func and
> handle different products separately. It's a bit of duplication but
> much easier to comprehend. Saved cycles reading code =3D=3D Good Thing(tm=
).

Our komeda driver has two layers, common layer and chip. current we
only have one chip folder d71 for support arch-v1.x prodcut.
And our future products (arch-v2.x) will have its own chip folder, and
its own chip specific code.

Thanks
James
>=20
> >=20
> > Thanks
> > James
> > >=20
> > > >  		offset +=3D D71_BLOCK_SIZE;
> > > >  	}
> > > > =20
> > > > @@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct kome=
da_chip_info *chip)
> > > > =20
> > > >  	switch (product_id) {
> > > >  	case MALIDP_D71_PRODUCT_ID:
> > > > +	case MALIDP_D32_PRODUCT_ID:
> > > >  		funcs =3D &d71_chip_funcs;
> > > >  		break;
> > > >  	default:
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/dr=
ivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > index 1727dc993909..81de6a23e7f3 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > > @@ -72,6 +72,19 @@
> > > >  #define GCU_CONTROL_MODE(x)	((x) & 0x7)
> > > >  #define GCU_CONTROL_SRST	BIT(16)
> > > > =20
> > > > +/* GCU_CONFIGURATION registers */
> > > > +#define GCU_CONFIGURATION_ID0	0x100
> > > > +#define GCU_CONFIGURATION_ID1	0x104
> > > > +
> > > > +/* GCU configuration */
> > > > +#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
> > > > +#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
> > > > +#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
> > > > +#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
> > > > +#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
> > > > +#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
> > > > +#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
> > > > +
> > > >  /* GCU opmode */
> > > >  #define INACTIVE_MODE		0
> > > >  #define TBU_CONNECT_MODE	1
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > index b7a1097c45c4..ad38bbc7431e 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > > @@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platfo=
rm_device *pdev)
> > > > =20
> > > >  static const struct of_device_id komeda_of_match[] =3D {
> > > >  	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> > > > +	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
> > > >  	{},
> > > >  };
> > > > =20
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
