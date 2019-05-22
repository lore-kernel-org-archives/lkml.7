Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1BEC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD24217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="YnkEpPMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfEVKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:55:24 -0400
Received: from mail-eopbgr1410110.outbound.protection.outlook.com ([40.107.141.110]:65504
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728743AbfEVKzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMgJmwSOhyU4SGsVx7Cp6tBPBYtt2ugZHPy0KRXEC2k=;
 b=YnkEpPMqulcTYE2lJRER5F05Ip2LAJbQ0w9HSpuxZdOU63BQTTsDFPAgfKO8jgn+QGJNwgUdjUTxdKG7L8h3z3aVEBZhqh3OEjnqDeXFLxrNqfi7WyIhc+an7bgkUeWo8/HF1fgOK8xMyVMpoteLQiJBqDaaejpE35wY2Th77KM=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1608.jpnprd01.prod.outlook.com (52.134.225.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 10:55:17 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:55:17 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by node
Thread-Topic: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
 node
Thread-Index: AQHVCjGxbEdsIx4ReU+jIZIOb3TooaZvJLIAgAApPICABAgXgIAAWsCAgAAANlCAAAi9gIAADx0AgAGaToCAAW2SoIAAHO0AgAAPKZA=
Date:   Wed, 22 May 2019 10:55:17 +0000
Message-ID: <OSBPR01MB21038F2B99EF74831A22727BB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
         <1557823643-8616-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190517103736.GA1490@kuha.fi.intel.com>
         <20190517130511.GA1887@kuha.fi.intel.com>
         <1558319951.10179.352.camel@mhfsdcap03>
         <20190520080359.GC1887@kuha.fi.intel.com>
         <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190520083601.GE1887@kuha.fi.intel.com>
         <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190521095839.GI1887@kuha.fi.intel.com>
         <OSBPR01MB21032206146152983C8F4E8EB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <1558517436.10179.388.camel@mhfsdcap03>
In-Reply-To: <1558517436.10179.388.camel@mhfsdcap03>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 374b0aa0-4b73-48a8-d0d8-08d6dea3f9eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB1608;
x-ms-traffictypediagnostic: OSBPR01MB1608:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB160860EE47BA337E6C38609CB8000@OSBPR01MB1608.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(39860400002)(366004)(51914003)(189003)(199004)(7736002)(5660300002)(305945005)(53936002)(186003)(7416002)(26005)(54906003)(6436002)(110136005)(316002)(71200400001)(966005)(14454004)(86362001)(478600001)(71190400001)(52536014)(256004)(44832011)(9686003)(4326008)(11346002)(446003)(6306002)(476003)(486006)(55016002)(25786009)(33656002)(81156014)(8936002)(6246003)(74316002)(6116002)(3846002)(8676002)(81166006)(7696005)(229853002)(76176011)(2906002)(66476007)(102836004)(99286004)(68736007)(6506007)(66066001)(76116006)(66446008)(64756008)(66946007)(66556008)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1608;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YgaGTvXxUXd/WW+J3SsZ1diQxQmGpa0h8+vEzoB6mLe0fxHJ6by7ebMD7ku3wCo+A8c4uk4xqUEryV8Mns+Y5bMuA4Hu2dBSepAOIuycxpDMOh8w14lYKcyFFrYp8DwaTavJPEg+gu9IlqAVRWCZkCHd0Mn7Wnn7S7bnmiAhLnsXeBM+Xzj+Ru3fCP22x3B3fB9vdXabK4h90Zuw3LAKgRfU7K01DMlpYorLHGRB2wAFHGzkk2ejfJ53ElTgoiOlpuHrZVj7ETJxt0VQau38APOwJv5wUNEMCkbIZFrUEtO3PytHR3Qf9pberHaDlV6k9LVXR/56NbJaZ+WBRXfXqjjxH8LkTAsTA69zfA3lkHdr7h6Qtsi7WwuJ7U4FT3kByXRbANrd/ahVwl4Zk2Jk8TiDChc1MFybiQJDj7Df5lw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b0aa0-4b73-48a8-d0d8-08d6dea3f9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:55:17.1062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bmZlbmcgWXVuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIHY1IDQvNl0gdXNiOiByb2xlczogYWRkIEFQSSB0byBnZXQgdXNiX3JvbGVf
c3dpdGNoIGJ5DQo+IG5vZGUNCj4gDQo+IEhpIEJpanUsDQo+IE9uIFdlZCwgMjAxOS0wNS0yMiBh
dCAwODowNSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgSGVpa2tpLA0KPiA+DQo+ID4g
VGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djUgNC82XSB1c2I6IHJvbGVzOiBhZGQgQVBJIHRvIGdldA0KPiA+ID4gdXNiX3JvbGVfc3dpdGNo
IGJ5IG5vZGUNCj4gPiA+DQo+ID4gPiBPbiBNb24sIE1heSAyMCwgMjAxOSBhdCAwOTo0NTo0NkFN
ICswMDAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSGkgSGVp
a2tpLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNl0gdXNiOiByb2xlczogYWRkIEFQ
SSB0byBnZXQNCj4gPiA+ID4gPiB1c2Jfcm9sZV9zd2l0Y2ggYnkgbm9kZQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gT24gTW9uLCBNYXkgMjAsIDIwMTkgYXQgMDg6MDY6NDFBTSArMDAwMCwgQmlqdSBE
YXMgd3JvdGU6DQo+ID4gPiA+ID4gPiBIaSBIZWlra2ksDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNl0gdXNiOiByb2xlczogYWRkIEFQSSB0byBn
ZXQNCj4gPiA+ID4gPiA+ID4gdXNiX3JvbGVfc3dpdGNoIGJ5IG5vZGUNCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBNYXkgMjAsIDIwMTkgYXQgMTA6Mzk6MTFBTSArMDgwMCwg
Q2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+ID4gPiA+
IE9uIEZyaSwgMjAxOS0wNS0xNyBhdCAxNjowNSArMDMwMCwgSGVpa2tpIEtyb2dlcnVzIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gT24gRnJpLCBNYXkgMTcsIDIwMTkgYXQgMDE6Mzc6MzZQTSArMDMwMCwgSGVpa2tpIEty
b2dlcnVzDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIE1heSAxNCwgMjAx
OSBhdCAwNDo0NzoyMVBNICswODAwLCBDaHVuZmVuZyBZdW4NCj4gPiA+IHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IEFkZCBmd25vZGVfdXNiX3JvbGVfc3dpdGNoX2dldCgpIHRvIG1ha2Ug
ZWFzaWVyIHRvDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZ2V0IHVzYl9yb2xlX3N3aXRjaCBieSBm
d25vZGUgd2hpY2ggcmVnaXN0ZXIgaXQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyB1c2Vm
dWwgd2hlbiB0aGVyZSBpcyBub3QgZGV2aWNlX2Nvbm5lY3Rpb24NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiByZWdpc3RlcmVkIGJldHdlZW4gdHdvIGRyaXZlcnMgYW5kIG9ubHkga25vd3MgdGhlDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gZndub2RlIHdoaWNoIHJlZ2lzdGVyIHVzYl9yb2xlX3N3aXRj
aC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1bg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRlc3RlZC1ieTogQmlqdSBEYXMg
PGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiBBY2tlZC1ieTogSGVpa2tpIEtyb2dlcnVzDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4gPiA+IEhvbGQgb24uIEkganVzdCBub3RpY2VkIFJvYidzIGNvbW1lbnQgb24g
cGF0Y2ggMi82LA0KPiA+ID4gPiA+ID4gPiA+ID4gd2hlcmUgaGUgcG9pbnRzIG91dCB0aGF0IHlv
dSBkb24ndCBuZWVkIHRvIHVzZSBkZXZpY2UNCj4gPiA+ID4gPiA+ID4gPiA+IGdyYXBoIHNpbmNl
IHRoZSBjb250cm9sbGVyIGlzIHRoZSBwYXJlbnQgb2YgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBj
b25uZWN0b3IuIERvZXNuJ3QgdGhhdCBtZWFuIHlvdSBkb24ndCByZWFsbHkgbmVlZCB0aGlzIEFQ
ST8NCj4gPiA+ID4gPiA+ID4gPiBObywgSSBzdGlsbCBuZWVkIGl0Lg0KPiA+ID4gPiA+ID4gPiA+
IFRoZSBjaGFuZ2UgaXMgYWJvdXQgdGhlIHdheSBob3cgdG8gZ2V0IGZ3bm9kZTsgd2hlbiB1c2UN
Cj4gPiA+ID4gPiA+ID4gPiBkZXZpY2UgZ3JhcGgsIGdldCBmd25vZGUgYnkgb2ZfZ3JhcGhfZ2V0
X3JlbW90ZV9ub2RlKCk7DQo+ID4gPiA+ID4gPiA+ID4gYnV0IG5vdyB3aWxsIGdldCBmd25vZGUg
Ynkgb2ZfZ2V0X3BhcmVudCgpOw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBPSywgSSBn
ZXQgdGhhdCwgYnV0IEknbSBzdGlsbCBub3QgY29udmluY2VkIGFib3V0IGlmDQo+ID4gPiA+ID4g
PiA+IHNvbWV0aGluZyBsaWtlIHRoaXMgZnVuY3Rpb24gaXMgbmVlZGVkIGF0IGFsbC4gSSBhbHNv
IGhhdmUNCj4gPiA+ID4gPiA+ID4gY29uY2VybnMgcmVnYXJkaW5nIGhvdyB5b3UgYXJlIHVzaW5n
IHRoZSBmdW5jdGlvbi4gSSdsbA0KPiA+ID4gPiA+ID4gPiBleHBsYWluIGluIGNvbW1lbnQgdG8g
dGhlIHBhdGNoIDUvNiBpbiB0aGlzDQo+ID4gPiA+ID4gc2VyaWVzLi4uDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gRllJLCBDdXJyZW50bHkgIEkgYW0gYWxzbyB1c2luZyB0aGlzIGFwaSBpbiBt
eSBwYXRjaCBzZXJpZXMuDQo+ID4gPiA+ID4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzEwOTQ0NjM3Lw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWWVzLCBhbmQgSSBoYXZlIHRo
ZSBzYW1lIHF1ZXN0aW9uIGZvciB5b3UgSSBqdXNiIGFza2VkIGluDQo+ID4gPiA+ID4gY29tbWVu
dCBJIGFkZGVkIHRvIHRoZSBwYXRjaCA1LzYgb2YgdGhpcyBzZXJpZXMuIFdoeSBpc24ndA0KPiA+
ID4gPiA+IHVzYl9yb2xlX3N3aXRjaF9nZXQoKQ0KPiA+ID4gZW5vdWdoPw0KPiA+ID4gPg0KPiA+
ID4gPiBDdXJyZW50bHkgbm8gaXNzdWUuIEl0IHdpbGwgd29yayB3aXRoIHRoaXMgYXBpIGFzIHdl
bGwsIHNpbmNlIHRoZQ0KPiA+ID4gPiBwb3J0IG5vZGUgaXMNCj4gPiA+IHBhcnQgb2YgY29udHJv
bGxlciBub2RlLg0KPiA+ID4gPiBGb3IgZWc6LQ0KPiA+ID4gPiBodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3BhdGNoLzEwOTQ0NjI3Lw0KPiA+ID4gPg0KPiA+ID4gPiBIb3dldmVyIGlmIGFu
eSBvbmUgYWRkcyBwb3J0IG5vZGUgaW5zaWRlIHRoZSBjb25uZWN0b3Igbm9kZSwgdGhlbg0KPiA+
ID4gPiB0aGlzDQo+ID4gPiBhcGkgbWF5IHdvbid0IHdvcmsgYXMgZXhwZWN0ZWQuDQo+ID4gPiA+
IEN1cnJlbnRseSBJIGdldCBiZWxvdyBlcnJvcg0KPiA+ID4gPg0KPiA+ID4gPiBbICAgIDIuMjk5
NzAzXSBPRjogZ3JhcGg6IG5vIHBvcnQgbm9kZSBmb3VuZCBpbg0KPiA+ID4gL3NvYy9pMmNAZTY1
MDAwMDAvaGQzc3MzMjIwQDQ3DQo+ID4gPg0KPiA+ID4gV2UgbmVlZCB0byB1bmRlcnN0YW5kIHdo
eSBpcyB0aGF0IGhhcHBlbmluZz8NCj4gPiA+DQo+ID4NCj4gPiBGb3JtIHRoZSBzdGFjayB0cmFj
ZSAgdGhlIHBhcmVudCBub2RlIGlzICJwYXJlbnRfbm9kZT1oZDNzczMyMjBANDciICwNCj4gaW5z
dGVhZCBvZiB0aGUgImNvbm5lY3RvciIgbm9kZS4NCj4gPiBUaGF0IGlzIHRoZSByZWFzb24gZm9y
IHRoZSBhYm92ZSBlcnJvci4NCj4gPg0KPiA+IFsgICAgMi40NDI0MjldICBvZl9ncmFwaF9nZXRf
bmV4dF9lbmRwb2ludC5wYXJ0LjArMHgyOC8weDE2OA0KPiA+IFsgICAgMi40NDc4ODldICBvZl9m
d25vZGVfZ3JhcGhfZ2V0X25leHRfZW5kcG9pbnQrMHg1Yy8weGIwDQo+ID4gWyAgICAyLjQ1MzI2
N10gIGZ3bm9kZV9ncmFwaF9nZXRfbmV4dF9lbmRwb2ludCsweDIwLzB4MzANCj4gPiBbICAgIDIu
NDU4Mzc0XSAgZGV2aWNlX2Nvbm5lY3Rpb25fZmluZF9tYXRjaCsweDc0LzB4MWEwDQo+ID4gWyAg
ICAyLjQ2MzM5OV0gIHVzYl9yb2xlX3N3aXRjaF9nZXQrMHgyMC8weDI4DQo+ID4gWyAgICAyLjQ2
NzU0Ml0gIGhkM3NzMzIyMF9wcm9iZSsweGM0LzB4MjE4DQo+ID4NCj4gPiBUaGUgdXNlIGNhc2Ug
aXMNCj4gPg0KPiA+ICZpMmMwIHsNCj4gPiAJaGQzc3MzMjIwQDQ3IHsNCj4gPiAgICAgICAgICAg
ICAgICAgIAljb21wYXRpYmxlID0gInRpLGhkM3NzMzIyMCI7DQo+ID4NCj4gPiAgICAgICAgICAg
ICAgICAgIAl1c2JfY29uOiBjb25uZWN0b3Igew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCQljb21wYXRpYmxlID0gInVzYi1jLWNvbm5lY3RvciI7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIAkJcG9ydCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAJ
CSBoZDNzczMyMjBfZXA6IGVuZHBvaW50IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCQkJcmVtb3RlLWVuZHBvaW50ID0NCj4gPCZ1c2IzX3JvbGVfc3dpdGNo
PjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAkJfTsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgCQl9Ow0KPiA+ICAgICAgICAgICAgICAgICAJIH07DQo+ID4gCSB9
Ow0KPiA+IH07DQo+ID4NCj4gPiAmdXNiM19wZXJpMCB7DQo+ID4gICAgICAgICAgY29tcGFuaW9u
ID0gPCZ4aGNpMD47DQo+ID4gICAgICAgICAgdXNiLXJvbGUtc3dpdGNoOw0KPiA+DQo+ID4gICAg
ICAgICAgcG9ydCB7DQo+ID4gICAgICAgICAgICAgICAgIHVzYjNfcm9sZV9zd2l0Y2g6IGVuZHBv
aW50IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8Jmhk
M3NzMzIyMF9lcD47DQo+ID4gICAgICAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgIH07DQo+
ID4gfTsNCj4gPg0KPiA+IFExKSBIb3cgZG8gd2UgbW9kaWZ5IHRoZSB1c2Jfcm9sZV9zd2l0Y2hf
Z2V0KCkgZnVuY3Rpb24gdG8gc2VhcmNoDQo+ID4gQ2hpbGQoY29ubmVjdG9yKSBhbmQgY2hpbGQn
cyBlbmRwb2ludD8NCj4gSG93IGFib3V0IGZpcnN0bHkgZmluZGluZyBjb25uZWN0b3Igbm9kZSBp
biBmd25vZGVfZ3JhcGhfZGV2Y29uX21hdGNoKCksDQo+IHRoZW4gc2VhcmNoIGVhY2ggZW5kcG9p
bnQ/DQoNCiBJIGhhdmUgZG9uZSBhIHF1aWNrIHByb3RvdHlwaW5nIHdpdGggdGhlIGNoYW5nZXMg
eW91IHN1Z2dlc3RlZCBhbmQgaXQgd29ya3MuDQoNCi0gICAgICAgc3RydWN0IGZ3bm9kZV9oYW5k
bGUgKmVwOw0KKyAgICAgICBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZXAsKmNoaWxkLCp0bXAgPSBm
d25vZGU7IA0KIA0KLSAgICAgICBmd25vZGVfZ3JhcGhfZm9yX2VhY2hfZW5kcG9pbnQoZndub2Rl
LCBlcCkgew0KKyAgICAgICBjaGlsZCA9IGZ3bm9kZV9nZXRfbmFtZWRfY2hpbGRfbm9kZShmd25v
ZGUsICJjb25uZWN0b3IiKTsNCisgICAgICAgaWYgKGNoaWxkKQ0KKyAgICAgICAgICAgICAgIHRt
cCA9IGNoaWxkOw0KKw0KKyAgICAgICBmd25vZGVfZ3JhcGhfZm9yX2VhY2hfZW5kcG9pbnQodG1w
LCBlcCkgew0KDQpGb3JtIHRoZSBzdGFjayB0cmFjZSAgdGhlIHBhcmVudCBub2RlIGlzICJwYXJl
bnRfbm9kZT0gY29ubmVjdG9yIiAuDQoNClsgICAgMi40NDA5MjJdICBvZl9ncmFwaF9nZXRfbmV4
dF9lbmRwb2ludC5wYXJ0LjArMHgyOC8weDE2OA0KWyAgICAyLjQ0NjM4MV0gIG9mX2Z3bm9kZV9n
cmFwaF9nZXRfbmV4dF9lbmRwb2ludCsweDVjLzB4YjANClsgICAgMi40NTE3NThdICBmd25vZGVf
Z3JhcGhfZ2V0X25leHRfZW5kcG9pbnQrMHgyMC8weDMwDQpbICAgIDIuNDU2ODY2XSAgZGV2aWNl
X2Nvbm5lY3Rpb25fZmluZF9tYXRjaCsweDg0LzB4MWMwDQpbICAgIDIuNDYxODg4XSAgdXNiX3Jv
bGVfc3dpdGNoX2dldCsweDIwLzB4MjgNCg0KSGVpa2tpLCANCkFyZSB5b3Ugb2sgIHdpdGggdGhl
IGFib3ZlIGNoYW5nZXM/DQoNClJlZ2FyZHMsDQpCaWp1DQo+ID4NCj4gPiA+IEl0IGxvb2tzIGxp
a2Ugd2UgaGF2ZSBhbiBpc3N1ZSBzb21ld2hlcmUgaW4gdGhlIGNvZGUsIGFuZCBpbnN0ZWFkIG9m
DQo+ID4gPiBmaXhpbmcgdGhhdCwgeW91IGFyZSB3b3JraW5nIGFyb3VuZCBpdC4gTGV0J3Mgbm90
IGRvIHRoYXQuDQo+ID4NCj4gPiBPSy4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQmlqdQ0KPiA+
DQo+IA0KDQo=
