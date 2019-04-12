Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25734C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VJIk+Axq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDLQQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:16:00 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:15753
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbfDLQQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/if1uT+Yisk4Cn4x2U3Ex7GyEeEP0m/rflHv89fgVQ=;
 b=VJIk+AxqhIjrg+TX/ddhCc48Z9OVnQcMReEplnVaCRDztsi32Lv3Z7YV42Mw5o6VwepJIRs0NYMqYJvyL4C6BgtV2Hxo1oMkn9Vulpl+FyfhgQKbHzH9zJ9QNqOk1Pw5N7pZQTncuHy4CH26llEj38OPtIdqwJJj5ORaZxYj994=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4567.eurprd05.prod.outlook.com (10.168.20.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 16:15:16 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::b463:4ddd:615c:f343]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::b463:4ddd:615c:f343%5]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 16:15:16 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Index: AQHU6x3BvT3IgEW16Emk4/JJP7JsJaYttpsAgAA2COCAAf5i9IAHIDaAgAGq5hA=
Date:   Fri, 12 Apr 2019 16:15:15 +0000
Message-ID: <DB6PR05MB32237EF42289A63B53433C14A1280@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1554406595-3128-1-git-send-email-lsun@mellanox.com>
 <CAHp75VdUwn1NEpSc0_Oc4wEh0TRzCwcE0_tajg3ak8BjfZ_-Mw@mail.gmail.com>
 <DB6PR05MB3223779DDDF815D2F5AFFE6BA1510@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <DB6PR05MB3223F6EA9E91F2564C24F5D5A1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <CAHp75Vfqi4Z3OrMsgeTJamJ61b7urAGkU2CKng8+Y-HvOGTvBQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfqi4Z3OrMsgeTJamJ61b7urAGkU2CKng8+Y-HvOGTvBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d9da30c-f7a3-44fa-ce43-08d6bf620cb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB4567;
