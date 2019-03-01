Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1744E20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LYRzLUr4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eUcMQieR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfCAGbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:31:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbfCAGbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:31:02 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x216M5Lo015386;
        Thu, 28 Feb 2019 22:30:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Y7aDRA4zLWVUOyKWQE1PWJ6cd4rdEMkgKArDrRmectg=;
 b=LYRzLUr4Car2pud06bmQNL6gbj7F/WabDYbeVblfGUDBaLIitdcRvT5TSQWcIdMi0gPx
 gagSqEMRVoqJqzF2IkE2+onxm1jxdVkxM1OvQyXD5qYtuXpkpVfQNK2p/91yVqI5VphB
 TjYRgTAC7MltCuMjyeU3M9PWZ6eLlopmxtU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qxupsrjdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 22:30:21 -0800
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub03.TheFacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 28 Feb 2019 22:30:20 -0800
Received: from frc-hub05.TheFacebook.com (192.168.177.75) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 28 Feb 2019 22:30:20 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 28 Feb 2019 22:30:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7aDRA4zLWVUOyKWQE1PWJ6cd4rdEMkgKArDrRmectg=;
 b=eUcMQieRAP+C5PkzYADFG/hQNfeMM6e0NXxtacIJgJ0cJYIQRcLeCcqU/HjMmoXJHE/cBxNIcUHzwnuhgk1URqSdP76kEavbkYMsTAKJ+/a6FJiRSjR7CatBtwzqM64/iz/vpdzosEH5H2jwmmc5xcKDRG+eX/tcRdywCUe97v8=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2630.namprd15.prod.outlook.com (20.179.156.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 06:30:17 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 06:30:17 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5 3/6] uaccess: Add non-pagefault user-space read
 functions
Thread-Topic: [PATCH v5 3/6] uaccess: Add non-pagefault user-space read
 functions
Thread-Index: AQHUz39IYmYXzWXlk0md3tL+pQqyDKX1SqyAgADDdYCAAENUgA==
Date:   Fri, 1 Mar 2019 06:30:17 +0000
Message-ID: <b2b14665-9508-604e-6fa0-c9466dd18e7a@fb.com>
References: <155136974478.2968.3105123100519786079.stgit@devbox>
 <155136983467.2968.13980231890937828195.stgit@devbox>
 <40eae910-16f3-8c6f-6cc7-c52b77b30ccd@fb.com>
 <20190301112915.f00e5d5c894f73da50746bcf@kernel.org>
