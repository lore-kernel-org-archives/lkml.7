Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE9F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tD2eY0GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfJOOaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:30:55 -0400
Received: from mail-eopbgr730080.outbound.protection.outlook.com ([40.107.73.80]:32178
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732087AbfJOOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSKw6oXK3ijdPRrAq70ELNv8+n69PEPGqB9Caqt32vXm+lFh5c6L3yzujZmyYPDMURh0eiDusohiszQeVkQhIK7t/M3zxYx26SZblh9OZcZBkrEhJNZXFGELMOEF/TDE3qK+H+g3ErEfaEyzD7BdQHgia9VCAE1jGsywLRqpq7Cwig3eEhjpkSzE5YuQXqaipPvIusvi/GFN1x2xE0SYvL/Fzio8R8dCA9gEqCXQ9NQ0j0x8SmRkWq2OmXWisyaV7JesOA2JT2TKqCI3Xn3AblcYsxG61+U2cX2MpNIv44HDFuJtCV9EZs3+HLTgjGv1SQNrb4g9qKev7oFUyLX90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89i57TQ/F7coxjFGXMGcE4G5YrnrUbTbS2rNIenK2JY=;
 b=AIwMwXMMQ700Q0YePJ426f/09nAfsRyK6OO8NUjEDFB1ZgCIA4qzA0+jCiDgWpV8PguKRXZJe3qU8nk6V0/V5pCGILuFL096cOPCzQujx+Zoepzm+WqwgsD3bR1e7mI1f0E4/BxBbSISAXQuEaqQ3YUFkGaFk3byowStk/3KqNwo5NfSbM8FkjO6FVfdKGnr2pbGIfTQp99oWzwZcYaCN7IEJKvPCDFW7yF3kSfmrbSHCMl3c04EkfCBw3fh3H3BvYcPeN1IhbDIM/dN7pbzH840OpqukRN53ozcVOOvPOsy6gyjIOVW/MI4CYooRwoRHGEMVCKlXPvw10/h466PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89i57TQ/F7coxjFGXMGcE4G5YrnrUbTbS2rNIenK2JY=;
 b=tD2eY0GNvizEYEvlwBg9VPSs6Coti+lf51rZgwBC0hy53rYJ0jdQB9FxTQY2Py0eGWEnNPbBwcjgoSOENP3gZkWc11acw4BdD14mUquemVWuyG5Z4PaYgVhH4cH9MFHmur+nyM7n7fHJFXZbxcYwSblMplP5Sp3SYeA/cmNJUWg=
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2503.namprd12.prod.outlook.com (10.172.116.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 14:30:52 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::5471:f58b:733e:1a61]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::5471:f58b:733e:1a61%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 14:30:52 +0000
From:   Harry Wentland <hwentlan@amd.com>
To:     "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Berthe, Abdoulaye" <Abdoulaye.Berthe@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?Windows-1252?Q?Ville_Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: Add LT-tunable PHY repeater mode operations
Thread-Topic: [PATCH] drm: Add LT-tunable PHY repeater mode operations
Thread-Index: AQHVg14R21/cmlYs3kCpQ3lK2eqOFKdbw2eA
Date:   Tue, 15 Oct 2019 14:30:51 +0000
Message-ID: <d9014121-a7e6-3487-1977-b26346456e24@amd.com>
References: <20191015134010.26zwopwnrbsmz5az@outlook.office365.com>
In-Reply-To: <20191015134010.26zwopwnrbsmz5az@outlook.office365.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
x-clientproxiedby: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 731e30e2-de77-4e22-5c0e-08d7517c47a7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR1201MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2503404AAC0CB9DD3AB6BFCF8C930@CY4PR1201MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(446003)(102836004)(11346002)(31686004)(186003)(478600001)(99936001)(2616005)(26005)(66556008)(64756008)(66446008)(66946007)(66616009)(66476007)(486006)(4001150100001)(8936002)(476003)(7736002)(81156014)(81166006)(8676002)(305945005)(4326008)(6246003)(53546011)(229853002)(66066001)(14454004)(65956001)(65806001)(25786009)(31696002)(36756003)(54906003)(58126008)(76176011)(71190400001)(6486002)(110136005)(71200400001)(316002)(52116002)(5660300002)(2906002)(99286004)(6436002)(3846002)(6512007)(6116002)(256004)(386003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2503;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYWnluT8KDqqx3WHQI592pz795ORyTdn6H6wr2g2e+nn+HE/zVOJIWH16wHUsphJ+gbR9H0YimjlGc+XYifPr9sM/qkz6MbFSjo5KD6AZyxYvuTbovNnQ9Ijz1rc0wsuqo3Q/00N93ubtlmW2BgImP+pUH4h/nQq6dtOHmm8jA1UwEemg3Una8+bhyEcas1uvmG5wnGRul/L5T/ruaA6CIOLZ/22txknb6ssbN2xWil4enIQfH3XAxwuaQ8ATbuAjx4NlHRpsMRJl4mbkRk9vY/zCRdEoKVJ7M2qRChGmNKYyeg9IehpPKR5e0/uBZe45LYhinGdBHE4TwbXAxkfh90XDX3E9S0ZHzqWS4AIR6Yb7CBzyhMXdKgShPAg6TK9M56hr0y9Wi+h9BV/aoPXGy2+qhE+0yMAfK/9gsMLEvY=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R7wmIA881mf0yB25ise9MwmOfw2ze62te"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731e30e2-de77-4e22-5c0e-08d7517c47a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 14:30:51.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bNoMPrKVqX4HKC64RMuSSAsxcLsiy1SDrYHIC9I1RW97X52AVScZvmlqPXc/WZcE2nCPBhiviRu4BnvfhUIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--R7wmIA881mf0yB25ise9MwmOfw2ze62te
Content-Type: multipart/mixed; boundary="OWlV1rvKFVCFyGZ7GZG6HStT3ygUcpvKd"

--OWlV1rvKFVCFyGZ7GZG6HStT3ygUcpvKd
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-10-15 9:40 a.m., Siqueira, Rodrigo wrote:
> LT-tunable PHY Repeaters can operate in two different modes: transparen=
t
> (default) and non-transparent. The value 0x55 specifies the transparent=

> mode, and 0xaa represents the non-transparent; this commit adds these
> two values as definitions.
>=20
> Cc: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  include/drm/drm_dp_helper.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index bf62b43aaf2b..cfadeeef8492 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1034,6 +1034,10 @@
>  #define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1	    0xf003b /* 1.3 *=
/
>  #define DP_FEC_STATUS_PHY_REPEATER1			    0xf0290 /* 1.4 */
> =20
> +/* Repeater modes */
> +#define DP_PHY_REPEATER_MODE_TRANSPARENT		    0x55    /* 1.3 */
> +#define DP_PHY_REPEATER_MODE_NON_TRANSPARENT		    0xaa    /* 1.3 */
> +
>  /* DP HDCP message start offsets in DPCD address space */
>  #define DP_HDCP_2_2_AKE_INIT_OFFSET		DP_HDCP_2_2_REG_RTX_OFFSET
>  #define DP_HDCP_2_2_AKE_SEND_CERT_OFFSET	DP_HDCP_2_2_REG_CERT_RX_OFFSE=
T
>=20


--OWlV1rvKFVCFyGZ7GZG6HStT3ygUcpvKd--

--R7wmIA881mf0yB25ise9MwmOfw2ze62te
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkiEcMSFhcOGNLtE6LVgVyYwUtuMFAl2l2BgACgkQLVgVyYwU
tuMLawf/cgj4YCmMWROgvysOgwG8RUIrI6NqW7xXgg90CSihx/5XwGbZeZVv7zh6
rOZNHMqXoxYWUn0Z7+JwJn/K+LKvbMjjYNpWpm2K8AVzDIYX25gbWgdm8MpiHp83
YcR7GCr9odjedAVlJ1RNpyVhBZGlJB+RM3FUYMQKwmImDfQcZlv4LGzNHHvf/XiC
bTo1ObULrYj1iUDIt4q2VWUKsl6LAUmSkU/82TtDL3A7Pvj9vFlIE1eg1nj1YKkW
lOyeKkD9c+wbf0ncDdkE7A8EX7cDLnwk/4zxKGnRFleDkySuD2kjxfypt3hIzkn6
+AJUO4/t8zivXoxqa2p3bj8igLoajw==
=hpCi
-----END PGP SIGNATURE-----

--R7wmIA881mf0yB25ise9MwmOfw2ze62te--
