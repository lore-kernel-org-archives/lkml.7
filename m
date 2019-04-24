Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E8B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WRYBWXcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfDXMqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:46:01 -0400
Received: from mail-eopbgr110114.outbound.protection.outlook.com ([40.107.11.114]:6835
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbfDXMqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHlkzz3rmH4owxkjeJpTab7AuT0ByAEbSaKHUBaB4y4=;
 b=WRYBWXcLVuUUS+Vztmy5aNfEXZC9wWSbsyPwHd09ltkJso1NEjE44tRYrt8kQDzNmUSOZy+vteSiStLv2YeWrrGfeIJXLER9ZYsa2+Y6EBtXEjK/WB1zEkCn6TGu4AlqSOGCyrf8tkY26TpXVMvMqCmVQQ5F5QHKP/HUuoxPzz4=
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM (20.176.139.20) by
 LO2P265MB1615.GBRP265.PROD.OUTLOOK.COM (20.176.145.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Wed, 24 Apr 2019 12:45:56 +0000
Received: from LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d5c0:cf6f:4b60:ae19]) by LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d5c0:cf6f:4b60:ae19%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 12:45:56 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Guo Ren <guoren@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>,
        Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Scott Wood <swood@redhat.com>,
        "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Thread-Topic: [PATCH] riscv: Support non-coherency memory model
Thread-Index: AQHU+SJqOw/bzOFv7E6YG/Ezkj/376ZIW7QAgACE3wCAAF+NAIAApRkAgAATvgCAAJneAIAAEuQggAAtFoCAAHI8gA==
Date:   Wed, 24 Apr 2019 12:45:56 +0000
Message-ID: <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
 <20190424055703.GA3417@guoren-Inspiron-7460>
