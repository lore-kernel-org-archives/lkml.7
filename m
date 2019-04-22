Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A30820896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y2yCozTC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E2KmMSnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfDVVRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:17:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728847AbfDVVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:17:54 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3ML7mjY007595;
        Mon, 22 Apr 2019 14:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mBTbUZy9g1+hWpwjDy98ytdQKzovLEOOohb2LmRFpuQ=;
 b=Y2yCozTCbaVMOWPD7SO5uqQVINt9NJGPlwlS99MVAShtXQUj2aZQiOkYOZvMH9TjAOqG
 AxD+er2RGh9GiE8llQphuN5Msv6/hE/IACstr/4F6+6mC+8jedVnyH8B/hCu+Et1UYuv
 kpXzIRrfQa92RtMhMww1cTPAHc63tvcFDn8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2ryy3cr5v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 14:17:04 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 14:17:02 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 14:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBTbUZy9g1+hWpwjDy98ytdQKzovLEOOohb2LmRFpuQ=;
 b=E2KmMSnrZQyYdtXS9DrBUwRYUx7EHR5t3wYXGzH//P0yOjtpOG67a73F0agti/N1pigvkJ0TMIExEA0ZLgh7hWi9Oan0kPMOi27C2t1F0f9A7SDBapLpEHwuY+NVcoa4wP1IWcebFFDzbYo0uoC90N+TvrUSAFL7hxcbVy0ove8=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2488.namprd15.prod.outlook.com (52.135.200.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Mon, 22 Apr 2019 21:17:00 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 21:17:00 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrew Hall <hall@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Lau <kafai@fb.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Topic: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Index: AQHU9vOB6YI4LMclcUeKr8qdEaM41KZICpuAgACJGACAAB/UgA==
Date:   Mon, 22 Apr 2019 21:17:00 +0000
Message-ID: <ca1d46d5-ea87-2859-c5a7-ce7220d396db@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-2-mmullins@fb.com>
 <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
 <de2eb4c12121c96b5b9912196aedb081027b3ac4.camel@fb.com>
In-Reply-To: <de2eb4c12121c96b5b9912196aedb081027b3ac4.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0006.namprd02.prod.outlook.com
 (2603:10b6:301:74::19) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:417e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda2b5ea-cf1d-4ba3-6b3c-08d6c767dbda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2488;
