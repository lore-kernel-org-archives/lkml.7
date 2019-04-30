Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF82BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7887720652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qbCNnBsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfD3MVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:21:07 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:54678
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfD3MVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnU8mPjPRDGNOr2LOTik8qUjgbRZruDoV4SexXvsrdY=;
 b=qbCNnBsN+wfbsjSSg7ADCiXm0fWcnyaWMOHi4MBJy/EyLa+KCWAtA7sx5/rUYedaK6BMXO5Qg6kPvrEfNUIe9Ucsyai+qi0km/dRBb5e3HTvSKIA9Ke1DktKQCXNS+SDXa9YuFlo+2nsaAYkXwrv1Tp2OwpC9IEoQKKRKUIyIrc=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB3642.eurprd08.prod.outlook.com (20.177.120.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 12:20:56 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 12:20:56 +0000
From:   Raphael Gault <Raphael.Gault@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Topic: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Index: AQHU7tulYY+OqZKg/k6QJwe1WY2Za6ZKSruAgAFe/4D///XuAIABEJyAgAB5AQCAB5dVgA==
Date:   Tue, 30 Apr 2019 12:20:56 +0000
Message-ID: <9a5f48e4-4846-7a47-48c6-52d937bf01e1@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190423203627.mwnaknit7cvr3l5l@treble>
 <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
 <20190424165640.5yeg2yicl7ej7g3i@treble>
 <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
 <20190425162528.mnmmierxxvixyoul@treble>
In-Reply-To: <20190425162528.mnmmierxxvixyoul@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::19) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db8e813-df1d-4226-6511-08d6cd664c15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3642;
x-ms-traffictypediagnostic: DB7PR08MB3642:
x-microsoft-antispam-prvs: <DB7PR08MB364215302D6FAAB8481841EFED3A0@DB7PR08MB3642.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(54094003)(189003)(199004)(40434004)(256004)(81166006)(25786009)(81156014)(8676002)(66476007)(53936002)(6916009)(66946007)(64756008)(66556008)(2906002)(446003)(476003)(2616005)(14454004)(6486002)(6246003)(71200400001)(72206003)(66446008)(4326008)(71190400001)(478600001)(6116002)(486006)(11346002)(8936002)(68736007)(3846002)(6512007)(5660300002)(73956011)(6436002)(44832011)(36756003)(14444005)(54906003)(99286004)(31696002)(7736002)(86362001)(229853002)(52116002)(31686004)(76176011)(26005)(93886005)(102836004)(6506007)(53546011)(97736004)(186003)(386003)(5024004)(316002)(305945005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3642;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tgduFhRO+GfbIOvYpx3gnOag9OvsjpNAoje0pgt7HF5db6G9xIAw0tMzvff5SuaPzhbx6zViEvcFXOTW28lz8bgMYsAcMkvLQanaAqklc181id7J3tR2zjQ3UFWTni1cfoBLUpr2m/OoYwN8DX5J0aJevj2Ok0vSo7mTWJvwtbnrPHwT4bt2s+oQY9j/d5olKXCeCOZjQU8gasn9JVGyvU4gVSW3/Z5a1nFWpoP+p6wmdqgk04jBbk43zcCQWN0XDPu+1ijtOBiWpY+dPl6I+AI0Dulf0w7uSB01EpTFD+Z0Mg723gixQhn2JXTmUpqVwY2xSsMZ5ub5eIwpwK6A+zXeidfq7Woo9Nq6hwBAOLdilQLOlmc+vtxGzI7Ci5kvZgW9dW6VlAHBN34lyASIuXIOvcKDVt9MIEaEcFqiQLk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DDC5356332FFC4DA7F0DAF2AD215C28@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db8e813-df1d-4226-6511-08d6cd664c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 12:20:56.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KT24gNC8yNS8xOSA1OjI1IFBNLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToNCj4g
T24gVGh1LCBBcHIgMjUsIDIwMTkgYXQgMDg6MTI6MjRBTSArMDAwMCwgUmFwaGFlbCBHYXVsdCB3
cm90ZToNCj4+IEhpIEpvc2gsDQo+Pg0KPj4gT24gNC8yNC8xOSA1OjU2IFBNLCBKb3NoIFBvaW1i
b2V1ZiB3cm90ZToNCj4+PiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCAwNDozMjo0NFBNICswMDAw
LCBSYXBoYWVsIEdhdWx0IHdyb3RlOg0KPj4+Pj4+IGRpZmYgLS1naXQgYS90b29scy9vYmp0b29s
L2FyY2gvYXJtNjQvZGVjb2RlLmMgYi90b29scy9vYmp0b29sL2FyY2gvYXJtNjQvZGVjb2RlLmMN
Cj4+Pj4+PiBpbmRleCAwZmViM2FlM2FmNWQuLjhiMjkzZWFlMmIzOCAxMDA2NDQNCj4+Pj4+PiAt
LS0gYS90b29scy9vYmp0b29sL2FyY2gvYXJtNjQvZGVjb2RlLmMNCj4+Pj4+PiArKysgYi90b29s
cy9vYmp0b29sL2FyY2gvYXJtNjQvZGVjb2RlLmMNCj4+Pj4+PiBAQCAtMTA1LDYgKzEwNSwzMyBA
QCB1bnNpZ25lZCBsb25nIGFyY2hfY29tcHV0ZV9yZWxhX3N5bV9vZmZzZXQoaW50IGFkZGVuZCkN
Cj4+Pj4+PiAgICAgcmV0dXJuIGFkZGVuZDsNCj4+Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4g
Ky8qDQo+Pj4+Pj4gKyAqIEluIG9yZGVyIHRvIGtub3cgaWYgd2UgYXJlIGluIHByZXNlbmNlIG9m
IGEgc2libGluZw0KPj4+Pj4+ICsgKiBjYWxsIGFuZCBub3QgaW4gcHJlc2VuY2Ugb2YgYSBzd2l0
Y2ggdGFibGUgd2UgbG9vaw0KPj4+Pj4+ICsgKiBiYWNrIGF0IHRoZSBwcmV2aW91cyBpbnN0cnVj
dGlvbnMgYW5kIHNlZSBpZiB3ZSBhcmUNCj4+Pj4+PiArICoganVtcGluZyBpbnNpZGUgdGhlIHNh
bWUgZnVuY3Rpb24gdGhhdCB3ZSBhcmUgYWxyZWFkeQ0KPj4+Pj4+ICsgKiBpbi4NCj4+Pj4+PiAr
ICovDQo+Pj4+Pj4gK2Jvb2wgYXJjaF9pc19pbnNuX3NpYmxpbmdfY2FsbChzdHJ1Y3QgaW5zdHJ1
Y3Rpb24gKmluc24pDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArc3RydWN0IGluc3RydWN0aW9uICpwcmV2
Ow0KPj4+Pj4+ICtzdHJ1Y3QgbGlzdF9oZWFkICpsOw0KPj4+Pj4+ICtzdHJ1Y3Qgc3ltYm9sICpz
eW07DQo+Pj4+Pj4gK2xpc3RfZm9yX2VhY2hfcHJldihsLCAmaW5zbi0+bGlzdCkgew0KPj4+Pj4+
ICtwcmV2ID0gKHZvaWQgKilsOw0KPj4+Pj4+ICtpZiAoIXByZXYtPmZ1bmMNCj4+Pj4+PiArfHwg
cHJldi0+ZnVuYy0+cGZ1bmMgIT0gaW5zbi0+ZnVuYy0+cGZ1bmMpDQo+Pj4+Pj4gK3JldHVybiBm
YWxzZTsNCj4+Pj4+PiAraWYgKHByZXYtPnN0YWNrX29wLnNyYy5yZWcgIT0gQURSX1NPVVJDRSkN
Cj4+Pj4+PiArY29udGludWU7DQo+Pj4+Pj4gK3N5bSA9IGZpbmRfc3ltYm9sX2NvbnRhaW5pbmco
aW5zbi0+c2VjLCBpbnNuLT5pbW1lZGlhdGUpOw0KPj4+Pj4+ICtpZiAoIXN5bSB8fCBzeW0tPnR5
cGUgIT0gU1RUX0ZVTkMNCj4+Pj4+PiArfHwgc3ltLT5wZnVuYyAhPSBpbnNuLT5mdW5jLT5wZnVu
YykNCj4+Pj4+PiArcmV0dXJuIHRydWU7DQo+Pj4+Pj4gK2JyZWFrOw0KPj4+Pj4+ICt9DQo+Pj4+
Pj4gK3JldHVybiB0cnVlOw0KPj4+Pj4+ICt9DQo+Pj4+Pg0KPj4+Pj4gSSBnZXQgdGhlIGZlZWxp
bmcgdGhlcmUgbWlnaHQgYmUgYSBiZXR0ZXIgd2F5IHRvIGRvIHRoaXMsIGJ1dCBJIGNhbid0DQo+
Pj4+PiBmaWd1cmUgb3V0IHdoYXQgdGhpcyBmdW5jdGlvbiBpcyBhY3R1YWxseSBkb2luZy4gIEl0
IGxvb2tzIGxpa2UgaXQNCj4+Pj4+IHNlYXJjaGVzIGJhY2t3YXJkcyBpbiB0aGUgZnVuY3Rpb24g
Zm9yIGFuIGluc3RydWN0aW9uIHdoaWNoIGhhcw0KPj4+Pj4gc3RhY2tfb3Auc3JjLnJlZyAhPSBB
RFJfU09VUkNFIC0tIHdoYXQgZG9lcyB0aGF0IG1lYW4/ICBBbmQgd2h5IGRvZXNuJ3QNCj4+Pj4+
IGl0IGRvIGFueXRoaW5nIHdpdGggdGhlIGluc3RydWN0aW9uIGFmdGVyIGl0IGZpbmRzIGl0Pw0K
Pj4+Pj4NCj4+Pj4NCj4+Pj4gSSB3aWxsIGluZGVlZCB0cnkgdG8gbWFrZSBpdCBiZXR0ZXIuDQo+
Pj4NCj4+PiBJIHN0aWxsIGRvbid0IHF1aXRlIGdldCB3aGF0IGl0J3MgdHJ5aW5nIHRvIGFjY29t
cGxpc2gsIGJ1dCBJIHdvbmRlciBpZg0KPj4+IHRoZXJlJ3Mgc29tZSBraW5kIG9mIHRyYWNraW5n
IHlvdSBjYW4gYWRkIGluIHZhbGlkYXRlX2JyYW5jaCgpIHRvIGtlZXANCj4+PiB0cmFjayBvZiB3
aGF0ZXZlciB5b3UncmUgbG9va2luZyBmb3IsIGxlYWRpbmcgdXAgdG8gdGhlIGluZGlyZWN0IGp1
bXAuDQo+Pj4NCj4+DQo+PiBUaGUgbW90aXZhdGlvbiBiZWhpbmQgdGhpcyBpcyB0aGF0IHRoZSBg
YnIgPFhuPmAgaW5zdHJ1Y3Rpb24gaXMgYQ0KPj4gZHluYW1pYyBqdW1wIChqdW1wIHRvIHRoZSBh
ZGRyZXNzIGNvbnRhaW5lZCBpbiB0aGUgcHJvdmlkZWQgcmVnaXN0ZXIpLg0KPj4gVGhpcyBpbnN0
cnVjdGlvbiBpcyB1c2VkIGZvciBzaWJsaW5nIGNhbGxzIGJ1dCBjYW4gYWxzbyBiZSB1c2VkIGZv
cg0KPj4gc3dpdGNoIHRhYmxlLiBJIHVzZSB0aGlzIHRvIGRpZmZlcmVudGlhdGUgdGhlc2UgdHdv
IGNhc2VzIGZyb20gb25lIGFub3RoZXI6DQo+Pg0KPj4gR2VuZXJhbGx5IHRoZSBgYWRyL2FkcnBg
IGluc3RydWN0aW9uIGlzIHVzZWQgcHJpb3IgdG8gYGJyYCBpbiBvcmRlciB0bw0KPj4gbG9hZCB0
aGUgYWRkcmVzcyBpbnRvIHRoZSByZWdpc3Rlci4gV2hhdCBJIGRvIGhlcmUgaXMgZ28gYmFjayB0
aHJvdWdodA0KPj4gdGhlIGluc3RydWN0aW9ucyBhbmQgdHJ5IHRvIGlkZW50aWZ5IGlmIHRoZSBh
ZGRyZXNzIGxvYWRlZC4NCj4+DQo+PiBJIGFsc28gdGhvdWdodCBvZiBpbXBsZW1lbnRpbmcgc29t
ZSBzb3J0IG9mIHRyYWNraW5nIGluIHZhbGlkYXRlIGJyYW5jaA0KPj4gYmVjYXVzZSBpdCBjb3Vs
ZCBiZSB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIHRoZSBzd2l0Y2ggdGFibGVzIGFzIHdlbGwuDQo+
PiBCdXQgaXQgc2VlbWVkIHRvIG1lIGxpa2UgYSBtYWpvciBjaGFuZ2UgaW4gdGhlIHNlbWVudGlj
IG9mIHRoaXMgdG9vbDoNCj4+IGluZGVlZCwgZnJvbSBteSBwZXJzcGVjdGl2ZSBJIHdvdWxkIGhh
dmUgdG8gdHJhY2sgdGhlIHN0YXRlIG9mIHRoZQ0KPj4gcmVnaXN0ZXJzIGFuZCBJIGRvbid0IGtu
b3cgaWYgd2Ugd2FudCB0byBkbyB0aGF0Lg0KPg0KPiBJIGRvbid0IGhhdmUgbXVjaCB0aW1lIHRv
IGxvb2sgYXQgdGhpcyB0b2RheSAoYW5kIEknbGwgYmUgb3V0IG5leHQNCj4gd2VlayksIGJ1dCB3
ZSBoYWQgYSBzaW1pbGFyIHByb2JsZW0gaW4geDg2LiAgU2VlIHRoZSBjb21tZW50cyBhYm92ZQ0K
PiBmaW5kX3N3aXRjaF90YWJsZSgpLCBwYXJ0aWN1bGFybHkgIzMuICBEb2VzIHRoYXQgZnVuY3Rp
b24gbm90IHdvcmsgZm9yDQo+IHRoZSBhcm02NCBjYXNlPw0KPg0KDQpIb25lc3RseSwgSSBkb24n
dCBoYXZlIGEgZnVsbCB1bmRlcnN0YW5kaW5nIG9mIGhvdyB0aGUgc3dpdGNoIHRhYmxlcyBhcmUN
CmhhbmRsZWQgb24gYXJtNjQuIEFsbCBJIGtub3cgaXMgdGhhdCBJJ3ZlIGlkZW50aWZpZWQgYSBj
YXNlIGluIHdoaWNoIGl0DQpkb2Vzbid0IHdvcmsgKGFuZCBJIGdldCBhbiB1bnJlYWNoYWJsZSBp
bnN0cnVjdGlvbiB3YXJuaW5nKS4NCldoZW4gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IHRoZSBz
d2l0Y2ggdGFibGVzIHdvcmsgb24gYXJtNjQgYW5kIGhvdw0Kb2JqdG9vbCBpcyByZXRyaWV2aW5n
IHRoZW0gKG9uIHg4NiBhdCBsZWFzdCkgSSByZWFsaXNlZCB0aGF0IHlvdSBsb29rDQpmb3IgMiBy
ZWxvY2F0aW9ucyA6DQotIE9uZSBmcm9tICgucmVsYSkudGV4dCB3aGljaCByZWZlcnMgdG8gdGhl
IC5yb2RhdGEgc2VjdGlvbg0KLSBPbmUgZnJvbSAoLnJlbGEpLnJvZGF0YSB3aGljaCByZWZlcnMg
c29tZXdoZXJlIGVsc2UuDQpPbiB0aGUgY2FzZSBJIGlkZW50aWZpZWQgdGhlIHNlY29uZCByZWxv
Y2F0aW9uIGRvZXNuJ3QgZXhpc3QgdGh1cyB0aGUNCmZ1bmN0aW9uIGRvZXNuJ3QgZmluZCB0aGUg
c3dpdGNoIHRhYmxlLg0KDQpBZ2FpbiBzaW5jZSBJIGRvIG5vdCBoYXZlIGEgZ29vZCB1bmRlcnN0
YW5kaW5nIGFib3V0IHRoaXMgSSBhbSBub3QgYWJsZQ0KdG8gc2F5IGlmIGl0IGlzIGEgY29ybmVy
IGNhc2Ugb3Igbm90Lg0KDQo+Pj4+Pj4gLWhhc2hfYWRkKGZpbGUtPmluc25faGFzaCwgJmluc24t
Pmhhc2gsIGluc24tPm9mZnNldCk7DQo+Pj4+Pj4gKy8qDQo+Pj4+Pj4gKyAqIEZvciBhcm02NCBh
cmNoaXRlY3R1cmUsIHdlIHNvbWV0aW1lIHNwbGl0IGluc3RydWN0aW9ucyBzbyB0aGF0DQo+Pj4+
Pj4gKyAqIHdlIGNhbiB0cmFjayB0aGUgc3RhdGUgZXZvbHV0aW9uIChpLmUuIGxvYWQvc3RvcmUg
b2YgcGFpcnMgb2YgcmVnaXN0ZXJzKS4NCj4+Pj4+PiArICogV2UgdGh1cyBuZWVkIHRvIHRha2Ug
Ym90aCBpbnRvIGFjY291bnQgYW5kIG5vdCBlcmFzZSB0aGUgcHJldmlvdXMgb25lcy4NCj4+Pj4+
PiArICovDQo+Pj4+Pg0KPj4+Pj4gRXcuLi4gIElzIHRoaXMgYW4gYXJjaGl0ZWN0dXJhbCB0aGlu
Zywgb3IganVzdCBhIHF1aXJrIG9mIHRoZSBhcm02NA0KPj4+Pj4gZGVjb2Rlcj8NCj4+Pj4+DQo+
Pj4+DQo+Pj4+IFRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIGlzIHRvIHNpbXVsYXRlIHRoZSB0d28g
Y29uc2VjdXRpdmUgb3BlcmF0aW9ucw0KPj4+PiB0aGF0IHdvdWxkIGJlIGV4ZWN1dGVkIG9uIHg4
NiBidXQgYXJlIGRvbmUgaW4gb25lIG9uIGFybTY0LiBUaGlzIGlzDQo+Pj4+IHN0cmljdGx5IGEg
ZGVjb2RlciByZWxhdGVkIHF1aXJrLiBJIGRvbid0IGtub3cgaWYgdGhlcmUgaXMgYSBiZXR0ZXIg
d2F5DQo+Pj4+IHRvIGRvIGl0IHdpdGhvdXQgbW9kaWZ5aW5nIHRoZSBzdHJ1Y3Qgb3Bfc3JjIGFu
ZCBzdHJ1Y3QgaW5zdHJ1Y3Rpb24uDQo+Pj4NCj4+PiBBaC4gIFdoaWNoIG9wcyBhcmUgdGhvc2U/
ICBIb3BlZnVsbHkgd2UgY2FuIGZpbmQgYSBiZXR0ZXIgd2F5IHRvDQo+Pj4gcmVwcmVzZW50IHRo
YXQgd2l0aCBhIHNpbmdsZSBpbnN0cnVjdGlvbi4gIEFkZGluZyBmYWtlIGluc3RydWN0aW9ucyBp
cw0KPj4+IGZyYWdpbGUuDQo+Pj4NCj4+DQo+PiBUaG9zZSBhcmUgdGhlIGxvYWQvc3RvcmUgb2Yg
cGFpcnMgb2YgcmVnaXN0ZXJzLCBtYWlubHkgc3RwL2xkcC4gVGhvc2UNCj4+IGFyZSBvZnRlbiB1
c2UgaW4gdGhlIGZ1bmN0aW9uIHByb2xvZ3Vlcy9lcGlsb2d1ZXMgdG8gc2F2ZS9yZXN0b3JlIHRo
ZQ0KPj4gc3RhY2sgcG9pbnRlcnMgYW5kIGZyYW1lIHBvaW50ZXJzIGhvd2V2ZXIgaXQgY2FuIGJl
IHVzZWQgd2l0aCBhbnkNCj4+IHJlZ2lzdGVyIHBhaXIuDQo+Pg0KPj4gVGhlIGlkZWEgdG8gYWRk
IGEgbmV3IGluc3RydWN0aW9uIGNvdWxkIHdvcmsgYnV0IEkgd291bGQgbmVlZCB0byBleHRlbmQN
Cj4+IHRoZSBgc3RydWN0IG9wX3NyY2AgYXMgd2VsbCBJIHRoaW5rLg0KPg0KPiBBZ2FpbiBJIGRv
bid0IGhhdmUgbXVjaCB0aW1lIHRvIGxvb2sgYXQgaXQsIGJ1dCBJIGRvIHRoaW5rIHRoYXQgY2hh
bmdpbmcNCj4gb3Bfc3JjL2Rlc3QgdG8gYWxsb3cgZm9yIHRoZSBzdHAvbGRwIGluc3RydWN0aW9u
cyB3b3VsZCB3b3JrIGJldHRlciB0aGFuDQo+IGluc2VydGluZyBhIGZha2UgaW5zdHJ1Y3Rpb24g
dG8gZW11bGF0ZSB4ODYuDQo+DQo+IE9yIGFub3RoZXIgaWRlYSB3b3VsZCBiZSB0byBhc3NvY2lh
dGUgbXVsdGlwbGUgc3RhY2tfb3BzIHdpdGggYSBzaW5nbGUNCj4gaW5zdHJ1Y3Rpb24uDQo+DQoN
CkkgaGF2ZW4ndCBsb29rZWQgYXQgaXQgaW4gZGVwdGggeWV0IGJ1dCBJIHdpbGwgdHJ5IHRvIGZp
Z3VyZSBvdXQgYSBnb29kDQp3YXkgdG8gcmVwcmVzZW50IHRob3NlIGluc3RydWN0aW9ucyBvbiBh
IG1vcmUgcHJvcGVyIG1hbm5lci4NCg0KVGhhbmtzLA0KDQotLQ0KUmFwaGFlbCBHYXVsdA0KSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5m
b3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
