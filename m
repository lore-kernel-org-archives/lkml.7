Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBBAC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243002064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="JW18wGDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgAGDzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:55:55 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:40704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbgAGDzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:55:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrXOmojJrxh61paJIRPYicWhtCaSyhodJ/LO0YPGnHewrcwgqImwGf9IrfCpWAuhJBwidxVbIlSchpAp8/WVkH0VyLdOBnTaJCfNNknKiAz40oaPpMsNV0qxNQgbQ7Nv/k5atvJyy/RMrtBWlM2hbJPSmTprzQImgJuXD/TVHvyWKSdh32769ZjFvFQ+V8v0zniVl52cJQMrK9FcXOXl6zqv2yDKvk4e5YZ0SzeTMwrxbDq1l5J0oLnXTn0BmE8BoO3lqh8zsqxYaVfbRqnnmclwoFIOv4DFHPbn8AnQJ/Zfwu8hRXwqPAo10IrvOrFuHSTN+e0RBFx9p+1N7iqQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcF8IYQV/p+3Mw01DxDjOJz0cPFS+5OiYKdA5/8RNWU=;
 b=mKATzE4hOymqM+O2elXmcsnsPeBLoAf/RTlBdnURxhVhoIOsJrxYV3ON8hmRp84MY0Pyybiw6iWqhc3vJRyZqS1joarKzBBH88EzXFWCaqiqEKOGr0Bi1d9bWAaMZyPyT6Jd56hBEgPcbI+ghLgQoNzKavLWUy+AAUfMBKPCvVGBQ8YC3DcKJ1I58cwvUoeE8vGeUAHLCe1omKNfYgabYFgZRB3/O1655J25SPoNGb4cBoTa8tYUuLd+PLkitY3FwGCpGMzTYpKiBfZrV12xhLP6+D5vST4QPvsNTbik8gH4h+U7FM1cGgT6j02venGJa53UzC/8pdAe/PVEKn8U2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcF8IYQV/p+3Mw01DxDjOJz0cPFS+5OiYKdA5/8RNWU=;
 b=JW18wGDISo3gON6yxR7UJsntPRk7m2eH1cWAjvx+k8Htdv4nc0tsTO/ti6DCB9rX1H3G45NgWWEgy8l8rmj1+o0YWZ55ew8KdPDV2eJnuv+w436QviZZo3m96lX8BFXL+e40NlAWF/gFamBy5NnJcMnPiiRrEt+6Wks1HvVOMeQ=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2SPR01MB0023.namprd13.prod.outlook.com (20.180.14.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Tue, 7 Jan 2020 03:55:49 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2623.008; Tue, 7 Jan 2020
 03:55:49 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bin Meng <bmeng.cn@gmail.com>,
        Green Wan <green.wan@sifive.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: RE: [PATCH v2 2/2] riscv: cacheinfo: Add support to determine no. of
 L2 cache way enabled
Thread-Topic: [PATCH v2 2/2] riscv: cacheinfo: Add support to determine no. of
 L2 cache way enabled
Thread-Index: AQHVwew4Uxrz+iLoAkGC7gaBkWkw+qfdXmOAgAE5Y/A=
Date:   Tue, 7 Jan 2020 03:55:49 +0000
Message-ID: <CH2PR13MB3368C0B3E991478BDA7665578C3F0@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
 <1578024801-39039-3-git-send-email-yash.shah@sifive.com>
 <CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-Z_FaOr8LPni+s_615Q@mail.gmail.com>
In-Reply-To: <CAAhSdy0CXde5s_ya=4YvmA4UQ5f5gLU-Z_FaOr8LPni+s_615Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54248c7f-ba2d-4654-26b7-08d793257be8
x-ms-traffictypediagnostic: CH2SPR01MB0023:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2SPR01MB00238F473A731DAEEDBF03128C3F0@CH2SPR01MB0023.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(136003)(376002)(366004)(13464003)(199004)(189003)(2906002)(107886003)(54906003)(186003)(9686003)(316002)(6506007)(55016002)(26005)(76116006)(53546011)(66556008)(52536014)(66446008)(7416002)(86362001)(81156014)(4326008)(64756008)(66946007)(478600001)(81166006)(66476007)(44832011)(8936002)(8676002)(5660300002)(6916009)(33656002)(71200400001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2SPR01MB0023;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKWswHRpy+8xtmPQ6auYlMt65Vgvm8tHblCbmBfSJTO9INn9bPYBFuh7Hu3stH9xmnYCEZyeDH3cN54OGA7hZssIbGFqilgay9ReYIUbBy1NZpPi103YsfRY2DVkGSWuyf7BWmgBhT4npeo0tu4U0unoq0bAieaxtXimIKBXwjPC+SVDZPIZDrO04GkflSj7R/jmHqmxWgOKxliyiAUzxjljwMazQAsbwaKoK4eT9iJyACrIwnA3BMJ3TMSt1gm30R9xnzYZvqAuiPkq0G/PAOgkoPSADoAbM/R6tN/CTZz19KplUEXndViUeCovGL/DoRw0pQ9HDa3HvzDAHddiSpmd8fjRUMYVN51icAbine0LnUnpDU6w12Q66Ckr8BGUEUb0mpH4YdxUNt0zygRCDQs51XtTp3ANDg37R3OO5BEJotSEjtj9+aV/PY+UaDpIDSiywSSfLQ4smeVswXON8S3eEry83e0viJCFKzO3czIxKV+9NmFq8McBNRK6gPrT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54248c7f-ba2d-4654-26b7-08d793257be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 03:55:49.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w558/QEeYpY/nDv/mNQBZ8/2D0XWCx8o5hESXSd4JBuQc5F6YN3Ya2JT8d56UsGAgjo1picJCNUqrH8F2VIlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2SPR01MB0023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW51cCBQYXRlbCA8YW51
cEBicmFpbmZhdWx0Lm9yZz4NCj4gU2VudDogMDYgSmFudWFyeSAyMDIwIDE0OjQwDQo+IFRvOiBZ
YXNoIFNoYWggPHlhc2guc2hhaEBzaWZpdmUuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBQ
YXVsIFdhbG1zbGV5ICggU2lmaXZlKQ0KPiA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsgUGFs
bWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+IEFsYmVydCBPdSA8YW91QGVlY3Mu
YmVya2VsZXkuZWR1PjsgQmluIE1lbmcgPGJtZW5nLmNuQGdtYWlsLmNvbT47DQo+IEdyZWVuIFdh
biA8Z3JlZW4ud2FuQHNpZml2ZS5jb20+OyBBbGxpc29uIFJhbmRhbCA8YWxsaXNvbkBsb2h1dG9r
Lm5ldD47DQo+IEFsZXhpb3MgWmF2cmFzIDxhbGV4aW9zLnphdnJhc0BpbnRlbC5jb20+OyBHcmVn
IEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Ow0KPiBicEBzdXNlLmRlOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtcmlzY3YgPGxpbnV4LQ0KPiByaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyBMaXN0IDxsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IFNhY2hpbiBHaGFkaSA8c2FjaGluLmdoYWRpQHNpZml2ZS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSByaXNjdjogY2FjaGVpbmZvOiBBZGQg
c3VwcG9ydCB0byBkZXRlcm1pbmUgbm8uIG9mDQo+IEwyIGNhY2hlIHdheSBlbmFibGVkDQo+IA0K
PiBPbiBGcmksIEphbiAzLCAyMDIwIGF0IDk6NDQgQU0gWWFzaCBTaGFoIDx5YXNoLnNoYWhAc2lm
aXZlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBvcmRlciB0byBkZXRlcm1pbmUgdGhlIG51bWJl
ciBvZiBMMiBjYWNoZSB3YXlzIGVuYWJsZWQgYXQgcnVudGltZSwNCj4gPiBpbXBsZW1lbnQgYSBw
cml2YXRlIGF0dHJpYnV0ZSB1c2luZyBjYWNoZV9nZXRfcHJpdl9ncm91cCgpIGluDQo+ID4gY2Fj
aGVpbmZvIGZyYW1ld29yay4gUmVhZGluZyB0aGlzIGF0dHJpYnV0ZQ0KPiAoIm51bWJlcl9vZl93
YXlzX2VuYWJsZWQiKQ0KPiA+IHdpbGwgcmV0dXJuIHRoZSBudW1iZXIgb2YgZW5hYmxlZCBMMiBj
YWNoZSB3YXlzIGF0IHJ1bnRpbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYXNoIFNoYWgg
PHlhc2guc2hhaEBzaWZpdmUuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3NpZml2ZV9sMl9jYWNoZS5oIHwgIDIgKysNCj4gPiAgYXJjaC9yaXNjdi9rZXJuZWwvY2Fj
aGVpbmZvLmMgICAgICAgICAgICB8IDMxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5jICAgICB8ICA1ICsr
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2lmaXZlX2wyX2NhY2hlLmgNCj4gPiBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2lmaXZlX2wyX2NhY2hlLmgNCj4gPiBpbmRleCAwNGY2
NzQ4Li4yMTdhNDJmIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2lm
aXZlX2wyX2NhY2hlLmgNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NpZml2ZV9s
Ml9jYWNoZS5oDQo+ID4gQEAgLTEwLDYgKzEwLDggQEANCj4gPiAgZXh0ZXJuIGludCByZWdpc3Rl
cl9zaWZpdmVfbDJfZXJyb3Jfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrDQo+ID4gKm5i
KTsgIGV4dGVybiBpbnQgdW5yZWdpc3Rlcl9zaWZpdmVfbDJfZXJyb3Jfbm90aWZpZXIoc3RydWN0
DQo+ID4gbm90aWZpZXJfYmxvY2sgKm5iKTsNCj4gPg0KPiA+ICtpbnQgc2lmaXZlX2wyX2xhcmdl
c3Rfd2F5ZW5hYmxlZCh2b2lkKTsNCj4gPiArDQo+ID4gICNkZWZpbmUgU0lGSVZFX0wyX0VSUl9U
WVBFX0NFIDANCj4gPiAgI2RlZmluZSBTSUZJVkVfTDJfRVJSX1RZUEVfVUUgMQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NhY2hlaW5mby5jDQo+ID4gYi9hcmNoL3Jp
c2N2L2tlcm5lbC9jYWNoZWluZm8uYyBpbmRleCA0YzkwYzA3Li4yOWJkYjIxIDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NhY2hlaW5mby5jDQo+ID4gKysrIGIvYXJjaC9yaXNj
di9rZXJuZWwvY2FjaGVpbmZvLmMNCj4gPiBAQCAtNyw2ICs3LDcgQEANCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L2NwdS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL3NpZml2ZV9sMl9jYWNoZS5o
Pg0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGNpX2xlYWZfaW5pdChzdHJ1Y3QgY2FjaGVpbmZvICp0
aGlzX2xlYWYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSwgQEAgLTE2LDYgKzE3LDM2IEBADQo+ID4gc3RhdGljIHZvaWQgY2lfbGVhZl9pbml0
KHN0cnVjdCBjYWNoZWluZm8gKnRoaXNfbGVhZiwNCj4gPiAgICAgICAgIHRoaXNfbGVhZi0+dHlw
ZSA9IHR5cGU7DQo+ID4gIH0NCj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHX1NJRklWRV9MMg0KPiA+
ICtzdGF0aWMgc3NpemVfdCBudW1iZXJfb2Zfd2F5c19lbmFibGVkX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2hhciAqYnVmKSB7DQo+ID4gKyAgICAgICByZXR1cm4gc3By
aW50ZihidWYsICIldVxuIiwgc2lmaXZlX2wyX2xhcmdlc3Rfd2F5ZW5hYmxlZCgpKTsgfQ0KPiA+
ICsNCj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JPKG51bWJlcl9vZl93YXlzX2VuYWJsZWQpOw0K
PiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnByaXZfYXR0cnNbXSA9IHsNCj4g
PiArICAgICAgICZkZXZfYXR0cl9udW1iZXJfb2Zfd2F5c19lbmFibGVkLmF0dHIsDQo+ID4gKyAg
ICAgICBOVUxMLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgcHJpdl9hdHRyX2dyb3VwID0gew0KPiA+ICsgICAgICAgLmF0dHJzID0gcHJp
dl9hdHRycywNCj4gPiArfTsNCj4gPiArDQo+ID4gK2NvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3Jv
dXAgKg0KPiA+ICtjYWNoZV9nZXRfcHJpdl9ncm91cChzdHJ1Y3QgY2FjaGVpbmZvICp0aGlzX2xl
YWYpIHsNCj4gPiArICAgICAgIC8qIFdlIHdhbnQgdG8gdXNlIHByaXZhdGUgZ3JvdXAgZm9yIEwy
IGNhY2hlIG9ubHkgKi8NCj4gPiArICAgICAgIGlmICh0aGlzX2xlYWYtPmxldmVsID09IDIpDQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiAmcHJpdl9hdHRyX2dyb3VwOw0KPiA+ICsgICAgICAg
ZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArfQ0KPiA+ICsjZW5k
aWYgLyogQ09ORklHX1NJRklWRV9MMiAqLw0KPiA+ICsNCj4gDQo+IEluc3RlYWQgb2YgdGhpcywg
SSB3b3VsZCBzdWdnZXN0IHRvIGltcGxlbWVudCBhIGdlbmVyaWMgb3BzIHN0cnVjdHVyZS4NCj4g
DQo+IEluIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVpbmZvLmg6DQo+IA0KPiBzdHJ1Y3Qg
cmlzY3ZfY2FjZWluZm9fb3BzIHsNCj4gICAgIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAg
KiAoKmdldF9wcml2X2dyb3VwKShzdHJ1Y3QgY2FjaGVpbmZvDQo+ICp0aGlzX2xlYWYpOyB9Ow0K
PiANCj4gdm9pZCByaXNjdl9zZXRfY2FjaGVpbmZvX29wcyhzdHJ1Y3QgcmlzY3ZfY2FjZWluZm9f
b3BzICpvcHMpOw0KPiANCj4gSW4gYXJjaC9yaXNjdi9yaXNjdi9rZXJuZWwvY2FjaGVpbmZvLmgN
Cj4gDQo+IHN0YXRpYyBzdHJ1Y3QgcmlzY3ZfY2FjZWluZm9fb3BzICpydl9jYWNoZV9vcHM7DQo+
IA0KPiB2b2lkIHJpc2N2X3NldF9jYWNoZWluZm9fb3BzKHN0cnVjdCByaXNjdl9jYWNlaW5mb19v
cHMgKm9wcykgew0KPiAgICAgcnZfY2FjaGVfb3BzID0gb3BzOw0KPiB9DQo+IEVYUE9SVF9TWU1C
T0xfR1BMKHJpc2N2X3NldF9jYWNoZWluZm9fb3BzKTsNCj4gDQo+IGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgKg0KPiBjYWNoZV9nZXRfcHJpdl9ncm91cChzdHJ1Y3QgY2FjaGVpbmZvICp0
aGlzX2xlYWYpIHsNCj4gICAgIGlmIChydl9jYWNoZV9vcHMgJiYgcnZfY2FjaGVfb3BzLT5nZXRf
cHJpdl9ncm91cCkNCj4gICAgICAgICByZXR1cm4gcnZfY2FjaGVfb3BzLT5nZXRfcHJpdl9ncm91
cCh0aGlzX2xlYWYpDQo+ICAgICByZXR1cm4gTlVMTDsNCj4gfQ0KPiANCj4gQWJvdmUgd2lsbCBi
ZSBhIHNlcGFyYXRlIHBhdGNoLiBJbiBmdXR1cmUsIHdlIGNhbiBhZGQgbW9yZSBvcHMgZm9yIFNP
Qw0KPiBzcGVjaWZpYyBjYWNoZWluZm8uDQo+IA0KPiBVc2luZyByaXNjdl9zZXRfY2FjaGVpbmZv
X29wcygpIHlvdSBjYW4gaGF2ZSBhbm90aGVyIHBhdGNoIHRvIGltcGxlbWVudA0KPiBTaUZpdmUg
TDIgaW5mbyBlbnRpcmVseSBpbiBkcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMN
Cj4gDQoNClllcyBJIGFncmVlLCB0aGUgYWJvdmUgYXBwcm9hY2ggaXMgYmV0dGVyLiBXaWxsIHdv
cmsgb24gdGhpcyBhcHByb2FjaCBhbmQgc2VuZCBuZXcgcGF0Y2hlcy4NCg0KPiBBbHNvLCBJIHdv
dWxkIHN0cm9uZ2x5IHJlY29tbWVuZCBtb3ZpbmcNCj4gYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9z
aWZpdmVfbDJfY2FjaGUuaA0KPiBUTw0KPiBpbmNsdWRlL3NvYy9zaWZpdmUvc2lmaXZlX2wyX2Nh
Y2hlLmgNCg0KU3VyZSwgd2lsbCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMuDQoNCj4g
DQo+ID4gIHN0YXRpYyBpbnQgX19pbml0X2NhY2hlX2xldmVsKHVuc2lnbmVkIGludCBjcHUpICB7
DQo+ID4gICAgICAgICBzdHJ1Y3QgY3B1X2NhY2hlaW5mbyAqdGhpc19jcHVfY2kgPSBnZXRfY3B1
X2NhY2hlaW5mbyhjcHUpOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9zaWZpdmUvc2lm
aXZlX2wyX2NhY2hlLmMNCj4gPiBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfbDJfY2FjaGUu
Yw0KPiA+IGluZGV4IGE5ZmZmZjMuLmYxYTVmMmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9z
b2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2Mvc2lmaXZl
L3NpZml2ZV9sMl9jYWNoZS5jDQo+ID4gQEAgLTEwNyw2ICsxMDcsMTEgQEAgaW50IHVucmVnaXN0
ZXJfc2lmaXZlX2wyX2Vycm9yX25vdGlmaWVyKHN0cnVjdA0KPiA+IG5vdGlmaWVyX2Jsb2NrICpu
YikgIH0NCj4gPiBFWFBPUlRfU1lNQk9MX0dQTCh1bnJlZ2lzdGVyX3NpZml2ZV9sMl9lcnJvcl9u
b3RpZmllcik7DQo+ID4NCj4gPiAraW50IHNpZml2ZV9sMl9sYXJnZXN0X3dheWVuYWJsZWQodm9p
ZCkNCj4gPiArew0KPiA+ICsgICAgICAgcmV0dXJuIHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJf
V0FZRU5BQkxFKTsgfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGlycXJldHVybl90IGwyX2ludF9oYW5k
bGVyKGludCBpcnEsIHZvaWQgKmRldmljZSkgIHsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBh
ZGRfaCwgYWRkX2w7DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+IA0KPiBSZWdhcmRzLA0KPiBB
bnVwDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cw0KDQotIFlhc2gNCg==
