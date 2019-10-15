Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE08C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D882C2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ej3MUu2N";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ej3MUu2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJOIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:30:19 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:59598
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfJOIaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD9/kB+CaGYjLiyrA4Bcr5NAuto1tdOngTBiU9HujLQ=;
 b=ej3MUu2NjDWd6mm5HG+Gxa3ICtFLKNCsIccJb1uuptfzz0o8NiiP4xPlgXnrJIz/kTmnuEOKIxXR6l7kQd6hUW0pIoTwn1etJD+uHZdGvAl4ljyoIo+ChtaRYyglLgTawsg+2ngHV7+4Z1cFkvk79Eb+hsozmH8mcXV4DDvglLI=
Received: from VI1PR08CA0239.eurprd08.prod.outlook.com (2603:10a6:802:15::48)
 by VI1PR08MB2990.eurprd08.prod.outlook.com (2603:10a6:803:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Tue, 15 Oct
 2019 08:30:08 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0239.outlook.office365.com
 (2603:10a6:802:15::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.22 via Frontend
 Transport; Tue, 15 Oct 2019 08:30:08 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 08:30:05 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Tue, 15 Oct 2019 08:30:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 997d37604a346b9d
X-CR-MTA-TID: 64aa7808
Received: from aa6095eeaf68.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0BC840AC-9B0B-4CB4-B70E-FB0646B86E3B.1;
        Tue, 15 Oct 2019 08:29:54 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aa6095eeaf68.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Oct 2019 08:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJELzFzuFfaIKeBwTkPpBxcXL35hlU2ZtkhCOCjTEx3hhj8OIOnnZSvagzF6BTmacZkhR80cY5o3oH0ATnc+TEFOtpKMP9/ufIGlTZtQWsneoXrU+B4/PEt+suEz1wdKG1ZxrcERjzl5HwpK/ukmvXGddd2opu9KjnwJWEHyVIT5QzT7WwxT9ILMBOVOilRqUFsM2akY4bsit5Rr0I0Argq/R0zPeydgCY5E7cjsmRH+JQD78zvMn/tgLHUTzLjSZGwPmTF5sAPtRlOcJU/xTPU3qhan1AcQY2FbJ0AG01OqpBLdJ84nasGTrx6Pqe9iVZOPOx5rIrTW1XvUAbdheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD9/kB+CaGYjLiyrA4Bcr5NAuto1tdOngTBiU9HujLQ=;
 b=PwyufANGly0r/3nFtJiwj/TYL/fzaRwIYHMuu9gpkPX3S0BWQ+3lwLMh1SnAeYzwNK5nBr2UDi36lVpG8pHMjX4Mjo9IhcaSIbS+QmY45nvaxn23lPv2ka5UfVLack1QqR/FeAnrj1zBJPUHYCi8K/WkwO8YlvmHT9dxkwl2FgwPKLcdwjzMBWq2dL10XAng5qx/XX7S0LcGwIGQEOJv21/PAB4HVg5zsYSMGj3cx7irGcEJgHLbAgf0Ofg9/eWg5Ra+qGqLrWFS5rohJY7nH3xMq1ldcXh8N+WHxrPfn1RX9wDgf4BKpOu1781FwEfz0vl7+ioM+XtEi+cWF0e4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD9/kB+CaGYjLiyrA4Bcr5NAuto1tdOngTBiU9HujLQ=;
 b=ej3MUu2NjDWd6mm5HG+Gxa3ICtFLKNCsIccJb1uuptfzz0o8NiiP4xPlgXnrJIz/kTmnuEOKIxXR6l7kQd6hUW0pIoTwn1etJD+uHZdGvAl4ljyoIo+ChtaRYyglLgTawsg+2ngHV7+4Z1cFkvk79Eb+hsozmH8mcXV4DDvglLI=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 08:29:53 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:29:53 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVgv3O8k6iQiFsIUKRPFsOmP4H16dbX3GA
Date:   Tue, 15 Oct 2019 08:29:52 +0000
Message-ID: <20191015082951.daxl5wpyt4h7xshh@DESKTOP-E1NTVVP.localdomain>
References: <20191015021016.327-1-james.qian.wang@arm.com>
 <20191015021016.327-3-james.qian.wang@arm.com>
In-Reply-To: <20191015021016.327-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: AM0PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::25) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee9b2cb-fc54-4428-9ad9-08d75149e172
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB5048:|AM6PR08MB5048:|VI1PR08MB2990:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB299048724A3DDEE23458D93AF0930@VI1PR08MB2990.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2449;OLM:2449;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(478600001)(25786009)(1076003)(44832011)(6636002)(7736002)(305945005)(2906002)(229853002)(81156014)(66476007)(66556008)(8936002)(81166006)(8676002)(64756008)(66946007)(66446008)(4326008)(6862004)(6246003)(6486002)(6436002)(9686003)(6512007)(66066001)(3846002)(99286004)(446003)(6116002)(11346002)(76176011)(86362001)(476003)(52116002)(316002)(5660300002)(71200400001)(71190400001)(486006)(6506007)(14454004)(386003)(54906003)(102836004)(186003)(58126008)(14444005)(256004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5048;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fAoB5XbxzsKMHR8l76/o8RoWl1xV2VAJu7gcaWtD0ofX6VefAMj2XLVrYA6JG43PhxeYt2Povff8smH9Ep/sIUe8N9zJnVjx+QSuWzOOx2aJ2mi6TazyJfonAQlab721O0Fofac9LeDau0f23wQr1RP5BaD6DNYgsB4KxLL9/hj3ks4PEeDVUKuABbTmfJFJWXTNP51ALNj3hnQJ8O+8EHnlvPLKllaaXFAAbsyXUUBVIPlKj1Lkx1LY3PQOXjVpzbRYI0e63y70pKSWz0ITTGZpzdNknniRRT3gwiHILmQe/7wzEsM/ZX2SPUUD0T0jIlGO/8XBvE9CSH4HZ3FA5vllWIF1jr6OwheqNXNkCItDDmtW29a1qMEIFDi3EQZFyaFvS4RdRw+gtqYtS/ems9VpujYcGcEy2gG8pQy0Y54=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DD28CA23DCA4A45A3F7E6FD60AC9C52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5048
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(102836004)(46406003)(76176011)(8746002)(316002)(63350400001)(9686003)(446003)(6512007)(229853002)(97756001)(58126008)(99286004)(386003)(6506007)(86362001)(22756006)(54906003)(66066001)(26005)(26826003)(6486002)(478600001)(5660300002)(8936002)(1076003)(23726003)(47776003)(186003)(6636002)(14444005)(6116002)(3846002)(81166006)(81156014)(6246003)(14454004)(8676002)(486006)(356004)(336012)(76130400001)(2906002)(70586007)(4326008)(25786009)(6862004)(126002)(50466002)(305945005)(7736002)(70206006)(11346002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2990;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2415c43e-4e20-4dc0-2322-08d75149d9e3
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npDKWNF3qHX53L4ve3tEAnH7KJjRzCgDYJmio9YjBssAjiWDRJHQVZn/V2Yo9uAI2fOrUs+eix4HYecISMt7i3yviTg/AdFn8f/PeAr3EO/81SDE43zWKLyUsU39sm3sj/e8PURSgQafjI06AsrQT8XkClSYnDk4Wir6chhdD8m9ajEsAvfoSbd7biLOcpY7NoGuY7N03y1WUDgy1UsluPJe+2LHE+5J9WZQs4n+NrrdVewPFYv91Xt03aYk92LCFPEPci5zKGLiVojF6CddmZ01m7onI/dpiyJ1JQOGztCzedpHFiowDuyN5B1is6myDcsEagi+0LQ0ZvycB13U76gRw2mDxNYLSlbQdrErpLBIWGB6vZeXjYYc7uzGWS7zJO85jc+6twbKDgkCaz0KD9ycU4IX3dzEiFR6X6e9V34=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 08:30:05.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee9b2cb-fc54-4428-9ad9-08d75149e172
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Oct 15, 2019 at 02:10:53AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> This function is used to convert drm 3dlut to komeda HW required 1d curve

This is a 1D LUT, not a 3D LUT

Cheers,
-Brian

> coeffs values.
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  .../arm/display/komeda/komeda_color_mgmt.c    | 52 +++++++++++++++++++
>  .../arm/display/komeda/komeda_color_mgmt.h    |  9 +++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index 9d14a92dbb17..c180ce70c26c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -65,3 +65,55 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_enco=
ding, u32 color_range)
> =20
>  	return coeffs;
>  }
> +
> +struct gamma_curve_sector {
> +	u32 boundary_start;
> +	u32 num_of_segments;
> +	u32 segment_width;
> +};
> +
> +struct gamma_curve_segment {
> +	u32 start;
> +	u32 end;
> +};
> +
> +static struct gamma_curve_sector sector_tbl[] =3D {
> +	{ 0,    4,  4   },
> +	{ 16,   4,  4   },
> +	{ 32,   4,  8   },
> +	{ 64,   4,  16  },
> +	{ 128,  4,  32  },
> +	{ 256,  4,  64  },
> +	{ 512,  16, 32  },
> +	{ 1024, 24, 128 },
> +};
> +
> +static void
> +drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
> +		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
> +{
> +	struct drm_color_lut *lut;
> +	u32 i, j, in, num =3D 0;
> +
> +	if (!lut_blob)
> +		return;
> +
> +	lut =3D lut_blob->data;
> +
> +	for (i =3D 0; i < num_sectors; i++) {
> +		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
> +			in =3D sector_tbl[i].boundary_start +
> +			     j * sector_tbl[i].segment_width;
> +
> +			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
> +						KOMEDA_COLOR_PRECISION);
> +		}
> +	}
> +
> +	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
> +}
> +
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs)
> +{
> +	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl))=
;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> index a2df218f58e7..08ab69281648 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> @@ -11,7 +11,14 @@
>  #include <drm/drm_color_mgmt.h>
> =20
>  #define KOMEDA_N_YUV2RGB_COEFFS		12
> +#define KOMEDA_N_RGB2YUV_COEFFS		12
> +#define KOMEDA_COLOR_PRECISION		12
> +#define KOMEDA_N_GAMMA_COEFFS		65
> +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
> +#define KOMEDA_N_CTM_COEFFS		9
> +
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs);
> =20
>  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge);
> =20
> -#endif
> +#endif /*_KOMEDA_COLOR_MGMT_H_*/
> --=20
> 2.20.1
>=20
