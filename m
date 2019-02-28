Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2537C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F4A206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NmNm8+Q9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ymfek7lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfB1Wug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:50:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfB1Wuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:50:35 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SMidqw025163;
        Thu, 28 Feb 2019 14:49:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nUupfsTqZkgsiWkzr8UgLmfVSLiM7oZq9YLWUAsjcx4=;
 b=NmNm8+Q9r87V8XQdENic8QO5DgGBlFJb1LRCZnZ9ZCQLIf/GorLNRslACXUMmgc5W1l+
 TKMcGbzVaOAdpK0pMjf+yq7m/y3rlZKxR/UeDVuswj9xmOMMbwDRDaFJwVq+O/3/NPLT
 pQkhPUNiU4ACkZOgZzSdMkJcFNiivT5e8o8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxpcwgjb4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 14:49:50 -0800
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 14:49:47 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 28 Feb 2019 14:49:46 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 28 Feb 2019 14:49:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUupfsTqZkgsiWkzr8UgLmfVSLiM7oZq9YLWUAsjcx4=;
 b=Ymfek7lI4sTeN7efK1vszmOuE9g3l4Fx80cjGIekYK0wSja+rhokzDDbZPKIzUD1PoZfU0TBe0PTmqbr7DMC//wzc8s2vt0RQ0VOHNi7Ka1TzEriLpgi8P40D0cGNmCgw5kGetP5wynZPtI6tGyL+UMyHwr+w52QoehPwBz+P5w=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2647.namprd15.prod.outlook.com (20.179.156.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 22:49:44 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 22:49:43 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHUz39IYmYXzWXlk0md3tL+pQqyDKX10MmA
Date:   Thu, 28 Feb 2019 22:49:43 +0000
Message-ID: <40eae910-16f3-8c6f-6cc7-c52b77b30ccd@fb.com>
References: <155136974478.2968.3105123100519786079.stgit@devbox>
 <155136983467.2968.13980231890937828195.stgit@devbox>
