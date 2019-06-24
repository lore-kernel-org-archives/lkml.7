Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47620C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F96720645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q33CpKJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfFXRna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:43:30 -0400
Received: from mail-eopbgr810050.outbound.protection.outlook.com ([40.107.81.50]:61920
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbfFXRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKOrHB6hoLwxQAGqq9dyuNjyW3+XKqaRQrmHBJj7FXc=;
 b=q33CpKJAug3UmStp4ijH6AKGc+4f00iI6CQ3JHtUe6HvAFwVV/KgISn3ZrwU9Gl1ueRoRWdQ9ptEPCd5AUJltf7XlSpY+1qwO7xdYcuPW68tfWTP9E6iUHIsOfr/55kQqKFp0sp3aSyR4soK5/w4PWaIpmBg9Lh8yCSOu0UFei0=
Received: from CH2PR12MB3831.namprd12.prod.outlook.com (52.132.245.141) by
 CH2PR12MB3783.namprd12.prod.outlook.com (52.132.245.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 17:42:47 +0000
Received: from CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::3459:726f:43e7:a64c]) by CH2PR12MB3831.namprd12.prod.outlook.com
 ([fe80::3459:726f:43e7:a64c%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 17:42:47 +0000
From:   "Kim, Jonathan" <Jonathan.Kim@amd.com>
To:     Mao Wenan <maowenan@huawei.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Thread-Topic: [PATCH -next v4] drm/amdgpu: return 'ret' immediately if failed
 in amdgpu_pmu_init
Thread-Index: AQHVKn5JEKVMvtxkwUKFh6TNDZEkvaarEYog
Date:   Mon, 24 Jun 2019 17:42:46 +0000
Message-ID: <CH2PR12MB3831BE36FF61D74FC529F64F85E00@CH2PR12MB3831.namprd12.prod.outlook.com>
References: <20190624094850.GQ18776@kadam>
 <20190624112318.149299-1-maowenan@huawei.com>
In-Reply-To: <20190624112318.149299-1-maowenan@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d477039-84db-4fd8-7c54-08d6f8cb5eb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR12MB3783;
x-ms-traffictypediagnostic: CH2PR12MB3783:
x-microsoft-antispam-prvs: <CH2PR12MB3783E513C00516C73437131785E00@CH2PR12MB3783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(13464003)(199004)(189003)(54906003)(110136005)(76176011)(6506007)(8936002)(7696005)(25786009)(476003)(7736002)(71190400001)(72206003)(33656002)(86362001)(256004)(71200400001)(446003)(486006)(53936002)(305945005)(478600001)(4326008)(2906002)(52536014)(14444005)(74316002)(2501003)(68736007)(9686003)(102836004)(229853002)(316002)(55016002)(6246003)(6436002)(53546011)(66446008)(73956011)(81156014)(64756008)(14454004)(76116006)(99286004)(6116002)(3846002)(66556008)(5660300002)(81166006)(2201001)(66946007)(66476007)(186003)(8676002)(66066001)(11346002)(26005)(14773001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB3783;H:CH2PR12MB3831.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mWAFPdEHvjBJauKAcHgTXKzXyvI1wqW+sUSDQYD77Oa16+Mk4YU2Msn7TYVFm7VF+nOet8Cwjk2JeHGfjkEp5CGp7mVk8JVTuVPlkufDTiz6Je+We3laG0amw4npi7L046tjplp4AsEXgWpBPqL7cxxqDpk0ojuSYQEemB2I+Dk3pgDjufptEtI3MuCamnfXhvdzNAxPW/ULbKKhXHLby4jkjYaMebfsbkw4TGOBo3diyyZYo/6UQ4QaVgQqE28eVsFvbVnxB4YxEYYNl6R0+00EoTxuLx+3B8w6Unk4Y7CAwyG9CKCZfpio7HP2su+23cxngPisqpI+mfJ8nPl9DnYT6d83KtWB+5rJUhF7/BgcGXgcdjjIycAL1nxeyeOmvE+LW+8MZZmHBEP4t9KUeLSuDtJfZ24Yl678XPbYIeI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d477039-84db-4fd8-7c54-08d6f8cb5eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 17:42:46.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jokim@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW1tZWRpYXRlIHJldHVybiBzaG91bGQgYmUgb2sgc2luY2UgcGVyZiByZWdpc3RyYXRpb24gaXNu
J3QgZGVwZW5kZW50IG9uIGdwdSBody4NCg0KUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIEtpbSA8Sm9u
YXRoYW4uS2ltQGFtZC5jb20+DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBN
YW8gV2VuYW4gPG1hb3dlbmFuQGh1YXdlaS5jb20+IA0KU2VudDogTW9uZGF5LCBKdW5lIDI0LCAy
MDE5IDc6MjMgQU0NClRvOiBhaXJsaWVkQGxpbnV4LmllOyBkYW5pZWxAZmZ3bGwuY2g7IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykgPERh
dmlkMS5aaG91QGFtZC5jb20+OyBkYW4uY2FycGVudGVyQG9yYWNsZS5jb207IGp1bGlhLmxhd2Fs
bEBsaXA2LmZyDQpDYzoga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEtpbSwg
Sm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgTWFvIFdlbmFuIDxtYW93ZW5hbkBodWF3
ZWkuY29tPg0KU3ViamVjdDogW1BBVENIIC1uZXh0IHY0XSBkcm0vYW1kZ3B1OiByZXR1cm4gJ3Jl
dCcgaW1tZWRpYXRlbHkgaWYgZmFpbGVkIGluIGFtZGdwdV9wbXVfaW5pdA0KDQpbQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWxdDQoNClRoZXJlIGlzIG9uZSB3YXJuaW5nOg0KZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BtdS5jOiBJbiBmdW5jdGlvbiDigJhhbWRncHVfcG11X2luaXTi
gJk6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG11LmM6MjQ5OjY6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmHJldOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0
LXZhcmlhYmxlXQ0KICBpbnQgcmV0ID0gMDsNCiAgICAgIF4NCmFtZGdwdV9wbXVfaW5pdCgpIGlz
IGNhbGxlZCBieSBhbWRncHVfZGV2aWNlX2luaXQoKSBpbiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMsDQp3aGljaCB3aWxsIHVzZSB0aGUgcmV0dXJuIHZhbHVlLiBT
byBpdCBzaG91bGQgcmV0dXJuICdyZXQnIGltbWVkaWF0ZWx5IGlmIGluaXRfcG11X2J5X3R5cGUo
KSBmYWlsZWQuDQphbWRncHVfZGV2aWNlX2luaXQoKQ0KICAgICAgICByID0gYW1kZ3B1X3BtdV9p
bml0KGFkZXYpOw0KDQpGaXhlczogOWM3Yzg1ZjdlYTFmICgiZHJtL2FtZGdwdTogYWRkIHBtdSBj
b3VudGVycyIpDQoNClNpZ25lZC1vZmYtYnk6IE1hbyBXZW5hbiA8bWFvd2VuYW5AaHVhd2VpLmNv
bT4NCi0tLQ0KIHYxLT52MjogY2hhbmdlIHRoZSBzdWJqZWN0IGZvciB0aGlzIHBhdGNoOyBjaGFu
Z2UgdGhlIGluZGVudGluZyB3aGVuIGl0IGNhbGxzIGluaXRfcG11X2J5X3R5cGU7IHVzZSB0aGUg
dmFsdWUgJ3JldCcgaW4gIGFtZGdwdV9wbXVfaW5pdCgpLg0KIHYyLT52MzogY2hhbmdlIHRoZSBz
dWJqZWN0IGZvciB0aGlzIHBhdGNoOyByZXR1cm4gJ3JldCcgaW1tZWRpYXRlbHkgaWYgZmFpbGVk
IHRvIGNhbGwgaW5pdF9wbXVfYnlfdHlwZSgpLg0KIHYzLT52NDogZGVsZXRlIHRoZSBpbmRlbnRp
bmcgZm9yIGluaXRfcG11X2J5X3R5cGUoKSBhcmd1bWVudHMuIFRoZSBvcmlnaW5hbCBpbmRlbnRp
bmcgaXMgY29ycmVjdC4NCg0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbXUu
YyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG11LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG11LmMNCmluZGV4IDBlNmRiYTlmNjBmMC4uYzk4Y2Y3N2Ez
N2YzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtdS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG11LmMNCkBAIC0yNTQs
NiArMjU0LDggQEAgaW50IGFtZGdwdV9wbXVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikNCiAgICAgICAgICAgICAgICByZXQgPSBpbml0X3BtdV9ieV90eXBlKGFkZXYsIGRmX3YzXzZf
YXR0cl9ncm91cHMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiREYi
LCAiYW1kZ3B1X2RmIiwgUEVSRl9UWVBFX0FNREdQVV9ERiwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERGX1YzXzZfTUFYX0NPVU5URVJTKTsNCisgICAgICAgICAgICAg
ICBpZiAocmV0KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0KICAgICAg
ICAgICAgICAgIC8qIG90aGVyIHBtdSB0eXBlcyBnbyBoZXJlKi8NCiAgICAgICAgICAgICAgICBi
cmVhazsNCi0tDQoyLjIwLjENCg0K
