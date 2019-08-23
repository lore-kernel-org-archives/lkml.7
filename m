Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96144C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601DB2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qzHJKk5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbfHWQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:07:55 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:50697 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbfHWQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:07:54 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ogO3tExMKkqIL3YI69aK9J3ow9tBM+SO1HGA7M7FAjwXAoy83X7XfxBBQkQkEZoLV/FoL1cl8U
 t6aCD/av2+7XIli2Uly0z3CjOMTlC4mqW0A/tZKdDzqipTDLaXauNSNqzLFLGQ6e7Aj0PTRKdC
 3H0HxJUMLBOXDZteFQmZH0k6cvEsM5SkDNyxCdGJCKGwzN91FoJjah1MdRAMHTja6G9YWNp5e8
 sYvyCqZOjCJvuJo3HQ8O6Xim2cZavSTnnPFwV8jkv2MhvuXeAXZ2gUkxCftyn8gHw4Ns3DtAMf
 gNs=
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="45399391"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 09:07:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 09:07:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 23 Aug 2019 09:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEnKC+nQ7n7B3pkKq2KywbndeWP0mfDrjwIhim9KLX9jfrzDAji8ZuzomuTx4cOyJf/qhJUxEDrxeUENfQeLTfqrK+YCuLkF0/hdfS1nLHTDBVy191RN7O5tvuJIsCVHMV9qdrppSc4IQrHGD8OxCHglGKVVQMvzjvdX58VIHiPwRBi3M9LowkJ+HSZ+mqnY5mLN6XXS/7WWeZqPfgkvKxu7zXwhTikWNShZz+TZ3j8P4fdnnzl7TeY9zKZBdMXedgAsX5asaulKcdrYVJJTYS10pehE1hYcid/w5mvXFaDk+E2/17/q7OezKPAbOT1HhDKPg9ddAJYcB7PWnEDCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwJVG/Owy1MP/r9Sc86/05Hdb24kqUA9Yujrdc22Fkw=;
 b=k8o18lF7mlx/TBNTnIW09gEbftDHZBgrRhQR50oCIIGJ0OPgG7qU5ivpMsAF/66m/Cnt+tzpAM6IhcZJbZ1hKb+yhFDDpd0KVizUS7HYbsqFq2I/l0Covq9guFHZTz6SxMLYps2xkn+/5Q4C4GR33147wX6SLFOtbTxaHX5PDuN92MJz93mERWduvyCLLYTIA6ifbQaU2gwdMtnJjE/1eSwsBfJGoimsLz1Q6O0CeS14BeAbCiKhNaw/w5oXLsNJrhmpeGpII5VdEGymxXvINQi+sseUYf+3axE5Ln60gez5DHNR8Z651qEmmTwbLZpKfBtfVpLK90AuwAxy7Q3NtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwJVG/Owy1MP/r9Sc86/05Hdb24kqUA9Yujrdc22Fkw=;
 b=qzHJKk5cgnnxdIW7xzUMQXMEU6Y3yj7wS3bv4k7cP8B0DZnju6+rcFVxGAPgw4sS06FufaUH6YW4+F9zq3mQyrPN+rWWOPdUYJSE8OC2sJxKtXcgfCXvOa3BnyawMDtB8qzgr1tQ+wQEuDzhOofsxFIE69gaSvreJ4uvBVJXPT8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4000.namprd11.prod.outlook.com (10.255.181.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 16:07:46 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 16:07:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH 0/2] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHVWcyE8k/5ko42FESjGCuiD3PSZ6cI5iyA
