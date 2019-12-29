Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A951FC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B61620722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 09:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="MmdB6JBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfL2JrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 04:47:07 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:47841
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfL2JrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 04:47:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1Iw3LSd2NdgAKkvU/XdefiNjdvEQy28099I5u/BrO3DCvuGGtVn/HoGHvnxHaeN/J7a2vISwLisHH5Zxmt+7drbXdSYhs47VQs9K2AZue/7ccaVv0xIKPhebSF2lSzGwvMVOATlFhsgKv2d/XrfX4od1ZkQ7+y0BsvfRNmpSrzO88A/4phNRrwYWT9u47FYYj/6O+DPKfEdjQ2AYshN7tFtz8luFFEqx3hfpMjJzBddxhchmfvU76UWUZ3XvbBirRvL8ph4zt8iQnGmrocS/lMeBLrP/Vv/iFuJ36tU+aLDtOM17t868Cq87l+Vgmnq4GnRRyOT8UpYl2qs+usPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJwgfoZxnCL2HHCzvbT7xn0nHQcha/HikbS0efY+ZVU=;
 b=fSUm+pCU0fTAbOH1nhQvp+1/Z0va8tGDO0sh3Yt75OcHqvopHNjim/fWKbW/6TnHQl8zoj2aIzrM3M59BWB7EVmrKrqc1TIrVoQ/RwPUkL2VaIS85eal+w5JN462s/po7f1Wp2+SmW4telcAwXOmT9rnDisX5y+MsbUeP+FTATGE4l4eER8ppe37JASV3s/jFGCsU90NMlHVWJnIsEjipQbOAzfbjaJZ7Yub9Cf0i5ji4I8WsAXMDlJ9otpu3B6aHv6txBUchi0a/F+3/hGemONyqNDFmN48tu3fLBift4T2k4JLzx/oDBZq+KnOwuNF3w7JdE+wC+EsF6fdszCdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJwgfoZxnCL2HHCzvbT7xn0nHQcha/HikbS0efY+ZVU=;
 b=MmdB6JBE78mis6SNCVNlnkzIaH577TSc4ICN7Io1g0zffTMdeS/uPjDhnW+KtvpT5shLVbXhKje1rC8f+OUTXjWTkixshpBmdDe3fC3eaJEBbHIjKSKUXODvVoTWY2s9gonr5FWDsyspcWa0FJIZXUFJ9w+LPKlkM4VMm/2iWJ4=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4416.namprd11.prod.outlook.com (52.135.36.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Sun, 29 Dec 2019 09:47:02 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf%4]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019
 09:47:02 +0000
From:   =?iso-8859-1?Q?J=E9r=F4me_Pouiller?= <Jerome.Pouiller@silabs.com>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v2] Staging: wfx: Fix style issues with hif_rx.c
Thread-Topic: [PATCH v2] Staging: wfx: Fix style issues with hif_rx.c
Thread-Index: AQHVvRcqbYTdpmaFvEWONRccZN89safQ36YA
Date:   Sun, 29 Dec 2019 09:47:01 +0000
Message-ID: <3570432.mCMjMbKv1p@pc-42>
References: <20191228003818.mmcf4aasks5mqcnr@mandalore.localdomain>
In-Reply-To: <20191228003818.mmcf4aasks5mqcnr@mandalore.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [88.191.86.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f2c2696-bc9a-4a2b-ab9e-08d78c440e33
x-ms-traffictypediagnostic: MN2PR11MB4416:
x-microsoft-antispam-prvs: <MN2PR11MB4416484438A0C81C3997A13793240@MN2PR11MB4416.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0266491E90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(396003)(346002)(39840400004)(366004)(136003)(199004)(189003)(81166006)(81156014)(9686003)(8676002)(54906003)(66574012)(316002)(86362001)(8936002)(6486002)(6916009)(6512007)(4326008)(71200400001)(33716001)(91956017)(66946007)(64756008)(6506007)(186003)(2906002)(478600001)(76116006)(26005)(66446008)(66476007)(66556008)(5660300002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4416;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlOhemrmAq5l5XC+jDigsnIgdnKX1c4PKIr8ZsEiQKijZmG96BvaHJp1cx9i570cRC+Vor+pDQwA089TKrySicpUNTo31pRsPK2yyOXNNcTxZnTcIDKWev2fsq/WurgBGBV3WHG922NmXr0b/Jl8LK5yNLhTbU+lty1K/IyZlyCdFfdBkMqwsAwXcxVWNt3Ig71+qcwNOvT7s8NnxLCfp07nf++alhtcqC0B4A7Wn5mGJeo4zoLMZY5jzSantB2XNkBAZAxHfXbgTpTgipRqj03C89kuIdJEfvHiOshkxxj1ZhyPoj034g//YmQy6XCwG/qkanPHYh17b4zrkqpgZLWU1BL1uIqMHQB3E7w3fpDdnAE/MoYZx9VV+00HtIaWfcNwW1CaLj9ERuOf1VOT8wcdmNddsZLJPuSxAmWGBu6yQZA54j7MS4kqtY7vRY9uV5g0I7o6DSQCBZnDNjcKE0CKzqCVNyVvFq4xaKGHT6bl5SVTdC34Bb/2QHtgOkHW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <346F119007CB444EA7109F8C5332BF9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2c2696-bc9a-4a2b-ab9e-08d78c440e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2019 09:47:01.8327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGht1wAH6cbXiiK391hircgdlU62KUYbnPpkrj+vye1arsBiDajwzwi+LCzCuKXPtgAxf6ARhMGRhZrxsFJ4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 December 2019 01:38:24 CET Matthew Hanzelik wrote:
> Fixes the 80 character line limit warning on line 79 of hif_rx.c.
>=20
> Also fixes the missing blank line warning on line 305 of hif_rx.c after
> the declaration of size_t len.
>=20
> Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
> ---
> Changes in v2:
>  - Make the commit message less vague.
>=20
>  drivers/staging/wfx/hif_rx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
> index 820de216be0c..1da9a153dda0 100644
> --- a/drivers/staging/wfx/hif_rx.c
> +++ b/drivers/staging/wfx/hif_rx.c
> @@ -76,7 +76,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, s=
truct hif_msg *hif,
>                                 void *buf)
>  {
>         struct hif_cnf_multi_transmit *body =3D buf;
> -       struct hif_cnf_tx *buf_loc =3D (struct hif_cnf_tx *) &body->tx_co=
nf_payload;
> +       struct hif_cnf_tx *buf_loc =3D (struct hif_cnf_tx *)
> +                                     &body->tx_conf_payload;

Since cast operator is an unary operator, I would try to avoid line break
between cast and variable. I suggest to place the break after the '=3D'.



>         struct wfx_vif *wvif =3D wdev_to_wvif(wdev, hif->interface);
>         int count =3D body->num_tx_confs;
>         int i;
> @@ -302,6 +303,7 @@ static int hif_exception_indication(struct wfx_dev *w=
dev,
>                                     struct hif_msg *hif, void *buf)
>  {
>         size_t len =3D hif->len - 4; // drop header
> +
>         dev_err(wdev->dev, "firmware exception\n");
>         print_hex_dump_bytes("Dump: ", DUMP_PREFIX_NONE, buf, len);
>         wdev->chip_frozen =3D 1;
Ack.

--=20
J=E9r=F4me Pouiller

