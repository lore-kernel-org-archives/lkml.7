Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C3EC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1B120815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yLXM6RHZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yLXM6RHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfI3RDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 13:03:04 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:31206
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfI3RDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 13:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuC+jheJXuPf98xSZNlLTvWJAZi0JUylXdiHG+CA73g=;
 b=yLXM6RHZDsk6TybagcVuKarwtQeYXhoaKNnjGSot6kdyHDXa0aWosdqi1idbtrUAvS0u9UgApPS8ZrUk/xrtHmJv++gdDHuP8A+Cy5+er9dz0MZyj4I1evH+QuN4q5elZfIvRJ45TY+Unp/MOCIzxU7DWu4YUbW3p5PYWzjvMBo=
Received: from DB7PR08CA0060.eurprd08.prod.outlook.com (2603:10a6:10:26::37)
 by AM6PR08MB5271.eurprd08.prod.outlook.com (2603:10a6:20b:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 30 Sep
 2019 17:02:55 +0000
Received: from AM5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by DB7PR08CA0060.outlook.office365.com
 (2603:10a6:10:26::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 17:02:55 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT007.mail.protection.outlook.com (10.152.16.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 17:02:53 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 30 Sep 2019 17:02:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 47d190c31b1c9e2e
X-CR-MTA-TID: 64aa7808
Received: from d457f0916bad.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C8FB5D35-737C-4D27-968E-30AB784AEBC5.1;
        Mon, 30 Sep 2019 17:02:40 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d457f0916bad.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 17:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLyxwi61c2i8SjsYk+OvtYMmZllvsjxQA+Cg9baNeF0FvbZFt+nLQ9wKLoILKdWDF0kN3BUftuGaIurk8oK2m+v2R7PsWzPZ4FxbjSq2RN5cUErqLA3e6GzF1rX6VmmFCny+ZNrIr+bdB5xCIfD0yb5rC3uAf5f+3aov2gr8OY3DDB0yqWiZQVxk51h5gU9t9H6XngJthDvfU33kzvU2LZ4Eo2JZkNtm2YBIoVwOPALASDTRZHSddrq5qWZWlnVvEYEiGFyDkxcUWcXftXNmNiW9SaJek8Bt1JrXxr1QI5ByZGp9wbavWezOM5kI6E1BMUGf4CgkAEWoCtFLkTra0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuC+jheJXuPf98xSZNlLTvWJAZi0JUylXdiHG+CA73g=;
 b=DOowrs20geOIiEd5PjGGIbAW2oOzemJP6k1NpA0KTSSSgzuCGerCli9HW9sf7HFkL/PAdITKcfsmO1yy7BUARhF0uO+SGm8QrXELzfW/8qR9n5g0pGtGDxkMv7BKhx/DWvrSbS5ySMpyTKUOSMlfYP4u8yZT3pAm7TL4+pafTCBAfR/ADwOsLt9cJsUomwOHUOf2MzqspPx59t9wx/v1wLbRvgoP9jVpSSycNYGp69sprpK5me/r3L8nMrzp+as8E3OO5/gOBLz0ZrSB8Ql8ch5xr+x6kEzcmS5dtLeTXrY23L1FCAlF94ktJPY8Aq7z0b+Z6ZgMiWZSrvjGkO26ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuC+jheJXuPf98xSZNlLTvWJAZi0JUylXdiHG+CA73g=;
 b=yLXM6RHZDsk6TybagcVuKarwtQeYXhoaKNnjGSot6kdyHDXa0aWosdqi1idbtrUAvS0u9UgApPS8ZrUk/xrtHmJv++gdDHuP8A+Cy5+er9dz0MZyj4I1evH+QuN4q5elZfIvRJ45TY+Unp/MOCIzxU7DWu4YUbW3p5PYWzjvMBo=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3912.eurprd08.prod.outlook.com (20.178.89.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 17:02:37 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.028; Mon, 30 Sep 2019
 17:02:37 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>, nd <nd@arm.com>,
        Raymond Smith <Raymond.Smith@arm.com>
Subject: Re: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVd65ZjChaP0zoZUGEUL74H9varqdEcloA
Date:   Mon, 30 Sep 2019 17:02:37 +0000
Message-ID: <20190930170236.fvlim4c4ziqbxkw7@DESKTOP-E1NTVVP.localdomain>
References: <20190930164425.20282-1-ayan.halder@arm.com>
In-Reply-To: <20190930164425.20282-1-ayan.halder@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::14) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: bed23424-500e-4179-030c-08d745c808c0
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3912:|AM6PR08MB3912:|AM6PR08MB5271:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5271F3B85EC58B8D6A7D7B65F0820@AM6PR08MB5271.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(51914003)(229853002)(71190400001)(99286004)(9686003)(6512007)(6486002)(6636002)(86362001)(14444005)(8936002)(256004)(71200400001)(81166006)(81156014)(8676002)(386003)(26005)(186003)(446003)(11346002)(6246003)(66946007)(76176011)(1076003)(305945005)(7736002)(6116002)(4326008)(102836004)(6506007)(66476007)(3846002)(52116002)(5660300002)(66066001)(2906002)(66446008)(316002)(478600001)(54906003)(64756008)(58126008)(66556008)(6862004)(25786009)(14454004)(486006)(476003)(44832011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3912;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HoZiDNYM+Cf6mqUnWvEpWWVj6Yh5aAxAApfdV4X0U/haecE2nYgZhytL1PPVmI9Cp5oeaQf5cJsGkEGYPA/coMscakogsyMW6O7J+4DwyzWt23E9e7c7TusTqjQnEmDdNw4MLeONLdo8owDBO2SBIVTEyrv1K4Ks2ZIMS6/KhKcT+x5fFN5R8WiJe0Mh3jAAa6IhZuZivojspSNO5aYvXoD0aw7UI/JW4ZVvQfQhJsOBTpSOhAFZHt13YIaych2XAJ32j6CKRfbwfqqpNU9Pq+aMpfXR68NNJp7uYEOH2yydRVoKJo0aKJmzf2AYV9hb1D0L/MSWKd7pB/VodJaXfB58uWH9DZos99yE9Ow0Ucsw6ORYHSjenAx5YKV9DADBl5+W038glubTnPeXaBjKVevA43gyUe3wLv49wU6jSPY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51909B6198E47B46873F78EBF6073327@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3912
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(51914003)(486006)(1076003)(66066001)(81166006)(356004)(76176011)(102836004)(47776003)(6862004)(8676002)(6246003)(229853002)(97756001)(6486002)(2906002)(22756006)(11346002)(99286004)(81156014)(476003)(446003)(186003)(7736002)(305945005)(8936002)(8746002)(126002)(336012)(63350400001)(36906005)(6636002)(86362001)(54906003)(4326008)(5660300002)(25786009)(76130400001)(46406003)(70206006)(316002)(6116002)(70586007)(50466002)(58126008)(3846002)(14454004)(9686003)(6512007)(386003)(6506007)(26826003)(26005)(23726003)(478600001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB5271;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: da93f0e3-8a5a-4d8f-55f9-08d745c7ff16
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlpESdPViHxWNO0yf2wMdZXZVmvBHWPF2gZRBV+nnQQrTSk3dgP+1C0cjM3nO5quOvvi4OWz8kVEf3zucAEUiZQ098/d9lYABshWKmD1EcyPP8XfL5iRLTefZZ6VNGfStRlAItIWZsV4+tHzCH4WH18OW/NMh2MSgpRSjA7ztyiW/XdAwtLm1o/OnJ0bDus2YopQHyXGBNj/ifCNB62CR8YKqSJ5H4gXNDq3g3MOOHsqEmCOna8M32cGa5oVFT237HR5TYM5f8oH4IAjizUeFYGzqb2p52HLEkuS+GGP8Ew1F9l7/i6xZqfF6chc3OVmsPsxvsgTCL8AdDMB2+rw9KNi7TVuIvP+Ctg1hUgArP97OxYNT+lPcZPJFouR9NT74vshRz1O1wpDQuC9o4XH6JQaKhn+SKLzVmiu/R5fTA0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 17:02:53.8231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed23424-500e-4179-030c-08d745c808c0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan,

Could we preserve Ray's authorship on this patch?

On Mon, Sep 30, 2019 at 04:44:38PM +0000, Ayan Halder wrote:
> Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> denote the 16x16 block u-interleaved format used in Arm Utgard and
> Midgard GPUs.
>=20
> Changes from v1:-
> 1. Reserved the upper four bits (out of the 56 bits assigned to each vend=
or)
> to denote the category of Arm specific modifiers. Currently, we have two
> categories ie AFBC and MISC.
>=20
> Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 3feeaa3f987a..b1d3de961109 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -648,7 +648,21 @@ extern "C" {
>   * Further information on the use of AFBC modifiers can be found in
>   * Documentation/gpu/afbc.rst
>   */
> -#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc=
_mode)
> +
> +/*
> + * The top 4 bits (out of the 56 bits alloted for specifying vendor spec=
ific
> + * modifiers) denote the category for modifiers. Currently we have only =
two
> + * categories of modifiers ie AFBC and MISC. We can have a maximum of si=
xteen
> + * different categories.
> + */

Yeah, this makes more sense than getting crazy with saving bits. Sorry
Qiang/Daniel for not just going with this in the first instance when
you both suggested it.

> +#define DRM_FORMAT_MOD_ARM_CODE(type, val) \
> +	fourcc_mod_code(ARM, ((__u64)type << 52) | ((val) & 0x000fffffffffffffU=
LL))

Not a big deal, but I might prefix type and val with "__" to reduce
the chance of name collisions with code using the macro:
DRM_FORMAT_MOD_ARM_CODE(__type, __val).

> +
> +#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
> +#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
> +
> +#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
> +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
> =20
>  /*
>   * AFBC superblock size
> @@ -742,6 +756,17 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> =20
> +/*
> + * Arm 16x16 Block U-Interleaved modifier
> + *
> + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the imag=
e
> + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pix=
els
> + * in the block are reordered.
> + */
> +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> +	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
> +
> +

I think you can drop this newline, there's no extra space between any
of the other definitions.

With this line dropped, and if you fix up the author:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Thanks for the respin,
-Brian

>  /*
>   * Allwinner tiled modifier
>   *
> --=20
> 2.23.0
>=20