In-Reply-To: <20190424055703.GA3417@guoren-Inspiron-7460>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::14) To LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8c::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary@garyguo.net; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:630:212:238:3697:f6ff:fe55:55b1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c780389-5b05-4da5-a139-08d6c8b2cb54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600141)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:LO2P265MB1615;
x-ms-traffictypediagnostic: LO2P265MB1615:
x-microsoft-antispam-prvs: <LO2P265MB1615507BF1770FD72D3989CCD63C0@LO2P265MB1615.GBRP265.PROD.OUTLOOK.COM>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(346002)(376002)(366004)(189003)(199004)(6506007)(7416002)(508600001)(53546011)(386003)(31696002)(25786009)(6246003)(102836004)(86362001)(6916009)(99286004)(8676002)(4326008)(7736002)(14454004)(81166006)(229853002)(2906002)(305945005)(81156014)(6486002)(97736004)(68736007)(52116002)(71200400001)(71190400001)(93886005)(476003)(53936002)(66946007)(73956011)(76176011)(6116002)(446003)(6512007)(11346002)(66476007)(8936002)(2616005)(36756003)(64756008)(66446008)(46003)(256004)(486006)(186003)(5660300002)(66556008)(54906003)(31686004)(6436002)(316002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:LO2P265MB1615;H:LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: garyguo.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ge//13D2PSS4WQ2QG4ap+Wv/KsdnX7YJ/h2mYOCRJS++FcVp8xuzpBmxzRSoKDHxAeazzNdnZoivV944w57JOJhLFrtOMI32Lhvd5Fdh+RquhjweL0x8YtlV5FuwwN5IySrw0eJgtXNKVvQcsioci0JWWFkR+4SVQjyP28NE3bPJyNTcI2YZAPFQLFSHQkRd9tATgNJn1ZD7/iZQgm46uG+7h4/NnPClSql1TGrQ7iru7cueg1iuSIjuCkJP+aJ4rlNE+cH8EKMNhHv8/kNr3WiLo689dmm69oL5aEv7wd9fs7/pNX9yg6KwgKB1hrO8BRqMGU6NvDfRKduVQlFR5sHuG1kWiTFs51gHajh1DvLKvrlAzRRn6kVV1HUzP9G5bsB9vmGmLnYDiRjHLv4653u6gIsgtm1Rf9tKXADF7o8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CB84A4D67FB29409C60DE8990A6CA97@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c780389-5b05-4da5-a139-08d6c8b2cb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:45:56.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB1615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI0LzA0LzIwMTkgMDY6NTcsIEd1byBSZW4gd3JvdGU6DQo+IEhpIEdhcnksDQo+IA0K
PiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCAwMzoyMToxNEFNICswMDAwLCBHYXJ5IEd1byB3cm90
ZToNCj4+PiBMb29rOg0KPj4+IGxpbnV4LW5leHQgZ2l0OihyaXNjdl9hc2lkX2FsbG9jYXRvcl92
MikkIGdyZXAgR0xPQkFMIGFyY2gvcmlzY3YgLXINCj4+PiBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNt
L3BndGFibGUtYml0cy5oOiNkZWZpbmUgX1BBR0VfR0xPQkFMICAgICgxIDw8IDUpICAgIC8qDQo+
Pj4gR2xvYmFsICovDQo+Pj4gYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLWJpdHMuaDog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfUEFHRV9VU0VSIHwNCj4+PiBfUEFH
RV9HTE9CQUwpKQ0KPj4+DQo+Pj4gWW91ciBwYXRjaCB0ZWxsIHVzIF9QQUdFX1VTRVIgYW5kIF9Q
QUdFX0dMT0JBTCBhcmUgZHVwbGljYXRlIGFuZCB3aHkgd2UNCj4+PiBjb3VsZG4ndCBtYWtlIF9Q
QUdFX1VTRVIgaW1wbGllcyBfUEFHRV9HTE9CQUw/IENhbiB5b3UgZ2l2ZSBhbiBleGFtcGxlDQo+
Pj4gb2YgYSByZWFsIHNjZW5lIGluIFBURSBhYm91dDoNCj4+PiAgICBfUEFHRV9VU0VSOjAgKyBf
UEFHRV9HTE9CQUw6MQ0KPj4+IG9yDQo+Pj4gICAgX1BBR0VfVVNFUjoxICsgX1BBR0VfR0xPQkFM
OjANCj4+Pg0KPj4+IE9mIGNhdXNlIEkga25vdyBVU0VSICYgR0xPQkFMIGFyZSBjb25jZXB0dWFs
bHkgdmVyeSBkaWZmZXJlbnQsIGJ1dA0KPj4+IHRoZXJlIGFyZSBvbmx5IDEwIGF0dHJpYnV0ZS1i
aXRzIGZvciByaXNjdiAoSW4gZmFjdCB3ZSd2ZSB3YXN0ZWQgdHdvIGJpdHMNCj4+PiB0byBzdXBw
b3J0IGh1Z2UgUlYzMi1wZm4gOlApLiBTbyBJIHRoaW5rIGl0IGlzIHRpbWUgdG8gbWVyZ2UgdGhl
c2UgdHdvIGJpdHMNCj4+PiBiZWZvcmUgaGFyZHdhcmUgc3VwcG9ydHMgR0xPQkFMLiBSZXNlcnZl
IHRoZW0gZm9yIGZ1dHVyZSENCj4+DQo+PiBUd28gY2FzZXMgSSBjYW4gdGhpbmsgb2Y6DQo+PiAq
IHZkc28gbGlrZSB0aGluZ3MuIFRoZXkncmUgdXNlciBwYWdlcyB0aGF0IGNhbiByZWFsbHkgYmUg
c2hhcmVkIGFjcm9zcyBhZGRyZXNzIHNwYWNlcyAoaS5lLiBnbG9iYWwpLiBLZXJuZWxzIGxpa2Ug
TDQgaW1wbGVtZW50IG1vc3Qgc3lzdGVtcyBjYWxscyBzaW1pbGFyIHRvIFZEU08sIHNvIFVTRVIg
KyBHTE9CQUwgaXMgdXNlZnVsLg0KPiBWZHNvIGlzIGEgdXNlciBzcGFjZSBtYXBwaW5nIGluIGxp
bnV4LCBTZWU6IGZzL2JpbmZtdF9lbGYuYw0KPiANCj4gc3RhdGljIGludCBsb2FkX2VsZl9iaW5h
cnkoc3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSkgew0KPiAuLi4NCj4gI2lmZGVmIEFSQ0hfSEFT
X1NFVFVQX0FERElUSU9OQUxfUEFHRVMNCj4gCXJldHZhbCA9IGFyY2hfc2V0dXBfYWRkaXRpb25h
bF9wYWdlcyhicHJtLCAhIWVsZl9pbnRlcnByZXRlcik7DQo+IAlpZiAocmV0dmFsIDwgMCkNCj4g
CQlnb3RvIG91dDsNCj4gI2VuZGlmIC8qIEFSQ0hfSEFTX1NFVFVQX0FERElUSU9OQUxfUEFHRVMg
Ki8NCj4gDQo+IEFsbCBsaW51eCBhcmNocyB1c2UgYXJjaF9zZXR1cF9hZGRpdGlvbmFsX3BhZ2Vz
IGZvciB2ZHNvIG1hcHBpbmcgYW5kDQo+IGV2ZXJ5IHByb2Nlc3MgaGFzIGl0cyBvd24gdmRzbyBt
YXBwaW5nIHRvIHRoZSBzYW1lIHBhZ2VzLg0KDQpCdXQgd2Ugc2hvdWxkbid0IHByZXZlbnQgYSBr
ZXJuZWwgZnJvbSBtYXBwaW5nIGEgVVNFUiBwYWdlIGdsb2JhbGx5LiBBcyANCkkgc2FpZCwgdGhl
IGZhY3QgdGhhdCBMaW51eCBkb2Vzbid0IGRvIGl0IGlzbid0IGEgdmFsaWQgcmVhc29uIGZvciAN
Cm9taXR0aW5nIHRoZSBwb3NzaWJpbGl0eS4NCg0KPiANCj4gSSBkb24ndCB0aGluayB2ZHNvIGlz
IGEgcmVhbCBzY2VuZSBmb3IgR0xPQkFMIGluIFBURS4NCj4gDQo+PiAqIGh5cGVydmlzb3Igd2l0
aG91dCBILWV4dGVuc2lvbjogVGhpcyByZXF1aXJlcyBzaGFkb3cgcGFnZSB0YWJsZXMuIFN1cGVy
dmlzb3INCj4+IHBhZ2VzIGFyZSBtYXBwZWQgdG8gc3VwZXJ2aXNvciBzaGFkb3cgcGFnZXMuIEhv
d2V2ZXIgdGhlc2Ugc2hhZG93IHBhZ2VzIGNhbm5vdA0KPj4gYmUgR0xPQkFMIGJlY2F1c2UgdGhl
eSBjYW4ndCBiZSBzaGFyZWQgYmV0d2VlbiBWTXMuIFNvICAhVVNFUiArICFHTE9CQUwgaXMgdXNl
ZnVsLg0KPiBIeXBlcnZpc29yIHVzZSAyLXN0YWdlcyBUTEIgdHJhbnNsYXRpb24gaW4gaGFyZHdh
cmUgYW5kIHNoYWRvdyBwYWdlDQo+IHRhYmxlcyBpcyBmb3Igc3RhZ2UgMiB0cmFuc2xhdGlvbi4g
U2hhZG93IHBhZ2UgdGFibGVzIGNhcmUgdm1pZCBub3QNCj4gYXNpZC4NCg0KV2hlbiBILWV4dGVu
c2lvbiBpcyBwcmVzZW50LCBzdGFnZSAyIHRyYW5zbGF0aW9uIHVzZXMgVk1JRCBhbmQgaXMgDQpw
ZXJmb3JtZWQgYnkgaGFyZHdhcmUuIFdoZW4gSC1leHRlbnNpb24gaXMgbm90IHByZXNlbnQsIHRo
ZXJlJ3Mgbm8gc3VjaCANCnRoaW5nIGNhbGxlZCBWTUlELiBXaGVuIEgtZXh0ZW5zaW9uIGlzIG5v
dCBwcmVzZW50LCBib3RoIGh5cGVydmlzb3IgYW5kIA0KZ3Vlc3Qgc3VwZXJ2aXNvciB3aWxsIHJ1
biBpbiBzdXBlcnZpc29yIG1vZGUsIGFuZCBoeXBlcnZpc29yIHVzZXMgDQpNU1RBVFVTLlRWTSB0
byB0cmFwIGd1ZXN0IHN1cGVydmlzb3IgdmlydHVhbCBtZW1vcnkgb3BlcmF0aW9ucy4gVGhlIA0K
c2hhZG93IHBhZ2UgdGFibGUgaXMgcG9wdWxhdGVkIGJ5IGRvaW5nIDItc3RhZ2UgcGFnZSB3YWxr
IGluIHNvZnR3YXJlLiANCkluIHRoaXMgY2FzZSwgdGhlIGh5cGVydmlzb3IgbGlrZWx5IG5lZWRz
IHRvIHVzZSBzb21lIGJpdHMgb2YgQVNJRCB0byANCmVtdWxhdGUgdGhlIFZNSUQgZmVhdHVyZS4g
SW4gdGhpcyBjYXNlIEdMT0JBTCBwYWdlIGNhbm5vdCBiZSB1c2VkIGFzIGl0IA0KbWVhbnMgdGhh
dCB0aGUgcGFnZSBleGlzdHMgaW4gYWxsIHBoeXNpY2FsIEFTSURzICh3aGljaCBjb250YWlucyBi
b3RoIA0KZW11bGF0ZWQgVk1JRCBhbmQgQVNJRCkuIEhhdmluZyBzdXBlcnZpc29yIHBhZ2VzIGJl
aW5nIEdMT0JBTCBtYWtlcyB0aGUgDQpzZW1hbnRpY3MgaW5jb3JyZWN0IQ0KDQo+IElmIGhhcmR3
YXJlIGRvbid0IHN1cHBvcnQgSC1leHRlbnNpb24gKE1NVSAyLXN0YWdlcyB0cmFuc2xhdGlvbiks
IGl0J3MNCj4gaGFyZCB0byBhY2NlcHQgZm9yIHZpcnR1YWxpemF0aW9uIHBlcmZvcm1hbmNlLg0K
DQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlYyBpcyBleHBsaWNpdGx5IGRlc2lnbmVkIHRvIGFs
bG93IHRoZSANCnRlY2huaXF1ZXMgZGVzY3JpYmVkIGFib3ZlICh0aGlzIGlzIHRoZSBzb2xlIHB1
cnBvc2Ugb2YgTVNUQVRVUy5UVk0pLiBJdCANCm1pZ2h0IGJlIGFzIGhpZ2ggcGVyZm9ybWFuY2Ug
YXMgYSBoYXJkd2FyZSB3aXRoIEgtZXh0ZW5zaW9uLCBidXQgaXMgDQpkZWZpbml0ZWx5IGEgbGVn
aXQgdXNlIGNhc2UuIEluIGZhY3QsIGl0IGlzIHZpdGFsIGZvciB1c2UgY2FzZXMgbGlrZSANCnJl
Y3Vyc2l2ZSB2aXJ0dWFsaXphdGlvbi4NCg0KQWxzbywgSSBiZWxpZXZlIHRoZSBQVEUgZm9ybWF0
IG9mIFJJU0MtViBpcyBhbHJlYWR5IGZyb3plbiAtLSB0aGVyZWZvcmUgDQppdCBpcyBpbXBvc3Np
YmxlIG5vdyB0byBtZXJnZSBHTE9CQUwgYW5kIFVTRVIgYml0LCBub3IgdG8gcmVwbGFjZSBSU1cg
DQpiaXQgd2l0aCBhbm90aGVyIGJpdC4NCg0KPiANCj4gSSBkb24ndCB0aGluayBoeXBlcnZpc29y
IGlzIGEgcmVhbCBzY2VuZSBmb3IgR0xPQkFMIGluIFBURS4NCj4gDQo+IEFyZSB0aGVyZSBvdGhl
ciBzY2VuZSBmb3IgR0xPQkFMIGluIFBURT8NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiAgIEd1byBS
ZW4NCj4gDQo=
