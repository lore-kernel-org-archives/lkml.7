Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E56BC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5902173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="nV6kfa7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:11:05 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:61953
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfLFOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw2YdsVpbPAASPf5HLfoMwze/rZyxD01Tnwt4UmhUMYyaM+w1+2aBpDlZk6cKz50xB0rIa3AA3kJM0z9GM1g5Vn6VRAcknEPwetzQLgUjqSFSRVsFq2Yq1E5Q9x7H/Y7XKh1DbcXWihmbalA3/VYLBts2QVOP3tfwejT/AZpFS6AXnhXYbpczKYZANbX9W1MmMgWE6Sz4qE8qmLBqQLihG43IXm2PfGZ5dmVpXymu9VY/rUM/WaWCCqD+IqRVj8nvGWa8F9gZhuhigKgWW/FyGRmh4+DGUFB9r7xt9SPDYi+AiefPqgzAvDxsC2ZcH6655wXaJ4ggrJ91Cvh044+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od4pN0+qEhGfsdE3/dEeHS9fPLMbYL+0sqtYoqoaV1U=;
 b=HzDlddk0TMfFdTgG/itw1u8fvtrwd64Or4WMbYvfSR8v56fZLq60Hi7IafFXZ/NBAUN1VTLwlI7gOD2z9y3uM7lWrw9K0ehfvVyp4AQ0nkvWogyDF7xVQMqWb0lRFLntWMoBZkjrEP5KBosnCTya9VKgrCoFsN7I2Cv+jRKVxVf7n5DjbkakYOWHjSxbhMbmRZ0w1H4mceGWiojHzTviTfXV8CyuLIb9t3Hoe7u1rkTXgAwqukv8tnQSvluHzFr1HCcOa39eVW19+7rzfeCjixSjEZEghOfBxPCvLa042EMwkJWHUSV1/kOEmtFMo+u0Op2ybKaim+o5JhViDVXkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od4pN0+qEhGfsdE3/dEeHS9fPLMbYL+0sqtYoqoaV1U=;
 b=nV6kfa7Q7ZK2EmASYDB835dq9LlMl75tZkRFmwKs++JkpVu3+94KPBiAvuSShubHn/0GADPs8elIwm7E5zQV5H7yT37WCNebxEawG9ZWYKlS9/sY8dVlyRaWc+lIXH+G1vLB1fsFtxCLeqMx6DJBtedHfioMIroXvewpPAOEu0c=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6814.namprd05.prod.outlook.com (52.132.172.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.5; Fri, 6 Dec 2019 14:10:59 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2516.003; Fri, 6 Dec 2019
 14:10:59 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
CC:     "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Topic: [PATCH 2/2] dma-mapping: force unencryped devices are always
 addressing limited
Thread-Index: AQHVqqNPg/9Qsdg+60Sr+vJTCD2APKetKK8A
Date:   Fri, 6 Dec 2019 14:10:59 +0000
Message-ID: <c98d594b465d3d8228743bc54017b8c456695219.camel@vmware.com>
References: <20191204130339.22804-1-hch@lst.de>
         <20191204130339.22804-3-hch@lst.de>
In-Reply-To: <20191204130339.22804-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25e2256e-836c-485f-9ad7-08d77a561eb0
x-ms-traffictypediagnostic: MN2PR05MB6814:
x-microsoft-antispam-prvs: <MN2PR05MB68143162087E1B6829692182A15F0@MN2PR05MB6814.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(66446008)(316002)(8936002)(71190400001)(66556008)(71200400001)(66476007)(305945005)(5660300002)(91956017)(36756003)(54906003)(110136005)(2906002)(118296001)(66946007)(229853002)(6512007)(86362001)(99286004)(478600001)(102836004)(6506007)(8676002)(81166006)(76176011)(6486002)(186003)(2616005)(81156014)(26005)(4326008)(64756008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6814;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vNigA4u55E/GOHw8i99hED6wtGY8NN0R1cxCSIzed7w9PEAmjNNOjccHq2+i+UT4XDsY/zkd5rPsAxelKmAfPmsA6VszMwnEmJWyP46XMGco85yjJIKJuZjJh3IfmBdtwZNLYB5skCnJqPUsWomvbWPCNTCsCKyLZL9igp6ZkpzzpdjzESGX7anz8rC6dHDEi6Wm6mUKumJAgtGl4LC2oqtr276TnqylT/s4cF5YwHq944mPFzPHzGSQ009MjPy1uxEVtUPGWC2urgDATzzJu3HOBd9MXHM1znK5MCVo6nA0v5uxdIUuTMMyOg2E8/WAYtyFQNQ8Y8ODoOhZS3w/V4wT4kLA94wTKXHz4BwQwcnEUCTvm6pl271B6lBXmFY5NE7PXZtwXBV+8ssQ9ZnjrMRbyYvwC93hcHLjd28AKuDTtHJFYqgUZI5jIlf6UIr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF5620F9EA7224F9ACF5E0AA5D5D863@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e2256e-836c-485f-9ad7-08d77a561eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 14:10:59.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BJ8IvB8xVjAvaPpbl3nqsXbhX+NXOBjkTRaLjlb/SnblsahndquM+UWf/hxPfMyo2qxUUBL6aEj9YWc90K7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENocmlzdG9waC4NCg0KDQpPbiBXZWQsIDIwMTktMTItMDQgYXQgMTQ6MDMgKzAxMDAsIENo
cmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBEZXZpY2VzIHRoYXQgYXJlIGZvcmNlZCB0byBETUEg
dGhyb3VnaCBzd2lvdGxiIG5lZWQgdG8gYmUgdHJlYXRlZCBhcw0KPiBpZg0KPiB0aGV5IGFyZSBh
ZGRyZXNzaW5nIGxpbWl0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2RtYS1kaXJlY3QuaCB8IDEg
Kw0KPiAga2VybmVsL2RtYS9kaXJlY3QuYyAgICAgICAgfCA4ICsrKysrKy0tDQo+ICBrZXJuZWwv
ZG1hL21hcHBpbmcuYyAgICAgICB8IDMgKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9kbWEtZGlyZWN0LmggYi9pbmNsdWRlL2xpbnV4L2RtYS1kaXJlY3QuaA0KPiBpbmRleCAyNGI4
Njg0YWEyMWQuLjgzYWFjMjE0MzRjNiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEt
ZGlyZWN0LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtZGlyZWN0LmgNCj4gQEAgLTg1LDQg
Kzg1LDUgQEAgaW50IGRtYV9kaXJlY3RfbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0K
PiB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAgCQl2b2lkICpjcHVfYWRkciwgZG1hX2FkZHJfdCBk
bWFfYWRkciwgc2l6ZV90IHNpemUsDQo+ICAJCXVuc2lnbmVkIGxvbmcgYXR0cnMpOw0KPiAgaW50
IGRtYV9kaXJlY3Rfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spOw0KPiAr
Ym9vbCBkbWFfZGlyZWN0X2FkZHJlc3NpbmdfbGltaXRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0K
PiAgI2VuZGlmIC8qIF9MSU5VWF9ETUFfRElSRUNUX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9kbWEvZGlyZWN0LmMgYi9rZXJuZWwvZG1hL2RpcmVjdC5jDQo+IGluZGV4IDZhZjdhZTgzYzRh
ZC4uNDUwZjNhYmU1Y2I1IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZG1hL2RpcmVjdC5jDQo+ICsr
KyBiL2tlcm5lbC9kbWEvZGlyZWN0LmMNCj4gQEAgLTQ5NywxMSArNDk3LDE1IEBAIGludCBkbWFf
ZGlyZWN0X3N1cHBvcnRlZChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHU2NCBtYXNrKQ0KPiAgCXJl
dHVybiBtYXNrID49IF9fcGh5c190b19kbWEoZGV2LCBtaW5fbWFzayk7DQo+ICB9DQo+ICANCj4g
K2Jvb2wgZG1hX2RpcmVjdF9hZGRyZXNzaW5nX2xpbWl0ZWQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiArew0KPiArCXJldHVybiBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQoZGV2KSB8fCBzd2lvdGxiX2Zv
cmNlID09DQo+IFNXSU9UTEJfRk9SQ0U7DQo+ICt9DQo+ICsNCj4gIHNpemVfdCBkbWFfZGlyZWN0
X21heF9tYXBwaW5nX3NpemUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCS8qIElmIFNX
SU9UTEIgaXMgYWN0aXZlLCB1c2UgaXRzIG1heGltdW0gbWFwcGluZyBzaXplICovDQo+IC0JaWYg
KGlzX3N3aW90bGJfYWN0aXZlKCkgJiYNCj4gLQkgICAgKGRtYV9hZGRyZXNzaW5nX2xpbWl0ZWQo
ZGV2KSB8fCBzd2lvdGxiX2ZvcmNlID09DQo+IFNXSU9UTEJfRk9SQ0UpKQ0KPiArCWlmIChpc19z
d2lvdGxiX2FjdGl2ZSgpICYmIGRtYV9hZGRyZXNzaW5nX2xpbWl0ZWQoZGV2KSkNCj4gIAkJcmV0
dXJuIHN3aW90bGJfbWF4X21hcHBpbmdfc2l6ZShkZXYpOw0KPiAgCXJldHVybiBTSVpFX01BWDsN
Cj4gIH0NCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvbWFwcGluZy5jIGIva2VybmVsL2RtYS9t
YXBwaW5nLmMNCj4gaW5kZXggMWRiZTZkNzI1OTYyLi5lYmM2MDYzM2Q4OWEgMTAwNjQ0DQo+IC0t
LSBhL2tlcm5lbC9kbWEvbWFwcGluZy5jDQo+ICsrKyBiL2tlcm5lbC9kbWEvbWFwcGluZy5jDQo+
IEBAIC00MTYsNiArNDE2LDkgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZG1hX2dldF9tZXJnZV9ib3Vu
ZGFyeSk7DQo+ICAgKi8NCj4gIGJvb2wgZG1hX2FkZHJlc3NpbmdfbGltaXRlZChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICB7DQo+ICsJaWYgKGRtYV9pc19kaXJlY3QoZ2V0X2RtYV9vcHMoZGV2KSkg
JiYNCj4gKwkgICAgZG1hX2RpcmVjdF9hZGRyZXNzaW5nX2xpbWl0ZWQoZGV2KSkNCj4gKwkJcmV0
dXJuIHRydWU7DQoNClRoaXMgd29ya3MgZmluZSBmb3Igdm13Z2Z4LCBmb3Igd2hpY2ggdGhlIGJl
bG93IGV4cHJlc3Npb24gaXMgYWx3YXlzIDAuDQpCdXQgaXQgbG9va3MgbGlrZSB0aGUgb25seSBj
dXJyZW50IHVzZXIgb2YgZG1hX2FkZHJlc3NpbmdfbGltaXRlZA0Kb3V0c2lkZSBvZiB0aGUgZG1h
IGNvZGUsIHJhZGVvbiwgYWN0dWFsbHkgd2FudHMgb25seSB0aGUgYmVsb3cNCmV4cHJlc3Npb24g
dG8gZm9yY2UgR0ZQX0RNQTMyIHBhZ2UgYWxsb2NhdGlvbnMgd2hlbiB0aGUgZGV2aWNlcyBoYXZl
DQpsaW1pdGVkIGRtYSBhZGRyZXNzIHNwYWNlLiBQZXJoYXBzIENocmlzdGlhbiBjYW4gZWxhYm9y
YXRlIG9uIHRoYXQuDQoNClNvIGluIHRoZSBlbmQgaXQgbG9va3MgbGlrZSB3ZSBoYXZlIHR3byBk
aWZmZXJlbnQgdXNlIGNhc2VzLiBPbmUgdG8NCmZvcmNlIGNvaGVyZW50IG1lbW9yeSAodm13Z2Z4
LCBwb3NzaWJseSBvdGhlciBncmFocGljcyBkcml2ZXJzKSBvcg0KcmVkdWNlZCBxdWV1ZSBkZXB0
aCAodm13X3B2c2NzaSkgd2hlbiB3ZSBoYXZlIGJvdW5jZS1idWZmZXJpbmcuDQoNClRoZSBvdGhl
ciBvbmUgaXMgdG8gZm9yY2UgR0ZQX0RNQTMyIHBhZ2UgYWxsb2NhdGlvbiB3aGVuIHRoZSBkZXZp
Y2UNCmRtYS1hZGRyZXNzaW5nIGlzIGxpbWl0ZWQuIFBlcmhhcHMgdGhpcyBtb2RlIGNhbiBiZSBy
ZXBsYWNlZCBieSB1c2luZw0KZG1hX2NvaGVyZW50IG1lbW9yeSBhbmQgc3RyaXBwZWQgdGhhdCBm
dW5jdGlvbmFsaXR5IGZyb20gVFRNPw0KDQo+ICAJcmV0dXJuIG1pbl9ub3RfemVybyhkbWFfZ2V0
X21hc2soZGV2KSwgZGV2LT5idXNfZG1hX2xpbWl0KSA8DQo+ICAJCQkgICAgZG1hX2dldF9yZXF1
aXJlZF9tYXNrKGRldik7DQo+ICB9DQoNCg0KVGhhbmtzLA0KVGhvbWFzDQoNCg==
