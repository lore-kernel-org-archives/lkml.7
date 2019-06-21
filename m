Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB927C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447F2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z19qVwO1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o26EfRG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFUV7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:59:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43693 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561154369; x=1592690369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iOeMgtPuKdHHp3Gj75vrS+FljHMJyjkSg9MW3eosJKI=;
  b=Z19qVwO1YHaEInRpkjlq21+c76mUoALiJh5t1QR0y6Nna58UVh7d7w54
   T06PJRbQeRDIcHlEl1goqWMZpFvSmbAtelUX3msH3gZKg3CdoUIv+axNJ
   MmVgcTsyPPFQPyS+2xM0UUcZnYOzUqqcD1gGaa+MGyrXLhrIejyvfJBrx
   TLU2gHMBfzCtZQpA+iRyOeNCRkMjCR90huJOcQeE10q/uE8QXVUXCbOne
   dttdt8vK25adqRHkFt33eQXKyhKiECoVXYnnTdHrBvtQYgZTefSdAViBm
   CIittWr37NxGNdsDQW2qWnemkZdp8+wn7Eip+OdJmXCWHaDu/wY1eU484
   w==;
X-IronPort-AV: E=Sophos;i="5.63,402,1557158400"; 
   d="scan'208";a="111179228"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 05:59:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOeMgtPuKdHHp3Gj75vrS+FljHMJyjkSg9MW3eosJKI=;
 b=o26EfRG2vlpSzAPTfU+R0Kw1K3HagHl3nlYmGu7bcI6dIucTmYElx310BvV/+AOBY1OGqJE0rEwnq3gWF5kTJJmYRXQs2FtryUxl+9L0xsESl0Lrbb9pBU8snoB8ch1wMaaNM/IuoRE+lPlj1XL764yVKMuEHa6yDgLEVQQfjV8=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4471.namprd04.prod.outlook.com (52.135.237.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Fri, 21 Jun 2019 21:59:26 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 21:59:26 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "troy.benjegerdes@sifive.com" <troy.benjegerdes@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "sachin.ghadi@sifive.com" <sachin.ghadi@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yash.shah@sifive.com" <yash.shah@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
Thread-Topic: [PATCH v2] riscv: dts: Add DT node for SiFive FU540 Ethernet
 controller driver
Thread-Index: AQHVKCA1s3Kn2VpoYUKwjMwaF74JUaametQAgAABOwCAAClhAIAAA3wA
Date:   Fri, 21 Jun 2019 21:59:26 +0000
Message-ID: <43da99709709d2a480b78f25356cda9255205372.camel@wdc.com>
References: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
         <1561114429-29612-2-git-send-email-yash.shah@sifive.com>
         <18c7992607dd1fed062bd295ac0738a759eff078.camel@wdc.com>
         <CAF5mof3QB8C7VjOyEvCsf9NEDkJhV3cBO5sBD+8z-GrWrnrAyg@mail.gmail.com>
         <3f91c8032e113a19dcec10ca71b017af1427ef7e.camel@wdc.com>
In-Reply-To: <3f91c8032e113a19dcec10ca71b017af1427ef7e.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 196fe958-7585-4908-8648-08d6f693ba50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4471;
x-ms-traffictypediagnostic: BYAPR04MB4471:
x-ms-exchange-purlcount: 3
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB44714C1281D03C65A3A2879BFAE70@BYAPR04MB4471.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(26005)(68736007)(66946007)(86362001)(14444005)(186003)(76176011)(2351001)(305945005)(476003)(6506007)(2616005)(7736002)(66066001)(966005)(66446008)(14454004)(66556008)(64756008)(486006)(72206003)(76116006)(66476007)(8676002)(81156014)(73956011)(8936002)(71200400001)(81166006)(478600001)(5660300002)(6916009)(2906002)(3846002)(4326008)(99286004)(25786009)(6116002)(5640700003)(6436002)(229853002)(256004)(54906003)(6246003)(316002)(71190400001)(36756003)(118296001)(6512007)(102836004)(53936002)(446003)(5024004)(11346002)(7416002)(2501003)(6306002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4471;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 89QSf4qlqjoU3XNf5agDwrD2G4cHCNuxXdAigCBdXchT6tomZyEXOVnKBGgIxI7csa/VInXOBJAdlZHEWSo/LePMrzUghLE6RtkukuH/M7G7YuTktd5dN8bHRVsJVjkssHj1JSNwH0dpd6NSjBwm1/b06X47AySYOTwsKKEG982MIv3QDUktFOdQ7HJkR2IkxkLCHCFxkKWH6v9hUd7CA2aQAIx8m6sjQ3J1khL56p5RxaE2uErfx8cysel6VKnjyqb6JBKfnH5hH4Dgm5BKnGTmZq3ESSdAeQbUrC6mGkpNGdD9JV4ZGVG6lifPYx3Ntp+9w//A15i10aGO1oI2EDwMha6ooCKhw02PxKtbD6c64Z7TIPYE2lSDa/DQUtswAmE/tpEmq5uHBTtYOtHITKNIXZdryGy9ULNXLXsZAQA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9208840D07144E8976D72F4B6703FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196fe958-7585-4908-8648-08d6f693ba50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 21:59:26.4859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTIxIGF0IDE0OjQ2IC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4g
T24gRnJpLCAyMDE5LTA2LTIxIGF0IDE0OjE4IC0wNTAwLCBUcm95IEJlbmplZ2VyZGVzIHdyb3Rl
Og0KPiA+IENhbiB5b3UgcG9zdCB0aGUgZnNibCBhbmQgb3RoZXIgaW1hZ2VzIHlvdSB1c2VkIHRv
IGJvb3QvdGVzdCB0aGlzPw0KPiA+IA0KPiANCg0KUmVzZW5kaW5nIGl0IHdpdGhvdXQgdGhlIGF0
dGFjaG1lbnQuIE9idmlvdXNseSwgdGhlIG1haWwgZGlkIG5vdCBnbw0KdGhyb3VnaCB3aXRoIHRo
ZSBiaW5hcnkgYmxvYiBhdHRhY2hlZCA6KCA6KC4gTXkgYmFkLg0KDQpMZXQgbWUga25vdyBpZiB5
b3Ugc3RpbGwgd2FudCBtZSB0byBzaGFyZSB0aGUgYmluYXJ5IHdpdGggeW91LiBJIHdpbGwNCnBy
b2JhYmx5IHNoYXJlIGl0IHZpYSBzb21lIG90aGVyIG1ldGhvZC4NCg0KPiBJIGhhdmUgbm90IGNo
YW5nZWQgZnNibC4gSXQncyB0aGUgZGVmYXVsdCBvbmUgY2FtZSB3aXRoIHRoZSBib2FyZC4NCj4g
SGVyZSBhcmUgdGhlIGhlYWRzIG9mIE9wZW5TQkkgKyBVLUJvb3QgKyBMaW51eCByZXBvLg0KPiAN
Cj4gT3BlblNCSTogY2QyZGZkYzg3MGVkIChtYXN0ZXIpDQo+IFUtYm9vdDogNzdmNmUyZGQwNTUx
ICsgQW51cCdzIHBhdGNoIHNlcmllcyAodjQpDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hdGlzaHAw
NC91LWJvb3QvdHJlZS91bmxlYXNoZWRfd29ya2luZw0KPiANCj4gTGludXg6IGJlZDNjMGQ4NGU3
ZSArIFlhc2gncyBNYWNiIFNlcmllcyArIHRoaXMgcGF0Y2gNCj4gaHR0cHM6Ly9naXRodWIuY29t
L2F0aXNocDA0L2xpbnV4L3RyZWUvNS4yLXJjNi1wcmUNCj4gDQo+IEkgaGF2ZSBhbHNvIGF0dGFj
aGVkIHRoZSBPcGVuU0JJICsgVS1ib290IGJpbmFyeSBhcyB3ZWxsLiBCdXQgdGhpcyBpcw0KPiBw
cmUtY29uZmlndXJlZCB3aXRoIG15IHRmdHBib290IHNlcnZlci4gWW91IG5lZWQgdG8gY2hhbmdl
IHRoYXQuDQo+IA0KPiA+IEkga2VlcCBydW5uaW5nIGludG8gdmFyaW91cyBmYWlsdXJlcyB3aGVu
IEkgYnVpbGQgZnJvbSBzb3VyY2UgYW5kIEkNCj4gPiB3YW50IHRvIHJ1bGUgb3V0IHBvdGVudGlh
bCBoYXJkd2FyZSBpc3N1ZXMgcmVsYXRlZCB0byBjbG9jayBhbmQvb3INCj4gPiBkZHIgaW5pdGlh
bGl6YXRpb24NCj4gPiANCj4gPiBPbiBGcmksIEp1biAyMSwgMjAxOSwgMjoxNCBQTSBBdGlzaCBQ
YXRyYSA8QXRpc2guUGF0cmFAd2RjLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMjAx
OS0wNi0yMSBhdCAxNjoyMyArMDUzMCwgWWFzaCBTaGFoIHdyb3RlOg0KPiA+ID4gPiBEVCBub2Rl
IGZvciBTaUZpdmUgRlU1NDAtQzAwMCBHRU1HWEwgRXRoZXJuZXQgY29udHJvbGxlciBkcml2ZXIN
Cj4gPiA+IGFkZGVkDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhc2ggU2hhaCA8eWFzaC5zaGFo
QHNpZml2ZS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9z
aWZpdmUvZnU1NDAtYzAwMC5kdHNpICAgICAgICAgIHwgMTYNCj4gPiA+ID4gKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiAgYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZlLXVubGVhc2hl
ZC1hMDAuZHRzIHwgIDkNCj4gPiA+ICsrKysrKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9ib290L2R0cy9zaWZpdmUvZnU1NDAtYzAwMC5kdHNpDQo+ID4gPiA+IGIvYXJjaC9yaXNj
di9ib290L2R0cy9zaWZpdmUvZnU1NDAtYzAwMC5kdHNpDQo+ID4gPiA+IGluZGV4IDRlOGZiZGUu
LmM1M2I0ZWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZl
L2Z1NTQwLWMwMDAuZHRzaQ0KPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2
ZS9mdTU0MC1jMDAwLmR0c2kNCj4gPiA+ID4gQEAgLTIyNSw1ICsyMjUsMjEgQEANCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gPiA+ICAgICAgICAgICAg
ICAgfTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBldGgwOiBldGhlcm5ldEAxMDA5MDAwMCB7DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1t
YWNiIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8
JnBsaWMwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8NTM+
Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDEwMDkwMDAwIDB4
MCAweDIwMDANCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAweDAgMHgxMDBh
MDAwMCAweDAgMHgxMDAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1l
cyA9ICJjb250cm9sIjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBsb2NhbC1tYWMtYWRkcmVz
cyA9IFswMCAwMCAwMCAwMCAwMCAwMF07DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBj
bG9jay1uYW1lcyA9ICJwY2xrIiwgImhjbGsiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgY2xvY2tzID0gPCZwcmNpIFBSQ0lfQ0xLX0dFTUdYTFBMTD4sDQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8JnByY2kgUFJDSV9DTEtfR0VNR1hMUExMPjsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICB9Ow0KPiA+ID4gPiAgfTsNCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2hpZml2ZS11bmxlYXNo
ZWQtDQo+ID4gPiA+IGEwMC5kdHMNCj4gPiA+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2
ZS9oaWZpdmUtdW5sZWFzaGVkLWEwMC5kdHMNCj4gPiA+ID4gaW5kZXggNGRhODg3MC4uZDc4M2Jm
MiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZl
LXVubGVhc2hlZC1hMDAuZHRzDQo+ID4gPiA+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lm
aXZlL2hpZml2ZS11bmxlYXNoZWQtYTAwLmR0cw0KPiA+ID4gPiBAQCAtNjMsMyArNjMsMTIgQEAN
Cj4gPiA+ID4gICAgICAgICAgICAgICBkaXNhYmxlLXdwOw0KPiA+ID4gPiAgICAgICB9Ow0KPiA+
ID4gPiAgfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArJmV0aDAgew0KPiA+ID4gPiArICAgICBzdGF0
dXMgPSAib2theSI7DQo+ID4gPiA+ICsgICAgIHBoeS1tb2RlID0gImdtaWkiOw0KPiA+ID4gPiAr
ICAgICBwaHktaGFuZGxlID0gPCZwaHkxPjsNCj4gPiA+ID4gKyAgICAgcGh5MTogZXRoZXJuZXQt
cGh5QDAgew0KPiA+ID4gPiArICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4gPiA+ID4gKyAgICAg
fTsNCj4gPiA+ID4gK307DQo+ID4gPiANCj4gPiA+IFRoYW5rcy4gSSBhbSBhYmxlIHRvIGJvb3Qg
VW5sZWFzaGVkIHdpdGggbmV0d29ya2luZyBlbmFibGVkIHdpdGgNCj4gPiA+IHRoaXMNCj4gPiA+
IHBhdGNoLg0KPiA+ID4gDQo+ID4gPiBGV0lXLCANCj4gPiA+IFRlc3RlZC1ieTogQXRpc2ggUGF0
cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBB
dGlzaA0KPiA+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gPiA+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiA+ID4gbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1yaXNjdg0K
