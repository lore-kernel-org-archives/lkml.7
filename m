Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94503C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3892064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mYjzhxzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfJONkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:40:55 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:65166
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbfJONky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXtBFJPSjupmcZ9042/7x1oV4FuCctHg9tuCJChS6+jz4VJgSyyY60delEx6dVM1izaVBObAeVjQYI0+kOthC8YlLTJclrPe5K/3JIba6osXPKzxKinTLVpKfmxGACqP1GidLqiaZG/705bkfowVJzpMmJ3T/E/7ciq9LHeIkqiStllLPyO8QJSvISPMkdg8tTueUZXCzRqAr77dXeOHv6si0A7Fr8MLBa5hFzDfT2VYHpdRDngN2iZWWE/Y09G6aoXRHL1/mpSVqj4K+D/Ks8zDyMIioSVPtYd4RBY/NuMVhUBz7Yksl1qGTWdVfIqPHgEipzgtn1biDgD4FzyLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrxrustGCN75leJlc9bS6aBW7tddQEq8xRC+9wW2m/w=;
 b=jYDxuLHePk/84aBtSz69+uuuWP6WqgHymX4PiPE4/QUMFdIGLBigV2wAd4NVNPJT/34IJRj3UiMABV8rsdOcB8RubeAZpNPgbvL5TdWDhI5pAz4WiKaRk7zsjT7BMTHyEB22SwnkgdShgxZPopTcoMwAWrOXWjrLBdxZCENAGf37WxFthNbYcR39suaaJAIqQodEAkYXbxbkVyuQY7e/7b9B/HAOdJFnWux7Qkoye0ClYeILUMb9zhSZWXjQ2JIt2i/PJkswLX0v74LHxfiQvwoFuG6tRiJKq55DK5Ug/7owhCxIkV1mG2DFvIuixQWUlGwbGQHY0inrp4UeFGqYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrxrustGCN75leJlc9bS6aBW7tddQEq8xRC+9wW2m/w=;
 b=mYjzhxzzOz/c/RZ4M+ydleFqNbAL7jr6oaWhF8vT5Gw1gFcud8ZQLBklczzqcID5OLpvEWBZp8Mdbo7OwS/liZ8ORhd2T1BA1qjNf/Pukrow7K3GqADf2gg1ddzGQvyJb+x6FLLcadqF/w4lw+0+ud65i2XMG5a9SOr8eL/SrbA=
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (20.178.198.25) by
 DM6PR12MB2908.namprd12.prod.outlook.com (20.179.71.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 13:40:12 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::88a6:9681:d4cd:51d2]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::88a6:9681:d4cd:51d2%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 13:40:12 +0000
From:   "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
To:     "Berthe, Abdoulaye" <Abdoulaye.Berthe@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: Add LT-tunable PHY repeater mode operations
Thread-Topic: [PATCH] drm: Add LT-tunable PHY repeater mode operations
Thread-Index: AQHVg14R21/cmlYs3kCpQ3lK2eqOFA==
Date:   Tue, 15 Oct 2019 13:40:12 +0000
Message-ID: <20191015134010.26zwopwnrbsmz5az@outlook.office365.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba34b68-5078-4597-bb72-08d7517533fa
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB2908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29087F0AB0D3AC56C961494998930@DM6PR12MB2908.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(316002)(66066001)(54906003)(7736002)(25786009)(14454004)(110136005)(305945005)(99936001)(71190400001)(71200400001)(8936002)(81156014)(478600001)(81166006)(8676002)(99286004)(256004)(102836004)(386003)(6506007)(52116002)(5660300002)(6436002)(66946007)(1076003)(3846002)(6116002)(64756008)(486006)(86362001)(2906002)(26005)(476003)(186003)(66616009)(66476007)(66556008)(66446008)(6512007)(9686003)(4326008)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2908;H:DM6PR12MB3370.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfZKcpjvUVN3TGzauCYv2neoAZreYK+vgTMMFMRR9ZWJREuX5s3wCjWPphhhQcOyRKizZQIKEZkCLN0iDh3No9FUhhBoyvVOoqn5kZt9gKWri1pOZ90mBRmVaDHHYzPr411RYfox4qAAnREXiN4LEOzsm2ParPI3+RUDbJYIW/bIYhIg5FBW5i9qSzJEWPtms7xcnHRNlmCT4+HSaGUL2uq33yx0nJ0aGaMEvpphB01IADus1c/JzBiKRnsMpcJGY8IJQ2vCRhJ3uoixRQwI+lc8rPMchxIPtpEbYQzAal2cV6L/jsHFA6YZB++VJnuzN4143HsLR9Lg+lZw5r7pCEQ44XL1a3W3WQqnqKsKJcoEH3MvzXfZptxaQZLgR4GBCwsnrCGto3YSlv9Q4yALkaQmxj3moZl2DnCiASQPaGU=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pojpfz544iiylxbh"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba34b68-5078-4597-bb72-08d7517533fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:40:12.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSXcEPz27nwz4yQGF6N/TUwhSZlHxamX4kGqxNb7g5IJ18GgXnLqFigy3Kn/ZtDRiKYgqZznQRUCM8NBkSIL+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pojpfz544iiylxbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

