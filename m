Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C285FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4E42075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="v2phUKFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:28:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:63654 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:28:44 -0400
X-IronPort-AV: E=Sophos;i="5.58,497,1544511600"; 
   d="scan'208";a="26489338"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Mar 2019 01:28:44 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Mar 2019 01:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP7GbjqoTrHUSk4y2XVVwkva9JUZHtoIiNTmajJpnf8=;
 b=v2phUKFbNvf0nIPycAd8q/S/Ac2rNuOAAxYifkqYAKAtbd2zSIJK1LfWPtZbx+tAOhkxLC5f3cVIIFJgTPsPc097me2IzsFNEx13yip7B22d7gxslBoJzjmGWnNDjLZwBFSTzdc2/Fb5zJw+8EyYtYhgNIw3IN4At9hwTy2YzL8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.53.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 08:28:40 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::5413:49b5:8548:fe44%8]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 08:28:40 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <matthias.wieloch@few-bauer.de>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] clk: at91: fix programmable clock for sama5d2
Thread-Topic: [PATCH v2] clk: at91: fix programmable clock for sama5d2
Thread-Index: AQHU3cRmvy5YfEm4i0SwVvQtqxhIlqYSn+sA
Date:   Tue, 19 Mar 2019 08:28:40 +0000
Message-ID: <dd4a32fe-4942-83a8-a2c4-336e3c6e55b3@microchip.com>
References: <20190318105045.26943-1-nicolas.ferre@microchip.com>
 <155293884206.20095.9858756917267939797@swboyd.mtv.corp.google.com>
