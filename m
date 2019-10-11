Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ACBC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F105F21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="96LtwpPi";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="96LtwpPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfJKI1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:27:13 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:5061
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbfJKI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1psI3ctevFR286UcPZdwCGHJds5ApXM4olewMNnC2U=;
 b=96LtwpPi+Gqcungk5fNvuUX/FikE+3SrOcHQBGRM/x+fInTI0aKF4nQUOmfcX/XFbA9nVFhiwRBFODRKaGrA1Psy0xpAG3w6JNHFTxz4eY4ZcKE4t2KcCjMrk3I0135oF83jpN6cBTr4gO5W2sm0dcIxHt1VveaXRq3apCojx/s=
Received: from DB6PR0801CA0049.eurprd08.prod.outlook.com (2603:10a6:4:2b::17)
 by VI1PR08MB3630.eurprd08.prod.outlook.com (2603:10a6:803:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Fri, 11 Oct
 2019 08:27:03 +0000
Received: from VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by DB6PR0801CA0049.outlook.office365.com
 (2603:10a6:4:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 08:27:03 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT008.mail.protection.outlook.com (10.152.18.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 08:27:01 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 11 Oct 2019 08:27:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 61ba61c69a2aba9f
X-CR-MTA-TID: 64aa7808
Received: from 8511ca7d45cd.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6F552D04-6CAC-47FB-B185-6A1BEA2AAF6E.1;
        Fri, 11 Oct 2019 08:26:55 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8511ca7d45cd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 08:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyjDX9gRT7rHtvUwHRjKZxafpsj9+e6HvEbk7OAzwPwEn11HqDT89394rKiDvN8mcpZwQibcXC1cbe3f5sAaExmx1eiDhvyxEp9r7oHLT8GQWjhOEEwud6Jf134/YnMh9OBrYR10Eb7JA2H8POZ4x+j8vNBF7UNhXtjTUGxksJk5l8/or6Z7dDeiq9n7cU4fZG1alTpFBiwfZLOdGf09+jO3Xve52L6oA4qNBJcuP+hNuSayJRjz+AZtoQC8l2ZjM0KY0YXHMZxy/13+0dDtzIPUkKVFLGfCel850py0WJZL2o3emB3WWq8gBZ24x/2bWlwecgCFVKe97G/TK5LNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1psI3ctevFR286UcPZdwCGHJds5ApXM4olewMNnC2U=;
 b=CSYPZST73swEdd/1KTs77rNHGfKrn4S4ih9zts73fb8EZyYF86WoNQXAHAarOWe0B8atNSbevVX1G10USuzlKFyijEy9XMYXiLJX2e5kTOMPBIqyrEy8rqpBq6bw9LL0xCjCJDFPBuEgjzD0O7JFEYVXrE6B49ReBCFE6+0COpv65CRUYGX8rRe+NGVRgk1gGIE75QS/r8Uxqb/L9ZIGdeuU9vQ5RDEUGL0yiVGK5Gb6M+MWA9R7jIqBfE+3Z2yfSeLY/OshxUjWbP/V42qtCg0PaQFA9E5oQeVz36G4DSsNhe6OxBkQLM2AMGl86VKbucDWr6hb+VCtT08e3FO4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1psI3ctevFR286UcPZdwCGHJds5ApXM4olewMNnC2U=;
 b=96LtwpPi+Gqcungk5fNvuUX/FikE+3SrOcHQBGRM/x+fInTI0aKF4nQUOmfcX/XFbA9nVFhiwRBFODRKaGrA1Psy0xpAG3w6JNHFTxz4eY4ZcKE4t2KcCjMrk3I0135oF83jpN6cBTr4gO5W2sm0dcIxHt1VveaXRq3apCojx/s=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4093.eurprd08.prod.outlook.com (20.178.127.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 08:26:53 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:26:53 +0000
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
Subject: Re: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/cdAHid3tH8+UyzZeXX5YE1LKdVG1SA
Date:   Fri, 11 Oct 2019 08:26:53 +0000
Message-ID: <1622787.6FTe1jSl1W@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-2-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-2-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LNXP265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::29) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 111736a0-2d67-4b08-7ab5-08d74e24ca2a
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4093:|VI1PR08MB4093:|VI1PR08MB3630:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3630A41D0181463E999AA4B18F970@VI1PR08MB3630.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(64756008)(6636002)(256004)(186003)(66446008)(476003)(71200400001)(14444005)(316002)(8676002)(86362001)(486006)(5660300002)(71190400001)(3846002)(7736002)(2906002)(66556008)(66476007)(446003)(11346002)(54906003)(81166006)(81156014)(6116002)(66946007)(25786009)(6862004)(26005)(66066001)(102836004)(8936002)(6246003)(305945005)(6436002)(52116002)(478600001)(9686003)(6512007)(6506007)(386003)(229853002)(4326008)(76176011)(14454004)(6486002)(33716001)(99286004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4093;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nBG0TXM9rTUg9IsPImGxzNUlEbC+DmYCU7DtbwvVcQZcHRtl6uNgTyYLUUSpMbDBZBzIAMU5BlXQEv9FotuxVOEp9TNILAmABBcxowPCtWqy7GX9WrBT9LyXKi2aqyJo+MF3lElh7v1I0SFX/2FjH7hDnOTG3WcCDiRjqzJYK8rDDVitDlTdkhWnavgCVJH17ZRBU9WAofU0LWeARuUIDopLGnAYyVvL4KCfAII//hcO0i2LyqrweV5Pmpg35806m0gbL87JS2Nq3cqSp8d4GrIKZGvA3eNYhy1xo+b9Tqtjyge51bF/UTVnTe4Hal8J1ax1tTYuMU9tpDs5qo5Tx/H2bfJvVB8upFaqB2WNiqawq6B1gPrm1obsCxKMZVjKDvR2Vk89my7LQcCwmlKjE5Qs8/us6OEt0aR6o3rqYYw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E9A0D14D6ECF7498045A0969AF1E44E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4093
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(486006)(476003)(26005)(99286004)(6636002)(446003)(3846002)(14444005)(386003)(6506007)(305945005)(2906002)(63350400001)(126002)(11346002)(6116002)(23726003)(336012)(102836004)(33716001)(5660300002)(186003)(86362001)(8746002)(8936002)(76176011)(8676002)(81166006)(81156014)(229853002)(356004)(50466002)(70586007)(14454004)(36906005)(316002)(54906003)(76130400001)(70206006)(6246003)(6862004)(22756006)(478600001)(26826003)(7736002)(66066001)(4326008)(47776003)(46406003)(97756001)(9686003)(6512007)(6486002)(25786009)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3630;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4dbc0383-0883-4a07-3976-08d74e24c54f
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j/MYp0+gt0prpHsbljDhrJmeD5Xp+u3Rv7pPk8APgrms8u0zkqyMHwBRyNNBDeMLf40TGTB4jA9C9uxspkPKVA/638sFEJEGEtezaJoF6LF24/syoDJS3Pj37+yYhmPJ/VS+BArn7nZtCYorTvXTaapvetQxgeJZsfztP+olqMCHdWygf/TXSaQo+ac4s2Gnim8xRi2NFJrlZoagTkoEykfH7KSs9SvSmRMC2QmEQndb2W8IE97mxySq0Fo01ZOIZe98MM3644yAYWwzge5Ezph81XylOtzUSmPj8bqx8xGjDQXNsKTpmHjD/Bx+MWoAKf/VIN+nUKvYXvwqSH6iKumtlliWKuxTwPInTd9odDrPpVEE3WPL/QjeXxRNs3d1AuXIrfdpyoM5gQZoz8n/xjYtxpYyPgJQEgT8hkDJMA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 08:27:01.2714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111736a0-2d67-4b08-7ab5-08d74e24ca2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Friday, 11 October 2019 06:45:27 BST james qian wang (Arm Technology Chi=
na) wrote:
> Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> hardware.
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
>  include/drm/drm_color_mgmt.h     |  2 ++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color=
_mgmt.c
> index 4ce5c6d8de99..3d533d0b45af 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input, =
uint32_t bit_precision)
>  }
>  EXPORT_SYMBOL(drm_color_lut_extract);
>=20
> +/**
> + * drm_color_ctm_s31_32_to_qm_n
> + *
> + * @user_input: input value
> + * @m: number of integer bits
> + * @n: number of fractinal bits
> + *
> + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> + */
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n)
> +{
> +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
This doesn't account for n > 32, which is perfectly possible (e.g. Q1.63).
> +	bool negative =3D !!(user_input & BIT_ULL(63));
> +	s64 val;
> +
> +	/* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> +	val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
This also doesn't account for n + m =3D=3D 64.
> +
> +	return negative ? 0ll - val : val;
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
>=20
>  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precisi=
on);
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n);
>=20
>  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
>  				uint degamma_lut_size,
> --
> 2.20.1
>=20


--=20
Mihail



