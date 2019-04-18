Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36679C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A7217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XZKetLwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfDRNRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:17:19 -0400
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:38229
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389008AbfDRNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U47EEBzXxGnK2uAeD94qqKuR6x0HjQz0xg4QNMm4Joo=;
 b=XZKetLwttPfP9YqKGjguI/+1C8frK3FLsGEheRJbqirEfhWuhqpxl+1xl4WWRvib6MLfsQuXsyQ8+hjfSZcK7aA6vLJ7PKKziJIUVCgdhJ/NtBOiD+AToMnP8X5K/80SEwoPdttYIn5f33Gzr3ORvy2FT7waDr34bcUimeqLDUo=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2697.namprd12.prod.outlook.com (20.176.116.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 13:17:03 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::c96d:c1dd:fd7a:ffd6%4]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 13:17:03 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>, lijiang <lijiang@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Thread-Topic: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Thread-Index: AQHU5ix9aieHaoOfIE+gtf2DydRsNqYomnkAgAAw8wCAAAuSAIAUaGkAgAA3wYCAAo1MgIAByqAAgAA2lQA=
Date:   Thu, 18 Apr 2019 13:17:03 +0000
Message-ID: <b04098df-5c4e-b8c8-3d8d-bab68a5e197a@amd.com>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com> <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
 <20190415154155.GH29317@zn.tnic>
 <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
 <20190418100138.GD27160@zn.tnic>
