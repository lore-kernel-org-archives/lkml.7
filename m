Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA058C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eKwClmvO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O+Gq3kpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfDPMS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:18:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555417107; x=1586953107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wofGZ8L9+Al5F+axZjmsjWAXE/ttDkcrEW41H9ZOolg=;
  b=eKwClmvOIzytfEOnRGpYJWD2UiGPujhSs0E0hk7cH2e6mcxy2hBZI696
   eZSuJ8V3yBXT6fTe0DBIJYSoS4KTv+Bx7vBfpwn/ekheJ1O/6ikP4wIOW
   dw2ljsJdLBgmJXcJzoPgH5DBXE2RRLJw++eiZid17k3xBJeofz/CcAxWM
   GdxKmNVCl6i2WZ2QbRQTpmoDhAxmrfihEu53afLM30GuCLQ9L9ke5kEMM
   Xmp4Dhg/RzdnEAB89/D6dMZPioZsgYZOzucZbnyM3485w0hMGap39r1YK
   AR/qiAVRByQJ/EkzzKfn7su7EO0xo5oViSwyEdNXZkaSRlYhrrbK2uZ9E
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,357,1549900800"; 
   d="scan'208";a="107307886"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2019 20:18:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6hw0es/e/c/zzfnpeZLj6Jd8IiDCqjjIzdWhdRLYoA=;
 b=O+Gq3kpf4RlGmSS7WIMLWmAmk7VnrSx/caGMCZOyTQ9vI0eYCUSGcpR8EVvRVZ7IJXCSmjacEITI/YrZooClDaMaBjVUUdHQ1hwAc0xC6z616LE04HUO2DEe9PCuzB5g9+9unPxoG+77eubhNaEVZEqZoABwEODVn+TP/pbDDtA=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4206.namprd04.prod.outlook.com (52.135.71.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Tue, 16 Apr 2019 12:18:25 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::18d2:ac1f:7c5e:186e]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::18d2:ac1f:7c5e:186e%2]) with mapi id 15.20.1813.011; Tue, 16 Apr 2019
 12:18:24 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Raul E Rangel <rrangel@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "zwisler@chromium.org" <zwisler@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1] mmc: core: Verify SD bus width
Thread-Topic: [PATCH v1] mmc: core: Verify SD bus width
Thread-Index: AQHU885Ju3yoBB5AdEOPcdYwnBORDKY+tCGA
Date:   Tue, 16 Apr 2019 12:18:24 +0000
Message-ID: <SN6PR04MB4925DC8FAFEE4A40ABAF68C8FC240@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190415210031.54062-1-rrangel@chromium.org>
In-Reply-To: <20190415210031.54062-1-rrangel@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e26306-1fc0-4839-9990-08d6c2659fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4206;
x-ms-traffictypediagnostic: SN6PR04MB4206:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB420670E7133F96CBC729EE5FFC240@SN6PR04MB4206.namprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(26005)(186003)(14454004)(71200400001)(76176011)(71190400001)(229853002)(106356001)(6436002)(446003)(8676002)(476003)(52536014)(11346002)(7696005)(86362001)(105586002)(15650500001)(6116002)(256004)(68736007)(486006)(3846002)(5660300002)(6246003)(53936002)(72206003)(97736004)(99286004)(6306002)(305945005)(25786009)(478600001)(2906002)(74316002)(66066001)(7736002)(966005)(2501003)(102836004)(110136005)(6506007)(316002)(81166006)(81156014)(9686003)(8936002)(4326008)(54906003)(33656002)(55016002)(10126625002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4206;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ry1UpxNi6jIAIZdYiDcp0ssmT9QoYltyTeEKNyRqspIqPgTADppqgK+bmuUlXiKfNYEFf3UyDkR2Xm8aMA2ARrr7pwMTICyl32kDdq0oRBBCoUBUkTvGw/SSkxurKKowK37nM3DGTybweS5/yE0QDmrr+Jo0EmHGrf4djcgRE6g4tmRrFl6QxiFoZuNFqezRZHSOPW/IQCkMaksoA6wwV6ombYiYIUS/XgYCahKrpXntQxgiFixYmXfGxVh4OgUfYdo3iEefF0DdS1apikfJ4vVwPBL4eKa3+LQRnEKH0mOdA/4wNBc7WdKFcNorNAMbaP29BcS1CI4xALglK8YXMnNC5RJKsRJzE12s+gSTLC5uNWw9zyiQHuvsnyNcTUAku6fjjdW7V39hcF8nNlgoe8GTMVbhYtSJ1pOOHdkdOM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e26306-1fc0-4839-9990-08d6c2659fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 12:18:24.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any S=
D
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH=3D"0101").
>=20
> This change verifies the card has specified a bus width.
>=20
> verified it didn't mount.
>=20
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
>=20
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
>=20
> Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
> Look for sd_scr and sd_ssr.
>=20
>  drivers/mmc/core/sd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 265e1aeeb9d8..f6481f8e9fe7 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -205,6 +205,13 @@ static int mmc_decode_scr(struct mmc_card *card)
>=20
>  	scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
>  	scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
> +
> +	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
> +	if (!scr->bus_widths) {
So why not testing that exact mask?
you have SD_SCR_BUS_WIDTH_1 and SD_SCR_BUS_WIDTH_4 already defined...