In-Reply-To: <155293884206.20095.9858756917267939797@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41b2ad4a-cbde-4346-1a5f-08d6ac44e3cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB18228A30C693B0389A1FE695E0400@MWHPR11MB1822.namprd11.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(51914003)(4326008)(6486002)(6436002)(14454004)(36756003)(6512007)(31696002)(76176011)(52116002)(71190400001)(446003)(97736004)(26005)(110136005)(6506007)(2906002)(229853002)(86362001)(6246003)(186003)(386003)(72206003)(99286004)(54906003)(102836004)(53546011)(53936002)(6346003)(11346002)(71200400001)(25786009)(498600001)(105586002)(5660300002)(81156014)(256004)(14444005)(8676002)(81166006)(6116002)(2501003)(2616005)(7736002)(476003)(31686004)(305945005)(66066001)(106356001)(486006)(8936002)(68736007)(3846002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HD/1H6xTndoK8UxEMb5N/AuEcJtcChz7E24NzIfHJC+xVqNnsJPbXYwSFzzOS7Mf6l5ndVljr0saHcbA8fck3ANIsI5Nfa3+DQrwBO6VSJ9NC5bZoKZNoJwz8rOf0Fq8dKIAFJDSbUbss3yXEFL0uWU61Md4je1p77AoG1k6WQPPWkOwKl5desXf7ZqDKsgYxiaYMM3kjqzMSkitGjTU/la+pxyVO+B7Fl/KoPqaHR1PiPnlPhGnz+tH0WohyMQyRwgQf2D3xTOa9rJNaSL704o14EJi/0t9zUs2e+EkKFxXHDoyq3PvxvAIicCOZmBOXKjQ2D9wfmzTg9M3/P7qHdU0ofwZQAuSvrZVGKLNutrv1xv7oX+lTjCgra2fDMUHF/Sbam0BeWqud83teUuIHHIkUcWPSwE4eVc60wzYnJ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1CD5ABD98BD984798EF6E11B4DFF797@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b2ad4a-cbde-4346-1a5f-08d6ac44e3cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 08:28:40.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3DQoNCk9uIDE4LzAzLzIwMTkgYXQgMjA6
NTQsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBOaWNvbGFzIEZlcnJlICgyMDE5LTAz
LTE4IDAzOjUwOjQ1KQ0KPj4gRnJvbTogTWF0dGhpYXMgV2llbG9jaCA8bWF0dGhpYXMud2llbG9j
aEBmZXctYmF1ZXIuZGU+DQo+Pg0KPj4gVGhlIHByZXNjYWxlciBmb3JtdWxhIG9mIHRoZSBwcm9n
cmFtbWFibGUgY2xvY2sgaGFzIGNoYW5nZWQgZm9yIHNhbWE1ZDIuIFVwZGF0ZQ0KPj4gdGhlIGRy
aXZlciBhY2NvcmRpbmdseS4NCj4+DQo+PiBGaXhlczogYTIwMzgwNzdkZTlhICgiY2xrOiBhdDkx
OiBhZGQgc2FtYTVkMiBQTUMgZHJpdmVyIikNCj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4gIyB2NC4yMCsNCj4+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVy
cmVAbWljcm9jaGlwLmNvbT4NCj4+IFtuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb206IGFkYXB0
IHRoZSBwcmVzY2FsZXIgcmFuZ2UsDQo+PiAgICAgICAgICAgICAgICAgIGZpeCBjbGtfcHJvZ3Jh
bW1hYmxlX3JlY2FsY19yYXRlLCBzcGxpdCBwYXRjaF0NCj4+IFNpZ25lZC1vZmYtYnk6IE1hdHRo
aWFzIFdpZWxvY2ggPG1hdHRoaWFzLndpZWxvY2hAZmV3LWJhdWVyLmRlPg0KPj4gU2lnbmVkLW9m
Zi1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0K
Pj4gLS0tDQo+PiB2MjogYWRhcHQgdG8gdjUuMS1yYzENCj4+ICAgICAgcmVtb3ZlIHVubmVlZGVk
IHNlbnRlbmNlIGFib3V0IERUIGluIGNvbW1pdCBtZXNzYWdlDQo+Pg0KPj4gU3RlcGhlbiwNCj4+
DQo+PiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gc2VlIHRoaXMgZml4IGdvaW5nIHVwc3Ry
ZWFtIGR1cmluZyB2NS4xLXJjIHBoYXNlLg0KPiANCj4gT2suIEkgY2FuIGFwcGx5IHRoaXMgY2xr
LWZpeGVzLiBJIHByZXN1bWUgdGhhdCB0aGluZ3MgYXJlIHJlYWwgYmFkIGFuZA0KPiBpdCBjYW4n
dCB3YWl0IHVudGlsIHY1LjI/DQoNClRvIGJlIHBlcmZlY3RseSBjbGVhciwgaXQncyBub3QgYSBy
ZWdyZXNzaW9uLg0KQnV0IGFzIHdlJ3JlIGF0IHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiB0aGUgJy1y
YycgcGhhc2UgYW5kIGFzIGl0J3MgYSBidWcsIA0KSSB3YXMgdGhpbmtpbmcgYWJvdXQgYWRkaW5n
IGl0IG5vdy4gQnV0IHlvdSB0byBjaG9vc2UsIG5vIHByb2JsZW0gZWl0aGVyIA0Kd2F5Lg0KDQo+
PiBAQCAtNjAsMTAgKzY4LDE4IEBAIHN0YXRpYyBpbnQgY2xrX3Byb2dyYW1tYWJsZV9kZXRlcm1p
bmVfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCj4+ICAgDQo+PiAgICAgICAgICAgICAgICAgIHBhcmVudF9yYXRlID0gY2xrX2h3
X2dldF9yYXRlKHBhcmVudCk7DQo+PiAtICAgICAgICAgICAgICAgZm9yIChzaGlmdCA9IDA7IHNo
aWZ0IDwgUFJPR19QUkVTX01BU0s7IHNoaWZ0KyspIHsNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHRtcF9yYXRlID0gcGFyZW50X3JhdGUgPj4gc2hpZnQ7DQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICBpZiAodG1wX3JhdGUgPD0gcmVxLT5yYXRlKQ0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAgICBpZiAobGF5b3V0LT5pc19w
cmVzX2RpcmVjdCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZm9yIChzaGlmdCA9IDA7
IHNoaWZ0IDw9IGxheW91dC0+cHJlc19tYXNrOyBzaGlmdCsrKSB7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHRtcF9yYXRlID0gcGFyZW50X3JhdGUgLyAoc2hpZnQgKyAxKTsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHRtcF9yYXRlIDw9IHJlcS0+
cmF0ZSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgICB9IGVsc2Ug
ew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZm9yIChzaGlmdCA9IDA7IHNoaWZ0IDwgbGF5
b3V0LT5wcmVzX21hc2s7IHNoaWZ0KyspIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdG1wX3JhdGUgPSBwYXJlbnRfcmF0ZSA+PiBzaGlmdDsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHRtcF9yYXRlIDw9IHJlcS0+cmF0ZSkNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIH0NCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIGxvdCBvZiBjb3B5IHBhc3RlIHdo
ZW4gdGhlIGlmIHN0YXRlbWVudCBjb3VsZCBoYXZlIGJlZW4NCj4gcHVsbGVkIGludG8gdGhlIGZv
ciBsb29wIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlIGxvb3BzIGFuZA0KPiBzdXJyb3VuZGlu
ZyBpZiBjb25kaXRpb24gY2hlY2sgZm9yIHRtcF9yYXRlLg0KDQpTdG9wIGNvbmRpdGlvbiBvZiBs
b29wcyBub3QgYmVpbmcgdGhlIHNhbWUgbWFkZSBtZSBzZXBhcmF0ZSB0aGVtIGluc3RlYWQgDQpv
ZiBhZGRpbmcgYXJ0aWZpY2lhbCB0ZXN0IGNvbmRpdGlvbnMgZm9yIHNoaWZ0ID09IGxheW91dC0+
cHJlc19tYXNrLiBJJ20gDQpub3Qgc3VyZSB0aGUgb3RoZXIgd2F5IGFyb3VuZCBpcyBtb3JlIG9i
dmlvdXMgdGhlbi4uLg0KDQo+IA0KPj4gICAgICAgICAgICAgICAgICB9DQo+PiAgIA0KPj4gICAg
ICAgICAgICAgICAgICBpZiAodG1wX3JhdGUgPiByZXEtPnJhdGUpDQoNCg0KLS0gDQpOaWNvbGFz
IEZlcnJlDQo=
