Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F01FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABAA20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8BGuotcf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8BGuotcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfJPLCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:02:34 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:32974
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfJPLCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bteAoqvg6Ja7R9NYtOBEL85RrNKJif/A9bVzjsytrpE=;
 b=8BGuotcfc+c3ZCGaT+WhNUt+Xv95jrjmR3MyWsx9JfJjCOxVLclOmqLcyq6vRe6SDzMwezgjXSquK8RdIGeE0DE4le4fOQEv63PTh3lVNYOP/JlfizEhSxD0lzvooyh3q5sfq0X9tB6RzGw+PkpRY7QHy+vA+LqsfNax/E31/5Q=
Received: from VI1PR0802CA0027.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::13) by AM6PR08MB3797.eurprd08.prod.outlook.com
 (2603:10a6:20b:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Wed, 16 Oct
 2019 11:02:22 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by VI1PR0802CA0027.outlook.office365.com
 (2603:10a6:800:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.19 via Frontend
 Transport; Wed, 16 Oct 2019 11:02:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 11:02:19 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 16 Oct 2019 11:02:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 703af21a9037f482
X-CR-MTA-TID: 64aa7808
Received: from 20899ea1f40f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EFA097B1-0D9D-47F5-96C8-34D5D7E3FCCA.1;
        Wed, 16 Oct 2019 11:02:06 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 20899ea1f40f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 11:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joEVvcGYxv48zdFxficsYqLo4rt3cMBWpFEe4SMpBkrv1gomMou5lzOhpzPH3GUVYcNEZFuhVmWcHscp5RzJmm7cg4MSat7qlP4poFqMf3qlsyvY883iqqsn+f5INHHnyNeC5v66U2ZzpJiXmb9a9o7P6eLRfa9zA8bOctOk/upyf6eNqLHVPWPKU6U9WCGKkN35gErCUcuQDKdEAdJeuRe2fZuugkSX3lA2hROin5xLj5w/66unpSSGFY9SBSsf0RNFsxtFvVgyImLWaTVDfDTzmkKJFysb7MmI0NhXRDBs2/xDWurVepQfAybniCRoAJdZTAvSilBWDVES/zTu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bteAoqvg6Ja7R9NYtOBEL85RrNKJif/A9bVzjsytrpE=;
 b=cF0R6fXkhT7vmRszwraXL9FWYn9hFwozl0qeLdpB1DNiE7LjFF+QVkp/3aF0j8MZXoWUzi6Iex5LYVwoVTJTdk39okqBasmEXAx5l5Y86C4bHiZYI4nGGKAHje1xh6SSpugdqt9q+2hNgj/5mJxbp654gukbzHSL5Sopw5HFFxFfw9UZJaUGpar4UTPq1sXlBBzVa3KFrp7YjqbvI/srSz+kiqAKtvhpZNkq89WBteHzwAWUzcCd9lZs8yftCvaoJuzDDUky03BaFFp2l45snDfF9L4c++6uvV4y15fhMLor8Vh9JJiGF6TKjT3+ah/LY+kJdkgkO2nH/aDX2LuROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bteAoqvg6Ja7R9NYtOBEL85RrNKJif/A9bVzjsytrpE=;
 b=8BGuotcfc+c3ZCGaT+WhNUt+Xv95jrjmR3MyWsx9JfJjCOxVLclOmqLcyq6vRe6SDzMwezgjXSquK8RdIGeE0DE4le4fOQEv63PTh3lVNYOP/JlfizEhSxD0lzvooyh3q5sfq0X9tB6RzGw+PkpRY7QHy+vA+LqsfNax/E31/5Q=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3135.eurprd08.prod.outlook.com (52.133.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 16 Oct 2019 11:02:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 11:02:03 +0000
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v5 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVhA1Dae0PEifxdEmUeEe4shI0vKddGiuA
Date:   Wed, 16 Oct 2019 11:02:03 +0000
Message-ID: <2404938.QDdPyV61sH@e123338-lin>
References: <20191016103339.25858-1-james.qian.wang@arm.com>
 <20191016103339.25858-2-james.qian.wang@arm.com>
In-Reply-To: <20191016103339.25858-2-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: AM0PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6d1074-7e00-41c0-693e-08d752285075
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3135:|VI1PR08MB3135:|AM6PR08MB3797:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37975D97F571F1D768E8AAED8F920@AM6PR08MB3797.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(64756008)(386003)(9686003)(102836004)(76176011)(6506007)(6862004)(25786009)(71190400001)(6246003)(6636002)(478600001)(7736002)(305945005)(66066001)(14454004)(71200400001)(229853002)(6486002)(26005)(99286004)(4326008)(6512007)(186003)(6436002)(52116002)(66946007)(66446008)(66476007)(66556008)(11346002)(81156014)(476003)(86362001)(486006)(316002)(54906003)(8936002)(81166006)(446003)(5660300002)(33716001)(8676002)(6116002)(3846002)(2906002)(256004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3135;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XwnRvE4YMgo0g9LJ9EffP+InukiUBP6DMJGL84gN1ICBO2t3EKnP1y1EPun2EMP5SlvkXxIt1o9yM3IYcnpdc2vLtsOCm9DOTMTzyRdrbu3YZEqMHUn206n0zD5TKiyVmILrsjUdVAsEkJ9n7dV4yhGt6aMVL1ruDCbO4w36k/iprdjGcCy9puTvpC6I5w9wwaUt1Pp4vPNkjE2gJ+ezYs8v+zKsaZs1M7KgUJ0R+sbXmiFxnWbhwl7LTLp2HV8AfpvhE9gRaGxENseqEEAqAhZKy8Y4YmpczuE9xQhJLQlm8op51jJYBk8usd7xsISmJ3LvsbrkvgyumWgltk+RVFHCA4tHJvqOL5W7K96ZK4IMkzz8qtkcKJ0UF0UczZ9nXoE8nTwRR65SN1c+SsFXIAffFX9SwVR5RjO4QV8C76A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92977D79E52F4F47A3B721E0CA643AF6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3135
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(336012)(229853002)(11346002)(63350400001)(6512007)(446003)(9686003)(8746002)(6636002)(33716001)(46406003)(5660300002)(26826003)(23726003)(3846002)(6116002)(14454004)(50466002)(8936002)(6862004)(478600001)(22756006)(6486002)(186003)(70586007)(97756001)(70206006)(2906002)(4326008)(54906003)(476003)(26005)(76176011)(81156014)(81166006)(8676002)(126002)(47776003)(86362001)(25786009)(66066001)(107886003)(6246003)(356004)(76130400001)(7736002)(486006)(305945005)(316002)(102836004)(386003)(6506007)(99286004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3797;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 483f1ccb-28fa-4879-6dd8-08d75228465f
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHBkfbdp9iY/CmKIRdLxBeG5Zp2Om9vy+gtMGoOWaGWml1ZozTuwSsRmDDQ/vibYd4O8riI2G0JgNIKbpXBQnf0J3HGvlgMRzSCkGfbFnGpxd5s4QAnBQF6Gi84r10B8+/qfqr4aXX38bUlsPpak84QjZAyeNnEHmo5htYUQyB19SB+Meay52C41WVXtUiJTS8rG6xcud2nE+RBWsVCf5TqmXkannzJQimyaN+x/GQMKEk5GPGArylCdYX8hMKMctrxz+p24VcjE2zhSlWhzsNfOUfwfFrt/1iEfsQ1EtAPz3tjFKmBWbYgl/kVGSofGrgylE4dKWKIHfO3TI0FqLAUo6cBP6Fm00ByFHXoY9n7iegOXoZxP1nTmhkbxSCK5TsVdfgPTrG5oUrj3m862PrgldvDRYT53hkaKR/2Xb7E=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 11:02:19.7715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6d1074-7e00-41c0-693e-08d752285075
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 16 October 2019 11:34:08 BST james qian wang (Arm Technology =
China) wrote:
> Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> hardware.
>=20
> V4: Address Mihai, Daniel and Ilia's review comments.
> V5: Includes the sign bit in the value of m (Qm.n).
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 27 +++++++++++++++++++++++++++
>  include/drm/drm_color_mgmt.h     |  2 ++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color=
_mgmt.c
> index 4ce5c6d8de99..d313f194f1ec 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -132,6 +132,33 @@ uint32_t drm_color_lut_extract(uint32_t user_input, =
uint32_t bit_precision)
>  }
>  EXPORT_SYMBOL(drm_color_lut_extract);
> =20
> +/**
> + * drm_color_ctm_s31_32_to_qm_n
> + *
> + * @user_input: input value
> + * @m: number of integer bits, include the sign-bit, support range is [1=
, 32]

Any reason why numbers like Q0.32 are disallowed? In those cases, the
'sign' bit and the first fractional bit just happen to be the same bit.
The longer I look at it, the more I think mentioning a 'sign-bit' here
might confuse people more, since 2's complement doesn't have a
dedicated bit just for the sign. How about reducing it simply to:

 * @m: number of integer bits, m <=3D 32.

> + * @n: number of fractional bits, only support n <=3D 32
> + *
> + * Convert and clamp S31.32 sign-magnitude to Qm.n (signed 2's complemen=
t). The
> + * higher bits that above m + n are cleared or equal to sign-bit BIT(m+n=
).

[nit] BIT(m + n - 1) if we count from 0.

> + */
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n)
> +{
> +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> +	bool negative =3D !!(user_input & BIT_ULL(63));
> +	s64 val;
> +
> +	WARN_ON(m < 1 || m > 32 || n > 32);
> +
> +	/* the range of signed 2's complement is [-2^(m-1), 2^(m-1) - 2^-n] */
> +	val =3D clamp_val(mag, 0, negative ?
> +				BIT_ULL(n + m - 1) : BIT_ULL(n + m - 1) - 1);
> +
> +	return negative ? -val : val;
> +}
> +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> +
>  /**
>   * drm_crtc_enable_color_mgmt - enable color management properties
>   * @crtc: DRM CRTC
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index d1c662d92ab7..60fea5501886 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -30,6 +30,8 @@ struct drm_crtc;
>  struct drm_plane;
> =20
>  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precisi=
on);
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n);
> =20
>  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
>  				uint degamma_lut_size,
>=20


--=20
Mihail



