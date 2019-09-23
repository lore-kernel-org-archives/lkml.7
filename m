Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5EC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4306C20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="vlwJQRxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfIWJLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:11:51 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com ([40.107.4.114]:12967
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfIWJLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8BCZtGcLuJQbCsAocpVC47suFg7xFCE55qna49lP9OkTu/Ms68IokXdjo65N+j+lpu/DgAQYKFZeSCHdvsX3TwRGJ8EIq9o6uy3kIfLysFSm4z89knf2nXgWR5bdpw6gg0DDwyALLS1zE/ysS+twqgGZYMWGj6YUKuR7uaBN9ivOc0NlBXECnHpY7Hp6QFs9XXWF4nC7A+K2GN29dpJ2wNyDKnwxtc/yyIiR3vA9OMOy54c4tQ28hx0z+QPvLhVC/5i9PytfL/ZzCGJy2hTCgb5kdCWjKmYBKwpw8yga5mgVpGIl19J6Awfb21xI0sCCbVq0xwfFDKslqstTDlZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z525nnqfk77TAwtmkkDvXy77S2o0kls+e+xPihCBnPc=;
 b=YMTGELyNGrfsghQgm4iVEUbJTddU+5JWTvc87Hxk4YZFocmdeOjXju+fotyrO6YNyIq0AzQN179SkphoZLN5eclqF48OHt7OApSIKf0zAZugMUV+S1kQBcweGcV68VION+L4pLO4/AJ5CFMgqlJbnxCk9uud0mHmJEt6uOiIPERKRLh3audh1X/bUcJKWAR4vxjqz//GGd7mLL/ENZeV3SMH5m9fBO4BSxqbR0tKgPJu9LxPsXrmwAmZR5yLVj0JyoXMFBHm4Ac6e49JiIqZSFoZ2MWv70bzT0ZPjHhKqJpjvH5ZwiDQH3HbiwFd5gTzhA6EtkybdGXdYIx18uVwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z525nnqfk77TAwtmkkDvXy77S2o0kls+e+xPihCBnPc=;
 b=vlwJQRxB0drG4cj3aNwp7q+DzFTrw4gzeEw6HOgU2pxpa16UIg4T4kAZX22YmRDFmrR8IPeaV+y+84l99NqbxzS+xEYZs9STb0gYrR2DAesWLSc6LBhhTfIonnxteeWbxWogE2WbFYvwLHhlBQsUrkEVZQNzr6DpI1aPLtrRHyw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2943.eurprd05.prod.outlook.com (10.175.24.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 09:08:10 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::1179:c881:a516:644d%3]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:08:10 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "marcel@ziswiler.com" <marcel@ziswiler.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "info@logictechno.com" <info@logictechno.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH v1 2/2] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Topic: [PATCH v1 2/2] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Index: AQHVb4i+AFMG6Tf6HkW/qXEuG4gbDqc4/cUA
Date:   Mon, 23 Sep 2019 09:08:10 +0000
Message-ID: <5a10bebc1e4c9e23221be9ebe6cdbbdaa2e21b13.camel@toradex.com>
References: <20190920075411.15735-1-marcel@ziswiler.com>
         <20190920075411.15735-2-marcel@ziswiler.com>
