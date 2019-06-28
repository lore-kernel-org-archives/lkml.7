Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F52147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q7WQVF5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF1EVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:21:00 -0400
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:15368
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfF1EU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsvWNfOxi2Ue0lJ40xxSADLSnceUh6GCKhjptto6I44=;
 b=Q7WQVF5ddwt2Bx/4xfG5KQhD4bWR6O9w2j/3QtakLQtZSXW6yyj6PkGVkUgUCcJlfD4anTibiYML3baYlSWaWMV5ThO6FywpabmnySR28SPRoCFEFIA5lGP2rulBTvgQhwsWd7OO1eLlf1cv+lpb3scBVoJmy7ARVoe0iqSvTMY=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB3946.namprd02.prod.outlook.com (20.176.74.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 04:20:54 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2008.017; Fri, 28 Jun 2019
 04:20:54 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasureshkumarrelli@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHVJlmqVOb6xhW5BUqvdsCoslaAraavvckAgADG9PA=
Date:   Fri, 28 Jun 2019 04:20:53 +0000
Message-ID: <DM6PR02MB4779965BBC6278653DAD62FFAFFC0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20181212100931.149b0cac@xps13>
        <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212141825.69711c57@xps13>
        <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181217174114.24196d17@xps13>
        <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181219152647.76f77711@xps13>
        <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20190128102720.70a52da7@xps13>
        <20190619044424.GB28766@xhdnagasure40.xilinx.com>
 <20190627182742.6389d772@xps13>
In-Reply-To: <20190627182742.6389d772@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8087f9c6-b585-4256-42ae-08d6fb8002d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB3946;
x-ms-traffictypediagnostic: DM6PR02MB3946:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR02MB3946EBC203E23A14FE4C3C4CAFFC0@DM6PR02MB3946.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(13464003)(102836004)(81156014)(76116006)(81166006)(4326008)(305945005)(74316002)(229853002)(11346002)(64756008)(476003)(446003)(486006)(68736007)(66446008)(8936002)(66476007)(76176011)(66556008)(7696005)(3846002)(6116002)(66946007)(7736002)(99286004)(73956011)(256004)(14444005)(7416002)(9686003)(6246003)(6306002)(33656002)(55016002)(53936002)(14454004)(52536014)(26005)(5660300002)(8676002)(6436002)(966005)(71200400001)(316002)(86362001)(25786009)(54906003)(66066001)(66574012)(478600001)(110136005)(53546011)(6506007)(186003)(71190400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB3946;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZRmhSrepcqhfmKo1bLFD54ryjsMU2JQu6jw2tWBUEHru1ajOI2gb0n8Ugm6skcvQk2M7M1knsKDUbSxzRCGjzneLw57LqcuUSvZhBPLCyLf5bsiECs4ZGzWSc8ajhPv2oxWVwfwd11OghzUJpfMZKQWStSEuhMrDb1Bg6s/s0l6QnSTmCzwrtDpj/ZldVovLovyqG0oH2iL1EhlIJ60rjGnDH8cUD9ZrCeobMFcdOuCLy7ZodlhphyL5n6PdBF+Rhp5M5lMkou9/wxRZOWCX8LIpLAynsE1HYBYoHUVBjXiHlQ0IKmOJt1z+hY+mEpNUUkjDLh28yEr+5EPhe28iiz0eM3AO44CnFNS6NDu3kHF4Qg6+myNeRa/D7DMUKQ1rJ+akVD0OCfUUMAb6HbyzpA3fZE2wzzWWs5/AEpk6mog=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8087f9c6-b585-4256-42ae-08d6fb8002d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 04:20:54.0059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBK
dW5lIDI3LCAyMDE5IDk6NTggUE0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2Fz
dXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNvbT4NCj4gQ2M6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkg
PG5hZ2FzdXJlQHhpbGlueC5jb20+OyByb2JoQGtlcm5lbC5vcmc7IG1hcnRpbi5sdW5kQGtlZXAt
aXQtDQo+IHNpbXBsZS5jb207IHJpY2hhcmRAbm9kLmF0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBCb3JpcyBCcmV6aWxsb24NCj4gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBuYWdhc3VyZXNoMTJAZ21haWwuY29tOw0K
PiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IGNvbXB1dGVyc2ZvcnBlYWNlQGdt
YWlsLmNvbTsgZHdtdzJAaW5mcmFkZWFkLm9yZzsNCj4gbWFyZWsudmFzdXRAZ21haWwuY29tDQo+
IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjEyIDMvM10gbXRkOiByYXduYW5kOiBhcmFzYW46
IEFkZCBzdXBwb3J0IGZvciBBcmFzYW4gTkFORA0KPiBGbGFzaCBDb250cm9sbGVyDQo+IA0KPiBI
aSBOYWdhLA0KPiANCj4gTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVzaGt1bWFycmVs
bGlAZ21haWwuY29tPiB3cm90ZSBvbiBUdWUsDQo+IDE4IEp1biAyMDE5IDIyOjQ0OjI0IC0wNjAw
Og0KPiANCj4gPiBPbiBNb24sIEphbiAyOCwgMjAxOSBhdCAxMDoyNzozOUFNICswMTAwLCBNaXF1
ZWwgUmF5bmFsIHdyb3RlOg0KPiA+IEhpIE1pcXVlbCwNCj4gPg0KPiA+ID4gSGkgTmFnYSwNCj4g
PiA+DQo+ID4gPiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPiB3
cm90ZSBvbiBNb24sIDI4IEphbg0KPiA+ID4gMjAxOQ0KPiA+ID4gMDY6MDQ6NTMgKzAwMDA6DQo+
ID4gPg0KPiA+ID4gPiBIaSBCb3JpcyAmIE1pcXVlbCwNCj4gPiA+ID4NCj4gPiA+ID4gQ291bGQg
eW91IHBsZWFzZSBwcm92aWRlIHlvdXIgdGhvdWdodHMgb24gdGhpcyBkcml2ZXIgdG8gc3VwcG9y
dCBIVy1FQ0M/DQo+ID4gPiA+IEFzIEkgc2FpZCBwcmV2aW91c2x5LCB0aGVyZSBpcyBubyB3YXkg
dG8gZGV0ZWN0IGVycm9ycyBiZXlvbmQgTiBiaXQuDQo+ID4gPiA+IEkgYW0gb2sgdG8gdXBkYXRl
IHRoZSBkcml2ZXIgYmFzZWQgb24geW91ciBpbnB1dHMuDQo+ID4gPg0KPiA+ID4gV2Ugd29uJ3Qg
c3VwcG9ydCB0aGUgRUNDIGVuZ2luZS4gSXQgc2ltcGx5IGNhbm5vdCBiZSB1c2VkIHJlbGlhYmx5
Lg0KPiA+ID4NCj4gPiA+IEkgYW0gd29ya2luZyBvbiBhIGdlbmVyaWMgRUNDIGVuZ2luZSBvYmpl
Y3QuIEl0J3MgZ29ubmEgdGFrZSBhIGZldw0KPiA+ID4gbW9udGhzIHVudGlsIGl0IGdldHMgbWVy
Z2VkIGJ1dCBhZnRlciB0aGF0IHlvdSBjb3VsZCB1cGRhdGUgdGhlDQo+ID4gPiBjb250cm9sbGVy
IGRyaXZlciB0byBkcm9wIGFueSBFQ0MtcmVsYXRlZCBmdW5jdGlvbi4gQWx0aG91Z2ggdGhlIEVD
Qw0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSBsZXQgbWUga25vdyB0aGF0LCB3aGVuIGNhbiB3
ZSBleHBlY3QgZ2VuZXJpYyBFQ0MNCj4gPiBlbmdpbmUgdXBkYXRlIGluIG10ZCBOQU5EPw0KPiA+
IEJhc2VkIG9uIHRoYXQsIGkgd2lsbCBwbGFuIHRvIHVwZGF0ZSB0aGUgQVJBU0FOIE5BTkQgZHJp
dmVyIGFsb25nIHdpdGgNCj4gPiB5b3VyIGNvbW1lbnRzIG1lbnRpb25lZCBhYm92ZSB1bmRlciB0
aGlzIHVwZGF0ZSwgYXMgeW91IGtub3cgdGhlcmUgaXMNCj4gPiBhIGxpbWlhdGlvbiBpbiBBUkFT
QU4gTkFORCBjb250cm9sbGVyIHRvIGRldGVjdCBFQ0MgZXJyb3JzLg0KPiA+IGkgYW0gZm9sbG93
aW5nIHRoaXMgc2VyaWVzDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MDgzODcwNS8NCj4gDQo+IEl0IGlzIGdvbm5hIHRha2UgbW9yZSB0aW1lIHRoYW4gZXhwZWN0ZWQu
IFlvdSBjYW4gc3RpY2sgdG8gdGhlIHNvZnR3YXJlIGVuZ2luZXMgZm9yIG5vdy4NCk9rLiBJIHdp
bGwgdXBkYXRlIHRoZSBkcml2ZXIgYWNjb3JkaW5nbHkuDQoNClRoYW5rcywNCk5hZ2EgU3VyZXNo
a3VtYXIgUmVsbGkNCg0KPg0KIA0KPiBUaGFua3MsDQo+IE1pcXXDqGwNCg==
