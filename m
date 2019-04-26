Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C62084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="eDTSZgd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDZLli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:41:38 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com ([40.107.4.118]:10916
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfDZLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnXW5toZFxCAg1ReVgpbF55pT1ypVbztVEOoHzEdz6Q=;
 b=eDTSZgd3MJvsZaQ7SrYT8ULgTured5aw32GibjApdsac/1iYO2Ajw3h/iYqp98b+JgbsBNbYqzpeyBRAo82VgDYCCwBc3qznFZidHnzLHKhCB1bAaDBkJBnQJCQfGEUqVbMVOmPyRxVw90/XnZQAWIjUk5EUCpKv7Sk6XxVzyEE=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3833.eurprd07.prod.outlook.com (52.133.7.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Fri, 26 Apr 2019 11:41:31 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::8c3f:5775:198e:e0e7]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::8c3f:5775:198e:e0e7%7]) with mapi id 15.20.1856.006; Fri, 26 Apr 2019
 11:41:31 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "astrachan@google.com" <astrachan@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Thread-Topic: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Thread-Index: AQHU88GVdiIeV/TyhkCfli2iaLO9taZOYnaA
Date:   Fri, 26 Apr 2019 11:41:30 +0000
Message-ID: <c9fc2241bb6687e6bfab50e329d81601ff6bc6bf.camel@nokia.com>
References: <20190415183726.036654568@linuxfoundation.org>
         <20190415183728.632579553@linuxfoundation.org>
