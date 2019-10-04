Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC63EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9506E215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TGlc8T8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfJDKss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:48:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18202 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:48:48 -0400
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
IronPort-SDR: figmXGPcw+UIOyXXLmNGuVWh+TKCI0G4PlsXeBVaZ8BM9sMh55KYgyhO3vpQThJBrEWot4Pouc
 ytjTrW1wBYBQNMKK6HINLnuzAQ4sURrV0KrRfrQ5WM4DivGFjZAIzDLQgKz+KRcf0wlfhYXAk5
 SwDQcAPGsGVfzOscSV1e3NPAOfMOUwX9ID/PdeppOeVC0xwtQ+v1eGTpfmIb2pXoLatOBynOuZ
 ET+wJkJXUdiCMhHGXX1W6xKvuq1BwKGtTJD7eHmaLHVFPAW8w7x52+OEBHvPYSqdVkF4hz+O6r
 aFg=
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="51745368"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2019 03:48:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Oct 2019 03:48:46 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 4 Oct 2019 03:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzLQrp2n3rdK843xKHEy52nIdlY1imbN6bwO4rDd6pvK3dOBvk+VlbDY7HLv/GXySM144UJW+sEj8ELobEKct81oFzGH2TRVWYxutZyOhpIs+I5KkNCqJ1E0Ob+HVRmDvglN9dw80udwX1nsCay9v/t2drQ3zKN8TspWG9c8xvMFEGOtrF/qDJzlpJ+ejCWQXBBL1SH8y6a0V5RgZo2HH//ShbG8tlCkEnhy7HYjYhH/wmeSHNLnbVol+j33+DDJGFUcg1etkQV0hHfSpRe5XQ7oaYRjx/nirTUks8TDYBW9LsqTr6WCUtSQDKvPrS2Ck5g9qkFn6Cx3/GRU1I1mxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UoiInd9321iKkr+w9Z2Pc0b1rni+ks2ZMtGBUC2MjM=;
 b=Erqf7o5zbWSdTP5QrqeZEfeTRPqBdTqrCXRJoGjlPGCCjHMxeZDeCBMzIRq1f22Xz+DSaW2mWfmDxIRSs2efQE7Kb7+at/ae3I0V/C4f4IYDd23yPno/eIBuwO2/Kmzwa3T+CCWHrjwWUOxkUYSZIAJnRe9jCXdt4mxGsk4dGN2RXcetY9WeiVcQouI5rGb8DALrAuR2QTL1FKwZSG9OHuoliixAJ+VSwk/Vll19iGM2uQeFlSdcFkReTaMULgee0zv71AJBqDJXU3S+U42ZU+a6uyCNiLdIUHi2rnYMRSpLCsk9wZhO+e1MjlYRLmGLDSz6MAgoR/JCHLaxO3Ah4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UoiInd9321iKkr+w9Z2Pc0b1rni+ks2ZMtGBUC2MjM=;
 b=TGlc8T8gFxbm4zLMUdZMlwy9AcgGu8FFeeFGHUIt+ZOQfcIl+co4YQ0jrsFMnblNU0XpwMXq7vDIaFAjmwMoYUFUv1HKdaJfgxjnRcZ6D8PLBtryp3SuFo/TUdikMA84TiqI//fdSeEd2P4SPzyhj1tqRlsblmjw0VujhSIcBWs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4222.namprd11.prod.outlook.com (52.135.36.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 10:48:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::340d:5a33:dc79:1184]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::340d:5a33:dc79:1184%5]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 10:48:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
Thread-Topic: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
Thread-Index: AQHVeqEtwNvmmNlG50ubt70oQPwmWadKTUqA
Date:   Fri, 4 Oct 2019 10:48:44 +0000
Message-ID: <9156860e-d257-bee6-fac8-a1821e4b5bf2@microchip.com>
References: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
 <20191004104746.23537-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191004104746.23537-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0021.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::31) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd2f9f49-7926-4b09-cf04-08d748b86daf
