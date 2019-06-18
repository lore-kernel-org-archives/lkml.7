Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B8C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DBD2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cEembCbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfFRCFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:05:38 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:40038
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRCFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg2kvnqT0VjSojJg+YRo1O9WIFi6KUcTt8LWGNg7nDc=;
 b=cEembCbJiNme+wGioPsdTCVzDyFC1DyA2U+lV6geOLavLrsMt7dEX6fHyawkJB+VO0TlnuAeNX/Du/+laneueMba/RdqEG5fGGvwNxEQ3SIxFvmQP33OkMETu8sT9jNraYfeeM5D892hrTO68uTKca8HQ0ga0NHKjqvMrBI01DA=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4688.eurprd08.prod.outlook.com (10.255.115.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 02:05:35 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 02:05:35 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
Thread-Topic: [PATCH] drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
Thread-Index: AQHVJXpNE3N21cdpKkuGT3soJLEwQQ==
Date:   Tue, 18 Jun 2019 02:05:35 +0000
Message-ID: <20190618020529.GB32081@james-ThinkStation-P300>
References: <20190617125121.1414507-1-arnd@arndb.de>
In-Reply-To: <20190617125121.1414507-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bd65035-c28a-4f80-d7c9-08d6f3917371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4688;
x-ms-traffictypediagnostic: VE1PR08MB4688:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4688F748B2409842670F1D6BB3EA0@VE1PR08MB4688.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(76176011)(25786009)(33716001)(478600001)(6246003)(99286004)(52116002)(256004)(58126008)(476003)(316002)(54906003)(229853002)(6486002)(11346002)(486006)(33656002)(1076003)(6436002)(14444005)(446003)(4326008)(6506007)(26005)(5660300002)(66066001)(6512007)(9686003)(66476007)(66446008)(66556008)(64756008)(81166006)(53936002)(71200400001)(71190400001)(8936002)(81156014)(3846002)(6116002)(386003)(86362001)(55236004)(186003)(8676002)(102836004)(66946007)(68736007)(14454004)(6916009)(2906002)(305945005)(73956011)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4688;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y04z68eaMDTgREEPP+neA+e8LM/Xh9ECuJHSo3zcKDewmgaV7iHGG71Jue5c1iwzMyIGI8q8POjzUXWlaxc1J4FlVyEtQ9WR3t4jaFvaxd3KJCdVBzJ/wQtoR6fzgk3gII0+L/5RYOnyix5pA5oP/9+wVFRaNJQHW8VxB2YwmuSmGcQ0hTivRv60oiRuTsLRspa/z94UP0ZtjUw+e3PCyhOahZdqw+8jt5djppLXe12qWLGqhjLBr6/7znabufSA20GxyZ5RTKCumImTfxLxMzk2D8CzsiWXjW307Sm6Zr5NDcC1iE8+MOqLkr5mODRFlH4bvdkaE145die8rpIjeCVFPYWyfyRykQcUOKeTIOlc9vDP31oO4LMJ6QtwYk0ctJV/8Mf6eQWUuC9U5qix8ThC5/xxPHemBgSQXV3C7AM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E41A22522EF64C458E76260D8DFE5E21@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd65035-c28a-4f80-d7c9-08d6f3917371
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 02:05:35.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:51:04PM +0200, Arnd Bergmann wrote:
> clang points out a bug in the clock calculation on 32-bit, that leads
> to the clock_ratio always being zero:
>=20
> drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:31:36: error: shift coun=
t >=3D width of type [-Werror,-Wshift-count-overflow]
>         aclk =3D komeda_calc_aclk(kcrtc_st) << 32;
>=20
> Move the shift into the division to make it apply on a 64-bit
> variable. Also use the more expensive div64_u64() instead of div_u64()
> to account for pxlclk being a 64-bit integer.
>=20
> Fixes: a962091227ed ("drm/komeda: Add engine clock requirement check for =
the downscaling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index cafb4457e187..3f222f464eb2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -28,10 +28,9 @@ static void komeda_crtc_update_clock_ratio(struct kome=
da_crtc_state *kcrtc_st)
>  	}
> =20
>  	pxlclk =3D kcrtc_st->base.adjusted_mode.clock * 1000;
> -	aclk =3D komeda_calc_aclk(kcrtc_st) << 32;
> +	aclk =3D komeda_calc_aclk(kcrtc_st);
> =20
> -	do_div(aclk, pxlclk);
> -	kcrtc_st->clock_ratio =3D aclk;
> +	kcrtc_st->clock_ratio =3D div64_u64(aclk << 32, pxlclk);
>  }
> =20
>  /**
> --=20
> 2.20.0

Hi Arnd:

Thank you for the patch.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
