Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A075EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7E20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P/UybzAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLCJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:00:27 -0500
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:38529
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfLCJA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcev+TTUNNTuAC+GddSXbrUiMn2Sd3qXvDP0IXshuS5btc14hxsU6spNE+FZteIlpZ1idSiB5ZVYy+COYb9D5urKPBGhCqLt5WWNPd2XYLcc93cv0xuCeZK7tykNoTjtKI4LxSQXrP+aZIXNnhoLFLbzb0m2JInnX2+/wOD5Klp/uTfKu9PRfzWlMfL4k8Nnu37J2ZtqaOzBy/zxIDZqFPWXUFCr5ItUG2Fu4UMUoqRHUhtR1D6H/KNHxvkWFDl6pHoHhYbkeEOTbLBOt+igqiQdi5vpCRth3c8rp9zE58pN1/9auNyZ6vRdk3Q4qlG7oG4A8e4In7wTQEYIQbVXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0ZF49QvckjIAxCv2fqMLJbmUIurGk32U/qwH4JzkI=;
 b=H6+tAXe/prhjZH1V+mcosWpK++w+2H4jEmBLGf/xL4YgdUwyEVaAJYNKSFKZQZo4zbLuJfYTA7Ho2DxtOxosZ83l08SyvIZruUQ27+fhxu6FZ4cp5iphzR5C0GgtaRu/xxHp/w0qwxlJScTxfQ9gLcoRuJayuGAGojjfjH+PUlTTkNs0K8Wsf3OTuiOGeNHZAcA57ILuquAXdPtAKQBpDMLJ3TDiNFwPfurFLXFojyC+j+VZvX+P/9rNnC+VV8fZdP4Uxeeus9DLzfVqvOVtVy/BL8gJdKNmVKDkhgsRcZ3P1D2njjZ2GNWCDXMUNYm5xJrm9iW4MIkHSG73RDIKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0ZF49QvckjIAxCv2fqMLJbmUIurGk32U/qwH4JzkI=;
 b=P/UybzAuBWy0HxUg7J8wtX9T7vBThtVz5SUTjWCmi2ggfUaDsDVQMyTigm9P6DQA1TNDpVT5tY9n/l2hQyAo1uMONWlViVrTCzAk1vbxth4fhoKMfjltZosOE5FDPoWO/enmsCeWHAWCmMDEbnE1tLfcBzuh45WYHRkSydUToA0=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB6269.namprd02.prod.outlook.com (52.132.175.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 09:00:11 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::948:464d:e305:9adc]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::948:464d:e305:9adc%5]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 09:00:11 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        "siva.durga.paladugu@xililnx.com" <siva.durga.paladugu@xililnx.com>