x-ms-traffictypediagnostic: DB6PR05MB4567:
x-microsoft-antispam-prvs: <DB6PR05MB4567962D5327E17F476D5C32A1280@DB6PR05MB4567.eurprd05.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(39860400002)(376002)(396003)(346002)(136003)(189003)(13464003)(199004)(8936002)(478600001)(6916009)(2906002)(8676002)(25786009)(66066001)(11346002)(81166006)(81156014)(446003)(14444005)(71200400001)(71190400001)(7696005)(102836004)(54906003)(186003)(26005)(53936002)(55016002)(76176011)(53546011)(4326008)(6506007)(3846002)(6116002)(256004)(316002)(9686003)(6436002)(97736004)(229853002)(33656002)(52536014)(86362001)(6246003)(105586002)(14454004)(7736002)(476003)(486006)(106356001)(93886005)(99286004)(5660300002)(68736007)(74316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4567;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jsnFUtr4RkNrD5NbuUh0G8caINNYhvmSbkzObssphMWi4YXiIl+5C5QYw7PCPAeECZBgQxg2SIRaO4YNug2uoR2+ZL6djDmhn20QFIb1udVeDO7NcaTL8EnH7EmCORjiVAuSu5usB/AsTRyjn++mt1qMH/SJWfGSB4qd7LjEfs98lQbiiQUES3MTWpL1IcKz7e4cPmI+gcjSLqlfMM/EAGGMtmpNsTmHfJRWCDdnWvjG7wgANnJj7jHZ3xkopuyiNjQ4q1mLNl3K3jrDHMt08q8dt6z20kDgWEFdc3pkjJIvXof0f2Phu7w36M9TiApBXYmnxv48myc5CaqeT7kDGrqkHQmX4xh45J1l2HLY9gQ6Aa5XA5BrHmovpwhjivrwNNw1qmIM8qynZJnjSdoGluzLyE54wducu4Ay/bs0DvA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9da30c-f7a3-44fa-ce43-08d6bf620cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 16:15:15.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHkuIFBsZWFzZSBzZWUgbXkgcmVzcG9uc2UgYmVsb3cgZm9yIHRoaXMgZW1haWwg
YXMgd2VsbC4NCg0KLSBMaW1pbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAxOSAxMDoxMyBBTQ0KPiBUbzogTGltaW5nIFN1biA8bHN1
bkBtZWxsYW5veC5jb20+DQo+IENjOiBEYXZpZCBXb29kcyA8ZHdvb2RzQG1lbGxhbm94LmNvbT47
IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsgRGFycmVuIEhhcnQgPGR2aGFy
dEBpbmZyYWRlYWQub3JnPjsgVmFkaW0NCj4gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29t
PjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz47IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLQ0KPiB4ODZAdmdlci5rZXJuZWwu
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxM10gcGxhdGZvcm0vbWVsbGFub3g6IEFkZCBU
bUZpZm8gZHJpdmVyIGZvciBNZWxsYW5veCBCbHVlRmllbGQgU29jDQo+IA0KPiBPbiBTdW4sIEFw
ciA3LCAyMDE5IGF0IDU6MDUgQU0gTGltaW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+IHdyb3Rl
Og0KPiANCj4gPiA+ID4gKyAqIG1seGJmX3RtZmlmb19tc2dfaGRyIC0gU3RydWN0dXJlIG9mIHRo
ZSBUbUZpZm8gbWVzc2FnZSBoZWFkZXINCj4gPiA+ID4gKyAqIEB0eXBlOiBtZXNzYWdlIHR5cGUN
Cj4gPiA+ID4gKyAqIEBsZW46IHBheWxvYWQgbGVuZ3RoDQo+ID4gPiA+ICsgKiBAdTogNjQtYml0
IHVuaW9uIGRhdGENCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArdW5pb24gbWx4YmZfdG1maWZvX21z
Z19oZHIgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCB7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICB1OCB0eXBlOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgX19iZTE2IGxlbjsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIHU4IHVudXNlZFs1XTsNCj4gPiA+ID4gKyAgICAgICB9IF9fcGFja2Vk
Ow0KPiA+ID4gPiArICAgICAgIHU2NCBkYXRhOw0KPiA+ID4NCj4gPiA+IEknbSBub3Qgc3VyZSBJ
IHVuZGVyc3RhbmQgaG93IHlvdSBjYW4gZGlzdGluZ3Vpc2ggd2hpY2ggZmllbGQgb2YgdW5pb24g
dG8gdXNlPw0KPiA+ID4gSXNuJ3QgaGVyZSBzb21lIHR5cGUgbWlzc2VkPw0KPiA+DQo+ID4gVXBk
YXRlZCB0aGUgY29tbWVudCBpbiB2MTQuDQo+ID4NCj4gPiBUaGlzIG1lc3NhZ2UgaGVhZGVyIGlz
IGEgdW5pb24gb2Ygc3RydWN0IGFuZCB1NjQgZGF0YS4NCj4gPiBUaGUgJ3N0cnVjdCcgaGFzDQo+
ID4gdHlwZSBhbmQgbGVuZ3RoIGZpZWxkIHdoaWNoIGFyZSB1c2VkIHRvIGVuY29kZSAmIGRlY29k
ZSB0aGUgbWVzc2FnZS4NCj4gPiBUaGUgJ2RhdGEnIGZpZWxkIGlzIHVzZWQgdG8gcmVhZC93cml0
ZSB0aGUgbWVzc2FnZSBoZWFkZXIgZnJvbS90byB0aGUgRklGTy4NCj4gDQo+IFNvbWV0aGluZyBm
aXNoeSBoZXJlLg0KPiANCj4gWW91IGFyZSB1c2luZyBhIHN0cnVjdHVyZSBvZiBkYXRhIHdoaWNo
IHlvdSB3b3VsZCBsaWtlIHRvIHdyaXRlIHdpdGgNCj4gb25lIGNhbGw/IFBlcmhhcHMgeW91IG5l
ZWQgdG8gY29uc3RydWN0IHRoaXMgb24tdGhlLWZseS4NCg0KTG9va3MgbGlrZSAidW5pb24gY2F1
c2VzIGNvbmZ1c2lvbiIuDQpJIHdpbGwgdXBkYXRlIGl0IGluIHYxNSB0byBjb25zdHJ1Y3QgaXQg
b24tdGhlLWZseSBhcyBzdWdnZXN0ZWQuDQoNCj4gTW9yZW92ZXIsIHRoZSBfX2JlIG1lbWViZXIg
aXMgdXNlZCBpbiBhIGRhdGEgd2hpY2ggaXMgd3JpdHRlbiBhcyBMRS4NCj4gVGhpcyBuZWVkcyBt
b3JlIGV4cGxhbmF0aW9uLg0KDQpXaWxsIHVwZGF0ZSB0aGUgY29tbWVudCBmb3IgaXQgaW4gdjE1
LiAgQmVsb3cgYXJlIHNvbWUgZXhwbGFuYXRpb24gZm9yIGl0Lg0KDQpUaGUgJ0xFJyBpcyBmb3Ig
dGhlIGxvdy1sZXZlbCBtbWlvIHRyYW5zcG9ydCBsYXllci4gVGhlIFNvQyBzZW5kcyBkYXRhIHN0
cmVhbQ0KaW50byB0aGUgRklGTywgdGhlIG90aGVyIHNpZGUgcmVhZCBpdC4gVGhlIGJ5dGUtb3Jk
ZXIgb2YgdGhlIGRhdGEgc3RyZWFtIGtlZXBzDQp0aGUgc2FtZSB3aGVuIHRoZSBvdGhlciBzaWRl
IHJlYWRzIGl0LiBUaGUgIl9fYmUxNiIgaXMgZm9yIHRoZSBkcml2ZXIgb3IgDQphcHBsaWNhdGlv
biBvbiBib3RoIHNpZGVzIHRvIGFncmVlIG9uIGhvdyB0byBkZWNvZGUgdGhlICdsZW5ndGgnLg0K
DQpGb3IgZXhhbXBsZSwgdGhlIFNvQyBzaWRlIChsaXR0bGUgZW5kaWFuKSBzZW5kcyBhIG1lc3Nh
Z2Ugd2l0aA0KOC1ieXRlIG1lc3NhZ2UgaGVhZGVyICIwMSAwMiAwMyAwNCAwNSAwNiAwNyAwOCIg
aW50byB0aGUgRklGTy4gVGhlIG90aGVyDQpzaWRlIChhc3N1bWluZyBiaWcgZW5kaWFuIGhvc3Qg
bWFjaGluZSB1c2luZyBVU0IgYnVsayB0cmFuc2ZlcikgcmVhZHMgdGhlDQpzYW1lIGJ5dGUtc3Ry
ZWFtIGFuZCB0cnkgdG8gZGVjb2RlIGl0IHdpdGggdGhlIG1seGJmX3RtZmlmb19tc2dfaGRyLg0K
V2l0aG91dCB0aGUgIl9fYmUxNiIgY29udmVyc2lvbiwgdGhlIFNvQyBzaWRlIHdpbGwgdGhpbmsg
DQoidHlwZT0xLCBsZW5ndGg9MHgwMzAyIiB3aGlsZSB0aGUgYmlnIGVuZGlhbiBob3N0LXNpZGUg
d2lsbCB0aGluayANCiJ0eXBlPTEsIGxlbmd0aD0weDAyMDMiLg0KDQo+IA0KPiAtLQ0KPiBXaXRo
IEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
