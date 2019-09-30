Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3CBC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED72190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KX+UEKh2";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KX+UEKh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfI3LFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:05:05 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:59493
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbfI3LFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieXO29+sPFFvolftawXOulWfErEGKiRbsgPQ0a4e9G4=;
 b=KX+UEKh2HgHfIOKLty/waDzA7U93zB3/Xn7lXeFo+wkO9twOfPlwUYMIIDLvlznBSax0DRJryKT7J+Z/16TcGIWhKEES71SOenxWx04A3VeREXXne9ADv3mouaLcFUdlHSVN5Ov+/oTiKJhjLhNkQGsC2enSU37tZattvA27DK0=
Received: from DB7PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:5:16::17) by
 AM6PR08MB4567.eurprd08.prod.outlook.com (2603:10a6:20b:b0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 11:04:57 +0000
Received: from DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by DB7PR08CA0004.outlook.office365.com
 (2603:10a6:5:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Mon, 30 Sep 2019 11:04:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT014.mail.protection.outlook.com (10.152.20.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 11:04:54 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 30 Sep 2019 11:04:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 30ac3e6b0742160c
X-CR-MTA-TID: 64aa7808
Received: from dfd7421f2557.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7E27A28D-C822-4792-B7C4-F069EC24830A.1;
        Mon, 30 Sep 2019 11:04:41 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dfd7421f2557.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 11:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTxSvJUx7VTBhKPOV/7d8qvVSLF6nOfTcoukuI6S9wR6t6ofYjtPt47oeCYD8E6Q59WENAEicB2yn/Enwbl/edDZNne4rMr2BpuLmsur+q0EYG99/O+2e3ziW9legmVcnMoO1yzDHdn6GVkyFSz6FTgMlqp+OafgG2IklIVqyF6Eg+vMvnbxxA9m/jVnv7LnN8Zrs63TxiqnMEsRiPVROidQmP6E/8jbBaeikH+fhxMseX/pxgebNRvF9iDfHh/JdKqmZPrB8L1fJ5pBUD4RkMiSpk51QL2Hftht5yKKUaNKZxpWJTBoGLfU9HdcuuQp5kbB2W4tNIzoqjqTd17UUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieXO29+sPFFvolftawXOulWfErEGKiRbsgPQ0a4e9G4=;
 b=GkhjUbzX7e3GikZTplbVDkSzGhR8LZJs28u6vISHv6qjlbXDRkrL9uY5PSbr6V5Sq9EThUs5VzcXWy4AcJFIe/oRHEPokiYMV3Jz3D/ysNlrJgChhlGKJLn/le6/j1ajP6hHIQMgtYREZzEiIsD5FqjFegrgaElLF7P/VzNbvD0/UfGEFN7GvYGzM9sswIuSsAjh+BD0FcMzSvg6EHJ7HZ0gTXi7dFr1G9PqalXBT6vMFkamI/kYaGwuT5gWu8/FsLBamz9RrpXtnErlUZuxJO3O5JFPNClOCUgeEtP0qKiiEK/nemhHt7wzpwxUozWU7gfmCU31mRd0jhSDfe1wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieXO29+sPFFvolftawXOulWfErEGKiRbsgPQ0a4e9G4=;
 b=KX+UEKh2HgHfIOKLty/waDzA7U93zB3/Xn7lXeFo+wkO9twOfPlwUYMIIDLvlznBSax0DRJryKT7J+Z/16TcGIWhKEES71SOenxWx04A3VeREXXne9ADv3mouaLcFUdlHSVN5Ov+/oTiKJhjLhNkQGsC2enSU37tZattvA27DK0=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4998.eurprd08.prod.outlook.com (10.255.120.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 11:04:39 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.028; Mon, 30 Sep 2019
 11:04:39 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Topic: [PATCH 2/3] drm/komeda: Add drm_ctm_to_coeffs()
Thread-Index: AQHVd0syoKU25huCdkWmRqYuLiJjnqdEDx0A
Date:   Mon, 30 Sep 2019 11:04:39 +0000
Message-ID: <20190930110438.6w7jtw2e5s2ykwnd@DESKTOP-E1NTVVP.localdomain>
References: <20190930045408.8053-1-james.qian.wang@arm.com>
 <20190930045408.8053-3-james.qian.wang@arm.com>
In-Reply-To: <20190930045408.8053-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::18) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1340aea1-eea9-402f-c970-08d7459606c1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB4998:|AM6PR08MB4998:|AM6PR08MB4567:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45673B1266772AE86ABC1468F0820@AM6PR08MB4567.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(186003)(2906002)(1076003)(229853002)(8676002)(52116002)(81156014)(6486002)(14454004)(76176011)(8936002)(86362001)(476003)(486006)(81166006)(6246003)(66066001)(102836004)(256004)(11346002)(26005)(99286004)(6506007)(386003)(446003)(7736002)(9686003)(6512007)(6436002)(305945005)(5660300002)(6636002)(66446008)(54906003)(66946007)(66476007)(66556008)(64756008)(71200400001)(44832011)(25786009)(478600001)(6862004)(4326008)(6116002)(58126008)(3846002)(71190400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4998;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1XPx0EX+SyiasvlgzLgRuTTpEDB5KaCDukA4vc+fbUALuh8eTtopZtwqujNf/TEBN7OW8VCGi+DN7n/WB5aQZA/1VXK+SgUpPqt6tAzToL0pwQIo2jGApHgo5Z0xfz2K7eFarsqiiF7Y6S2F8+n31wdEm0zPjz68IsHxkHZWGtILuQM3TddP4ACiVsC+n48R1zaCsDJ84v2yQpK9jTlWz/VOlmBwEk+56obv1d6z5Lj6z3yTXGK+fYqy9FvFWevCSxOMOTJY6T4nKqXPQLCgeMV0SPNn8mAwWDl+hx2gi06arrOc1WDIKI3RbJx/yBlTgkMq6qnf2ZH9calv0lIYJFvTiEMWRiasD4A5V6i7EgwYD6rjBRRvZ7DspVdPALwrcMC4nDsACAF3fg8tMzXiJCIFPS5qJtY+hX8NIGllqhA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED06BD66BDDFF842BB9EF9FC05ADCD00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4998
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(4326008)(6862004)(63350400001)(6506007)(46406003)(6486002)(97756001)(478600001)(26005)(22756006)(76130400001)(26826003)(6246003)(9686003)(70586007)(99286004)(81156014)(81166006)(336012)(25786009)(316002)(6512007)(70206006)(54906003)(86362001)(446003)(229853002)(7736002)(386003)(186003)(8676002)(126002)(356004)(66066001)(5660300002)(58126008)(47776003)(11346002)(23726003)(2906002)(6116002)(486006)(102836004)(476003)(76176011)(8746002)(1076003)(305945005)(50466002)(6636002)(3846002)(8936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4567;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c8e89a5-87a9-4ffa-db50-08d74595fce4
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXiislnXDeTFMKpF4hxVmlHz0NWyKdepI/EhJoU6qP/bnFQn+MPif6O81x8ODzzv+Xyy2ibBR8E/gUOrjDaW+9RX35qmvoC34hmaotUxX2XP3g1VDQrX9jaCWDAwR24+cjj7mvE6dn2FE8LQZBdyxHRDoZbqJL7ojXkzU4pkWsg+DV9zqlPstPqpVLBTWM1k5vFQA84QPdw9QvjmJoym5DG/cUBj6eGZTMnWEtIVCZNagvnP1xOEJJaVSQYc2iSqf40/e/04frg0vq6TrQNJK1ZK8sKt2NZoE/EySqyPbUHNK9lH7ts6dX/g6MliHfU4zkXmu86LA63PZ+zz31t6WCaWw4aiNp0RT6/NyL/zqK7jlBzgOXFMizpl1Zkr6KxLXBG0V69sKUvl04VpCbHRDBjb98PK+vEENmN5E6ZmN8U=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 11:04:54.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1340aea1-eea9-402f-c970-08d7459606c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Sep 30, 2019 at 04:54:41AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> This function is used to convert drm_color_ctm S31.32 sign-magnitude
> value to komeda required Q2.12 2's complement
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../arm/display/komeda/komeda_color_mgmt.c    | 27 +++++++++++++++++++
>  .../arm/display/komeda/komeda_color_mgmt.h    |  1 +
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index c180ce70c26c..c92c82eebddb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -117,3 +117,30 @@ void drm_lut_to_fgamma_coeffs(struct drm_property_bl=
ob *lut_blob, u32 *coeffs)
>  {
>  	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl))=
;
>  }
> +
> +/* Convert from S31.32 sign-magnitude to HW Q2.12 2's complement */
> +static s32 drm_ctm_s31_32_to_q2_12(u64 input)
> +{
> +	u64 mag =3D (input & ~BIT_ULL(63)) >> 20;
> +	bool negative =3D !!(input & BIT_ULL(63));
> +	u32 val;
> +
> +	/* the range of signed 2s complement is [-2^n, 2^n - 1] */
> +	val =3D clamp_val(mag, 0, negative ? BIT(14) : BIT(14) - 1);
> +
> +	return negative ? 0 - val : val;
> +}

This function looks generally useful. Should it be in DRM core
(assuming there isn't already one there)?

You can use a parameter to determine the number of bits desired in the
output.

Thanks,
-Brian

> +
> +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
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
> +		coeffs[i] =3D drm_ctm_s31_32_to_q2_12(ctm->matrix[i]);
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
> --=20
> 2.20.1
>=20
