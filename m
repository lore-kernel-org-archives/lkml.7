Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB12C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD32190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F98YlC+X";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F98YlC+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJKKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:13:12 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:7753
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfJKKNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXUhkcZysD0JLDCufCIZouin04Du52uPxuW73AOw8pU=;
 b=F98YlC+XmZB6jdSRXhZl5uKRqL96Dfuycnpx9gCEunwgNtKungUsCBJT8BzmcpzfmBix4us+3+MOg1H0cwCxrshudirJAEjVRV6+gWWAEhn8zxkr5EamDCw/VHaNCE/B18zkZITrTjm91nR83IrZW5E69opwVlKH76nKir7+SAQ=
Received: from AM6PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:20b:c0::22)
 by AM6PR08MB4803.eurprd08.prod.outlook.com (2603:10a6:20b:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Fri, 11 Oct
 2019 10:13:04 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by AM6PR08CA0034.outlook.office365.com
 (2603:10a6:20b:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 10:13:04 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 10:13:03 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 11 Oct 2019 10:12:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 393a5c948f6a3472
X-CR-MTA-TID: 64aa7808
Received: from fb8db4d7c804.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FC712224-6FE3-4261-859B-EC83DFFDAC0C.1;
        Fri, 11 Oct 2019 10:12:54 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fb8db4d7c804.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 10:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8cbvrY9aMpcJ05g7wAaUbdx6mKWCcWvFyeomeWReK6K76XfFAG/TSW+tdTYZfkxTCx4CMgwW0M7h5BnfedBWRgu3HDsX9V0j9Kz6PSDLlaMkhr0nW2++1nRFgVpHaK+xF/3z/MSWVqhla7mTEei3A+CkJnMwu/kmCaOnrrlk7e6lZ9HTHtQBusGW0tw6oDpo0O7OwMXZwCqCdN8ocFHqK/JUZDUJEUZ9Mu1KChQtik/C5/5/oOKfL5QkAJE6oBNlZysMfsGOat3EJFA+wJVFB2/mbv4b1H3vE8x8MZcvQSi3O1cenFP4UapSudm2i3K4DCoO/53EnwPZeJT/sg11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXUhkcZysD0JLDCufCIZouin04Du52uPxuW73AOw8pU=;
 b=Sp8koNbA6V5btuha3xOkhgZtIxhPblC2TtxRrT2vgeWXlJTzkO6biK6PsBKwQftBhWCy/4HXkIOHrBHyGRRGFUuwV23Ha3835FbJuvhq17pgATLEpcv9hNYd0u1KOQcxyoh/KxEalowN9tafLTvmx/f5lApS/S19memqHYkUt+TvjN7LGBHYikA44ZymgqwdVirhME7MjzYTrSRNLt6or9oan6c7Fhrzl9VUTTUsv3B0ZE96PtX8LnvjIKnsGGVeCPbryPnrJvujWZ0dIUbXTb8uJygHxLGjXtwlZqBv5trAetj804w6eRq7zi+7ErMjgu+W0rZIRrFtmbDqDRAvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXUhkcZysD0JLDCufCIZouin04Du52uPxuW73AOw8pU=;
 b=F98YlC+XmZB6jdSRXhZl5uKRqL96Dfuycnpx9gCEunwgNtKungUsCBJT8BzmcpzfmBix4us+3+MOg1H0cwCxrshudirJAEjVRV6+gWWAEhn8zxkr5EamDCw/VHaNCE/B18zkZITrTjm91nR83IrZW5E69opwVlKH76nKir7+SAQ=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3981.eurprd08.prod.outlook.com (20.178.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 10:12:52 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::e52a:a540:75ae:ced9%4]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 10:12:51 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Topic: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVf/cpkaYtgOCh2EeGNF1NL51m6adVIu6AgAAV/AA=
Date:   Fri, 11 Oct 2019 10:12:51 +0000
Message-ID: <20191011101244.GA13428@lowli01-ThinkStation-P300>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-5-james.qian.wang@arm.com>
 <8416585.jh9292Gg6g@e123338-lin>
In-Reply-To: <8416585.jh9292Gg6g@e123338-lin>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c6f65a0a-ce1b-4942-a3af-08d74e339a30
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3981:|VI1PR08MB3981:|AM6PR08MB4803:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48034594A79124CE764AD6329F970@AM6PR08MB4803.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(66066001)(71200400001)(71190400001)(81166006)(316002)(81156014)(8676002)(58126008)(54906003)(446003)(486006)(66476007)(11346002)(6862004)(14454004)(478600001)(66946007)(6246003)(8936002)(4326008)(5660300002)(476003)(66556008)(64756008)(66446008)(25786009)(3846002)(6436002)(6116002)(6512007)(9686003)(99286004)(6486002)(2906002)(76176011)(33656002)(6506007)(186003)(386003)(1076003)(26005)(52116002)(55236004)(229853002)(102836004)(86362001)(33716001)(14444005)(256004)(7736002)(305945005)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3981;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0zJeOGsb7a7+P8rPkriRPqVFrs4mGawOwyiQ6pln8DwS/L7zUXEyPdzL91bhCnCvqpGVRJHTWv9yv0biflWFOyDMvHm+F3X9KdsNxLifFiBczFV8kG6BV0/VmUyW5adMWv3wd2HkL1joIyeCUiDkXhv+YefGRdYdkrnBz1men8Ga60IeqXMV1tQIhSI0/65x4Iwv/MViufMsk6wNLLTC7ZCWt5b7aK0wZ1/Yfh0iOy47nlweQ+E6JQPW3FT/ABSAk4U7v/YLvO8H1R9PgOYGKUWJs6nraaXkVJPdwYT57wjTRQuXBETwu4mdm8AwHSgJfa0VaAMAuNR0dOckwAyqeXbkK+9S/Ft+HqpGYsx7aU0UvOGz4TeUMEkQoZVjwDkIvAZYREnmDt0VPEr0WmQMhlYxW/w8C8f3gipXhM0Q+Jc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0243169099F92A47A256B1BECB486C33@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3981
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(356004)(14444005)(47776003)(5660300002)(33716001)(8676002)(81156014)(81166006)(8936002)(8746002)(66066001)(11346002)(2906002)(336012)(102836004)(486006)(446003)(476003)(26005)(26826003)(63350400001)(478600001)(126002)(6506007)(386003)(97756001)(14454004)(76176011)(186003)(4326008)(99286004)(70586007)(6512007)(9686003)(54906003)(3846002)(76130400001)(6116002)(33656002)(70206006)(6862004)(229853002)(46406003)(6486002)(305945005)(7736002)(1076003)(50466002)(86362001)(6246003)(25786009)(23726003)(6636002)(58126008)(316002)(22756006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4803;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e32a0491-bd93-46e7-de20-08d74e339320
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SXcVCG2n5cxhPEGqOAhieUt+Mt/CQUkAE8uXu+wKI+j2MzmYBuE5DtRhMsui9RknpayyxTtoaSBReBRZebNauipmbmEzTAZZ5cbaxRQipNFZCFK3I2FCJgkgepIF87zEOrc50OHGSFjmmcyon8wewl5je8AiOHkRQGa+aqyNoRe6VVy/O1JqtPVffu0Hl06G9QvirsZ/sbnsKu58O0LGCFCylOxN5oz5zfsUcW8RtOkinY8K9mj75qYs+XNnlSgAsI1fALWTiGzFSd0XG7JMbr6YzoLwcjtLmDFY3BC2qOT9cWJljUcwBZMaquKKt33xSp5J7YXA2vtllHK5k99SzbtJnY4J0eYmyJYhetCxpIYjPD0McJdfiyrTI3jFBE8Vrzbe38NH6iY0oNATt2Swg14pDewDcxRvHB0Ax5rGTs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 10:13:03.2881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f65a0a-ce1b-4942-a3af-08d74e339a30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,
On Fri, Oct 11, 2019 at 08:54:03AM +0000, Mihail Atanassov wrote:
> Hi James, Lowry,
>=20
> On Friday, 11 October 2019 06:45:50 BST james qian wang (Arm Technology C=
hina) wrote:
> > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> >=20
> > Adds gamma and color-transform support for DOU-IPS.
> > Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_sta=
te.
> > If color management changed, set gamma and color-transform accordingly.
> >=20
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
> >  .../display/komeda/komeda_pipeline_state.c    |  6 +++++
> >  4 files changed, 35 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c3d29c0b051b..e7e5a8e4430e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
> >  static void d71_improc_update(struct komeda_component *c,
> >  			      struct komeda_component_state *state)
> >  {
> > +	struct drm_crtc_state *crtc_st =3D state->crtc->state;
> I'm not sure it's a good idea to introduce a dependency on drm state
> so far down in the HW funcs, is there a good reason for the direct prod?
We dicussed about this before. To decide using this way is to avoid of
duplicated state between DRM and Komeda.

Regards,
Lowry
> >  	struct komeda_improc_state *st =3D to_improc_st(state);
> > +	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
> >  	u32 __iomem *reg =3D c->reg;
> >  	u32 index;
> > +	u32 mask =3D 0, ctrl =3D 0;
> > =20
> >  	for_each_changed_input(state, index)
> >  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
> >  			       to_d71_input_id(state, index));
> > =20
> >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > +
> > +	if (crtc_st->color_mgmt_changed) {
> > +		mask |=3D IPS_CTRL_FT | IPS_CTRL_RGB;
> > +
> > +		if (crtc_st->gamma_lut) {
> > +			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
> > +					   KOMEDA_N_GAMMA_COEFFS,
> > +					   st->fgamma_coeffs);
> > +			ctrl |=3D IPS_CTRL_FT; /* enable gamma */
> > +		}
> > +
> > +		if (crtc_st->ctm) {
> > +			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
> > +					   KOMEDA_N_CTM_COEFFS,
> > +					   st->ctm_coeffs);
> > +			ctrl |=3D IPS_CTRL_RGB; /* enable gamut */
> > +		}
> > +	}
> > +
> > +	if (mask)
> > +		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
> >  }
> > =20
> >  static void d71_improc_dump(struct komeda_component *c, struct seq_fil=
e *sf)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 9beeda04818b..406b9d0ca058 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *k=
ms,
> > =20
> >  	crtc->port =3D kcrtc->master->of_output_port;
> > =20
> > +	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
> > +
> >  	return err;
> >  }
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index b322f52ba8f2..c5ab8096c85d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -11,6 +11,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include "malidp_utils.h"
> > +#include "komeda_color_mgmt.h"
> > =20
> >  #define KOMEDA_MAX_PIPELINES		2
> >  #define KOMEDA_PIPELINE_MAX_LAYERS	4
> > @@ -324,6 +325,8 @@ struct komeda_improc {
> >  struct komeda_improc_state {
> >  	struct komeda_component_state base;
> >  	u16 hsize, vsize;
> > +	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
> > +	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
> >  };
> > =20
> >  /* display timing controller */
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 0ba9c6aa3708..4a40b37eb1a6 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *impro=
c,
> >  	st->hsize =3D dflow->in_w;
> >  	st->vsize =3D dflow->in_h;
> > =20
> > +	if (kcrtc_st->base.color_mgmt_changed) {
> > +		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
> > +					 st->fgamma_coeffs);
> > +		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
> > +	}
> > +
> >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > =20
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