Date:   Fri, 23 Aug 2019 16:07:46 +0000
Message-ID: <8e8e85e2-9645-0c1d-0c02-171185567fd9@microchip.com>
References: <20190823160452.14905-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190823160452.14905-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6085c55a-95a7-46c1-4ddb-08d727e40959
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB4000;
x-ms-traffictypediagnostic: MN2PR11MB4000:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB40009040801DF5910A53DC8AF0A40@MN2PR11MB4000.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(6246003)(99286004)(53936002)(6486002)(66556008)(31686004)(6436002)(66446008)(256004)(6512007)(86362001)(229853002)(81166006)(31696002)(8676002)(66946007)(71200400001)(71190400001)(14454004)(7736002)(2201001)(6306002)(478600001)(305945005)(102836004)(81156014)(6506007)(53546011)(316002)(25786009)(26005)(446003)(5660300002)(386003)(476003)(966005)(486006)(2616005)(11346002)(66476007)(64756008)(2906002)(52116002)(4744005)(8936002)(186003)(3846002)(36756003)(76176011)(66066001)(2501003)(110136005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4000;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: am9B4t+FyR5Z2mpmZSQja8YzS7FdN5LLGwKWEH4/g/UYcJHTyp2SN9lNpd+/u8WWWnhu+qbHBkaWdxKmobGkgWchJFkvLsbC8dGJuI4OhAJDqfMIe4PeH+SW4mf5CHiNOKdnf911DnDE1tDwXXhOMCh9tZ8jTHX0tNd2SmcFfQeVr9XswxPpOjxu03psO0VRTaf53gPCnztyEpVkZbeQTGrfcW6T7v1watxGUdV3jHvA8Xw3RIYK5MDKwZ86VBkA7UdIxsrwcS4qOWtjwG0TQ3mB80vavTHpA+jVdwbI5yP65HFS9hgeQ3w7m/aL5B7hBXrj9FXmlx1VnHN6yn7AVMAiGxJXu1ySLXo3jS31KZxFi+hFkuwbNDWUTYh8BmGWrbsxqdA+Yi6/D7u817S+Ikjt1DHlC8coaMkJwfhhFBU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <34DB623D43E15B4CB70EB654248579E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6085c55a-95a7-46c1-4ddb-08d727e40959
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 16:07:46.0927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJ/Wd5/aJEjyLCg+wGTYH8oJMq7JZD+vFdGnD3yavZwVkWu0z+z/FZpUUlEQf2Bj+QV1sa0ma39kTMVpDIOldlaL2sqC8lt8xvhwin2d9xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNClRoaXMgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUgbW92ZSBtYW51ZmFjdHVyZXIgb3V0
IG9mIHRoZSBzcGktbm9yIGNvcmUNCnB1cnN1ZSwgYnV0IGRlcGVuZHMgb246DQoNCmh0dHBzOi8v
cGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvbGlzdC8/c2VyaWVzPTEyNzAz
MA0KDQpPbiAwOC8yMy8yMDE5IDA3OjA1IFBNLCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0IHdyb3Rl
Og0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBUaGlzIGlzIHNpbWlsYXIgd2l0aCB3aGF0IG90aGVyIG5vciBmbGFzaGVzIGFyZSBkb2lu
ZyBieSBjbGVhcmluZyB0aGUNCj4gYmxvY2sgcHJvdGVjdGlvbiBiaXRzIGZyb20gdGhlIHN0YXR1
cyByZWdpc3RlcjogZGlzYWJsZSB0aGUgd3JpdGUNCj4gcHJvdGVjdGlvbiBhZnRlciBhIHBvd2Vy
LW9uIHJlc2V0IGN5Y2xlLg0KPiANCj4gVGhlIEdsb2JhbCBCbG9jay1Qcm90ZWN0aW9uIFVubG9j
ayBjb21tYW5kIG9mZmVycyBhIHNpbmdsZSBjb21tYW5kIGN5Y2xlDQo+IHRoYXQgdW5sb2NrcyB0
aGUgZW50aXJlIG1lbW9yeSBhcnJheS4gUHJlZmVyIHRoaXMgbWV0aG9kIGZvciBoaWdoZXINCj4g
dGhyb3VnaHB1dC4NCj4gDQo+IFRlc3RlZCBvbiB0aGUgc3N0MjZ2ZjA2NGIgZmxhc2ggdXNpbmcg
dGhlIGF0bWVsLXF1YWRzcGkgZHJpdmVyLg0KPiANCj4gVHVkb3IgQW1iYXJ1cyAoMik6DQo+ICAg
bXRkOiBzcGktbm9yOiBhZGQgR2xvYmFsIEJsb2NrIFVubG9jayBzdXBwb3J0DQo+ICAgbXRkOiBz
cGktbm9yOiB1bmxvY2sgZ2xvYmFsIGJsb2NrIHByb3RlY3Rpb24gb24gc3N0MjZ2ZjA2NGINCj4g
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDUxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3Iu
aCAgIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCg==
