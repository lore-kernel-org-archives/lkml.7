Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68372FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BEF21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="922MCy7k";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="922MCy7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394077AbfJPOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:30:39 -0400
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:15374
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728190AbfJPOai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7OyTbyPqqj6409GWtJSyNvSMmG5Bzi2MmDOwmsFIT8=;
 b=922MCy7kARXTwgBqFkRXT3sjcjc9+9jgBu4ve6HvOuey/8KA7rjgkrGgGWx7iKwZk3a38ydNXERkoeD5kXF4TdT+tKbn0xcEpeolUeFArzd/xS5hxU5/qf0ElYJCiWb33hLLmKBJca+zE7i5Ep6zH08432mCkAwJHzRHXWMGpZk=
Received: from HE1PR0802CA0010.eurprd08.prod.outlook.com (2603:10a6:3:bd::20)
 by VI1PR0802MB2271.eurprd08.prod.outlook.com (2603:10a6:800:a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Wed, 16 Oct
 2019 14:30:33 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by HE1PR0802CA0010.outlook.office365.com
 (2603:10a6:3:bd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 14:30:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 14:30:32 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 16 Oct 2019 14:30:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 74536b999e862091
X-CR-MTA-TID: 64aa7808
Received: from 2f357e2889b7.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A338AB45-1DB7-44B9-9395-50C32E5FEEA7.1;
        Wed, 16 Oct 2019 14:30:22 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2f357e2889b7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 14:30:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grTBNUqgG5JKDOqC93uL0qFlV4ZYDWug40tJhw2Pof9wkVGT/riyJW6UVBVUNc6pBALNcxjb+BqI+NQsh1ZqNqpkrHFZ1hxjjmILqwJkEX2L1inWBxxOk1ebpiqGwe7RvdQR49fCtBVKwhfMJSRplYEIsccq+UfhvkvLOjleJXo3FtUmNF4pC0RLf+d0qgscZqikeB+C/5lZ5A3nGFtxNWPVUf0f53PnxoI7Y+7Y1j4RtwpCbiUiSCfYz1ADKB9IIegthlZEbkg5NBZoOr1x/qbd22z56Nq9NfOtpjnIbmHyk0pRfbtpBHE3Y5daF6EHeQelerKLTc9wk0SeqU89aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7OyTbyPqqj6409GWtJSyNvSMmG5Bzi2MmDOwmsFIT8=;
 b=QIklvV+5HyzrPIGtBcns+j04S4ELaOHekkjJ5iFoaHk/eymSPkynraDrDekZahzdYMaBluvh/aaq/NJxiI3ldY2/shc8Agm1OKLu3+sYXgdNuCY4tfelXGnEGdTTHp3YoLBhiKJVl+tb0e2aw0F+dG5DselBh/iWXRu2b1S7OSX19oiApBAZ3VwUNktrS45vFoVA37YaQijmR5qIny90kGy0yx73vcdKht7EKCT11Ore3lryv6lS5wfgh/DPWSey0fwETqv2VfnGIQtyHAIWqk+wBgTIxebPlGFm3XYGpXLOlzCHo7TEOC7o6kt0hVpNs/UP/svjBggb7uXq+/nV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7OyTbyPqqj6409GWtJSyNvSMmG5Bzi2MmDOwmsFIT8=;
 b=922MCy7kARXTwgBqFkRXT3sjcjc9+9jgBu4ve6HvOuey/8KA7rjgkrGgGWx7iKwZk3a38ydNXERkoeD5kXF4TdT+tKbn0xcEpeolUeFArzd/xS5hxU5/qf0ElYJCiWb33hLLmKBJca+zE7i5Ep6zH08432mCkAwJHzRHXWMGpZk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2973.eurprd08.prod.outlook.com (10.171.182.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 14:30:20 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 14:30:20 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
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
Subject: Re: [PATCH v5 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Topic: [PATCH v5 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVhA1TRCL0eNp/dE2Lu5eXcmRLQqddVFwA
Date:   Wed, 16 Oct 2019 14:30:20 +0000
Message-ID: <1854916.b3CkKF7cjY@e123338-lin>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
 <20191016103339.25858-5-james.qian.wang@arm.com>
In-Reply-To: <20191016103339.25858-5-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: AM3PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:207:1::20) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ba168ab2-c447-4401-784a-08d75245666a
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2973:|VI1PR08MB2973:|VI1PR0802MB2271:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2271F358F358ABE73B91DA058F920@VI1PR0802MB2271.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(99286004)(11346002)(54906003)(6246003)(71190400001)(8936002)(6436002)(102836004)(81166006)(3846002)(8676002)(86362001)(6512007)(4326008)(9686003)(26005)(6862004)(316002)(81156014)(229853002)(446003)(186003)(6486002)(14444005)(486006)(256004)(71200400001)(476003)(66946007)(52116002)(66556008)(64756008)(66446008)(66476007)(6506007)(2906002)(478600001)(76176011)(33716001)(6116002)(66066001)(7736002)(6636002)(305945005)(25786009)(386003)(14454004)(5660300002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2973;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pWo5+rDYiTe5Se5A4qECUFjU/+1/ofLx2oYAHR0edfMdsDquLt1gIX805SlgjEKom7Z9Vp31J8MyDYEFkOamLev1J2M0BTEp5+35iRDuh8Ty5yikixHjzj+Hc8KnKmJAlRKhKwdaIji+CItu34j6ADWaWWI4RoTB6Llq18INXDcmxDHH+xYvzebQldvLON3zc0iB6R8ysnKNmHS1VTiKE5y88FZsDLmRBbJMpZQqeqzyOcXPCUTIKsGF/BFPCVUbj7XpJ9Ch+IF5sohitZA0UF9NGqraMCS/qdwHVDzvrdtFXhDGnhF5T0LWF/L9dhpxrDK+NhooJqNIdCIUZ4JhZ/Aamt1HUcSAH1vlpUFsbEDomuY3GI9hUzwuUHqaFX2TaJ1v2nJ7CDdnwy+FSykaVBVLh0XXRil1y/269Blt47c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08618AA940EB2B419FDA5FCF1B25186D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2973
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(66066001)(26005)(54906003)(5660300002)(126002)(70586007)(50466002)(70206006)(8676002)(6862004)(7736002)(76130400001)(4326008)(26826003)(478600001)(336012)(9686003)(63350400001)(229853002)(6512007)(14444005)(22756006)(2906002)(86362001)(97756001)(386003)(6636002)(6506007)(102836004)(11346002)(186003)(76176011)(25786009)(446003)(486006)(36906005)(14454004)(356004)(33716001)(8936002)(46406003)(6246003)(8746002)(99286004)(316002)(305945005)(23726003)(47776003)(6116002)(476003)(3846002)(81166006)(6486002)(81156014)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2271;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e1394fb-8733-4c30-b6d6-08d752455f46
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBsw5DCo9z9nMroQj6myW08fhPGUeHn1kp9jaechJjeZ1VZ5aMp20DepgVgf5bqhQEFT+QJ/jLWywi6qBgzeSTndXShyRfoutuxeXsFbFO2Ah4Ga5FAYMzDFw8XFGc/zxp//UV9ZiRSR4u59ZWfiK+RXTaay4T5NV3ZuEuJ7htX4T1DOhyLx14keL0qB59/3cj3lPc9p/lSsE5L5OEMPIS+YHPYjirXqELzCut6hMHpvzkwvw8GqKH2mPYOgd/VUe+PURa5SpWrELoxR7XtnjkCMqWWQL1HX6HnrYUe+Jo/cVI/SrlUXYCpWkoK1zwYpt/bS9HZFwu9/xcTra5tqFLukSnOGWaO4mfruD/AdOY9yyIXosu3OG0tx5HUHQNMTuF6WZl6uTbEqAyDprp16iZKOzPL6JSjS/VO7CdwCJJw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 14:30:32.0108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba168ab2-c447-4401-784a-08d75245666a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 16 October 2019 11:34:30 BST james qian wang (Arm Technology =
China) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds gamma and color-transform support for DOU-IPS.
> Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state=
.
> If color management changed, set gamma and color-transform accordingly.
>=20
> v5: Rebase with drm-misc-next
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 20 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
>  .../display/komeda/komeda_pipeline_state.c    |  6 ++++++
>  4 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 6740b8422f11..63a1b6f9cbba 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1032,7 +1032,9 @@ static int d71_merger_init(struct d71_dev *d71,
>  static void d71_improc_update(struct komeda_component *c,
>  			      struct komeda_component_state *state)
>  {
> +	struct drm_crtc_state *crtc_st =3D state->crtc->state;
>  	struct komeda_improc_state *st =3D to_improc_st(state);
> +	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
>  	u32 __iomem *reg =3D c->reg;
>  	u32 index, mask =3D 0, ctrl =3D 0;
> =20
> @@ -1043,6 +1045,24 @@ static void d71_improc_update(struct komeda_compon=
ent *c,
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
>  	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> =20
> +	if (crtc_st->color_mgmt_changed) {
> +		mask |=3D IPS_CTRL_FT | IPS_CTRL_RGB;
> +
> +		if (crtc_st->gamma_lut) {
> +			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
> +					   KOMEDA_N_GAMMA_COEFFS,
> +					   st->fgamma_coeffs);
> +			ctrl |=3D IPS_CTRL_FT; /* enable gamma */
> +		}
> +
> +		if (crtc_st->ctm) {
> +			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
> +					   KOMEDA_N_CTM_COEFFS,
> +					   st->ctm_coeffs);
> +			ctrl |=3D IPS_CTRL_RGB; /* enable gamut */
> +		}
> +	}
> +
>  	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> =20
>  	/* config color format */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 252015210fbc..1c452ea75999 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -617,6 +617,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms=
,
> =20
>  	crtc->port =3D kcrtc->master->of_output_port;
> =20
> +	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
> +
>  	return err;
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index bd6ca7c87037..ac8725e24853 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -11,6 +11,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include "malidp_utils.h"
> +#include "komeda_color_mgmt.h"
> =20
>  #define KOMEDA_MAX_PIPELINES		2
>  #define KOMEDA_PIPELINE_MAX_LAYERS	4
> @@ -327,6 +328,8 @@ struct komeda_improc_state {
>  	struct komeda_component_state base;
>  	u8 color_format, color_depth;
>  	u16 hsize, vsize;
> +	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
> +	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
>  };
> =20
>  /* display timing controller */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 42bdc63dcffa..0930234abb9d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -802,6 +802,12 @@ komeda_improc_validate(struct komeda_improc *improc,
>  		st->color_format =3D BIT(__ffs(avail_formats));
>  	}
> =20
> +	if (kcrtc_st->base.color_mgmt_changed) {
> +		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
> +					 st->fgamma_coeffs);
> +		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
> +	}
> +
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
>  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> =20
>=20
You must've missed it, but I had a

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

(granted, it was deeper in a thread and quite informally written
as 'r-b me')

--=20
Mihail