x-ms-traffictypediagnostic: MN2PR11MB4222:
x-microsoft-antispam-prvs: <MN2PR11MB422284C89065D0560916C64CF09E0@MN2PR11MB4222.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(53546011)(446003)(2501003)(11346002)(316002)(478600001)(99286004)(6246003)(6506007)(386003)(14454004)(102836004)(25786009)(64756008)(71200400001)(71190400001)(66476007)(66556008)(66946007)(66446008)(31686004)(86362001)(229853002)(486006)(2616005)(476003)(66066001)(52116002)(2906002)(305945005)(7736002)(4744005)(256004)(6512007)(6436002)(6116002)(3846002)(14444005)(31696002)(8676002)(81166006)(76176011)(8936002)(26005)(2201001)(81156014)(186003)(6486002)(110136005)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4222;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Nqy8eAlkW1PRRpxdxaYLEa3X9tT89ihVOqdaSUta7ktOMY4YKPeQWa6nE/StTVCanibd3BeTMR0Am/JhrNJG6f7MsdLgcQNSRCcrUhQ3KDmRM0zqXqC3RxMO/qO9WNT9aEVvWfTFOf6XXWD44GGekw7DDmK7MGHEGXYlQyQD9xzMbTz6ZlAIZmadm+4EiOlQMICQjiIH/yFpL7SThcgd1Uo/7d6RF+MIuHNHNfT5UtfLGO26EUmcewZxIetpBd57ulHrWXVnpBQPwzLPZYfSSLsKe3g5wAFN30F7D+IfDnLoZavJ9dQhsOQDWlCIRxhMOcG+o9ioUcRIDuiTCXJqhxgTE/01KgDpN3iXsVaymsUN8p9cFBB4Qp5o35xsCsqHf4+J1+mi/gwzKfUtnV+EFq8/HcITYy/XHhL/FrBJro=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F22D9A0BBF44E246AA7546AC611AF05B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f9f49-7926-4b09-cf04-08d748b86daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 10:48:44.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swJwc4sKJY/Ag3mG1GsahHoLPWnHcslOTluJGPhdBce9WP6pxqMtttG1iqD5Gw4KNMWzHiWho+Fscwrk28vxp2+PZvbLx0EoVSwsJnCvnxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9obiwgZG9lcyB0aGlzIGZpeCB5b3VyIHByb2JsZW0/DQoNCk9uIDEwLzA0LzIwMTkgMDE6NDcg
UE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6DQo+IEZyb206IFR1ZG9yIEFtYmFydXMg
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gDQo+IHdyaXRlX3NyKCkgc2VuZHMgZGF0
YSB0byB0aGUgU1BJIG1lbW9yeSwgZml4IHRoZSBkaXJlY3Rpb24uDQo+IA0KPiBGaXhlczogYjM1
YjlhMTAzNjJkICgibXRkOiBzcGktbm9yOiBNb3ZlIG0yNXA4MCBjb2RlIGluIHNwaS1ub3IuYyIp
DQo+IFJlcG9ydGVkLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGktbm9yLmMNCj4gaW5kZXggMWQ4NjIxZDQzMTYwLi43YWNmNGE5M2I1OTIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jDQo+IEBAIC00ODcsNyArNDg3LDcgQEAgc3RhdGljIGludCB3cml0ZV9z
cihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCB2YWwpDQo+ICAJCQlTUElfTUVNX09QKFNQSV9NRU1f
T1BfQ01EKFNQSU5PUl9PUF9XUlNSLCAxKSwNCj4gIAkJCQkgICBTUElfTUVNX09QX05PX0FERFIs
DQo+ICAJCQkJICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gLQkJCQkgICBTUElfTUVNX09QX0RB
VEFfSU4oMSwgbm9yLT5ib3VuY2VidWYsIDEpKTsNCj4gKwkJCQkgICBTUElfTUVNX09QX0RBVEFf
T1VUKDEsIG5vci0+Ym91bmNlYnVmLCAxKSk7DQo+ICANCj4gIAkJcmV0dXJuIHNwaV9tZW1fZXhl
Y19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4gIAl9DQo+IA0K
