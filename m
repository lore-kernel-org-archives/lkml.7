Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F16C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4970C2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rK9edBon";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rK9edBon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfJIHeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:34:21 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:58286
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfJIHeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEI8NIVUsWJFXlYd6MRAcc7FR+LkQnseTgpc5WQHRyM=;
 b=rK9edBonaH371U7Uh/50t+cMs7ONtKbz2tGP03hMhOgQzu9+tD2pgiLotfRp9PMHdNmzyKkl/HSgvO4dgXlziB6dJdyZRNf5bkdZi0uUZBKpZCsj93oZvpk3Ec0InFzvWab3x9rWaY+Cjbv0xfoV+uqcCw8UZX2I/AZB++2I9cM=
Received: from VI1PR0802CA0048.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::34) by AM6PR08MB3349.eurprd08.prod.outlook.com
 (2603:10a6:209:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Wed, 9 Oct
 2019 07:34:09 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR0802CA0048.outlook.office365.com
 (2603:10a6:800:a9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 07:34:09 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 9 Oct 2019 07:34:07 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 09 Oct 2019 07:34:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 89b7025407d70dc6
X-CR-MTA-TID: 64aa7808
Received: from 9834a8bad193.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 02F0C33D-A5F0-44EC-9D3E-1A49E6F61E0E.1;
        Wed, 09 Oct 2019 07:33:55 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9834a8bad193.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 09 Oct 2019 07:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfpEUaDk2ZCNHuSN92+8Vfri/No6QllLkHn6Vr7S4L2yBmRT6sYjmAQalg3pazjai6su7wKWfo82t/G5eXhZ0B9fSstm79lt1Hvbsn4f1Bkh95Tn9Y3M73I4dtmYRZpXozb2utDPh313uxQvzxN0YZxvnAwSIh6Jd3zfo+gRP6M+AumYzoSg3gI17bAfgYA6TMdWgbV+JG82m2UZaSDUXuXeuXZ6TuyQWQ4LUB4J4nMNFjOQ5ZRXXH/O/D9Yg1Le1ljrMnz4w15hp8QTTlljsAA20otv3zM7dcRbYdFUeotOElmAqBWj4kKUDdEIAfpVNn5aE3o//L5F49FajdH/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEI8NIVUsWJFXlYd6MRAcc7FR+LkQnseTgpc5WQHRyM=;
 b=MJQeVT9kGQG+/fkqeku/mDfYEM9TIYv+NU/Jd48P+Rj58ZWakCy8WyL/ERJzE18bQF1086vqE/MPh32jpPySW4zXWH8GZl+ZDzBC2myuzwhCnk+fvvjVStRUYkPYelDtfTuK09x/sLWmhbAauHXbWHgWKNpYEEyXd+sbb68iKmCO6q0RI7uWrdCyHo2z64ojui3TIa78OntTwa4ywcWPJ3aTRyjaXDOG+4Rnywf/M5urVdIA67pogSuFFfqW3byVSLrI1BOAZtFMmDZlFeH7JX7GLlS//Gh4kBnfolyZhMaIN1CdOnI7880k0pp4/GzlnEOP4vKcpqOB6FCgYS3+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEI8NIVUsWJFXlYd6MRAcc7FR+LkQnseTgpc5WQHRyM=;
 b=rK9edBonaH371U7Uh/50t+cMs7ONtKbz2tGP03hMhOgQzu9+tD2pgiLotfRp9PMHdNmzyKkl/HSgvO4dgXlziB6dJdyZRNf5bkdZi0uUZBKpZCsj93oZvpk3Ec0InFzvWab3x9rWaY+Cjbv0xfoV+uqcCw8UZX2I/AZB++2I9cM=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3997.eurprd08.prod.outlook.com (20.178.126.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 07:33:53 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 07:33:53 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQfC0AgAAOlYCAAA4iAIABU24A
Date:   Wed, 9 Oct 2019 07:33:53 +0000
Message-ID: <20191009073346.GA31246@lowli01-ThinkStation-P300>
References: <20191008091734.19509-1-lowry.li@arm.com>
 <20191008093608.eyr5ygc2lkkaaqia@DESKTOP-E1NTVVP.localdomain>
 <20191008102818.GB16398@lowli01-ThinkStation-P300>
 <3803267.CWkr2XGRCA@e123338-lin>
In-Reply-To: <3803267.CWkr2XGRCA@e123338-lin>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 52c94196-97b3-4fee-15e1-08d74c8b11b2
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3997:|VI1PR08MB3997:|AM6PR08MB3349:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3349AFFF287F20AA19CA83C59F950@AM6PR08MB3349.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 018577E36E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(26005)(316002)(58126008)(6116002)(256004)(3846002)(14444005)(99286004)(25786009)(66066001)(486006)(55236004)(52116002)(33716001)(478600001)(76176011)(186003)(6506007)(102836004)(386003)(446003)(11346002)(54906003)(2906002)(71200400001)(71190400001)(476003)(6486002)(14454004)(6246003)(33656002)(6436002)(8936002)(81166006)(6512007)(66946007)(8676002)(9686003)(229853002)(6636002)(6862004)(1076003)(81156014)(64756008)(66556008)(66446008)(305945005)(7736002)(86362001)(66476007)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3997;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CBBNkElDIP1W2aMDdqOOE1TNS5cj8mzEkm4TB/z4Z4ha+9c2rArE7OWfJIZ0wchANe+dSAAR+yykfLotUQPxeh/edk1EZCyl+Au7Sm6GrHksdRfmvWA9sZHBYvcurwEV8faGfREONZQyHyUKHLwyGq/cZs+LByfhuv6wb6DnDA0OLFIo2lOc7tPr2dRCXs/M3lBKQtjf6cdVc/cdsX60/0I2pn7GK5+9PJH787W+2+B8PvSY8LX8O9DEacU7IfUfWI315ZQ6pBMdy6D6kFMh0xHSf/I0tK50RPza3ZgG1xYxSjBdcxt9VfcPPxbei0msio/OfQsaShq68wF7ES0hD/OdiUOqHJZ3UQ08v0kh8TbPwmlAaoB3NDiCPHGA8l//pf2zj0IstcoNsNMz50DQvR56ziQEgqYrYRj6eRVkc7U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76B450A400CBB243935D6642FC93D224@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3997
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(186003)(81166006)(63350400001)(86362001)(356004)(8676002)(2906002)(26005)(14444005)(9686003)(11346002)(4326008)(81156014)(70206006)(6636002)(70586007)(99286004)(76130400001)(446003)(8936002)(8746002)(336012)(6512007)(305945005)(46406003)(7736002)(386003)(58126008)(6506007)(25786009)(97756001)(66066001)(54906003)(47776003)(486006)(6862004)(316002)(126002)(50466002)(6246003)(22756006)(478600001)(26826003)(1076003)(5660300002)(6486002)(102836004)(14454004)(33656002)(23726003)(6116002)(76176011)(3846002)(33716001)(476003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3349;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3fa566a4-9251-49c2-bda2-08d74c8b08f9
NoDisclaimer: True
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nev3tc8fL6dMjukydzEQ0Zx7xeOVnwzOuPc8RzjkRVdPYtx760V+ZFQW5b9KKFE9vgHqLj4ewexG5MbbFzMUu3kVb7iAiJ951pL+KVRLGxvXNoSrgImk2FhrNFeO/wXkzE8txO8KOTRV0xPU5ZcyWYUtqB3/loT5SRAMBM4IKzgTjv13fk54D3aJE6rD6VThyfz9SExnTECz/79Zmy3U5vIUtld/lLzMEgi8tIPjyjP6WCA1WJI5aZP5kuIMXR+IH7tV34KM950wyyyfOuCidL8FO917aXfcR4jrteY1XUVKaljDw60/dHW5Xh4uuNYhgvHDQVcZN8O8sPP8/mko+kY6a5hYwPYzWa9JN9qMpXWUvRdDFFXVin1URmV80uIdx9l/Z8GJxYXneiMt4Xph4F9syI6GcTppTL3DD8QrznY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 07:34:07.6462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c94196-97b3-4fee-15e1-08d74c8b11b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,
On Tue, Oct 08, 2019 at 11:18:56AM +0000, Mihail Atanassov wrote:
> On Tuesday, 8 October 2019 11:28:24 BST Lowry Li (Arm Technology China) w=
rote:
> > Hi Brian,
> > On Tue, Oct 08, 2019 at 09:36:09AM +0000, Brian Starkey wrote:
> > > Hi Lowry,
> > >=20
> > > On Tue, Oct 08, 2019 at 09:17:52AM +0000, Lowry Li (Arm Technology Ch=
ina) wrote:
> > > > Set color_depth according to connector->bpc.
> > > >=20
> > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > ---
> > > >  .../arm/display/komeda/d71/d71_component.c    |  1 +
> > > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++=
++++
> > > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
> > > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> > > >  .../display/komeda/komeda_pipeline_state.c    | 19 +++++++++++++++=
+++
> > > >  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
> > > >  6 files changed, 47 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c=
 b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > index c3d29c0b051b..27cdb03573c1 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > > @@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_com=
ponent *c,
> > > >  			       to_d71_input_id(state, index));
> > > > =20
> > > >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > > > +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> > > >  }
> > > > =20
> > > >  static void d71_improc_dump(struct komeda_component *c, struct seq=
_file *sf)
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > index 75263d8cd0bd..baa986b70876 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > > @@ -17,6 +17,26 @@
> > > >  #include "komeda_dev.h"
> > > >  #include "komeda_kms.h"
> > > > =20
> > > > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > > > +				  u32 *color_depths)
> > > > +{
> > > > +	struct drm_connector *conn;
> > > > +	struct drm_connector_state *conn_st;
> > > > +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> > > > +
> > > > +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i)=
 {
> > > > +		if (conn_st->crtc !=3D crtc_st->crtc)
> > > > +			continue;
> > > > +
> > > > +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8=
;
> > >=20
> > > We can have multiple connectors on a single CRTC (e.g. normal +
> > > writeback), so what's the expected behaviour here in that case?
> > >=20
> > > > +
> > > > +		if (conn_bpc < min_bpc)
> > > > +			min_bpc =3D conn_bpc;
> > > > +	}
> > > > +
> > > > +	*color_depths =3D GENMASK(conn_bpc, 0);
> > > > +}
> > > > +
> > > >  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_stat=
e *kcrtc_st)
> > > >  {
> > > >  	u64 pxlclk, aclk;
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > index 45c498e15e7a..a42503451b5d 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
> > > >  		return !!(rotation & DRM_MODE_REFLECT_X);
> > > >  }
> > > > =20
> > > > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > > > +				  u32 *color_depths);
> > > >  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc=
_st);
> > > > =20
> > > >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct kome=
da_dev *mdev);
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > index b322f52ba8f2..7653f134a8eb 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > @@ -323,6 +323,7 @@ struct komeda_improc {
> > > > =20
> > > >  struct komeda_improc_state {
> > > >  	struct komeda_component_state base;
> > > > +	u8 color_depth;
> > > >  	u16 hsize, vsize;
> > > >  };
> > > > =20
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_sta=
te.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > index 0ba9c6aa3708..e68e8f85ab27 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > > @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *im=
proc,
> > > >  		       struct komeda_data_flow_cfg *dflow)
> > > >  {
> > > >  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> > > > +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
> > > >  	struct komeda_component_state *c_st;
> > > >  	struct komeda_improc_state *st;
> > > > =20
> > > > @@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *i=
mproc,
> > > >  	st->hsize =3D dflow->in_w;
> > > >  	st->vsize =3D dflow->in_h;
> > > > =20
> > > > +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> > > > +		u32 output_depths;
> > > > +		u32 avail_depths;
> > > > +
> > > > +		komeda_crtc_get_color_config(crtc_st,
> > > > +					     &output_depths);
> > > > +
> > > > +		avail_depths =3D output_depths & improc->supported_color_depths;
> > > > +		if (avail_depths =3D=3D 0) {
> > > > +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x =
& display: 0x%x\n",
> > > > +					 output_depths,
> > > > +					 improc->supported_color_depths);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		st->color_depth =3D __fls(avail_depths);
> > > > +	}
> > > > +
> > > >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> > > >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > > > =20
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector=
.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > > index 2851cac94d86..740a81250630 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > > @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komed=
a_kms_dev *kms,
> > > >  	struct komeda_dev *mdev =3D kms->base.dev_private;
> > > >  	struct komeda_wb_connector *kwb_conn;
> > > >  	struct drm_writeback_connector *wb_conn;
> > > > +	struct drm_display_info *info;
> > > >  	u32 *formats, n_formats =3D 0;
> > > >  	int err;
> > > > =20
> > > > @@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komed=
a_kms_dev *kms,
> > > > =20
> > > >  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_f=
uncs);
> > > > =20
> > > > +	info =3D &kwb_conn->base.base.display_info;
> > > > +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths=
);
> > > > +
> > >=20
> > > The IPS color depth doesn't really apply to writeback. Maybe we shoul=
d
> > > just skip the writeback connector?
> > >=20
> > > Thanks,
> > > -Brian
> > >=20
> > Yes, the color depth not apply to writeback. We adds it because:
> >=20
> > In the komeda_crtc_get_color_config() will loop all connectors of CRTC
> > including the wb_conn, since crtc always has wb_conn. If not setting
> > here, wb_conn->bpc will be set it to 8bit forcely in komeda_crtc_get_co=
lor_config() which will lead crtc bpc to 8bits all the time. So we are sett=
ing the
> > largest supported depth to kwb_conn->bpc here.
> >=20
> I agree with Brian here, it sounds like you need to fix
> komeda_crtc_get_color_config() rather than putting in arcane bpc
> values and invoking spooky action. Connectors have a type [1], so
> it's easy to filter WB connectors out of the loop.
>=20
> [1] e.g. DRM_MODE_CONNECTOR_WRITEBACK in this case.
>=20
Even for writeback only, at H/W requirement, we still need to set IPS
depth and output color for IPS.

Regards,
Lowry
> > > >  	kcrtc->wb_conn =3D kwb_conn;
> > > > =20
> > > >  	return 0;
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