In-Reply-To: <20190920075411.15735-2-marcel@ziswiler.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2100ad2c-db03-462b-f4e7-08d740058ea7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2943;
x-ms-traffictypediagnostic: VI1PR0502MB2943:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2943A9CADFA948166C403394F4850@VI1PR0502MB2943.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(39840400004)(346002)(136003)(189003)(199004)(66476007)(110136005)(8676002)(2501003)(6306002)(86362001)(14454004)(36756003)(6486002)(76176011)(486006)(66446008)(91956017)(44832011)(7416002)(4326008)(81156014)(3846002)(26005)(8936002)(6436002)(966005)(99286004)(102836004)(229853002)(256004)(6246003)(5660300002)(6506007)(186003)(54906003)(71190400001)(6116002)(81166006)(66066001)(71200400001)(25786009)(2906002)(305945005)(7736002)(118296001)(316002)(476003)(66556008)(64756008)(11346002)(6512007)(2616005)(478600001)(66946007)(76116006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2943;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3YeIODIrowbGnr4LbPFxnPBGSGFDYohVMV0McxMdycjrpOPA64tw3JmaZvW5hUyZekrCFFQvevytSHKULGCasJkqdI80pgyL/GbBEjYs62fS0DR2KEui7RO25Hyt/sMdXfTgpzG/myaIhYTyXS3kO9hgxD8EwcetK2TCZZSBNkI/OXydtuY0Acr16e7IA/8zmFw5wpPOeJm7AOQ6urQ+jbjmdgWf4thUw3umzMD8v6RiSXb5jGmFIqnnWDMSzZITMUN8YuXQEj1inr/QI+dudYQFEdFqVYKizBMneyUM6ZS3LM8rvulxL722fB/DkBH1AqollgjFoqUTUcfODY4uxnUE+eAwcNgiuZaoOGmhOErxWvmO+dYUeb1UqWO2EETj0UofoLA9lU98fqYTDaYG4Wjz8tU+fjLXu6+IawvsfPs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F0E200B057DD549B3AE60E846DEC987@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2100ad2c-db03-462b-f4e7-08d740058ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:08:10.6651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rU+95zq2yHv58kRGqukUEv1B9HI3OHaSEsV8N5nmqtaZU/1w71tbgGvx6n7tF/oV61Srk2dHfZ2uDrH7gYrbxApH1cxHS4uqk0nSmNXg5bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTIwIGF0IDA5OjU0ICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0K
PiANCj4gQWRkIGRpc3BsYXkgdGltaW5ncyBmb3IgdGhlIGZvbGxvd2luZyAzIGRpc3BsYXkgcGFu
ZWxzIG1hbnVmYWN0dXJlZCBieQ0KPiBMb2dpYyBUZWNobm9sb2dpZXMgTGltaXRlZDoNCj4gDQo+
IC0gTFQxNjEwMTAtMk5IQyBlLmcuIGFzIGZvdW5kIGluIHRoZSBUb3JhZGV4IENhcGFjaXRpdmUg
VG91Y2ggRGlzcGxheQ0KPiAgIDciIFBhcmFsbGVsIFsxXQ0KPiAtIExUMTYxMDEwLTJOSFIgZS5n
LiBhcyBmb3VuZCBpbiB0aGUgVG9yYWRleCBSZXNpc3RpdmUgVG91Y2ggRGlzcGxheQ0KPiA3Ig0K
PiAgIFBhcmFsbGVsIFsyXQ0KPiAtIExUMTcwNDEwLTJXSEMgZS5nLiBhcyBmb3VuZCBpbiB0aGUg
VG9yYWRleCBDYXBhY2l0aXZlIFRvdWNoIERpc3BsYXkNCj4gICAxMC4xIiBMVkRTIFszXQ0KPiAN
Cj4gVGhvc2UgcGFuZWxzIG1heSBhbHNvIGJlIGRpc3RyaWJ1dGVkIGJ5IEVuZHJpY2ggQmF1ZWxl
bWVudGUgVmVydHJpZWJzDQo+IEdtYkggWzRdLg0KPiANCj4gWzFdIA0KPiBodHRwczovL2RvY3Mu
dG9yYWRleC5jb20vMTA0NDk3LTctaW5jaC1wYXJhbGxlbC1jYXBhY2l0aXZlLXRvdWNoLWRpc3Bs
YXktODAweDQ4MC1kYXRhc2hlZXQucGRmDQo+IFsyXSANCj4gaHR0cHM6Ly9kb2NzLnRvcmFkZXgu
Y29tLzEwNDQ5OC03LWluY2gtcGFyYWxsZWwtcmVzaXN0aXZlLXRvdWNoLWRpc3BsYXktODAweDQ4
MC5wZGYNCj4gWzNdIA0KPiBodHRwczovL2RvY3MudG9yYWRleC5jb20vMTA1OTUyLTEwLTEtaW5j
aC1sdmRzLWNhcGFjaXRpdmUtdG91Y2gtZGlzcGxheS0xMjgweDgwMC1kYXRhc2hlZXQucGRmDQo+
IFs0XSANCj4gaHR0cHM6Ly93d3cuZW5kcmljaC5jb20vaXNpNTBfaXNpMzBfdGZ0LWRpc3BsYXlz
L2x0MTcwNDEwLTF3aGNfaXNpMzANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxl
ciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQpSZXZpZXdlZC1ieTogUGhpbGlwcGUg
U2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQo+IA0KPiAtLS0NCj4g
DQo+ICBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMgfCA2NQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUuYw0KPiBpbmRleCAyOGZh
NmJhN2I3NjcuLjQyYmQwZGUyNTE2NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Bh
bmVsL3BhbmVsLXNpbXBsZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1z
aW1wbGUuYw0KPiBAQCAtMjAzNCw2ICsyMDM0LDYyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGFu
ZWxfZGVzYyBsZ19scDEyOXFlID0gew0KPiAgCX0sDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGRpc3BsYXlfdGltaW5nIGxvZ2ljdGVjaG5vX2x0MTYxMDEwXzJuaF90aW1pbmcg
PQ0KPiB7DQo+ICsJLnBpeGVsY2xvY2sgPSB7IDI2NDAwMDAwLCAzMzMwMDAwMCwgNDY4MDAwMDAg
fSwNCj4gKwkuaGFjdGl2ZSA9IHsgODAwLCA4MDAsIDgwMCB9LA0KPiArCS5oZnJvbnRfcG9yY2gg
PSB7IDE2LCAyMTAsIDM1NCB9LA0KPiArCS5oYmFja19wb3JjaCA9IHsgNDYsIDQ2LCA0NiB9LA0K
PiArCS5oc3luY19sZW4gPSB7IDEsIDIwLCA0MCB9LA0KPiArCS52YWN0aXZlID0geyA0ODAsIDQ4
MCwgNDgwIH0sDQo+ICsJLnZmcm9udF9wb3JjaCA9IHsgNywgMjIsIDE0NyB9LA0KPiArCS52YmFj
a19wb3JjaCA9IHsgMjMsIDIzLCAyMyB9LA0KPiArCS52c3luY19sZW4gPSB7IDEsIDEwLCAyMCB9
LA0KPiArCS5mbGFncyA9IERJU1BMQVlfRkxBR1NfSFNZTkNfTE9XIHwgRElTUExBWV9GTEFHU19W
U1lOQ19MT1cgfA0KPiArCQkgRElTUExBWV9GTEFHU19ERV9ISUdIIHwgRElTUExBWV9GTEFHU19Q
SVhEQVRBX1BPU0VER0UgfA0KPiArCQkgRElTUExBWV9GTEFHU19TWU5DX1BPU0VER0UsDQo+ICt9
Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBhbmVsX2Rlc2MgbG9naWN0ZWNobm9fbHQx
NjEwMTBfMm5oID0gew0KPiArCS50aW1pbmdzID0gJmxvZ2ljdGVjaG5vX2x0MTYxMDEwXzJuaF90
aW1pbmcsDQo+ICsJLm51bV90aW1pbmdzID0gMSwNCj4gKwkuc2l6ZSA9IHsNCj4gKwkJLndpZHRo
ID0gMTU0LA0KPiArCQkuaGVpZ2h0ID0gODYsDQo+ICsJfSwNCj4gKwkuYnVzX2Zvcm1hdCA9IE1F
RElBX0JVU19GTVRfUkdCNjY2XzFYMTgsDQo+ICsJLmJ1c19mbGFncyA9IERSTV9CVVNfRkxBR19E
RV9ISUdIIHwNCj4gKwkJICAgICBEUk1fQlVTX0ZMQUdfUElYREFUQV9TQU1QTEVfTkVHRURHRSB8
DQo+ICsJCSAgICAgRFJNX0JVU19GTEFHX1NZTkNfU0FNUExFX05FR0VER0UsDQo+ICt9Ow0KPiAr
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRpc3BsYXlfdGltaW5nIGxvZ2ljdGVjaG5vX2x0MTcw
NDEwXzJ3aGNfdGltaW5nID0NCj4gew0KPiArCS5waXhlbGNsb2NrID0geyA2ODkwMDAwMCwgNzEx
MDAwMDAsIDczNDAwMDAgfSwNCj4gKwkuaGFjdGl2ZSA9IHsgMTI4MCwgMTI4MCwgMTI4MCB9LA0K
PiArCS5oZnJvbnRfcG9yY2ggPSB7IDIzLCA2MCwgNzEgfSwNCj4gKwkuaGJhY2tfcG9yY2ggPSB7
IDIzLCA2MCwgNzEgfSwNCj4gKwkuaHN5bmNfbGVuID0geyAxNSwgNDAsIDQ3IH0sDQo+ICsJLnZh
Y3RpdmUgPSB7IDgwMCwgODAwLCA4MDAgfSwNCj4gKwkudmZyb250X3BvcmNoID0geyA1LCA3LCAx
MCB9LA0KPiArCS52YmFja19wb3JjaCA9IHsgNSwgNywgMTAgfSwNCj4gKwkudnN5bmNfbGVuID0g
eyA2LCA5LCAxMiB9LA0KPiArCS5mbGFncyA9IERJU1BMQVlfRkxBR1NfSFNZTkNfTE9XIHwgRElT
UExBWV9GTEFHU19WU1lOQ19MT1cgfA0KPiArCQkgRElTUExBWV9GTEFHU19ERV9ISUdIIHwgRElT
UExBWV9GTEFHU19QSVhEQVRBX1BPU0VER0UgfA0KPiArCQkgRElTUExBWV9GTEFHU19TWU5DX1BP
U0VER0UsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBhbmVsX2Rlc2MgbG9n
aWN0ZWNobm9fbHQxNzA0MTBfMndoYyA9IHsNCj4gKwkudGltaW5ncyA9ICZsb2dpY3RlY2hub19s
dDE3MDQxMF8yd2hjX3RpbWluZywNCj4gKwkubnVtX3RpbWluZ3MgPSAxLA0KPiArCS5zaXplID0g
ew0KPiArCQkud2lkdGggPSAyMTcsDQo+ICsJCS5oZWlnaHQgPSAxMzYsDQo+ICsJfSwNCj4gKwku
YnVzX2Zvcm1hdCA9IE1FRElBX0JVU19GTVRfUkdCODg4XzFYN1g0X1NQV0csDQo+ICsJLmJ1c19m
bGFncyA9IERSTV9CVVNfRkxBR19ERV9ISUdIIHwNCj4gKwkJICAgICBEUk1fQlVTX0ZMQUdfUElY
REFUQV9TQU1QTEVfTkVHRURHRSB8DQo+ICsJCSAgICAgRFJNX0JVU19GTEFHX1NZTkNfU0FNUExF
X05FR0VER0UsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5
X21vZGUgbWl0c3ViaXNoaV9hYTA3MG1jMDFfbW9kZSA9IHsNCj4gIAkuY2xvY2sgPSAzMDQwMCwN
Cj4gIAkuaGRpc3BsYXkgPSA4MDAsDQo+IEBAIC0zMjY0LDYgKzMzMjAsMTUgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gcGxhdGZvcm1fb2ZfbWF0Y2hbXSA9IHsNCj4gIAl9
LCB7DQo+ICAJCS5jb21wYXRpYmxlID0gImxnLGxwMTI5cWUiLA0KPiAgCQkuZGF0YSA9ICZsZ19s
cDEyOXFlLA0KPiArCX0sIHsNCj4gKwkJLmNvbXBhdGlibGUgPSAibG9naWN0ZWNobm8sbHQxNjEw
MTAtMm5oYyIsDQo+ICsJCS5kYXRhID0gJmxvZ2ljdGVjaG5vX2x0MTYxMDEwXzJuaCwNCj4gKwl9
LCB7DQo+ICsJCS5jb21wYXRpYmxlID0gImxvZ2ljdGVjaG5vLGx0MTYxMDEwLTJuaHIiLA0KPiAr
CQkuZGF0YSA9ICZsb2dpY3RlY2hub19sdDE2MTAxMF8ybmgsDQo+ICsJfSwgew0KPiArCQkuY29t
cGF0aWJsZSA9ICJsb2dpY3RlY2hubyxsdDE3MDQxMC0yd2hjIiwNCj4gKwkJLmRhdGEgPSAmbG9n
aWN0ZWNobm9fbHQxNzA0MTBfMndoYywNCj4gIAl9LCB7DQo+ICAJCS5jb21wYXRpYmxlID0gIm1p
dHN1YmlzaGksYWEwNzBtYzAxLWNhMSIsDQo+ICAJCS5kYXRhID0gJm1pdHN1YmlzaGlfYWEwNzBt
YzAxLA0K
