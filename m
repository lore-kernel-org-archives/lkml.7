Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B23C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B912133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FenbPZVt";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FenbPZVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHNHwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:52:40 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:39161
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHNHwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+wzEMGoJS+V3upkxrH4uxBTjiCwXDOxOBJLcmpxmCw=;
 b=FenbPZVtutROnrludoI0kajh3dszztK0WLGZ8+YqrtDRlqUUZo1MsSyu8zarojLJxuhPghS2dReGiBi4kPsB73dqcKeTKby3YwtFHng9DLqoVGrjyki9vf0joNPXURcaKCjkQxtQ0XtMSf3ZjuFA0D32VikbDF243/ME4iS9VDg=
Received: from VI1PR08CA0093.eurprd08.prod.outlook.com (2603:10a6:800:d3::19)
 by DB8PR08MB4954.eurprd08.prod.outlook.com (2603:10a6:10:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Wed, 14 Aug
 2019 07:52:28 +0000
Received: from VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR08CA0093.outlook.office365.com
 (2603:10a6:800:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15 via Frontend
 Transport; Wed, 14 Aug 2019 07:52:28 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT021.mail.protection.outlook.com (10.152.18.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.18 via Frontend Transport; Wed, 14 Aug 2019 07:52:26 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Wed, 14 Aug 2019 07:52:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 10745c97b1bb1756
X-CR-MTA-TID: 64aa7808
Received: from dcc9ab17699d.1 (cr-mta-lb-1.cr-mta-net [104.47.9.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E8E9E1E3-DFE3-46D5-A2A1-0D9CC6CD5309.1;
        Wed, 14 Aug 2019 07:52:20 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dcc9ab17699d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Aug 2019 07:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCE1hrZ/HEbaK+Z58i5CniKyBrp+A0Nh85geeikRKerGILAjKi8wF6RDVcgP+RLxso4eprOzYY4S81UR+WxT8C9UXgQnJqeXVTG8NcAxCI8rGreyXjjksQnqBkJuJfSmPXOsJnpUMtRDheIu7YQKwaJzxeyvu9bUzghvbRu1T/UiTzBOAXi2qukZKVU27a8C9IaM+AWSQonV27tUksE2Gfp/iBxYcHV02YjldW8Le/xSq+O3D+fa/6iw2/lsmkHWtwICSAxb9kkNSQY/1zR0KbIP9MWQf5Z539VjTL45HvWZTpwRFLMK4AegtnZEBuJryt1kaMVmuEIN9S2Vd8mSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+wzEMGoJS+V3upkxrH4uxBTjiCwXDOxOBJLcmpxmCw=;
 b=CZ58GhkBKuC7KGeLYjG4pRX8vVaTJp88GJXWKDsFxNXBLfZ+fzLHIJGAtreZAu1DMXN+dxL3PwhDA3RbUt4PczNIvPCDmmsennxJrS31NtY6d07usrZwH4vsQpltfSVvuJ77eoZTPRI4C6vf0RsqnI7QhqorvgQfuQJO5FJWmakp0KdH6gRoWkz3KhuVlAfGOtwAmzTcvfNZ2No1Nua/ao726Wb/kIZ9jvmUsF2TAOB1MO6lv/PHcKlzm/1dUQoBBuAbONzxcbCvmN1l8M5mG/ToxMyZmhx6JMotdCHuHm2GtnOHlzvdWbW1GsKa5NDEGJsOHAFrlls8widPQDdmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+wzEMGoJS+V3upkxrH4uxBTjiCwXDOxOBJLcmpxmCw=;
 b=FenbPZVtutROnrludoI0kajh3dszztK0WLGZ8+YqrtDRlqUUZo1MsSyu8zarojLJxuhPghS2dReGiBi4kPsB73dqcKeTKby3YwtFHng9DLqoVGrjyki9vf0joNPXURcaKCjkQxtQ0XtMSf3ZjuFA0D32VikbDF243/ME4iS9VDg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5038.eurprd08.prod.outlook.com (10.255.159.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 14 Aug 2019 07:52:18 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 07:52:18 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
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
Thread-Index: AQHVUZNrgGWWre2e4Eyh5LBkmfNYaKb41hsAgAFxGAA=
Date:   Wed, 14 Aug 2019 07:52:18 +0000
Message-ID: <20190814075210.GA24984@jamwan02-TSP300>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
 <20190813045536.28239-3-james.qian.wang@arm.com>
 <3902025.BCtzpz6JhW@e123338-lin>
In-Reply-To: <3902025.BCtzpz6JhW@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d4b7cc3e-e3a7-4291-6d04-08d7208c5960
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5038;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5038:|DB8PR08MB4954:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4954E0B721950F24CE8326E8B3AD0@DB8PR08MB4954.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01294F875B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(6436002)(58126008)(5660300002)(316002)(26005)(186003)(6116002)(3846002)(305945005)(2906002)(66066001)(7736002)(71190400001)(33716001)(33656002)(71200400001)(8676002)(1076003)(54906003)(6862004)(386003)(478600001)(52116002)(6636002)(4326008)(14454004)(6246003)(81156014)(55236004)(66946007)(446003)(256004)(11346002)(14444005)(76176011)(6506007)(81166006)(6486002)(66556008)(66476007)(229853002)(66446008)(102836004)(9686003)(86362001)(99286004)(6512007)(8936002)(486006)(64756008)(476003)(25786009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5038;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: z4pzWggcGcqrRcaJ3MQFHCdB56R9Wm/bGyH7YR1yhvg2+ea3kEx+VkF4Ni0Jr1kDLvLjfHPnQuzGt3857yIvjhsbznMRPbpW/IOrH3jW4T7jwx9Cx54w22xl+iqvPumqy3sOITiBtIIhehubwGKz1FsNLkW1laKbTBJo6OJoq8ztYvaeXCW+kRpfT2b6Ui7Y5DkyrQPxOAq8BHep41Xi4tOdDGHXYjjXUJv7nVYy85lr8yIKxvMXYzOyaRv9oFx5+AxxIDXTCNWjBUoXPzllmO3eoP5nFLv9ainRChvzo3RjoUy8eecqHOzCzINcuZxoizeQ4qvpGaBnzjFQlWRW8ZSfOjUSyouYq++CPr+JIG9TyfQASYtGAhsYqYKKQqHmHQ2U6Somy7wb2o/nSp5NmQLxkwdjJSVQ5T41vGjs82Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B6916E830453D4AB567C0609A6442AB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5038
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(46406003)(6486002)(446003)(26826003)(63350400001)(11346002)(63370400001)(486006)(229853002)(5660300002)(58126008)(476003)(336012)(316002)(47776003)(356004)(26005)(66066001)(6636002)(22756006)(1076003)(126002)(8676002)(33716001)(81156014)(76176011)(305945005)(70206006)(386003)(102836004)(8746002)(186003)(8936002)(97756001)(70586007)(54906003)(478600001)(14454004)(50466002)(2906002)(4326008)(25786009)(33656002)(3846002)(99286004)(36906005)(86362001)(23726003)(76130400001)(6116002)(6512007)(6246003)(9686003)(14444005)(7736002)(6506007)(6862004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4954;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b4f7a331-2f72-4362-a409-08d7208c5449
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB8PR08MB4954;
NoDisclaimer: True
X-Forefront-PRVS: 01294F875B
X-Microsoft-Antispam-Message-Info: 1LIttZm0g5hcBLdwvvbOF9SjO4BAw9Q40OnVA/qMw4wPxUmv2LSA6h/FvY7cdJg2joDGlGBxcgKV9HZmYNAK88biO0LYw25jULKKA1xVqCLZD/8rbXv5Yb2sgyfSOqrZxrIWK6P+Y0aa4ZDEAqyeNoDEBq5qEMX/34SX8jWrZUz5kMiliXAN6hM+4H1qGA7gpWAVkCt3PHEczJtEvNUrlVSThLJWSY8mXAlgCw9kptOmnHp8Slt5JmOuhAq5CQQJM8I425YUKkRL/M1jqj/8CfjFWDnjoUdC+4FP4MjQphMhY5jhoACQ/UMbSmyhFHQic4ltlz0zGqi2M0d9F2kv4ous79aQ+5Oc6i1OzDVrF9OPiPKzSzengB956vJzmQMC+nKygJHi2nbHzpG1fEQTZ5WVU3Ru6nbFKQKOAOm0GVA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 07:52:26.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b7cc3e-e3a7-4291-6d04-08d7208c5960
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:51:08AM +0000, Mihail Atanassov wrote:
> Hi James,
>=20
> On Tuesday, 13 August 2019 05:56:07 BST james qian wang (Arm Technology C=
hina) wrote:
> > Many komeda component support color management like layer and IPS, so
> > komeda_color_manager/state are introduced to manager gamma, csc and deg=
amma
> > together for easily share it to multiple componpent.
> >=20
> > And for komeda_color_manager which:
> > - convert drm 3d gamma lut to komeda specific gamma coeffs
> > - gamma table management and hide the HW difference for komeda-CORE
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../arm/display/komeda/komeda_color_mgmt.c    | 126 ++++++++++++++++++
> >  .../arm/display/komeda/komeda_color_mgmt.h    |  32 ++++-
> >  2 files changed, 156 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > index 9d14a92dbb17..bf2388d641b9 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > @@ -4,7 +4,9 @@
> >   * Author: James.Qian.Wang <james.qian.wang@arm.com>
> >   *
> >   */
> > +#include <drm/drm_print.h>
> > =20
> > +#include "malidp_utils.h"
> >  #include "komeda_color_mgmt.h"
> > =20
> >  /* 10bit precision YUV2RGB matrix */
> > @@ -65,3 +67,127 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_e=
ncoding, u32 color_range)
> > =20
> >  	return coeffs;
> >  }
> > +
> > +struct gamma_curve_sector {
> > +	u32 boundary_start;
> > +	u32 num_of_segments;
> > +	u32 segment_width;
> > +};
> > +
> > +struct gamma_curve_segment {
> > +	u32 start;
> > +	u32 end;
> > +};
> > +
> > +static struct gamma_curve_sector sector_tbl[] =3D {
> > +	{ 0,    4,  4   },
> > +	{ 16,   4,  4   },
> > +	{ 32,   4,  8   },
> > +	{ 64,   4,  16  },
> > +	{ 128,  4,  32  },
> > +	{ 256,  4,  64  },
> > +	{ 512,  16, 32  },
> > +	{ 1024, 24, 128 },
> > +};
> > +
> > +static struct gamma_curve_sector igamma_sector_tbl[] =3D {
> > +	{0, 64, 64},
> > +};
> > +
> > +static void
> > +drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
> > +		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
> > +{
> > +	struct drm_color_lut *lut;
> > +	u32 i, j, in, num =3D 0;
> > +
> > +	if (!lut_blob)
> > +		return;
> > +
> > +	lut =3D lut_blob->data;
> > +
> > +	for (i =3D 0; i < num_sectors; i++) {
> > +		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
> > +			in =3D sector_tbl[i].boundary_start +
> > +			     j * sector_tbl[i].segment_width;
> > +
> > +			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
> > +						KOMEDA_COLOR_PRECISION);
> > +		}
> > +	}
> > +
> > +	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
> > +}
> > +
> > +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs)
> > +{
> > +	drm_lut_to_coeffs(lut_blob, coeffs,
> > +			  igamma_sector_tbl, ARRAY_SIZE(igamma_sector_tbl));
> > +}
> > +
> > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs)
> > +{
> > +	drm_lut_to_coeffs(lut_blob, coeffs,
> > +			  sector_tbl, ARRAY_SIZE(sector_tbl));
> > +}
> > +
> > +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs=
)
> > +{
> > +	struct drm_color_ctm *ctm;
> > +	u32 i;
> > +
> > +	if (!ctm_blob)
> > +		return;
> > +
> > +	ctm =3D ctm_blob->data;
> > +
> > +	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; ++i) {
> > +		/* Convert from S31.32 to Q3.12. */
> > +		s64 v =3D ctm->matrix[i];
> > +
> > +		coeffs[i] =3D clamp_val(v, 1 - (1LL << 34), (1LL << 34) - 1) >> 20;
> CTM matrix values are S31.32, i.e. sign-magnitude, so clamp_val won't
> give you the right result for negative coeffs. See
> malidp_crtc_atomic_check_ctm for the sign-mag -> 2's complement
> conversion.

Thank you Mihail for pointing this out.

No matter our user or kernel all assume this s31.32 as 2's complement.=20
we need to correct them both.

> > +	}
> > +}
> > +
> > +void komeda_color_duplicate_state(struct komeda_color_state *new,
> > +				  struct komeda_color_state *old)
> [bikeshed] not really a _duplicate_state if all it does is refcounts.
> kmemdup here and return a pointer (with ERR_PTR on fail), or memcpy if
> you want to keep the signature?

