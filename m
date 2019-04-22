Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A920896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MvLscmty";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TmVc/IQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfDVTYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:24:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfDVTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:24:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MJN920032268;
        Mon, 22 Apr 2019 12:23:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5csmhE2vyDgTaTZn+yetAKZxkBCDQaNrSV514J+Miqc=;
 b=MvLscmtymjBpmYQhamR0HhBvxXWfn0NTlfHFjLEOXdH8Ax2+GiCj0/8LeK02kR0u50sm
 h4OZYUS9BbVfCMR/0WFuVOsbUhYmzSiH7xbhasrF0mB+3f6kOl4iT5zY3C9xorcNi19Q
 llxHsJ/kI8KjdedckFqVUNaSKRg9EUM78aY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s1fx69568-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 12:23:10 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 12:23:04 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 12:23:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5csmhE2vyDgTaTZn+yetAKZxkBCDQaNrSV514J+Miqc=;
 b=TmVc/IQAQ2S+dkW/9c4me/ZPwF67wfxxnLfV4amPNSNfc8gLF90UY37YtmTg680ZkQPhrgJlkhVPWRwsn1oIlymgKocluAcdaKCVatqG91Ndm33oFdDle4hvgRS55m/GzgUxaHfIrkg4TMnjz179veW/gMRs6P+OuGnyqucMY7s=
Received: from MWHPR15MB1262.namprd15.prod.outlook.com (10.175.3.12) by
 MWHPR15MB1118.namprd15.prod.outlook.com (10.175.2.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 19:23:02 +0000
Received: from MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::99cf:e855:88ea:3f7c]) by MWHPR15MB1262.namprd15.prod.outlook.com
 ([fe80::99cf:e855:88ea:3f7c%12]) with mapi id 15.20.1813.017; Mon, 22 Apr
 2019 19:23:02 +0000
From:   Matt Mullins <mmullins@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Andrew Hall <hall@fb.com>,
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
Thread-Index: AQHU9vOB79lL7UaxSkud4C7lvhwQXqZIf/cAgAATu4A=
Date:   Mon, 22 Apr 2019 19:23:02 +0000
Message-ID: <de2eb4c12121c96b5b9912196aedb081027b3ac4.camel@fb.com>
References: <20190419210409.5021-1-mmullins@fb.com>
         <20190419210409.5021-2-mmullins@fb.com>
         <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
