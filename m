Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7212C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA1621530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="2doe82wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfFUMpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:45:03 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:18286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfFUMpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ktalAvf5nEozTCvceC401Q2GBLMEpa2yHcUth6+dPM=;
 b=2doe82wU1UiRADhIYNt70+EHe4jKy1je3FB05eJUJFeGTMEILDkRgp3nvRagd/eOE5oTsJtymvzAKljPET3yo3xMSziHYucNl1gjXJ/BjLk705ucNXk+aJHUf9qvl5aNd/Cha48v38tKIcttQhhNdUabfStAeHZqV/I8BWcOdOA=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3757.eurprd08.prod.outlook.com (20.178.14.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 12:44:59 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::b07f:c7e4:d946:91d8]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::b07f:c7e4:d946:91d8%7]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:44:59 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Raymond Smith <Raymond.Smith@arm.com>
CC:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVKBsKBvRwqAaS30eXmbt21cTJQqamDg4A
Date:   Fri, 21 Jun 2019 12:44:59 +0000
Message-ID: <20190621124458.rxa5djcmzd6lwkmy@DESKTOP-E1NTVVP.localdomain>
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
In-Reply-To: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 663320df-d085-4513-ff96-08d6f6464578
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3757;
x-ms-traffictypediagnostic: VI1PR08MB3757:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3757CBC745C13AE292477A65F0E70@VI1PR08MB3757.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(305945005)(86362001)(6506007)(53936002)(26005)(81166006)(52116002)(6862004)(476003)(6636002)(72206003)(486006)(102836004)(256004)(64756008)(386003)(8676002)(58126008)(81156014)(186003)(478600001)(446003)(8936002)(66446008)(68736007)(71200400001)(76176011)(73956011)(25786009)(54906003)(71190400001)(5660300002)(14444005)(66946007)(66476007)(11346002)(6436002)(316002)(4326008)(7736002)(6116002)(3846002)(66066001)(6486002)(6246003)(66556008)(229853002)(6512007)(1076003)(99286004)(9686003)(44832011)(14454004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3757;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qunpvre3yVTzezVVxbsB7MiFy5bkCwUb8dks9bsV404VAQtDlmIhHSHbkfmtj2kxFu6Mo09knNLwSq1tHR4Mejaz6Jqjhh8NdfGyZXUc1tNHP++zsWpoe+GEMLQ4Vr8qbDt7VFI+MlpTZoSg1oVKUOu+BdIgnylv77QzrFbcb01zzRCrn+bLjpD3aY9SGVYd/fJiNUqsUsBsjL2g6VDQ7Cg9jg54z1c7oOlZZ8LJgAAaga5OHZUZGjg12L0RSLeQ9S58Uz54AfwM2ZHJisY15pTPbTmGh7Xx6tU1KFvwKmDxcXcWkOIOQLp3ZjWYlp4rqdcSHara4mzigxJMJPCcvz5ofrWvvPXSL4btvqXyRTK/gsbofFwh1jOe1L22txtrGlZrYA4D6sb/+sGlcLuLKr9pqx2f2Wk2u5P99lMD34k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32A47F10489B0D4EBAD32964611BBA40@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663320df-d085-4513-ff96-08d6f6464578
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:44:59.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:21:08AM +0100, Raymond Smith wrote:
> Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> denote the 16x16 block u-interleaved format used in Arm Utgard and
> Midgard GPUs.
>=20
> Signed-off-by: Raymond Smith <raymond.smith@arm.com>

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Thanks for chasing this down!

> ---
>  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 3feeaa3..8ed7ecf 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -743,6 +743,16 @@ extern "C" {
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> =20
>  /*
> + * Arm 16x16 Block U-Interleaved modifier
> + *
> + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the imag=
e
> + * into 16x16 pixel blocks. Blocks are stored linearly in order, but pix=
els
> + * in the block are reordered.
> + */
> +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> +	fourcc_mod_code(ARM, ((1ULL << 55) | 1))
> +
> +/*
>   * Allwinner tiled modifier
>   *
>   * This tiling mode is implemented by the VPU found on all Allwinner pla=
tforms,
> --=20
> 2.7.4
>=20
