Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3905E20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="brOYLDEt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vcGS/kP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF1Tor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:44:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45370 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1Tor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561751110; x=1593287110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/RVJa912dr6WLsbEoVEPNY0bFG8sgSsTPvrW9GfhPaM=;
  b=brOYLDEtz6g+3eds3BskwiMQTSmvTtrzrjATmGFfhyje9vHfJK3DmH19
   QQjxZRlexx0RTvXWoeucUD9txiXFKeVuvBpC4k9quINdPPrd+RDc7RZAb
   Dz5+QTMZhaI9wz/wQ5dTlbw2JBQi0+9Q/n1VMFVmuUOTcaY79qT6AdxkT
   jFJBHfHtE4aqfcHvY3czxqeS/vp06mpCFHqVJ896fVJJXEBVfajJvuBP9
   MhyK4NAPnwSVu5WwlEmQtRaPh9Q3nbT0XeVaoC9WYVtMy0+UszDNtGDSn
   Uh4sB9daKnxj1+QrK49qLnJvRzDc2b8W4/icugYzteUs6jk+PMDemzUw2
   A==;
X-IronPort-AV: E=Sophos;i="5.63,428,1557158400"; 
   d="scan'208";a="211636843"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2019 03:45:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RVJa912dr6WLsbEoVEPNY0bFG8sgSsTPvrW9GfhPaM=;
 b=vcGS/kP1J9R8IAmBsquDLAh9+AVjf31jZ+nt/DrmLfcFPWsEJ/VMp4AUQk1f3mlc2R5GylFkraa4yhbpQRVzmhYW0fbWeGItwieXSBSaBYzzD5KHBQ+ToUz0g5BVO13mxClp9n9Ob60+iTk8sWy45CgiPL4ayStYcTLFJezu+3A=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5989.namprd04.prod.outlook.com (20.178.233.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 19:44:43 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 19:44:43 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "trini@konsulko.com" <trini@konsulko.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "merker@debian.org" <merker@debian.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4] RISC-V: Add an Image header that boot loader can
 parse.
Thread-Topic: [PATCH v4] RISC-V: Add an Image header that boot loader can
 parse.
Thread-Index: AQHVHLzHT4YK2HktEU6wLZ3FpbqNK6axkG0AgAAJ9IA=
Date:   Fri, 28 Jun 2019 19:44:43 +0000
Message-ID: <c0bdc25bc3aee9eee8bf9ebe561900b88df0540b.camel@wdc.com>
References: <20190606230800.19932-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1906281207290.3867@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906281207290.3867@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f850754-ae51-494f-143e-08d6fc01116a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5989;
x-ms-traffictypediagnostic: BYAPR04MB5989:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB59899C20B999F2D0203EED12FAFC0@BYAPR04MB5989.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(54906003)(316002)(25786009)(6246003)(6916009)(71200400001)(53936002)(5660300002)(71190400001)(4326008)(81166006)(81156014)(2501003)(102836004)(229853002)(8676002)(6306002)(6512007)(6506007)(8936002)(26005)(76176011)(7736002)(68736007)(305945005)(86362001)(118296001)(186003)(99286004)(36756003)(6116002)(72206003)(66066001)(478600001)(76116006)(66946007)(2616005)(66476007)(73956011)(11346002)(476003)(3846002)(446003)(2906002)(256004)(66446008)(66556008)(7416002)(64756008)(486006)(966005)(6486002)(5640700003)(6436002)(14454004)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5989;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: llIc0JbXUX5OASelvZPVxK7PyaVv9VZ9vnP1aai++RT2Z7waDdDo29XIOHo4ziMzx1gPxGn/GtB7UihaHl8xZCKzWg/IXMDF6jYyVlWuymnBIXiKSN7JalTlcQtO4EpaCburAiYy244+re8HR0kosMOzpZZQNqgix+tmlA/JgLfHpchNh7TH4Tf4FDev4Bv0P6CRAV9uwgLP90ZyitnNIDIoF2c9ZaBXCzF79t+Dy6nGTWkJ9mZZU65+tWJP3KDDYKlcbOUBWV3V4zjeYO57m3mzGtxRcAR0/JgcxZbvBA2l/WANkU/redCjqhOB1Fsz3fv9glrtavdHVkz/ezFQAgfEVjiqNBAk7zD8cFQedhe9M8BA1Z9wDrikSKGK6ppRHof/RH3eqF3h/w33a9an98MqHBc3xZTRZFNATCNesFk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1572903D129304EB588DB11188C72EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f850754-ae51-494f-143e-08d6fc01116a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 19:44:43.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA2LTI4IGF0IDEyOjA5IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBUaHUsIDYgSnVuIDIwMTksIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiANCj4gPiBDdXJyZW50
bHksIHRoZSBsYXN0IHN0YWdlIGJvb3QgbG9hZGVycyBzdWNoIGFzIFUtQm9vdCBjYW4gYWNjZXB0
DQo+ID4gb25seQ0KPiA+IHVJbWFnZSB3aGljaCBpcyBhbiB1bm5lY2Vzc2FyeSBhZGRpdGlvbmFs
IHN0ZXAgaW4gYXV0b21hdGluZyBib290DQo+ID4gcHJvY2Vzcy4NCj4gPiANCj4gPiBBZGQgYW4g
aW1hZ2UgaGVhZGVyIHRoYXQgYm9vdCBsb2FkZXIgdW5kZXJzdGFuZHMgYW5kIGJvb3QgTGludXgN
Cj4gPiBmcm9tDQo+ID4gZmxhdCBJbWFnZSBkaXJlY3RseS4NCj4gDQo+IC4uLg0KPiANCj4gDQo+
ID4gKyNpZiBfX3Jpc2N2X3hsZW4gPT0gNjQNCj4gPiArCS8qIEltYWdlIGxvYWQgb2Zmc2V0KDJN
QikgZnJvbSBzdGFydCBvZiBSQU0gKi8NCj4gPiArCS5kd29yZCAweDIwMDAwMA0KPiA+ICsjZWxz
ZQ0KPiA+ICsJLyogSW1hZ2UgbG9hZCBvZmZzZXQoNE1CKSBmcm9tIHN0YXJ0IG9mIFJBTSAqLw0K
PiA+ICsJLmR3b3JkIDB4NDAwMDAwDQo+ID4gKyNlbmRpZg0KPiANCj4gSXMgdGhlcmUgYSByYXRp
b25hbGUgYmVoaW5kIHRoZXNlIGxvYWQgb2Zmc2V0IHZhbHVlcz8NCj4gDQoNCjJNQi80TUIgYWxp
Z25tZW50IHJlcXVpcmVtZW50IGlzIG1hbmRhdG9yeSBmb3IgY3VycmVudCBSSVNDLVYga2VybmVs
Lg0KQW51cCBoYWQgYSBwYXRjaCB0aGF0IHRyaWVkIHRvIHJlbW92ZSB0aGF0IGJ1dCBub3QgYWNj
ZXB0ZWQgeWV0Lg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwODY4NDY1
Lw0KDQoNCj4gDQo+IC0gUGF1bA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJp
c2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
