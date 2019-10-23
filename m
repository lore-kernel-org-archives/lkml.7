Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BPEYnKjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392095AbfJWVZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:25:01 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9018 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392012AbfJWVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:25:00 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cE2YaGadm4jSx1aV3E2tdG5p12t4mbgQEQzocF9ScEXJyxotnvOjAWSpHJLXmHRVzS5HUdlgTW
 Da4l/u5kf2vZofZZnufGM2Z0lJc5LzbhW5pgn62P5aY/Gi5D2VzeG+2aSVzSjFYzyQ1Y+XvYSf
 8kR5rHcK628mqVjY9GfdOOGZvuyo1rFOt670ZIYQGr4RA4G0uyg1BGMY0MHf9f+DuVqYrBA9Xe
 T/y206WkEqwDGk6LyLPBk7rfKC8VQ5Ksl2mexKHPFgh8SDPsR2kDEaxZmFbtEAk9xnvb3ytZ8L
 2hg=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="54151951"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 14:24:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 14:24:58 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 23 Oct 2019 14:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWYnaJE6QOlfbAPlWtoPTxA0HzLRv5H8HY+g+yjsYXmD1UJlSaFdGFJ9xRWHhAmag5FYpMn3FzU0LdANvz7sQKaNPAgWunw/e/tkvo83qn/rH+spb0MyvZOJ/G8GO6xL++Ob2ZyeX6bQgLrh5DpuFnffD6OuglOANU4iei0JZ0ljWSw9+8uZvP8/Tr49muiK2YMRx+yB0qEjlJt02hsP46vCzG1q/PWtUJwbgFNQJLstgt8THyGM8H9IaR2l2n7pr5xTibGi9B9Iv+jcVQkFc2jZ2y9eXC1m1TMT4dsjjCmi5LoFKKPrBEXUl/JEzzl8XCx4SS25MBQ2IK3XGhfOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfQerkVRfO4/hdMv1w7iaxwJKKrsFgZjV92MIq9sa0Q=;
 b=YDKU/pBplpVlUbT7It4+WIqM6L6jKZRFyFSmBI/wXvjD3pc7wPhULhXakJxyDZYbQd1QxqTW+mtL+7/YsrLSZujH0FGPhf8eQEZ++ZioBiIip3CCG+HytY2fYpVcJvOwzzJHYFbOhQBGyDNtPMjZDKlMwCx5LnpuJVLZF0WHXDYYJLanaEbximPqEvaFc+2dr9LFyK7fmZ2phOCGJffz90dQaGhhMoLATEbhtLEDDsnCQBG/jsE/rQZf3NSZZen46LcFaeG8LEJ1J5cUzZgs+Z220riiyJuvqogJXQ3/xkozC88n8j+zcsEiTzISNB9Jm5E7rprOmlUNqtGj736hQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfQerkVRfO4/hdMv1w7iaxwJKKrsFgZjV92MIq9sa0Q=;
 b=BPEYnKjXAsw4nGqfARKU2rGT6y7y2mZ/KjyA6SdBO+PZ5EYxqd3YXu2pOE3B6WtKtWJHMk0TDT5dZI6NGxicLI5xgRmoPeKeWYSvuAq82qZCjsgyvPnzAV13wflI+gVcCemHf9Q3TjbVxvXul3UnJ522nqm77Rh59p7bZZVyfhs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3549.namprd11.prod.outlook.com (20.178.250.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 21:24:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 21:24:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 02/22] mtd: spi-nor: Introduce 'struct
 spi_nor_controller_ops'
Thread-Topic: [PATCH v2 02/22] mtd: spi-nor: Introduce 'struct
 spi_nor_controller_ops'
