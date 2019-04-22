Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB0C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E542073F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C8zB7L8C";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GoaBonFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfDVXRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:17:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbfDVXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:17:36 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MNFFl8024099;
        Mon, 22 Apr 2019 16:16:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FThCzi2GFXQN6PDJg77R7Gdc6YoJPP4c+KBkAFta6hI=;
 b=C8zB7L8Cx43mJKddhMY4db998YdwNZ9ZB15Bz0+QQgqMYFZD4zCWQrJ9i03A6AZr3t4q
 LiYorsr5TJiG6+B7uxC/1tdNPyOhguve9efDlZHIyKF7m5jiQG1AhwOSQVeqtMrU2jmI
 82lz/AFkxxcuh4rOi+v5NYzjZPiNMlojuaA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1pysg1q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 16:16:45 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 16:16:44 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 16:16:44 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 16:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FThCzi2GFXQN6PDJg77R7Gdc6YoJPP4c+KBkAFta6hI=;
 b=GoaBonFCvONaIiMQppGOSxI6bgTY7jd9i6zaXD3UUEADgxA71vALSH0u2za05Y+dq/huu9FFXEI3YcsnSrIL+Hmvm+Amh9SXGwtjeer1rp+I7nsLEvvSrR/YOGsUhXdZPBBhAOEyXwzUk2lUGNzvzBURwlZbieanqzj/3P/IRJQ=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3175.namprd15.prod.outlook.com (20.179.56.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Mon, 22 Apr 2019 23:16:42 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 23:16:42 +0000
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
Thread-Index: AQHU9vOB6YI4LMclcUeKr8qdEaM41KZICpuAgACJGACAAB/UgIAAHTkAgAAEOYA=
Date:   Mon, 22 Apr 2019 23:16:42 +0000
Message-ID: <aa1d0ac8-dda0-67db-8aaa-3b1cec531622@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
 <20190419210409.5021-2-mmullins@fb.com>
 <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
 <de2eb4c12121c96b5b9912196aedb081027b3ac4.camel@fb.com>
 <ca1d46d5-ea87-2859-c5a7-ce7220d396db@fb.com>
 <2d77d03b79263872397e6d7ee9eeaa0995f8be04.camel@fb.com>
In-Reply-To: <2d77d03b79263872397e6d7ee9eeaa0995f8be04.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:300:12b::24) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:417e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c55e0ca-3410-444a-7c1e-08d6c7789471
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3175;
x-ms-traffictypediagnostic: BYAPR15MB3175:
x-microsoft-antispam-prvs: <BYAPR15MB31751E5922F8FFFC93991631D3220@BYAPR15MB3175.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(346002)(366004)(189003)(199004)(76176011)(102836004)(4326008)(6512007)(31686004)(478600001)(110136005)(2906002)(14454004)(68736007)(6246003)(73956011)(64756008)(36756003)(25786009)(66476007)(66556008)(52116002)(66946007)(66446008)(386003)(5024004)(53936002)(53546011)(256004)(6506007)(14444005)(71190400001)(71200400001)(6116002)(99286004)(316002)(46003)(186003)(8676002)(81156014)(81166006)(2201001)(6436002)(31696002)(486006)(11346002)(93886005)(229853002)(7736002)(8936002)(97736004)(54906003)(2501003)(476003)(2616005)(86362001)(305945005)(446003)(6486002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3175;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMnb/IAMM8kRqpajS8unQk/r6MmZ/Ralvay8WmoSwfGl9b3TI1CzIffjVMqzOjgvM/1fXyN8QzgUv2lHS5krqtFM+jz5UYPFcaR0I/t1vfV4+OrcJaZdkEHSjr9GCCpBuYZfHb4Vhtzn6HK/cpAzHhobYJzgcnp+CF6q6OlMmdcAADBI7jPrvYwIAyXPzyv4hGgMJtcuEhgeiOi+rbFJvusf1akTHZ10q+cN4zmpVaZt/ludm0yZVCP+27raF/PNRPh1EY685ELQDS67hryjXmb+zX7D/ayiiJwfUWJKG7x1oLccHctxZFaGpN52pM2UWjjO5mfh6bu9lWSfEDUrDLZePrcnFN3d+dUngHhIBVI+e3fwlEEMPjl5/BtRlK+Ponv77VU7gfpndKhh+vogfGDlJdrKP5Wyt7BY0ALJ7Aw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD36A6A672EA704EB42A5072AF4DAC68@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c55e0ca-3410-444a-7c1e-08d6c7789471
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 23:16:42.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjIvMTkgNDowMSBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPiBPbiBNb24sIDIw
MTktMDQtMjIgYXQgMjE6MTcgKzAwMDAsIFlvbmdob25nIFNvbmcgd3JvdGU6DQo+Pg0KPj4gT24g
NC8yMi8xOSAxMjoyMyBQTSwgTWF0dCBNdWxsaW5zIHdyb3RlOg0KPj4+IE9uIE1vbiwgMjAxOS0w
NC0yMiBhdCAxODoxMiArMDAwMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+Pj4NCj4+Pj4gT24g
NC8xOS8xOSAyOjA0IFBNLCBNYXR0IE11bGxpbnMgd3JvdGU6DQo+Pj4+PiBUaGlzIGlzIGFuIG9w
dC1pbiBpbnRlcmZhY2UgdGhhdCBhbGxvd3MgYSB0cmFjZXBvaW50IHRvIHByb3ZpZGUgYSBzYWZl
DQo+Pj4+PiBidWZmZXIgdGhhdCBjYW4gYmUgd3JpdHRlbiBmcm9tIGEgQlBGX1BST0dfVFlQRV9S
QVdfVFJBQ0VQT0lOVCBwcm9ncmFtLg0KPj4+Pj4gVGhlIHNpemUgb2YgdGhlIGJ1ZmZlciBtdXN0
IGJlIGEgY29tcGlsZS10aW1lIGNvbnN0YW50LCBhbmQgaXMgY2hlY2tlZA0KPj4+Pj4gYmVmb3Jl
IGFsbG93aW5nIGEgQlBGIHByb2dyYW0gdG8gYXR0YWNoIHRvIGEgdHJhY2Vwb2ludCB0aGF0IHVz
ZXMgdGhpcw0KPj4+Pj4gZmVhdHVyZS4NCj4+Pj4+DQo+Pj4+PiBUaGUgcG9pbnRlciB0byB0aGlz
IGJ1ZmZlciB3aWxsIGJlIHRoZSBmaXJzdCBhcmd1bWVudCBvZiB0cmFjZXBvaW50cw0KPj4+Pj4g
dGhhdCBvcHQgaW47IHRoZSBidWZmZXIgaXMgcmVhZGFibGUgYnkgYm90aCBCUEZfUFJPR19UWVBF
X1JBV19UUkFDRVBPSU5UDQo+Pj4+PiBhbmQgQlBGX1BST0dfVFlQRV9SQVdfVFJBQ0VQT0lOVF9X
UklUQUJMRSBwcm9ncmFtcyB0aGF0IGF0dGFjaCB0byBzdWNoIGENCj4+Pj4+IHRyYWNlcG9pbnQs
IGJ1dCB0aGUgYnVmZmVyIHRvIHdoaWNoIGl0IHBvaW50cyBtYXkgb25seSBiZSB3cml0dGVuIGJ5
IHRoZQ0KPj4+Pj4gbGF0dGVyLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hdHQgTXVs
bGlucyA8bW11bGxpbnNAZmIuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgaW5jbHVkZS9saW51
eC9icGYuaCAgICAgICAgICAgICB8ICAyICsrDQo+Pj4+PiAgICAgaW5jbHVkZS9saW51eC9icGZf
dHlwZXMuaCAgICAgICB8ICAxICsNCj4+Pj4+ICAgICBpbmNsdWRlL2xpbnV4L3RyYWNlcG9pbnQt
ZGVmcy5oIHwgIDEgKw0KPj4+Pj4gICAgIGluY2x1ZGUvdHJhY2UvYnBmX3Byb2JlLmggICAgICAg
fCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+Pj4+ICAgICBpbmNsdWRlL3VhcGkv
bGludXgvYnBmLmggICAgICAgIHwgIDEgKw0KPj4+Pj4gICAgIGtlcm5lbC9icGYvc3lzY2FsbC5j
ICAgICAgICAgICAgfCAgOCArKysrKystLQ0KPj4+Pj4gICAgIGtlcm5lbC9icGYvdmVyaWZpZXIu
YyAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAg
ICAga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysr
KysrKw0KPj4+Pj4gICAgIDggZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBi
L2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4+IGluZGV4IGEyMTMyZTA5ZGMxYy4uZDNjNzFmZDY3
NDc2IDEwMDY0NA0KPj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9icGYuaA0KPj4+Pj4gKysrIGIv
aW5jbHVkZS9saW51eC9icGYuaA0KPj4+Pj4gQEAgLTI2Myw2ICsyNjMsNyBAQCBlbnVtIGJwZl9y
ZWdfdHlwZSB7DQo+Pj4+PiAgICAgCVBUUl9UT19TT0NLX0NPTU1PTl9PUl9OVUxMLCAvKiByZWcg
cG9pbnRzIHRvIHNvY2tfY29tbW9uIG9yIE5VTEwgKi8NCj4+Pj4+ICAgICAJUFRSX1RPX1RDUF9T
T0NLLAkgLyogcmVnIHBvaW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgKi8NCj4+Pj4+ICAgICAJUFRS
X1RPX1RDUF9TT0NLX09SX05VTEwsIC8qIHJlZyBwb2ludHMgdG8gc3RydWN0IHRjcF9zb2NrIG9y
IE5VTEwgKi8NCj4+Pj4+ICsJUFRSX1RPX1RQX0JVRkZFUiwJIC8qIHJlZyBwb2ludHMgdG8gYSB3
cml0YWJsZSByYXcgdHAncyBidWZmZXIgKi8NCj4+Pj4+ICAgICB9Ow0KPj4+Pj4gICAgIA0KPj4+
Pg0KPj4+PiBbLi4uXQ0KPj4+Pj4gICAgIC8qIHRydW5jYXRlIHJlZ2lzdGVyIHRvIHNtYWxsZXIg
c2l6ZSAoaW4gYnl0ZXMpDQo+Pj4+PiAgICAgICogbXVzdCBiZSBjYWxsZWQgd2l0aCBzaXplIDwg
QlBGX1JFR19TSVpFDQo+Pj4+PiAgICAgICovDQo+Pj4+PiBAQCAtMjEwMCw2ICsyMTI3LDEwIEBA
IHN0YXRpYyBpbnQgY2hlY2tfbWVtX2FjY2VzcyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52
LCBpbnQgaW5zbl9pZHgsIHUzMiByZWduDQo+Pj4+PiAgICAgCQllcnIgPSBjaGVja19zb2NrX2Fj
Y2VzcyhlbnYsIGluc25faWR4LCByZWdubywgb2ZmLCBzaXplLCB0KTsNCj4+Pj4+ICAgICAJCWlm
ICghZXJyICYmIHZhbHVlX3JlZ25vID49IDApDQo+Pj4+PiAgICAgCQkJbWFya19yZWdfdW5rbm93
bihlbnYsIHJlZ3MsIHZhbHVlX3JlZ25vKTsNCj4+Pj4+ICsJfSBlbHNlIGlmIChyZWctPnR5cGUg
PT0gUFRSX1RPX1RQX0JVRkZFUikgew0KPj4+Pj4gKwkJZXJyID0gY2hlY2tfdHBfYnVmZmVyX2Fj
Y2VzcyhlbnYsIHJlZywgcmVnbm8sIG9mZiwgc2l6ZSk7DQo+Pj4+PiArCQlpZiAoIWVyciAmJiB0
ID09IEJQRl9SRUFEICYmIHZhbHVlX3JlZ25vID49IDApDQo+Pj4+PiArCQkJbWFya19yZWdfdW5r
bm93bihlbnYsIHJlZ3MsIHZhbHVlX3JlZ25vKTsNCj4+Pj4+ICAgICAJfSBlbHNlIHsNCj4+Pj4+
ICAgICAJCXZlcmJvc2UoZW52LCAiUiVkIGludmFsaWQgbWVtIGFjY2VzcyAnJXMnXG4iLCByZWdu
bywNCj4+Pj4+ICAgICAJCQlyZWdfdHlwZV9zdHJbcmVnLT50eXBlXSk7DQo+Pj4+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL3RyYWNlL2JwZl90cmFjZS5jIGIva2VybmVsL3RyYWNlL2JwZl90cmFjZS5j
DQo+Pj4+PiBpbmRleCBkNjRjMDBhZmNlYjUuLmEyZGQ3OWRjNjg3MSAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KPj4+Pj4gKysrIGIva2VybmVsL3RyYWNlL2Jw
Zl90cmFjZS5jDQo+Pj4+PiBAQCAtOTA5LDYgKzkwOSwyNCBAQCBjb25zdCBzdHJ1Y3QgYnBmX3Zl
cmlmaWVyX29wcyByYXdfdHJhY2Vwb2ludF92ZXJpZmllcl9vcHMgPSB7DQo+Pj4+PiAgICAgY29u
c3Qgc3RydWN0IGJwZl9wcm9nX29wcyByYXdfdHJhY2Vwb2ludF9wcm9nX29wcyA9IHsNCj4+Pj4+
ICAgICB9Ow0KPj4+Pj4gICAgIA0KPj4+Pj4gK3N0YXRpYyBib29sIHJhd190cF93cml0YWJsZV9w
cm9nX2lzX3ZhbGlkX2FjY2VzcyhpbnQgb2ZmLCBpbnQgc2l6ZSwNCj4+Pj4+ICsJCQkJCQkgZW51
bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwNCj4+Pj4+ICsJCQkJCQkgY29uc3Qgc3RydWN0IGJwZl9w
cm9nICpwcm9nLA0KPj4+Pj4gKwkJCQkJCSBzdHJ1Y3QgYnBmX2luc25fYWNjZXNzX2F1eCAqaW5m
bykNCj4+Pj4+ICt7DQo+Pj4+PiArCWlmIChvZmYgPT0gMCAmJiBzaXplID09IHNpemVvZih1NjQp
KQ0KPj4+Pj4gKwkJaW5mby0+cmVnX3R5cGUgPSBQVFJfVE9fVFBfQlVGRkVSOw0KPj4+Pg0KPj4+
PiBvbiAzMmJpdCBzeXN0ZW0sIHRoZSBmaXJzdCBhcmd1bWVudCBwb2ludGVyIHNpemUgY291bGQg
YmUgc2l6ZW9mKHUzMik/DQo+Pj4NCj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgcG9pbnRlcnMg
YXJlIGFsd2F5cyA2NCBiaXRzIHdpZGUgZnJvbSB0aGUNCj4+PiBwZXJzcGVjdGl2ZSBvZiB0aGUg
ZUJQRiBpbnN0cnVjdGlvbiBzZXQuICBJIHRoaW5rIHRoZSBwcm9wZXIgZml4dXAgaXMNCj4+PiBp
biBpbmNsdWRlL3RyYWNlL2V2ZW50cy9uYmQuaCAuLi4gSSBzaG91bGQgdXNlIGEgdTY0IGluc3Rl
YWQgb2YgYQ0KPj4+IHBvaW50ZXIgdHlwZS4NCj4+DQo+PiB1NjQgaXMgb2theS4gWW91IG1heSB3
YW50IHRvIGRvdWJsZSBjaGVjayB0cmFjZXBvaW50IGRlZmluaXRpb24gdG8NCj4+IGVuc3VyZSB0
aGUgYXNzaWduIHRvIHRoZSBmaXJzdCBhcmd1bWVudCBjb252ZXJ0aW5nIHRvIHU2NCBhcyB3ZWxs
IHRvDQo+PiBhdm9pZCBwb3RlbnRpYWwgZ2FyYmFnZS4gSXQgd291bGQgYmUgZ29vZCBpZiB0aGlz
IGlzIGVuZm9yY2VkIGR1cmluZw0KPj4gY29tcGlsYXRpb24gdGltZS4NCj4gDQo+IE5vdyB0aGF0
IEkndmUgbG9va2VkIGludG8gdGhpcyBmdXJ0aGVyLCB0aGlzIGlzIGFscmVhZHkgaGFuZGxlZCBp
bg0KPiBpbmNsdWRlL3RyYWNlL2JwZl9wcm9iZS5oOg0KPiANCj4gI3VuZGVmIERFQ0xBUkVfRVZF
TlRfQ0xBU1MNCj4gI2RlZmluZSBERUNMQVJFX0VWRU5UX0NMQVNTKGNhbGwsIHByb3RvLCBhcmdz
LCB0c3RydWN0LCBhc3NpZ24sIHByaW50KQlcDQo+IHN0YXRpYyBub3RyYWNlIHZvaWQJCQkJCQkJ
XA0KPiBfX2JwZl90cmFjZV8jI2NhbGwodm9pZCAqX19kYXRhLCBwcm90bykJCQkJCVwNCj4gewkJ
CQkJCQkJCVwNCj4gCXN0cnVjdCBicGZfcHJvZyAqcHJvZyA9IF9fZGF0YTsJCQkJCVwNCj4gCUNP
TkNBVEVOQVRFKGJwZl90cmFjZV9ydW4sIENPVU5UX0FSR1MoYXJncykpKHByb2csIENBU1RfVE9f
VTY0KGFyZ3MpKTsJXA0KPiB9DQo+IA0KPiBUaGUgMzItYml0IHZhbHVlIG9mIHRoZSBzdHJ1Y3Qg
bmJkX3JlcXVlc3QgcG9pbnRlciB3aWxsIGJlIHplcm8tDQo+IGV4dGVuZGVkIHRvIDY0LWJpdHMg
YmVmb3JlIHRoZSBCUEYgcHJvZ3JhbSBzZWVzIGl0LCBzbyB0aGVyZSB3b24ndCBiZQ0KPiBhbnkg
Z2FyYmFnZSBpbiB0aGUgdXBwZXIgaGFsZiBvZiB0aGUgcmVnaXN0ZXIuICBJJ20gZ29pbmcgdG8g
bGVhdmUgdGhlDQo+IHRyYWNlXyogZnVuY3Rpb25zIHRha2luZyB0aGUgcG9pbnRlciBhcy1pcywg
c28gdGhhdCBJIGNhbiBrZWVwIHRoZQ0KPiBjb21waWxlLXRpbWUgY2hlY2tzIHRoYXQgd3JpdGFi
bGVfc2l6ZSA9PSBzaXplb2YoKmZpcnN0X2FyZ3VtZW50KS4NCj4gDQo+Pj4+IFNob3VsZCB0aGUg
Zmlyc3QgYXJndW1lbnQgZm9yIHJhd190cF93cml0YWJsZV9wcm9nIGJlIGFsd2F5cw0KPj4+PiBQ
VFJfVE9fVFBfQlVGRkVSPw0KPj4+DQo+Pj4gVGhhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGlzIHBh
dGNoIHNlcmllcywgeWVzLiAgTXkgaW5pdGlhbCBhdHRlbXB0IGF0DQo+Pj4gdGhpcyB0cmllZCB0
byBhZGQgaXQgdG8gdGhlIGVuZCBvZiB0aGUgY29udGV4dCBzdHJ1Y3R1cmUgaW5zdGVhZCwgYW5k
DQo+Pj4gdGhhdCBlbmRlZCB1cCBiZWluZyBxdWl0ZSBjb21wbGV4IHRvIHRyYWNrLg0KPj4NCj4+
IFNvIGBzaXplID09IHNpemVvZih1NjQpYCBjYW4gYmUgcmVtb3ZlZCwgb2ZmID09IDAganVzdCBp
bXBsaWVzDQo+PiByZWdfdHlwZSBQVFJfVE9fVFBfQlVGRkVSPw0KPiANCj4gSSBjYW4ndCBnZXQg
cmlkIG9mIHRoZSBzaXplIGNoZWNrLCBiZWNhdXNlIEkgY2FuIGVtaXQgYW4gb3Bjb2RlIGxpa2UN
Cj4gDQo+ICAgIDA6ICg3MSkgcjYgPSAqKHU4ICopKHIxICswKQ0KPiANCj4gYW5kIEkgZG9uJ3Qg
d2FudCB0byBhY2NpZGVudGFsbHkgbWFyayBhIHZhbHVlIGFzIFBUUl9UT19UUF9CVUZGRVINCj4g
dW5sZXNzIGl0IGlzIGEgd2hvbGUsIHZhbGlkIHBvaW50ZXIuDQoNCldlIGNvdWxkIHJlamVjdCBp
ZiBvZmYgPT0gMCAmJiBzaXplICE9IDggdG8gYWxsb3cgb25seSB3aG9sZSBwb2ludGVyIA0KYWNj
ZXNzLiBJIGNhbm5vdCB0aGluayB0aGF0IHVzZXIgd2lsbCB1c2UgcjYgaW4gYSBtZWFuaW5nZnVs
IGV4Y2VwdCB0aGUgDQpoYXNoLiBCdXQgaWYgeW91IGhhdmUgYSB2YWxpZCB1c2UgY2FzZSB0byBw
ZXJtaXQgc3VjaCBhY2Nlc3MsIEkNCmFtIG9rYXkgd2l0aCB0aGF0Lg0KDQo+IA0KPj4+Pj4gKwly
ZXR1cm4gcmF3X3RwX3Byb2dfaXNfdmFsaWRfYWNjZXNzKG9mZiwgc2l6ZSwgdHlwZSwgcHJvZywg
aW5mbyk7DQo+Pj4+PiArfQ0KPj4+Pj4gKw0KPj4+Pj4gK2NvbnN0IHN0cnVjdCBicGZfdmVyaWZp
ZXJfb3BzIHJhd190cmFjZXBvaW50X3dyaXRhYmxlX3ZlcmlmaWVyX29wcyA9IHsNCj4+Pj4+ICsJ
LmdldF9mdW5jX3Byb3RvICA9IHJhd190cF9wcm9nX2Z1bmNfcHJvdG8sDQo+Pj4+PiArCS5pc192
YWxpZF9hY2Nlc3MgPSByYXdfdHBfd3JpdGFibGVfcHJvZ19pc192YWxpZF9hY2Nlc3MsDQo+Pj4+
PiArfTsNCj4+Pj4+ICsNCj4+Pj4+ICtjb25zdCBzdHJ1Y3QgYnBmX3Byb2dfb3BzIHJhd190cmFj
ZXBvaW50X3dyaXRhYmxlX3Byb2dfb3BzID0gew0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiAg
ICAgc3RhdGljIGJvb2wgcGVfcHJvZ19pc192YWxpZF9hY2Nlc3MoaW50IG9mZiwgaW50IHNpemUs
IGVudW0gYnBmX2FjY2Vzc190eXBlIHR5cGUsDQo+Pj4+PiAgICAgCQkJCSAgICBjb25zdCBzdHJ1
Y3QgYnBmX3Byb2cgKnByb2csDQo+Pj4+PiAgICAgCQkJCSAgICBzdHJ1Y3QgYnBmX2luc25fYWNj
ZXNzX2F1eCAqaW5mbykNCj4+Pj4+IEBAIC0xMTk4LDYgKzEyMTYsOSBAQCBzdGF0aWMgaW50IF9f
YnBmX3Byb2JlX3JlZ2lzdGVyKHN0cnVjdCBicGZfcmF3X2V2ZW50X21hcCAqYnRwLCBzdHJ1Y3Qg
YnBmX3Byb2cgKg0KPj4+Pj4gICAgIAlpZiAocHJvZy0+YXV4LT5tYXhfY3R4X29mZnNldCA+IGJ0
cC0+bnVtX2FyZ3MgKiBzaXplb2YodTY0KSkNCj4+Pj4+ICAgICAJCXJldHVybiAtRUlOVkFMOw0K
Pj4+Pj4gICAgIA0KPj4+Pj4gKwlpZiAocHJvZy0+YXV4LT5tYXhfdHBfYWNjZXNzID4gYnRwLT53
cml0YWJsZV9zaXplKQ0KPj4+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4+PiArDQo+Pj4+PiAg
ICAgCXJldHVybiB0cmFjZXBvaW50X3Byb2JlX3JlZ2lzdGVyKHRwLCAodm9pZCAqKWJ0cC0+YnBm
X2Z1bmMsIHByb2cpOw0KPj4+Pj4gICAgIH0NCj4+Pj4+ICAgICANCj4+Pj4+DQo=
