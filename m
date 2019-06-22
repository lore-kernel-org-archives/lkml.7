Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83687C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E57B20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3RgxQ9Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFVKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:19:01 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25576 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfFVKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:19:00 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="35446107"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2019 03:18:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Jun 2019 03:18:55 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 22 Jun 2019 03:18:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLMr2pStPLkl0RtmesXVD9kz3vOk36Y3smddQ88bobM=;
 b=3RgxQ9Cq3FOTYIPHxAYnVUq3eN2OdVRP5jXkho8WQaGWhSBRKfg3ehjcM2YO+ABzxjYHGX0uRbbXHSg4Eb54WnhRhxgGritKoA4WD2kgEqrJw2igM6kGXgEysdvdCSKvR2ZK7+tgp3sotUjMnhTrYhwQ9cLXcSmvbnRDgwnjKa4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1651.namprd11.prod.outlook.com (10.172.23.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Sat, 22 Jun 2019 10:18:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1987.017; Sat, 22 Jun 2019
 10:18:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugeniy.Paltsev@synopsys.com>, <linux-mtd@lists.infradead.org>,
        <marex@denx.de>
CC:     <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Alexey.Brodkin@synopsys.com>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Topic: [PATCH] mtd: spi-nor: add support for sst26wf016, sst26wf032
 memory
Thread-Index: AQHVHUfULV5f3c0l6EGHxaXBBI7PvaanjSsA
Date:   Sat, 22 Jun 2019 10:18:50 +0000
Message-ID: <aab6510e-9608-584e-1556-613bb0be482e@microchip.com>
References: <20190607154308.20899-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20190607154308.20899-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0010.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::20) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.138.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 075cfc71-2ec2-4429-a714-08d6f6fb0502
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1651;
x-ms-traffictypediagnostic: BN6PR11MB1651:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB1651835948A8A0C592D4A5C7F0E60@BN6PR11MB1651.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(110136005)(31696002)(99286004)(31686004)(8936002)(54906003)(6436002)(14444005)(2501003)(229853002)(186003)(256004)(36756003)(68736007)(81166006)(86362001)(316002)(102836004)(4326008)(76176011)(6306002)(6512007)(52116002)(81156014)(8676002)(71190400001)(6486002)(71200400001)(386003)(6506007)(53546011)(25786009)(305945005)(486006)(7736002)(446003)(53936002)(6246003)(14454004)(11346002)(5660300002)(2906002)(478600001)(72206003)(73956011)(66446008)(64756008)(66556008)(66946007)(66476007)(966005)(3846002)(6116002)(476003)(2616005)(66066001)(26005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1651;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +mTrpHpU7fU7wek0H96Zgdxj8Vp+7Nl7yQ9sKLatvhxHjFDrCm7RSmrt3FujznkqXtIbPeswdsVJvP6Y7+bZtulno5p3bsMnDwHQNCQdWxXB2FEpNvYLUmr9PO+roYe9zpiTPNtJROdUdIvAjci4qM4dy27gVwx18Nkopw2vKKYAZdO0uqjzMkxe4xPYsBqUqzRs3rP7SuWIzvbKoDPd204UWIDgw4T4V4THFHA7o2X/LMZv/6T+OaX8zQTRUfaEkwHMg4t6uRB1C5ALzOn/iF8tUq5AD46BKD9mqDO+c5au0dH4IiF+vbeGGYlmoBSjVXbqMAaS2J+Zy86otcUuJ18jgO13MYx/WZ2bPPE6Gwkj5n9kxao7lYtpKI5wYS7blUk229aTPQrkXmWCpR++9sn9KT7DcNYNvxhqyr6Quro=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C10A3D5626A1418BED5D9D21748518@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 075cfc71-2ec2-4429-a714-08d6f6fb0502
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 10:18:50.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEV1Z2VuaXksDQoNCk9uIDA2LzA3LzIwMTkgMDY6NDMgUE0sIEV1Z2VuaXkgUGFsdHNldiB3
cm90ZToNCj4gRXh0ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gVGhpcyBjb21taXQgYWRkcyBzdXBw
b3J0IGZvciB0aGUgU1NUIHNzdDI2d2YwMTYgYW5kIHNzdDI2d2YwMzINCj4gZmxhc2ggbWVtb3J5
IElDLg0KDQpQbGVhc2Ugc3BlY2lmeSBpZiB5b3UgdGVzdGVkIGJvdGggZmxhc2hlcywgd2l0aCAx
LTEtMSwgMS0xLTIgYW5kIDEtMS00IHJlYWRzLg0KTGV0IHVzIGtub3cgd2hpY2ggY29udHJvbGxl
ciB5b3UgdXNlZC4gSSBhc2sgZm9yIHRoZXNlIHRvIGJlIHN1cmUgdGhhdCB3ZSBkb24ndA0KYWRk
IGZsYXNoZXMgdGhhdCBhcmUgYnJva2VuIGZyb20gZGF5IG9uZS4NCg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMiArKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gaW5kZXgg
NzMxNzJkN2Y1MTJiLi4yMjQyNzU0NjFhMmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+
IEBAIC0xOTQ1LDYgKzE5NDUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3Bp
X25vcl9pZHNbXSA9IHsNCj4gIAl7ICJzc3QyNXdmMDQwYiIsIElORk8oMHg2MjE2MTMsIDAsIDY0
ICogMTAyNCwgIDgsIFNFQ1RfNEspIH0sDQo+ICAJeyAic3N0MjV3ZjA0MCIsICBJTkZPKDB4YmYy
NTA0LCAwLCA2NCAqIDEwMjQsICA4LCBTRUNUXzRLIHwgU1NUX1dSSVRFKSB9LA0KPiAgCXsgInNz
dDI1d2YwODAiLCAgSU5GTygweGJmMjUwNSwgMCwgNjQgKiAxMDI0LCAxNiwgU0VDVF80SyB8IFNT
VF9XUklURSkgfSwNCj4gKwl7ICJzc3QyNndmMDE2IiwgIElORk8oMHhiZjI2NTEsIDAsIDY0ICog
MTAyNCwgMzIsIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFE
KSB9LA0KDQpJIGNvbmZpcm0gdGhhdCB0aGUgYWJvdmUgaXMgY29ycmVjdC4NCg0KPiArCXsgInNz
dDI2d2YwMzIiLCAgSU5GTygweGJmMjYyMiwgMCwgNjQgKiAxMDI0LCA2NCwgU0VDVF80SyB8IFNQ
SV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQoNClRoZXJlIGFyZSBzc3Qy
NndmMDMyIGZsYXNoZXMgdGhhdCBkb24ndCBzdXBwb3J0IFNQSU5PUl9PUF9SRUFEXzFfMV8yICgw
eDNiKSBhbmQNClNQSU5PUl9PUF9SRUFEXzFfMV80ICgweDZiKSwgY2hlY2sNCmh0dHBzOi8vcGRm
MS5hbGxkYXRhc2hlZXQuY29tL2RhdGFzaGVldC1wZGYvdmlldy8zOTIwNjMvU1NUL1NTVDI2V0Yw
MzIuaHRtbC4gWW91DQpjYW4ndCBhZGQgU1BJX05PUl9EVUFMX1JFQUQgYW5kIFNQSV9OT1JfUVVB
RF9SRUFEIGlmIDB4M2IgYW5kIDB4NmIgY29tbWFuZHMgYXJlDQpub3Qgc3VwcG9ydGVkLiBDaGVj
ayBzcGlfbm9yX2luaXRfcGFyYW1zKCkuDQoNCkNoZWVycywNCnRhDQo=