x-ms-traffictypediagnostic: BYAPR15MB2488:
x-microsoft-antispam-prvs: <BYAPR15MB2488D65944B23D9A085478A5D3220@BYAPR15MB2488.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(54906003)(4326008)(478600001)(14454004)(110136005)(316002)(2501003)(36756003)(99286004)(2906002)(8936002)(6512007)(6116002)(53936002)(25786009)(52116002)(93886005)(76176011)(81166006)(81156014)(6246003)(8676002)(2616005)(97736004)(11346002)(476003)(446003)(31686004)(486006)(186003)(305945005)(5024004)(5660300002)(46003)(256004)(14444005)(86362001)(7736002)(2201001)(71190400001)(71200400001)(31696002)(68736007)(53546011)(6436002)(6506007)(6486002)(386003)(102836004)(73956011)(66476007)(66946007)(66556008)(66446008)(64756008)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2488;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zH2CKlzG3EoR3W58eIP4AH8AxfxtcMWkoQKaGXZjUwYM+D3otgARaCbh7U22UIlF2v5jIXUJFhm5gZw5224EeRLfg2669vdkyRCkEJTBybfkVlAjJfed2zgvEiVrvtgaefUIpYUYrYmmvlqxKWfDYlxT4bALR8W290olKh31ePTOsoUUeaNfQEhdSVwn3USoSqs740fMd5T+82fzhGQCgdQhhDEHnEvb3cMgkE0VHeqWn+zk9f/J02UojIBSUs7ygGuWyDeWRchU7lb4HH/ZzsQML0HmGy5QNaszjMG1rvaUEz5v/i547b1VpRRC1NWkp/CgK/5h2G5ZkZCaRnEHDZurVVuM4q8KNJJz53zQmjMZVcTI1F33qMgeleH3y/KpRJNQfh3dvOiDNIL/wv27NtPeoUgzYQIsvZ6aBMaLxaA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52E1460AD4A4CF48B137FD56C4491079@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cda2b5ea-cf1d-4ba3-6b3c-08d6c767dbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 21:17:00.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2488
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjIvMTkgMTI6MjMgUE0sIE1hdHQgTXVsbGlucyB3cm90ZToNCj4gT24gTW9uLCAy
MDE5LTA0LTIyIGF0IDE4OjEyICswMDAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0KPj4NCj4+IE9u
IDQvMTkvMTkgMjowNCBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPj4+IFRoaXMgaXMgYW4gb3B0
LWluIGludGVyZmFjZSB0aGF0IGFsbG93cyBhIHRyYWNlcG9pbnQgdG8gcHJvdmlkZSBhIHNhZmUN
Cj4+PiBidWZmZXIgdGhhdCBjYW4gYmUgd3JpdHRlbiBmcm9tIGEgQlBGX1BST0dfVFlQRV9SQVdf
VFJBQ0VQT0lOVCBwcm9ncmFtLg0KPj4+IFRoZSBzaXplIG9mIHRoZSBidWZmZXIgbXVzdCBiZSBh
IGNvbXBpbGUtdGltZSBjb25zdGFudCwgYW5kIGlzIGNoZWNrZWQNCj4+PiBiZWZvcmUgYWxsb3dp
bmcgYSBCUEYgcHJvZ3JhbSB0byBhdHRhY2ggdG8gYSB0cmFjZXBvaW50IHRoYXQgdXNlcyB0aGlz
DQo+Pj4gZmVhdHVyZS4NCj4+Pg0KPj4+IFRoZSBwb2ludGVyIHRvIHRoaXMgYnVmZmVyIHdpbGwg
YmUgdGhlIGZpcnN0IGFyZ3VtZW50IG9mIHRyYWNlcG9pbnRzDQo+Pj4gdGhhdCBvcHQgaW47IHRo
ZSBidWZmZXIgaXMgcmVhZGFibGUgYnkgYm90aCBCUEZfUFJPR19UWVBFX1JBV19UUkFDRVBPSU5U
DQo+Pj4gYW5kIEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUgcHJvZ3JhbXMg
dGhhdCBhdHRhY2ggdG8gc3VjaCBhDQo+Pj4gdHJhY2Vwb2ludCwgYnV0IHRoZSBidWZmZXIgdG8g
d2hpY2ggaXQgcG9pbnRzIG1heSBvbmx5IGJlIHdyaXR0ZW4gYnkgdGhlDQo+Pj4gbGF0dGVyLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWF0dCBNdWxsaW5zIDxtbXVsbGluc0BmYi5jb20+DQo+
Pj4gLS0tDQo+Pj4gICAgaW5jbHVkZS9saW51eC9icGYuaCAgICAgICAgICAgICB8ICAyICsrDQo+
Pj4gICAgaW5jbHVkZS9saW51eC9icGZfdHlwZXMuaCAgICAgICB8ICAxICsNCj4+PiAgICBpbmNs
dWRlL2xpbnV4L3RyYWNlcG9pbnQtZGVmcy5oIHwgIDEgKw0KPj4+ICAgIGluY2x1ZGUvdHJhY2Uv
YnBmX3Byb2JlLmggICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+PiAg
ICBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmggICAgICAgIHwgIDEgKw0KPj4+ICAgIGtlcm5lbC9i
cGYvc3lzY2FsbC5jICAgICAgICAgICAgfCAgOCArKysrKystLQ0KPj4+ICAgIGtlcm5lbC9icGYv
dmVyaWZpZXIuYyAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+Pj4gICAga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jICAgICAgICB8IDIxICsrKysrKysrKysr
KysrKysrKysrKw0KPj4+ICAgIDggZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIv
aW5jbHVkZS9saW51eC9icGYuaA0KPj4+IGluZGV4IGEyMTMyZTA5ZGMxYy4uZDNjNzFmZDY3NDc2
IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2JwZi5oDQo+Pj4gQEAgLTI2Myw2ICsyNjMsNyBAQCBlbnVtIGJwZl9yZWdfdHlwZSB7
DQo+Pj4gICAgCVBUUl9UT19TT0NLX0NPTU1PTl9PUl9OVUxMLCAvKiByZWcgcG9pbnRzIHRvIHNv
Y2tfY29tbW9uIG9yIE5VTEwgKi8NCj4+PiAgICAJUFRSX1RPX1RDUF9TT0NLLAkgLyogcmVnIHBv
aW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgKi8NCj4+PiAgICAJUFRSX1RPX1RDUF9TT0NLX09SX05V
TEwsIC8qIHJlZyBwb2ludHMgdG8gc3RydWN0IHRjcF9zb2NrIG9yIE5VTEwgKi8NCj4+PiArCVBU
Ul9UT19UUF9CVUZGRVIsCSAvKiByZWcgcG9pbnRzIHRvIGEgd3JpdGFibGUgcmF3IHRwJ3MgYnVm
ZmVyICovDQo+Pj4gICAgfTsNCj4+PiAgICANCj4+DQo+PiBbLi4uXQ0KPj4+ICAgIC8qIHRydW5j
YXRlIHJlZ2lzdGVyIHRvIHNtYWxsZXIgc2l6ZSAoaW4gYnl0ZXMpDQo+Pj4gICAgICogbXVzdCBi
ZSBjYWxsZWQgd2l0aCBzaXplIDwgQlBGX1JFR19TSVpFDQo+Pj4gICAgICovDQo+Pj4gQEAgLTIx
MDAsNiArMjEyNywxMCBAQCBzdGF0aWMgaW50IGNoZWNrX21lbV9hY2Nlc3Moc3RydWN0IGJwZl92
ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4LCB1MzIgcmVnbg0KPj4+ICAgIAkJZXJyID0g
Y2hlY2tfc29ja19hY2Nlc3MoZW52LCBpbnNuX2lkeCwgcmVnbm8sIG9mZiwgc2l6ZSwgdCk7DQo+
Pj4gICAgCQlpZiAoIWVyciAmJiB2YWx1ZV9yZWdubyA+PSAwKQ0KPj4+ICAgIAkJCW1hcmtfcmVn
X3Vua25vd24oZW52LCByZWdzLCB2YWx1ZV9yZWdubyk7DQo+Pj4gKwl9IGVsc2UgaWYgKHJlZy0+
dHlwZSA9PSBQVFJfVE9fVFBfQlVGRkVSKSB7DQo+Pj4gKwkJZXJyID0gY2hlY2tfdHBfYnVmZmVy
X2FjY2VzcyhlbnYsIHJlZywgcmVnbm8sIG9mZiwgc2l6ZSk7DQo+Pj4gKwkJaWYgKCFlcnIgJiYg
dCA9PSBCUEZfUkVBRCAmJiB2YWx1ZV9yZWdubyA+PSAwKQ0KPj4+ICsJCQltYXJrX3JlZ191bmtu
b3duKGVudiwgcmVncywgdmFsdWVfcmVnbm8pOw0KPj4+ICAgIAl9IGVsc2Ugew0KPj4+ICAgIAkJ
dmVyYm9zZShlbnYsICJSJWQgaW52YWxpZCBtZW0gYWNjZXNzICclcydcbiIsIHJlZ25vLA0KPj4+
ICAgIAkJCXJlZ190eXBlX3N0cltyZWctPnR5cGVdKTsNCj4+PiBkaWZmIC0tZ2l0IGEva2VybmVs
L3RyYWNlL2JwZl90cmFjZS5jIGIva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jDQo+Pj4gaW5kZXgg
ZDY0YzAwYWZjZWI1Li5hMmRkNzlkYzY4NzEgMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsL3RyYWNl
L2JwZl90cmFjZS5jDQo+Pj4gKysrIGIva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jDQo+Pj4gQEAg
LTkwOSw2ICs5MDksMjQgQEAgY29uc3Qgc3RydWN0IGJwZl92ZXJpZmllcl9vcHMgcmF3X3RyYWNl
cG9pbnRfdmVyaWZpZXJfb3BzID0gew0KPj4+ICAgIGNvbnN0IHN0cnVjdCBicGZfcHJvZ19vcHMg
cmF3X3RyYWNlcG9pbnRfcHJvZ19vcHMgPSB7DQo+Pj4gICAgfTsNCj4+PiAgICANCj4+PiArc3Rh
dGljIGJvb2wgcmF3X3RwX3dyaXRhYmxlX3Byb2dfaXNfdmFsaWRfYWNjZXNzKGludCBvZmYsIGlu
dCBzaXplLA0KPj4+ICsJCQkJCQkgZW51bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwNCj4+PiArCQkJ
CQkJIGNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZywNCj4+PiArCQkJCQkJIHN0cnVjdCBicGZf
aW5zbl9hY2Nlc3NfYXV4ICppbmZvKQ0KPj4+ICt7DQo+Pj4gKwlpZiAob2ZmID09IDAgJiYgc2l6
ZSA9PSBzaXplb2YodTY0KSkNCj4+PiArCQlpbmZvLT5yZWdfdHlwZSA9IFBUUl9UT19UUF9CVUZG
RVI7DQo+Pg0KPj4gb24gMzJiaXQgc3lzdGVtLCB0aGUgZmlyc3QgYXJndW1lbnQgcG9pbnRlciBz
aXplIGNvdWxkIGJlIHNpemVvZih1MzIpPw0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHBv
aW50ZXJzIGFyZSBhbHdheXMgNjQgYml0cyB3aWRlIGZyb20gdGhlDQo+IHBlcnNwZWN0aXZlIG9m
IHRoZSBlQlBGIGluc3RydWN0aW9uIHNldC4gIEkgdGhpbmsgdGhlIHByb3BlciBmaXh1cCBpcw0K
PiBpbiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9uYmQuaCAuLi4gSSBzaG91bGQgdXNlIGEgdTY0IGlu
c3RlYWQgb2YgYQ0KPiBwb2ludGVyIHR5cGUuDQoNCnU2NCBpcyBva2F5LiBZb3UgbWF5IHdhbnQg
dG8gZG91YmxlIGNoZWNrIHRyYWNlcG9pbnQgZGVmaW5pdGlvbiB0byANCmVuc3VyZSB0aGUgYXNz
aWduIHRvIHRoZSBmaXJzdCBhcmd1bWVudCBjb252ZXJ0aW5nIHRvIHU2NCBhcyB3ZWxsIHRvIA0K
YXZvaWQgcG90ZW50aWFsIGdhcmJhZ2UuIEl0IHdvdWxkIGJlIGdvb2QgaWYgdGhpcyBpcyBlbmZv
cmNlZCBkdXJpbmcNCmNvbXBpbGF0aW9uIHRpbWUuDQoNCj4gDQo+PiBTaG91bGQgdGhlIGZpcnN0
IGFyZ3VtZW50IGZvciByYXdfdHBfd3JpdGFibGVfcHJvZyBiZSBhbHdheXMNCj4+IFBUUl9UT19U
UF9CVUZGRVI/DQo+IA0KPiBUaGF0IGlzIHRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggc2VyaWVz
LCB5ZXMuICBNeSBpbml0aWFsIGF0dGVtcHQgYXQNCj4gdGhpcyB0cmllZCB0byBhZGQgaXQgdG8g
dGhlIGVuZCBvZiB0aGUgY29udGV4dCBzdHJ1Y3R1cmUgaW5zdGVhZCwgYW5kDQo+IHRoYXQgZW5k
ZWQgdXAgYmVpbmcgcXVpdGUgY29tcGxleCB0byB0cmFjay4NCg0KU28gYHNpemUgPT0gc2l6ZW9m
KHU2NClgIGNhbiBiZSByZW1vdmVkLCBvZmYgPT0gMCBqdXN0IGltcGxpZXMNCnJlZ190eXBlIFBU
Ul9UT19UUF9CVUZGRVI/DQoNCj4gDQo+Pg0KPj4+ICsJcmV0dXJuIHJhd190cF9wcm9nX2lzX3Zh
bGlkX2FjY2VzcyhvZmYsIHNpemUsIHR5cGUsIHByb2csIGluZm8pOw0KPj4+ICt9DQo+Pj4gKw0K
Pj4+ICtjb25zdCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX29wcyByYXdfdHJhY2Vwb2ludF93cml0YWJs
ZV92ZXJpZmllcl9vcHMgPSB7DQo+Pj4gKwkuZ2V0X2Z1bmNfcHJvdG8gID0gcmF3X3RwX3Byb2df
ZnVuY19wcm90bywNCj4+PiArCS5pc192YWxpZF9hY2Nlc3MgPSByYXdfdHBfd3JpdGFibGVfcHJv
Z19pc192YWxpZF9hY2Nlc3MsDQo+Pj4gK307DQo+Pj4gKw0KPj4+ICtjb25zdCBzdHJ1Y3QgYnBm
X3Byb2dfb3BzIHJhd190cmFjZXBvaW50X3dyaXRhYmxlX3Byb2dfb3BzID0gew0KPj4+ICt9Ow0K
Pj4+ICsNCj4+PiAgICBzdGF0aWMgYm9vbCBwZV9wcm9nX2lzX3ZhbGlkX2FjY2VzcyhpbnQgb2Zm
LCBpbnQgc2l6ZSwgZW51bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwNCj4+PiAgICAJCQkJICAgIGNv
bnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZywNCj4+PiAgICAJCQkJICAgIHN0cnVjdCBicGZfaW5z
bl9hY2Nlc3NfYXV4ICppbmZvKQ0KPj4+IEBAIC0xMTk4LDYgKzEyMTYsOSBAQCBzdGF0aWMgaW50
IF9fYnBmX3Byb2JlX3JlZ2lzdGVyKHN0cnVjdCBicGZfcmF3X2V2ZW50X21hcCAqYnRwLCBzdHJ1
Y3QgYnBmX3Byb2cgKg0KPj4+ICAgIAlpZiAocHJvZy0+YXV4LT5tYXhfY3R4X29mZnNldCA+IGJ0
cC0+bnVtX2FyZ3MgKiBzaXplb2YodTY0KSkNCj4+PiAgICAJCXJldHVybiAtRUlOVkFMOw0KPj4+
ICAgIA0KPj4+ICsJaWYgKHByb2ctPmF1eC0+bWF4X3RwX2FjY2VzcyA+IGJ0cC0+d3JpdGFibGVf
c2l6ZSkNCj4+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+PiArDQo+Pj4gICAgCXJldHVybiB0cmFj
ZXBvaW50X3Byb2JlX3JlZ2lzdGVyKHRwLCAodm9pZCAqKWJ0cC0+YnBmX2Z1bmMsIHByb2cpOw0K
Pj4+ICAgIH0NCj4+PiAgICANCj4+Pg0K
