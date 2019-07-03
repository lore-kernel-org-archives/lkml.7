Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327D5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC282184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wI5ZkT5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGCPF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:05:29 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:48027 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGCPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:05:29 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: o05FCN3Nb76Ada20UnhIjzdEOUWBya41B7HH5THPz27BSUeJXuivGhcHj1m8sPR7/Cz4TaBS/V
 aokBEPiCM0oEG/gmcwJoz0GFJKvHpYvPtx7GToG1BPiND8DMspmTwOjq8Z7YhIQXwLRZ3suk75
 MQw8gSyjHP0f9QTFFaiiILY3aZ+nV/eU1uFXLNBujC/lm2xsu+X0DcGJLbXHJXA9L1JVis2oCA
 pcyIiXEC4KxvSfEOI/d8sH/Uy6+EQOKpdOECq7FXwNUO7aiLPu8gZjPFl34jXzM6Wo9C0dkEzj
 clU=
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="38310142"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2019 08:05:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 3 Jul 2019 08:05:27 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Jul 2019 08:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/vlT9dvZgZz9KEogC3vPeN+p9x9rIQr4sqlIrOAQ3s=;
 b=wI5ZkT5NlO4Min4+aYzgP/K4Hg7+v/UtkRiF2IHJnG6JNioTmfYujz0UwIgO57GM9pQGu4wnB+uW5byGhn7tt7Z3xXRMdRrst1ZgN3AC/I+hGFisFZT1sd3R7Fu6cYy/P2AWw2OXMzZ7VVoUs4oVkaZx03kqB+2t/qMWCSKOKmY=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1725.namprd11.prod.outlook.com (10.169.237.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 15:05:25 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::75c6:9864:b5c5:a7e5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::75c6:9864:b5c5:a7e5%7]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 15:05:24 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Codrin.Ciubotariu@microchip.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Thread-Topic: [RESEND][PATCH] clk: at91: generated: Truncate divisor to
 GENERATED_MAX_DIV + 1
Thread-Index: AQHVMbC9mVadLuob/kClhqByyH9zfA==
Date:   Wed, 3 Jul 2019 15:05:24 +0000
Message-ID: <af07c26e-cef3-f0ff-48ff-68f99ccf4de9@microchip.com>
References: <20190625091002.27567-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190625091002.27567-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::30) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e866d46-4849-4d5a-ae1c-08d6ffc7e00a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1725;
x-ms-traffictypediagnostic: MWHPR11MB1725:
x-microsoft-antispam-prvs: <MWHPR11MB17250DD530A61A69BD7CF395E0FB0@MWHPR11MB1725.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(71200400001)(31686004)(486006)(71190400001)(36756003)(305945005)(81166006)(8936002)(8676002)(81156014)(3846002)(6116002)(72206003)(6486002)(7736002)(4326008)(25786009)(5660300002)(478600001)(256004)(68736007)(66066001)(14454004)(102836004)(6506007)(6436002)(386003)(476003)(66556008)(53936002)(2501003)(6512007)(52116002)(26005)(316002)(99286004)(2201001)(110136005)(76176011)(186003)(446003)(53546011)(6246003)(86362001)(31696002)(54906003)(11346002)(2616005)(66946007)(6636002)(66476007)(66446008)(229853002)(64756008)(73956011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1725;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nBCmm/WBprWUFAhDMhLAMIPkjvoXrfVyIcJDMQttkFLZUka4YBzLDbbU9WuZb2mnJWQZ2orEwMYiy8OwwchF5iGFHl7g4z/UCaX1T00oZW6mG48OGFqPspKPB5pOU88+3tZrMo8iGdBgiDo1GD2NuK0YVSf7trJLXKcl7bXgkbkN15+OYrlB2MAWSj1zgVaT8o0vlCKDmm7LwvyJ12pxm6oN3asi2/DG01GPZdn4YVqOpZ2hl/CEFjLFxSkUuKXBnKnLmUNkRcRqWy8Zi/yVI32Ah6a8yv+9WC3PGhwW+XdiHRPqCgAtJJb6xYeRWAgzfXT4o7U3XhViqEROm6eaoT9xhYwfNOvozr9A0isF0ln2FeihQdyFNgqcLZuPkwZ0HkLN5/ynJ5kj5qG9MEvIVEH4t6TixapSHyIB3k2DZOE=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1FD09E8ED1663B4F99671CC1C3F4569B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e866d46-4849-4d5a-ae1c-08d6ffc7e00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 15:05:24.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nicolas.ferre@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2019 at 11:10, Codrin Ciubotariu wrote:
> In clk_generated_determine_rate(), if the divisor is greater than
> GENERATED_MAX_DIV + 1, then the wrong best_rate will be returned.
> If clk_generated_set_rate() will be called later with this wrong
> rate, it will return -EINVAL, so the generated clock won't change
> its value. Do no let the divisor be greater than GENERATED_MAX_DIV + 1.
>=20
> Fixes: 8c7aa6328947 ("clk: at91: clk-generated: remove useless divisor lo=
op")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>=20
> - The email-server was converting my patches to base64, so I resend it
>    using another server;
> - Added acked-bys from Nicolas and Ludovic;

Stephen,

I don't see this patch in linux-next and we're already late in the=20
development cycle: aka ping...

Best regards,
   Nicolas

>=20
>   drivers/clk/at91/clk-generated.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-gene=
rated.c
> index 5f18847965c1..290cffe35deb 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -146,6 +146,8 @@ static int clk_generated_determine_rate(struct clk_hw=
 *hw,
>   			continue;
>  =20
>   		div =3D DIV_ROUND_CLOSEST(parent_rate, req->rate);
> +		if (div > GENERATED_MAX_DIV + 1)
> +			div =3D GENERATED_MAX_DIV + 1;
>  =20
>   		clk_generated_best_diff(req, parent, parent_rate, div,
>   					&best_diff, &best_rate);
>=20


--=20
Nicolas Ferre
