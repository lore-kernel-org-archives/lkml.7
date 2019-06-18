Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9082C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDBE2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0yqDJgJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFRBnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:43:04 -0400
Received: from mail-eopbgr770082.outbound.protection.outlook.com ([40.107.77.82]:15429
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfFRBnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXam+TKFgnB3V32fuBcC25ezLEfWrxZIMviOChd2XL8=;
 b=0yqDJgJkhx876re5pXEB2apaHQ6uOnFL048O5sK43TO71r8J8BwkrD7WN9na2DjARCcRHhzIj2ODnde8qZNQJVH8Wx9w7zzXlzXQI3wfXHQbAKTeCVeSz1lWTGAuS85YuTE0xjL8oVQbwC19e+XR17mIH2Uos1aGpVfNGNiuTdY=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2969.namprd12.prod.outlook.com (20.178.29.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 01:43:01 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 01:43:01 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Topic: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Thread-Index: AQHVIvZEz1ndLb3IT0abs+80RMkH56afrj4AgAD6JoA=
Date:   Tue, 18 Jun 2019 01:43:00 +0000
Message-ID: <7a35c79d-370e-5595-234e-0aafc527331b@amd.com>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
 <20190617104740.GG27127@zn.tnic>
In-Reply-To: <20190617104740.GG27127@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:3:7b::14) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea8e251d-15d2-492d-35d7-08d6f38e4c02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2969;
x-ms-traffictypediagnostic: DM6PR12MB2969:
x-microsoft-antispam-prvs: <DM6PR12MB2969F11CCCB3DB8F0C59D32AECEA0@DM6PR12MB2969.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53546011)(25786009)(305945005)(2906002)(72206003)(7736002)(31696002)(229853002)(6916009)(86362001)(99286004)(2616005)(7416002)(486006)(53936002)(26005)(6512007)(76176011)(6486002)(31686004)(71190400001)(4326008)(14454004)(6246003)(256004)(6436002)(478600001)(102836004)(8936002)(36756003)(5660300002)(54906003)(316002)(66066001)(386003)(6116002)(81166006)(3846002)(81156014)(71200400001)(6506007)(66946007)(186003)(66476007)(446003)(66446008)(64756008)(66556008)(52116002)(8676002)(68736007)(73956011)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2969;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sv4579WVPRGXiaOwqYoyaCUERcc50p9Y3PVukIsS8NiG/fEgDS3WEeOo18dLqMLlF+0zU4KpOqo77GMmz9ULvjOcjDiEz3nX4chdHEH86mSVt8nFGLc0yByWxUpsAOrPf9b1oIR3piNKmtG1Nu3dN55CKDMPCN6uyYKSZE0oVvz4fazprTrhd9ZA+6qsnPv0OeW5TsTT16Qa1o7s3B6Rs1/eLsxxHmSpf29aXbIu0beqqdOStrU00zOlzoRPAoTTis/MV9Kaqsl+mVpgRW7f7EtVuZQcCr+rCcaBLYU5sty8BBAZHrJh8Dcpp85kP5KzoNN/AgKEVJgts1eZUMMZES7cp6nEGqhD1sLex/wD2ogvTuITin1PvyPfRBwsRV/s/6oNllosq6okxjIvX5l7ysauHS+eauDK63guy254kR8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3F582635EC6294E86C6D20535190D2E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8e251d-15d2-492d-35d7-08d6f38e4c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 01:43:00.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDYvMTcvMTkgNTo0NyBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBGcmks
IEp1biAxNCwgMjAxOSBhdCAwOToxNToxOFBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3Rl
Og0KPj4gVGhlIG1lbW9yeSBvY2N1cGllZCBieSB0aGUga2VybmVsIGlzIHJlc2VydmVkIHVzaW5n
IG1lbWJsb2NrX3Jlc2VydmUoKQ0KPj4gaW4gc2V0dXBfYXJjaCgpLiBDdXJyZW50bHksIHRoZSBh
cmVhIGlzIGZyb20gc3ltYm9scyBfdGV4dCB0byBfX2Jzc19zdG9wLg0KPj4gRXZlcnl0aGluZyBh
ZnRlciBfX2Jzc19zdG9wIG11c3QgYmUgc3BlY2lmaWNhbGx5IHJlc2VydmVkIG90aGVyd2lzZSBp
dA0KPj4gaXMgZGlzY2FyZGVkLiBUaGlzIGlzIG5vdCBjbGVhcmx5IGRvY3VtZW50ZWQuDQo+IA0K
PiBIbW0sIHNvIEkgc2VlIHRoaXMgaW4gYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgYWZ0
ZXIgX2VuZDoNCj4gDQo+ICAgICAgICAgX2VuZCA9IC47DQo+IA0KPiAgICAgICAgIFNUQUJTX0RF
QlVHDQo+ICAgICAgICAgRFdBUkZfREVCVUcNCj4gDQo+ICAgICAgICAgLyogU2VjdGlvbnMgdG8g
YmUgZGlzY2FyZGVkICovDQo+ICAgICAgICAgRElTQ0FSRFMNCj4gICAgICAgICAvRElTQ0FSRC8g
OiB7DQo+ICAgICAgICAgICAgICAgICAqKC5laF9mcmFtZSkNCj4gICAgICAgICB9DQo+IA0KPiBh
bmQgb3ZlciBESVNDQVJEUzoNCj4gDQo+IC8qDQo+ICAqIERlZmF1bHQgZGlzY2FyZGVkIHNlY3Rp
b25zLg0KPiAgKg0KPiAgKiBTb21lIGFyY2hzIHdhbnQgdG8gZGlzY2FyZCBleGl0IHRleHQvZGF0
YSBhdCBydW50aW1lIHJhdGhlciB0aGFuDQo+ICAqIGxpbmsgdGltZSBkdWUgdG8gY3Jvc3Mtc2Vj
dGlvbiByZWZlcmVuY2VzIHN1Y2ggYXMgYWx0IGluc3RydWN0aW9ucywNCj4gICogYnVnIHRhYmxl
LCBlaF9mcmFtZSwgZXRjLiAgRElTQ0FSRFMgbXVzdCBiZSB0aGUgbGFzdCBvZiBvdXRwdXQNCj4g
ICogc2VjdGlvbiBkZWZpbml0aW9ucyBzbyB0aGF0IHN1Y2ggYXJjaHMgcHV0IHRob3NlIGluIGVh
cmxpZXIgc2VjdGlvbg0KPiAgKiBkZWZpbml0aW9ucy4NCj4gICovDQo+ICNkZWZpbmUgRElTQ0FS
RFMNCj4gDQo+IFRoYXQgc291bmRzIGxpa2UgaXQgaXMgZG9jdW1lbnRlZCB0byBtZSwgb3IgZG8g
eW91IG1lYW4gc29tZXRoaW5nIGVsc2U/DQoNClllcyBhbmQgbm8uLi4gIGl0IGRvZXNuJ3Qgc2F5
IGhvdyBpdCBpcyBkb25lLCBuYW1lbHkgdGhyb3VnaCB0aGUgdXNlIG9mDQptZW1ibG9ja19yZXNl
cnZlKCkgY2FsbHMgYW5kIHdoZW4gYW5kIHdoZXJlIHRob3NlIG9jY3VyLg0KDQo+IA0KPj4gQWRk
IGEgbmV3IHN5bWJvbCwgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUsIHRoYXQgbW9yZSByZWFkaWx5
IGlkZW50aWZpZXMNCj4+IHdoYXQgaXMgcmVzZXJ2ZWQsIGFsb25nIHdpdGggY29tbWVudHMgdGhh
dCBpbmRpY2F0ZSB3aGF0IGlzIHJlc2VydmVkLA0KPj4gd2hhdCBpcyBkaXNjYXJkZWQgYW5kIHdo
YXQgbmVlZHMgdG8gYmUgZG9uZSB0byBwcmV2ZW50IGEgc2VjdGlvbiBmcm9tDQo+PiBiZWluZyBk
aXNjYXJkZWQuDQo+Pg0KPj4gQ2M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0KPj4gQ2M6
IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVG9t
IExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3NlY3Rpb25zLmggfCAyICsrDQo+PiAgYXJjaC94ODYva2VybmVsL3NldHVw
LmMgICAgICAgICB8IDggKysrKysrKy0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMu
UyAgIHwgOSArKysrKysrKy0NCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3NlY3Rpb25zLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWN0aW9ucy5oDQo+PiBpbmRleCA4
ZWExY2ZkYmVhYmMuLjcxYjMyZjI1NzBhYiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3NlY3Rpb25zLmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NlY3Rpb25z
LmgNCj4+IEBAIC0xMyw0ICsxMyw2IEBAIGV4dGVybiBjaGFyIF9fZW5kX3JvZGF0YV9hbGlnbmVk
W107DQo+PiAgZXh0ZXJuIGNoYXIgX19lbmRfcm9kYXRhX2hwYWdlX2FsaWduW107DQo+PiAgI2Vu
ZGlmDQo+PiAgDQo+PiArZXh0ZXJuIGNoYXIgX19lbmRfb2Zfa2VybmVsX3Jlc2VydmVbXTsNCj4+
ICsNCj4+ICAjZW5kaWYJLyogX0FTTV9YODZfU0VDVElPTlNfSCAqLw0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODYva2VybmVsL3NldHVwLmMNCj4+IGlu
ZGV4IDA4YTVmNGExMzFmNS4uMzJlYjcwNjI1YjNiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYv
a2VybmVsL3NldHVwLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jDQo+PiBAQCAt
ODI3LDggKzgyNywxNCBAQCBkdW1wX2tlcm5lbF9vZmZzZXQoc3RydWN0IG5vdGlmaWVyX2Jsb2Nr
ICpzZWxmLCB1bnNpZ25lZCBsb25nIHYsIHZvaWQgKnApDQo+PiAgDQo+PiAgdm9pZCBfX2luaXQg
c2V0dXBfYXJjaChjaGFyICoqY21kbGluZV9wKQ0KPj4gIHsNCj4+ICsJLyoNCj4+ICsJICogUmVz
ZXJ2ZSB0aGUgbWVtb3J5IG9jY3VwaWVkIGJ5IHRoZSBrZXJuZWwgYmV0d2VlbiBfdGV4dCBhbmQN
Cj4+ICsJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9scy4gQW55IGtlcm5lbCBzZWN0
aW9ucyBhZnRlciB0aGUNCj4+ICsJICogX19lbmRfb2Zfa2VybmVsX3Jlc2VydmUgc3ltYm9sIG11
c3QgYmUgZXhwbGljaXR5IHJlc2VydmVkIHdpdGggYQ0KPj4gKwkgKiBzZXBhcmF0ZSBtZW1ibG9j
a19yZXNlcnZlKCkgb3IgaXQgd2lsbCBiZSBkaXNjYXJkZWQuDQo+IA0KPiBzL2l0L3RoZXkvDQo+
IA0KPj4gKwkgKi8NCj4+ICAJbWVtYmxvY2tfcmVzZXJ2ZShfX3BhX3N5bWJvbChfdGV4dCksDQo+
PiAtCQkJICh1bnNpZ25lZCBsb25nKV9fYnNzX3N0b3AgLSAodW5zaWduZWQgbG9uZylfdGV4dCk7
DQo+PiArCQkJICh1bnNpZ25lZCBsb25nKV9fZW5kX29mX2tlcm5lbF9yZXNlcnZlIC0gKHVuc2ln
bmVkIGxvbmcpX3RleHQpOw0KPj4gIA0KPj4gIAkvKg0KPj4gIAkgKiBNYWtlIHN1cmUgcGFnZSAw
IGlzIGFsd2F5cyByZXNlcnZlZCBiZWNhdXNlIG9uIHN5c3RlbXMgd2l0aA0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC94ODYva2VybmVsL3ZtbGlu
dXgubGRzLlMNCj4+IGluZGV4IDA4NTBiNTE0OTM0NS4uY2EyMjUyY2E2YWQ3IDEwMDY0NA0KPj4g
LS0tIGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMNCj4+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC92bWxpbnV4Lmxkcy5TDQo+PiBAQCAtMzY4LDYgKzM2OCwxNCBAQCBTRUNUSU9OUw0KPj4g
IAkJX19ic3Nfc3RvcCA9IC47DQo+PiAgCX0NCj4+ICANCj4+ICsJLyoNCj4+ICsJICogVGhlIG1l
bW9yeSBvY2N1cGllZCBmcm9tIF90ZXh0IHRvIGhlcmUsIF9fZW5kX29mX2tlcm5lbF9yZXNlcnZl
LCBpcw0KPj4gKwkgKiBhdXRvbWF0aWNhbGx5IHJlc2VydmVkIGluIHNldHVwX2FyY2goKS4gQW55
dGhpbmcgYWZ0ZXIgaGVyZSBtdXN0IGJlDQo+PiArCSAqIGV4cGxpY2l0bHkgcmVzZXJ2ZWQgdXNp
bmcgbWVtYmxvY2tfcmVzZXJ2ZSgpIG9yIGl0IHdpbGwgYmUgZGlzY2FyZGVkDQo+PiArCSAqIGFu
ZCB0cmVhdGVkIGFzIGF2YWlsYWJsZSBtZW1vcnkuDQo+PiArCSAqLw0KPj4gKwlfX2VuZF9vZl9r
ZXJuZWxfcmVzZXJ2ZSA9IC47DQo+PiArDQo+PiAgCS4gPSBBTElHTihQQUdFX1NJWkUpOw0KPj4g
IAkuYnJrIDogQVQoQUREUiguYnJrKSAtIExPQURfT0ZGU0VUKSB7DQo+PiAgCQlfX2Jya19iYXNl
ID0gLjsNCj4+IEBAIC0zODIsNyArMzkwLDYgQEAgU0VDVElPTlMNCj4+ICAJU1RBQlNfREVCVUcN
Cj4+ICAJRFdBUkZfREVCVUcNCj4+ICANCj4+IC0JLyogU2VjdGlvbnMgdG8gYmUgZGlzY2FyZGVk
ICovDQo+IA0KPiBIdWg/DQo+IA0KPiBUaGV5J3JlIGNhbGxlZCBESVNDQVJEKiAuLi4NCg0KVGhl
IGNvbW1lbnQgYWJvdmUgaXMgbW9yZSBleHBsaWNpdCBhYm91dCB3aGF0IHdpbGwgYmUgZGlzY2Fy
ZGVkIGFuZA0KaG93IG5vdCB0byBoYXZlIGl0IGRpc2NhcmRlZCwgc28gSSByZW1vdmVkIHRoaXMg
Y29tbWVudC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+PiAgICAgICBESVNDQVJEUw0KPj4gICAg
ICAgL0RJU0NBUkQvIDogew0KPj4gICAgICAgICAgICAgICAqKC5laF9mcmFtZSkNCj4gDQo=
