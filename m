Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D17920449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="BWYvFmNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392476AbfFMQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:34:28 -0400
Received: from mail-eopbgr30113.outbound.protection.outlook.com ([40.107.3.113]:62725
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730774AbfFMHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8265ax/934QuDUiBoQEZMb64RtPXDkWrDI0HvdAidU=;
 b=BWYvFmNsXaw0R2uEEp5e+cpqzyFVJgwCTO2Y1msk6d26wS9eaJ3XXj5iy+Feqkbk1+I69BNjd9ZKkwhtoslgSzGuDfJZ2Kx4IaptGo9A0ewE1g9FHG64DQfuSiqpfXysenWV5ncM+FVLnP93TmISVV1u3gHcl2FUkEVnGB/oBxA=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3417.eurprd02.prod.outlook.com (52.134.67.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 07:52:15 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 07:52:15 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 4/5] phy: ti: Add a new SERDES driver for TI's AM654x
 SoC
Thread-Topic: [PATCH v4 4/5] phy: ti: Add a new SERDES driver for TI's AM654x
 SoC
Thread-Index: AQHVIXFAm1a56jUsOECZ0qCoRiyFBqaZBiQAgAAwyYA=
Date:   Thu, 13 Jun 2019 07:52:15 +0000
Message-ID: <c990858e-5473-570a-221e-d2b3eea603a3@axentia.se>
References: <c357f9bc-dcf9-e8de-f879-f208e45a5b86@axentia.se>
 <ac361a0c-829c-41bb-64f0-bd74bb0c0dd6@ti.com>
In-Reply-To: <ac361a0c-829c-41bb-64f0-bd74bb0c0dd6@ti.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:7:29::47) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 172d4b6b-913d-48bb-cffd-08d6efd40d0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3417;
x-ms-traffictypediagnostic: DB3PR0202MB3417:
x-microsoft-antispam-prvs: <DB3PR0202MB34174DFE0A26822591223F73BCEF0@DB3PR0202MB3417.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39830400003)(136003)(199004)(189003)(446003)(486006)(2616005)(476003)(65826007)(31686004)(11346002)(229853002)(6436002)(68736007)(65806001)(65956001)(66066001)(6486002)(2501003)(64126003)(305945005)(25786009)(6506007)(53546011)(386003)(102836004)(76176011)(99286004)(52116002)(508600001)(58126008)(110136005)(74482002)(3846002)(14454004)(256004)(6246003)(53936002)(14444005)(2906002)(6116002)(7736002)(186003)(8936002)(81166006)(8676002)(81156014)(73956011)(71190400001)(5660300002)(36756003)(66946007)(71200400001)(316002)(6512007)(26005)(31696002)(66476007)(66446008)(64756008)(86362001)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3417;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SokUPjbo2T0YHCHQtQLZjSNQ+0ftmKZIn/LlZngTiTHdlEyWlP6+q6sL1P2cJ65cbwQGjAYj+DQMhoDxcnTaUbwyrdibgq8WMNqp+dAYj4nWeOD76sjSvNC+HLZcq4gDqxBPcn/qHgPR43A2c4xX0pzr3zWr6ahzo1Fx48jajzMU8atdsgq0mj071PkB/8qhfS2p2CEtK8OAzzTdI0fVJqP+hE8WzlINap5enL4Q8U3n5szSqFfxK6gON2Tm/uauzAYvcXqHyuPV7bq69Y9ZlPsW7tJ3GaAKChC0vSj4ZrHfW8q+I5ekW/Xa3i1cnZDUG7Ewz3q8YRWTY91W6HTZhWWrsRZBd0ZIfqNIoe1jcpWyZy2hEozJUv0nF6TihaBhXCsTJTWJfGv0gkqPTVKIIW8ouvFpYJ5aB7snwpvMsP8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A027ABDD4A080F4BA3C9A16AD81CFD43@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 172d4b6b-913d-48bb-cffd-08d6efd40d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 07:52:15.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIwMTktMDYtMTMgMDY6NTcsIEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgd3JvdGU6
DQo+IEhpIFBldGVyLA0KPiANCj4gT24gMTMvMDYvMTkgNDoyMCBBTSwgUGV0ZXIgUm9zaW4gd3Jv
dGU6DQo+PiBIaSENCj4+DQo+PiBbSSBrbm93IHRoaXMgaGFzIGFscmVhZHkgYmVlbiBtZXJnZWQg
dXBzdHJlYW0sIGJ1dCBJIG9ubHkganVzdA0KPj4gIG5vdyBub3RpY2VkIHRoZSBjb2RlIGFuZCB3
ZW50IHRvIHRoZSBhcmNoaXZlcyB0byBmaW5kIHRoZQ0KPj4gIG9yaWdpbmF0aW5nIG1haWwuIEkg
aG9wZSBJIG1hbmFnZWQgdG8gc2V0IGluLXJlcGx5LXRvIGNvcnJlY3RseS4uLl0NCj4+DQo+PiBU
aGUgbXV4IGhhbmRsaW5nIGlzIHByb2JsZW1hdGljIGFuZCBkb2VzIG5vdCBmb2xsb3cgdGhlIHJ1
bGVzLg0KPj4gSXQgbmVlZHMgdG8gYmUgZml4ZWQsIG9yIHlvdSBtYXkgZmFjZSBkZWFkbG9ja3Mu
IFNlZSBiZWxvdy4NCj4+DQo+PiBPbiAyMDE5LTA0LTA1IDExOjA4LCBLaXNob24gVmlqYXkgQWJy
YWhhbSBJIHdyb3RlOg0KPj4+IEFkZCBhIG5ldyBTRVJERVMgZHJpdmVyIGZvciBUSSdzIEFNNjU0
eCBTb0Mgd2hpY2ggY29uZmlndXJlcw0KPj4+IHRoZSBTRVJERVMgb25seSBmb3IgUENJZS4gU3Vw
cG9ydCBmbyBVU0IzIHdpbGwgYmUgYWRkZWQgbGF0ZXIuDQo+Pj4NCj4+PiBTRVJERVMgaW4gYW02
NTR4IGhhcyB0aHJlZSBpbnB1dCBjbG9ja3MgKGxlZnQgaW5wdXQsIGV4dGVybmVsIHJlZmVyZW5j
ZQ0KPj4+IGNsb2NrIGFuZCByaWdodCBpbnB1dCkgYW5kIHR3byBvdXRwdXQgY2xvY2tzIChsZWZ0
IG91dHB1dCBhbmQgcmlnaHQNCj4+PiBvdXRwdXQpIGluIGFkZGl0aW9uIHRvIGEgUExMIG11eCBj
bG9jayB3aGljaCB0aGUgU0VSREVTIHVzZXMgZm9yIENsb2NrDQo+Pj4gTXVsdGlwbGllciBVbml0
IChDTVUgcmVmY2xvY2spLg0KPj4+DQo+Pj4gVGhlIFBMTCBtdXggY2xvY2sgY2FuIHNlbGVjdCBm
cm9tIG9uZSBvZiB0aGUgdGhyZWUgaW5wdXQgY2xvY2tzLg0KPj4+IFRoZSByaWdodCBvdXRwdXQg
Y2FuIHNlbGVjdCBiZXR3ZWVuIGxlZnQgaW5wdXQgYW5kIGV4dGVybmFsIHJlZmVyZW5jZQ0KPj4+
IGNsb2NrIHdoaWxlIHRoZSBsZWZ0IG91dHB1dCBjYW4gc2VsZWN0IGJldHdlZW4gdGhlIHJpZ2h0
IGlucHV0IGFuZA0KPj4+IGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jay4NCj4+Pg0KPj4+IFRoZSBk
cml2ZXIgaGFzIHN1cHBvcnQgdG8gc2VsZWN0IFBMTCBtdXggYW5kIGxlZnQvcmlnaHQgb3V0cHV0
IG11eCBhcw0KPj4+IHNwZWNpZmllZCBpbiBkZXZpY2UgdHJlZS4NCj4+Pg0KPj4+IFtyb2dlcnFA
dGkuY29tOiBGaXggYm9vdCBsb2NrdXAgY2F1c2VkIGJ5IGFjY2Vzc2luZyBhIHN0cnVjdHVyZSBt
ZW1iZXINCj4+PiAoaHctPmluaXQpIGFsbG9jYXRlZCBpbiBzdGFjayBvZiBwcm9iZSgpIGFuZCBh
Y2Nlc3NlZCBpbiBnZXRfcGFyZW50XQ0KPj4+IFtyb2dlcnFAdGkuY29tOiBGaXggIkZhaWxlZCB0
byBmaW5kIHRoZSBwYXJlbnQiIHdhcm5pbmdzXQ0KPj4+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1
YWRyb3MgPHJvZ2VycUB0aS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogS2lzaG9uIFZpamF5IEFi
cmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCg0KKnNuaXAqDQoNCj4+PiArc3RhdGljIHZvaWQgc2Vy
ZGVzX2FtNjU0X3JlbGVhc2Uoc3RydWN0IHBoeSAqeCkNCj4+PiArew0KPj4+ICsJc3RydWN0IHNl
cmRlc19hbTY1NCAqcGh5ID0gcGh5X2dldF9kcnZkYXRhKHgpOw0KPj4+ICsNCj4+PiArCXBoeS0+
dHlwZSA9IFBIWV9OT05FOw0KPj4+ICsJcGh5LT5idXN5ID0gZmFsc2U7DQo+Pj4gKwltdXhfY29u
dHJvbF9kZXNlbGVjdChwaHktPmNvbnRyb2wpOw0KPj4NCj4+IEhlcmUgeW91IHVuY29uZGl0aW9u
YWxseSBkZXNlbGVjdCB0aGUgbXV4LCBhbmQgdGhhdCBzZWVtcw0KPj4gZGFuZ2Vyb3VzLiBBcmUg
eW91ICpzdXJlKiB0aGF0IC0+cmVsZWFzZSBtYXkgbm90IGJlIGNhbGxlZA0KPj4gd2l0aG91dCBh
IHN1Y2Nlc3NmdWwgeGxhdGUgY2FsbD8NCj4gDQo+IFllYWgsIHdpdGhvdXQgYSBzdWNjZXNzZnVs
IHhsYXRlKCksIHRoZSBjb25zdW1lciB3aWxsIG5ldmVyIGdldCBhIHJlZmVyZW5jZSB0bw0KPiB0
aGUgUEhZIGFuZCB0aGUgLT5yZWxlYXNlKCkgaXMgaW52b2tlZCBvbmx5IGZyb20gcGh5X3B1dCgp
IHdoaWNoIG5lZWRzIGENCj4gcmVmZXJlbmNlIHRvIHRoZSBQSFkuDQoNClllcywgSSB0aG91Z2h0
IGl0IG1pZ2h0IGJlIG9rLCBidXQgZ29vZCB0aGF0IHlvdSBjYW4gY29uZmlybSBpdC4NCg0KPj4g
SSdtIG5vdCAxMDAlIHN1cmUgb2YgdGhhdCwgYnV0IEkgaGF2ZSBub3QgbG9va2VkIGF0IHRoZSBw
aHkNCj4+IGNvZGUgYmVmb3JlIHRvZGF5LCBzbyBpdCBtYXkgdmVyeSB3ZWxsIGJlIHRoZSBjYXNl
IHRoYXQgdGhpcw0KPj4gaXMgc2FmZS4uLg0KPj4NCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RydWN0
IHBoeSAqc2VyZGVzX2FtNjU0X3hsYXRlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG9mX3Bo
YW5kbGVfYXJncw0KPj4+ICsJCQkJICphcmdzKQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3Qgc2VyZGVz
X2FtNjU0ICphbTY1NF9waHk7DQo+Pj4gKwlzdHJ1Y3QgcGh5ICpwaHk7DQo+Pj4gKwlpbnQgcmV0
Ow0KPj4+ICsNCj4+PiArCXBoeSA9IG9mX3BoeV9zaW1wbGVfeGxhdGUoZGV2LCBhcmdzKTsNCj4+
PiArCWlmIChJU19FUlIocGh5KSkNCj4+PiArCQlyZXR1cm4gcGh5Ow0KPj4+ICsNCj4+PiArCWFt
NjU0X3BoeSA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0KPj4+ICsJaWYgKGFtNjU0X3BoeS0+YnVz
eSkNCj4+PiArCQlyZXR1cm4gRVJSX1BUUigtRUJVU1kpOw0KPj4+ICsNCj4+PiArCXJldCA9IG11
eF9jb250cm9sX3NlbGVjdChhbTY1NF9waHktPmNvbnRyb2wsIGFyZ3MtPmFyZ3NbMV0pOw0KPj4+
ICsJaWYgKHJldCkgew0KPj4+ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHNlbGVjdCBTRVJE
RVMgTGFuZSBGdW5jdGlvblxuIik7DQo+Pj4gKwkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4+PiAr
CX0NCj4+DQo+PiAqSG93ZXZlcioNCj4+DQo+PiBIZXJlIHlvdSBzZWxlY3QgdGhlIG11eCBhcyB0
aGUgbGFzdCBhY3Rpb24sIGdvb2QsIGJ1dCwgYSBtdXggbXVzdA0KPj4gYmUgaGFuZGxlZCB3aXRo
IHRoYXQgc2FtZSBjYXJlIGFzIGEgbG9ja2luZyBwcmltaXRpdmUsIGkuZS4NCj4+IHN1Y2Nlc3Nm
dWwgc2VsZWN0cyBtdXN0IGJlIHBlcmZlY3RseSBiYWxhbmNlZCB3aXRoIGRlc2VsZWN0cy4gSQ0K
Pj4gc2VlIG5vIGd1YXJhbnRlZSBvZiB0aGF0IGhlcmUsIHNpbmNlIHRoZXJlIGFyZSBvdGhlciBm
YWlsdXJlcw0KPj4gcG9zc2libGUgYWZ0ZXIgdGhlIHhsYXRlIGNhbGwuIFNvLCBiZWluZyBsYXN0
IGluIHRoZSBmdW5jdGlvbg0KPj4gZG9lcyBub3QgcmVhbGx5IGhlbHAuIElmIEkgcmVhZCB0aGUg
Y29kZSBjb3JyZWN0bHksIHRoZQ0KPj4gcGh5IGNvcmUgbWF5IGZhaWwgaWYgdHJ5X21vZHVsZV9n
ZXQgZmFpbHMgaW4gcGh5X2dldCgpLiBJZiB0aGF0DQo+PiBldmVyIGhhcHBlbnMsIGEgc3VjY2Vz
c2Z1bCBjYWxsIHRvIG11eF9jb250cm9sX3NlbGVjdCBpcyBzaW1wbHkNCj4+IGZvcmdvdHRlbiwg
YW5kIHRoZSBtdXggd2lsbCBiZSBsb2NrZWQgaW5kZWZpbml0ZWx5Lg0KPiANCj4gR29vZCBjYXRj
aC4gV2hpbGUgYWRkaW5nIC0+cmVsZWFzZSgpIG9wcyB3aGljaCBpcyBvbmx5IGludm9rZWQgZnJv
bSBwaHlfcHV0LA0KPiBwZXJoYXBzIHRoaXMgd2FzIG1pc3NlZC4gSWRlYWxseSBpdCBzaG91bGQg
YmUgaW52b2tlZCBmcm9tIG90aGVyIHBsYWNlcyB3aGVyZQ0KPiB0aGVyZSBpcyBhIGZhaWx1cmUg
YWZ0ZXIgcGh5X2dldC4NCj4+DQo+PiBhbTY1NF9waHktPmJ1c3kgd2lsbCBhbHNvIGJlIHNldCBp
bmRlZmluaXRlbHksIHNvIHlvdSB3aWxsIGdldA0KPj4gLUVCVVNZIGFuZCBub3QgYSBoYXJkIGRl
YWRsb2NrLiBBdCBsZWFzdCBoZXJlLCBidXQgaWYgdGhlIG5vdw0KPj4gbG9ja2VkIG11eCBjb250
cm9sIGhhcHBlbnMgdG8gYWxzbyBjb250cm9sIHNvbWUgb3RoZXIgbXV4ZXMNCj4+IChwcm9iYWJs
eSB1bmxpa2VseSwgYnV0IGlmKSwgdGhlbiB0aGVpciBjb25zdW1lcnMgd2lsbCBwb3RlbnRpYWxs
eQ0KPj4gZGVhZGxvY2sgaGFyZC4gQnV0IHRoYXQncyBqdXN0IGFmdGVyIGEgY3Vyc29yeSByZWFk
aW5nLCBzbyBJIG1heQ0KPj4gY29tcGxldGVseSBtaXNzIHNvbWV0aGluZy4uLg0KPiANCj4gVGhl
IC0+YnVzeSBoZXJlIHNob3VsZCBwcmV2ZW50IHR3byBjb25zdW1lcnMgdHJ5aW5nIHRvIGNvbnRy
b2wgdGhlIHNhbWUgbXV4Lg0KDQpBaGEsIHlvdSBkbyBub3Qgc2VlbSB0byBiZSBhd2FyZSB0aGF0
IG9uZSBtdXggY29udHJvbGxlciBjYW4NCmhhdmUgbXVsdGlwbGUgaW5kZXBlbmRlbnQgY29uc3Vt
ZXJzIChhIG11eCBpcyBub3QgbGlrZSBhIGdwaW8NCm9yIGEgcHdtIGluIHRoYXQgYXNwZWN0KS4g
V2hhdCBJJ20gdGFsa2luZyBhYm91dCBpcyBhIHNpbmdsZQ0KbXV4IGNvbnRyb2wgdGhhdCBjb250
cm9scyBzZXZlcmFsIHBhcmFsbGVsIG11eGVzLCBlYWNoIHdpdGggaXRzDQpvd24gY29uc3VtZXIu
IEluIHRoZSBzcGVjaWZpYyBjYXNlIHlvdSBhcmUgdGFyZ2V0aW5nLCB0aGF0IG1heQ0Kbm90IGJl
IHBvc3NpYmxlIGR1ZSB0byBzb21lIGhhcmR3YXJlIHJlYXNvbiBvciBzb21ldGhpbmcsIGJ1dA0K
bG9va2luZyBhdCBqdXN0IHRoaXMgZHJpdmVyICppdCogY2Fubm90IGtub3cgdGhhdCB0aGUgbXV4
IHdpbGwNCmJlIGF2YWlsYWJsZSBqdXN0IGJlY2F1c2UgaXQgaGFzIGEgbG9jYWwgLT5idXN5IGZs
YWcuDQoNCkZvciB0aGlzIGNhc2UsIEkgZ2V0IHRoZSBmZWVsaW5nIHRoYXQgdGhlIG11eCBtYXkg
YmUgc2VsZWN0ZWQgZm9yDQphIHZlcnkgbG9uZyB0aW1lLCByaWdodD8gSXQgaXMgbmV2ZXIgYWJv
dXQgc2VsZWN0aW5nIHRoZSBtdXgsDQpkb2luZyBzb21ldGhpbmcgZm9yIHggbWlsbGkvbWljcm9z
ZWNvbmRzIG9yIHNvIGFuZCB0aGVuIGRlc2VsZWN0aW5nDQp0aGUgbXV4LiBQZXJoYXBzIHRoZSBt
dXggd2lsbCB0eXBpY2FsbHkgc2l0IGluIHRoZSBzYW1lIHN0YXRlIGZvcg0KdGhlIGVudGlyZSB1
cHRpbWUgb2YgdGhlIG1hY2hpbmU/DQoNCklmIHlvdSBoYXZlIHRoZXNlIHZlcnkgbG9uZyBhY2Nl
c3MgcGF0dGVybnMsIHRoZSBzaGFyaW5nIGNhcGFiaWxpdHkNCm9mIHRoZSBtdXggY29udHJvbHMg
YXJlIHByZXR0eSBtdWNoIHVzZWxlc3MsIGFuZCBJIGhhdmUNCmNvbnRlbXBsYXRpbmcgYSBtdXgg
bW9kZSB0byBzdXBwb3J0IHRoaXMgY2FzZS4gSS5lLiB3aGVyZSB5b3UNCmxvY2svdW5sb2NrIHRo
ZSBtdXggY29udHJvbCBvbmNlIGF0IHByb2JlL3JlbGVhc2UgKG9yIHNpbWlsYXIpLA0KYW5kIHRo
ZW4gYmFzaWNhbGx5IGluc3RlYWQgb2YgYSBzaGFyZWQgbXV4IGdldCBhbiBleGNsdXNpdmUgbXV4
DQp3aGVyZSB0aGUgY29uc3VtZXIgaXMgcmVzcG9uc2libGUgZm9yIG5vdCBtYWtpbmcgcGFyYWxs
ZWwgYWNjZXNzZXMuDQpJbiBvdGhlciB3b3JkcywganVzdCBsaWtlIGEgZ3BpbyBvciBhIHB3bS4N
Cg0KVGhlIHByb2JsZW0gaXMgdGhhdCBJIHRoZW4gbmVlZCBhIGRlZmluaXRpb24gb2YgImxvbmci
IGFuZCAic2hvcnQiDQphY2Nlc3NlcywgYW5kIEkgc3BsaXQgdGhlIG11eCB1bml2ZXJzZSBpbiB0
d28uLi4NCg0KPj4gVGhpbmtpbmcgc29tZSBtb3JlLCB0aGUgYWJvdmUgbWVudGlvbmVkIGZvcmdv
dHRlbiBwaHkgcHJvYmxlbQ0KPj4gaW4gZmFjdCBsb29rcyBsaWtlIGEgZ2VuZXJpYyBsZWFrIGlu
IHBoeV9nZXQuIEl0IHdpbGwgc2ltcGx5DQo+PiBsZWFrIGFueSBhbmQgYWxsIHBoeXMgd2hlcmUg
dGhlIG93bmVyIG1vZHVsZSBpcyBub3QgeWV0DQo+PiBhdmFpbGFibGUuIE9yLCBhbSBJIG1pc3Np
bmcgc29tZXRoaW5nPw0KPiANCj4geWVzIHlvdSBhcmUgcmlnaHQuIElkZWFsbHkgd2Ugc2hvdWxk
IGhhdmUgaW52b2tlZCAtPnJlbGVhc2UoKSBhZnRlciBwaHlfZ2V0KCkNCj4gZmFpbHVyZXMuDQo+
Pg0KPj4gUGVyaGFwcyBmaXhpbmcgdGhhdCBpcyBhbGwgdGhhdCBpcyBuZWVkZWQgdG8gbWFrZSB0
aGUgbXV4DQo+PiBzZWxlY3QvZGVzZWxlY3QgY2FsbHMgZ3VhcmFudGVlZCB0byBiZSBiYWxhbmNl
ZD8NCj4gDQo+IFRoYXQncyBjb3JyZWN0LiBUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzLg0KDQpO
byBwcm9ibGVtIQ0KDQpDaGVlcnMsDQpQZXRlcg0K
