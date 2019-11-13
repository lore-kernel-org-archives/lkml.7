Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3951222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZZPlFMRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKMNfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:35:25 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:43531 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfKMNfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:35:25 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BC3NV9vWyy/+zpXrMCW2BbK4IxsQHx8PxU0CdhZDsBAdqr1sHcWEgMcS0aEMbih5LTua1lmz/f
 h1oN4PtkFFwrJ0fDbL9DT/aL9Ak7aLQQfSeatNk9k7w8Y9l5jQywthsCgVtxvRjadMNFuyqhsd
 5qjdrCZEA5GstakL81A0bvNXaoBB8hFnW6bZ2uLHkOhPt3bWYY5cgg+z03m9z0g3Fh+Eb8Pxb8
 hpxQL/Rp2VIRhibbX6UuicK5haJfw906aFFKPg0Rts4MRAP+lKUWJFmfLL146s0U3mMsqxIxCt
 Ud8=
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="55449795"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 06:34:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 06:34:33 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 06:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjgLqzqZKYgu6aVrIvFNlrHSQ3wrhoEaOMu9yyhEdcCJSZ6dHs/9OZm3too57+VUJthyjVBOy2c92VxVlawkmQDoMqfVgb4ROh6fGaPtqYjsQ6QvRxnqxzXlbnjqau/uDzPRgeFuVRRU5E9lidfvbGySpiN/6SEXkSZZD3FzKN5AXeA6JxQt7iZI0mzFjuPxiQLkAty3KBgD/TfBs5dZGdM+U2XYRp59m+k8nHji+YiUjl0882C1WxjGSVA/QsC2jzCtNypCT8yp/evdUxk7JN7JiV54kmqTBsXzZaMIrKOnZBBQh5xGQ6rymLg656F4uTn6Gbd1NN2uRkuaRivo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nIWPWKXsbGv2hsQUrne5QCICgslThikr/NHDNPRBSU=;
 b=kfMTmC8pNdZvvAfRSjhKb6i5ftQFDkuCNTQzOr4WyxVpO+pQ07vUz4mEU8ZT1xxneyCfGgiceXXTMHSxo5a5VXY+13gRg/FGTfOcCEgtpwvo1r/dIrIsE0adUyi71uZGpjOiEPz9LHVexu3tg94db+XaytnajnjtSJ9Hgqgk2MZMf1TunL09/4jEhhx8u0DpaOhDtf7rwmGff1b/HMUJSWZsgXd9HHqSTiSluSNve7IeqUbh3mo/O0LC7xMtXMgjkYbr9FyzkdpOjlSyIgnFZXuKlRM1bXKuVlUj+/vY9qCsJlXVL6rgdnESaVkisuG1u3ifKjKvtoCE0Gk3ebo/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nIWPWKXsbGv2hsQUrne5QCICgslThikr/NHDNPRBSU=;
 b=ZZPlFMRxfZraSIkJ1c19RykRzBtsrnl/pm0allsRT+RnUbC4XSA5lx9iGy48yna3a3iLqX2hNYsRI5vbtSP1BGFxBhsDI19aWUwurISk0uqDNYITKu/Jz4Yz5v1o8//939ygg3f4p2zaBOM8yN2mEviyTGF/sAaVoKYE7Pd1ifc=
Received: from BY5PR11MB3895.namprd11.prod.outlook.com (10.255.162.149) by
 BY5PR11MB4194.namprd11.prod.outlook.com (52.132.253.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 13 Nov 2019 13:34:30 +0000
Received: from BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::ac5c:4f74:3892:4787]) by BY5PR11MB3895.namprd11.prod.outlook.com
 ([fe80::ac5c:4f74:3892:4787%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 13:34:29 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <peter.ujfalusi@ti.com>
CC:     <ulf.hansson@linaro.org>, <vkoul@kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] mmc: atmel-mci: Use dma_request_chan() directly for
 channel request
Thread-Topic: [PATCH 1/2] mmc: atmel-mci: Use dma_request_chan() directly for
 channel request
Thread-Index: AQHVmgW75mYLihL5AEO67/DxxxkYxaeJGgyA
Date:   Wed, 13 Nov 2019 13:34:29 +0000
Message-ID: <20191113133417.zrz5zcwuyxjskaes@M43218.corp.atmel.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
 <20191113093616.32474-2-peter.ujfalusi@ti.com>
In-Reply-To: <20191113093616.32474-2-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:101:16::14) To BY5PR11MB3895.namprd11.prod.outlook.com
 (2603:10b6:a03:18e::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf3e18b-5fa3-42a7-90c7-08d7683e35ca
x-ms-traffictypediagnostic: BY5PR11MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB41940AEF451E7073EF70CE0BEF760@BY5PR11MB4194.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(14444005)(54906003)(256004)(7736002)(66946007)(26005)(478600001)(1076003)(71200400001)(71190400001)(6916009)(6246003)(186003)(486006)(6506007)(476003)(386003)(6436002)(99286004)(6486002)(446003)(11346002)(66446008)(52116002)(66556008)(76176011)(66476007)(305945005)(64756008)(229853002)(6512007)(9686003)(8936002)(81166006)(86362001)(8676002)(2906002)(81156014)(14454004)(5660300002)(66066001)(316002)(102836004)(4326008)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4194;H:BY5PR11MB3895.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8/zZjRL6TweVwo2v9qGRGxdvY6qJ9zLf40VrGRWX0QiSKFJ6w7FSAszspe3kbwxJ+JY9XPS4LKX2Epj0PLJvUDaxMlh5wP/BVAhwicrUo5e6GbvRI0t6UEvuVoSJbbZjm7a3gI/s1b9mtJ1Jt/ri0aFsn73BZj1MIwDBS4pAWHRWncQyQZqUJqNN11losQjK6bhHYjJ6+k09OKFgB8/qCTxV3qSH4mmu06g8nL6hbW87tKoPVDFhKErHojUcR+Hz6SaArguHxd3zftJk0BzwRYlgZ6V/Ri4+29Mb4Q9u4MQ+N3+wu8wxKwHmQiItfSRlL91AA2ZhTRQxjC6YsKXgsH3CIzt8gcD2vh0bMLof+pER6ykTKQv2a9+LfeL5KOFPAxk9Vgje35wlHOra3nW3qheTAcGUoYq25XTg8rDbR7CViBIOTufWaPYZzuv9zin
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14F9A1929CF5AE40891E63ADE53B85E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf3e18b-5fa3-42a7-90c7-08d7683e35ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:34:29.7942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp1hxhjyunltYjXfj6mHJ38ljgzplKv6NsQ+AD5pWC095bsmFWtPrtgpurKniBvxiv2V9vUqLIZqW3vwUYxXhqDHACnk+jp9jWR7K1GHa10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:36:15AM +0200, Peter Ujfalusi wrote:
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks
> ---
>  drivers/mmc/host/atmel-mci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 34c992d87529..6f065bb5c55a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2347,8 +2347,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slo=
t *slot,
> =20
>  static int atmci_configure_dma(struct atmel_mci *host)
>  {
> -	host->dma.chan =3D dma_request_slave_channel_reason(&host->pdev->dev,
> -							"rxtx");
> +	host->dma.chan =3D dma_request_chan(&host->pdev->dev, "rxtx");
> =20
>  	if (PTR_ERR(host->dma.chan) =3D=3D -ENODEV) {
>  		struct mci_platform_data *pdata =3D host->pdev->dev.platform_data;
> --=20
> Peter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20
>=20
