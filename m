Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEED321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0Nbjowjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDHMjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:39:19 -0400
Received: from mail-eopbgr690077.outbound.protection.outlook.com ([40.107.69.77]:39549
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfDHMjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBp/ZUW8my6ju8eIkgQRaJqxXz12gIub/dKK40UtbEY=;
 b=0NbjowjnlguLpLOTC/Tapg7+eMbVDCB6mVEN2a7Ekyyab+AjOR+RJK7hKSAg/bmnmeCaesD6JBpxzIPKzkr57++e9/hfBnPOqSBZD/TxaFoa05lBAYurUbfq8dlZNdBumKub/q+pVQzVNNKvyamzV7mWrWZX7B85ws4v9M5GOos=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4918.namprd02.prod.outlook.com (52.135.234.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Mon, 8 Apr 2019 12:39:12 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::55ca:e7d8:c514:8276%3]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 12:39:12 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Subject: RE: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Topic: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Index: AQHU6VAa3juPwWr490+9QB3ZXSwb5qYpMM2AgAkMFiA=
Date:   Mon, 8 Apr 2019 12:39:11 +0000
Message-ID: <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
In-Reply-To: <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4468c9e0-c191-4545-4fa1-08d6bc1f33f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4918;
x-ms-traffictypediagnostic: BYAPR02MB4918:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB49184C77CDCDB040378F622FC22C0@BYAPR02MB4918.namprd02.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(13464003)(189003)(199004)(54906003)(55016002)(6246003)(52536014)(6116002)(8676002)(256004)(25786009)(8936002)(9686003)(99286004)(4326008)(5660300002)(53936002)(74316002)(71200400001)(33656002)(71190400001)(81166006)(81156014)(316002)(7696005)(305945005)(2906002)(66066001)(68736007)(86362001)(3846002)(6436002)(229853002)(106356001)(97736004)(478600001)(486006)(105586002)(476003)(7736002)(76176011)(26005)(102836004)(53546011)(446003)(11346002)(6506007)(6916009)(186003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4918;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PKcKlHAsy7dMwdTVxlCMd5KI/SWbJ7cpBDqIp1iYsdbN6kE1+EN7SYJYGGoc8Q+nDgDGtcm52IfW+PvOdTf2p4mCMMy6toJZp++JvdHrVq5AQvbyNmTe2d0CD+Lh6F5j6j1RsarElnFHHoVKcvXZ622K92Yq97YJGk9Ru62E8GV4AL6/zbFDZ9JvjixuDmrV13mdghB1yQhznWHvHs2ZztksRMhdMzkuVnDdilJ2Wc2ydH3CzxUnJI869r7jhHgkj0gKGIeNFPtjp6LWmtwN5uXNc+sI7i5J780OuPBFJl98J46CVDmuuBkeV6HOTTVTqTo0dSTkN6z07RyKT0b8GCGhvk8wqpR2/0UyL+kxGKjsquJ8ZKwlJx6hte5+zVc1VrX+1Fe78tLLLgNJ+CYbtZ7LOcE+lMRtf8Oqifqxpfw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4468c9e0-c191-4545-4fa1-08d6bc1f33f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 12:39:11.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciBsb29rIGludG8gaXQgYW5kIHByb3ZpZGluZyB0aGUgQUNL
LiAgDQpJIGdvdCBvbmUgbWlub3IgY29tbWVudHMgZnJvbSBNb3JpdHogRmlzY2hlciBkbyB5b3Ug
d2FudCBtZSBmaXggdGhhdCBpc3N1ZSBub3cgb3IgSSBjYW4gZml4IGl0IGxhdGVyIGFzIGl04oCZ
cyBhIG1pbm9yIGNvbW1lbnQ/DQpJbiB3aGljaCBrZXJuZWwgdmVyc2lvbiBpIGNhbiBleHBlY3Qg
dGhpcyBkcml2ZXIgY2hhbmdlcz8/DQoNCg0KUmVnYXJkcywNCk5hdmFraXNob3JlLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsYW4gVHVsbCBbbWFpbHRvOmF0dWxs
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIsIDIwMTkgMTE6NTcgUE0NCj4g
VG86IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT4NCj4gQ2M6IE1vcml0eiBG
aXNjaGVyIDxtZGZAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBNYXJrDQo+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgTWljaGFsIFNpbWVrIDxt
aWNoYWxzQHhpbGlueC5jb20+OyBSYWphbg0KPiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IEpv
bGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsgbGludXgtDQo+IGZwZ2FAdmdlci5rZXJuZWwu
b3JnOyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRQ0KPiBUUkVF
IEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IG1vZGVyYXRlZCBsaXN0OkFS
TS9GUkVFU0NBTEUNCj4gSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUgPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWwgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+OyBraXNob3JlIG0NCj4gPGNoaW5uaWtpc2hvcmUzNjlAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gZnBnYSBtYW5hZ2VyOiBBZGRpbmcgRlBH
QSBNYW5hZ2VyIHN1cHBvcnQgZm9yDQo+IFhpbGlueCB6eW5xbXANCj4gDQo+IE9uIFR1ZSwgQXBy
IDIsIDIwMTkgYXQgNzozMiBBTSBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54
LmNvbT4NCj4gd3JvdGU6DQo+IA0KPiBIaSBOYXZhLA0KPiANCj4gTG9va3MgZ29vZC4NCj4gDQo+
ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgRlBHQSBNYW5hZ2VyIHN1cHBvcnQgZm9yIHRoZSBYaWxp
bnggWnlucU1QIGNoaXAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFu
bmUgPG5hdmEubWFubmVAeGlsaW54LmNvbT4NCj4gQWNrZWQtYnk6IEFsYW4gVHVsbCA8YXR1bGxA
a2VybmVsLm9yZz4NCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjQ6DQo+ID4gICAgICAg
ICAgICAgICAgIC1VcGRhdGVkIHRoZSBGcGdhIE1nciByZWdpc3RyYXRpb25zIGNhbGwncw0KPiA+
ICAgICAgICAgICAgICAgICAgdG8gNS4wDQo+ID4gICAgICAgICAgICAgICAgIC1SZW1vdmVkIGRt
YV9zZXRfbWFza19hbmRfY29oZXJlbnQoKSBBcyB0aGUgRlcNCj4gPiAgICAgICAgICAgICAgICAg
IHN1cHBvcnRzIG9ubHkgMzItYml0IGFkZHJlc3Mgb3BlcmF0aW9ucy4NCj4gPg0KPiA+IENoYW5n
ZXMgZm9yIHYzOg0KPiA+ICAgICAgICAgICAgICAgICAtQ3JlYXRlZCBwYXRjaGVzIG9uIHRvcCBv
ZiA1LjAtcmM1Lg0KPiA+ICAgICAgICAgICAgICAgICAgTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0K
PiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gICAgICAgICAgICAgICAgIC1GaXhlZCBzb21l
IG1pbm9yIGNvZGluZyBpc3N1ZXMgYXMgc3VnZ2VzdGVkIGJ5DQo+ID4gICAgICAgICAgICAgICAg
ICBNb3JpdHoNCj4gPg0KPiA+IENoYW5nZXMgZm9yIHYxOg0KPiA+ICAgICAgICAgICAgICAgICAt
Tm9uZS4NCj4gPg0KPiA+IENoYW5nZXMgZm9yIFJGQy1WMjoNCj4gPiAgICAgICAgICAgICAgICAg
LVVwZGF0ZWQgdGhlIEZwZ2EgTWdyIHJlZ2lzdHJhdGlvbnMgY2FsbCdzDQo+ID4gICAgICAgICAg
ICAgICAgICB0byA0LjE4DQo+IA0KPiBUaGFua3MsDQo+IEFsYW4NCg==
