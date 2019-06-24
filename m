Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95788C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E13A208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="4N7uyuoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfFXKlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:41:19 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:52297 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728824AbfFXKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:41:19 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 06:41:16 EDT
X-IronPort-AV: E=McAfee;i="6000,8403,9297"; a="4579444"
X-IronPort-AV: E=Sophos;i="5.63,411,1557154800"; 
   d="scan'208";a="4579444"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jun 2019 19:34:06 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector1-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiZlZcWdA6DTcp6JsQlv3ctgl+ETkC6V29KOUpw5p3w=;
 b=4N7uyuoFYLWF5Y9BQA77JtIPo+ShDdWTuENx5+wjWOGpyU00vxVphFhrHQjx3c/ZCAwuZW3Uy7NrH/lBH5XMEO8prVH8PG46tgYuDd6yS//N0chB1NBUc8xSIG5AXDUIUEuo1c/ET5o/znoOUoZK8nyhEgpNDMlgCskVt9s5zsc=
Received: from OSBPR01MB5000.jpnprd01.prod.outlook.com (20.179.183.204) by
 OSBPR01MB4055.jpnprd01.prod.outlook.com (20.178.99.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 10:34:02 +0000
Received: from OSBPR01MB5000.jpnprd01.prod.outlook.com
 ([fe80::d033:28f6:3937:40c2]) by OSBPR01MB5000.jpnprd01.prod.outlook.com
 ([fe80::d033:28f6:3937:40c2%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 10:34:02 +0000
From:   "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To:     Will Deacon <will.deacon@arm.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Topic: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Index: AQHVJRmVihUXsBTsv0iIDHwIrvWdbKagEvcAgAqT5QA=
Date:   Mon, 24 Jun 2019 10:34:02 +0000
Message-ID: <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617170328.GJ30800@fuggles.cambridge.arm.com>
In-Reply-To: <20190617170328.GJ30800@fuggles.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com; 
x-originating-ip: [114.160.9.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 035565ac-5b70-4e11-aaba-08d6f88f79b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:OSBPR01MB4055;
x-ms-traffictypediagnostic: OSBPR01MB4055:
x-microsoft-antispam-prvs: <OSBPR01MB405537AE5738705F6191752BF7E00@OSBPR01MB4055.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(189003)(199004)(26005)(2906002)(6486002)(446003)(71190400001)(476003)(6246003)(31686004)(66446008)(6512007)(66556008)(66946007)(53936002)(102836004)(64756008)(73956011)(85182001)(31696002)(54906003)(110136005)(91956017)(86362001)(316002)(81166006)(81156014)(14444005)(11346002)(256004)(68736007)(229853002)(71200400001)(5660300002)(66476007)(76116006)(486006)(6436002)(53546011)(6506007)(8936002)(186003)(3846002)(8676002)(4326008)(6116002)(25786009)(66066001)(478600001)(7736002)(305945005)(99286004)(76176011)(6636002)(14454004)(777600001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB4055;H:OSBPR01MB5000.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6lNqGmd6H7/oOP87Y8aYYmoviUGHyAJ+mml708ExU3YvJK5i8A5Wh8Y8VoZD03QfjV28eMzFi+epIsq1fwZ7xtMJyuIY2oUrMyisl4nIjiUTFONm5A1yW4isjCpzGOOSVO7R8GGxfevOTOPu1Z6/AdmT7h7XHCYykgT0k5tIEIHCK6Z5tvr1LWnGXjq8NYgXO1SgqURj6Wq9cdv4rnCiZ0YXTc5U3vqWvgNdrVmdy6tqUAtjDaEy7l0RUcDSc9NczOSaolkoDW5tzFXxuw/q8GgPIS7MZyxz6ADlZ10w+DNGdzCxSe0O4Ni/OIoxrr82LuYYoTQoyOilSUIxdQVW7XBSsPRZxXtAOR4iP6yoPmrcKyYrTZYPsxMFPJMSqc41g83SGO0RUPA9ATUF5eVo/gnS1uP9czz7qdbGICXFoE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4755D6B231C12648B281812FB2FCCE3F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035565ac-5b70-4e11-aaba-08d6f88f79b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 10:34:02.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi.fuli@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KSSBhbSBUYWthbydzIGNvbGxlYWd1ZSwgdGhhbmsgeW91IHZlcnkgbXVjaCBm
b3IgeW91ciByZXBseS4NCg0KT24gNi8xOC8xOSAyOjAzIEFNLCBXaWxsIERlYWNvbiB3cm90ZToN
Cj4gSGkgVGFrYW8sDQo+DQo+IFsrUGV0ZXIgWl0NCj4NCj4gT24gTW9uLCBKdW4gMTcsIDIwMTkg
YXQgMTE6MzI6NTNQTSArMDkwMCwgVGFrYW8gSW5kb2ggd3JvdGU6DQo+PiBGcm9tOiBUYWthbyBJ
bmRvaCA8aW5kb3UudGFrYW9AZnVqaXRzdS5jb20+DQo+Pg0KPj4gSSBmb3VuZCBhIHBlcmZvcm1h
bmNlIGlzc3VlIHJlbGF0ZWQgb24gdGhlIGltcGxlbWVudGF0aW9uIG9mIExpbnV4J3MgVExCDQo+
PiBmbHVzaCBmb3IgYXJtNjQuDQo+Pg0KPj4gV2hlbiBJIHJ1biBhIHNpbmdsZS10aHJlYWRlZCB0
ZXN0IHByb2dyYW0gb24gbW9kZXJhdGUgZW52aXJvbm1lbnQsIGl0DQo+PiB1c3VhbGx5IHRha2Vz
IDM5bXMgdG8gZmluaXNoIGl0cyB3b3JrLiBIb3dldmVyLCB3aGVuIEkgcHV0IGEgc21hbGwNCj4+
IGFwcHJpY2F0aW9uLCB3aGljaCBqdXN0IGNhbGxzIG1wcm90ZXN0KCkgY29udGludW91c2x5LCBv
biBvbmUgb2Ygc2libGluZw0KPj4gY29yZXMgYW5kIHJ1biBpdCBzaW11bHRhbmVvdXNseSwgdGhl
IHRlc3QgcHJvZ3JhbSBzbG93cyBkb3duIHNpZ25pZmljYW50bHkuDQo+PiBJdCBiZWNvbWVzIDQ5
bXMoMTI1JSkgb24gVGh1bmRlclgyLiBJIGFsc28gZGV0ZWN0ZWQgdGhlIHNhbWUgcHJvYmxlbSBv
bg0KPj4gVGh1bmRlclgxIGFuZCBGdWppdHN1IEE2NEZYLg0KPiBUaGlzIGlzIGEgcHJvYmxlbSBm
b3IgYW55IGFwcGxpY2F0aW9ucyB0aGF0IHNoYXJlIGhhcmR3YXJlIHJlc291cmNlcyB3aXRoDQo+
IGVhY2ggb3RoZXIsIHNvIEkgZG9uJ3QgdGhpbmsgaXQncyBzb21ldGhpbmcgd2Ugc2hvdWxkIGJl
IHRvbyBjb25jZXJuZWQgYWJvdXQNCj4gYWRkcmVzc2luZyB1bmxlc3MgdGhlcmUgaXMgYSBwcmFj
dGljYWwgRG9TIHNjZW5hcmlvLCB3aGljaCB0aGVyZSBkb2Vzbid0DQo+IGFwcGVhciB0byBiZSBp
biB0aGlzIGNhc2UuIEl0IG1heSBiZSB0aGF0IHRoZSByZWFsIGFuc3dlciBpcyAiZG9uJ3QgY2Fs
bA0KPiBtcHJvdGVjdCgpIGluIGEgbG9vcCIuDQpJIHRoaW5rIHRoZXJlIGhhcyBiZWVuIGEgbWlz
dW5kZXJzdGFuZGluZywgcGxlYXNlIGxldCBtZSBleHBsYWluLg0KVGhpcyBhcHBsaWNhdGlvbiBp
cyBqdXN0IGFuIGV4YW1wbGUgdXNpbmcgZm9yIHJlcHJvZHVjaW5nIHRoZSANCnBlcmZvcm1hbmNl
IGlzc3VlIHdlIGZvdW5kLg0KT3VyIG9yaWdpbmFsIHB1cnBvc2UgaXMgcmVkdWNpbmcgT1Mgaml0
dGVyIGJ5IHRoaXMgc2VyaWVzLg0KVGhlIE9TIGppdHRlciBvbiBtYXNzaXZlbHkgcGFyYWxsZWwg
cHJvY2Vzc2luZyBzeXN0ZW1zIGhhdmUgYmVlbiBrbm93biANCmFuZCBzdHVkaWVkIGZvciBtYW55
IHllYXJzLg0KVGhlIDIuNSUgT1Mgaml0dGVyIGNhbiByZXN1bHQgaW4gb3ZlciBhIGZhY3RvciBv
ZiAyMCBzbG93ZG93biBmb3IgdGhlIA0Kc2FtZSBhcHBsaWNhdGlvbiBbMV0uDQpUaG91Z2ggaXQg
bWF5IGJlIGFuIGV4dHJlbWUgZXhhbXBsZSwgcmVkdWNpbmcgdGhlIE9TIGppdHRlciBoYXMgYmVl
biBhbiANCmlzc3VlIGluIEhQQyBlbnZpcm9ubWVudC4NCg0KWzFdIEZlcnJlaXJhLCBLdXJ0IEIu
LCBQYXRyaWNrIEJyaWRnZXMsIGFuZCBSb24gQnJpZ2h0d2VsbC4gDQoiQ2hhcmFjdGVyaXppbmcg
YXBwbGljYXRpb24gc2Vuc2l0aXZpdHkgdG8gT1MgaW50ZXJmZXJlbmNlIHVzaW5nIA0Ka2VybmVs
LWxldmVsIG5vaXNlIGluamVjdGlvbi4iIFByb2NlZWRpbmdzIG9mIHRoZSAyMDA4IEFDTS9JRUVF
IA0KY29uZmVyZW5jZSBvbiBTdXBlcmNvbXB1dGluZy4gSUVFRSBQcmVzcywgMjAwOC4NCg0KPj4g
SSBzdXBwb3NlIHRoZSByb290IGNhdXNlIG9mIHRoaXMgaXNzdWUgaXMgdGhlIGltcGxlbWVudGF0
aW9uIG9mIExpbnV4J3MgVExCDQo+PiBmbHVzaCBmb3IgYXJtNjQsIGVzcGVjaWFsbHkgdXNlIG9m
IFRMQkktaXMgaW5zdHJ1Y3Rpb24gd2hpY2ggaXMgYSBicm9hZGNhc3QNCj4+IHRvIGFsbCBwcm9j
ZXNzb3IgY29yZSBvbiB0aGUgc3lzdGVtLiBJbiBjYXNlIG9mIHRoZSBhYm92ZSBzaXR1YXRpb24s
DQo+PiBUTEJJLWlzIGlzIGNhbGxlZCBieSBtcHJvdGVjdCgpLg0KPiBPbiB0aGUgZmxpcCBzaWRl
LCBMaW51eCBpcyBwcm92aWRpbmcgdGhlIGhhcmR3YXJlIHdpdGggZW5vdWdoIGluZm9ybWF0aW9u
DQo+IG5vdCB0byBicm9hZGNhc3QgdG8gY29yZXMgZm9yIHdoaWNoIHRoZSByZW1vdGUgVExCcyBk
b24ndCBoYXZlIGVudHJpZXMNCj4gYWxsb2NhdGVkIGZvciB0aGUgQVNJRCBiZWluZyBpbnZhbGlk
YXRlZC4gSSB3b3VsZCBzYXkgdGhhdCB0aGUgcm9vdCBjYXVzZQ0KPiBvZiB0aGUgaXNzdWUgaXMg
dGhhdCB0aGlzIGZpbHRlcmluZyBpcyBub3QgdGFraW5nIHBsYWNlLg0KDQpEbyB5b3UgbWVhbiB0
aGF0IHRoZSBmaWx0ZXIgc2hvdWxkIGJlIGltcGxlbWVudGVkIGluIGhhcmR3YXJlPw0KDQpUaGFu
a3MsDQpRaSBGdWxpDQoNCj4+IFRoaXMgaXMgbm90IGEgcHJvYmxlbSBmb3Igc21hbGwgZW52aXJv
bm1lbnQsIGJ1dCB0aGlzIGNhdXNlcyBhIHNpZ25pZmljYW50DQo+PiBwZXJmb3JtYW5jZSBub2lz
ZSBmb3IgbGFyZ2Utc2NhbGUgSFBDIGVudmlyb25tZW50LCB3aGljaCBoYXMgbW9yZSB0aGFuDQo+
PiB0aG91c2FuZCBub2RlcyB3aXRoIGxvdyBsYXRlbmN5IGludGVyY29ubmVjdC4NCj4gSWYgeW91
IGhhdmUgYSBzeXN0ZW0gd2l0aCBvdmVyIGEgdGhvdXNhbmQgbm9kZXMsIHdpdGhvdXQgc25vb3Ag
ZmlsdGVyaW5nDQo+IGZvciBEVk0gbWVzc2FnZXMgYW5kIHlvdSBleHBlY3QgcGVyZm9ybWFuY2Ug
dG8gc2NhbGUgaW4gdGhlIGZhY2Ugb2YgdGlnaHQNCj4gbXByb3RlY3QoKSBsb29wcyB0aGVuIEkg
dGhpbmsgeW91IGhhdmUgYSBwcm9ibGVtIGlycmVzcGVjdGl2ZSBvZiB0aGlzIHBhdGNoLg0KPiBX
aGF0IGhhcHBlbnMgaWYgc29tZWJvZHkgcnVucyBJLWNhY2hlIGludmFsaWRhdGlvbiBpbiBhIGxv
b3A/DQo+DQo+PiBUbyBmaXggdGhpcyBwcm9ibGVtLCB0aGlzIHBhdGNoIGFkZHMgbmV3IGJvb3Qg
cGFyYW1ldGVyDQo+PiAnZGlzYWJsZV90bGJmbHVzaF9pcycuICBJbiB0aGUgY2FzZSBvZiBmbHVz
aF90bGJfbW0oKSAqd2l0aG91dCogdGhpcw0KPj4gcGFyYW1ldGVyLCBUTEIgZW50cnkgaXMgaW52
YWxpZGF0ZWQgYnkgX190bGJpKGFzaWRlMWlzLCBhc2lkKS4gQnkgdGhpcw0KPj4gaW5zdHJ1Y3Rp
b24sIGFsbCBDUFVzIHdpdGhpbiB0aGUgc2FtZSBpbm5lciBzaGFyZWFibGUgZG9tYWluIGNoZWNr
IGlmIHRoZXJlDQo+PiBhcmUgVExCIGVudHJpZXMgd2hpY2ggaGF2ZSB0aGlzIEFTSUQsIHRoaXMg
Y2F1c2VzIHBlcmZvcm1hbmNlIG5vaXNlLiBPVE9ILA0KPj4gd2hlbiB0aGlzIG5ldyBwYXJhbWV0
ZXIgaXMgc3BlY2lmaWVkLCBUTEIgZW50cnkgaXMgaW52YWxpZGF0ZWQgYnkNCj4+IF9fdGxiaShh
c2lkZTEsIGFzaWQpIG9ubHkgb24gdGhlIENQVXMgc3BlY2lmaWVkIGJ5IG1tX2NwdW1hc2sobW0p
Lg0KPj4gVGhlcmVmb3JlIFRMQiBmbHVzaCBpcyBkb25lIG9uIG1pbmltYWwgQ1BVcyBhbmQgcGVy
Zm9ybWFuY2UgcHJvYmxlbSBkb2VzDQo+PiBub3Qgb2NjdXIuIEFjdHVhbGx5IEkgY29uZmlybSB0
aGUgcGVyZm9ybWFuY2UgcHJvYmxlbSBpcyBmaXhlZCBieSB0aGlzDQo+PiBwYXRjaC4NCj4gT3Ro
ZXIgdGhhbiBteSBjb21tZW50cyBhYm92ZSwgbXkgb3ZlcmFsbCBjb25jZXJuIHdpdGggdGhpcyBw
YXRjaCBpcyB0aGF0DQo+IGl0IGludHJvZHVjZXMgZGl2ZXJnZW50IGJlaGF2aW91ciBmb3Igb3Vy
IFRMQiBpbnZhbGlkYXRpb24gZmxvdywgd2hpY2ggaXMNCj4gdW5kZXNpcmFibGUgZnJvbSBib3Ro
IG1haW50YWluYWJpbGl0eSBhbmQgdXNhYmlsaXR5IHBlcnNwZWN0aXZlcy4gSWYgeW91DQo+IHdp
c2ggdG8gY2hhbmdlIHRoZSBjb2RlLCBwbGVhc2UgZG9uJ3QgcHV0IGl0IGJlaGluZCBhIGNvbW1h
bmQtbGluZSBvcHRpb24sDQo+IGJ1dCBpbnN0ZWFkIGltcHJvdmUgdGhlIGNvZGUgdGhhdCBpcyBh
bHJlYWR5IHRoZXJlLiBIb3dldmVyLCBJIHN1c3BlY3QgdGhhdA0KPiBibG93aW5nIGF3YXkgdGhl
IGxvY2FsIFRMQiBvbiBldmVyeSBjb250ZXh0LXN3aXRjaCBtYXkgaGF2ZSBoaWRkZW4gY29zdHMN
Cj4gd2hpY2ggYXJlIG9ubHkgYXBwYXJlbnQgd2l0aCB3b3JrbG9hZHMgZGlmZmVyZW50IGZyb20g
dGhlIGNvbnRyaXZlZCBjYXNlDQo+IHRoYXQgeW91J3JlIHNlZWtpbmcgdG8gaW1wcm92ZS4gWW91
IGFsc28gaGF2ZW4ndCB0YWtlbiBpbnRvIGFjY291bnQgdGhlDQo+IGVmZmVjdHMgb2YgdmlydHVh
bGlzYXRpb24sIHdoZXJlIGl0J3MgbGlrZWx5IHRoYXQgdGhlIGh5cGVydmlzb3Igd2lsbA0KPiB1
cGdyYWRlIG5vbi1zaGFyZWFibGUgb3BlcmF0aW9ucyB0byBpbm5lci1zaGFyZWFibGUgb25lcyBh
bnl3YXkuDQo+DQo+IFRoYW5rcywNCj4NCj4gV2lsbA==
