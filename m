Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD33C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F072175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oWgbggGp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WAnsXHRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfDVSNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:13:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727818AbfDVSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:13:19 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MI68A5025428;
        Mon, 22 Apr 2019 11:12:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HzY3fBCM5xXVnnRPy5ulOjjA6rr3xijuTSCppzYu1q8=;
 b=oWgbggGppufxT3Z1HVoyBH68tYUXUueT2oXLOG5Ume8o2qBv9I7srM94KYpYtj6R6kV0
 vsk1CV66ygh74izwxYyWuDWdh/zn4VWVKSQtgkzOYPSNR6PquUWwxj6eoD1ipvSnO+cW
 DTZKT2CAikdOhk4YObqpoGZU6PcPYCVR0o4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2ryy82qey8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 11:12:27 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 11:12:26 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 11:12:26 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 11:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzY3fBCM5xXVnnRPy5ulOjjA6rr3xijuTSCppzYu1q8=;
 b=WAnsXHRYzAsaAJ5ETG5CJOBbqSxvcS9lYYO8JzTr8pzv+AgunMq93XH1hwUGMN6YM2vbaHGBnDuAFqLfmYqvzBypU3sj7lR7UCSXSe/MKzapTbKsBMHSUAnTUXmNST8bEc9uQr49OhAIRG07sYqtjE291mRnN63uVswU+BPbggA=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2613.namprd15.prod.outlook.com (20.179.155.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 18:12:24 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 18:12:24 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Matt Mullins <mmullins@fb.com>, Andrew Hall <hall@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Topic: [PATCH bpf-next v3 1/5] bpf: add writable context for raw
 tracepoints
Thread-Index: AQHU9vOB6YI4LMclcUeKr8qdEaM41KZIf/SA
Date:   Mon, 22 Apr 2019 18:12:24 +0000
Message-ID: <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-2-mmullins@fb.com>
In-Reply-To: <20190419210409.5021-2-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1601CA0014.namprd16.prod.outlook.com
 (2603:10b6:300:da::24) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:70ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5de64bc-e19f-4af5-72f4-08d6c74e11bb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2613;
x-ms-traffictypediagnostic: BYAPR15MB2613:
x-microsoft-antispam-prvs: <BYAPR15MB26132CDCD6259A34BB7830F2D3220@BYAPR15MB2613.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(14454004)(4326008)(53936002)(6512007)(36756003)(478600001)(25786009)(486006)(476003)(2616005)(6246003)(11346002)(446003)(2501003)(316002)(5024004)(14444005)(7736002)(110136005)(54906003)(71190400001)(2906002)(256004)(305945005)(71200400001)(5660300002)(99286004)(66446008)(8936002)(66476007)(73956011)(66946007)(68736007)(31696002)(6486002)(6436002)(229853002)(81156014)(8676002)(81166006)(186003)(76176011)(86362001)(2201001)(97736004)(6506007)(386003)(6116002)(31686004)(46003)(53546011)(66556008)(64756008)(52116002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2613;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9XBgTe3goWcHQQXZE0rMvNNLviSeXqP9/t22JEtX74gW5IbsskZXytetI2aOezABDPc3WlIRJaxug43ig3kSiOtqiaoiOoByS8NEt5Pmq2E7PQyI1ieKRzO1VeG8NszLCNoUwQ0e6NL6ii2m2oRiELfVPT3UhKT2lUolW+OKAreFNjYQltqMGq+AUPgFoUEykTHfsGeIlsCtb+dzfHhpPsUk9I7F1tb61M0ppyyY2gRTy3G5CjMV7nmHbPBk624ZJ2odLqg3nM7Zuf3MpDmMfAIO27kp3osJn60TSxoBOBrE2CIpZXB9bbiIHaNRqbOfVCZN0/4JvmiR4g+ZWLytEX6CFSz1cVxuB6AqwVWqxR1WULAcABpeaLzV5h/LqtV5CBQ4rqyxqR0yRtc1SRJrI18K4zJ+g9GSw0e6b5na6DU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CF9CAC5BF2F084A8852EC77D44D4ABF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5de64bc-e19f-4af5-72f4-08d6c74e11bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 18:12:24.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2613
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTkvMTkgMjowNCBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPiBUaGlzIGlzIGFu
IG9wdC1pbiBpbnRlcmZhY2UgdGhhdCBhbGxvd3MgYSB0cmFjZXBvaW50IHRvIHByb3ZpZGUgYSBz
YWZlDQo+IGJ1ZmZlciB0aGF0IGNhbiBiZSB3cml0dGVuIGZyb20gYSBCUEZfUFJPR19UWVBFX1JB
V19UUkFDRVBPSU5UIHByb2dyYW0uDQo+IFRoZSBzaXplIG9mIHRoZSBidWZmZXIgbXVzdCBiZSBh
IGNvbXBpbGUtdGltZSBjb25zdGFudCwgYW5kIGlzIGNoZWNrZWQNCj4gYmVmb3JlIGFsbG93aW5n
IGEgQlBGIHByb2dyYW0gdG8gYXR0YWNoIHRvIGEgdHJhY2Vwb2ludCB0aGF0IHVzZXMgdGhpcw0K
PiBmZWF0dXJlLg0KPiANCj4gVGhlIHBvaW50ZXIgdG8gdGhpcyBidWZmZXIgd2lsbCBiZSB0aGUg
Zmlyc3QgYXJndW1lbnQgb2YgdHJhY2Vwb2ludHMNCj4gdGhhdCBvcHQgaW47IHRoZSBidWZmZXIg
aXMgcmVhZGFibGUgYnkgYm90aCBCUEZfUFJPR19UWVBFX1JBV19UUkFDRVBPSU5UDQo+IGFuZCBC
UEZfUFJPR19UWVBFX1JBV19UUkFDRVBPSU5UX1dSSVRBQkxFIHByb2dyYW1zIHRoYXQgYXR0YWNo
IHRvIHN1Y2ggYQ0KPiB0cmFjZXBvaW50LCBidXQgdGhlIGJ1ZmZlciB0byB3aGljaCBpdCBwb2lu
dHMgbWF5IG9ubHkgYmUgd3JpdHRlbiBieSB0aGUNCj4gbGF0dGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWF0dCBNdWxsaW5zIDxtbXVsbGluc0BmYi5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUv
bGludXgvYnBmLmggICAgICAgICAgICAgfCAgMiArKw0KPiAgIGluY2x1ZGUvbGludXgvYnBmX3R5
cGVzLmggICAgICAgfCAgMSArDQo+ICAgaW5jbHVkZS9saW51eC90cmFjZXBvaW50LWRlZnMuaCB8
ICAxICsNCj4gICBpbmNsdWRlL3RyYWNlL2JwZl9wcm9iZS5oICAgICAgIHwgMjcgKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgICAgICB8
ICAxICsNCj4gICBrZXJuZWwvYnBmL3N5c2NhbGwuYyAgICAgICAgICAgIHwgIDggKysrKysrLS0N
Cj4gICBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgIGtlcm5lbC90cmFjZS9icGZfdHJhY2UuYyAgICAgICAgfCAy
MSArKysrKysrKysrKysrKysrKysrKysNCj4gICA4IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9i
cGYuaCBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gaW5kZXggYTIxMzJlMDlkYzFjLi5kM2M3MWZk
Njc0NzYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9icGYuaA0KPiBAQCAtMjYzLDYgKzI2Myw3IEBAIGVudW0gYnBmX3JlZ190eXBlIHsN
Cj4gICAJUFRSX1RPX1NPQ0tfQ09NTU9OX09SX05VTEwsIC8qIHJlZyBwb2ludHMgdG8gc29ja19j
b21tb24gb3IgTlVMTCAqLw0KPiAgIAlQVFJfVE9fVENQX1NPQ0ssCSAvKiByZWcgcG9pbnRzIHRv
IHN0cnVjdCB0Y3Bfc29jayAqLw0KPiAgIAlQVFJfVE9fVENQX1NPQ0tfT1JfTlVMTCwgLyogcmVn
IHBvaW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgb3IgTlVMTCAqLw0KPiArCVBUUl9UT19UUF9CVUZG
RVIsCSAvKiByZWcgcG9pbnRzIHRvIGEgd3JpdGFibGUgcmF3IHRwJ3MgYnVmZmVyICovDQo+ICAg
fTsNCj4gICANClsuLi5dDQo+ICAgLyogdHJ1bmNhdGUgcmVnaXN0ZXIgdG8gc21hbGxlciBzaXpl
IChpbiBieXRlcykNCj4gICAgKiBtdXN0IGJlIGNhbGxlZCB3aXRoIHNpemUgPCBCUEZfUkVHX1NJ
WkUNCj4gICAgKi8NCj4gQEAgLTIxMDAsNiArMjEyNywxMCBAQCBzdGF0aWMgaW50IGNoZWNrX21l
bV9hY2Nlc3Moc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4LCB1MzIg
cmVnbg0KPiAgIAkJZXJyID0gY2hlY2tfc29ja19hY2Nlc3MoZW52LCBpbnNuX2lkeCwgcmVnbm8s
IG9mZiwgc2l6ZSwgdCk7DQo+ICAgCQlpZiAoIWVyciAmJiB2YWx1ZV9yZWdubyA+PSAwKQ0KPiAg
IAkJCW1hcmtfcmVnX3Vua25vd24oZW52LCByZWdzLCB2YWx1ZV9yZWdubyk7DQo+ICsJfSBlbHNl
IGlmIChyZWctPnR5cGUgPT0gUFRSX1RPX1RQX0JVRkZFUikgew0KPiArCQllcnIgPSBjaGVja190
cF9idWZmZXJfYWNjZXNzKGVudiwgcmVnLCByZWdubywgb2ZmLCBzaXplKTsNCj4gKwkJaWYgKCFl
cnIgJiYgdCA9PSBCUEZfUkVBRCAmJiB2YWx1ZV9yZWdubyA+PSAwKQ0KPiArCQkJbWFya19yZWdf
dW5rbm93bihlbnYsIHJlZ3MsIHZhbHVlX3JlZ25vKTsNCj4gICAJfSBlbHNlIHsNCj4gICAJCXZl
cmJvc2UoZW52LCAiUiVkIGludmFsaWQgbWVtIGFjY2VzcyAnJXMnXG4iLCByZWdubywNCj4gICAJ
CQlyZWdfdHlwZV9zdHJbcmVnLT50eXBlXSk7DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2Uv
YnBmX3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gaW5kZXggZDY0YzAwYWZj
ZWI1Li5hMmRkNzlkYzY4NzEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2Uu
Yw0KPiArKysgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gQEAgLTkwOSw2ICs5MDksMjQg
QEAgY29uc3Qgc3RydWN0IGJwZl92ZXJpZmllcl9vcHMgcmF3X3RyYWNlcG9pbnRfdmVyaWZpZXJf
b3BzID0gew0KPiAgIGNvbnN0IHN0cnVjdCBicGZfcHJvZ19vcHMgcmF3X3RyYWNlcG9pbnRfcHJv
Z19vcHMgPSB7DQo+ICAgfTsNCj4gICANCj4gK3N0YXRpYyBib29sIHJhd190cF93cml0YWJsZV9w
cm9nX2lzX3ZhbGlkX2FjY2VzcyhpbnQgb2ZmLCBpbnQgc2l6ZSwNCj4gKwkJCQkJCSBlbnVtIGJw
Zl9hY2Nlc3NfdHlwZSB0eXBlLA0KPiArCQkJCQkJIGNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJv
ZywNCj4gKwkJCQkJCSBzdHJ1Y3QgYnBmX2luc25fYWNjZXNzX2F1eCAqaW5mbykNCj4gK3sNCj4g
KwlpZiAob2ZmID09IDAgJiYgc2l6ZSA9PSBzaXplb2YodTY0KSkNCj4gKwkJaW5mby0+cmVnX3R5
cGUgPSBQVFJfVE9fVFBfQlVGRkVSOw0KDQpvbiAzMmJpdCBzeXN0ZW0sIHRoZSBmaXJzdCBhcmd1
bWVudCBwb2ludGVyIHNpemUgY291bGQgYmUgc2l6ZW9mKHUzMik/DQpTaG91bGQgdGhlIGZpcnN0
IGFyZ3VtZW50IGZvciByYXdfdHBfd3JpdGFibGVfcHJvZyBiZSBhbHdheXMgDQpQVFJfVE9fVFBf
QlVGRkVSPw0KDQoNCj4gKwlyZXR1cm4gcmF3X3RwX3Byb2dfaXNfdmFsaWRfYWNjZXNzKG9mZiwg
c2l6ZSwgdHlwZSwgcHJvZywgaW5mbyk7DQo+ICt9DQo+ICsNCj4gK2NvbnN0IHN0cnVjdCBicGZf
dmVyaWZpZXJfb3BzIHJhd190cmFjZXBvaW50X3dyaXRhYmxlX3ZlcmlmaWVyX29wcyA9IHsNCj4g
KwkuZ2V0X2Z1bmNfcHJvdG8gID0gcmF3X3RwX3Byb2dfZnVuY19wcm90bywNCj4gKwkuaXNfdmFs
aWRfYWNjZXNzID0gcmF3X3RwX3dyaXRhYmxlX3Byb2dfaXNfdmFsaWRfYWNjZXNzLA0KPiArfTsN
Cj4gKw0KPiArY29uc3Qgc3RydWN0IGJwZl9wcm9nX29wcyByYXdfdHJhY2Vwb2ludF93cml0YWJs
ZV9wcm9nX29wcyA9IHsNCj4gK307DQo+ICsNCj4gICBzdGF0aWMgYm9vbCBwZV9wcm9nX2lzX3Zh
bGlkX2FjY2VzcyhpbnQgb2ZmLCBpbnQgc2l6ZSwgZW51bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwN
Cj4gICAJCQkJICAgIGNvbnN0IHN0cnVjdCBicGZfcHJvZyAqcHJvZywNCj4gICAJCQkJICAgIHN0
cnVjdCBicGZfaW5zbl9hY2Nlc3NfYXV4ICppbmZvKQ0KPiBAQCAtMTE5OCw2ICsxMjE2LDkgQEAg
c3RhdGljIGludCBfX2JwZl9wcm9iZV9yZWdpc3RlcihzdHJ1Y3QgYnBmX3Jhd19ldmVudF9tYXAg
KmJ0cCwgc3RydWN0IGJwZl9wcm9nICoNCj4gICAJaWYgKHByb2ctPmF1eC0+bWF4X2N0eF9vZmZz
ZXQgPiBidHAtPm51bV9hcmdzICogc2l6ZW9mKHU2NCkpDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gICANCj4gKwlpZiAocHJvZy0+YXV4LT5tYXhfdHBfYWNjZXNzID4gYnRwLT53cml0YWJsZV9z
aXplKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgIAlyZXR1cm4gdHJhY2Vwb2ludF9w
cm9iZV9yZWdpc3Rlcih0cCwgKHZvaWQgKilidHAtPmJwZl9mdW5jLCBwcm9nKTsNCj4gICB9DQo+
ICAgDQo+IA0K