Thread-Index: AQHVcqwXvwt12P9zSEWzEDp8S155Aqdo6zKA
Date:   Wed, 23 Oct 2019 21:24:57 +0000
Message-ID: <18ad9382-b081-9945-f981-5bf5ba1cde56@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-3-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-3-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::25) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a36900a4-4399-4346-c136-08d757ff73f3
x-ms-traffictypediagnostic: MN2PR11MB3549:
x-microsoft-antispam-prvs: <MN2PR11MB35493C6D6608B44929760BBCF06B0@MN2PR11MB3549.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(6436002)(25786009)(2906002)(5660300002)(102836004)(26005)(64756008)(446003)(66556008)(8936002)(86362001)(2201001)(386003)(6506007)(66476007)(229853002)(66946007)(53546011)(36756003)(31696002)(81166006)(6116002)(81156014)(2501003)(8676002)(256004)(3846002)(14454004)(71200400001)(71190400001)(7416002)(110136005)(66066001)(52116002)(316002)(99286004)(6486002)(54906003)(76176011)(6512007)(31686004)(478600001)(11346002)(66446008)(6246003)(186003)(4326008)(305945005)(2616005)(486006)(476003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3549;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PaMmgRfwTh7beEDA0C0eGbkflOWDE+3KA9ugF8Z1nFSEGqSkoZsNqCtt1a2WBiUSdjQ0eQX27zT1Y5jeGQJsM2Vd2J4yWour6867TPTXnRCWMUTvfBjEJmXhQ6iHsF0kSVO28hrTSu77U7Kjn6boK0T8/cg9inJrnU6Zd74Si3vdM6yFOFSpU8F/b2643l+rtFbK1NiNeKVaun4fCB3f6zYQMH+gD88vcHTK+uf/utcFF/kCYWvh0wsFIxDZVlQX2loSz6Hb62/HMud1DLBTFuGxJf86HtwGMkIl5CKJzAG0l33C0zuQV8Z2cTx9fi4NZB1LoIWvuWYvcwvOc11cZLYPaFSQyvRwHX+B9t4pHcLDMUg2dG7qOVtbbCG9egfMV0Z9Ka2/gm2X0EXPdLM/zb679oquXiCcL9nBCbmv4CVue3DNsNd13hoWmnp9RtN7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D377C1234231CD4495F1D287096B941D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a36900a4-4399-4346-c136-08d757ff73f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 21:24:57.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juTPhF0ai6dSVS7tx3Kis9XYsQMVpipmU4tHsKgRVWFHPccWDrsDgi3FgIoPEM4bFjCd4khkfleluN8S2q98XigGpEqbzQvft0kHwR3ur84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzI0LzIwMTkgMTA6NDUgQU0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IE1vdmUgYWxsIFNQSSBOT1IgY29udHJvbGxlciBkcml2ZXIgc3BlY2lmaWMgb3BzIGluIGEg
ZGVkaWNhdGVkDQo+IHN0cnVjdHVyZS4gJ3N0cnVjdCBzcGlfbm9yJyBiZWNvbWVzIGxpZ2h0ZXIu
DQo+IA0KPiBVc2Ugc2l6ZV90IGZvciBsZW5ndGhzIGluICdpbnQgKCp3cml0ZV9yZWcpKCknIGFu
ZCAnaW50ICgqcmVhZF9yZWcpKCknLg0KPiBSZW5hbWUgd2l0ZS9yZWFkX2J1ZiB0byBidWYsIHRo
ZSBuYW1lIG9mIHRoZSBmdW5jdGlvbnMgYXJlDQo+IHN1Z2dlc3RpdmUgZW5vdWdoLiBDb25zdGlm
eSBidWYgaW4gaW50ICgqd3JpdGVfcmVnKS4gQ29tcGx5IHdpdGggdGhlc2UNCj4gY2hhbmdlcyBp
biB0aGUgU1BJIE5PUiBjb250cm9sbGVyIGRyaXZlcnMuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEJv
cmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2FzcGVlZC1zbWMuYyAgICAgIHwgMjMgKysrKysrLS0t
LS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgfCAzOSArKysrKysr
KysrLS0tLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvaGlzaS1zZmMuYyAgICAgICAgfCAy
MiArKysrKy0tLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jICAgICAgIHwg
MjQgKysrKysrLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbXRrLXF1YWRzcGkuYyAgICAg
fCAyNSArKysrKysrLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbnhwLXNwaWZpLmMgICAg
ICAgfCAyMyArKysrKysrLS0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgICAg
ICAgICB8IDc2ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICBpbmNsdWRl
L2xpbnV4L210ZC9zcGktbm9yLmggICAgICAgICAgIHwgNTEgKysrKysrKysrKysrKy0tLS0tLS0t
LS0NCj4gIDggZmlsZXMgY2hhbmdlZCwgMTY2IGluc2VydGlvbnMoKyksIDExNyBkZWxldGlvbnMo
LSkNCg0KQXBwbGllZCB0byBzcGktbm9yL25leHQuDQo=