In-Reply-To: <155136983467.2968.13980231890937828195.stgit@devbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:300:6c::16) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e2ab]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e09e5925-0f85-4e79-93d1-08d69dcf07c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2647;
x-ms-traffictypediagnostic: BYAPR15MB2647:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2647;20:qwrTO+LZqjvGWptTZQd8rSLSQB0J22Dw/J6KVlo1uhLRMsU5FdZYe9jZgJ/hLvIUYLuCC+ROFpr1x0O3X6xJURtNV9KRcsV7Mv1a7ETvvUCHQv6SmgMJUmp58emXdqgltGp4Eu6+DFTXKFhCYq0sMnDimMiKqV0oma/VDW2Cv4E=
x-microsoft-antispam-prvs: <BYAPR15MB264799C36F8D7D9315FEF788D3750@BYAPR15MB2647.namprd15.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(396003)(376002)(366004)(199004)(189003)(31696002)(2616005)(6486002)(6506007)(105586002)(7416002)(106356001)(478600001)(6436002)(305945005)(7736002)(14454004)(68736007)(81156014)(6116002)(31686004)(316002)(71190400001)(6512007)(36756003)(8936002)(81166006)(53936002)(8676002)(71200400001)(2906002)(102836004)(446003)(53546011)(4326008)(256004)(14444005)(52116002)(46003)(186003)(54906003)(5660300002)(25786009)(110136005)(229853002)(97736004)(76176011)(386003)(6246003)(99286004)(86362001)(11346002)(476003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2647;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LgL8tY1hOVEfK7AbtSv4AdjZ7DTJT/VHur9J73U0MK9JCDhEICYtvyI41bIOZlpP6EgLXXAhhR1rm5Yg1cIFgGjHur9mWZkyA2Dvp1IgRX7eALc9SiWnJtlvhat0n4HEanU7ocR9xIK0NdYVz6/tDSMf2CGMxwkVpUyDrBY7r3Brz17Mgq1UEoqsS8VEAKV3jHtBrQgOrwii8o83xZ7TpdnMEKBczTiNFKZSllbenWY6r6iRHKAcpmGt3LblzBXNYmcJPR5E/dYW+EuLkFgf19wVD6LK8io90mfsGQw29MPICRy/1AhREBdruUQFyKpcCc4emF1HSCG3rylL3HJrbdNKvx87KevmnzyhXgp3YwNwdlbNq4UHl6677CR33DHPGYWD5nRa6Z2X2blGORwBGcVX9qDvapo6EK1TlGLJ+fs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED4DB3D79E434B489F57AB480E7744FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e09e5925-0f85-4e79-93d1-08d69dcf07c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 22:49:43.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMjgvMTkgODowMyBBTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gQWRkIHBy
b2JlX3VzZXJfcmVhZCgpLCBzdHJuY3B5X2Zyb21fdW5zYWZlX3VzZXIoKSBhbmQNCj4gc3Rybmxl
bl91bnNhZmVfdXNlcigpIHdoaWNoIGFsbG93cyBjYWxsZXIgdG8gYWNjZXNzIHVzZXItc3BhY2UN
Cj4gaW4gSVJRIGNvbnRleHQuDQo+IA0KPiBDdXJyZW50IHByb2JlX2tlcm5lbF9yZWFkKCkgYW5k
IHN0cm5jcHlfZnJvbV91bnNhZmUoKSBhcmUNCj4gbm90IGF2YWlsYWJsZSBmb3IgdXNlci1zcGFj
ZSBtZW1vcnksIGJlY2F1c2UgaXQgc2V0cw0KPiBLRVJORUxfRFMgd2hpbGUgYWNjZXNzaW5nIGRh
dGEuIE9uIHNvbWUgYXJjaCwgdXNlciBhZGRyZXNzDQo+IHNwYWNlIGFuZCBrZXJuZWwgYWRkcmVz
cyBzcGFjZSBjYW4gYmUgY28tZXhpc3QsIGJ1dCBvdGhlcnMNCj4gY2FuIG5vdC4gSW4gdGhhdCBj
YXNlLCBzZXR0aW5nIEtFUk5FTF9EUyBtZWFucyBnaXZlbg0KDQpKdXN0IGN1cmlvdXMuIEdpdmVu
IHRoZSBsaXN0IG9mIGFyY2gncyBjdXJyZW50bHkgbGludXggc3VwcG9ydHMsDQpkbyB5b3Uga25v
dyB3aGljaCBhcmNoJ3MgZmFsbCBpbnRvICJ1c2VyIGFkZHJlc3Mgc3BhY2UgYW5kDQprZXJuZWwg
YWRkcmVzcyBzcGFjZSIgY2FuIGNvLWV4aXN0LCBhbmQgd2hpY2ggYXJjaCdzIGNhbm5vdD8NCg0K
VGhhbmtzIQ0KDQpZb25naG9uZw0KDQoNCj4gYWRkcmVzcyBpcyB0cmVhdGVkIGFzIGEga2VybmVs
IGFkZHJlc3Mgc3BhY2UuDQo+IEFsc28gc3Rybmxlbl91c2VyKCkgaXMgb25seSBhdmFpbGFibGUg
ZnJvbSB1c2VyIGNvbnRleHQgc2luY2UNCj4gaXQgY2FuIHNsZWVwIGlmIHBhZ2VmYXVsdCBpcyBl
bmFibGVkLg0KPiANCj4gVG8gYWNjZXNzIHVzZXItc3BhY2UgbWVtb3J5IHdpdGhvdXQgcGFnZWZh
dWx0LCB3ZSBuZWVkDQo+IHRoZXNlIG5ldyBmdW5jdGlvbnMgd2hpY2ggc2V0cyBVU0VSX0RTIHdo
aWxlIGFjY2Vzc2luZw0KPiB0aGUgZGF0YS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hc2FtaSBI
aXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgICBDaGFuZ2VzIGluIHY1
Og0KPiAgICAgLSBTaW1wbGlmeSBwcm9iZV91c2VyX3JlYWQoKSAoVGhhbmtzLCBQZXRlciEpDQo+
ICAgICAtIEFkZCBzdHJubGVuX3Vuc2FmZV91c2VyKCkNCj4gICAgQ2hhbmdlcyBpbiB2MzoNCj4g
ICAgIC0gVXNlIHVzZXJfYWNjZXNzX29rKCkgZm9yIHByb2JlX3VzZXJfcmVhZCgpLg0KPiAgICBD
aGFuZ2VzIGluIHYyOg0KPiAgICAgLSBTaW1wbGlmeSBzdHJuY3B5X2Zyb21fdW5zYWZlX3VzZXIo
KSB1c2luZyBzdHJuY3B5X2Zyb21fdXNlcigpDQo+ICAgICAgIGFjY29yZGluZyB0byBMaW51cydz
IHN1Z2dlc3Rpb24uDQo+ICAgICAtIFNpbXBsaWZ5IHByb2JlX3VzZXJfcmVhZCgpIG5vdCB1c2lu
ZyBpbnRlcm1lZGlhdGUgZnVuY3Rpb24uDQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvdWFjY2Vz
cy5oIHwgICAxNCArKysrKw0KPiAgIG1tL21hY2Nlc3MuYyAgICAgICAgICAgIHwgIDEyMiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC91YWNjZXNzLmggYi9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaA0K
PiBpbmRleCAxYWZkOWRmYWJlNjcuLjViZTdmOWFkYjQxOCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC91YWNjZXNzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91YWNjZXNzLmgNCj4gQEAg
LTI1OCw2ICsyNTgsMTcgQEAgZXh0ZXJuIGxvbmcgcHJvYmVfa2VybmVsX3JlYWQodm9pZCAqZHN0
LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzaXplKTsNCj4gICBleHRlcm4gbG9uZyBfX3Byb2Jl
X2tlcm5lbF9yZWFkKHZvaWQgKmRzdCwgY29uc3Qgdm9pZCAqc3JjLCBzaXplX3Qgc2l6ZSk7DQo+
ICAgDQo+ICAgLyoNCj4gKyAqIHByb2JlX3VzZXJfcmVhZCgpOiBzYWZlbHkgYXR0ZW1wdCB0byBy
ZWFkIGZyb20gYSBsb2NhdGlvbiBpbiB1c2VyIHNwYWNlDQo+ICsgKiBAZHN0OiBwb2ludGVyIHRv
IHRoZSBidWZmZXIgdGhhdCBzaGFsbCB0YWtlIHRoZSBkYXRhDQo+ICsgKiBAc3JjOiBhZGRyZXNz
IHRvIHJlYWQgZnJvbQ0KPiArICogQHNpemU6IHNpemUgb2YgdGhlIGRhdGEgY2h1bmsNCj4gKyAq
DQo+ICsgKiBTYWZlbHkgcmVhZCBmcm9tIGFkZHJlc3MgQHNyYyB0byB0aGUgYnVmZmVyIGF0IEBk
c3QuICBJZiBhIGtlcm5lbCBmYXVsdA0KPiArICogaGFwcGVucywgaGFuZGxlIHRoYXQgYW5kIHJl
dHVybiAtRUZBVUxULg0KPiArICovDQo+ICtleHRlcm4gbG9uZyBwcm9iZV91c2VyX3JlYWQodm9p
ZCAqZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCBzaXplX3Qgc2l6ZSk7DQo+ICsNCj4gKy8q
DQo+ICAgICogcHJvYmVfa2VybmVsX3dyaXRlKCk6IHNhZmVseSBhdHRlbXB0IHRvIHdyaXRlIHRv
IGEgbG9jYXRpb24NCj4gICAgKiBAZHN0OiBhZGRyZXNzIHRvIHdyaXRlIHRvDQo+ICAgICogQHNy
YzogcG9pbnRlciB0byB0aGUgZGF0YSB0aGF0IHNoYWxsIGJlIHdyaXR0ZW4NCj4gQEAgLTI3MCw2
ICsyODEsOSBAQCBleHRlcm4gbG9uZyBub3RyYWNlIHByb2JlX2tlcm5lbF93cml0ZSh2b2lkICpk
c3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IHNpemUpOw0KPiAgIGV4dGVybiBsb25nIG5vdHJh
Y2UgX19wcm9iZV9rZXJuZWxfd3JpdGUodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVf
dCBzaXplKTsNCj4gICANCj4gICBleHRlcm4gbG9uZyBzdHJuY3B5X2Zyb21fdW5zYWZlKGNoYXIg
KmRzdCwgY29uc3Qgdm9pZCAqdW5zYWZlX2FkZHIsIGxvbmcgY291bnQpOw0KPiArZXh0ZXJuIGxv
bmcgc3RybmNweV9mcm9tX3Vuc2FmZV91c2VyKGNoYXIgKmRzdCwgY29uc3Qgdm9pZCBfX3VzZXIg
KnVuc2FmZV9hZGRyLA0KPiArCQkJCSAgICAgbG9uZyBjb3VudCk7DQo+ICtleHRlcm4gbG9uZyBz
dHJubGVuX3Vuc2FmZV91c2VyKGNvbnN0IHZvaWQgX191c2VyICp1bnNhZmVfYWRkciwgbG9uZyBj
b3VudCk7DQo+ICAgDQo+ICAgLyoqDQo+ICAgICogcHJvYmVfa2VybmVsX2FkZHJlc3MoKTogc2Fm
ZWx5IGF0dGVtcHQgdG8gcmVhZCBmcm9tIGEgbG9jYXRpb24NCj4gZGlmZiAtLWdpdCBhL21tL21h
Y2Nlc3MuYyBiL21tL21hY2Nlc3MuYw0KPiBpbmRleCBlYzAwYmU1MWEyNGYuLmQxYjJlYzc4ZDll
ZiAxMDA2NDQNCj4gLS0tIGEvbW0vbWFjY2Vzcy5jDQo+ICsrKyBiL21tL21hY2Nlc3MuYw0KPiBA
QCAtNSw4ICs1LDIwIEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+ICAgI2luY2x1ZGUg
PGxpbnV4L3VhY2Nlc3MuaD4NCj4gICANCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgbG9uZw0K
PiArcHJvYmVfcmVhZF9jb21tb24odm9pZCAqZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCBz
aXplX3Qgc2l6ZSkNCj4gK3sNCj4gKwlsb25nIHJldDsNCj4gKw0KPiArCXBhZ2VmYXVsdF9kaXNh
YmxlKCk7DQo+ICsJcmV0ID0gX19jb3B5X2Zyb21fdXNlcl9pbmF0b21pYyhkc3QsIHNyYywgc2l6
ZSk7DQo+ICsJcGFnZWZhdWx0X2VuYWJsZSgpOw0KPiArDQo+ICsJcmV0dXJuIHJldCA/IC1FRkFV
TFQgOiAwOw0KPiArfQ0KPiArDQo+ICAgLyoqDQo+IC0gKiBwcm9iZV9rZXJuZWxfcmVhZCgpOiBz
YWZlbHkgYXR0ZW1wdCB0byByZWFkIGZyb20gYSBsb2NhdGlvbg0KPiArICogcHJvYmVfa2VybmVs
X3JlYWQoKTogc2FmZWx5IGF0dGVtcHQgdG8gcmVhZCBmcm9tIGEga2VybmVsLXNwYWNlIGxvY2F0
aW9uDQo+ICAgICogQGRzdDogcG9pbnRlciB0byB0aGUgYnVmZmVyIHRoYXQgc2hhbGwgdGFrZSB0
aGUgZGF0YQ0KPiAgICAqIEBzcmM6IGFkZHJlc3MgdG8gcmVhZCBmcm9tDQo+ICAgICogQHNpemU6
IHNpemUgb2YgdGhlIGRhdGEgY2h1bmsNCj4gQEAgLTI5LDE3ICs0MSw0NSBAQCBsb25nIF9fcHJv
YmVfa2VybmVsX3JlYWQodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBzaXplKQ0K
PiAgIAltbV9zZWdtZW50X3Qgb2xkX2ZzID0gZ2V0X2ZzKCk7DQo+ICAgDQo+ICAgCXNldF9mcyhL
RVJORUxfRFMpOw0KPiAtCXBhZ2VmYXVsdF9kaXNhYmxlKCk7DQo+IC0JcmV0ID0gX19jb3B5X2Zy
b21fdXNlcl9pbmF0b21pYyhkc3QsDQo+IC0JCQkoX19mb3JjZSBjb25zdCB2b2lkIF9fdXNlciAq
KXNyYywgc2l6ZSk7DQo+IC0JcGFnZWZhdWx0X2VuYWJsZSgpOw0KPiArCXJldCA9IHByb2JlX3Jl
YWRfY29tbW9uKGRzdCwgKF9fZm9yY2UgY29uc3Qgdm9pZCBfX3VzZXIgKilzcmMsIHNpemUpOw0K
PiAgIAlzZXRfZnMob2xkX2ZzKTsNCj4gICANCj4gLQlyZXR1cm4gcmV0ID8gLUVGQVVMVCA6IDA7
DQo+ICsJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwocHJvYmVfa2Vy
bmVsX3JlYWQpOw0KPiAgIA0KPiAgIC8qKg0KPiArICogcHJvYmVfdXNlcl9yZWFkKCk6IHNhZmVs
eSBhdHRlbXB0IHRvIHJlYWQgZnJvbSBhIHVzZXItc3BhY2UgbG9jYXRpb24NCj4gKyAqIEBkc3Q6
IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciB0aGF0IHNoYWxsIHRha2UgdGhlIGRhdGENCj4gKyAqIEBz
cmM6IGFkZHJlc3MgdG8gcmVhZCBmcm9tLiBUaGlzIG11c3QgYmUgYSB1c2VyIGFkZHJlc3MuDQo+
ICsgKiBAc2l6ZTogc2l6ZSBvZiB0aGUgZGF0YSBjaHVuaw0KPiArICoNCj4gKyAqIFNhZmVseSBy
ZWFkIGZyb20gdXNlciBhZGRyZXNzIEBzcmMgdG8gdGhlIGJ1ZmZlciBhdCBAZHN0LiBJZiBhIGtl
cm5lbCBmYXVsdA0KPiArICogaGFwcGVucywgaGFuZGxlIHRoYXQgYW5kIHJldHVybiAtRUZBVUxU
Lg0KPiArICovDQo+ICsNCj4gK2xvbmcgX193ZWFrIHByb2JlX3VzZXJfcmVhZCh2b2lkICpkc3Qs
IGNvbnN0IHZvaWQgX191c2VyICpzcmMsIHNpemVfdCBzaXplKQ0KPiArICAgIF9fYXR0cmlidXRl
X18oKGFsaWFzKCJfX3Byb2JlX3VzZXJfcmVhZCIpKSk7DQo+ICsNCj4gK2xvbmcgX19wcm9iZV91
c2VyX3JlYWQodm9pZCAqZHN0LCBjb25zdCB2b2lkIF9fdXNlciAqc3JjLCBzaXplX3Qgc2l6ZSkN
Cj4gK3sNCj4gKwlsb25nIHJldCA9IC1FRkFVTFQ7DQo+ICsJbW1fc2VnbWVudF90IG9sZF9mcyA9
IGdldF9mcygpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBTaW5jZSB0aGlzIGNhbiBiZSBjYWxsZWQg
aW4gSVJRIGNvbnRleHQsIHdlIGNhcmVmdWxseSBzZXQgdGhlDQo+ICsJICogVVNFUl9EUyBhbmQg
dXNlIHVzZXJfYWNjZXNzX29rKCkgd2hpY2ggY2hlY2tzIHNlZ21lbnQgc2V0dGluZw0KPiArCSAq
IGluc3RlYWQgb2YgdGFzayBjb250ZXh0Lg0KPiArCSAqLw0KPiArCXNldF9mcyhVU0VSX0RTKTsN
Cj4gKwlpZiAodXNlcl9hY2Nlc3Nfb2soc3JjLCBzaXplKSkNCj4gKwkJcmV0ID0gcHJvYmVfcmVh
ZF9jb21tb24oZHN0LCBzcmMsIHNpemUpOw0KPiArCXNldF9mcyhvbGRfZnMpOw0KPiArCXJldHVy
biByZXQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChwcm9iZV91c2VyX3JlYWQpOw0KPiAr
DQo+ICsvKioNCj4gICAgKiBwcm9iZV9rZXJuZWxfd3JpdGUoKTogc2FmZWx5IGF0dGVtcHQgdG8g
d3JpdGUgdG8gYSBsb2NhdGlvbg0KPiAgICAqIEBkc3Q6IGFkZHJlc3MgdG8gd3JpdGUgdG8NCj4g
ICAgKiBAc3JjOiBwb2ludGVyIHRvIHRoZSBkYXRhIHRoYXQgc2hhbGwgYmUgd3JpdHRlbg0KPiBA
QCAtNjYsNiArMTA2LDcgQEAgbG9uZyBfX3Byb2JlX2tlcm5lbF93cml0ZSh2b2lkICpkc3QsIGNv
bnN0IHZvaWQgKnNyYywgc2l6ZV90IHNpemUpDQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0xfR1BM
KHByb2JlX2tlcm5lbF93cml0ZSk7DQo+ICAgDQo+ICsNCj4gICAvKioNCj4gICAgKiBzdHJuY3B5
X2Zyb21fdW5zYWZlOiAtIENvcHkgYSBOVUwgdGVybWluYXRlZCBzdHJpbmcgZnJvbSB1bnNhZmUg
YWRkcmVzcy4NCj4gICAgKiBAZHN0OiAgIERlc3RpbmF0aW9uIGFkZHJlc3MsIGluIGtlcm5lbCBz
cGFjZS4gIFRoaXMgYnVmZmVyIG11c3QgYmUgYXQNCj4gQEAgLTEwNSwzICsxNDYsNzIgQEAgbG9u
ZyBzdHJuY3B5X2Zyb21fdW5zYWZlKGNoYXIgKmRzdCwgY29uc3Qgdm9pZCAqdW5zYWZlX2FkZHIs
IGxvbmcgY291bnQpDQo+ICAgDQo+ICAgCXJldHVybiByZXQgPyAtRUZBVUxUIDogc3JjIC0gdW5z
YWZlX2FkZHI7DQo+ICAgfQ0KPiArDQo+ICsvKioNCj4gKyAqIHN0cm5jcHlfZnJvbV91bnNhZmVf
dXNlcjogLSBDb3B5IGEgTlVMIHRlcm1pbmF0ZWQgc3RyaW5nIGZyb20gdW5zYWZlIHVzZXINCj4g
KyAqCQkJCWFkZHJlc3MuDQo+ICsgKiBAZHN0OiAgIERlc3RpbmF0aW9uIGFkZHJlc3MsIGluIGtl
cm5lbCBzcGFjZS4gIFRoaXMgYnVmZmVyIG11c3QgYmUgYXQNCj4gKyAqICAgICAgICAgbGVhc3Qg
QGNvdW50IGJ5dGVzIGxvbmcuDQo+ICsgKiBAdW5zYWZlX2FkZHI6IFVuc2FmZSB1c2VyIGFkZHJl
c3MuDQo+ICsgKiBAY291bnQ6IE1heGltdW0gbnVtYmVyIG9mIGJ5dGVzIHRvIGNvcHksIGluY2x1
ZGluZyB0aGUgdHJhaWxpbmcgTlVMLg0KPiArICoNCj4gKyAqIENvcGllcyBhIE5VTC10ZXJtaW5h
dGVkIHN0cmluZyBmcm9tIHVuc2FmZSB1c2VyIGFkZHJlc3MgdG8ga2VybmVsIGJ1ZmZlci4NCj4g
KyAqDQo+ICsgKiBPbiBzdWNjZXNzLCByZXR1cm5zIHRoZSBsZW5ndGggb2YgdGhlIHN0cmluZyBJ
TkNMVURJTkcgdGhlIHRyYWlsaW5nIE5VTC4NCj4gKyAqDQo+ICsgKiBJZiBhY2Nlc3MgZmFpbHMs
IHJldHVybnMgLUVGQVVMVCAoc29tZSBkYXRhIG1heSBoYXZlIGJlZW4gY29waWVkDQo+ICsgKiBh
bmQgdGhlIHRyYWlsaW5nIE5VTCBhZGRlZCkuDQo+ICsgKg0KPiArICogSWYgQGNvdW50IGlzIHNt
YWxsZXIgdGhhbiB0aGUgbGVuZ3RoIG9mIHRoZSBzdHJpbmcsIGNvcGllcyBAY291bnQtMSBieXRl
cywNCj4gKyAqIHNldHMgdGhlIGxhc3QgYnl0ZSBvZiBAZHN0IGJ1ZmZlciB0byBOVUwgYW5kIHJl
dHVybnMgQGNvdW50Lg0KPiArICovDQo+ICtsb25nIHN0cm5jcHlfZnJvbV91bnNhZmVfdXNlcihj
aGFyICpkc3QsIGNvbnN0IHZvaWQgX191c2VyICp1bnNhZmVfYWRkciwNCj4gKwkJCSAgICAgIGxv
bmcgY291bnQpDQo+ICt7DQo+ICsJbW1fc2VnbWVudF90IG9sZF9mcyA9IGdldF9mcygpOw0KPiAr
CWxvbmcgcmV0Ow0KPiArDQo+ICsJaWYgKHVubGlrZWx5KGNvdW50IDw9IDApKQ0KPiArCQlyZXR1
cm4gMDsNCj4gKw0KPiArCXNldF9mcyhVU0VSX0RTKTsNCj4gKwlwYWdlZmF1bHRfZGlzYWJsZSgp
Ow0KPiArCXJldCA9IHN0cm5jcHlfZnJvbV91c2VyKGRzdCwgdW5zYWZlX2FkZHIsIGNvdW50KTsN
Cj4gKwlwYWdlZmF1bHRfZW5hYmxlKCk7DQo+ICsJc2V0X2ZzKG9sZF9mcyk7DQo+ICsJaWYgKHJl
dCA+PSBjb3VudCkgew0KPiArCQlyZXQgPSBjb3VudDsNCj4gKwkJZHN0W3JldCAtIDFdID0gJ1ww
JzsNCj4gKwl9IGVsc2UgaWYgKHJldCA+IDApDQo+ICsJCXJldCsrOw0KPiArCXJldHVybiByZXQ7
DQo+ICt9DQo+ICsNCj4gKy8qKg0KPiArICogc3Rybmxlbl91bnNhZmVfdXNlcjogLSBHZXQgdGhl
IHNpemUgb2YgYSB1c2VyIHN0cmluZyBJTkNMVURJTkcgZmluYWwgTlVMLg0KPiArICogQHVuc2Fm
ZV9hZGRyOiBUaGUgc3RyaW5nIHRvIG1lYXN1cmUuDQo+ICsgKiBAY291bnQ6IE1heGltdW0gY291
bnQgKGluY2x1ZGluZyBOVUwgY2hhcmFjdGVyKQ0KPiArICoNCj4gKyAqIEdldCB0aGUgc2l6ZSBv
ZiBhIE5VTC10ZXJtaW5hdGVkIHN0cmluZyBpbiB1c2VyIHNwYWNlIHdpdGhvdXQgcGFnZWZhdWx0
Lg0KPiArICoNCj4gKyAqIFJldHVybnMgdGhlIHNpemUgb2YgdGhlIHN0cmluZyBJTkNMVURJTkcg
dGhlIHRlcm1pbmF0aW5nIE5VTC4NCj4gKyAqDQo+ICsgKiBJZiB0aGUgc3RyaW5nIGlzIHRvbyBs
b25nLCByZXR1cm5zIGEgbnVtYmVyIGxhcmdlciB0aGFuIEBjb3VudC4gVXNlcg0KPiArICogaGFz
IHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgYWdhaW5zdCAiPiBjb3VudCIuDQo+ICsgKiBPbiBl
eGNlcHRpb24gKG9yIGludmFsaWQgY291bnQpLCByZXR1cm5zIDAuDQo+ICsgKg0KPiArICogVW5s
aWtlIHN0cm5sZW5fdXNlciwgdGhpcyBjYW4gYmUgdXNlZCBmcm9tIElSUSBoYW5kbGVyIGV0Yy4g
YmVjYXVzZQ0KPiArICogaXQgZGlzYWJsZXMgcGFnZWZhdWx0cy4NCj4gKyAqLw0KPiArbG9uZyBz
dHJubGVuX3Vuc2FmZV91c2VyKGNvbnN0IHZvaWQgX191c2VyICp1bnNhZmVfYWRkciwgbG9uZyBj
b3VudCkNCj4gK3sNCj4gKwltbV9zZWdtZW50X3Qgb2xkX2ZzID0gZ2V0X2ZzKCk7DQo+ICsJaW50
IHJldDsNCj4gKw0KPiArCXNldF9mcyhVU0VSX0RTKTsNCj4gKwlwYWdlZmF1bHRfZGlzYWJsZSgp
Ow0KPiArCXJldCA9IHN0cm5sZW5fdXNlcih1bnNhZmVfYWRkciwgY291bnQpOw0KPiArCXBhZ2Vm
YXVsdF9lbmFibGUoKTsNCj4gKwlzZXRfZnMob2xkX2ZzKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiAr
fQ0KPiANCg==
