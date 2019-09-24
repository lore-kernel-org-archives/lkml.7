Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D755C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7248207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZI/S6/A3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ZI/S6/A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408525AbfIXCNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:13:50 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:8672
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729136AbfIXCNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtOvIKTEM9Kdx1cv1gDjPRGAeLlDy+xXsM2fNqbAC6g=;
 b=ZI/S6/A3I04AlFWrw8aHHuX9AU87it9D5UiFOFSSn7lQd+Xp5+ikgTJSwK+vAb2IqFRiHC2eTzD2g0pze2tECqTSca/HrSzfXlUELvUrAlDs1kexN4xno5gFfggfB8lHfNZlPpaeYvS9N1wulam69pfdNvdbSceEdvb/DKJAW+U=
Received: from VI1PR08CA0193.eurprd08.prod.outlook.com (2603:10a6:800:d2::23)
 by VI1PR08MB3261.eurprd08.prod.outlook.com (2603:10a6:803:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Tue, 24 Sep
 2019 02:13:41 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0193.outlook.office365.com
 (2603:10a6:800:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 02:13:41 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT064.mail.protection.outlook.com (10.152.17.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.25 via Frontend Transport; Tue, 24 Sep 2019 02:13:39 +0000
Received: ("Tessian outbound 96594883d423:v31"); Tue, 24 Sep 2019 02:13:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f9fc6ec848561296
X-CR-MTA-TID: 64aa7808
Received: from 9a22645dec10.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A61F15E7-E877-4E10-9C2D-84779960E7AC.1;
        Tue, 24 Sep 2019 02:13:30 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9a22645dec10.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 02:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMjQFyqsIgSnpZYBDiUyi19CwGbJLhcKpAFjAzMnNLfyk6F06oA8rHKfWGaQ819W60cI0ZdYBThve4SEje9SpCrUpeSk7iAKwEGFnXENJu8Y/sCpNG3l7OkqxHTLhuqcBImBKUbRcj6o3iXRiwkdXRFrkO3OQRVJW6NWMdQe6ggNzgWfGyV+F1MpdyapQEzQ7bnjJBSgzVZ/2YbanZDgNErVL8eYpmixSFotQKHmQnIbvU4vJsDhs3YvlRLTLiTrKVQwDcW0xKB1qAg96NTJgYQ+k7yiLI9xlDJdrPxixIi+4aSmtLh+tAFaXW+vZ537kBHCTX/Zq3xM0PKnC7XE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtOvIKTEM9Kdx1cv1gDjPRGAeLlDy+xXsM2fNqbAC6g=;
 b=SN9WQphpvP+ypgoBY4yyg+eKWVBWlxnqa6n8cQojZXxQuvSK+6PD7yx39RBU94ZxdLoG/BBCytTzjtYWKZOpbxNpT/JozoaDXYV6P5Z4wFCkhlCdA52fbWR+KjRV7mosm6qSXZFxKfkrLuCpnlJ5ffgbA8/BVEgn+cL6vdi5iXd+65hK3xAEeWpFhsxHolxqflvJrGRoJ5EG4Tuhu8SLbUw2dJMd4fnjXnNpXigZTiop5dI4At4t+BpmzxXLS4NXzn7rL70oysuvCQzIyfwKj/qfdQQ6jJNZbOtH2ca1wtnV6dmZlOHdNCcbTOXFC1OQBLl1+GqUSyPPvfOmo3Qgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtOvIKTEM9Kdx1cv1gDjPRGAeLlDy+xXsM2fNqbAC6g=;
 b=ZI/S6/A3I04AlFWrw8aHHuX9AU87it9D5UiFOFSSn7lQd+Xp5+ikgTJSwK+vAb2IqFRiHC2eTzD2g0pze2tECqTSca/HrSzfXlUELvUrAlDs1kexN4xno5gFfggfB8lHfNZlPpaeYvS9N1wulam69pfdNvdbSceEdvb/DKJAW+U=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5120.eurprd08.prod.outlook.com (20.179.30.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 02:13:27 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 02:13:27 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc5MiiAgADp5IA=
Date:   Tue, 24 Sep 2019 02:13:27 +0000
Message-ID: <20190924021313.GA15776@jamwan02-TSP300>
References: <20190920094329.17513-1-lowry.li@arm.com>
 <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190923121604.jqi6ewln27yvdajw@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 69931e9f-8748-4ec0-cc87-08d74094d069
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5120;
X-MS-TrafficTypeDiagnostic: VE1PR08MB5120:|VE1PR08MB5120:|VI1PR08MB3261:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3261BAE6C5F5D35D37142AB1B3840@VI1PR08MB3261.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(71190400001)(486006)(66556008)(229853002)(64756008)(14454004)(446003)(66946007)(54906003)(476003)(4326008)(3846002)(6116002)(11346002)(305945005)(81166006)(81156014)(66476007)(102836004)(8936002)(55236004)(386003)(6506007)(186003)(8676002)(71200400001)(478600001)(1076003)(26005)(52116002)(30864003)(6636002)(99286004)(5660300002)(6436002)(33656002)(14444005)(33716001)(256004)(6486002)(7736002)(6512007)(6246003)(58126008)(25786009)(76176011)(316002)(6862004)(9686003)(66446008)(2906002)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5120;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: tBs03Fr3VxbSQ4oGHvkeAMtXrJEjxIt7/91cMm4n8J1hVaf3lKgLG3DnNk97+J4wRUkPZhSkBE5sCaNrIjujciefsI2uH29KblCEgpOsSX0QrEtM4/lgNMIJa0Jc31k9M+ml+HHFmVso/6lszNnxr1HGyVPly58Q/4P5cx2OOK9K4oLOHDWDt86iDWaxfpjB488osGcaVt0GkKPDAmFWaLeicDJQ0y5YrLq6N1zduyBObpLQhtxZeXOQAw3p3qisFCkOWXtUMOXfaTPiEJHfTL0+M7v/SGMOKyx6yfTcXCphiHfqZGSMYLuKLbd5J1cGq0kDb7VTXYjqzhPi4fie/5hUSNceSHj2NdyKCO9Z7NIg4YG7idCdArL549uHOXsfEavUE3MtVRK5AWQKTuUn6qgQsFmxRVLVlu7ctLxRIRE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7ED7DFFAB9B0149AE56555BAB00E8BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5120
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(50466002)(22756006)(54906003)(66066001)(30864003)(2906002)(186003)(229853002)(8936002)(46406003)(26005)(76176011)(86362001)(8746002)(70206006)(70586007)(99286004)(102836004)(6486002)(478600001)(81156014)(8676002)(14444005)(6246003)(5660300002)(47776003)(26826003)(81166006)(33656002)(386003)(6506007)(36906005)(25786009)(6862004)(446003)(7736002)(6512007)(9686003)(356004)(11346002)(486006)(476003)(126002)(6636002)(63350400001)(316002)(1076003)(23726003)(76130400001)(58126008)(336012)(33716001)(97756001)(14454004)(4326008)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3261;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 00e768a5-9978-462b-34c8-08d74094c8e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3261;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: brj1AZxCWCwC8YP6QwIZtqMRZCkNqLDyjHJqzdfmDlqCY355RoHGdJC0nf6vKLb21MQTU1DO0X1bTg2GNrvL84cARC6Je7EsfqiCt1Pwa0eSEJFE5qLjEjE5WDbPL16LUgeUIV7pEx4Dnta542fMZVeX+2TqRMShp+nADcDJ0u1rzkcAO3K7jfOY7pe6F/QfCztqckacUOOSTHxnT/tZL23GUD4mqEcLDwZ3OFatnJzyBGJ/xa60wVxQ32FJ6NlbY3C7VlRFzyeW03qYJJrZyo6pzMzypfyXA/Ex9T2r/FPStBEAVe2B+6mrEOQYtqbiyl17Tb/xx2vkmkySICuBRKst5OUku+B/gHljJX8dM8SeohBCXTEiL2Jad97bXzYEVTHm+IvpJnp8aZLp1C6RG6VVxH2r0B0mex23tJqzOLc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 02:13:39.1576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69931e9f-8748-4ec0-cc87-08d74094d069
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:16:12PM +0000, Brian Starkey wrote:
> Hi Lowry,
>=20
> On Fri, Sep 20, 2019 at 09:43:47AM +0000, Lowry Li (Arm Technology China)=
 wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >=20
> > Sets color_depth according to connector->bpc.
> > Adds a new optional DT attribute "color-format" to represent a
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
>=20
> Is there a specific use-case for the DT property for selecting color
> format?

Hi Brian:

Since one monitor can support mutiple color-formats, this DT property
supply a way for user to select a specific one from this supported
color-formats.

> I think in general the color format should be determined according to
> the rules in the CEA spec. There's also the drm_mode_is_420_only()
> helper we can use to determine if YCBCR420 must be used. For the cases
> where it's optional, I think we can default to RGB444.

Yes, This selection depends on the real connector supported_color-formats,
I think you misunderstand this DT, this DT color-format is not for
specifying a real output format. but a way or select order for how to
select the final output format from the mutiple color-formats of a connecto=
r.

Like the DT color-format is "YCRCR420", it indicates a select order:
  YUV420 > YUV422 > YUV444 > RGB444

We use this order to select the final output-format.

> > Then the final color_format is calculated by 3 steps:
> > 1. calculate HW available formats.
> >   avail_formats =3D connector_color_formats & improc->color_formats;

NOTE: this connector_color_formats is
drm_connector->display_info.color_formats.

> > 2. filter out un-preferred format.
> >   avail_formats &=3D preferred_color_formats;
> > 3. select the final format according to the preferred order.
> >   color_format =3D BIT(__fls(aval_formats));

__fls here is used for selecting as order.

>
> Thanks,
> -Brian
>=20
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
> > --=20
> > 2.17.1
> >=20
