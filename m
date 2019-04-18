Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C99C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607052183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ayGurQbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfDRI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:28:54 -0400
Received: from mail-eopbgr770072.outbound.protection.outlook.com ([40.107.77.72]:11106
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbfDRI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQtbWY6zqqDOHWn2c9H9yhjyF9z9beU8YvgwleVlyB4=;
 b=ayGurQbxpr1IxMizDAbGcF4ecjoClBmaRaEmCej3a70lcJ5e6ILC6oEa6d7G8fkmpXxDlHKDXizys9LIp/Sold9mFoUfO4OCMN/qOxE6cM/eGxtHiZ13ltV9+9KmEzNfTca9Nue+d0PDAbcEJgHIBv6HTI5jWnB1bXglDOWtUIQ=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Thu, 18 Apr 2019 08:28:51 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1813.013; Thu, 18 Apr
 2019 08:28:51 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Thread-Topic: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Thread-Index: AQHU9b3rtUqKb1xVM0O+lx+3bc1c1aZBlfuA
Date:   Thu, 18 Apr 2019 08:28:51 +0000
Message-ID: <0611f62c-2b81-b85f-a8d9-69c3daf0c635@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
 <20190417190719.GL13337@phenom.ffwll.local>
 <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
 <20190418080826.GN13337@phenom.ffwll.local>
In-Reply-To: <20190418080826.GN13337@phenom.ffwll.local>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P193CA0061.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::38) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4abfcd8c-e508-4ab8-f947-08d6c3d7e2ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR12MB2504;
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB25044A860A3D4EA747BD9E6A83260@DM5PR12MB2504.namprd12.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(52116002)(11346002)(446003)(31696002)(66574012)(2501003)(86362001)(6246003)(53936002)(99286004)(6512007)(7736002)(65956001)(110136005)(81166006)(6436002)(36756003)(65826007)(65806001)(81156014)(31686004)(2201001)(97736004)(2906002)(305945005)(8936002)(14444005)(68736007)(316002)(25786009)(76176011)(102836004)(478600001)(8676002)(14454004)(229853002)(72206003)(64126003)(6116002)(5024004)(256004)(46003)(93886005)(476003)(386003)(71200400001)(186003)(5660300002)(486006)(6506007)(2616005)(58126008)(6486002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2504;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yeq6uFWXsqLrRK7cmFEBKa7zMtoUrJd/qsnI8RhqQ4leYEBEK/l6VaWAHjY8EiPdsQWb2qYXzdW0h+fHoHKehMddaSnZNdaIvjZOWdQMBsCXNlY7UKIf+fYfTsG328odkm94lC/WFbe1KkWtdL+j2s1d8hXXdPUgjS+LRdY41kwrEjgx7AjvugD+AAN2/jNyLXX/rNqZkFIJRjSf7FbJyjx9BUxZhx2PDwRklZmKOHEo8x43/AQDfjxy4DMKyjWpQMt4PICJaiyxwWZCeGslrF6mTsv40BiJvN9RrlJQJmIApF67Y85ZuDzR/UGQkNTSF7HGMdJW9QiRfWG+Cw0ldc6kJAeVv/ISGlRlQ9NRzeBJ9lmAxUNW8ng3GPFZtVVRSya8TewtSqHiuSzlgYWmitpDO2qjRh9yeZbpebIodCY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36AED96C7FBD8D46AB2DE6ACAC60BA31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abfcd8c-e508-4ab8-f947-08d6c3d7e2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:28:51.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTguMDQuMTkgdW0gMTA6MDggc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBPbiBXZWQsIEFw
ciAxNywgMjAxOSBhdCAwOToxMzoyMlBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0K
Pj4gQW0gMTcuMDQuMTkgdW0gMjE6MDcgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPj4+IE9uIFR1
ZSwgQXByIDE2LCAyMDE5IGF0IDA4OjM4OjMzUE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6DQo+Pj4+IEVhY2ggaW1wb3J0ZXIgY2FuIG5vdyBwcm92aWRlIGFuIGludmFsaWRhdGVfbWFw
cGluZ3MgY2FsbGJhY2suDQo+Pj4+DQo+Pj4+IFRoaXMgYWxsb3dzIHRoZSBleHBvcnRlciB0byBw
cm92aWRlIHRoZSBtYXBwaW5ncyB3aXRob3V0IHRoZSBuZWVkIHRvIHBpbg0KPj4+PiB0aGUgYmFj
a2luZyBzdG9yZS4NCj4+Pj4NCj4+Pj4gdjI6IGRvbid0IHRyeSB0byBpbnZhbGlkYXRlIG1hcHBp
bmdzIHdoZW4gdGhlIGNhbGxiYWNrIGlzIE5VTEwsDQo+Pj4+ICAgICAgIGxvY2sgdGhlIHJlc2Vy
dmF0aW9uIG9iaiB3aGlsZSB1c2luZyB0aGUgYXR0YWNobWVudHMsDQo+Pj4+ICAgICAgIGFkZCBo
ZWxwZXIgdG8gc2V0IHRoZSBjYWxsYmFjaw0KPj4+PiB2MzogbW92ZSBmbGFnIGZvciBpbnZhbGlk
YXRpb24gc3VwcG9ydCBpbnRvIHRoZSBETUEtYnVmLA0KPj4+PiAgICAgICB1c2UgbmV3IGF0dGFj
aF9pbmZvIHN0cnVjdHVyZSB0byBzZXQgdGhlIGNhbGxiYWNrDQo+Pj4+IHY0OiB1c2UgaW1wb3J0
ZXJfcHJpdiBmaWVsZCBpbnN0ZWFkIG9mIG1hbmdsaW5nIGV4cG9ydGVyIHByaXYuDQo+Pj4+IHY1
OiBkcm9wIGludmFsaWRhdGlvbl9zdXBwb3J0ZWQgZmxhZw0KPj4+Pg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+Pj4+IC0t
LQ0KPj4+PiAgICBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIHwgMzcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgICBpbmNsdWRlL2xpbnV4L2RtYS1idWYuaCAg
IHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4+ICAgIDIgZmlsZXMg
Y2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1h
LWJ1Zi5jDQo+Pj4+IGluZGV4IDgzYzkyYmZkOTY0Yy4uYTM3MzhmYWIzOTI3IDEwMDY0NA0KPj4+
PiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZG1h
LWJ1Zi9kbWEtYnVmLmMNCj4+Pj4gQEAgLTU2Myw2ICs1NjMsOCBAQCBzdHJ1Y3QgZG1hX2J1Zl9h
dHRhY2htZW50ICpkbWFfYnVmX2F0dGFjaChjb25zdCBzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2hfaW5m
byAqaW5mbw0KPj4+PiAgICAJYXR0YWNoLT5kZXYgPSBpbmZvLT5kZXY7DQo+Pj4+ICAgIAlhdHRh
Y2gtPmRtYWJ1ZiA9IGRtYWJ1ZjsNCj4+Pj4gKwlhdHRhY2gtPmltcG9ydGVyX3ByaXYgPSBpbmZv
LT5pbXBvcnRlcl9wcml2Ow0KPj4+PiArCWF0dGFjaC0+aW52YWxpZGF0ZSA9IGluZm8tPmludmFs
aWRhdGU7DQo+Pj4+ICAgIAltdXRleF9sb2NrKCZkbWFidWYtPmxvY2spOw0KPj4+PiBAQCAtNTcx
LDcgKzU3Myw5IEBAIHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmRtYV9idWZfYXR0YWNoKGNv
bnN0IHN0cnVjdCBkbWFfYnVmX2F0dGFjaF9pbmZvICppbmZvDQo+Pj4+ICAgIAkJaWYgKHJldCkN
Cj4+Pj4gICAgCQkJZ290byBlcnJfYXR0YWNoOw0KPj4+PiAgICAJfQ0KPj4+PiArCXJlc2VydmF0
aW9uX29iamVjdF9sb2NrKGRtYWJ1Zi0+cmVzdiwgTlVMTCk7DQo+Pj4+ICAgIAlsaXN0X2FkZCgm
YXR0YWNoLT5ub2RlLCAmZG1hYnVmLT5hdHRhY2htZW50cyk7DQo+Pj4+ICsJcmVzZXJ2YXRpb25f
b2JqZWN0X3VubG9jayhkbWFidWYtPnJlc3YpOw0KPj4+PiAgICAJbXV0ZXhfdW5sb2NrKCZkbWFi
dWYtPmxvY2spOw0KPj4+PiBAQCAtNjE1LDcgKzYxOSw5IEBAIHZvaWQgZG1hX2J1Zl9kZXRhY2go
c3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwgc3RydWN0IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNo
KQ0KPj4+PiAgICAJCQkJCSAgIERNQV9CSURJUkVDVElPTkFMKTsNCj4+Pj4gICAgCW11dGV4X2xv
Y2soJmRtYWJ1Zi0+bG9jayk7DQo+Pj4+ICsJcmVzZXJ2YXRpb25fb2JqZWN0X2xvY2soZG1hYnVm
LT5yZXN2LCBOVUxMKTsNCj4+Pj4gICAgCWxpc3RfZGVsKCZhdHRhY2gtPm5vZGUpOw0KPj4+PiAr
CXJlc2VydmF0aW9uX29iamVjdF91bmxvY2soZG1hYnVmLT5yZXN2KTsNCj4+Pj4gICAgCWlmIChk
bWFidWYtPm9wcy0+ZGV0YWNoKQ0KPj4+PiAgICAJCWRtYWJ1Zi0+b3BzLT5kZXRhY2goZG1hYnVm
LCBhdHRhY2gpOw0KPj4+PiBAQCAtNjUzLDcgKzY1OSwxNiBAQCBkbWFfYnVmX21hcF9hdHRhY2ht
ZW50X2xvY2tlZChzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2gsDQo+Pj4+ICAgIAlp
ZiAoYXR0YWNoLT5zZ3QpDQo+Pj4+ICAgIAkJcmV0dXJuIGF0dGFjaC0+c2d0Ow0KPj4+PiArCS8q
DQo+Pj4+ICsJICogTWFwcGluZyBhIERNQS1idWYgY2FuIHRyaWdnZXIgaXRzIGludmFsaWRhdGlv
biwgcHJldmVudCBzZW5kaW5nIHRoaXMNCj4+Pj4gKwkgKiBldmVudCB0byB0aGUgY2FsbGVyIGJ5
IHRlbXBvcmFyeSByZW1vdmluZyB0aGlzIGF0dGFjaG1lbnQgZnJvbSB0aGUNCj4+Pj4gKwkgKiBs
aXN0Lg0KPj4+PiArCSAqLw0KPj4+PiArCWlmIChhdHRhY2gtPmludmFsaWRhdGUpDQo+Pj4+ICsJ
CWxpc3RfZGVsKCZhdHRhY2gtPm5vZGUpOw0KPj4+IEp1c3Qgbm90aWNlZCB0aGlzOiBXaHkgZG8g
d2UgbmVlZCB0aGlzPyBpbnZhbGlkYXRlIG5lZWRzIHRoZSByZXNlcnZhdGlvbg0KPj4+IGxvY2ss
IGFzIGRvZXMgbWFwX2F0dGFjaG1lbnQuIEl0IHNob3VsZCBiZSBpbXBzc29ibGUgdG8gaGF2ZSBz
b21lb25lIGVsc2UNCj4+PiBzbmVhayBpbiBoZXJlLg0KPj4gSSB3YXMgaGF2aW5nIHByb2JsZW1z
IHdpdGggc2VsZiB0cmlnZ2VyZWQgaW52YWxpZGF0aW9ucy4NCj4+DQo+PiBFLmcuIGNsaWVudCBB
IHRyaWVzIHRvIG1hcCBhbiBhdHRhY2htZW50LCB0aGF0IGluIHR1cm4gY2F1c2VzIHRoZSBidWZm
ZXIgdG8NCj4+IG1vdmUgdG8gYSBuZXcgcGxhY2UgYW5kIGNsaWVudCBBIGlzIGluZm9ybWVkIGFi
b3V0IHRoYXQgbW92ZW1lbnQgd2l0aCBhbg0KPj4gaW52YWxpZGF0aW9uLg0KPiBVaCwgdGhhdCBz
b3VuZHMgbGlrZSBhIGJ1ZyBpbiB0dG0gb3Igc29tZXdoZXJlIGVsc2UgaW4gdGhlIGV4cG9ydGVy
LiBJZg0KPiB5b3UgZXZpY3QgdGhlIGJvIHRoYXQgeW91J3JlIHRyeWluZyB0byBtYXAsIHRoYXQn
cyBiYWQuDQo+DQo+IE9yIG1heWJlIGl0J3MgYSBmcmFtZXdvcmsgYnVnLCBhbmQgd2UgbmVlZCB0
byB0cmFjayB3aGV0aGVyIGFuIGF0dGFjaG1lbnQNCj4gaGFzIGEgbWFwIG9yIG5vdC4gVGhhdCB3
b3VsZCBtYWtlIG1vcmUgc2Vuc2UgLi4uDQoNCldlbGwgbmVpdGhlciwgYXMgZmFyIGFzIEkgY2Fu
IHNlZSB0aGlzIGlzIHBlcmZlY3RseSBub3JtYWwgYmVoYXZpb3IuDQoNCldlIGp1c3QgZG9uJ3Qg
d2FudCBhbnkgaW52YWxpZGF0aW9uIHNlbmQgdG8gYSBkcml2ZXIgd2hpY2ggaXMgY3VycmVudGx5
IA0KbWFraW5nIGEgbWFwcGluZy4NCg0KSWYgeW91IHdhbnQgSSBjYW4gZG8gdGhpcyBpbiB0aGUg
ZHJpdmVyIGFzIHdlbGwsIGJ1dCBhdCBsZWFzdCBvZiBoYW5kIGl0IA0KbG9va3MgbGlrZSBhIGdv
b2QgaWRlYSB0byBoYXZlIHRoYXQgaW4gY29tbW9uIGNvZGUuDQoNClRyYWNraW5nIHRoZSBtYXBw
aW5ncyBjb3VsZCB3b3JrIGFzIHdlbGwsIGJ1dCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgSSAN
CmFjdHVhbGx5IHdhbnQgdGhlIGxpZmV0aW1lIG9mIG9sZCBhbmQgbmV3IG1hcHBpbmdzIHRvIG92
ZXJsYXAgZm9yIA0KcGlwZWxpbmluZy4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiAtRGFu
aWVsDQoNCg==