In-Reply-To: <20190301112915.f00e5d5c894f73da50746bcf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e3373d-37d2-4051-d355-08d69e0f5e88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2630;
x-ms-traffictypediagnostic: BYAPR15MB2630:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2630;20:tTr0MOofAgvoUU2gaoW2XSPw/8FhSd4JyNnGtxUt4PVF0Qv7s/klzexGIM0X7Isj2oqLTpdMj0I4Q0ONI2pektfjYQS/QHwvUCrobb6M2wE5SLM7S1aNbZD66CwVkeSim/8/vzb/XudOoYSRRWH7z3IAV++T87EF7BqIFNrBrVQ=
x-microsoft-antispam-prvs: <BYAPR15MB26306558F3DB7868E3A9D23CD3760@BYAPR15MB2630.namprd15.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(51914003)(189003)(14444005)(4326008)(2906002)(256004)(5660300002)(7736002)(81156014)(478600001)(71200400001)(71190400001)(8676002)(25786009)(2616005)(386003)(486006)(97736004)(476003)(53936002)(53546011)(305945005)(81166006)(6486002)(14454004)(6506007)(229853002)(102836004)(68736007)(31696002)(54906003)(7416002)(446003)(6512007)(46003)(86362001)(11346002)(316002)(6916009)(8936002)(36756003)(186003)(76176011)(52116002)(93886005)(6246003)(105586002)(106356001)(31686004)(6436002)(6116002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2630;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7AxaxiVBBTPPWk8yBIiD1Q5dtvWu0ixWc2bmCcM7LQCMTI4/erZcZkJB2uf8/5lqzaAz2zyvMpjVbDjLWBK7fZIyfl3MyVktIEGRBSrOCsMXLKs2t2C2fu+skd/xMHRr4CGiIMP7t0dDZA1Cr+wJlNvKkfyDpH4g0iS64cG9vVe7ohXViX/7e0xIuAUKsSBLKvEQW9fwZ7/egE4B5033VXOPHgoSPPKXLB7Ce8KIfmiujsz4g6brB0w40h3waqaM+NB2mfHoY3NsVx9XYD7y8/INaSYIxTpKilEPyu9X5/7RbgLL+HrPmw6BYr0IHNyqt+Gu/vrO7J1WKFxlKyd0byOu7q0BpQxhQeEcHJwdnXSdMr6nmjD1350SYmD7yd51+hZjVM37hkW++RUd4nbbDU0Y6cAjKm1bBz6bRgUWry0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F0E62BE465D814E82D692AC3AD329E5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3373d-37d2-4051-d355-08d69e0f5e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 06:30:17.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMjgvMTkgNjoyOSBQTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gSGkgWW9u
Z2hvbmcsDQo+IA0KPiBPbiBUaHUsIDI4IEZlYiAyMDE5IDIyOjQ5OjQzICswMDAwDQo+IFlvbmdo
b25nIFNvbmcgPHloc0BmYi5jb20+IHdyb3RlOg0KPiANCj4+DQo+Pg0KPj4gT24gMi8yOC8xOSA4
OjAzIEFNLCBNYXNhbWkgSGlyYW1hdHN1IHdyb3RlOg0KPj4+IEFkZCBwcm9iZV91c2VyX3JlYWQo
KSwgc3RybmNweV9mcm9tX3Vuc2FmZV91c2VyKCkgYW5kDQo+Pj4gc3Rybmxlbl91bnNhZmVfdXNl
cigpIHdoaWNoIGFsbG93cyBjYWxsZXIgdG8gYWNjZXNzIHVzZXItc3BhY2UNCj4+PiBpbiBJUlEg
Y29udGV4dC4NCj4+Pg0KPj4+IEN1cnJlbnQgcHJvYmVfa2VybmVsX3JlYWQoKSBhbmQgc3RybmNw
eV9mcm9tX3Vuc2FmZSgpIGFyZQ0KPj4+IG5vdCBhdmFpbGFibGUgZm9yIHVzZXItc3BhY2UgbWVt
b3J5LCBiZWNhdXNlIGl0IHNldHMNCj4+PiBLRVJORUxfRFMgd2hpbGUgYWNjZXNzaW5nIGRhdGEu
IE9uIHNvbWUgYXJjaCwgdXNlciBhZGRyZXNzDQo+Pj4gc3BhY2UgYW5kIGtlcm5lbCBhZGRyZXNz
IHNwYWNlIGNhbiBiZSBjby1leGlzdCwgYnV0IG90aGVycw0KPj4+IGNhbiBub3QuIEluIHRoYXQg
Y2FzZSwgc2V0dGluZyBLRVJORUxfRFMgbWVhbnMgZ2l2ZW4NCj4+DQo+PiBKdXN0IGN1cmlvdXMu
IEdpdmVuIHRoZSBsaXN0IG9mIGFyY2gncyBjdXJyZW50bHkgbGludXggc3VwcG9ydHMsDQo+PiBk
byB5b3Uga25vdyB3aGljaCBhcmNoJ3MgZmFsbCBpbnRvICJ1c2VyIGFkZHJlc3Mgc3BhY2UgYW5k
DQo+PiBrZXJuZWwgYWRkcmVzcyBzcGFjZSIgY2FuIGNvLWV4aXN0LCBhbmQgd2hpY2ggYXJjaCdz
IGNhbm5vdD8NCj4gDQo+IEFzIGZhciBhcyBJIGNhbiBoZWFyZCwgKGFuZCBiYXNlZCBvbiBwcm9i
ZV9rZXJuZWxfcmVhZCgpIGZhaWx1cmUpDQo+IHNwYXJjMzIgKGFuZCBzcGFyYzY0PyksIGFybTY0
LCBhbmQgczM5MCB3aWxsIG5vdCB3b3JrLg0KPiB4ODYgd29ya3MsIGJ1dCBpZiB1c2VyIHBhdGNo
IHRoZSA0Ry80RywgaXQgc2hvdWxkbid0IHdvcmsuDQoNClRoYW5rcyBmb3IgdGhlIGluZm8hIEdy
ZWF0IHRvIGtub3cgdGhlIGRldGFpbHMuDQoNCj4gDQo+IFRoYW5rIHlvdSwNCj4gDQo+Pg0KPj4g
VGhhbmtzIQ0KPj4NCj4+IFlvbmdob25nDQo+Pg0KPj4NCj4+PiBhZGRyZXNzIGlzIHRyZWF0ZWQg
YXMgYSBrZXJuZWwgYWRkcmVzcyBzcGFjZS4NCj4+PiBBbHNvIHN0cm5sZW5fdXNlcigpIGlzIG9u
bHkgYXZhaWxhYmxlIGZyb20gdXNlciBjb250ZXh0IHNpbmNlDQo+Pj4gaXQgY2FuIHNsZWVwIGlm
IHBhZ2VmYXVsdCBpcyBlbmFibGVkLg0KPj4+DQo+Pj4gVG8gYWNjZXNzIHVzZXItc3BhY2UgbWVt
b3J5IHdpdGhvdXQgcGFnZWZhdWx0LCB3ZSBuZWVkDQo+Pj4gdGhlc2UgbmV3IGZ1bmN0aW9ucyB3
aGljaCBzZXRzIFVTRVJfRFMgd2hpbGUgYWNjZXNzaW5nDQo+Pj4gdGhlIGRhdGEuDQo+Pj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0K
Pj4+IC0tLQ0KPj4+ICAgICBDaGFuZ2VzIGluIHY1Og0KPj4+ICAgICAgLSBTaW1wbGlmeSBwcm9i
ZV91c2VyX3JlYWQoKSAoVGhhbmtzLCBQZXRlciEpDQo+Pj4gICAgICAtIEFkZCBzdHJubGVuX3Vu
c2FmZV91c2VyKCkNCj4+PiAgICAgQ2hhbmdlcyBpbiB2MzoNCj4+PiAgICAgIC0gVXNlIHVzZXJf
YWNjZXNzX29rKCkgZm9yIHByb2JlX3VzZXJfcmVhZCgpLg0KPj4+ICAgICBDaGFuZ2VzIGluIHYy
Og0KPj4+ICAgICAgLSBTaW1wbGlmeSBzdHJuY3B5X2Zyb21fdW5zYWZlX3VzZXIoKSB1c2luZyBz
dHJuY3B5X2Zyb21fdXNlcigpDQo+Pj4gICAgICAgIGFjY29yZGluZyB0byBMaW51cydzIHN1Z2dl
c3Rpb24uDQo+Pj4gICAgICAtIFNpbXBsaWZ5IHByb2JlX3VzZXJfcmVhZCgpIG5vdCB1c2luZyBp
bnRlcm1lZGlhdGUgZnVuY3Rpb24uDQo+Pj4gLS0tDQo+Pj4gICAgaW5jbHVkZS9saW51eC91YWNj
ZXNzLmggfCAgIDE0ICsrKysrDQo+Pj4gICAgbW0vbWFjY2Vzcy5jICAgICAgICAgICAgfCAgMTIy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCBiL2luY2x1ZGUvbGludXgv
dWFjY2Vzcy5oDQo+Pj4gaW5kZXggMWFmZDlkZmFiZTY3Li41YmU3ZjlhZGI0MTggMTAwNjQ0DQo+
Pj4gLS0tIGEvaW5jbHVkZS9saW51eC91YWNjZXNzLmgNCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4
L3VhY2Nlc3MuaA0KPj4+IEBAIC0yNTgsNiArMjU4LDE3IEBAIGV4dGVybiBsb25nIHByb2JlX2tl
cm5lbF9yZWFkKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc2l6ZSk7DQo+Pj4g
ICAgZXh0ZXJuIGxvbmcgX19wcm9iZV9rZXJuZWxfcmVhZCh2b2lkICpkc3QsIGNvbnN0IHZvaWQg
KnNyYywgc2l6ZV90IHNpemUpOw0KPj4+ICAgIA0KPj4+ICAgIC8qDQo+Pj4gKyAqIHByb2JlX3Vz
ZXJfcmVhZCgpOiBzYWZlbHkgYXR0ZW1wdCB0byByZWFkIGZyb20gYSBsb2NhdGlvbiBpbiB1c2Vy
IHNwYWNlDQo+Pj4gKyAqIEBkc3Q6IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciB0aGF0IHNoYWxsIHRh
a2UgdGhlIGRhdGENCj4+PiArICogQHNyYzogYWRkcmVzcyB0byByZWFkIGZyb20NCj4+PiArICog
QHNpemU6IHNpemUgb2YgdGhlIGRhdGEgY2h1bmsNCj4+PiArICoNCj4+PiArICogU2FmZWx5IHJl
YWQgZnJvbSBhZGRyZXNzIEBzcmMgdG8gdGhlIGJ1ZmZlciBhdCBAZHN0LiAgSWYgYSBrZXJuZWwg
ZmF1bHQNCj4+PiArICogaGFwcGVucywgaGFuZGxlIHRoYXQgYW5kIHJldHVybiAtRUZBVUxULg0K
Pj4+ICsgKi8NCj4+PiArZXh0ZXJuIGxvbmcgcHJvYmVfdXNlcl9yZWFkKHZvaWQgKmRzdCwgY29u
c3Qgdm9pZCBfX3VzZXIgKnNyYywgc2l6ZV90IHNpemUpOw0KPj4+ICsNCj4+PiArLyoNCj4+PiAg
ICAgKiBwcm9iZV9rZXJuZWxfd3JpdGUoKTogc2FmZWx5IGF0dGVtcHQgdG8gd3JpdGUgdG8gYSBs
b2NhdGlvbg0KPj4+ICAgICAqIEBkc3Q6IGFkZHJlc3MgdG8gd3JpdGUgdG8NCj4+PiAgICAgKiBA
c3JjOiBwb2ludGVyIHRvIHRoZSBkYXRhIHRoYXQgc2hhbGwgYmUgd3JpdHRlbg0KPj4+IEBAIC0y
NzAsNiArMjgxLDkgQEAgZXh0ZXJuIGxvbmcgbm90cmFjZSBwcm9iZV9rZXJuZWxfd3JpdGUodm9p
ZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzaXplKTsNCj4+PiAgICBleHRlcm4gbG9u
ZyBub3RyYWNlIF9fcHJvYmVfa2VybmVsX3dyaXRlKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3Jj
LCBzaXplX3Qgc2l6ZSk7DQo+Pj4gICAgDQo+Pj4gICAgZXh0ZXJuIGxvbmcgc3RybmNweV9mcm9t
X3Vuc2FmZShjaGFyICpkc3QsIGNvbnN0IHZvaWQgKnVuc2FmZV9hZGRyLCBsb25nIGNvdW50KTsN
Cj4+PiArZXh0ZXJuIGxvbmcgc3RybmNweV9mcm9tX3Vuc2FmZV91c2VyKGNoYXIgKmRzdCwgY29u
c3Qgdm9pZCBfX3VzZXIgKnVuc2FmZV9hZGRyLA0KPj4+ICsJCQkJICAgICBsb25nIGNvdW50KTsN
Cj4+PiArZXh0ZXJuIGxvbmcgc3Rybmxlbl91bnNhZmVfdXNlcihjb25zdCB2b2lkIF9fdXNlciAq
dW5zYWZlX2FkZHIsIGxvbmcgY291bnQpOw0KPj4+ICAgIA0KPj4+ICAgIC8qKg0KPj4+ICAgICAq
IHByb2JlX2tlcm5lbF9hZGRyZXNzKCk6IHNhZmVseSBhdHRlbXB0IHRvIHJlYWQgZnJvbSBhIGxv
Y2F0aW9uDQo+Pj4gZGlmZiAtLWdpdCBhL21tL21hY2Nlc3MuYyBiL21tL21hY2Nlc3MuYw0KPj4+
IGluZGV4IGVjMDBiZTUxYTI0Zi4uZDFiMmVjNzhkOWVmIDEwMDY0NA0KPj4+IC0tLSBhL21tL21h
Y2Nlc3MuYw0KPj4+ICsrKyBiL21tL21hY2Nlc3MuYw0KPj4+IEBAIC01LDggKzUsMjAgQEANCj4+
PiAgICAjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4+PiAgICAjaW5jbHVkZSA8bGludXgvdWFjY2Vz
cy5oPg0KPj4+ICAgIA0KPj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIGxvbmcNCj4+PiArcHJv
YmVfcmVhZF9jb21tb24odm9pZCAqZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCBzaXplX3Qg
c2l6ZSkNCj4+PiArew0KPj4+ICsJbG9uZyByZXQ7DQo+Pj4gKw0KPj4+ICsJcGFnZWZhdWx0X2Rp
c2FibGUoKTsNCj4+PiArCXJldCA9IF9fY29weV9mcm9tX3VzZXJfaW5hdG9taWMoZHN0LCBzcmMs
IHNpemUpOw0KPj4+ICsJcGFnZWZhdWx0X2VuYWJsZSgpOw0KPj4+ICsNCj4+PiArCXJldHVybiBy
ZXQgPyAtRUZBVUxUIDogMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiAgICAvKioNCj4+PiAtICogcHJv
YmVfa2VybmVsX3JlYWQoKTogc2FmZWx5IGF0dGVtcHQgdG8gcmVhZCBmcm9tIGEgbG9jYXRpb24N
Cj4+PiArICogcHJvYmVfa2VybmVsX3JlYWQoKTogc2FmZWx5IGF0dGVtcHQgdG8gcmVhZCBmcm9t
IGEga2VybmVsLXNwYWNlIGxvY2F0aW9uDQo+Pj4gICAgICogQGRzdDogcG9pbnRlciB0byB0aGUg
YnVmZmVyIHRoYXQgc2hhbGwgdGFrZSB0aGUgZGF0YQ0KPj4+ICAgICAqIEBzcmM6IGFkZHJlc3Mg
dG8gcmVhZCBmcm9tDQo+Pj4gICAgICogQHNpemU6IHNpemUgb2YgdGhlIGRhdGEgY2h1bmsNCj4+
PiBAQCAtMjksMTcgKzQxLDQ1IEBAIGxvbmcgX19wcm9iZV9rZXJuZWxfcmVhZCh2b2lkICpkc3Qs
IGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IHNpemUpDQo+Pj4gICAgCW1tX3NlZ21lbnRfdCBvbGRf
ZnMgPSBnZXRfZnMoKTsNCj4+PiAgICANCj4+PiAgICAJc2V0X2ZzKEtFUk5FTF9EUyk7DQo+Pj4g
LQlwYWdlZmF1bHRfZGlzYWJsZSgpOw0KPj4+IC0JcmV0ID0gX19jb3B5X2Zyb21fdXNlcl9pbmF0
b21pYyhkc3QsDQo+Pj4gLQkJCShfX2ZvcmNlIGNvbnN0IHZvaWQgX191c2VyICopc3JjLCBzaXpl
KTsNCj4+PiAtCXBhZ2VmYXVsdF9lbmFibGUoKTsNCj4+PiArCXJldCA9IHByb2JlX3JlYWRfY29t
bW9uKGRzdCwgKF9fZm9yY2UgY29uc3Qgdm9pZCBfX3VzZXIgKilzcmMsIHNpemUpOw0KPj4+ICAg
IAlzZXRfZnMob2xkX2ZzKTsNCj4+PiAgICANCj4+PiAtCXJldHVybiByZXQgPyAtRUZBVUxUIDog
MDsNCj4+PiArCXJldHVybiByZXQ7DQo+Pj4gICAgfQ0KPj4+ICAgIEVYUE9SVF9TWU1CT0xfR1BM
KHByb2JlX2tlcm5lbF9yZWFkKTsNCj4+PiAgICANCj4+PiAgICAvKioNCj4+PiArICogcHJvYmVf
dXNlcl9yZWFkKCk6IHNhZmVseSBhdHRlbXB0IHRvIHJlYWQgZnJvbSBhIHVzZXItc3BhY2UgbG9j
YXRpb24NCj4+PiArICogQGRzdDogcG9pbnRlciB0byB0aGUgYnVmZmVyIHRoYXQgc2hhbGwgdGFr
ZSB0aGUgZGF0YQ0KPj4+ICsgKiBAc3JjOiBhZGRyZXNzIHRvIHJlYWQgZnJvbS4gVGhpcyBtdXN0
IGJlIGEgdXNlciBhZGRyZXNzLg0KPj4+ICsgKiBAc2l6ZTogc2l6ZSBvZiB0aGUgZGF0YSBjaHVu
aw0KPj4+ICsgKg0KPj4+ICsgKiBTYWZlbHkgcmVhZCBmcm9tIHVzZXIgYWRkcmVzcyBAc3JjIHRv
IHRoZSBidWZmZXIgYXQgQGRzdC4gSWYgYSBrZXJuZWwgZmF1bHQNCj4+PiArICogaGFwcGVucywg
aGFuZGxlIHRoYXQgYW5kIHJldHVybiAtRUZBVUxULg0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gK2xv
bmcgX193ZWFrIHByb2JlX3VzZXJfcmVhZCh2b2lkICpkc3QsIGNvbnN0IHZvaWQgX191c2VyICpz
cmMsIHNpemVfdCBzaXplKQ0KPj4+ICsgICAgX19hdHRyaWJ1dGVfXygoYWxpYXMoIl9fcHJvYmVf
dXNlcl9yZWFkIikpKTsNCj4+PiArDQo+Pj4gK2xvbmcgX19wcm9iZV91c2VyX3JlYWQodm9pZCAq
ZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCBzaXplX3Qgc2l6ZSkNCj4+PiArew0KPj4+ICsJ
bG9uZyByZXQgPSAtRUZBVUxUOw0KPj4+ICsJbW1fc2VnbWVudF90IG9sZF9mcyA9IGdldF9mcygp
Ow0KPj4+ICsNCj4+PiArCS8qDQo+Pj4gKwkgKiBTaW5jZSB0aGlzIGNhbiBiZSBjYWxsZWQgaW4g
SVJRIGNvbnRleHQsIHdlIGNhcmVmdWxseSBzZXQgdGhlDQo+Pj4gKwkgKiBVU0VSX0RTIGFuZCB1
c2UgdXNlcl9hY2Nlc3Nfb2soKSB3aGljaCBjaGVja3Mgc2VnbWVudCBzZXR0aW5nDQo+Pj4gKwkg
KiBpbnN0ZWFkIG9mIHRhc2sgY29udGV4dC4NCj4+PiArCSAqLw0KPj4+ICsJc2V0X2ZzKFVTRVJf
RFMpOw0KPj4+ICsJaWYgKHVzZXJfYWNjZXNzX29rKHNyYywgc2l6ZSkpDQo+Pj4gKwkJcmV0ID0g
cHJvYmVfcmVhZF9jb21tb24oZHN0LCBzcmMsIHNpemUpOw0KPj4+ICsJc2V0X2ZzKG9sZF9mcyk7
DQo+Pj4gKwlyZXR1cm4gcmV0Ow0KPj4+ICt9DQo+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKHByb2Jl
X3VzZXJfcmVhZCk7DQo+Pj4gKw0KPj4+ICsvKioNCj4+PiAgICAgKiBwcm9iZV9rZXJuZWxfd3Jp
dGUoKTogc2FmZWx5IGF0dGVtcHQgdG8gd3JpdGUgdG8gYSBsb2NhdGlvbg0KPj4+ICAgICAqIEBk
c3Q6IGFkZHJlc3MgdG8gd3JpdGUgdG8NCj4+PiAgICAgKiBAc3JjOiBwb2ludGVyIHRvIHRoZSBk
YXRhIHRoYXQgc2hhbGwgYmUgd3JpdHRlbg0KPj4+IEBAIC02Niw2ICsxMDYsNyBAQCBsb25nIF9f
cHJvYmVfa2VybmVsX3dyaXRlKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc2l6
ZSkNCj4+PiAgICB9DQo+Pj4gICAgRVhQT1JUX1NZTUJPTF9HUEwocHJvYmVfa2VybmVsX3dyaXRl
KTsNCj4+PiAgICANCj4+PiArDQo+Pj4gICAgLyoqDQo+Pj4gICAgICogc3RybmNweV9mcm9tX3Vu
c2FmZTogLSBDb3B5IGEgTlVMIHRlcm1pbmF0ZWQgc3RyaW5nIGZyb20gdW5zYWZlIGFkZHJlc3Mu
DQo+Pj4gICAgICogQGRzdDogICBEZXN0aW5hdGlvbiBhZGRyZXNzLCBpbiBrZXJuZWwgc3BhY2Uu
ICBUaGlzIGJ1ZmZlciBtdXN0IGJlIGF0DQo+Pj4gQEAgLTEwNSwzICsxNDYsNzIgQEAgbG9uZyBz
dHJuY3B5X2Zyb21fdW5zYWZlKGNoYXIgKmRzdCwgY29uc3Qgdm9pZCAqdW5zYWZlX2FkZHIsIGxv
bmcgY291bnQpDQo+Pj4gICAgDQo+Pj4gICAgCXJldHVybiByZXQgPyAtRUZBVUxUIDogc3JjIC0g
dW5zYWZlX2FkZHI7DQo+Pj4gICAgfQ0KPj4+ICsNCj4+PiArLyoqDQo+Pj4gKyAqIHN0cm5jcHlf
ZnJvbV91bnNhZmVfdXNlcjogLSBDb3B5IGEgTlVMIHRlcm1pbmF0ZWQgc3RyaW5nIGZyb20gdW5z
YWZlIHVzZXINCj4+PiArICoJCQkJYWRkcmVzcy4NCj4+PiArICogQGRzdDogICBEZXN0aW5hdGlv
biBhZGRyZXNzLCBpbiBrZXJuZWwgc3BhY2UuICBUaGlzIGJ1ZmZlciBtdXN0IGJlIGF0DQo+Pj4g
KyAqICAgICAgICAgbGVhc3QgQGNvdW50IGJ5dGVzIGxvbmcuDQo+Pj4gKyAqIEB1bnNhZmVfYWRk
cjogVW5zYWZlIHVzZXIgYWRkcmVzcy4NCj4+PiArICogQGNvdW50OiBNYXhpbXVtIG51bWJlciBv
ZiBieXRlcyB0byBjb3B5LCBpbmNsdWRpbmcgdGhlIHRyYWlsaW5nIE5VTC4NCj4+PiArICoNCj4+
PiArICogQ29waWVzIGEgTlVMLXRlcm1pbmF0ZWQgc3RyaW5nIGZyb20gdW5zYWZlIHVzZXIgYWRk
cmVzcyB0byBrZXJuZWwgYnVmZmVyLg0KPj4+ICsgKg0KPj4+ICsgKiBPbiBzdWNjZXNzLCByZXR1
cm5zIHRoZSBsZW5ndGggb2YgdGhlIHN0cmluZyBJTkNMVURJTkcgdGhlIHRyYWlsaW5nIE5VTC4N
Cj4+PiArICoNCj4+PiArICogSWYgYWNjZXNzIGZhaWxzLCByZXR1cm5zIC1FRkFVTFQgKHNvbWUg
ZGF0YSBtYXkgaGF2ZSBiZWVuIGNvcGllZA0KPj4+ICsgKiBhbmQgdGhlIHRyYWlsaW5nIE5VTCBh
ZGRlZCkuDQo+Pj4gKyAqDQo+Pj4gKyAqIElmIEBjb3VudCBpcyBzbWFsbGVyIHRoYW4gdGhlIGxl
bmd0aCBvZiB0aGUgc3RyaW5nLCBjb3BpZXMgQGNvdW50LTEgYnl0ZXMsDQo+Pj4gKyAqIHNldHMg
dGhlIGxhc3QgYnl0ZSBvZiBAZHN0IGJ1ZmZlciB0byBOVUwgYW5kIHJldHVybnMgQGNvdW50Lg0K
Pj4+ICsgKi8NCj4+PiArbG9uZyBzdHJuY3B5X2Zyb21fdW5zYWZlX3VzZXIoY2hhciAqZHN0LCBj
b25zdCB2b2lkIF9fdXNlciAqdW5zYWZlX2FkZHIsDQo+Pj4gKwkJCSAgICAgIGxvbmcgY291bnQp
DQo+Pj4gK3sNCj4+PiArCW1tX3NlZ21lbnRfdCBvbGRfZnMgPSBnZXRfZnMoKTsNCj4+PiArCWxv
bmcgcmV0Ow0KPj4+ICsNCj4+PiArCWlmICh1bmxpa2VseShjb3VudCA8PSAwKSkNCj4+PiArCQly
ZXR1cm4gMDsNCj4+PiArDQo+Pj4gKwlzZXRfZnMoVVNFUl9EUyk7DQo+Pj4gKwlwYWdlZmF1bHRf
ZGlzYWJsZSgpOw0KPj4+ICsJcmV0ID0gc3RybmNweV9mcm9tX3VzZXIoZHN0LCB1bnNhZmVfYWRk
ciwgY291bnQpOw0KPj4+ICsJcGFnZWZhdWx0X2VuYWJsZSgpOw0KPj4+ICsJc2V0X2ZzKG9sZF9m
cyk7DQo+Pj4gKwlpZiAocmV0ID49IGNvdW50KSB7DQo+Pj4gKwkJcmV0ID0gY291bnQ7DQo+Pj4g
KwkJZHN0W3JldCAtIDFdID0gJ1wwJzsNCj4+PiArCX0gZWxzZSBpZiAocmV0ID4gMCkNCj4+PiAr
CQlyZXQrKzsNCj4+PiArCXJldHVybiByZXQ7DQo+Pj4gK30NCj4+PiArDQo+Pj4gKy8qKg0KPj4+
ICsgKiBzdHJubGVuX3Vuc2FmZV91c2VyOiAtIEdldCB0aGUgc2l6ZSBvZiBhIHVzZXIgc3RyaW5n
IElOQ0xVRElORyBmaW5hbCBOVUwuDQo+Pj4gKyAqIEB1bnNhZmVfYWRkcjogVGhlIHN0cmluZyB0
byBtZWFzdXJlLg0KPj4+ICsgKiBAY291bnQ6IE1heGltdW0gY291bnQgKGluY2x1ZGluZyBOVUwg
Y2hhcmFjdGVyKQ0KPj4+ICsgKg0KPj4+ICsgKiBHZXQgdGhlIHNpemUgb2YgYSBOVUwtdGVybWlu
YXRlZCBzdHJpbmcgaW4gdXNlciBzcGFjZSB3aXRob3V0IHBhZ2VmYXVsdC4NCj4+PiArICoNCj4+
PiArICogUmV0dXJucyB0aGUgc2l6ZSBvZiB0aGUgc3RyaW5nIElOQ0xVRElORyB0aGUgdGVybWlu
YXRpbmcgTlVMLg0KPj4+ICsgKg0KPj4+ICsgKiBJZiB0aGUgc3RyaW5nIGlzIHRvbyBsb25nLCBy
ZXR1cm5zIGEgbnVtYmVyIGxhcmdlciB0aGFuIEBjb3VudC4gVXNlcg0KPj4+ICsgKiBoYXMgdG8g
Y2hlY2sgdGhlIHJldHVybiB2YWx1ZSBhZ2FpbnN0ICI+IGNvdW50Ii4NCj4+PiArICogT24gZXhj
ZXB0aW9uIChvciBpbnZhbGlkIGNvdW50KSwgcmV0dXJucyAwLg0KPj4+ICsgKg0KPj4+ICsgKiBV
bmxpa2Ugc3Rybmxlbl91c2VyLCB0aGlzIGNhbiBiZSB1c2VkIGZyb20gSVJRIGhhbmRsZXIgZXRj
LiBiZWNhdXNlDQo+Pj4gKyAqIGl0IGRpc2FibGVzIHBhZ2VmYXVsdHMuDQo+Pj4gKyAqLw0KPj4+
ICtsb25nIHN0cm5sZW5fdW5zYWZlX3VzZXIoY29uc3Qgdm9pZCBfX3VzZXIgKnVuc2FmZV9hZGRy
LCBsb25nIGNvdW50KQ0KPj4+ICt7DQo+Pj4gKwltbV9zZWdtZW50X3Qgb2xkX2ZzID0gZ2V0X2Zz
KCk7DQo+Pj4gKwlpbnQgcmV0Ow0KPj4+ICsNCj4+PiArCXNldF9mcyhVU0VSX0RTKTsNCj4+PiAr
CXBhZ2VmYXVsdF9kaXNhYmxlKCk7DQo+Pj4gKwlyZXQgPSBzdHJubGVuX3VzZXIodW5zYWZlX2Fk
ZHIsIGNvdW50KTsNCj4+PiArCXBhZ2VmYXVsdF9lbmFibGUoKTsNCj4+PiArCXNldF9mcyhvbGRf
ZnMpOw0KPj4+ICsJcmV0dXJuIHJldDsNCj4+PiArfQ0KPj4+DQo+IA0KPiANCg==