LT-tunable PHY Repeaters can operate in two different modes: transparent
(default) and non-transparent. The value 0x55 specifies the transparent
mode, and 0xaa represents the non-transparent; this commit adds these
two values as definitions.

Cc: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 include/drm/drm_dp_helper.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index bf62b43aaf2b..cfadeeef8492 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1034,6 +1034,10 @@
 #define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1	    0xf003b /* 1.3 */
 #define DP_FEC_STATUS_PHY_REPEATER1			    0xf0290 /* 1.4 */
=20
+/* Repeater modes */
+#define DP_PHY_REPEATER_MODE_TRANSPARENT		    0x55    /* 1.3 */
+#define DP_PHY_REPEATER_MODE_NON_TRANSPARENT		    0xaa    /* 1.3 */
+
 /* DP HDCP message start offsets in DPCD address space */
 #define DP_HDCP_2_2_AKE_INIT_OFFSET		DP_HDCP_2_2_REG_RTX_OFFSET
 #define DP_HDCP_2_2_AKE_SEND_CERT_OFFSET	DP_HDCP_2_2_REG_CERT_RX_OFFSET
--=20
2.23.0

--pojpfz544iiylxbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl2lzDoACgkQWJzP/com
vP+mVBAAxMB8LNzRHORcTyVgD+sjTzswbmJzxhyacbK1S72ePMOHLwrzIC12YF8m
V8gvFgWC+aHNM5G0ffS5fUTOn7YfYNohG52cRnhAhGHctkBP105m273zDekijMCa
j+qkGkJOoDhWWB7f9H5Kv+PxpCOl30u1Wo7yTKccsqDPj6Ic7kIV7MRl3zV2CsEs
RY9qtN/6LqXOGCO9qDcfhPpFlrAvtGM+ukpDqqJpQn2zch9DkkKVyOm9luKpGW9e
tu1sqye8gZA2fotrHWLLtm4IrlZbCBIeHKQMk7nzcB000ykqWNN8oHRkX/hDsKoz
GQoQFXgANTKCHHDFWhQoK1f/0zH1lgmm2lzo+bZOCs5NmKxScfCPtC3GPXiTsWbn
1l/peRgPu4dLzZi/b89t4DC4dedJ7suu8tTPwHR3njyFC1H5lmz04QPt8AEpztTm
nQhqBaXTNTfCzcQGUkWJlTFrQRkvNqTPOa6VoIHU8jvkpLb6oJa1yFsniuwhr+we
DXXDVemGo9NtWsCsFYOYwwy745NxIz1UOL0BmS+WHtwEo4qSjFdTo10Hr0eZKhVf
4NLesv7GFvlFubRQDDGuzCPyv3HEYM+41cnG8qbx3Tsif0TL8vZr3zWYF96cgUoE
o86WYz2ggxnA0elL4XSwjzw5wdQHQpxy9Fcokgjf+BdIZKtrOV8=
=FFde
-----END PGP SIGNATURE-----

--pojpfz544iiylxbh--