Yes, the dup mostly should return a new ptr from a old, the dup name here
is not accurate.
the reason is the color_state is not a separated structure but always
embedded into layer_state, but I want to make all color_state operation
into a func.
Do you have any suggestion ?

> > +{
> > +	new->igamma =3D komeda_coeffs_get(old->igamma);
> > +	new->fgamma =3D komeda_coeffs_get(old->fgamma);
> > +}
> > +
> > +void komeda_color_cleanup_state(struct komeda_color_state *color_st)
> > +{
> > +	komeda_coeffs_put(color_st->igamma);
> > +	komeda_coeffs_put(color_st->fgamma);
> > +}
> > +
> > +int komeda_color_validate(struct komeda_color_manager *mgr,
> > +			  struct komeda_color_state *st,
> > +			  struct drm_property_blob *igamma_blob,
> > +			  struct drm_property_blob *fgamma_blob)
> > +{
> > +	u32 coeffs[KOMEDA_N_GAMMA_COEFFS];
> > +
> > +	komeda_color_cleanup_state(st);
> > +
> > +	if (igamma_blob) {
> > +		drm_lut_to_igamma_coeffs(igamma_blob, coeffs);
> > +		st->igamma =3D komeda_coeffs_request(mgr->igamma_mgr, coeffs);
> > +		if (!st->igamma) {
> > +			DRM_DEBUG_ATOMIC("request igamma table failed.\n");
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	if (fgamma_blob) {
> > +		drm_lut_to_fgamma_coeffs(fgamma_blob, coeffs);
> > +		st->fgamma =3D komeda_coeffs_request(mgr->fgamma_mgr, coeffs);
> > +		if (!st->fgamma) {
> > +			DRM_DEBUG_ATOMIC("request fgamma table failed.\n");
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/d=
rivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > index a2df218f58e7..41a96b3b540f 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > @@ -4,14 +4,42 @@
> >   * Author: James.Qian.Wang <james.qian.wang@arm.com>
> >   *
> >   */
> > -
> >  #ifndef _KOMEDA_COLOR_MGMT_H_
> >  #define _KOMEDA_COLOR_MGMT_H_
> > =20
> >  #include <drm/drm_color_mgmt.h>
> > +#include "komeda_coeffs.h"
> > =20
> >  #define KOMEDA_N_YUV2RGB_COEFFS		12
> > +#define KOMEDA_N_RGB2YUV_COEFFS		12
> > +#define KOMEDA_COLOR_PRECISION		12
> > +#define KOMEDA_N_GAMMA_COEFFS		65
> > +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)

> I don't see how the number of LUT entries has anything to do with the
> bit-precision of each entry.

Because our komeda color is 12-bit precison, and for 1 vs 1 loopup
table, we need BIT(12) entries.

Thank you
James

> > +#define KOMEDA_N_CTM_COEFFS		9
> > +
> > +struct komeda_color_manager {
> > +	struct komeda_coeffs_manager *igamma_mgr;
> > +	struct komeda_coeffs_manager *fgamma_mgr;
> > +	bool has_ctm;
> > +};
> > +
> > +struct komeda_color_state {
> > +	struct komeda_coeffs_table *igamma;
> > +	struct komeda_coeffs_table *fgamma;
> > +};
> > +
> > +void komeda_color_duplicate_state(struct komeda_color_state *new,
> > +				  struct komeda_color_state *old);
> > +void komeda_color_cleanup_state(struct komeda_color_state *color_st);
> > +int komeda_color_validate(struct komeda_color_manager *mgr,
> > +			  struct komeda_color_state *st,
> > +			  struct drm_property_blob *igamma_blob,
> > +			  struct drm_property_blob *fgamma_blob);
> > +
> > +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs);
> > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs);
> > +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs=
);
> > =20
> >  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_=
range);
> > =20
> > -#endif
> > +#endif /*_KOMEDA_COLOR_MGMT_H_*/
> >=20
>=20
> BR,
> Mihail
>=20
>=20