In-Reply-To: <20190415183728.632579553@linuxfoundation.org>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a706550-3819-44a0-b7b0-08d6ca3c2087
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3833;
x-ms-traffictypediagnostic: HE1PR0702MB3833:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HE1PR0702MB3833653C2D6D0B779F2D34A5B43E0@HE1PR0702MB3833.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(52314003)(6306002)(6512007)(6436002)(66066001)(4326008)(76176011)(6246003)(110136005)(6486002)(54906003)(2501003)(5660300002)(316002)(6116002)(3846002)(476003)(99286004)(53936002)(186003)(2616005)(508600001)(71190400001)(446003)(11346002)(71200400001)(2906002)(7736002)(305945005)(25786009)(256004)(7416002)(14444005)(36756003)(76116006)(486006)(966005)(8936002)(14454004)(66476007)(66556008)(64756008)(66446008)(86362001)(73956011)(68736007)(66946007)(6506007)(97736004)(229853002)(102836004)(26005)(81156014)(81166006)(8676002)(118296001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3833;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V5zK/r7beucRWpiONk8QV7SHj4lOnneeTcLxweqMLgZCAQCfd+4gWkSx2smVGsLiGnRrcaG1cP4a61egZf+pgOJuts1MyZDtkXH1iHsdtRw7/7jDzSDgOD4DyiX08g0LP5LBOgxKOwTaUKXBl1Eg/0NWbcOT/5/nTE9Co/SglNnc6LCGhysCV38FxA0NstMTh/cnzVMOE3z+0ne3UbPlvrI1ZpjWEOi/+Cn+GYyoLw0CwKJ33iN1NzB3EGtN4CVf497G9myG1lvdEuA2cmaOYq3NfSBIDNp2COeq/tdcHttHcOWiNNwqFm5TzCqZPzXCh8SqsRsCFPw8fCNiGg9H7H0GR/tSZpT9o4ig33GCvluj9KtW/2oftMopaiQVWMSW4nP135xZ0VOlnDsufukOYig7AtqQExKaNPSllZOza7s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91D490A3FD40949BE996B2CFC4EB398@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a706550-3819-44a0-b7b0-08d6ca3c2087
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 11:41:31.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTE1IGF0IDIwOjU4ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IGNvbW1pdCAzNzlkOThkZGY0MTM0NDI3M2Q5NzE4NTU2Zjc2MTQyMGY0ZGM4MGIzIHVw
c3RyZWFtLg0KPiANCg0KSGksDQoNCldpdGggdGhpcyBwYXRjaCBpbiA0LjE0LjExMiBidWlsZC1p
ZCBpcyBub3cgbWlzc2luZyBpbiB2ZHNvMzIuc286DQoNCiQgZmlsZSBhcmNoL3g4Ni9lbnRyeS92
ZHNvL3Zkc28qc28qDQphcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi5zbzogICAgIEVMRiAzMi1i
aXQgTFNCIHBpZSBleGVjdXRhYmxlLCBJbnRlbA0KODAzODYsIHZlcnNpb24gMSAoU1lTViksIGR5
bmFtaWNhbGx5IGxpbmtlZCwgc3RyaXBwZWQNCmFyY2gveDg2L2VudHJ5L3Zkc28vdmRzbzMyLnNv
LmRiZzogRUxGIDMyLWJpdCBMU0IgcGllIGV4ZWN1dGFibGUsIEludGVsDQo4MDM4NiwgdmVyc2lv
biAxIChTWVNWKSwgZHluYW1pY2FsbHkgbGlua2VkLCB3aXRoIGRlYnVnX2luZm8sIG5vdA0Kc3Ry
aXBwZWQNCmFyY2gveDg2L2VudHJ5L3Zkc28vdmRzbzY0LnNvOiAgICAgRUxGIDY0LWJpdCBMU0Ig
cGllIGV4ZWN1dGFibGUsIHg4Ni0NCjY0LCB2ZXJzaW9uIDEgKFNZU1YpLCBkeW5hbWljYWxseSBs
aW5rZWQsDQpCdWlsZElEW3NoYTFdPWQ4MDczMGE1YjU2MWEzMTYxZTQ4OGEzNjlkMWM3NmMyNTBi
NTg0YjQsIHN0cmlwcGVkDQphcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc282NC5zby5kYmc6IEVMRiA2
NC1iaXQgTFNCIHBpZSBleGVjdXRhYmxlLCB4ODYtDQo2NCwgdmVyc2lvbiAxIChTWVNWKSwgZHlu
YW1pY2FsbHkgbGlua2VkLA0KQnVpbGRJRFtzaGExXT1kODA3MzBhNWI1NjFhMzE2MWU0ODhhMzY5
ZDFjNzZjMjUwYjU4NGI0LCB3aXRoDQpkZWJ1Z19pbmZvLCBub3Qgc3RyaXBwZWQNCg0KDQpCYXNl
ZCBvbiBxdWljayBjaGVjaywgIiQoY2FsbCBsZC1vcHRpb24sIC0tYnVpbGQtaWQpIiBmYWlscyBk
dWUgdG8gc29tZQ0KMzIvNjQgYml0IG1pc21hdGNoLCBzbyB0aGUgLS1idWlsZC1pZCBsaW5rZXIg
ZmxhZyBpcyBub3QgdXNlZCB3aGVuDQpsaW5raW5nIHZkc28zMi5zbw0KDQpQZXJoYXBzIHNjcmlw
dHMvS2J1aWxkLmluY2x1ZGUgaXMgbWlzc2luZyBzb21lIGNoYW5nZSBpbiA0LjE0LnkgdG8gbWFr
ZQ0KdGhpcyB3b3JrIHByb3Blcmx5Lg0KDQotVG9tbWkNCg0KPiBUaGUgdmRzb3szMiw2NH0uc28g
Y2FuIGZhaWwgdG8gbGluayB3aXRoIENDPWNsYW5nIHdoZW4gY2xhbmcgdHJpZXMgdG8NCj4gZmlu
ZA0KPiBhIHN1aXRhYmxlIEdDQyB0b29sY2hhaW4gdG8gbGluayB0aGVzZSBsaWJyYXJpZXMgd2l0
aC4NCj4gDQo+IC91c3IvYmluL2xkOiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1l
Lm86DQo+ICAgYWNjZXNzIGJleW9uZCBlbmQgb2YgbWVyZ2VkIHNlY3Rpb24gKDc4MikNCj4gDQo+
IFRoaXMgaGFwcGVucyBiZWNhdXNlIHRoZSBob3N0IGVudmlyb25tZW50IGxlYWtlZCBpbnRvIHRo
ZSBjcm9zcw0KPiBjb21waWxlcg0KPiBlbnZpcm9ubWVudCBkdWUgdG8gdGhlIHdheSBjbGFuZyBz
ZWFyY2hlcyBmb3Igc3VpdGFibGUgR0NDDQo+IHRvb2xjaGFpbnMuDQo+IA0KPiBDbGFuZyBpcyBh
IHJldGFyZ2V0YWJsZSBjb21waWxlciwgYW5kIGVhY2ggaW52b2NhdGlvbiBvZiBpdCBtdXN0DQo+
IHByb3ZpZGUNCj4gLS10YXJnZXQ9PHNvbWV0aGluZz4gLS1nY2MtdG9vbGNoYWluPTxzb21ldGhp
bmc+IHRvIGFsbG93IGl0IHRvIGZpbmQNCj4gdGhlDQo+IGNvcnJlY3QgYmludXRpbHMgZm9yIGNy
b3NzIGNvbXBpbGF0aW9uLiBUaGVzZSBmbGFncyBoYWQgYmVlbiBhZGRlZCB0bw0KPiBLQlVJTERf
Q0ZMQUdTLCBidXQgdGhlIHZkc28gY29kZSB1c2VzIENDIGFuZCBub3QgS0JVSUxEX0NGTEFHUyAo
Zm9yDQo+IHZhcmlvdXMNCj4gcmVhc29ucykgd2hpY2ggYnJlYWtzIGNsYW5nJ3MgYWJpbGl0eSB0
byBmaW5kIHRoZSBjb3JyZWN0IGxpbmtlciB3aGVuDQo+IGNyb3NzDQo+IGNvbXBpbGluZy4NCj4g
DQo+IE1vc3Qgb2YgdGhlIHRpbWUgdGhpcyBnb2VzIHVubm90aWNlZCBiZWNhdXNlIHRoZSBob3N0
IGxpbmtlciBpcyBuZXcNCj4gZW5vdWdoDQo+IHRvIHdvcmsgYW55d2F5LCBvciBpcyBpbmNvbXBh
dGlibGUgYW5kIHNraXBwZWQsIGJ1dCB0aGlzIGNhbm5vdCBiZQ0KPiByZWxpYWJseQ0KPiBhc3N1
bWVkLg0KPiANCj4gVGhpcyBjaGFuZ2UgYWx0ZXJzIHRoZSB2ZHNvIG1ha2VmaWxlIHRvIGp1c3Qg
dXNlIExEIGRpcmVjdGx5LCB3aGljaA0KPiBieXBhc3NlcyBjbGFuZyBhbmQgdGh1cyB0aGUgc2Vh
cmNoaW5nIHByb2JsZW0uIFRoZSBtYWtlZmlsZSB3aWxsIGp1c3QNCj4gdXNlDQo+ICR7Q1JPU1Nf
Q09NUElMRX1sZCBpbnN0ZWFkLCB3aGljaCBpcyBhbHdheXMgd2hhdCB3ZSB3YW50LiBUaGlzDQo+
IG1hdGNoZXMgdGhlDQo+IG1ldGhvZCB1c2VkIHRvIGxpbmsgdm1saW51eC4NCj4gDQo+IFRoaXMg
ZHJvcHMgcmVmZXJlbmNlcyB0byBESVNBQkxFX0xUTzsgdGhpcyBvcHRpb24gZG9lc24ndCBzZWVt
IHRvIGJlDQo+IHNldA0KPiBhbnl3aGVyZSwgYW5kIG5vdCBrbm93aW5nIHdoYXQgaXRzIHBvc3Np
YmxlIHZhbHVlcyBhcmUsIGl0J3Mgbm90DQo+IGNsZWFyIGhvdw0KPiB0byBjb252ZXJ0IGl0IGZy
b20gQ0MgdG8gTEQgZmxhZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIFN0cmFjaGFu
IDxhc3RyYWNoYW5AZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IEFja2VkLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9A
a2VybmVsLm9yZz4NCj4gQ2M6ICJILiBQZXRlciBBbnZpbiIgPGhwYUB6eXRvci5jb20+DQo+IENj
OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBDYzog
a2VybmVsLXRlYW1AYW5kcm9pZC5jb20NCj4gQ2M6IGpvZWxAam9lbGZlcm5hbmRlcy5vcmcNCj4g
Q2M6IEFuZGkgS2xlZW4gPGFuZGkua2xlZW5AaW50ZWwuY29tPg0KPiBMaW5rOiANCj4gaHR0cHM6
Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE4MDgwMzE3MzkzMS4xMTc1MTUtMS1hc3RyYWNoYW5AZ29v
Z2xlLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxs
b3JAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5l
bC5vcmc+DQo+IC0tLQ0KPiAgYXJjaC94ODYvZW50cnkvdmRzby9NYWtlZmlsZSB8IDIyICsrKysr
KysrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vTWFr
ZWZpbGUNCj4gYi9hcmNoL3g4Ni9lbnRyeS92ZHNvL01ha2VmaWxlDQo+IGluZGV4IDBhNTUwZGM1
YzUyNS4uMGRlZmNjOTM5YWI0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL01h
a2VmaWxlDQo+ICsrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vTWFrZWZpbGUNCj4gQEAgLTQ4LDEw
ICs0OCw4IEBAIHRhcmdldHMgKz0gJCh2ZHNvX2ltZ19zb2RiZykNCj4gIA0KPiAgZXhwb3J0IENQ
UEZMQUdTX3Zkc28ubGRzICs9IC1QIC1DDQo+ICANCj4gLVZEU09fTERGTEFHU192ZHNvLmxkcyA9
IC1tNjQgLVdsLC1zb25hbWU9bGludXgtdmRzby5zby4xIFwNCj4gLQkJCS1XbCwtLW5vLXVuZGVm
aW5lZCBcDQo+IC0JCQktV2wsLXosbWF4LXBhZ2Utc2l6ZT00MDk2IC1XbCwteixjb21tb24tcGFn
ZS0NCj4gc2l6ZT00MDk2IFwNCj4gLQkJCSQoRElTQUJMRV9MVE8pDQo+ICtWRFNPX0xERkxBR1Nf
dmRzby5sZHMgPSAtbSBlbGZfeDg2XzY0IC1zb25hbWUgbGludXgtdmRzby5zby4xIC0tbm8tDQo+
IHVuZGVmaW5lZCBcDQo+ICsJCQkteiBtYXgtcGFnZS1zaXplPTQwOTYgLXogY29tbW9uLXBhZ2Ut
c2l6ZT00MDk2DQo+ICANCj4gICQob2JqKS92ZHNvNjQuc28uZGJnOiAkKHNyYykvdmRzby5sZHMg
JCh2b2JqcykgRk9SQ0UNCj4gIAkkKGNhbGwgaWZfY2hhbmdlZCx2ZHNvKQ0KPiBAQCAtMTAzLDEw
ICsxMDEsOCBAQCBDRkxBR1NfUkVNT1ZFX3Z2YXIubyA9IC1wZw0KPiAgIw0KPiAgDQo+ICBDUFBG
TEFHU192ZHNveDMyLmxkcyA9ICQoQ1BQRkxBR1NfdmRzby5sZHMpDQo+IC1WRFNPX0xERkxBR1Nf
dmRzb3gzMi5sZHMgPSAtV2wsLW0sZWxmMzJfeDg2XzY0IFwNCj4gLQkJCSAgIC1XbCwtc29uYW1l
PWxpbnV4LXZkc28uc28uMSBcDQo+IC0JCQkgICAtV2wsLXosbWF4LXBhZ2Utc2l6ZT00MDk2IFwN
Cj4gLQkJCSAgIC1XbCwteixjb21tb24tcGFnZS1zaXplPTQwOTYNCj4gK1ZEU09fTERGTEFHU192
ZHNveDMyLmxkcyA9IC1tIGVsZjMyX3g4Nl82NCAtc29uYW1lIGxpbnV4LXZkc28uc28uMSBcDQo+
ICsJCQkgICAteiBtYXgtcGFnZS1zaXplPTQwOTYgLXogY29tbW9uLXBhZ2UtDQo+IHNpemU9NDA5
Ng0KPiAgDQo+ICAjIDY0LWJpdCBvYmplY3RzIHRvIHJlLWJyYW5kIGFzIHgzMg0KPiAgdm9ianM2
NC1mb3IteDMyIDo9ICQoZmlsdGVyLW91dCAkKHZvYmpzLW5veDMyKSwkKHZvYmpzLXkpKQ0KPiBA
QCAtMTM0LDcgKzEzMCw3IEBAICQob2JqKS92ZHNveDMyLnNvLmRiZzogJChzcmMpL3Zkc294MzIu
bGRzDQo+ICQodm9iangzMnMpIEZPUkNFDQo+ICAJJChjYWxsIGlmX2NoYW5nZWQsdmRzbykNCj4g
IA0KPiAgQ1BQRkxBR1NfdmRzbzMyLmxkcyA9ICQoQ1BQRkxBR1NfdmRzby5sZHMpDQo+IC1WRFNP
X0xERkxBR1NfdmRzbzMyLmxkcyA9IC1tMzIgLVdsLC1tLGVsZl9pMzg2IC1XbCwtc29uYW1lPWxp
bnV4LQ0KPiBnYXRlLnNvLjENCj4gK1ZEU09fTERGTEFHU192ZHNvMzIubGRzID0gLW0gZWxmX2kz
ODYgLXNvbmFtZSBsaW51eC1nYXRlLnNvLjENCj4gIA0KPiAgIyBUaGlzIG1ha2VzIHN1cmUgdGhl
ICQob2JqKSBzdWJkaXJlY3RvcnkgZXhpc3RzIGV2ZW4gdGhvdWdoIHZkc28zMi8NCj4gICMgaXMg
bm90IGEga2J1aWxkIHN1Yi1tYWtlIHN1YmRpcmVjdG9yeS4NCj4gQEAgLTE4MCwxMyArMTc2LDEz
IEBAICQob2JqKS92ZHNvMzIuc28uZGJnOiBGT1JDRSBcDQo+ICAjIFRoZSBEU08gaW1hZ2VzIGFy
ZSBidWlsdCB1c2luZyBhIHNwZWNpYWwgbGlua2VyIHNjcmlwdC4NCj4gICMNCj4gIHF1aWV0X2Nt
ZF92ZHNvID0gVkRTTyAgICAkQA0KPiAtICAgICAgY21kX3Zkc28gPSAkKENDKSAtbm9zdGRsaWIg
LW8gJEAgXA0KPiArICAgICAgY21kX3Zkc28gPSAkKExEKSAtbm9zdGRsaWIgLW8gJEAgXA0KPiAg
CQkgICAgICAgJChWRFNPX0xERkxBR1MpICQoVkRTT19MREZMQUdTXyQoZmlsdGVyDQo+ICUubGRz
LCQoXkYpKSkgXA0KPiAtCQkgICAgICAgLVdsLC1ULCQoZmlsdGVyICUubGRzLCReKSAkKGZpbHRl
ciAlLm8sJF4pICYmIFwNCj4gKwkJICAgICAgIC1UICQoZmlsdGVyICUubGRzLCReKSAkKGZpbHRl
ciAlLm8sJF4pICYmIFwNCj4gIAkJIHNoICQoc3JjdHJlZSkvJChzcmMpL2NoZWNrdW5kZWYuc2gg
JyQoTk0pJyAnJEAnDQo+ICANCj4gLVZEU09fTERGTEFHUyA9IC1mUElDIC1zaGFyZWQgJChjYWxs
IGNjLWxkb3B0aW9uLCAtV2wkKGNvbW1hKS0taGFzaC0NCj4gc3R5bGU9Ym90aCkgXA0KPiAtCSQo
Y2FsbCBjYy1sZG9wdGlvbiwgLVdsJChjb21tYSktLWJ1aWxkLWlkKSAtV2wsLUJzeW1ib2xpYw0K
PiAkKExUT19DRkxBR1MpDQo+ICtWRFNPX0xERkxBR1MgPSAtc2hhcmVkICQoY2FsbCBsZC1vcHRp
b24sIC0taGFzaC1zdHlsZT1ib3RoKSBcDQo+ICsJJChjYWxsIGxkLW9wdGlvbiwgLS1idWlsZC1p
ZCkgLUJzeW1ib2xpYw0KPiAgR0NPVl9QUk9GSUxFIDo9IG4NCj4gIA0KPiAgIw0KDQo=
