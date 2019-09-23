Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EC2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E3206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kGe4BdCf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kGe4BdCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbfIWBuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:50:22 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:35973
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390768AbfIWBuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxG+zTHUW3464E7vxMfuUWQgPItHkQtOTgF8v+0vI2c=;
 b=kGe4BdCfByhJrbvZp4vcz0vWTZW2gFEW6c3YPeJB7XszReKgdTvgNSANNZ7TsI7FsjvR2ehs6UbY7C6lIb77wSspC2Ydti/DtLPSj7rQLqkMfgr2k+sHfoPAbypwGxuCTHBhXn4k593hKUng/sqHULbIcNIQsd776DKtDUzlhXU=
Received: from VI1PR08CA0127.eurprd08.prod.outlook.com (2603:10a6:800:d4::29)
 by VI1PR08MB2990.eurprd08.prod.outlook.com (2603:10a6:803:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 01:50:06 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0127.outlook.office365.com
 (2603:10a6:800:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Mon, 23 Sep 2019 01:50:06 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 01:50:05 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Mon, 23 Sep 2019 01:50:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 46f43f018a1c131a
X-CR-MTA-TID: 64aa7808
Received: from fc79088cf811.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 322E27B5-8A0D-4AB6-AD48-A7F9B50BD1B6.1;
        Mon, 23 Sep 2019 01:49:55 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fc79088cf811.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 01:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIRbVuMJTahkvcFKsitQKWvWvrW8H+ItN5TqPH9onyE30zJ5K3eyspM/Ba810jp9ui/pw9QqOnzhhx8ruY6DOqioA4Fercj7vdYGGx1oxeoB64F3MNvEy9Ogi3h0ciH/Wu/kCQOUWtSMnwG4IJPbuxiGfhDZC/O5sxHxlRkP9Laax+GSCWWuTwOgY6y7Jmk41uPFrFyfRT1HO1+OVMxQEZ75NDtV2ZLXu+xj0VQW7f8MJPShaTupNTovwywAX4FzPAwdojKCLwE1Ywefr7YElzw4LtEsXs29/+qmtiiiwl8yeBEATyPh7DZ88NcYVp0rsDL+9d1+WGoUb2OhAl5ylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxG+zTHUW3464E7vxMfuUWQgPItHkQtOTgF8v+0vI2c=;
 b=BefsuCYXViTBWYsbfNx+0kNpYkjcH036WRhtYqC/HpnkDI+KzsVL+aVJaNivgJ1HV/YiWO9QxoQdw9DLOtQD7SWdIyEsfBwXp35rGlvXtrZYxeQuu/paMFVO4f3HMwPV0aX0OulALkYSuVr0zaHexAiPIm9f12RI0roGHNyZT0XIq8X73D3qMGW2eFPuBKJlabVCWwKWSGqcZERg21p5bV634i8slJhfcAllt64ON5P/JoBaY0Qi2sTl/OXHraYOe6qbsXOo7SQsqeHkA03eQy+VtWMv2jBLXHkK6EwSRoOPRGPV1M05NoRO8kosiD+E42V0YUqL3TfL+n9UNZymIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxG+zTHUW3464E7vxMfuUWQgPItHkQtOTgF8v+0vI2c=;
 b=kGe4BdCfByhJrbvZp4vcz0vWTZW2gFEW6c3YPeJB7XszReKgdTvgNSANNZ7TsI7FsjvR2ehs6UbY7C6lIb77wSspC2Ydti/DtLPSj7rQLqkMfgr2k+sHfoPAbypwGxuCTHBhXn4k593hKUng/sqHULbIcNIQsd776DKtDUzlhXU=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB2783.eurprd08.prod.outlook.com (10.170.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Mon, 23 Sep 2019 01:49:52 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 01:49:52 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc0VieAgAQtAQA=
Date:   Mon, 23 Sep 2019 01:49:52 +0000
Message-ID: <20190923014944.GA26415@lowli01-ThinkStation-P300>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <2379631.WB1HUilIrr@e123338-lin>
In-Reply-To: <2379631.WB1HUilIrr@e123338-lin>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1964e4d6-af92-4ca1-60cb-08d73fc85b94
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2783;
X-MS-TrafficTypeDiagnostic: VI1PR08MB2783:|VI1PR08MB2783:|VI1PR08MB2990:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB29901E69D7BF347C90F304899F850@VI1PR08MB2990.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(51914003)(189003)(199004)(58126008)(66946007)(3846002)(66066001)(30864003)(5660300002)(6116002)(1076003)(33716001)(229853002)(316002)(54906003)(66446008)(64756008)(66556008)(66476007)(478600001)(14454004)(2906002)(11346002)(25786009)(6246003)(486006)(52116002)(14444005)(256004)(76176011)(446003)(86362001)(6486002)(99286004)(6862004)(6512007)(9686003)(476003)(4326008)(6436002)(55236004)(33656002)(71200400001)(186003)(6636002)(305945005)(102836004)(26005)(8936002)(71190400001)(81166006)(8676002)(7736002)(81156014)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2783;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: wbm+j4TwHxjwha5iQm0IjPFns9zFo/hlOMH6RwffisN292SGDjw2HJePd+2tkVScBTxkSX47I3rNDQDeTJFG9m+DMLjPyWiZQczIelXAJUY5WlXeFPsMA+I5tTvpX6bnK28+81pOT1WeszCuObipe5NYs5b/iQKMJaALBuLpx4UuIEr7i8NMKEDe5cqOV5mODu0A4xP4FRuYglDQrRvT6SJdkBt3I1MqHhBrFTD1E67b1iBU86C4fFuvQ7AsIhjWX4zExTO4hzB+jfMoFYkwsVwfc8xCpCM7H1wDLI+fw+5SlX8PpqNdfr+qWyWllqDMaCH53rpElSQOGV5d9j2y9ifre5mGTCbEsU5XcqUFqYAVVIpl0ZBXO2DDAWLr6Iu0TG8BcR/LdknAgKHNs2eHuTWJ6XrR2QnBOOr98Yj1TA4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <452F4A5CCEF8A64ABAD85A44D25B4030@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2783
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(51914003)(26826003)(356004)(86362001)(54906003)(11346002)(4326008)(14444005)(6636002)(50466002)(229853002)(126002)(8746002)(5660300002)(76176011)(8936002)(8676002)(336012)(70206006)(97756001)(66066001)(3846002)(386003)(81166006)(486006)(70586007)(6506007)(81156014)(1076003)(36906005)(58126008)(316002)(30864003)(446003)(102836004)(22756006)(46406003)(6862004)(25786009)(76130400001)(6116002)(6486002)(23726003)(14454004)(63350400001)(2906002)(6246003)(186003)(476003)(6512007)(33656002)(99286004)(478600001)(47776003)(7736002)(305945005)(9686003)(26005)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2990;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff2c8934-6cd4-4642-8dbe-08d73fc8532f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2990;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: HTFM0nS9qFBMKI5j0sEk7oYndqs0SCKCLnC3mHobnPWaE5ZsEdH4/mE50mmo6EL/JO9qa8oLKlLhLTKKhWDcU41h6mqE2Mk6chKUDFhl0PLNP5Utr8A8j82bP1ZdqAvGtdEZbalrid/9PY+Ow3+x0tlkbz5W8Wz4eT0mgEx1qRrbLU5GxeImtJKXXuuOZer/C929Lhjf7GmHeL/AKjwXr7YHAoHpnliWYqBnVwoX17kiq8orLm7/hXX24ea1Pwr/iNxzbDbohiUARHFF2+pHHOd3xHaLfJBZs0lfP3rtI6lwgx0UMpXKHpcSacrLTRB3obIVWElezBkOcgYlQVg++p06TBEvEEnXmbMpbsm9D/4LlieIj9e69dlNV/GSsLUrsnAnQMHBiA7H1kwv1TK//3xnatAPaYtgH0ZXdeodMo0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 01:50:05.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1964e4d6-af92-4ca1-60cb-08d73fc85b94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,
On Fri, Sep 20, 2019 at 10:03:38AM +0000, Mihail Atanassov wrote:
> Hi Lowry,
>=20
> On Friday, 20 September 2019 10:43:47 BST Lowry Li (Arm Technology China)=
 wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >=20
> > Sets color_depth according to connector->bpc.
> > Adds a new optional DT attribute "color-format" to represent a
>=20
> I don't see the hunk with the updated doc for the DT binding.

Thanks for the comment. We planed a new patch serie for DT binding
doc update, including output-color format, side by side, dual link and
etc.

Regards,
Lowry
> > preferred color formats for a specific pipeline, and the select order
> > is:
> > 	YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> > The color-format can be anyone of these 4 format, one color-format not
> > only represent one format, but also include the lower formats, like
> >=20
> > color-format         preferred_color_formats
> > YCRCB420        YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> > YCRCB422        YCRCB422 > YCRCB444 > RGB444
> > YCRCB444        YCRCB444 > RGB444
> > RGB444          RGB444
> >=20
> > Then the final color_format is calculated by 3 steps:
> > 1. calculate HW available formats.
> >   avail_formats =3D connector_color_formats & improc->color_formats;
> > 2. filter out un-preferred format.
> >   avail_formats &=3D preferred_color_formats;
> > 3. select the final format according to the preferred order.
> >   color_format =3D BIT(__fls(aval_formats));
> >=20
> > Changes since v1:
> > Rebased to the drm-misc-next branch.
> >=20
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    | 15 ++++++++-
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 ++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 32 ++++++++++++++++++-
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 ++
> >  .../display/komeda/komeda_pipeline_state.c    | 31 ++++++++++++++++++
> >  .../arm/display/komeda/komeda_wb_connector.c  |  5 +++
> >  7 files changed, 113 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c3d29c0b051b..7b374a3b911e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -944,13 +944,26 @@ static void d71_improc_update(struct komeda_compo=
nent *c,
> >  {
> >  	struct komeda_improc_state *st =3D to_improc_st(state);
> >  	u32 __iomem *reg =3D c->reg;
> > -	u32 index;
> > +	u32 index, mask =3D 0, ctrl =3D 0;
> > =20
> >  	for_each_changed_input(state, index)
> >  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
> >  			       to_d71_input_id(state, index));
> > =20
> >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> > +
> > +	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> > +
> > +	/* config color format */
> > +	if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB420)
> > +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> > +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB422)
> > +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422;
> > +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
> > +		ctrl |=3D IPS_CTRL_YUV;
> > +
> > +	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
> >  }
> > =20
> >  static void d71_improc_dump(struct komeda_component *c, struct seq_fil=
e *sf)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 624d257da20f..38d5cb20e908 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -18,6 +18,33 @@
> >  #include "komeda_dev.h"
> >  #include "komeda_kms.h"
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths, u32 *color_formats)
> > +{
> > +	struct drm_connector *conn;
> > +	struct drm_connector_state *conn_st;
> > +	u32 conn_color_formats =3D ~0u;
> > +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> > +
> > +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> > +		if (conn_st->crtc !=3D crtc_st->crtc)
> > +			continue;
> > +
> > +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> > +		conn_color_formats &=3D conn->display_info.color_formats;
> > +
> > +		if (conn_bpc < min_bpc)
> > +			min_bpc =3D conn_bpc;
> > +	}
> > +
> > +	/* connector doesn't config any color_format, use RGB444 as default *=
/
> > +	if (conn_color_formats =3D=3D 0)
> > +		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
> > +
> > +	*color_depths =3D GENMASK(conn_bpc, 0);
> > +	*color_formats =3D conn_color_formats;
> > +}
> > +
> >  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *k=
crtc_st)
> >  {
> >  	u64 pxlclk, aclk;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index 9cbcd56e54cd..bee4633cdd9f 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -113,12 +113,34 @@ static struct attribute_group komeda_sysfs_attr_g=
roup =3D {
> >  	.attrs =3D komeda_sysfs_entries,
> >  };
> > =20
> > +static int to_color_format(const char *str)
> > +{
> > +	int format;
> > +
> > +	if (!strncmp(str, "RGB444", 7)) {
> > +		format =3D DRM_COLOR_FORMAT_RGB444;
> > +	} else if (!strncmp(str, "YCRCB444", 9)) {
> > +		format =3D DRM_COLOR_FORMAT_YCRCB444;
> > +	} else if (!strncmp(str, "YCRCB422", 9)) {
> > +		format =3D DRM_COLOR_FORMAT_YCRCB422;
> > +	} else if (!strncmp(str, "YCRCB420", 9)) {
> > +		format =3D DRM_COLOR_FORMAT_YCRCB420;
> > +	} else {
> > +		DRM_WARN("invalid color_format: %s, please set it to RGB444, YCRCB44=
4, YCRCB422 or YCRCB420\n",
> > +			 str);
> > +		format =3D DRM_COLOR_FORMAT_RGB444;
> > +	}
> > +
> > +	return format;
> > +}
> > +
> >  static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device=
_node *np)
> >  {
> >  	struct komeda_pipeline *pipe;
> >  	struct clk *clk;
> >  	u32 pipe_id;
> > -	int ret =3D 0;
> > +	int ret =3D 0, color_format;
> > +	const char *str;
> > =20
> >  	ret =3D of_property_read_u32(np, "reg", &pipe_id);
> >  	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
> > @@ -133,6 +155,14 @@ static int komeda_parse_pipe_dt(struct komeda_dev =
*mdev, struct device_node *np)
> >  	}
> >  	pipe->pxlclk =3D clk;
> > =20
> > +	/* fetch DT configured color-format, if not set, use RGB444 */
> > +	if (!of_property_read_string(np, "color-format", &str))
> > +		color_format =3D to_color_format(str);
> > +	else
> > +		color_format =3D DRM_COLOR_FORMAT_RGB444;
> > +
> > +	pipe->improc->preferred_color_formats =3D (color_format << 1) - 1;
> > +
> >  	/* enum ports */
> >  	pipe->of_output_links[0] =3D
> >  		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index 45c498e15e7a..456f3c435719 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
> >  		return !!(rotation & DRM_MODE_REFLECT_X);
> >  }
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths, u32 *color_formats);
> >  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st)=
;
> > =20
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_d=
ev *mdev);
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index a7a84e66549d..910d279ae48d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -315,6 +315,8 @@ struct komeda_splitter_state {
> >  struct komeda_improc {
> >  	struct komeda_component base;
> >  	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
> > +	/* the preferred order is from MSB to LSB YUV420 --> RGB444 */
> > +	u32 preferred_color_formats;
> >  	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
> >  	u8 supports_degamma : 1;
> >  	u8 supports_csc : 1;
> > @@ -323,6 +325,7 @@ struct komeda_improc {
> > =20
> >  struct komeda_improc_state {
> >  	struct komeda_component_state base;
> > +	u8 color_format, color_depth;
> >  	u16 hsize, vsize;
> >  };
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index ea26bc9c2d00..5526731f5a33 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *improc=
,
> >  		       struct komeda_data_flow_cfg *dflow)
> >  {
> >  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> > +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
> >  	struct komeda_component_state *c_st;
> >  	struct komeda_improc_state *st;
> > =20
> > @@ -756,6 +757,36 @@ komeda_improc_validate(struct komeda_improc *impro=
c,
> >  	st->hsize =3D dflow->in_w;
> >  	st->vsize =3D dflow->in_h;
> > =20
> > +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> > +		u32 output_depths, output_formats;
> > +		u32 avail_depths, avail_formats;
> > +
> > +		komeda_crtc_get_color_config(crtc_st, &output_depths,
> > +					     &output_formats);
> > +
> > +		avail_depths =3D output_depths & improc->supported_color_depths;
> > +		if (avail_depths =3D=3D 0) {
> > +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & di=
splay: 0x%x\n",
> > +					 output_depths,
> > +					 improc->supported_color_depths);
> > +			return -EINVAL;
> > +		}
> > +
> > +		avail_formats =3D output_formats &
> > +				improc->supported_color_formats &
> > +				improc->preferred_color_formats;
> > +		if (avail_formats =3D=3D 0) {
> > +			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & d=
isplay: 0x%x & preferred: 0x%x\n",
> > +					 output_formats,
> > +					 improc->supported_color_formats,
> > +					 improc->preferred_color_formats);
> > +			return -EINVAL;
> > +		}
> > +
> > +		st->color_depth =3D __fls(avail_depths);
> > +		st->color_format =3D BIT(__fls(avail_formats));
> > +	}
> > +
> >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > index 617e1f7b8472..49e5469ba48e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
> >  	struct komeda_dev *mdev =3D kms->base.dev_private;
> >  	struct komeda_wb_connector *kwb_conn;
> >  	struct drm_writeback_connector *wb_conn;
> > +	struct drm_display_info *info;
> >  	u32 *formats, n_formats =3D 0;
> >  	int err;
> > =20
> > @@ -171,6 +172,10 @@ static int komeda_wb_connector_add(struct komeda_k=
ms_dev *kms,
> > =20
> >  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs=
);
> > =20
> > +	info =3D &kwb_conn->base.base.display_info;
> > +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> > +	info->color_formats =3D kcrtc->master->improc->supported_color_format=
s;
> > +
> >  	kcrtc->wb_conn =3D kwb_conn;
> > =20
> >  	return 0;
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
