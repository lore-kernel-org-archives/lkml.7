Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26598C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3945206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AEYMnCm9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AEYMnCm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfJHKSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:18:32 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:45220
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729944AbfJHKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKyK2cIjC/c1xSS4RGBXVVfiCslGQ3VVEudPca/f9O8=;
 b=AEYMnCm9TyOjbleVl+NGZtef0pmhL9TDYUUrjcjrhg3NI91xLW5kFMebWUntviQANeBEjS8jjrYyxQBnl0wLgG/q/2PBSxRKgqe0u6VDAduOIB1dp0A2gotUfiJZ1lBrTyzynwc/P9Jb8NZpos5uv6orUzqc/d84vAgnWQ++bgs=
Received: from VI1PR08CA0244.eurprd08.prod.outlook.com (2603:10a6:803:dc::17)
 by HE1PR0801MB2060.eurprd08.prod.outlook.com (2603:10a6:3:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 10:18:21 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0244.outlook.office365.com
 (2603:10a6:803:dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 10:18:20 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 10:18:18 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Tue, 08 Oct 2019 10:18:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 347e7d9f291ccd66
X-CR-MTA-TID: 64aa7808
Received: from 0818bbc51657.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 74511A95-94BF-4203-8338-DF13D8904014.1;
        Tue, 08 Oct 2019 10:18:08 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0818bbc51657.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 10:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIX2P0cIPH/Yw5A2Ry8Syap1gmJF8lRmlg0rwBOne1+wqskdkITkcjgGZv8X+SQffKKlgeXXJhK6TNO0M/zPsoycp5exsa481YA4MK9ZWiF/+43KHeRP+WZcepUT16oKxT2aUzSUnQ2AYDZMuBPfTKKF5U15NUi1oU2EJsHOOdW1w3LYDR900O+d3rwDfvCL8Mh4bOTy+zLzXYLn6YjsPueOSyFk4Uuzdr1oybt+BsvykQvOINqrCfWY3fKpFJJUHzghQ/m2RqQfgJHGd091O95MNKr2XbLa3lCAE/eywugvT+ZJQEgGy44hcTJeGxnf8zGVlllyHlPkpT3DVBfByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKyK2cIjC/c1xSS4RGBXVVfiCslGQ3VVEudPca/f9O8=;
 b=e9XIFV60MQ41bTRDWWr64BY3DK1S4a5E0SP3d/qx3VwLtZn2k6Zs84b40qeFhMPmmdSCdBPpNjxijZQAAZcxHcWsJPL9ZGm+U40O5YD9zlR02af59BWrOfBWbJswbyiC15HTuiDuQsn7iUrIqbYj3j0NsShNpLEgbXvti4G1C4KYhuFHbWqHPkWWFELah1AgH3Kf7D+gZg1szLig17k+FAHCdDxiHMzoIKU7BxGCvbrtKLy9SLGJJPMMWcNfCyPhDbRSVxB4T4sREZeM3BdflWae9oQIDSgOyJPE5JxVCwpDCktifJWcpa7xWJ6wzW3R08MZQMA6TTR9h3DL8sp3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKyK2cIjC/c1xSS4RGBXVVfiCslGQ3VVEudPca/f9O8=;
 b=AEYMnCm9TyOjbleVl+NGZtef0pmhL9TDYUUrjcjrhg3NI91xLW5kFMebWUntviQANeBEjS8jjrYyxQBnl0wLgG/q/2PBSxRKgqe0u6VDAduOIB1dp0A2gotUfiJZ1lBrTyzynwc/P9Jb8NZpos5uv6orUzqc/d84vAgnWQ++bgs=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3742.eurprd08.prod.outlook.com (20.178.15.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 10:18:06 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 10:18:06 +0000
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
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQe+uAgAAL8gA=
Date:   Tue, 8 Oct 2019 10:18:06 +0000
Message-ID: <20191008101758.GA16398@lowli01-ThinkStation-P300>
References: <20191008091734.19509-1-lowry.li@arm.com>
 <3337512.00vBK9FLud@e123338-lin.cambridge.arm.com>
In-Reply-To: <3337512.00vBK9FLud@e123338-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5eab4c-1e29-4038-a552-08d74bd8d6b5
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3742:|VI1PR08MB3742:|HE1PR0801MB2060:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2060B58ACC315C95C5BFC8A99F9A0@HE1PR0801MB2060.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:397;OLM:397;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(446003)(66066001)(256004)(486006)(33716001)(476003)(11346002)(305945005)(5660300002)(1076003)(7736002)(6116002)(3846002)(14444005)(33656002)(2906002)(54906003)(58126008)(316002)(86362001)(71190400001)(25786009)(71200400001)(52116002)(186003)(6636002)(102836004)(99286004)(26005)(55236004)(6862004)(229853002)(6486002)(478600001)(14454004)(6506007)(386003)(6436002)(76176011)(6512007)(9686003)(4326008)(81156014)(81166006)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3742;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /wVmh40GSRwTx58HHYEpIXmV5dm7AJGADiTDuBUIcMbz2lxNMF09ACVq8DgjpRC/lrsRTbgtuygjE6oY6QFd05Q/6rHSFNOzopkpCRXqzrxYoeG6HCVE9RELK1eupxMQg1wEI/k6Hqmno1lQog2kxkiWyaUiJw1qZ4R2ZPnFvmjMvBxMFZGnnDojl9vzl85LR+HMtRcoy8GCAvcyQgZzORLU1XY1Fo8wvCBqrGiAwg3mXQp5ZozIw1h2d7Tg5LriSK4LiScDU+IBeOxi9O7C/BgaVJ1xfaZtm4yn83Kh5vvvSkBpj81thnV7Oa1PW0ya4cB3ofqPgwks8+Nee4OE9klHKKe4nwG93qjwXFlINsR25aRaukhJ6XBgdBMu61gAq4waiyZnRFyr+jUDP34UjvrZ89MCiWFMiNstGXMEZao=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <974A287278A50447A47EE08185EBE286@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3742
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(376002)(136003)(346002)(1110001)(339900001)(199004)(189003)(316002)(6636002)(5660300002)(70586007)(26826003)(478600001)(186003)(305945005)(6486002)(336012)(70206006)(446003)(97756001)(8676002)(6116002)(23726003)(26005)(22756006)(4326008)(81156014)(6862004)(102836004)(81166006)(3846002)(386003)(6506007)(11346002)(36906005)(6246003)(126002)(58126008)(14454004)(76176011)(2906002)(476003)(47776003)(46406003)(86362001)(25786009)(33716001)(9686003)(6512007)(99286004)(66066001)(54906003)(33656002)(76130400001)(8746002)(486006)(8936002)(7736002)(1076003)(14444005)(229853002)(50466002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB2060;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d0947822-b81a-4330-edac-08d74bd8cf9e
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWPr/KpRwE6E7wXn+H/yRoB4ou6agCE+L1P+Bs7zb+Dnknf3mMgshMenXGyBQQ00FgOT0PioBnjJLcHnFMo+RJUGphiTP/QVkSuoZ1EFALMTNSwN0eIMo2INoQYf7+ds2q7iX82Bfdvo8zK52rtmrBV/12doW7k6yvtqWFYN2PgtMnBeItGYhIv+8wn4UpZGLSkoCGNfp5uxpleiRwn6J+gfky7mYxk49Hr9lT23WWOVIR3iCcjjVXzf/uE08vhKmeFXjIRz2rV3q0mfQVdJOzZQTby+wB9DoM7TdwaX9efJYRgkbzN3OGQ24W8+xCVE49w9OOla55qvFL1SjWs/92wL+v/AYVQNHzpyDOqr537Q6OATb6QOmll1tgV+NvkVk9Z0HldunmTXzcP8SDKFGizFEw8x4RA045m1K09WZ6w=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 10:18:18.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5eab4c-1e29-4038-a552-08d74bd8d6b5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,
On Tue, Oct 08, 2019 at 09:35:15AM +0000, Mihail Atanassov wrote:
> Hi Lowry,
>=20
> On Tuesday, 8 October 2019 10:17:52 BST Lowry Li (Arm Technology China) w=
rote:
> > Set color_depth according to connector->bpc.
> >=20
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    |  1 +
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> >  .../display/komeda/komeda_pipeline_state.c    | 19 ++++++++++++++++++
> >  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
> >  6 files changed, 47 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c3d29c0b051b..27cdb03573c1 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_compone=
nt *c,
> >  			       to_d71_input_id(state, index));
> > =20
> >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> >  }
> > =20
> >  static void d71_improc_dump(struct komeda_component *c, struct seq_fil=
e *sf)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 75263d8cd0bd..baa986b70876 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -17,6 +17,26 @@
> >  #include "komeda_dev.h"
> >  #include "komeda_kms.h"
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths)
> > +{
> > +	struct drm_connector *conn;
> > +	struct drm_connector_state *conn_st;
> > +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> > +
> > +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> > +		if (conn_st->crtc !=3D crtc_st->crtc)
> > +			continue;
> > +
> > +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> > +
> > +		if (conn_bpc < min_bpc)
> > +			min_bpc =3D conn_bpc;
> Something doesn't add up here. min_bpc is effectively set but not used.
Thanks a lot for the correction. We'd use min_bpc to get color_depths
bitmask. Will correct this.
> > +	}
> > +
> > +	*color_depths =3D GENMASK(conn_bpc, 0);
> > +}
> > +
> >  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *k=
crtc_st)
> >  {
> >  	u64 pxlclk, aclk;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index 45c498e15e7a..a42503451b5d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
> >  		return !!(rotation & DRM_MODE_REFLECT_X);
> >  }
> > =20
> > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > +				  u32 *color_depths);
> >  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st)=
;
> > =20
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_d=
ev *mdev);
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index b322f52ba8f2..7653f134a8eb 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -323,6 +323,7 @@ struct komeda_improc {
> > =20
> >  struct komeda_improc_state {
> >  	struct komeda_component_state base;
> > +	u8 color_depth;
> >  	u16 hsize, vsize;
> >  };
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 0ba9c6aa3708..e68e8f85ab27 100644
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
> > @@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *impro=
c,
> >  	st->hsize =3D dflow->in_w;
> >  	st->vsize =3D dflow->in_h;
> > =20
> > +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> > +		u32 output_depths;
> > +		u32 avail_depths;
> > +
> > +		komeda_crtc_get_color_config(crtc_st,
> > +					     &output_depths);
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
> > +		st->color_depth =3D __fls(avail_depths);
> > +	}
> > +
> >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > index 2851cac94d86..740a81250630 100644
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
> > @@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
> > =20
> >  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs=
);
> > =20
> > +	info =3D &kwb_conn->base.base.display_info;
> > +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
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
