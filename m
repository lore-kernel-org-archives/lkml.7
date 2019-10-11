Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C04C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF312190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b/pUuXLa";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b/pUuXLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfJKIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:54:23 -0400
Received: from mail-eopbgr120074.outbound.protection.outlook.com ([40.107.12.74]:53255
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfJKIyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B7Vv51tFQW1fv//oCz414JiDh7MEdFMxM/duBp8wZA=;
 b=b/pUuXLa6cwJwmDp9UtUPhEKJC6oa55bfvUOT2a5eITUHO8JII4taFzR6NRUWhmv/9I+Rwcx3DviEHzP/WHcU4kayTlS0+iDs0CTAkylWt3MJcT2eR48sRq/xj2s71sKCz8TftZsFPQotYQT6P6NR/ZCdNR+BWdZwjS0k6c//6I=
Received: from AM6PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:20b:c0::31)
 by PR2PR08MB4811.eurprd08.prod.outlook.com (2603:10a6:101:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 08:54:17 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM6PR08CA0043.outlook.office365.com
 (2603:10a6:20b:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Fri, 11 Oct 2019 08:54:17 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 08:54:15 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Fri, 11 Oct 2019 08:54:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae2371e16ef1e3e9
X-CR-MTA-TID: 64aa7808
Received: from 9daac585a64f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FFF47F46-42B7-4CF6-A767-354E206E5CD0.1;
        Fri, 11 Oct 2019 08:54:06 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9daac585a64f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 11 Oct 2019 08:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpoBJMYur4yWifqv8XWj9fAB/FwRaJVYjXjgZ1P/Qmv3eQHGuYhSZdydYsdCTDddKQzNP77pGAjjcYIiR0fcx/cisof+bftwhrApz04U87YRWfS7uWbMDbZzeuR3xUMU5hgPUwP93+FZMZBmWHOVaDCnvIkwj7i4XEWjxl/fCCZgJgtTVT4ZQB1vc1Myqp5NDU/RFisOFek1Ca6S8fuqLgoj3EdAexJBAAQiOrrQRdI8o7S5kIx2zv7dt0UwyurWXa2xoTEmuMySwqCBgiAyJwxUu88vieVfjrRhNTctsK3ir46VWZvXkHFHlZwcXlZbyMUQ4YZTXE3m89O4bX7dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B7Vv51tFQW1fv//oCz414JiDh7MEdFMxM/duBp8wZA=;
 b=I4IfATNnxV8ior43zD/nymKzJDCSxOIazxfeErBdsjvlwAkVmLtcdXTnsEfj1JhnON5VCXnras/v3Lz8rN/7IyGDKOrWW7jjRvdtZyKY+TbXIEg8LYMwmZj9y0wRR3A+YYfkl1o+7GTpQurTxE/DEGG2G6x8wZPxYZEqjHLG3Kk5/qha8SHsPFwmKswGsh44w2WHL9kFN07s0aRM94Tae0lAtHkYpvu0oKA4hOlR6/UAfbp92uMHzy1i6xKlOrQATMWRyR5cYAlhSEpz22uy/1Lpj3qrN4/vwDBOVCU5BS2zddM+xKYgOkVpzG9+ha/7qYwRwT7fiPKKky2M9XRukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B7Vv51tFQW1fv//oCz414JiDh7MEdFMxM/duBp8wZA=;
 b=b/pUuXLa6cwJwmDp9UtUPhEKJC6oa55bfvUOT2a5eITUHO8JII4taFzR6NRUWhmv/9I+Rwcx3DviEHzP/WHcU4kayTlS0+iDs0CTAkylWt3MJcT2eR48sRq/xj2s71sKCz8TftZsFPQotYQT6P6NR/ZCdNR+BWdZwjS0k6c//6I=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2960.eurprd08.prod.outlook.com (52.133.14.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 08:54:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:54:03 +0000
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
Subject: Re: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Topic: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVf/cp1ECrFKcx7E6lw4dO6fyhYKdVIuuA
Date:   Fri, 11 Oct 2019 08:54:03 +0000
Message-ID: <8416585.jh9292Gg6g@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-5-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-5-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0287.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::35) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 11800649-68f3-4e5e-65fe-08d74e289852
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2960:|VI1PR08MB2960:|PR2PR08MB4811:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB4811EF548BEEA56AB624CD178F970@PR2PR08MB4811.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(81156014)(14454004)(316002)(8676002)(66066001)(486006)(52116002)(14444005)(256004)(81166006)(25786009)(7736002)(66446008)(64756008)(386003)(102836004)(8936002)(6506007)(99286004)(305945005)(76176011)(478600001)(66476007)(66556008)(66946007)(186003)(26005)(6862004)(2906002)(33716001)(71200400001)(71190400001)(6116002)(11346002)(446003)(476003)(3846002)(86362001)(6436002)(6246003)(54906003)(5660300002)(229853002)(4326008)(9686003)(6486002)(6512007)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2960;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: otgFmMo3t5ofd/bZOtm7x8SaQrIyDKqehdPlsQNq+DtJ425dgRRnhk/cYx4IKfjWl6IRZ2FTQ3I7vAOENfL+lwtj5rfFwLEBjkOslMcslvEbxm94xd94/VKMhcIbCuaZYwy0v9aGivq2Im7gmVf24Z9YSdCyjaUaQg8AJzfI+P5GiGN3FYZVFELk1DLzdTLfr5SzkHLc9a2tvpDBzjyHf28K3ewA8jSgPuEWbJtCfXA3M7doRFgxPcUB74t3iyP3wcPKP3Dqptyk31HFeUI0BlGAMOMf8lFmMxPme/jz2qVlGZ9wzqiZmu63x4M9G5PCjicWAZBQt9YO3sbm9SN6BHtsBoPRTPN2e7iEpp1JkJ8yS2KQNsn3f8jMhe0ctPWfwSKqdleSs65mOUr6/YiaqBrhdPOc4uUGsKvLH9+ukl0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51DD38C7F75A844181E5A31B96409527@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2960
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(23726003)(6116002)(97756001)(76130400001)(22756006)(66066001)(478600001)(26826003)(47776003)(229853002)(446003)(26005)(6862004)(4326008)(99286004)(386003)(186003)(63350400001)(486006)(476003)(6506007)(102836004)(11346002)(126002)(76176011)(14454004)(6486002)(6246003)(336012)(46406003)(2906002)(3846002)(54906003)(25786009)(7736002)(33716001)(305945005)(14444005)(50466002)(36906005)(316002)(8676002)(70586007)(9686003)(8936002)(81166006)(6636002)(8746002)(6512007)(70206006)(5660300002)(86362001)(81156014)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4811;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 999b8171-b08c-449b-add2-08d74e2890e5
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evqSCu5tVlYxghimxes2KlVoaVadm6nhmn43Ct/crcdcsnxdSG/GjrUTLj4za/Njd0WIlja0y2KCZWq1yuFRncdZxZBlc7Dr48Alc2eumpl4Ekld1/if6KLrFIHpFFYgRJE5UfGGR8J0OGl7k9sJNy6orcCX1UMerbrZ4a+CaY8hPXtPZ2rsjgcQ3j/lcMVhjKB7rGMvkkmCN8vaf999hrMZdCfmk01LaYYBOyq7EEZuACGHuPiRqTkZWBbpJADxs/mK7xGVwSoXjVv0q26xg7tH2nPyOn6zMZHAzM0YuSDwSOSQFGcSpUi40H3RYzCI4zs51sM6XBrUuXFyf5SauQIdg1fKs1mAIGqlss/Y1K8oWCOzfxdb3lIfzq0Dv4nI9usQgEUEhYO+5Ufo08MoSQ0vepNGIsKLBExPgidOlrc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 08:54:15.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11800649-68f3-4e5e-65fe-08d74e289852
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Lowry,

On Friday, 11 October 2019 06:45:50 BST james qian wang (Arm Technology Chi=
na) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds gamma and color-transform support for DOU-IPS.
> Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state=
.
> If color management changed, set gamma and color-transform accordingly.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
>  .../display/komeda/komeda_pipeline_state.c    |  6 +++++
>  4 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..e7e5a8e4430e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
>  static void d71_improc_update(struct komeda_component *c,
>  			      struct komeda_component_state *state)
>  {
> +	struct drm_crtc_state *crtc_st =3D state->crtc->state;
I'm not sure it's a good idea to introduce a dependency on drm state
so far down in the HW funcs, is there a good reason for the direct prod?
>  	struct komeda_improc_state *st =3D to_improc_st(state);
> +	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
>  	u32 __iomem *reg =3D c->reg;
>  	u32 index;
> +	u32 mask =3D 0, ctrl =3D 0;
> =20
>  	for_each_changed_input(state, index)
>  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
>  			       to_d71_input_id(state, index));
> =20
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> +
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
> +	if (mask)
> +		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
>  }
> =20
>  static void d71_improc_dump(struct komeda_component *c, struct seq_file =
*sf)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 9beeda04818b..406b9d0ca058 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms=
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
> index b322f52ba8f2..c5ab8096c85d 100644
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
> @@ -324,6 +325,8 @@ struct komeda_improc {
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
>  	u16 hsize, vsize;
> +	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
> +	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
>  };
> =20
>  /* display timing controller */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 0ba9c6aa3708..4a40b37eb1a6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *improc,
>  	st->hsize =3D dflow->in_w;
>  	st->vsize =3D dflow->in_h;
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


--=20
Mihail