In-Reply-To: <20190418100138.GD27160@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:803:20::15) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17f57348-86bd-4401-c31d-08d6c40025b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2697;
x-ms-traffictypediagnostic: DM6PR12MB2697:
x-microsoft-antispam-prvs: <DM6PR12MB2697082501EAB8598541E5C7EC260@DM6PR12MB2697.namprd12.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(3846002)(6246003)(54906003)(14454004)(476003)(110136005)(72206003)(186003)(305945005)(31686004)(25786009)(316002)(93886005)(256004)(229853002)(36756003)(5660300002)(2616005)(68736007)(53546011)(478600001)(102836004)(6512007)(386003)(6506007)(86362001)(97736004)(486006)(11346002)(26005)(31696002)(99286004)(4326008)(71190400001)(81156014)(76176011)(53936002)(446003)(7416002)(2906002)(52116002)(6486002)(8676002)(81166006)(6436002)(7736002)(71200400001)(66066001)(8936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2697;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RJ5GaxoT4G+ufhOB3HwI+iL5MBWNHTcP0Knw1fuH+MMIvmAbNhuPxv2ZxYlHQtKNRDgUlhzPQ+S1WR6oT93IcbTZAl3SniiYhfjfthX/0GwKjlHXPMx8NpdaCwAJlhDzgrdMH/ZJSa8rRNWtvw2esyHLm3I2yeIoAkjzgmKRHKEL6tAK+8qPwyteorsE+eWTFrEPYkAVH5QNK70uN+iP/TCNIUZsKrYq5CmjBWgH8oZcDr4lRZ2Aca3VGsoniEkn4HN+VuOdpVzyvwBIjbH215lV8HdSBcUVvJ4G2ELnU9XaqzimDjmlnQA+DFckTauuOVJICpMHiIVbRQF+ZNr+usghzbQXauZrJz/uS9eEFvTjnsJGLc3s+pFZsqEaMt1UIspdSzT45Orz2hPqMd1cdsaOe+XY9ow4Evxq60BAyNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B83771FD8D354F881AB7985764771E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f57348-86bd-4401-c31d-08d6c40025b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 13:17:03.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOC8xOSA1OjAxIEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIFdlZCwgQXBy
IDE3LCAyMDE5IGF0IDAyOjQwOjA5UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6DQo+PiBCYXNlZCBv
biB0aGUgYWJvdmUgZGVzY3JpcHRpb24sIGkgbWFkZSBhIGRyYWZ0IHBhdGNoLCBwbGVhc2UgcmVm
ZXIgdG8gaXQuIEJ1dCBpdA0KPj4gc2VlbXMgdGhhdCB0aGUgY29kZSBoYXMgYmVlbiBjaGFuZ2Vk
IGEgbG90Lg0KPiANCj4gSXQgZ29lcyBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uLiBIZXJlIGlzIGEg
dmVyc2lvbiB3aGVyZSBJIGNvcnJlY3RlZCBzb21lDQo+IHRoaW5nczoNCj4gDQo+IC0tLQ0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vaW9yZW1hcC5jIGIvYXJjaC94ODYvbW0vaW9yZW1hcC5j
DQo+IGluZGV4IGRkNzNkNWQ3NDM5My4uMGMxMzkyZTc2YjdkIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9tbS9pb3JlbWFwLmMNCj4gKysrIGIvYXJjaC94ODYvbW0vaW9yZW1hcC5jDQo+IEBAIC0y
Nyw5ICsyNyw4IEBADQo+ICANCj4gICNpbmNsdWRlICJwaHlzYWRkci5oIg0KPiAgDQo+IC1zdHJ1
Y3QgaW9yZW1hcF9tZW1fZmxhZ3Mgew0KPiAtCWJvb2wgc3lzdGVtX3JhbTsNCj4gLQlib29sIGRl
c2Nfb3RoZXI7DQo+ICtzdHJ1Y3QgaW9yZW1hcF9kZXNjIHsNCj4gKwl1NjQgZmxhZ3M7DQoNCllv
dSBjb3VsZCBwcm9iYWJseSBtYWtlIHRoaXMgdW5zaWduZWQgaW50IGZvciBub3cgc2luY2UgeW91
J3JlIGNyZWF0aW5nDQp0aGUgbmV3IGVudW0gdXNlZCB0byBhc3NpZ24gdG8gdGhpcyB2YXJpYWJs
ZSBhbmQgaXQgb25seSB1c2VzIHR3byBiaXRzDQpjdXJyZW50bHkuDQoNCj4gIH07DQo+ICANCj4g
IC8qDQo+IEBAIC02MSwxMyArNjAsMTMgQEAgaW50IGlvcmVtYXBfY2hhbmdlX2F0dHIodW5zaWdu
ZWQgbG9uZyB2YWRkciwgdW5zaWduZWQgbG9uZyBzaXplLA0KPiAgCXJldHVybiBlcnI7DQo+ICB9
DQo+ICANCj4gLXN0YXRpYyBib29sIF9faW9yZW1hcF9jaGVja19yYW0oc3RydWN0IHJlc291cmNl
ICpyZXMpDQo+ICtzdGF0aWMgdTY0IF9faW9yZW1hcF9jaGVja19yYW0oc3RydWN0IHJlc291cmNl
ICpyZXMpDQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHN0b3BfcGZuOw0KPiAg
CXVuc2lnbmVkIGxvbmcgaTsNCj4gIA0KPiAgCWlmICgocmVzLT5mbGFncyAmIElPUkVTT1VSQ0Vf
U1lTVEVNX1JBTSkgIT0gSU9SRVNPVVJDRV9TWVNURU1fUkFNKQ0KPiAtCQlyZXR1cm4gZmFsc2U7
DQo+ICsJCXJldHVybiAwOw0KPiAgDQo+ICAJc3RhcnRfcGZuID0gKHJlcy0+c3RhcnQgKyBQQUdF
X1NJWkUgLSAxKSA+PiBQQUdFX1NISUZUOw0KPiAgCXN0b3BfcGZuID0gKHJlcy0+ZW5kICsgMSkg
Pj4gUEFHRV9TSElGVDsNCj4gQEAgLTc1LDI4ICs3NCwzOSBAQCBzdGF0aWMgYm9vbCBfX2lvcmVt
YXBfY2hlY2tfcmFtKHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiAgCQlmb3IgKGkgPSAwOyBpIDwg
KHN0b3BfcGZuIC0gc3RhcnRfcGZuKTsgKytpKQ0KPiAgCQkJaWYgKHBmbl92YWxpZChzdGFydF9w
Zm4gKyBpKSAmJg0KPiAgCQkJICAgICFQYWdlUmVzZXJ2ZWQocGZuX3RvX3BhZ2Uoc3RhcnRfcGZu
ICsgaSkpKQ0KPiAtCQkJCXJldHVybiB0cnVlOw0KPiArCQkJCXJldHVybiBJT1JFU19NQVBfU1lT
VEVNX1JBTTsNCj4gIAl9DQo+ICANCj4gLQlyZXR1cm4gZmFsc2U7DQo+ICsJcmV0dXJuIDA7DQo+
ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgX19pb3JlbWFwX2NoZWNrX2Rlc2Nfb3RoZXIoc3RydWN0
IHJlc291cmNlICpyZXMpDQo+ICsvKg0KPiArICogTk9ORSBhbmQgUkVTRVJWRUQgc2hvdWxkIG5v
dCBiZSBtYXBwZWQgZW5jcnlwdGVkIGluIFNFViBiZWNhdXNlIHRoZXJlDQo+ICsgKiB0aGUgd2hv
bGUgbWVtb3J5IGlzIGFscmVhZHkgZW5jcnlwdGVkLg0KPiArICovDQo+ICtzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBfX2lvcmVtYXBfY2hlY2tfZGVzYyhzdHJ1Y3QgcmVzb3VyY2UgKnJlcykNCg0KSWYg
eW91IGRvbid0IG1ha2UgdGhlIGNoYW5nZSB0byB1bnNpZ25lZCBpbnQsIHRoZW4gdGhpcyBzaG91
bGQgYmUgYSB1NjQNCnJldHVybiB0byBtYXRjaCB0aGUgdGhlIGZsYWdzIGRlZmluaXRpb24gYW5k
IHRoZSBvdGhlciBmdW5jdGlvbi4NCg0KPiAgew0KPiAtCXJldHVybiAocmVzLT5kZXNjICE9IElP
UkVTX0RFU0NfTk9ORSk7DQo+ICsJaWYgKCFzZXZfYWN0aXZlKCkpDQo+ICsJCXJldHVybiAwOw0K
PiArDQo+ICsJaWYgKHJlcy0+ZGVzYyAmIChJT1JFU19ERVNDX05PTkUgfCBJT1JFU19ERVNDX1JF
U0VSVkVEKSkNCj4gKwkJcmV0dXJuIDA7DQoNClRoZSBJT1JFU19ERVNDX3h4eHggZW51bXMgYXJl
IG5vdCBiaXRzLCBqdXN0IHNlcXVlbnRpYWwgbnVtYmVycywgc28geW91DQp3b24ndCBiZSBhYmxl
IHRvIHRlc3QgdGhlbSB0aGlzIHdheS4gIFlvdSBjYW4gcHJvYmFibHkgZ2V0IGF3YXkgd2l0aCBh
DQpzd2l0Y2ggc3RhdGVtZW50IGhlcmUuDQoNClRoYW5rcywNClRvbQ0KDQo+ICsNCj4gKwlyZXR1
cm4gSU9SRVNfTUFQX0VOQ1JZUFRFRDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBfX2lvcmVt
YXBfcmVzX2NoZWNrKHN0cnVjdCByZXNvdXJjZSAqcmVzLCB2b2lkICphcmcpDQo+ICB7DQo+IC0J
c3RydWN0IGlvcmVtYXBfbWVtX2ZsYWdzICpmbGFncyA9IGFyZzsNCj4gKwlzdHJ1Y3QgaW9yZW1h
cF9kZXNjICpkZXNjID0gYXJnOw0KPiAgDQo+IC0JaWYgKCFmbGFncy0+c3lzdGVtX3JhbSkNCj4g
LQkJZmxhZ3MtPnN5c3RlbV9yYW0gPSBfX2lvcmVtYXBfY2hlY2tfcmFtKHJlcyk7DQo+ICsJaWYg
KCEoZGVzYy0+ZmxhZ3MgJiBJT1JFU19NQVBfU1lTVEVNX1JBTSkpDQo+ICsJCWRlc2MtPmZsYWdz
IHw9IF9faW9yZW1hcF9jaGVja19yYW0ocmVzKTsNCj4gIA0KPiAtCWlmICghZmxhZ3MtPmRlc2Nf
b3RoZXIpDQo+IC0JCWZsYWdzLT5kZXNjX290aGVyID0gX19pb3JlbWFwX2NoZWNrX2Rlc2Nfb3Ro
ZXIocmVzKTsNCj4gKwlpZiAoIShkZXNjLT5mbGFncyAmIElPUkVTX01BUF9FTkNSWVBURUQpKQ0K
PiArCQlkZXNjLT5mbGFncyB8PSBfX2lvcmVtYXBfY2hlY2tfZGVzYyhyZXMpOw0KPiAgDQo+IC0J
cmV0dXJuIGZsYWdzLT5zeXN0ZW1fcmFtICYmIGZsYWdzLT5kZXNjX290aGVyOw0KPiArCXJldHVy
biAoKGRlc2MtPmZsYWdzICYgKElPUkVTX01BUF9TWVNURU1fUkFNIHwgSU9SRVNfTUFQX0VOQ1JZ
UFRFRCkpID09DQo+ICsJCQkgICAgICAgKElPUkVTX01BUF9TWVNURU1fUkFNIHwgSU9SRVNfTUFQ
X0VOQ1JZUFRFRCkpOw0KPiAgfQ0KPiAgDQo+ICAvKg0KPiBAQCAtMTA1LDEzICsxMTUsMTMgQEAg
c3RhdGljIGludCBfX2lvcmVtYXBfcmVzX2NoZWNrKHN0cnVjdCByZXNvdXJjZSAqcmVzLCB2b2lk
ICphcmcpDQo+ICAgKiByZXNvdXJjZSBkZXNjcmliZWQgbm90IGFzIElPUkVTX0RFU0NfTk9ORSAo
ZS5nLiBJT1JFU19ERVNDX0FDUElfVEFCTEVTKS4NCj4gICAqLw0KPiAgc3RhdGljIHZvaWQgX19p
b3JlbWFwX2NoZWNrX21lbShyZXNvdXJjZV9zaXplX3QgYWRkciwgdW5zaWduZWQgbG9uZyBzaXpl
LA0KPiAtCQkJCXN0cnVjdCBpb3JlbWFwX21lbV9mbGFncyAqZmxhZ3MpDQo+ICsJCQkJc3RydWN0
IGlvcmVtYXBfZGVzYyAqZGVzYykNCj4gIHsNCj4gIAl1NjQgc3RhcnQsIGVuZDsNCj4gIA0KPiAg
CXN0YXJ0ID0gKHU2NClhZGRyOw0KPiAgCWVuZCA9IHN0YXJ0ICsgc2l6ZSAtIDE7DQo+IC0JbWVt
c2V0KGZsYWdzLCAwLCBzaXplb2YoKmZsYWdzKSk7DQo+ICsJbWVtc2V0KGRlc2MsIDAsIHNpemVv
ZihzdHJ1Y3QgaW9yZW1hcF9kZXNjKSk7DQo+ICANCj4gIAl3YWxrX21lbV9yZXMoc3RhcnQsIGVu
ZCwgZmxhZ3MsIF9faW9yZW1hcF9yZXNfY2hlY2spOw0KPiAgfQ0KPiBAQCAtMTM4LDcgKzE0OCw3
IEBAIHN0YXRpYyB2b2lkIF9faW9tZW0gKl9faW9yZW1hcF9jYWxsZXIocmVzb3VyY2Vfc2l6ZV90
IHBoeXNfYWRkciwNCj4gIAlyZXNvdXJjZV9zaXplX3QgbGFzdF9hZGRyOw0KPiAgCWNvbnN0IHJl
c291cmNlX3NpemVfdCB1bmFsaWduZWRfcGh5c19hZGRyID0gcGh5c19hZGRyOw0KPiAgCWNvbnN0
IHVuc2lnbmVkIGxvbmcgdW5hbGlnbmVkX3NpemUgPSBzaXplOw0KPiAtCXN0cnVjdCBpb3JlbWFw
X21lbV9mbGFncyBtZW1fZmxhZ3M7DQo+ICsJc3RydWN0IGlvcmVtYXBfZGVzYyBpb19kZXNjOw0K
PiAgCXN0cnVjdCB2bV9zdHJ1Y3QgKmFyZWE7DQo+ICAJZW51bSBwYWdlX2NhY2hlX21vZGUgbmV3
X3BjbTsNCj4gIAlwZ3Byb3RfdCBwcm90Ow0KPiBAQCAtMTU3LDEyICsxNjcsMTIgQEAgc3RhdGlj
IHZvaWQgX19pb21lbSAqX19pb3JlbWFwX2NhbGxlcihyZXNvdXJjZV9zaXplX3QgcGh5c19hZGRy
LA0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIAl9DQo+ICANCj4gLQlfX2lvcmVtYXBfY2hlY2tfbWVt
KHBoeXNfYWRkciwgc2l6ZSwgJm1lbV9mbGFncyk7DQo+ICsJX19pb3JlbWFwX2NoZWNrX21lbShw
aHlzX2FkZHIsIHNpemUsICZpb19kZXNjKTsNCj4gIA0KPiAgCS8qDQo+ICAJICogRG9uJ3QgYWxs
b3cgYW55Ym9keSB0byByZW1hcCBub3JtYWwgUkFNIHRoYXQgd2UncmUgdXNpbmcuLg0KPiAgCSAq
Lw0KPiAtCWlmIChtZW1fZmxhZ3Muc3lzdGVtX3JhbSkgew0KPiArCWlmIChpb19kZXNjLmZsYWdz
ICYgSU9SRVNfTUFQX1NZU1RFTV9SQU0pIHsNCj4gIAkJV0FSTl9PTkNFKDEsICJpb3JlbWFwIG9u
IFJBTSBhdCAlcGEgLSAlcGFcbiIsDQo+ICAJCQkgICZwaHlzX2FkZHIsICZsYXN0X2FkZHIpOw0K
PiAgCQlyZXR1cm4gTlVMTDsNCj4gQEAgLTIwMCw3ICsyMTAsNyBAQCBzdGF0aWMgdm9pZCBfX2lv
bWVtICpfX2lvcmVtYXBfY2FsbGVyKHJlc291cmNlX3NpemVfdCBwaHlzX2FkZHIsDQo+ICAJICog
cmVzdWx0aW5nIG1hcHBpbmcuDQo+ICAJICovDQo+ICAJcHJvdCA9IFBBR0VfS0VSTkVMX0lPOw0K
PiAtCWlmICgoc2V2X2FjdGl2ZSgpICYmIG1lbV9mbGFncy5kZXNjX290aGVyKSB8fCBlbmNyeXB0
ZWQpDQo+ICsJaWYgKChpb19kZXNjLmZsYWdzICYgSU9SRVNfTUFQX0VOQ1JZUFRFRCkgfHwgZW5j
cnlwdGVkKQ0KPiAgCQlwcm90ID0gcGdwcm90X2VuY3J5cHRlZChwcm90KTsNCj4gIA0KPiAgCXN3
aXRjaCAocGNtKSB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvcG9ydC5oIGIvaW5j
bHVkZS9saW51eC9pb3BvcnQuaA0KPiBpbmRleCBkYTBlYmFlYzI1ZjAuLjJhNWUwZjFkZWQ5MyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb3BvcnQuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L2lvcG9ydC5oDQo+IEBAIC0xMiw2ICsxMiw3IEBADQo+ICAjaWZuZGVmIF9fQVNTRU1CTFlf
Xw0KPiAgI2luY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvdHlw
ZXMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRzLmg+DQo+ICAvKg0KPiAgICogUmVzb3VyY2Vz
IGFyZSB0cmVlLWxpa2UsIGFsbG93aW5nDQo+ICAgKiBuZXN0aW5nIGV0Yy4uDQo+IEBAIC0xMzUs
NiArMTM2LDE0IEBAIGVudW0gew0KPiAgCUlPUkVTX0RFU0NfREVWSUNFX1BVQkxJQ19NRU1PUlkJ
CT0gNywNCj4gIH07DQo+ICANCj4gKy8qDQo+ICsgKiBGbGFncyBjb250cm9sbGluZyBpb3JlbWFw
KCkgYmVoYXZpb3IuDQo+ICsgKi8NCj4gK2VudW0gew0KPiArCUlPUkVTX01BUF9TWVNURU1fUkFN
CT0gQklUKDApLA0KPiArCUlPUkVTX01BUF9FTkNSWVBURUQJPSBCSVQoMSksDQo+ICt9Ow0KPiAr
DQo+ICAvKiBoZWxwZXJzIHRvIGRlZmluZSByZXNvdXJjZXMgKi8NCj4gICNkZWZpbmUgREVGSU5F
X1JFU19OQU1FRChfc3RhcnQsIF9zaXplLCBfbmFtZSwgX2ZsYWdzKQkJCVwNCj4gIAl7CQkJCQkJ
CQlcDQo+IA0K
