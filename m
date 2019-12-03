Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E6120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rfiCGBZs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rfiCGBZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLCGq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:46:26 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:17505
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InwpahARXwcQQKbK6oyIQABye0nSOUPA+dfNUEH/Yoo=;
 b=rfiCGBZs0hy0FtgBEzmOepyXxewQdj/8xfR0JOzrV/ZbwQmN3M3v1HIHS2LNLTxscwvDTd8Jz/OyBx8+4Tz/YSWdo7+CuEDpbYluTxD5JSB8qzoanZ0AtiKo84X8azb74HY7z/8ZgSKO/NTVVuF/iMFjgNsKaRLBlfGCJqO0Eq0=
Received: from VI1PR08CA0194.eurprd08.prod.outlook.com (2603:10a6:800:d2::24)
 by AM6PR08MB5240.eurprd08.prod.outlook.com (2603:10a6:20b:ec::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Tue, 3 Dec
 2019 06:46:15 +0000
Received: from AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VI1PR08CA0194.outlook.office365.com
 (2603:10a6:800:d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Tue, 3 Dec 2019 06:46:15 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT011.mail.protection.outlook.com (10.152.16.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 3 Dec 2019 06:46:15 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Tue, 03 Dec 2019 06:46:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 25fcf5caa8be31fe
X-CR-MTA-TID: 64aa7808
Received: from ef8e2e4c748e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E4C5B765-469F-4F56-9627-BA54AD3DD2D1.1;
        Tue, 03 Dec 2019 06:46:09 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ef8e2e4c748e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Dec 2019 06:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhffT7YSgAKIb3gT+LJmYxUmaP6SOB1e9l9pMdbxdBb7CnRppu8Llb88F+1VnFaqWpr72FUxZWGlSDnGYL0DKTJ2AGBDdCKXyJm6YVt3ypgsaxlbWWIIxlC9fw7NXSXsl7Dmf/Bq1z2lsqHIsGk4kG/p+VRiFV/FgE8ACy8nxJxbcm2KsFbc2zMZkYAj9n0XRwsz96MA1bkK5BMIgQ1zHpJdzn9F3CuPKaLyDyw73RHZF7hSE5Q1Px7AafcggOXY69Zo3sTpS/pFvtBKGIipXKDLMSahKVfMMe2m1v6c24/n3KdzbbW38wn+WigxW1qMMr2T1OWqEU9ZZTJh1e7rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InwpahARXwcQQKbK6oyIQABye0nSOUPA+dfNUEH/Yoo=;
 b=AgWkzh5OqXCiNlQMipR5WGcvf+SBY+2LAgLfvqbwf0+TR7fFOIfxyaw82e57WXKZiQ9zlP73Z8d8JYpzR2r48Tt1A3pGoWQDD2W2uEvtxOhygTsC5oaG8iOrzkqEzeHbtqibKmiPrmwY+Hx2NoH/FRzv0Mxb4lNIL0ZH55POWq/PGhemcKk1/wlECqK31kPN1/ltxBVhvm3ddFOYFrg4Roxsa/FAgJfcV8dEBKoxLtR4k3reylI/vDtkGKqTlfwED49qpT0sXnnsI+G6W7s0MLuq9MHYj3iywntrFl0fzlUztl6RPAt9nh0Rd5s5u1iHEhPYQ+SF8zbAPu257Y7FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InwpahARXwcQQKbK6oyIQABye0nSOUPA+dfNUEH/Yoo=;
 b=rfiCGBZs0hy0FtgBEzmOepyXxewQdj/8xfR0JOzrV/ZbwQmN3M3v1HIHS2LNLTxscwvDTd8Jz/OyBx8+4Tz/YSWdo7+CuEDpbYluTxD5JSB8qzoanZ0AtiKo84X8azb74HY7z/8ZgSKO/NTVVuF/iMFjgNsKaRLBlfGCJqO0Eq0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4640.eurprd08.prod.outlook.com (10.255.27.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 06:46:06 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 06:46:06 +0000
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
Subject: Re: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQnHODp0nh43k+zk6WDkpPTxKemwPIAgAFJKYA=
Date:   Tue, 3 Dec 2019 06:46:06 +0000
Message-ID: <20191203064559.GA17018@jamwan02-TSP300>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <20191121081717.29518-3-james.qian.wang@arm.com>
 <15788924.1fOzIsmBsr@e123338-lin>
In-Reply-To: <15788924.1fOzIsmBsr@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebfad314-8fec-4473-a431-08d777bc7e52
X-MS-TrafficTypeDiagnostic: VE1PR08MB4640:|VE1PR08MB4640:|AM6PR08MB5240:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB524096C65C474A1938DE2C8AB3420@AM6PR08MB5240.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 02408926C4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(26005)(6512007)(9686003)(186003)(102836004)(55236004)(11346002)(446003)(478600001)(6862004)(99286004)(14454004)(66066001)(6246003)(54906003)(256004)(66556008)(64756008)(25786009)(58126008)(6436002)(66946007)(6486002)(66476007)(76176011)(6506007)(386003)(52116002)(4326008)(229853002)(66446008)(316002)(6116002)(14444005)(3846002)(33716001)(2906002)(5660300002)(71190400001)(33656002)(71200400001)(1076003)(81156014)(305945005)(81166006)(86362001)(8676002)(7736002)(8936002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4640;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rdPQ4rzElsMrOSEqGzKx9PBPvyJT5KwPP4nM04Q6jHp4GXBI/6fmxL5u/o4Epo8iePV6qx75PDnJQAZNe/1HeCPPMU60y7cfy5a9TBsuJLX/vu4eCLXy30k7p7gQX8xjGssNzI2N556/6ccsIdf0CgJT4vcGQsyMCi0FPCkBNUg/pPWqkyUSHu/4dy+H9mSCy9NIji8KMc3+4sPhGjY98MwxWKbJqZJrSxCATWrSg0JKTJbgtA81CArlSzBcMrLXTqqD2hXzoJt/svb1Xj8yvbCG03c2rYC/krDVO0unF2G/ATKMJ0TBBtELAuR3+k1xQt/ntHSYoA6a/iEs76uG0pYt3SpXixfdxjvzAVpZmS2XY0MhgXBuVilS0RRiCZLTDnppheEf6GGGAk4wJNo12sQQcLT8Q4BPyhK+tXMk2KtocbbyXJN99jiQljTSnGlB
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E431424A51237E4985D486BD46F29453@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4640
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(6512007)(6246003)(3846002)(6116002)(356004)(316002)(6862004)(336012)(76176011)(102836004)(386003)(478600001)(25786009)(6486002)(81156014)(81166006)(8676002)(8936002)(22756006)(47776003)(8746002)(305945005)(11346002)(33716001)(446003)(46406003)(186003)(26005)(14454004)(2906002)(86362001)(36906005)(97756001)(23726003)(14444005)(1076003)(50466002)(6506007)(7736002)(33656002)(229853002)(26826003)(66066001)(70206006)(70586007)(5660300002)(54906003)(106002)(4326008)(99286004)(9686003)(6636002)(76130400001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5240;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5864fb55-99ae-497d-5cf1-08d777bc78db
NoDisclaimer: True
X-Forefront-PRVS: 02408926C4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBx/Oo6VrZIlJw1bslKZ6PNmaksO+0kQrKTj93+1P0JukLSmqyyjWnhu22rGrKIqSFFuk3JfDLY4BahjkusM+eccBFEwXRH6QOm3O3OBL7dnCKUp71Ln+MvnCDYaavMbn3z4smwJgY7AuvUIoHXtMX3ln8iChp3OrMdtYNyEV/LdyNxUGqhmFIM1iLyxxG5W3oMurNpBr+iMb8bezRbZTjS3anMBM08odN4KK9fF6uiwcocW6R0YWRXxMxCm33v4dG27n23uiNHQxYtbamKkOjlWiRnFX/aipY4R24SfK3cxf432RUV1LYnGeHXqgL5jf5nxLyOhqRPO2xD0PD38iQ8fJN/ERHnpo/MwTRque9naRKaFiRY0bRRj8n7ueEB1t9d9fOTOAAYTwHlf28b2CkNWwh/KwgZZRB2rGrMY8Haxlu+61yiVb87qO6hkKxNy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 06:46:15.2346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfad314-8fec-4473-a431-08d777bc7e52
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:07:52AM +0000, Mihail Atanassov wrote:
> On Thursday, 21 November 2019 08:17:45 GMT james qian wang (Arm Technolog=
y China) wrote:
> > D32 is simple version of D71, the difference is:
> > - Only has one pipeline
> > - Drop the periph block and merge it to GCU
> >=20
> > v2: Rebase.
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../drm/arm/display/include/malidp_product.h  |  3 +-
> >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-------
> >  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
> >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
> >  5 files changed, 44 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/dri=
vers/gpu/drm/arm/display/include/malidp_product.h
> > index 96e2e4016250..dbd3d4765065 100644
> > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > @@ -18,7 +18,8 @@
> >  #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0=
xFF)
> > =20
> >  /* Mali-display product IDs */
> > -#define MALIDP_D71_PRODUCT_ID   0x0071
> > +#define MALIDP_D71_PRODUCT_ID	0x0071
> > +#define MALIDP_D32_PRODUCT_ID	0x0032
> > =20
> >  union komeda_config_id {
> >  	struct {
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index 6dadf4413ef3..c7f7e9c545c7 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *=
d71,
> > =20
> >  	ctrlr =3D to_ctrlr(c);
> > =20
> > -	ctrlr->supports_dual_link =3D true;
> > +	ctrlr->supports_dual_link =3D d71->supports_dual_link;
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers=
/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > index 9b3bf353b6cc..2d429e310e5b 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > @@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_dev *=
mdev)
> >  		goto err_cleanup;
> >  	}
> > =20
> > -	/* probe PERIPH */
> > +	/* Only the legacy HW has the periph block, the newer merges the peri=
ph
> > +	 * into GCU
> > +	 */
> >  	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> > -	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> > -		DRM_ERROR("access blk periph but got blk: %d.\n",
> > -			  BLOCK_INFO_BLK_TYPE(value));
> > -		err =3D -EINVAL;
> > -		goto err_cleanup;
> > +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
> > +		d71->periph_addr =3D NULL;
> > +
> > +	if (d71->periph_addr) {
> > +		/* probe PERIPHERAL in legacy HW */
> > +		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> > +
> > +		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> > +		d71->max_vsize		=3D 4096;
> > +		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > +		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
> > +		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
> > +	} else {
> > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
> > +		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
> > +		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
> > +
> > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
> > +		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
> > +		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
> > +		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
> >  	}
> > =20
> > -	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> > -
> > -	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> > -	d71->max_vsize		=3D 4096;
> > -	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > -	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
> > -	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> > -
> >  	for (i =3D 0; i < d71->num_pipelines; i++) {
> >  		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
> >  					   &d71_pipeline_funcs);
> > @@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
> >  	}
> > =20
> >  	/* loop the register blks and probe */
> > -	i =3D 2; /* exclude GCU and PERIPH */
> > +	i =3D 1; /* exclude GCU */
> >  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> >  	while (i < d71->num_blocks) {
> >  		blk_base =3D mdev->reg_base + (offset >> 2);
> > @@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
> >  			err =3D d71_probe_block(d71, &blk, blk_base);
> >  			if (err)
> >  				goto err_cleanup;
> > -			i++;
> >  		}
> > =20
> > +		i++;
>=20
> This change doesn't make much sense if you want to count how many
> blocks are available, since you're now counting the reserved ones, too.

That's because for D32 num_blocks includes the reserved blocks.

> On the counting note, the prior code rides on the assumption the periph
> block is last in the map, and I don't see how you still handle not
> counting it in the D71 case.

Since D71 has one reserved block, and now we count reserved block.

So now no matter D32 or D71:
  num_blocks =3D n_valid_block + n_reserved_block + GCU.

Thanks
James
>=20
> >  		offset +=3D D71_BLOCK_SIZE;
> >  	}
> > =20
> > @@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_c=
hip_info *chip)
> > =20
> >  	switch (product_id) {
> >  	case MALIDP_D71_PRODUCT_ID:
> > +	case MALIDP_D32_PRODUCT_ID:
> >  		funcs =3D &d71_chip_funcs;
> >  		break;
> >  	default:
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/driver=
s/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > index 1727dc993909..81de6a23e7f3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > @@ -72,6 +72,19 @@
> >  #define GCU_CONTROL_MODE(x)	((x) & 0x7)
> >  #define GCU_CONTROL_SRST	BIT(16)
> > =20
> > +/* GCU_CONFIGURATION registers */
> > +#define GCU_CONFIGURATION_ID0	0x100
> > +#define GCU_CONFIGURATION_ID1	0x104
> > +
> > +/* GCU configuration */
> > +#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
> > +#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
> > +#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
> > +#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
> > +#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
> > +#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
> > +#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
> > +
> >  /* GCU opmode */
> >  #define INACTIVE_MODE		0
> >  #define TBU_CONNECT_MODE	1
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_drv.c
> > index b7a1097c45c4..ad38bbc7431e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > @@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platform_d=
evice *pdev)
> > =20
> >  static const struct of_device_id komeda_of_match[] =3D {
> >  	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> > +	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
> >  	{},
> >  };
> > =20
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
