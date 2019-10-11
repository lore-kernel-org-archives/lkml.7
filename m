Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2770AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1AB2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ehiesx1K";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ehiesx1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfJKIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:39:54 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:17986
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfJKIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28GGuu3K9YqFf3AYiW4eldKKm1MXDtrHAc9zcfNljY=;
 b=Ehiesx1Kd2G66h6Z88EHi2RSD6P1Vabzz8WZSSRYR5MdwrkkMy7lYbllAUet51XomPjwMxH520FEUVRmwvPSY3uZno9JHPUkiUVZ3s3GRH+4Mn1osRLWQVSLgycpQ6XSAqEp2u2jMFlNPhlTqhIBay5gSkJqvgqPs5tzbRq7N7U=
Received: from VI1PR08CA0140.eurprd08.prod.outlook.com (2603:10a6:800:d5::18)
 by AM6PR08MB5158.eurprd08.prod.outlook.com (2603:10a6:20b:ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 08:38:06 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR08CA0140.outlook.office365.com
 (2603:10a6:800:d5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 08:38:06 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 08:38:05 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Fri, 11 Oct 2019 08:37:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 18a55e67db5b86f3
X-CR-MTA-TID: 64aa7808
Received: from cdbdbaa94d86.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6D2F009E-55F0-4339-A076-C8A348A2DDEE.1;
        Fri, 11 Oct 2019 08:37:51 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cdbdbaa94d86.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 08:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg7VHAuAqSl1veZdR+DsnnafBFdjxz52ijXTZq7GIhPJgyPT2igY5ecd2ORJ25MMMLrvrXYw0UsgdiL5KCO5frwhiuv/KNGkD+dzLgYouZsYg7vHa4ajb7BHJ2vQSStaipeBujiO0hL1LOSdF0coRfW66aL961Q/y0fTahZFyTZzDpjdw0GryXRdFDd0TdT5MZ4dx9JyPgVUnnrlCdUaUvAGkFeUwoKh72DroUc96upl/HT9hA9gN6JQzRt2E7nFdqp3SrBldQ5g34Q/bjpCnqs/xIFizzPYByHnKl2+THyUwWjSmoQ9/4srNkNHXUZg9smZriRArXFtzEHB8udkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28GGuu3K9YqFf3AYiW4eldKKm1MXDtrHAc9zcfNljY=;
 b=Q3dTNQ9N18KgMQqyzWKvkO5QDUVvyx6Nnvs3rUnKsqiWrj/TulBdDQFPZh2cX2PuSAzfaJwx4OGDhl5p5MaLg0Sn0E0GyWoy2dznWljRwYYikkawlPd5YjrtBYKSbtW5rBa6npkO+fpY1u7jZlkPJEXZ/SS/FoYOh5OtIDn+POcezaZKuFo17KrfFqh4Wdy6IwArkRHz3Dpj9o/waQBaUaEgAoTJsuhQJXP8FDv7ZVfN5YyT8aam2NzykaWbdzl1fbJbM0cwb6DoYRy1VHdEAILFOPw6LrW4OPcF86Fq/YF0e0TBQUobU5GRO7DKtC+DpIfOrI/eNelbu4BDJRMByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28GGuu3K9YqFf3AYiW4eldKKm1MXDtrHAc9zcfNljY=;
 b=Ehiesx1Kd2G66h6Z88EHi2RSD6P1Vabzz8WZSSRYR5MdwrkkMy7lYbllAUet51XomPjwMxH520FEUVRmwvPSY3uZno9JHPUkiUVZ3s3GRH+4Mn1osRLWQVSLgycpQ6XSAqEp2u2jMFlNPhlTqhIBay5gSkJqvgqPs5tzbRq7N7U=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3630.eurprd08.prod.outlook.com (20.177.61.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 11 Oct 2019 08:37:49 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:37:49 +0000
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
Subject: Re: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH v2 3/4] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVf/clWn1lNlR63U6qt5ndUaDKFadVHmKA
Date:   Fri, 11 Oct 2019 08:37:48 +0000
Message-ID: <25767213.BG6Th7YoJn@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-4-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-4-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe6a5de-abcf-4ac3-dbcd-08d74e2655e2
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3630:|VI1PR08MB3630:|AM6PR08MB5158:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5158CC71E692A81ED119C0A18F970@AM6PR08MB5158.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(6862004)(6246003)(54906003)(316002)(66946007)(66446008)(64756008)(66556008)(66476007)(14454004)(6436002)(6512007)(9686003)(6486002)(25786009)(478600001)(7736002)(66066001)(4326008)(71190400001)(305945005)(6506007)(386003)(2906002)(6116002)(71200400001)(11346002)(99286004)(26005)(6636002)(476003)(486006)(229853002)(256004)(3846002)(446003)(81166006)(8676002)(81156014)(76176011)(8936002)(86362001)(52116002)(102836004)(186003)(5660300002)(33716001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3630;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qnFLkiTwq/6Ei3Oia1zwhVpwnYxR+2/cU2uYa7Q+Pq42qOz0nLweULSNpoDlZ2j6L7s3D7iENQwXc+QE5PeuCydarS8bNWKjO3WCNEDXQ2oJIDhvksvxm3ZehJZDPitNjlsUSl9JAIHV7RUkSrZ4+oJtj2CRQk/cP24aRQ/BJ46WE12wndKMAhdu0qWW5rFA0SvD2eqTJSZP902R2RgLJwvx/q+bBhBkEAyxS72w0Tuo/kChanohVOoI+P14izJ0/Csv19Bh5PsMZP6kwlkjT2IWteerFakRvHoDHFfOfpUS58KbGISeiuY1HSBK8KAmStJg4FFOZrYXDgXornQrAvCfWJ1xHaQzdIkO0lwcLVir3mI3LFtpkSD+W2FPLHx4g+jX/0CTYEI+2LRjPU70miLXr2nQ5bNvJvuVEGkg+1s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C83F7169AC8AF845AAFA7DF2C36259EC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3630
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(50466002)(7736002)(54906003)(22756006)(81166006)(66066001)(356004)(316002)(6486002)(102836004)(6636002)(81156014)(36906005)(8746002)(8936002)(5660300002)(305945005)(47776003)(8676002)(26826003)(11346002)(336012)(14454004)(99286004)(97756001)(476003)(126002)(6862004)(486006)(63350400001)(478600001)(9686003)(386003)(2906002)(186003)(86362001)(6246003)(6512007)(26005)(76176011)(4326008)(33716001)(76130400001)(23726003)(3846002)(25786009)(6116002)(229853002)(46406003)(6506007)(446003)(70206006)(70586007)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5158;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0404b903-6eba-4682-c33c-08d74e264c03
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65TEdWBiSx4I2T3EhRh3/Cgg3/9dHC/r6qMpu5ekb5QZJvprL20Mbb52CMNciM118aqRl59DBu1i1cN5XwdYLZltbhgxRAscxucqe2/LSBlY9NfJKI0oD5Ux8QpFJPWATN2oXygmZ8ZobjQv4IuchDjkOUI4V281Cb6e1B0Be0qd7Ax4h/TJDFEuPOPGvd2b3eJBr2cnc4UlmmeJ8v6P9V5z2E/kaPP7y4e/nbwx2FbcSOVllD6/kb0GB01xspO5x4gFFshhPn9m6OC65TiheFEdSbGaoYNRfCBVB44Ng4W8ykE7qraboQWd9ky9WSquerlg57L2qxj/i23b99dmH3v9gw0UmmE8GNkOjom5fNxkOWT/edE3eHqiYrG1Wa2rd8XdI0AnR1vuu2VCNw5oxMziMh27PMu+8btFq+MTECM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 08:38:05.1818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe6a5de-abcf-4ac3-dbcd-08d74e2655e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11 October 2019 06:45:42 BST james qian wang (Arm Technology Chi=
na) wrote:
> This function is for converting drm_color_ctm matrix to komeda hardware
> required required Q2.12 2's complement CSC matrix.
>=20
> v2:
>   Move the fixpoint conversion function s31_32_to_q2_12() to drm core
>   as a shared helper.
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 14 ++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |  1 +
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index c180ce70c26c..ad668accbdf4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -117,3 +117,17 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_bl=
ob *lut_blob, u32 *coeffs)
>  {
>  	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl))=
;
>  }
> +
> +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
[nit] Could do with an extra const or two on the drm_property_blob,
otherwise...
> +{
> +	struct drm_color_ctm *ctm;
> +	u32 i;
> +
> +	if (!ctm_blob)
> +		return;
> +
> +	ctm =3D ctm_blob->data;
> +
> +	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; i++)
> +		coeffs[i] =3D drm_color_ctm_s31_32_to_qm_n(ctm->matrix[i], 2, 12);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> index 08ab69281648..2f4668466112 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> @@ -18,6 +18,7 @@
>  #define KOMEDA_N_CTM_COEFFS		9
> =20
>  void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs);
> +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
> =20
>  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge);
> =20
>=20
...
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



