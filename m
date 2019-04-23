Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC2C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483702175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wD4juUgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfDWMgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:36:11 -0400
Received: from mail-eopbgr720083.outbound.protection.outlook.com ([40.107.72.83]:24032
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbfDWMgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6dYOrpM1KCsXTylNQuXvoR/aO0DmUmTP/2rD+p34w4=;
 b=wD4juUgjhjkYSHccE8mOxZfTQBEfYCiilGDLhG0BEvD5Km5yc6mzdNcx1O2E0e9web9a2D8+O7hVthmKAgAVMM0TMmYM+5WgyZngvt1uNzCs/B9OEjrvGpgUBlMDd2Lq2E9XhWbE/uRtLnBVjwumZFyDkRKAlAc9vJGYm6lSM7Q=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1548.namprd12.prod.outlook.com (10.172.37.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 12:36:04 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1813.017; Tue, 23 Apr
 2019 12:36:04 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Vadim V . Vlasov" <vadim.vlasov@t-platforms.ru>
Subject: Re: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Thread-Topic: [PATCH] drm: Permit video-buffers writecombine mapping for MIPS
Thread-Index: AQHU+dChEKiJLSyrBEq8lIyweClEMKZJro0A
Date:   Tue, 23 Apr 2019 12:36:04 +0000
Message-ID: <bc89382c-a2cc-c17a-8bc6-54685f1ce726@amd.com>
References: <20190423123122.32573-1-fancer.lancer@gmail.com>
In-Reply-To: <20190423123122.32573-1-fancer.lancer@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:209:15::32) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad036752-cae8-4c6e-e64d-08d6c7e83fd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1548;
x-ms-traffictypediagnostic: DM5PR12MB1548:
x-microsoft-antispam-prvs: <DM5PR12MB1548302E77DDE74B009A785C83230@DM5PR12MB1548.namprd12.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(6246003)(5660300002)(31686004)(68736007)(66574012)(6512007)(110136005)(58126008)(52116002)(46003)(2906002)(76176011)(386003)(486006)(476003)(2616005)(11346002)(446003)(478600001)(186003)(72206003)(102836004)(6506007)(6636002)(53936002)(54906003)(14454004)(8936002)(36756003)(31696002)(8676002)(229853002)(81156014)(6116002)(7736002)(64126003)(316002)(305945005)(86362001)(81166006)(97736004)(14444005)(99286004)(71200400001)(71190400001)(4326008)(25786009)(6486002)(7416002)(65806001)(6436002)(73956011)(256004)(66946007)(65826007)(65956001)(66446008)(66556008)(64756008)(66476007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1548;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kK3RYLCrf213vmj1Yt9b4DHZiFVEyw/ShJAkZ0KlQxSQTN0fv52m0W8ahFt5zYb9xxulBil7mJNacwdFtwT6XhcQQSqbu+xZhmy4ssReTwNn7yD5I4VN5NEmj873hv0RTx8rkp0DgA1seowj7aoJauW12UNzrvqUxPI/tjvIph2sMn48leSfwWis0EBhbaVw/HFpWbRk/iPiYyYlAUWJ2fIfmELrjGMCx4pwMX/uohJuVrdpS4mCRmrZPnEUaJF5/+s1iKD8ruB3TuayatXxcGASuFu1Z+OrcOc9L46j9XEPjLCiQdXrV+lzPan5Qk2TxmKUgJuAiHMFBAVMwe0XxhjgMw6ORYphOUUw9CK1Aq42OoWDLbWZwsyRtD8S+n9sTIHNETZCtyD+jsf/VPzmRgnXnOU15RX0Oi4/YY7jBhI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03BD4A253FAA65449EA1059CEDCE9597@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad036752-cae8-4c6e-e64d-08d6c7e83fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 12:36:04.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjMuMDQuMTkgdW0gMTQ6MzEgc2NocmllYiBTZXJnZSBTZW1pbjoNCj4gU2luY2UgY29tbWl0
IDRiMDUwYmE3YTY2YyAoIk1JUFM6IHBndGFibGUuaDogSW1wbGVtZW50IHRoZQ0KPiBwZ3Byb3Rf
d3JpdGVjb21iaW5lIGZ1bmN0aW9uIGZvciBNSVBTIikgYW5kIGNvbW1pdCBjNDY4N2IxNWE4NDgg
KCJNSVBTOiBGaXgNCj4gZGVmaW5pdGlvbiBvZiBwZ3Byb3Rfd3JpdGVjb21iaW5lKCkiKSB3cml0
ZS1jb21iaW5lIHZtYSBtYXBwaW5nIGlzDQo+IGF2YWlsYWJsZSB0byBiZSB1c2VkIGJ5IGtlcm5l
bCBzdWJzeXN0ZW1zIGZvciBNSVBTLiBJbiBwYXJ0aWN1bGFyIHRoZQ0KPiB1bmNhY2hlZCBhY2Nl
bGVyYXRlZCBhdHRyaWJ1dGUgaXMgcmVxdWVzdGVkIHRvIGJlIHNldCBieSBpb3JlbWFwX3djKCkN
Cj4gbWV0aG9kIGFuZCBieSBnZW5lcmljIFBDSSBtZW1vcnkgcGFnZXMvcmFuZ2VzIG1hcHBpbmcg
bWV0aG9kcy4gVGhlIHNhbWUNCj4gaXMgZG9uZSBieSB0aGUgZHJtX2lvX3Byb3QoKS90dG1faW9f
cHJvdCgpIGZ1bmN0aW9ucyBpbiBjYXNlIGlmDQo+IHdyaXRlLWNvbWJpbmUgZmxhZyBpcyBzZXQg
Zm9yIHZtYSdzIHBhc3NlZCBmb3IgbWFwcGluZy4gQnV0IGZvciBzb21lDQo+IHJlYXNvbiB0aGUg
cGdwcm90X3dyaXRlY29tYmluZSgpIG1ldGhvZCBjYWxsaW5nIGlzIGlmZGVmZWQgdG8gYmUgYQ0K
PiBwbGF0Zm9ybS1zcGVjaWZpYyB3aXRoIE1JUFMgc3lzdGVtIGJlaW5nIG1hcmtlZCBhcyBsYWNr
aW5nIG9mIG9uZS4gQXQgdGhlDQo+IHZlcnkgbGVhc3QgaXQgZG9lc24ndCByZWZsZWN0IHRoZSBj
dXJyZW50IE1JUFMgcGxhdGZvcm0gaW1wbGVtZW50YXRpb24uDQo+IFNvIGluIG9yZGVyIHRvIGlt
cHJvdmUgdGhlIERSTSBzdWJzeXN0ZW0gcGVyZm9ybWFuY2Ugb24gTUlQUyB3aXRoIFVDQQ0KPiBt
YXBwaW5nIGVuYWJsZWQsIHdlIG5lZWQgdG8gaGF2ZSBwZ3Byb3Rfd3JpdGVjb21iaW5lKCkgY2Fs
bGVkIGZvciBidWZmZXJzLA0KPiB3aGljaCBuZWVkIHN0b3JlIG9wZXJhdGlvbnMgYmVpbmcgY29t
YmluZWQuIEluIGNhc2UgaWYgcGFydGljdWxhciBNSVBTDQo+IGNoaXAgZG9lc24ndCBzdXBwb3J0
IHRoZSBVQ0EgYXR0cmlidXRlLCB0aGUgbWFwcGluZyB3aWxsIGZhbGwgYmFjayB0bw0KPiBub25j
YWNoZWQuDQo+DQo+IENjOiBSYWxmIEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+DQo+IENj
OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlwcy5jb20+DQo+IENjOiBKYW1lcyBIb2dhbiA8
amhvZ2FuQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFZhZGltIFYuIFZsYXNvdiA8dmFk
aW0udmxhc292QHQtcGxhdGZvcm1zLnJ1Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnZSBTZW1pbiA8
ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQoNCk5vdCBzdXJlIGFib3V0IGFsbCB0aGUgZGV0YWls
cywgYnV0IGF0IGxlYXN0IGZyb20gdGhlIHR3byBtaWxlIGhpZ2ggdmlldyANCnRoYXQgc2VlbXMg
dG8gbWFrZSBzZW5zZS4NCg0KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX3ZtLmMgICAg
ICAgICAgfCA1ICsrKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jIHwg
NCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3ZtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vZHJtX3ZtLmMNCj4gaW5kZXggYzMzMDEwNDZkZmFhLi41MDE3OGRjNjQwNjAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdm0uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vZHJtX3ZtLmMNCj4gQEAgLTYyLDcgKzYyLDggQEAgc3RhdGljIHBncHJvdF90IGRybV9p
b19wcm90KHN0cnVjdCBkcm1fbG9jYWxfbWFwICptYXAsDQo+ICAgCS8qIFdlIGRvbid0IHdhbnQg
Z3JhcGhpY3MgbWVtb3J5IHRvIGJlIG1hcHBlZCBlbmNyeXB0ZWQgKi8NCj4gICAJdG1wID0gcGdw
cm90X2RlY3J5cHRlZCh0bXApOw0KPiAgIA0KPiAtI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRl
ZmluZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX3Bvd2VycGNfXykNCj4gKyNpZiBkZWZpbmVk
KF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19wb3dlcnBjX18p
IHx8IFwNCj4gKyAgICBkZWZpbmVkKF9fbWlwc19fKQ0KPiAgIAlpZiAobWFwLT50eXBlID09IF9E
Uk1fUkVHSVNURVJTICYmICEobWFwLT5mbGFncyAmIF9EUk1fV1JJVEVfQ09NQklOSU5HKSkNCj4g
ICAJCXRtcCA9IHBncHJvdF9ub25jYWNoZWQodG1wKTsNCj4gICAJZWxzZQ0KPiBAQCAtNzMsNyAr
NzQsNyBAQCBzdGF0aWMgcGdwcm90X3QgZHJtX2lvX3Byb3Qoc3RydWN0IGRybV9sb2NhbF9tYXAg
Km1hcCwNCj4gICAJCXRtcCA9IHBncHJvdF93cml0ZWNvbWJpbmUodG1wKTsNCj4gICAJZWxzZQ0K
PiAgIAkJdG1wID0gcGdwcm90X25vbmNhY2hlZCh0bXApOw0KPiAtI2VsaWYgZGVmaW5lZChfX3Nw
YXJjX18pIHx8IGRlZmluZWQoX19hcm1fXykgfHwgZGVmaW5lZChfX21pcHNfXykNCj4gKyNlbGlm
IGRlZmluZWQoX19zcGFyY19fKSB8fCBkZWZpbmVkKF9fYXJtX18pDQo+ICAgCXRtcCA9IHBncHJv
dF9ub25jYWNoZWQodG1wKTsNCj4gICAjZW5kaWYNCj4gICAJcmV0dXJuIHRtcDsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX2JvX3V0aWwuYw0KPiBpbmRleCA4OTVkNzdkNzk5ZTQuLjlmOTE4Yjk5MmY3ZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYw0KPiBAQCAtNTM5LDEzICs1MzksMTMg
QEAgcGdwcm90X3QgdHRtX2lvX3Byb3QodWludDMyX3QgY2FjaGluZ19mbGFncywgcGdwcm90X3Qg
dG1wKQ0KPiAgIAkJdG1wID0gcGdwcm90X25vbmNhY2hlZCh0bXApOw0KPiAgICNlbmRpZg0KPiAg
ICNpZiBkZWZpbmVkKF9faWE2NF9fKSB8fCBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX19h
YXJjaDY0X18pIHx8IFwNCj4gLSAgICBkZWZpbmVkKF9fcG93ZXJwY19fKQ0KPiArICAgIGRlZmlu
ZWQoX19wb3dlcnBjX18pIHx8IGRlZmluZWQoX19taXBzX18pDQo+ICAgCWlmIChjYWNoaW5nX2Zs
YWdzICYgVFRNX1BMX0ZMQUdfV0MpDQo+ICAgCQl0bXAgPSBwZ3Byb3Rfd3JpdGVjb21iaW5lKHRt
cCk7DQo+ICAgCWVsc2UNCj4gICAJCXRtcCA9IHBncHJvdF9ub25jYWNoZWQodG1wKTsNCj4gICAj
ZW5kaWYNCj4gLSNpZiBkZWZpbmVkKF9fc3BhcmNfXykgfHwgZGVmaW5lZChfX21pcHNfXykNCj4g
KyNpZiBkZWZpbmVkKF9fc3BhcmNfXykNCj4gICAJdG1wID0gcGdwcm90X25vbmNhY2hlZCh0bXAp
Ow0KPiAgICNlbmRpZg0KPiAgIAlyZXR1cm4gdG1wOw0KDQo=
