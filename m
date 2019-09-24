Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E281C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299852146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HRmRiqxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440890AbfIXLxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:53:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:5875 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394463AbfIXLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:53:38 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /1ZOBQ6ERgzdZ0NjuWpAauIB9IVKH3NcbpJryVpWl73yErqoS7rJDOL0ZBEUfh+cXHVhy6SUse
 HfSCV4dIjqNvDqIZ/uNPJ89XHAuIr4bkddf8LJgtZybcsv5tKL6DEg1SkTHL3b1cKWb+pYRTwE
 uhfX1tSmzwosYmFO5tpi5DJDGHDd9qLnWtMeM4IZIQof+DDgcv+fRRlmWsUAGN3FoC8PBwlDQx
 4CPWqOZMyfivJ0zTnMG+wKfpSQfG7qt+LP84QcVpyOUj7kql823E6XlOaWLpcJtXsHiGGBn8C5
 PK0=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="51642054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 04:53:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 04:53:36 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 04:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh/NCe9S9EiS7Ce8166E6Wh0NfHC4Mv+ue9+rmXgTS2r4jrVVpQwwy8DcA7vN5pauSNCl1jXpayiipnACMeWI/1UTbRp2l1ZSo9quAWAn4EtiCewXkY6Cg2VZ0w0C7XRhNW7b0f4SYDQc+22fDj4huT5j/zxa2bY/GCHABhafymAZd1M4k7A1tT/m1Ew7OhttyldR4flaqVUo5BKZuiU6Ey8/UHDpSknIAPziUNA7XOndxJLOoxwTkwgw+BwrkzYiidqXRPyYnhY3u5QSMgbg6eQOZeT2+G+UrVmq/rxFlgQf4dkaBm0ICBg8y4tZS2UAhyl86R10H1eYVOjJtEZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNpqvT9bNHgd5aL+Eu9HXIQw7Azfq0GS9vEBhBTlrg4=;
 b=M5ZZaafxHg2pr5dHUPFJ4vuaq0nd0CNy2DVtotsaFb61aDHcODwo6hP2sfzQ0PvKwXWUUrpiJg4zAk9nP8RqKq8m1WOBy+7cbGBVGg7w36oGj9lbOr0/Os52z8ow0bqykQrOAbiAcn6QpEZyw1Jy1ilDOMhSppADThfXxAL3lje0UbOyyK6kHaNn1KoKGu7Li9pqXO5C73Xx5aPtUq9qz6+vPt145kZNJOn+k7JOn25lFISpBKoZzVB2dPpmYt9sAi/0U8PmEcrPoo4SSrrJ4v+2iZnlZD3cFsLRmr0GCyCAawR6Jtvf1iTmZIZZaq4ysqv0ZO4p2cGspXeyFEf13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNpqvT9bNHgd5aL+Eu9HXIQw7Azfq0GS9vEBhBTlrg4=;
 b=HRmRiqxWocKAuoHt8Cx8PjV/oVjZEAlusg8NvtPLlK63ZW9zLaX61/STroeJ31IWY+tb9gmHLR4UrjniHgAPlJ2AiTt8mAtqt5jrWWp1wvdjQD0F4QbKllSSMTp9Cr00je9cPPkAZ+BeQ+gtltPmyzAoFbrxzjEEIM7Crw/9nak=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1920.namprd11.prod.outlook.com (10.175.49.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 24 Sep 2019 11:53:32 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::a5d8:feff:2b41:862b]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::a5d8:feff:2b41:862b%6]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 11:53:32 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sam9x60: fix programmable clock
Thread-Topic: [PATCH] clk: at91: sam9x60: fix programmable clock
Thread-Index: AQHVcsRMYTeAx/4mlU+eM6N6BpGrrac6t80A
Date:   Tue, 24 Sep 2019 11:53:32 +0000
Message-ID: <a0139a50-9109-77d2-1aff-8c43439e5ec3@microchip.com>
References: <1569321191-27606-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1569321191-27606-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::23) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914edafb-bdc0-4181-ec6b-08d740e5d29e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1920;
x-ms-traffictypediagnostic: MWHPR11MB1920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1920E1B3192F599B0183A910E0840@MWHPR11MB1920.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(6506007)(66476007)(26005)(66556008)(53546011)(102836004)(386003)(8936002)(66946007)(3846002)(110136005)(71190400001)(71200400001)(2906002)(64756008)(36756003)(4744005)(6116002)(66066001)(52116002)(76176011)(186003)(99286004)(256004)(66446008)(446003)(476003)(2616005)(486006)(11346002)(25786009)(2501003)(86362001)(2201001)(14454004)(31696002)(478600001)(316002)(8676002)(81156014)(6512007)(6246003)(81166006)(31686004)(229853002)(6436002)(6486002)(305945005)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1920;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vs0TD5vyRTLlZ+Gkvpr7ZKU6U1+YHqEUbrPgP10+Mito8oO73PHIG2CRRhLML3iFEi4xxDQv6Qv4IA8AeWRk4TxdYj/R2RsmaQsodSE/bSeUr5dRMlDDp1b/K3srZtQafJKA1h4em7UkFXpPhmkCnow9Pb7teXp7wT3bpTZd0ofw0Dxtslkl4XR+GOHwPIbKk1AjMpPdQl1JQIcqhNn9nZuUPDZ/r7cjfT7Q605CLZ6JoN9u3uwgMq0Fkri7Sz4K0rg22PKSknDn5BgDhvYb9uJpfcFTZa6hyNfh9J3u9RN982tILBBdNnxl5lAhWGZ3ekyyANgZOmkIxb/yitHJczO6XEdpWzCfczkcSgekdYHktTdWYv2CQOYZEIDKlHKmK+7o6z36+eIUE7Q+ZOflo0wnWTtU66GHoONJn82a6uQ=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F3EE17076B5A274D814D23071466CC13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 914edafb-bdc0-4181-ec6b-08d740e5d29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 11:53:32.3102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jluPSRMxbvO5OtIV+vFUqqUvOzdGN3ohv8k6qcGvadnlHmZEhvIrUFDp6FE4JpFe5P2ImkLtQ6aouBQAOmOJjFjuJyvhBivyn7pXDwvvcLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 at 12:39, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The prescaler mask for sam9x60 must be 0xff (8 bits).
> Being set to 0, means that we cannot set any prescaler, thus the
> programmable clocks do not work (except the case with prescaler 0)
> Set the mask accordingly in layout struct.
>=20
> Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Eugen. Best regards,
   Nicolas

> ---
>   drivers/clk/at91/sam9x60.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index 9790ddf..86238d5 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -43,6 +43,7 @@ static const struct clk_pll_characteristics upll_charac=
teristics =3D {
>   };
>  =20
>   static const struct clk_programmable_layout sam9x60_programmable_layout=
 =3D {
> +	.pres_mask =3D 0xff,
>   	.pres_shift =3D 8,
>   	.css_mask =3D 0x1f,
>   	.have_slck_mck =3D 0,
>=20


--=20
Nicolas Ferre
