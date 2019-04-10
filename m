Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DDC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F2B2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AVetMN1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDJTlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:41:55 -0400
Received: from mail-eopbgr740058.outbound.protection.outlook.com ([40.107.74.58]:63037
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfDJTly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrgS4LO1uTay9xOhmpgy/g/M/3TysV1nnylbq8b70DQ=;
 b=AVetMN1L5aS1oKU/LfT5dq2qHK+Bj21906yS6Tw6RbeWG/lo6xxiWKND2ShIaCGjSWWHVHNT1wPnZx/u9a7Ib27sVJ2Nz4fa4b4Mg+wLnx3LgPH6jritKfSMlZsWnTJ+Cf3rIRefPGZQ7AXdlKsMnlX5Sj3GkzeLa4X3xAq8r2Y=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 19:41:47 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 19:41:47 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Topic: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Thread-Index: AQHU7hUSVDLUqZVqKEupBAtcrt9jWqYyi0gAgAAIfUCAAbc/AIABTYIggAADjgCAAAApUIAADG2AgAAlB/A=
Date:   Wed, 10 Apr 2019 19:41:47 +0000
Message-ID: <SN6PR12MB2639F1786ED9F6BD261B1632F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
 <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410164036.GC26580@zn.tnic>
 <SN6PR12MB2639F37C634BC7F6D4B86194F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410172539.GF26580@zn.tnic>
In-Reply-To: <20190410172539.GF26580@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920b9cbf-0633-4c00-b38a-08d6bdec91c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-microsoft-antispam-prvs: <SN6PR12MB2640A40A24C673401745BC6AF82E0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(13464003)(2906002)(76176011)(316002)(478600001)(26005)(106356001)(72206003)(14444005)(256004)(105586002)(53546011)(6506007)(68736007)(71190400001)(14454004)(54906003)(186003)(6436002)(86362001)(93886005)(71200400001)(25786009)(4326008)(53936002)(6246003)(99286004)(446003)(305945005)(97736004)(7696005)(5660300002)(7736002)(486006)(74316002)(476003)(229853002)(55016002)(3846002)(6116002)(102836004)(52536014)(81166006)(33656002)(66066001)(81156014)(8936002)(11346002)(6916009)(8676002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vK2lN5+kxeAM232WvNj2Xc5r2TLKiD8hb53zSKJ0y3Js4wrH5oqOdj9xHYMuEbT9I8QRi0bX3jvlDj8pUqzY3PTLAfl43zMVYL0oW8S9T4or0qGOg9I8M3C8zobtbV5TYGglHCb4QIrWzIAAdfjdxy9V1AUQnZvJIxXp+Rq46aBkKX1BsTgG5tb0SuIdqGnUUXvO1Boeh6gPCS7i3sbJvXbUKHyc+h/lJ3LiMT/CJe11+8EyYATwTi+/AqEJKYkswFFWfvDMc+Kh/qOnUI3+NIpPP75M/lC+hCbSfAGWELucQWPsbhxoWUZuRDRqY/SbSbWrD+fOupkUhFR+Au+7EZkz1Yjil6yUqwgNsh4LpvrErBDtGYzJ/kn8QOmmLPZHVKVsMDTivlMMLSwyYftNyKY3Q/j9cmPziv6hSQBIU4U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920b9cbf-0633-4c00-b38a-08d6bdec91c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 19:41:47.3296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxMCwgMjAxOSAx
MjoyNiBQTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIFJFU0VORCAyLzVdIHg4Ni9NQ0U6IEhhbmRsZSBNQ0EgY29udHJvbHMgaW4gYSBwZXJf
Y3B1IHdheQ0KPiANCj4gT24gV2VkLCBBcHIgMTAsIDIwMTkgYXQgMDQ6NTg6MTJQTSArMDAwMCwg
R2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gWWVzLCB1bnVzZWQgYmFua3MgaW4gdGhlIG1pZGRs
ZSBhcmUgY291bnRlZCBpbiB0aGUgTUNHX0NBUFtDb3VudF0gdmFsdWUuDQo+IA0KPiBHb29kLg0K
PiANCj4gPiBPa2F5LCBzbyB5b3UncmUgc2F5aW5nIHRoZSBzeXNmcyBhY2Nlc3Mgc2hvdWxkIGZh
aWwgaWYgYSBiYW5rIGlzDQo+ID4gZGlzYWJsZWQuIElzIHRoYXQgY29ycmVjdD8NCj4gDQo+IFdl
bGwsIHRoaW5rIGFib3V0IGl0LiBJZiBhIGJhbmsgaXMgbm90IG9wZXJhdGlvbmFsIGZvciB3aGF0
ZXZlciByZWFzb24sDQo+IHdlIHNob3VsZCB0ZWxsIHRoZSB1c2VyIHRoYXQuDQo+IA0KPiA+IERv
ZXMgImRpc2FibGVkIiBtZWFuIG9uZSBvciBib3RoIG9mIHRoZXNlPw0KPiA+IFVudXNlZCA9IFJB
Wi9XSSBpbiBoYXJkd2FyZQ0KPiA+IFVuaW5pdGlhbGl6ZWQgPSBOb3QgaW5pdGlhbGl6ZWQgYnkg
a2VybmVsIGR1ZSB0byBxdWlya3MsIGV0Yy4NCj4gPg0KPiA+IEZvciBhbiB1bnVzZWQgYmFuaywg
aXQgZG9lc24ndCBodXJ0IHRvIHdyaXRlIE1DQV9DVEwsIGJ1dCByZWFsbHkNCj4gPiB0aGVyZSdz
IG5vIHJlYXNvbiB0byBkbyBzbyBhbmQgZ28gdGhyb3VnaCBtY2VfcmVzdGFydCgpLg0KPiANCj4g
WWVzLCBidXQgdGhhdCBiYW5rIGlzIG5vbi1vcGVyYXRpb25hbCBpbiBzb21lIGZvcm0uIFNvIHdl
IHNob3VsZCBwcmV2ZW50DQo+IGFsbCB3cml0ZXMgdG8gaXQgYmVjYXVzZSwgd2VsbCwgaXQgaXMg
bm90IGdvaW5nIHRvIGRvIGFueXRoaW5nLiBBbmQgdGhpcw0KPiB3b3VsZCBiZSBhIGdvb2Qgd2F5
IHRvIGdpdmUgZmVlZGJhY2sgdG8gdGhlIHVzZXIgdGhhdCB0aGF0IGlzIHRoZSBjYXNlLg0KPiAN
Cj4gPiBGb3IgYW4gdW5pbml0aWFsaXplZCBiYW5rLCBzaG91bGQgd2UgcHJldmVudCB1c2VycyBm
cm9tIG92ZXJyaWRpbmcgdGhlDQo+ID4ga2VybmVsJ3Mgc2V0dGluZ3M/DQo+IA0KPiBUaGF0IGFs
bCBkZXBlbmRzIG9uIHRoZSBxdWlya3MuIFdoZXRoZXIgd2Ugc2hvdWxkIGFsbG93IHRoZW0gdG8g
YmUNCj4gb3ZlcnJpZGRlbiBvciBub3QuIEkgZG9uJ3QgdGhpbmsgd2UndmUgZXZlciB0aG91Z2h0
IGFib3V0IGl0LCB0aG91Z2guDQo+IA0KPiBMZXQncyBsb29rIGF0IG9uZToNCj4gDQo+ICAgICAg
ICAgaWYgKGMtPng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQpIHsNCj4gICAgICAgICAgICAg
ICAgIGlmIChjLT54ODYgPT0gMTUgJiYgY2ZnLT5iYW5rcyA+IDQpIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgLyoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICogZGlzYWJsZSBHQVJU
IFRCTCB3YWxrIGVycm9yIHJlcG9ydGluZywgd2hpY2gNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICogdHJpcHMgb2ZmIGluY29ycmVjdGx5IHdpdGggdGhlIElPTU1VICYgM3dhcmUNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICogJiBDZXJiZXJ1czoNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFyX2JpdCgxMCwgKHVuc2ln
bmVkIGxvbmcgKikmbWNlX2JhbmtzWzRdLmN0bCk7DQo+IA0KPiANCj4gWWFoLCBzbyBpZiB0aGUg
dXNlciByZWVuYWJsZXMgdGhvc2UgR0FSVCBlcnJvcnMsIHRoZW4gc2hlL2hlIHdpbGwgc2VlIGEN
Cj4gbG90IG9mIE1DRXMgcmVwb3J0ZWQgYW5kIHdpbGwgbWF5YmUgY29tcGxhaW4gYWJvdXQgaXQu
IEFuZCB0aGVuIHdlJ2xsDQo+IHNheSwgYnV0IHdoeSBkaWQgeW91IGVuYWJsZSB0aGVtIHRoZW4u
IEFuZCBzaGUvaGUnbGwgc2F5OiB1aCwgZGlkbid0DQo+IGtub3cuIE9yLCBJIHdhcyBqdXN0IHBv
a2luZyBhdCBzeXNmcyBhbmQgdGhpcyBoYXBwZW5lZC4NCj4gDQo+IFRoZW4gd2UgY2FuIHNheSwg
d2VsbCwgZG9uJ3QgZG8gdGhhdCB0aGVuISA6LSkNCj4gDQo+IFNvIG15IGN1cnJlbnQgcG9zaXRp
b24gaXMsIG1laCwgd2hvIGNhcmVzLiBCdXQgdGhlbiBJJ20gbG9va2luZyBhdA0KPiBhbm90aGVy
IHF1aXJrOg0KPiANCj4gICAgICAgICBpZiAoYy0+eDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0lO
VEVMKSB7DQo+ICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAgICogU0RNIGRv
Y3VtZW50cyB0aGF0IG9uIGZhbWlseSA2IGJhbmsgMCBzaG91bGQgbm90IGJlIHdyaXR0ZW4NCj4g
ICAgICAgICAgICAgICAgICAqIGJlY2F1c2UgaXQgYWxpYXNlcyB0byBhbm90aGVyIHNwZWNpYWwg
QklPUyBjb250cm9sbGVkDQo+ICAgICAgICAgICAgICAgICAgKiByZWdpc3Rlci4NCj4gICAgICAg
ICAgICAgICAgICAqIEJ1dCBpdCdzIG5vdCBhbGlhc2VkIGFueW1vcmUgb24gbW9kZWwgMHgxYSsN
Cj4gICAgICAgICAgICAgICAgICAqIERvbid0IGlnbm9yZSBiYW5rIDAgY29tcGxldGVseSBiZWNh
dXNlIHRoZXJlIGNvdWxkIGJlIGENCj4gICAgICAgICAgICAgICAgICAqIHZhbGlkIGV2ZW50IGxh
dGVyLCBtZXJlbHkgZG9uJ3Qgd3JpdGUgQ1RMMC4NCj4gICAgICAgICAgICAgICAgICAqLw0KPiAN
Cj4gICAgICAgICAgICAgICAgIGlmIChjLT54ODYgPT0gNiAmJiBjLT54ODZfbW9kZWwgPCAweDFB
ICYmIGNmZy0+YmFua3MgPiAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBtY2VfYmFua3Nb
MF0uaW5pdCA9IDA7DQo+IA0KPiANCj4gd2hpY2ggYmFzaWNhbGx5IHByZXZlbnRzIHRoYXQgYmFu
ayBmcm9tIGJlaW5nIHJlaW5pdGlhbGl6ZWQuIFNvIEkgZ3Vlc3MNCj4gd2UgaGF2ZSB0aGF0IGZ1
bmN0aW9uYWxpdHkgYWxyZWFkeSAtIHdlIHNpbXBseSBuZWVkIHRvIHBheSBhdHRlbnRpb24gdG8N
Cj4gdy0+aW5pdC4NCj4gDQo+IFJpZ2h0Pw0KDQpPa2F5LCBJJ20gd2l0aCB5b3UuDQoNClNvIEkn
bSB0aGlua2luZyB0byBhZGQgYW5vdGhlciBwYXRjaCB0byB0aGUgc2V0LiBUaGlzIHdpbGwgc2V0
IG1jZV9iYW5rLmluaXQ9MCBpZiB3ZSByZWFkIE1DQV9DVEw9MCBmcm9tIHRoZSBoYXJkd2FyZS4N
Cg0KVGhlbiB3ZSBjaGVjayBpZiBtY2VfYmFuay5pbml0PTAgaW4gdGhlIHNldC9zaG93IGZ1bmN0
aW9ucyBhbmQgZ2l2ZSBhIG1lc3NhZ2UgaWYgdGhlIGJhbmsgaXMgbm90IHVzZWQuDQoNCkhvdyBk
b2VzIHRoYXQgc291bmQ/DQoNClRoYW5rcywNCllhemVuDQo=