In-Reply-To: <6fbd1336-d2a0-3ea8-6127-ffb12ddde365@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [2620:10d:c090:200::3:ede9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8c2f000-7e4a-40d1-87f2-08d6c757f05d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1118;
x-ms-traffictypediagnostic: MWHPR15MB1118:
x-microsoft-antispam-prvs: <MWHPR15MB11189BE1856D6F2EDE5C3AE2B0220@MWHPR15MB1118.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(2906002)(5024004)(14444005)(256004)(76116006)(2501003)(305945005)(11346002)(476003)(2616005)(36756003)(5660300002)(486006)(86362001)(2201001)(46003)(6116002)(446003)(66446008)(66556008)(66476007)(66946007)(73956011)(64756008)(76176011)(53936002)(8676002)(4326008)(81156014)(50226002)(229853002)(478600001)(186003)(25786009)(99286004)(81166006)(6486002)(97736004)(6246003)(71200400001)(7736002)(71190400001)(68736007)(110136005)(54906003)(14454004)(53546011)(6506007)(6512007)(8936002)(102836004)(118296001)(316002)(6436002)(99106002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1118;H:MWHPR15MB1262.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B+BkvXtvRGLWGTp1oUi7VGnrbUaKmVGS2akB+Q1+/ZW0KU9/LFkqgTHLQ4758nRvgF5E+HEOzvzWjRPxdvHSzYgWKYKbNNaGOxV+XW/M28ryDLNOS5Et3ugZzkWY20nfZZ5YWVXEfJj+HFnJUOOFtAZJcZeGvRthz6nMEdpSbkMudQPK0fMC1Lj3GpzPWIhE+CssbUji6PATmMZkqQ1blIQaEYp9dk34X2T/rZa1/yy82zBHLh3wLlnTJForijQ8TVolL+3BYFxKkGly1LwfrdvgXJ7d47hV7u9+JcuJUN90t6qcNpJThhxCHy6mWde1FgFDgkogTia0pUleYAnKU8sclusJxBbB5Qj5gNqK1S61onpY4EcHVdkYAVLSezeM2/efFaWeAUYlghD7P+u6bcUqGAdxqo6ahftW5fpPiBE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCADC7A4A004B743BE1BEE0765AE682E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c2f000-7e4a-40d1-87f2-08d6c757f05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:23:02.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDE4OjEyICswMDAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gT24gNC8xOS8xOSAyOjA0IFBNLCBNYXR0IE11bGxpbnMgd3JvdGU6DQo+ID4gVGhpcyBp
cyBhbiBvcHQtaW4gaW50ZXJmYWNlIHRoYXQgYWxsb3dzIGEgdHJhY2Vwb2ludCB0byBwcm92aWRl
IGEgc2FmZQ0KPiA+IGJ1ZmZlciB0aGF0IGNhbiBiZSB3cml0dGVuIGZyb20gYSBCUEZfUFJPR19U
WVBFX1JBV19UUkFDRVBPSU5UIHByb2dyYW0uDQo+ID4gVGhlIHNpemUgb2YgdGhlIGJ1ZmZlciBt
dXN0IGJlIGEgY29tcGlsZS10aW1lIGNvbnN0YW50LCBhbmQgaXMgY2hlY2tlZA0KPiA+IGJlZm9y
ZSBhbGxvd2luZyBhIEJQRiBwcm9ncmFtIHRvIGF0dGFjaCB0byBhIHRyYWNlcG9pbnQgdGhhdCB1
c2VzIHRoaXMNCj4gPiBmZWF0dXJlLg0KPiA+IA0KPiA+IFRoZSBwb2ludGVyIHRvIHRoaXMgYnVm
ZmVyIHdpbGwgYmUgdGhlIGZpcnN0IGFyZ3VtZW50IG9mIHRyYWNlcG9pbnRzDQo+ID4gdGhhdCBv
cHQgaW47IHRoZSBidWZmZXIgaXMgcmVhZGFibGUgYnkgYm90aCBCUEZfUFJPR19UWVBFX1JBV19U
UkFDRVBPSU5UDQo+ID4gYW5kIEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUg
cHJvZ3JhbXMgdGhhdCBhdHRhY2ggdG8gc3VjaCBhDQo+ID4gdHJhY2Vwb2ludCwgYnV0IHRoZSBi
dWZmZXIgdG8gd2hpY2ggaXQgcG9pbnRzIG1heSBvbmx5IGJlIHdyaXR0ZW4gYnkgdGhlDQo+ID4g
bGF0dGVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHQgTXVsbGlucyA8bW11bGxpbnNA
ZmIuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9icGYuaCAgICAgICAgICAgICB8
ICAyICsrDQo+ID4gICBpbmNsdWRlL2xpbnV4L2JwZl90eXBlcy5oICAgICAgIHwgIDEgKw0KPiA+
ICAgaW5jbHVkZS9saW51eC90cmFjZXBvaW50LWRlZnMuaCB8ICAxICsNCj4gPiAgIGluY2x1ZGUv
dHJhY2UvYnBmX3Byb2JlLmggICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgIGluY2x1ZGUvdWFwaS9saW51eC9icGYuaCAgICAgICAgfCAgMSArDQo+ID4gICBrZXJu
ZWwvYnBmL3N5c2NhbGwuYyAgICAgICAgICAgIHwgIDggKysrKysrLS0NCj4gPiAgIGtlcm5lbC9i
cGYvdmVyaWZpZXIuYyAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgICAgICAgIHwgMjEgKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gICA4IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnBmLmgg
Yi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gaW5kZXggYTIxMzJlMDlkYzFjLi5kM2M3MWZkNjc0
NzYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvYnBmLmgNCj4gPiBAQCAtMjYzLDYgKzI2Myw3IEBAIGVudW0gYnBmX3JlZ190eXBl
IHsNCj4gPiAgIAlQVFJfVE9fU09DS19DT01NT05fT1JfTlVMTCwgLyogcmVnIHBvaW50cyB0byBz
b2NrX2NvbW1vbiBvciBOVUxMICovDQo+ID4gICAJUFRSX1RPX1RDUF9TT0NLLAkgLyogcmVnIHBv
aW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgKi8NCj4gPiAgIAlQVFJfVE9fVENQX1NPQ0tfT1JfTlVM
TCwgLyogcmVnIHBvaW50cyB0byBzdHJ1Y3QgdGNwX3NvY2sgb3IgTlVMTCAqLw0KPiA+ICsJUFRS
X1RPX1RQX0JVRkZFUiwJIC8qIHJlZyBwb2ludHMgdG8gYSB3cml0YWJsZSByYXcgdHAncyBidWZm
ZXIgKi8NCj4gPiAgIH07DQo+ID4gICANCj4gDQo+IFsuLi5dDQo+ID4gICAvKiB0cnVuY2F0ZSBy
ZWdpc3RlciB0byBzbWFsbGVyIHNpemUgKGluIGJ5dGVzKQ0KPiA+ICAgICogbXVzdCBiZSBjYWxs
ZWQgd2l0aCBzaXplIDwgQlBGX1JFR19TSVpFDQo+ID4gICAgKi8NCj4gPiBAQCAtMjEwMCw2ICsy
MTI3LDEwIEBAIHN0YXRpYyBpbnQgY2hlY2tfbWVtX2FjY2VzcyhzdHJ1Y3QgYnBmX3ZlcmlmaWVy
X2VudiAqZW52LCBpbnQgaW5zbl9pZHgsIHUzMiByZWduDQo+ID4gICAJCWVyciA9IGNoZWNrX3Nv
Y2tfYWNjZXNzKGVudiwgaW5zbl9pZHgsIHJlZ25vLCBvZmYsIHNpemUsIHQpOw0KPiA+ICAgCQlp
ZiAoIWVyciAmJiB2YWx1ZV9yZWdubyA+PSAwKQ0KPiA+ICAgCQkJbWFya19yZWdfdW5rbm93bihl
bnYsIHJlZ3MsIHZhbHVlX3JlZ25vKTsNCj4gPiArCX0gZWxzZSBpZiAocmVnLT50eXBlID09IFBU
Ul9UT19UUF9CVUZGRVIpIHsNCj4gPiArCQllcnIgPSBjaGVja190cF9idWZmZXJfYWNjZXNzKGVu
diwgcmVnLCByZWdubywgb2ZmLCBzaXplKTsNCj4gPiArCQlpZiAoIWVyciAmJiB0ID09IEJQRl9S
RUFEICYmIHZhbHVlX3JlZ25vID49IDApDQo+ID4gKwkJCW1hcmtfcmVnX3Vua25vd24oZW52LCBy
ZWdzLCB2YWx1ZV9yZWdubyk7DQo+ID4gICAJfSBlbHNlIHsNCj4gPiAgIAkJdmVyYm9zZShlbnYs
ICJSJWQgaW52YWxpZCBtZW0gYWNjZXNzICclcydcbiIsIHJlZ25vLA0KPiA+ICAgCQkJcmVnX3R5
cGVfc3RyW3JlZy0+dHlwZV0pOw0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvYnBmX3Ry
YWNlLmMgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gPiBpbmRleCBkNjRjMDBhZmNlYjUu
LmEyZGQ3OWRjNjg3MSAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMN
Cj4gPiArKysgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gPiBAQCAtOTA5LDYgKzkwOSwy
NCBAQCBjb25zdCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX29wcyByYXdfdHJhY2Vwb2ludF92ZXJpZmll
cl9vcHMgPSB7DQo+ID4gICBjb25zdCBzdHJ1Y3QgYnBmX3Byb2dfb3BzIHJhd190cmFjZXBvaW50
X3Byb2dfb3BzID0gew0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICtzdGF0aWMgYm9vbCByYXdfdHBf
d3JpdGFibGVfcHJvZ19pc192YWxpZF9hY2Nlc3MoaW50IG9mZiwgaW50IHNpemUsDQo+ID4gKwkJ
CQkJCSBlbnVtIGJwZl9hY2Nlc3NfdHlwZSB0eXBlLA0KPiA+ICsJCQkJCQkgY29uc3Qgc3RydWN0
IGJwZl9wcm9nICpwcm9nLA0KPiA+ICsJCQkJCQkgc3RydWN0IGJwZl9pbnNuX2FjY2Vzc19hdXgg
KmluZm8pDQo+ID4gK3sNCj4gPiArCWlmIChvZmYgPT0gMCAmJiBzaXplID09IHNpemVvZih1NjQp
KQ0KPiA+ICsJCWluZm8tPnJlZ190eXBlID0gUFRSX1RPX1RQX0JVRkZFUjsNCj4gDQo+IG9uIDMy
Yml0IHN5c3RlbSwgdGhlIGZpcnN0IGFyZ3VtZW50IHBvaW50ZXIgc2l6ZSBjb3VsZCBiZSBzaXpl
b2YodTMyKT8NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHBvaW50ZXJzIGFyZSBhbHdheXMgNjQg
Yml0cyB3aWRlIGZyb20gdGhlDQpwZXJzcGVjdGl2ZSBvZiB0aGUgZUJQRiBpbnN0cnVjdGlvbiBz
ZXQuICBJIHRoaW5rIHRoZSBwcm9wZXIgZml4dXAgaXMNCmluIGluY2x1ZGUvdHJhY2UvZXZlbnRz
L25iZC5oIC4uLiBJIHNob3VsZCB1c2UgYSB1NjQgaW5zdGVhZCBvZiBhDQpwb2ludGVyIHR5cGUu
DQoNCj4gU2hvdWxkIHRoZSBmaXJzdCBhcmd1bWVudCBmb3IgcmF3X3RwX3dyaXRhYmxlX3Byb2cg
YmUgYWx3YXlzIA0KPiBQVFJfVE9fVFBfQlVGRkVSPw0KDQpUaGF0IGlzIHRoZSBwdXJwb3NlIG9m
IHRoaXMgcGF0Y2ggc2VyaWVzLCB5ZXMuICBNeSBpbml0aWFsIGF0dGVtcHQgYXQNCnRoaXMgdHJp
ZWQgdG8gYWRkIGl0IHRvIHRoZSBlbmQgb2YgdGhlIGNvbnRleHQgc3RydWN0dXJlIGluc3RlYWQs
IGFuZA0KdGhhdCBlbmRlZCB1cCBiZWluZyBxdWl0ZSBjb21wbGV4IHRvIHRyYWNrLg0KDQo+IA0K
PiA+ICsJcmV0dXJuIHJhd190cF9wcm9nX2lzX3ZhbGlkX2FjY2VzcyhvZmYsIHNpemUsIHR5cGUs
IHByb2csIGluZm8pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtjb25zdCBzdHJ1Y3QgYnBmX3Zlcmlm
aWVyX29wcyByYXdfdHJhY2Vwb2ludF93cml0YWJsZV92ZXJpZmllcl9vcHMgPSB7DQo+ID4gKwku
Z2V0X2Z1bmNfcHJvdG8gID0gcmF3X3RwX3Byb2dfZnVuY19wcm90bywNCj4gPiArCS5pc192YWxp
ZF9hY2Nlc3MgPSByYXdfdHBfd3JpdGFibGVfcHJvZ19pc192YWxpZF9hY2Nlc3MsDQo+ID4gK307
DQo+ID4gKw0KPiA+ICtjb25zdCBzdHJ1Y3QgYnBmX3Byb2dfb3BzIHJhd190cmFjZXBvaW50X3dy
aXRhYmxlX3Byb2dfb3BzID0gew0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgIHN0YXRpYyBib29sIHBl
X3Byb2dfaXNfdmFsaWRfYWNjZXNzKGludCBvZmYsIGludCBzaXplLCBlbnVtIGJwZl9hY2Nlc3Nf
dHlwZSB0eXBlLA0KPiA+ICAgCQkJCSAgICBjb25zdCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2csDQo+
ID4gICAJCQkJICAgIHN0cnVjdCBicGZfaW5zbl9hY2Nlc3NfYXV4ICppbmZvKQ0KPiA+IEBAIC0x
MTk4LDYgKzEyMTYsOSBAQCBzdGF0aWMgaW50IF9fYnBmX3Byb2JlX3JlZ2lzdGVyKHN0cnVjdCBi
cGZfcmF3X2V2ZW50X21hcCAqYnRwLCBzdHJ1Y3QgYnBmX3Byb2cgKg0KPiA+ICAgCWlmIChwcm9n
LT5hdXgtPm1heF9jdHhfb2Zmc2V0ID4gYnRwLT5udW1fYXJncyAqIHNpemVvZih1NjQpKQ0KPiA+
ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgIA0KPiA+ICsJaWYgKHByb2ctPmF1eC0+bWF4X3Rw
X2FjY2VzcyA+IGJ0cC0+d3JpdGFibGVfc2l6ZSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiArDQo+ID4gICAJcmV0dXJuIHRyYWNlcG9pbnRfcHJvYmVfcmVnaXN0ZXIodHAsICh2b2lkICop
YnRwLT5icGZfZnVuYywgcHJvZyk7DQo+ID4gICB9DQo+ID4gICANCj4gPiANCg==