Subject: RE: ubifs mount failure
Thread-Topic: ubifs mount failure
Thread-Index: AdWpk0w1vXoILfyXR5WMh1O5WbDMxgAIiuAAAABceaA=
Date:   Tue, 3 Dec 2019 09:00:11 +0000
Message-ID: <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de>
In-Reply-To: <20191203084134.tgzir4mtekpm5xbs@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33dcaecf-b482-4504-0c9f-08d777cf3450
x-ms-traffictypediagnostic: MN2PR02MB6269:|MN2PR02MB6269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB62699DB9EC24EAD297F6B4C8AF420@MN2PR02MB6269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(13464003)(189003)(199004)(6916009)(66946007)(66556008)(478600001)(64756008)(66446008)(54906003)(76116006)(316002)(229853002)(256004)(33656002)(966005)(81166006)(66476007)(81156014)(8676002)(25786009)(99286004)(8936002)(14444005)(86362001)(2906002)(5660300002)(26005)(53546011)(102836004)(3846002)(6116002)(186003)(6246003)(4326008)(11346002)(446003)(6436002)(55016002)(74316002)(9686003)(6306002)(52536014)(14454004)(71190400001)(71200400001)(3480700005)(305945005)(7116003)(76176011)(7696005)(7736002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6269;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0TqASI/p27nbJ/s4f2OcueWnDkHX7gRaYZyDgzDiBDSiLEwZe7Dt/jzy85fhvNj5FRWtkhG/DIgZ6DEVFc1vTyKxIMzvUwO4mS4BARBym+iZ4bYzHBW3IVVY7/5qP6rvOBXJSdN7NV4covyD92jQWr9w4ceK2k2eVlF0t+PTZz3Dk6ZhLhvf36VKStgFHcdfQ7KUZqaiVF9p/R231t+gP1v98t1oEWu4tTzejgBo+PDDNhDiS09TBhnhLhvv6XV7skvMFHfaF+MmX7fLITnzcYCK0n3Xhbh3f34g3+UgyFS6UmHd7Q3RwX6tBLTvM1Lwe4ytZdGjqF84HPGxPDIcjcqdl1f15ohCJCjJBHv0Zxous1XssgWRuGIwtsvtU7DP53QIgRf/aKNptW4djnmKqP8CIW0Vcu7xW3i8e9GrvuBgBXRtzdKfYs2V6xcaYvF6OJi408eEcFDX/sx8WG9oRcgAPEecHKfRpOqpPCndwc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dcaecf-b482-4504-0c9f-08d777cf3450
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:00:11.2223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfPUz2aDv2jfG9halcESglV2tYzgJLYYSauJrPk3KjXWl4NF9UheCJn2IhtgvmCi4w+U58BEbk3cy+h6DKcGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FzY2hhLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNhc2No
YSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1i
ZXIgMywgMjAxOSAyOjEyIFBNDQo+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3Vy
ZUB4aWxpbnguY29tPg0KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47
IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+Ow0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTWljaGFs
IFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+OyBzaXZhLmR1cmdhLnBhbGFkdWd1QHhpbGls
bnguY29tDQo+IFN1YmplY3Q6IFJlOiB1YmlmcyBtb3VudCBmYWlsdXJlDQo+IA0KPiBIaSwNCj4g
DQo+IE9uIFR1ZSwgRGVjIDAzLCAyMDE5IGF0IDA0OjUyOjMyQU0gKzAwMDAsIE5hZ2EgU3VyZXNo
a3VtYXIgUmVsbGkgd3JvdGU6DQo+ID4gICAgSGksDQo+ID4NCj4gPg0KPiA+DQo+ID4gICAgV2Ug
aGF2ZSB1cGdyYWRlZCBvdXIgTGludXgga2VybmVsIHRvIDUuNCBmcm9tIDQuMTkuDQo+ID4NCj4g
PiAgICBBbmQgSSB0cmllZCBtb3VudGluZyB1YmlmcyB1c2luZyB0aGlzIGtlcm5lbCBvbiBOQU5E
IHBhcnRpdGlvbiB3aXRoIGJlbG93DQo+ID4gICAgY29tbWFuZCBhbmQgc2F3IHRoYXQNCj4gPg0K
PiA+ICAgIFRoZXJlIGlzIGFuIGlzc3VlIHdpdGggbWVtb3J5IGFsbG9jYXRpb24uDQo+ID4NCj4g
PiAgICAjbW91bnQgLXQgdWJpZnMgdWJpMDpkYXRhIC9tbnQvDQo+ID4NCj4gPiAgICBtb3VudDog
bW91bnRpbmcgdWJpMDpkYXRhIG9uIC9tbnQvIGZhaWxlZDogQ2Fubm90IGFsbG9jYXRlIG1lbW9y
eQ0KPiA+DQo+ID4NCj4gPg0KPiA+ICAgIEkgc2F3IHRoYXQgdGhlcmUgaXMgYSBjb21taXQgb24g
ZnMvdWJpZnMvc2IuYywgd2hlcmUgaXQgaXMgYWxsb2NhdGluZyBhbGwNCj4gPiAgICB0aGUgcmVx
dWlyZWQgbWVtb3JpZXMgYXQgb25lIHNob3QuDQo+ID4NCj4gPiAgICBbMV1odHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOC85LzcvNzI0DQo+ID4NCj4gPiAgICBCeSByZXZlcnRpbmcgdGhlIGFib3Zl
IHBhdGNoLCBJIGFtIGFibGUgdG8gbW91bnQgc3VjY2Vzc2Z1bGx5IHRoZSB1Ymlmcy4NCj4gPg0K
PiA+ICAgIEJ5IHJldmVydGluZyB0aGlzIHBhdGNoLCB3ZSBhcmUgYWxsb2NhdGluZywgd3JpdGlu
ZyBhbmQgZnJlZWluZyBpbiBhDQo+ID4gICAgbWFubmVyIHN1Y2ggdGhhdCwgd2UgZG9u4oCZdCBz
ZWUgbWVtb3J5IGFsbG9jYXRpb24gaXNzdWVzLg0KPiANCj4gU29ycnksIEkgY2FuJ3Qgc2VlIGhv
dyB0aGlzIHBhdGNoIGNhdXNlcyBmYWlsaW5nIG1lbW9yeSBhbGxvY2F0aW9ucy4gQW5kIG5vLCB0
aGlzIGlzIG5vdA0KPiBleHBlY3RlZC4gQ291bGQgeW91IHNwcmlua2xlIHNvbWUgcHJpbnRrcyBh
bmQgdHJhY2sgZG93biB3aGVyZSBpdCBmYWlscz8gSXMgaXQgdGhlIG9idmlvdXMNCj4gcGxhY2Ug
aGVyZToNClllcywgaXQgaXMgZmFpbGluZyBpbiB0aGlzIHBsYWNlIG9ubHkuDQo+IA0KPiAJaWYg
KCFzdXAgfHwgIW1zdCB8fCAhaWR4IHx8ICFpbm8gfHwgIWNzKSB7DQo+IAkJZXJyID0gLUVOT01F
TTsNCj4gCQlnb3RvIG91dDsNCj4gCX0NCj4gDQo+IElmIHllcywgd2hpY2ggYWxsb2NhdGlvbiBm
YWlscyBhbmQgaG93IG11Y2ggbWVtb3J5IGRpZCB3ZSB0cnkgdG8gYWxsb2NhdGU/DQpGYWlsaW5n
IGF0IGluZGV4aW5nIG5vZGUoaWR4KSBhbGxvY2F0aW9uDQpodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92NS40L3NvdXJjZS9mcy91Ymlmcy9zYi5jI0wxNjQNCndlIGFyZSB0cnlpbmcg
dG8gYWxsb2NhdGUgNDMyNTM3NiAofjRNQikNCj4gSWYgbm8sIHdoZXJlIGRvZXMgaXQgZmFpbD8g
QWxzbywgd2hlcmUgYXJlIHlvdSB1c2luZyBVQklGUy4gSXMgaXQgTkFORCBmbGFzaCBvciBOT1Ig
Zmxhc2g/DQpJdCBpcyBvbiBOQU5EIGZsYXNoLg0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFy
IFJlbGxpDQoNCj4gDQo+IFNhc2NoYQ0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
U3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5w
ZW5ndXRyb25peC5kZS8gIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAg
ICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGls
ZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1
IHwNCg==
