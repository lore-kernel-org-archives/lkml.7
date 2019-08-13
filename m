Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56823C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B90206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="O7QvY0Le";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="O7QvY0Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfHMKIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:08:04 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4942
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728410AbfHMKID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEp78bpszcqRWbo0DOWI7TMRSxcZ9yQHHBFq9zLj/8o=;
 b=O7QvY0LeiHahS0xWp/egcNYdnD+C6DyUhQRE9ckDppS7PyDz65YcH5Et0GFNbiYffKPyyF5FoBEIgMruMzKqYaMrIGzr15I2utCiCOLLGN7I7bmadhFGZWSmIMmfkmeWAVXH5gjDmiuw4wgu7DsG0JK/AMDcnd5c9HfzOvm7Vl4=
Received: from VI1PR08CA0087.eurprd08.prod.outlook.com (2603:10a6:800:d3::13)
 by VI1PR0802MB2608.eurprd08.prod.outlook.com (2603:10a6:800:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Tue, 13 Aug
 2019 10:07:52 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0087.outlook.office365.com
 (2603:10a6:800:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.13 via Frontend
 Transport; Tue, 13 Aug 2019 10:07:52 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 10:07:50 +0000
Received: ("Tessian outbound 1e6e633a5b56:v26"); Tue, 13 Aug 2019 10:07:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0cef8750091697e6
X-CR-MTA-TID: 64aa7808
Received: from bedec1d6489e.1 (cr-mta-lb-1.cr-mta-net [104.47.1.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 85061050-A2A2-40C6-9619-CB8E892F5769.1;
        Tue, 13 Aug 2019 10:07:40 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bedec1d6489e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 13 Aug 2019 10:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUgny7NkexRTOCifmI1SOfN8hC5p98OdJCftmf902jJ74ESVrNf7atNewwCj/rxSzyys4VuZCRS9PKs9vU9NvNHYuY5vXU2EpYzj1rEbXeMYZf7g+4Ml0bmDBEbPe+OLq8TuorjHZioBZqXFg0MNUilVVP48fOHckV16ecxjJZJkcxtbtuOuhMqqIOajrkvcTmwKqMJKx5nruM22jgLslG9ajppGDT1JFsG8hJV+ovCReTsFlcFa2kh1OsEYe8XcymrdZfLXsOqRh7WwMX/2NcHb90u3xSagIOONDqBys57pXFe3Bhy3pQYVyVZaKJpibiR6INp0xq6yhW/ek0u4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEp78bpszcqRWbo0DOWI7TMRSxcZ9yQHHBFq9zLj/8o=;
 b=IQQ9s0Im4WosagOzqP0rpU6VIH3Jn1fMMXM5Vjp7mnnG/9iAd0yjhf5K3Wh5VhrLwIaK73DtdYT6fXEefXTc2s+Q3RjQ3kwg66IMM/XDEaiw+ZJhJQz95hxKtkZU1btRU5TV0ejSubP779LuW/fl3VHvbGfj9Pph0KMcHNZxvZ4ycFHAK33B9rsigcnGQx2PrYS/qX4ZWz0KN7KYPfmQtU4/8tBOt65hMwjadVK1SDcf9AcgaabI0tst6ZH8+TmhNohy87bJ3PhSYMJhk4IwME0KP1+mW1S+hEoIQRtO4BJ4y6bqiEqzNiNlKpSUjyJSBIucC/np8WbZAF244ftNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEp78bpszcqRWbo0DOWI7TMRSxcZ9yQHHBFq9zLj/8o=;
 b=O7QvY0LeiHahS0xWp/egcNYdnD+C6DyUhQRE9ckDppS7PyDz65YcH5Et0GFNbiYffKPyyF5FoBEIgMruMzKqYaMrIGzr15I2utCiCOLLGN7I7bmadhFGZWSmIMmfkmeWAVXH5gjDmiuw4wgu7DsG0JK/AMDcnd5c9HfzOvm7Vl4=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4606.eurprd08.prod.outlook.com (20.178.14.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Tue, 13 Aug 2019 10:07:37 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 10:07:37 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
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
Subject: Re: [PATCH v2 4/4] drm/komeda: Enable Layer color management for
 komeda
Thread-Topic: [PATCH v2 4/4] drm/komeda: Enable Layer color management for
 komeda
Thread-Index: AQHVUZN5MUEXIaw5o0ydkKEl7A/UMKb42rSA
Date:   Tue, 13 Aug 2019 10:07:36 +0000
Message-ID: <3251837.i0RyjatB9e@e123338-lin>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
 <20190813045536.28239-5-james.qian.wang@arm.com>
In-Reply-To: <20190813045536.28239-5-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LNXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::23) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 84ec2606-3820-45dc-b696-08d71fd6197b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4606;
X-MS-TrafficTypeDiagnostic: VI1PR08MB4606:|VI1PR0802MB2608:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2608930F1D6D80DE0DCA0BE68FD20@VI1PR0802MB2608.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(71190400001)(9686003)(4326008)(30864003)(53936002)(6862004)(14444005)(33716001)(6636002)(71200400001)(2906002)(6246003)(5660300002)(966005)(102836004)(7736002)(6512007)(305945005)(6116002)(81156014)(81166006)(6306002)(6506007)(386003)(8676002)(256004)(52116002)(76176011)(54906003)(229853002)(478600001)(186003)(25786009)(6436002)(3846002)(26005)(66066001)(6486002)(66446008)(64756008)(66476007)(66556008)(66946007)(86362001)(486006)(316002)(8936002)(11346002)(14454004)(446003)(476003)(99286004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4606;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: BJUA8vch3mDboDy+4ldBAWaukGehpQSYaQx4xSob6sdqw9+Fu9iqeQygpq2PsoCh3PPgVeS2lWtOKqD8IMQYOs2BFyqjXZlDChGB8h0vDtt30fLkFsIYDnohxgWvc/02z8CAFi6TPBjMaZXbfCBGNo/03137Vv9AnuhiBK9+oD/Vh9NCpm8u1CijgLQYTO33MT2oDCqZUH1dlctXiXZd62QBGxQJz4qzEhl3mNPfnr+yfQVN90stE1pMHN0FCpG1WEY3rshjxGue0fi52MwWe71g0EYe2j8FHGWmzeF4WFat778kh1FbQBZngQrTIyXaWFDnOB7BfKwCmHEpvjw2dBpeX663kMIqjbLkLlke3dAZfzpqmDNzTHBeErbhgHYe4TKV30m74XUOxkE6xYdPq00zDuiEyxYdrHzShb0iPpA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47696D7744461B4496226DF71F663D0C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4606
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(81156014)(76130400001)(70206006)(70586007)(36906005)(81166006)(99286004)(478600001)(386003)(8676002)(6636002)(186003)(6506007)(63350400001)(102836004)(966005)(336012)(486006)(126002)(305945005)(23726003)(33716001)(63370400001)(356004)(6486002)(76176011)(4326008)(6116002)(3846002)(476003)(5660300002)(316002)(86362001)(46406003)(446003)(54906003)(30864003)(25786009)(26005)(11346002)(47776003)(26826003)(229853002)(14454004)(7736002)(14444005)(97756001)(2906002)(6512007)(66066001)(6246003)(22756006)(9686003)(8746002)(6862004)(50466002)(6306002)(8936002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2608;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: df4cb423-41ab-4fa4-bde5-08d71fd6111d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0802MB2608;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: 38lU8YzLrLYO881Ig6/MywZVe/ne8hior08/k0WuvNKeZ13tF5RtM73iGNU3bm+h2SnIrp0hnQQueE7NIb8liCYtkwpCYjSvnSD6/kMX5OFAQSEDXswCc+1WAfmzUXP1a7powCeYVlZHJwANC+jWfWgOxyYM/hR9ANnAQL9DQiApirZt58kv3yl+NbpIBLACs0wavr1e2yU0vtDolcOlynYrfCkEeVJgEWC3nYP5kIiftm5/eXjf3S6grPVTZCjIo2WSQj97homDTf8gvbEarRA9vzlCgrmbI6IIPt/k7CMomIdOuhUcqZGuyME/hTA6gLHsMJNDkVYcpwlvk3neoehORXqwIItrRj2f6dBvs5wfePQ5T7zcJD1gLd93I26t4Bzq2fAhnQjWUeqVf/pyAL3wtk+g0kd+N7kTpAAC8rg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 10:07:50.6314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ec2606-3820-45dc-b696-08d71fd6197b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tuesday, 13 August 2019 05:56:19 BST james qian wang (Arm Technology Chi=
na) wrote:
> - D71 has 3 global layer gamma table which can be used for all layers as
>   gamma lookup table, no matter inverse or forward.
> - Add komeda_color_manager/state to layer/layer_state for describe the
>   color caps for the specific layer which will be initialized in
>   d71_layer_init, and for D71 only layer with L_INFO_CM (color mgmt) bit
>   can support forward gamma, and CSC.
> - Update komeda-CORE code to validate and convert the plane color state t=
o
>   komeda_color_state.
> - Enable plane color mgmt according to layer komeda_color_manager
>=20
> This patch depends on:
> - https://patchwork.freedesktop.org/series/30876/
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 64 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  5 +-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  2 +
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  4 +-
>  .../display/komeda/komeda_pipeline_state.c    | 53 ++++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_plane.c | 12 ++++
>  .../arm/display/komeda/komeda_private_obj.c   |  4 ++
>  7 files changed, 139 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 55a8cc94808a..c9c40a36e4d2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -189,6 +189,46 @@ static void d71_layer_update_fb(struct komeda_compon=
ent *c,
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  }
> =20
> +static u32 d71_layer_update_color(struct drm_plane_state *st,
> +				  u32 __iomem *reg,
> +				  struct komeda_color_state *color_st,
> +				  u32 *mask)
> +{
> +	struct komeda_coeffs_table *igamma =3D color_st->igamma;
> +	struct komeda_coeffs_table *fgamma =3D color_st->fgamma;
> +	u32 ctrl =3D 0, v =3D 0;
> +
> +	if (!st->color_mgmt_changed)
> +		return 0;
> +
> +	*mask |=3D L_IT | L_R2R | L_FT;
> +
> +	if (igamma) {
> +		komeda_coeffs_update(igamma);
> +		ctrl |=3D L_IT;
> +		v =3D L_ITSEL(igamma->hw_id);
> +	}
> +
> +	if (st->ctm) {
> +		u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
> +
> +		drm_ctm_to_coeffs(st->ctm, ctm_coeffs);
> +		malidp_write_group(reg, LAYER_RGB_RGB_COEFF0,
> +				   ARRAY_SIZE(ctm_coeffs),
> +				   ctm_coeffs);
> +		ctrl |=3D L_R2R; /* enable RGB2RGB conversion */
> +	}
> +
> +	if (fgamma) {
> +		komeda_coeffs_update(fgamma);
> +		ctrl |=3D L_FT;
> +		v |=3D L_FTSEL(fgamma->hw_id);
> +	}
> +
> +	malidp_write32(reg, LAYER_LT_COEFFTAB, v);
> +	return ctrl;
> +}
> +
>  static void d71_layer_disable(struct komeda_component *c)
>  {
>  	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
> @@ -261,6 +301,8 @@ static void d71_layer_update(struct komeda_component =
*c,
> =20
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> =20
> +	ctrl |=3D d71_layer_update_color(plane_st, reg, &st->color_st, &ctrl_ma=
sk);
> +
>  	if (kfb->is_va)
>  		ctrl |=3D L_TBU_EN;
>  	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
> @@ -365,6 +407,12 @@ static int d71_layer_init(struct d71_dev *d71,
>  	else
>  		layer->layer_type =3D KOMEDA_FMT_SIMPLE_LAYER;
> =20
> +	layer->color_mgr.igamma_mgr =3D d71->glb_lt_mgr;
> +	if (layer_info & L_INFO_CM) {
> +		layer->color_mgr.has_ctm =3D true;
> +		layer->color_mgr.fgamma_mgr =3D d71->glb_lt_mgr;
> +	}
> +
>  	set_range(&layer->hsize_in, 4, d71->max_line_size);
>  	set_range(&layer->vsize_in, 4, d71->max_vsize);
> =20
> @@ -1140,6 +1188,21 @@ static int d71_timing_ctrlr_init(struct d71_dev *d=
71,
>  	return 0;
>  }
> =20
> +static void d71_gamma_update(struct komeda_coeffs_table *table)
> +{
> +	malidp_write_group(table->reg, GLB_LT_COEFF_DATA,
> +			   GLB_LT_COEFF_NUM, table->coeffs);
> +}
> +
> +static int d71_lt_coeff_init(struct d71_dev *d71,
> +			     struct block_header *blk, u32 __iomem *reg)
> +{
> +	struct komeda_coeffs_manager *mgr =3D d71->glb_lt_mgr;
> +	int hw_id =3D BLOCK_INFO_TYPE_ID(blk->block_info);
> +
> +	return komeda_coeffs_add(mgr, hw_id, reg, d71_gamma_update);
> +}
> +
>  int d71_probe_block(struct d71_dev *d71,
>  		    struct block_header *blk, u32 __iomem *reg)
>  {
> @@ -1202,6 +1265,7 @@ int d71_probe_block(struct d71_dev *d71,
>  		break;
> =20
>  	case D71_BLK_TYPE_GLB_LT_COEFF:
> +		err =3D d71_lt_coeff_init(d71, blk, reg);
>  		break;
> =20
>  	case D71_BLK_TYPE_GLB_SCL_COEFF:
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index d567ab7ed314..edd5d7c7f2a2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -341,7 +341,7 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
>  	struct komeda_pipeline *pipe;
>  	struct block_header blk;
>  	u32 __iomem *blk_base;
> -	u32 i, value, offset;
> +	u32 i, value, offset, coeffs_size;
>  	int err;
> =20
>  	d71 =3D devm_kzalloc(mdev->dev, sizeof(*d71), GFP_KERNEL);
> @@ -398,6 +398,9 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
>  		d71->pipes[i] =3D to_d71_pipeline(pipe);
>  	}
> =20
> +	coeffs_size =3D GLB_LT_COEFF_NUM * sizeof(u32);
> +	d71->glb_lt_mgr =3D komeda_coeffs_create_manager(coeffs_size);
> +
>  	/* loop the register blks and probe */
>  	i =3D 2; /* exclude GCU and PERIPH */
>  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.h
> index 84f1878b647d..009c164a1584 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> @@ -39,6 +39,8 @@ struct d71_dev {
>  	u32 __iomem	*periph_addr;
> =20
>  	struct d71_pipeline *pipes[D71_MAX_PIPELINE];
> +	 /* global layer transform coefficient table manager */
> +	struct komeda_coeffs_manager *glb_lt_mgr;
>  };
> =20
>  #define to_d71_pipeline(x)	container_of(x, struct d71_pipeline, base)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index a7a84e66549d..4104c81e5032 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -10,6 +10,7 @@
>  #include <linux/types.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include "komeda_color_mgmt.h"
>  #include "malidp_utils.h"
> =20
>  #define KOMEDA_MAX_PIPELINES		2
> @@ -226,6 +227,7 @@ struct komeda_layer {
>  	struct komeda_component base;
>  	/* accepted h/v input range before rotation */
>  	struct malidp_range hsize_in, vsize_in;
> +	struct komeda_color_manager color_mgr;
>  	u32 layer_type; /* RICH, SIMPLE or WB */
>  	u32 supported_rots;
>  	/* komeda supports layer split which splits a whole image to two parts
> @@ -238,7 +240,7 @@ struct komeda_layer {
> =20
>  struct komeda_layer_state {
>  	struct komeda_component_state base;
> -	/* layer specific configuration state */
> +	struct komeda_color_state color_st;
>  	u16 hsize, vsize;
>  	u32 rot;
>  	u16 afbc_crop_l;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index ea26bc9c2d00..803715c1128e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -95,6 +95,21 @@ komeda_pipeline_get_state_and_set_crtc(struct komeda_p=
ipeline *pipe,
>  	return st;
>  }
> =20
> +static bool komeda_component_is_new_active(struct komeda_component *c,
> +					   struct drm_atomic_state *state)
> +{
> +	struct komeda_pipeline_state *ppl_old_st;
> +
> +	ppl_old_st =3D komeda_pipeline_get_old_state(c->pipeline, state);
> +	if (IS_ERR(ppl_old_st))
> +		return true;
> +
> +	if (has_bit(c->id, ppl_old_st->active_comps))
> +		return false;
> +
> +	return true;
> +}
> +
>  static struct komeda_component_state *
>  komeda_component_get_state(struct komeda_component *c,
>  			   struct drm_atomic_state *state)
> @@ -279,6 +294,29 @@ komeda_rotate_data_flow(struct komeda_data_flow_cfg =
*dflow, u32 rot)
>  	}
>  }
> =20
> +static int
> +komeda_validate_plane_color(struct komeda_component *c,
> +			    struct komeda_color_manager *color_mgr,
> +			    struct komeda_color_state *color_st,
> +			    struct drm_plane_state *plane_st)
> +{
> +	int err;
> +
> +	if (komeda_component_is_new_active(c, plane_st->state))
> +		plane_st->color_mgmt_changed =3D true;
> +
> +	if (!plane_st->color_mgmt_changed)
> +		return 0;
> +
> +	err =3D komeda_color_validate(color_mgr, color_st,
> +				    plane_st->degamma_lut,
> +				    plane_st->gamma_lut);
> +	if (err)
> +		DRM_DEBUG_ATOMIC("%s validate color failed.\n", c->name);
> +
> +	return err;
> +}
> +
>  static int
>  komeda_layer_check_cfg(struct komeda_layer *layer,
>  		       struct komeda_fb *kfb,
> @@ -362,6 +400,11 @@ komeda_layer_validate(struct komeda_layer *layer,
>  		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->in_x,
>  						       dflow->in_y, i);
> =20
> +	err =3D komeda_validate_plane_color(&layer->base, &layer->color_mgr,
> +					  &st->color_st, plane_st);
> +	if (err)
> +		return err;
> +
>  	err =3D komeda_component_validate_private(&layer->base, c_st);
>  	if (err)
>  		return err;
> @@ -1177,7 +1220,7 @@ komeda_pipeline_unbound_components(struct komeda_pi=
peline *pipe,
>  {
>  	struct drm_atomic_state *drm_st =3D new->obj.state;
>  	struct komeda_pipeline_state *old =3D priv_to_pipe_st(pipe->obj.state);
> -	struct komeda_component_state *c_st;
> +	struct komeda_component_state *st;
>  	struct komeda_component *c;
>  	u32 disabling_comps, id;
> =20
> @@ -1188,9 +1231,13 @@ komeda_pipeline_unbound_components(struct komeda_p=
ipeline *pipe,
>  	/* unbound all disabling component */
>  	dp_for_each_set_bit(id, disabling_comps) {
>  		c =3D komeda_pipeline_get_component(pipe, id);
> -		c_st =3D komeda_component_get_state_and_set_user(c,
> +		st =3D komeda_component_get_state_and_set_user(c,
>  				drm_st, NULL, new->crtc);
> -		WARN_ON(IS_ERR(c_st));
> +
> +		WARN_ON(IS_ERR(st));
I think this needs to be:
if (WARN_ON(IS_ERR(st)))
        continue;
...because...
> +
> +		if (has_bit(id, KOMEDA_PIPELINE_LAYERS))
> +			komeda_color_cleanup_state(&to_layer_st(st)->color_st);
... this may deref an invalid `st' otherwise.
>  	}
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index 98e915e325dd..69fa1dea41c9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -11,6 +11,7 @@
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
>  #include "komeda_framebuffer.h"
> +#include "komeda_color_mgmt.h"
> =20
>  static int
>  komeda_plane_init_data_flow(struct drm_plane_state *st,
> @@ -250,6 +251,7 @@ static int komeda_plane_add(struct komeda_kms_dev *km=
s,
>  {
>  	struct komeda_dev *mdev =3D kms->base.dev_private;
>  	struct komeda_component *c =3D &layer->base;
> +	struct komeda_color_manager *color_mgr;
>  	struct komeda_plane *kplane;
>  	struct drm_plane *plane;
>  	u32 *formats, n_formats =3D 0;
> @@ -306,6 +308,16 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
ms,
>  	if (err)
>  		goto cleanup;
> =20
> +	err =3D drm_plane_color_create_prop(plane->dev, plane);
> +	if (err)
> +		goto cleanup;
> +
> +	color_mgr =3D &layer->color_mgr;
> +	drm_plane_enable_color_mgmt(plane,
> +			color_mgr->igamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0,
> +			color_mgr->has_ctm,
> +			color_mgr->fgamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0);
> +
>  	err =3D drm_plane_create_zpos_property(plane, layer->base.id, 0, 8);
>  	if (err)
>  		goto cleanup;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> index 914400c4af73..4c474663f554 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> @@ -19,12 +19,15 @@ komeda_component_state_reset(struct komeda_component_=
state *st)
>  static struct drm_private_state *
>  komeda_layer_atomic_duplicate_state(struct drm_private_obj *obj)
>  {
> +	struct komeda_layer_state *old =3D to_layer_st(priv_to_comp_st(obj->sta=
te));
>  	struct komeda_layer_state *st;
> =20
>  	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
>  	if (!st)
>  		return NULL;
> =20
> +	komeda_color_duplicate_state(&st->color_st, &old->color_st);
> +
>  	komeda_component_state_reset(&st->base);
>  	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
> =20
> @@ -37,6 +40,7 @@ komeda_layer_atomic_destroy_state(struct drm_private_ob=
j *obj,
>  {
>  	struct komeda_layer_state *st =3D to_layer_st(priv_to_comp_st(state));
> =20
> +	komeda_color_cleanup_state(&st->color_st);
>  	kfree(st);
>  }
> =20
>=20

BR,
Mihail



