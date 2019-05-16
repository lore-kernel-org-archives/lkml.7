Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA4C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B872082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vOywdjk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfEPIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:12:02 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25646 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfEPIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:12:02 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,475,1549954800"; 
   d="scan'208";a="30682350"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 16 May 2019 01:11:59 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 16 May 2019 01:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDAc519Gpnh5boTsudllchrsvozS+LhsWDClcKRDxOo=;
 b=vOywdjk1eldClaEW9dRlbwa3kAB30eI6tkB+PL+xw2mS40qK7WLG/VzJwO8MUL9hKofVSnKeOUJ/8rLCx4+qvIpLrlVYuCDz8/LFoPbmYyAm+rjhGB5k/HGq65OfmtDTYMWWOPCfc77HELKVsioGwy/eQ5mL+WiCfJByH8MWBc0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1952.namprd11.prod.outlook.com (10.175.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 08:10:34 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 08:10:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Topic: [PATCH v3 2/4] clk: at91: sckc: add support to specify registers
 bit offsets
Thread-Index: AQHVByLMz9Q/0hn5ekyMa2w9MKbUHaZk4YYAgAiN1AA=
Date:   Thu, 16 May 2019 08:10:34 +0000
Message-ID: <b99b1782-30be-b6b9-0df2-f14125be22ac@microchip.com>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-3-git-send-email-claudiu.beznea@microchip.com>
 <20190510213242.GE7622@piout.net>
In-Reply-To: <20190510213242.GE7622@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190516111024528
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d9fde0-ec71-49ea-4474-08d6d9d5f8b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1952;
x-ms-traffictypediagnostic: MWHPR11MB1952:
x-microsoft-antispam-prvs: <MWHPR11MB19522A5712D6C7E7405AA04D870A0@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(52314003)(199004)(6512007)(14454004)(71200400001)(102836004)(25786009)(99286004)(53936002)(229853002)(53546011)(2906002)(71190400001)(11346002)(66446008)(64756008)(6506007)(386003)(3846002)(486006)(66476007)(52116002)(66556008)(86362001)(6116002)(305945005)(73956011)(68736007)(66946007)(31696002)(54906003)(6246003)(5660300002)(8676002)(81166006)(186003)(76176011)(36756003)(446003)(7736002)(81156014)(8936002)(4326008)(26005)(66066001)(6916009)(72206003)(6436002)(256004)(6486002)(2616005)(316002)(31686004)(476003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1952;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HZozGJH79H/wcd/E5YK6YbhsjWzMSbj7cXNmROQTuzdY9d7lW7tVcaeHFnCUw+AbyZKxJMX6JUii3ZoTCr1hMgxsHNCfaSEHG1HY+04KiFjmX1ct5sqNhXkNbNPYkgcy4V3PCPFItFOQpB4hlu4mu614zSau1Y6NzsLwZtf0DKMO39pdKeUVtBJfHttBVvCH53GC2/SSd67mZ+y0ZZLnb8ZB1j9EDHPjq7yBFLM4pMuo6wKx/gFfA6CWhxY9OlQ9Bvu8QNkorHzRlylRy+P+9QZlPo0aWMXOzNvp8zB7XED/PdENg5vWI1rYngsS09JcEYd9I/Kjiw+u074/pozUDAGyWzSLwlvBNVD2YkXybm7kCGwO6bSTfHk5hfq5OEHfIftsSvPULWxwULfwLcY9fUTXmAIciB6sj62NfVHqyF0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <383569B37B17E34ABBDAAB8948BC2E04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d9fde0-ec71-49ea-4474-08d6d9d5f8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 08:10:34.7147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLjA1LjIwMTkgMDA6MzIsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAx
MC8wNS8yMDE5IDExOjIzOjMxKzAwMDAsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4+DQo+PiBEaWZmZXJlbnQgSVBzIHVzZXMgZGlmZmVyZW50IGJpdCBvZmZzZXRzIGluIHJl
Z2lzdGVycyBmb3IgdGhlIHNhbWUNCj4+IGZ1bmN0aW9uYWxpdHksIHRodXMgYWRhcHQgdGhlIGRy
aXZlciB0byBzdXBwb3J0IHRoaXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2Ns
ay9hdDkxL3Nja2MuYyB8IDEwMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgMzMgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIv
ZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCj4+IGluZGV4IDZjNTVhN2E4NmY3OS4uMmE0YWM1NDhk
ZTgwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvY2xrL2F0OTEvc2NrYy5jDQo+PiBAQCAtMjIsMTUgKzIyLDIzIEBADQo+PiAgI2RlZmlu
ZSBTTE9XQ0tfU1dfVElNRV9VU0VDCSgoU0xPV0NLX1NXX0NZQ0xFUyAqIFVTRUNfUEVSX1NFQykg
LyBcDQo+PiAgCQkJCSBTTE9XX0NMT0NLX0ZSRVEpDQo+PiAgDQo+PiAtI2RlZmluZQlBVDkxX1ND
S0NfQ1IJCQkweDAwDQo+PiAtI2RlZmluZQkJQVQ5MV9TQ0tDX1JDRU4JCSgxIDw8IDApDQo+PiAt
I2RlZmluZQkJQVQ5MV9TQ0tDX09TQzMyRU4JKDEgPDwgMSkNCj4+IC0jZGVmaW5lCQlBVDkxX1ND
S0NfT1NDMzJCWVAJKDEgPDwgMikNCj4+IC0jZGVmaW5lCQlBVDkxX1NDS0NfT1NDU0VMCSgxIDw8
IDMpDQo+PiArI2RlZmluZQlBVDkxX1NDS0NfQ1IJCTB4MDANCj4+ICsjZGVmaW5lCQlBVDkxX1ND
S0NfUkNFTihvZmYpCSgob2ZmKS0+Y3JfcmNlbikNCj4+ICsjZGVmaW5lCQlBVDkxX1NDS0NfT1ND
MzJFTihvZmYpCSgob2ZmKS0+Y3Jfb3NjMzJlbikNCj4+ICsjZGVmaW5lCQlBVDkxX1NDS0NfT1ND
MzJCWVAob2ZmKQkoKG9mZiktPmNyX29zYzMyYnlwKQ0KPj4gKyNkZWZpbmUJCUFUOTFfU0NLQ19P
U0NTRUwob2ZmKQkoKG9mZiktPmNyX29zY3NlbCkNCj4+ICsNCj4+ICtzdHJ1Y3QgY2xrX3Nsb3df
Yml0cyB7DQo+PiArCXUzMiBjcl9yY2VuOw0KPiANCj4gVGhpcyBiaXQgaXMgb25seSB1c2VkIG9u
IHNhbTl4NSBzbyBJIHdvdWxkbid0IGJvdGhlciBoYXZpbmcgaXQgaW4gdGhlDQo+IHN0cnVjdHVy
ZSwgZXNwZWNpYWxseSBzaW5jZSBpdHMgdXNlIHdpbGwgYWx3YXlzIGJlIHF1aXRlIHNlcGFyYXRl
IGZyb20NCj4gdGhlIG90aGVyIG9uZXMgYXMgaXQgaXMgY29udHJvbGxpbmcgYSBzZXBhcmF0ZSBj
bG9jay4NCj4gDQo+PiArCXUzMiBjcl9vc2MzMmVuOw0KPj4gKwl1MzIgY3Jfb3NjMzJieXA7DQo+
PiArCXUzMiBjcl9vc2NzZWw7DQo+PiArfTsNCj4+ICANCj4+ICBzdHJ1Y3QgY2xrX3Nsb3dfb3Nj
IHsNCj4+ICAJc3RydWN0IGNsa19odyBodzsNCj4+ICAJdm9pZCBfX2lvbWVtICpzY2tjcjsNCj4+
ICsJY29uc3Qgc3RydWN0IGNsa19zbG93X2JpdHMgKmJpdHM7DQo+PiAgCXVuc2lnbmVkIGxvbmcg
c3RhcnR1cF91c2VjOw0KPj4gIH07DQo+PiAgDQo+PiBAQCAtMzksNiArNDcsNyBAQCBzdHJ1Y3Qg
Y2xrX3Nsb3dfb3NjIHsNCj4+ICBzdHJ1Y3QgY2xrX3NhbWE1ZDRfc2xvd19vc2Mgew0KPj4gIAlz
dHJ1Y3QgY2xrX2h3IGh3Ow0KPj4gIAl2b2lkIF9faW9tZW0gKnNja2NyOw0KPj4gKwljb25zdCBz
dHJ1Y3QgY2xrX3Nsb3dfYml0cyAqYml0czsNCj4+ICAJdW5zaWduZWQgbG9uZyBzdGFydHVwX3Vz
ZWM7DQo+PiAgCWJvb2wgcHJlcGFyZWQ7DQo+PiAgfTsNCj4+IEBAIC00OCw2ICs1Nyw3IEBAIHN0
cnVjdCBjbGtfc2FtYTVkNF9zbG93X29zYyB7DQo+PiAgc3RydWN0IGNsa19zbG93X3JjX29zYyB7
DQo+PiAgCXN0cnVjdCBjbGtfaHcgaHc7DQo+PiAgCXZvaWQgX19pb21lbSAqc2NrY3I7DQo+PiAr
CWNvbnN0IHN0cnVjdCBjbGtfc2xvd19iaXRzICpiaXRzOw0KPj4gIAl1bnNpZ25lZCBsb25nIGZy
ZXF1ZW5jeTsNCj4+ICAJdW5zaWduZWQgbG9uZyBhY2N1cmFjeTsNCj4+ICAJdW5zaWduZWQgbG9u
ZyBzdGFydHVwX3VzZWM7DQo+PiBAQCAtNTgsNiArNjgsNyBAQCBzdHJ1Y3QgY2xrX3Nsb3dfcmNf
b3NjIHsNCj4+ICBzdHJ1Y3QgY2xrX3NhbTl4NV9zbG93IHsNCj4+ICAJc3RydWN0IGNsa19odyBo
dzsNCj4+ICAJdm9pZCBfX2lvbWVtICpzY2tjcjsNCj4+ICsJY29uc3Qgc3RydWN0IGNsa19zbG93
X2JpdHMgKmJpdHM7DQo+PiAgCXU4IHBhcmVudDsNCj4+ICB9Ow0KPj4gIA0KPj4gQEAgLTY5LDEw
ICs4MCwxMSBAQCBzdGF0aWMgaW50IGNsa19zbG93X29zY19wcmVwYXJlKHN0cnVjdCBjbGtfaHcg
Kmh3KQ0KPj4gIAl2b2lkIF9faW9tZW0gKnNja2NyID0gb3NjLT5zY2tjcjsNCj4+ICAJdTMyIHRt
cCA9IHJlYWRsKHNja2NyKTsNCj4+ICANCj4+IC0JaWYgKHRtcCAmIChBVDkxX1NDS0NfT1NDMzJC
WVAgfCBBVDkxX1NDS0NfT1NDMzJFTikpDQo+PiArCWlmICh0bXAgJiAoQVQ5MV9TQ0tDX09TQzMy
QllQKG9zYy0+Yml0cykgfA0KPj4gKwkJICAgQVQ5MV9TQ0tDX09TQzMyRU4ob3NjLT5iaXRzKSkp
DQo+IA0KPiBJIHN0aWxsIGZpbmQgdGhhdDoNCj4gDQo+IAlpZiAodG1wICYgKG9zYy0+Yml0cy0+
Y3Jfb3NjMzJieXAgfCBvc2MtPmJpdHMtPmNyX29zYzMyZW4pKQ0KPiANCj4gd291bGQgYmUgc2hv
cnRlciBhbmQgZWFzaWVyIHRvIHJlYWQgYW5kIHN0aWxsIGZpdHMgb24gb25lIGxpbmUuDQoNCkFn
cmVlLCBidXQgSSB0aG91Z2h0IHRvIHVzZSB0aGUgc2FtZSBpbnRlcmZhY2UgZXZlcnl3aGVyZS4g
QW55d2F5LCB0ZWxsIG1lDQppZiB5b3Ugd2FudCB0byByZXNlbmQgd2l0aCB0aGVzZSBjaGFuZ2Vz
Lg0KDQo+IA0K
