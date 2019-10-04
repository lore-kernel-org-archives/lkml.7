Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28149C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3DF21D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KOq60PJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfJDLan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:30:43 -0400
Received: from mail-eopbgr750054.outbound.protection.outlook.com ([40.107.75.54]:17820
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfJDLam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWtkYzQPazJMDxS8qwbIPw1L/HMrs8cNxMHVplec512uqLu6SeSYsYLdjsiY/SsHWHhUV1oNJW11fEsSx5dqD74JBfUlyu/jiraEr4KXAIINPWOvfbGf6h7uT/l91cMEttBkVyGQEnCUamSLEGSTv5neVrb2BXMFUBR7wSzwhjjZAgDVJ/jqLaZnkFlQUINgX2mrR582LGSjUxNx9V7SE3PBN18GkgZFzo0+HegzLBJCw7aIytii+Rky8BDdGDtRm4ANibNFAJmIsjMB1xUWlUYHR+3OKhKE3iHWZn9/g6gY0TcTTWlmeREdlb5fc64n/lO8Rr+0YmvN8mtuQx7zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5cqpylDFTjT6jQFZSQHjrd0ye2RN8hQIx1KZNekZV4=;
 b=NdsxclNCUzN3Xc9utnSt6YHdNn+7FOUnSWgexUfll7IwfKdQyttdU5EPvxclOjMJp2GRw9QKZTqCuylvQzUODyeMn6zt44Lmv753p+Wqvy+WAnLLU6Qk+zG4oP0m1amECbpIBtXZfRL9pT/T0PMjhhHcMIpNhqhZWbYWiPXm9d99MKIPPTRFgs5VZtX44IrClKqhBTD7ZcsDzYQjrog3vPWnomH9nMNC+1c75f+xe/tqz6ptOCpIAYE7i+ez24UQaY6rKYHCaHTRURWlFy8xrP8ZzFNOgZZbdv28J88K2/K79VuRuHUZPE+auu7+nJrYLPTTsMpSTlXwG8BwlHEyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5cqpylDFTjT6jQFZSQHjrd0ye2RN8hQIx1KZNekZV4=;
 b=KOq60PJqP3Ca7dWmDtLmWBB2oa1x+dyDRPTJJs3nYJzUCT0GDd0H5htfzvJoduyiABg/s80qNMEeoBoXCFyrWlWakzJqMtr7JPTBNclBc2cZRgKQPfauQT76V3/N4JkCv6+kGNop4OOje9/72GNuUOL183uTQAPaZCFF+7k9rec=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1868.namprd12.prod.outlook.com (10.175.85.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 11:30:39 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::7428:f6b3:a0b1:a02e%10]) with mapi id 15.20.2327.023; Fri, 4 Oct 2019
 11:30:38 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     "Das, Nirmoy" <Nirmoy.Das@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix memory leak
Thread-Topic: [PATCH] drm/amdgpu: fix memory leak
Thread-Index: AQHVepz+9tzYVi1V60uU+pu6QVo02qdKTAYAgAAEjYCAAAOrgIAAA5GAgAABO4A=
Date:   Fri, 4 Oct 2019 11:30:38 +0000
Message-ID: <fef8697b-30c4-e4e1-f45c-d3377dbd444e@amd.com>
References: <20191004101746.19574-1-nirmoy.das@amd.com>
 <62ea397d-2847-04d7-3c50-6292255845c5@amd.com>
 <32afa408-0968-2d1a-5add-593907636592@amd.com>
 <4d665d18-2109-675e-dd69-c15bd0b2a011@amd.com>
 <e79aa8f8-5198-bfd9-3f69-e7975bac3232@amd.com>
In-Reply-To: <e79aa8f8-5198-bfd9-3f69-e7975bac3232@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 435770e4-68bc-4bd2-6f2b-08d748be480e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR12MB1868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB186858A2F699A928470B3AB2839E0@DM5PR12MB1868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(65806001)(65956001)(6436002)(256004)(31686004)(14444005)(81166006)(81156014)(478600001)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(31696002)(2906002)(5660300002)(14454004)(36756003)(229853002)(6246003)(6486002)(25786009)(76176011)(58126008)(305945005)(6116002)(52116002)(99286004)(86362001)(486006)(386003)(6506007)(53546011)(71190400001)(71200400001)(46003)(54906003)(102836004)(2616005)(110136005)(476003)(6636002)(7736002)(316002)(446003)(6512007)(11346002)(186003)(4326008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1868;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwEnp2ekLzStubPsfI5KlROB5vodF2CgFAVZJdlCQPIl2y0qpGfMafc0uEhOG0jm8RJzBaqPEMaADgxzGYRXTHdmSFpLLEkY+seWQn2EDZPCdhunbaYdUFN5A4bahqWZIYq7K/cHYC8FX33a/3gyl/k7MvL0wjUagyS0T6twiyNIG74cwz5U2cuaTgV0oe4VIlLs045UObKnkv/N20M57zRSNYaCPXovM16R/ES6cObsINrs1YsX5SHnBocps+jlM7hx2reMkgOO6S7fcaVIwMkdV7sKhb9etsSP/hqX1q3KbfeFE9kQ6rPfuB7iKvIutarr1UIytagURfoFDs3k6U2QpssXVO7i+M84rrNU0o7f7fwyfshlyU6jbs5CVdhaeW3GuJLLZjxY25MzuYHh9PEvF6yhPqdm6a6lX1Sr/Dc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <289D53C2BBB0934D828510835D5F60CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435770e4-68bc-4bd2-6f2b-08d748be480e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 11:30:38.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2fTRr1JmBGpzJIsEJB2ijASKVGCzVOkh/BEIPqoG+E16fMAcOu8nvN3fNhd9bzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDQuMTAuMTkgdW0gMTM6MjYgc2NocmllYiBEYXMsIE5pcm1veToNCj4gT24gMTAvNC8xOSAx
OjEzIFBNLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+Pj4gTkFLLCB0aGF0IGlzIGEgZG91
YmxlIGZyZWUuIFRoZSBibyBsaXN0IGVudHJpZXMgYXJlIGZyZWVkIGJ5DQo+Pj4+IGFtZGdwdV9i
b19saXN0X3B1dCgpLg0KPj4+IFRoYW5rcywgZGlkbid0IHJlYWxpemUgdGhhdC4NCj4+IFdhaXQg
YSBzZWNvbmQsIHdoYXQgZW50cmllcyBhcmUgeW91IHRhbGtpbmcgYWJvdXQ/DQo+Pg0KPj4gVGhl
IGVudHJpZXMgaW4gdGhlIGxpc3Qgb2JqZWN0IGFyZSBmcmVlZCB3aGVuIGFtZGdwdV9ib19saXN0
X3B1dCgpIGlzDQo+PiBjYWxsZWQsIGJ1dCB0aGUgdGVtcG9yYXJ5IGluZm8gYXJyYXkgd2l0aCB0
aGUgaGFuZGxlcyBuZWVkcyB0byBiZSBmcmVlZA0KPj4gYXMgd2VsbC4NCj4+DQo+PiBBbmQgaXQg
bG9va3MgbGlrZSB0aGF0IGlzIGluZGVlZCBsZWFrZWQgaGVyZS4NCj4gSSBhbSB0YWxraW5nIGFi
b3V0IHRoZSBgaW5mb2AgYXJyYXkgY3JlYXRlZCBieQ0KPiBhbWRncHVfYm9fY3JlYXRlX2xpc3Rf
ZW50cnlfYXJyYXkoKS4NCg0KWWVhaCwgdGhhdCBhcmUgdGhlIGhhbmRsZXMgYW5kIG5vdCB0aGUg
ZW50cmllcy4gU29ycnkgdGhhdCBJIHdhcyANCmNvbmZ1c2VkIGFib3V0IHRoYXQuDQoNCllvdXIg
cGF0Y2ggaXMgY29ycmVjdCwgeW91IHNob3VsZCBqdXN0IHVwZGF0ZSB0aGUgY29tbWl0IG1lc3Nh
Z2UgYSBiaXQuDQoNCkJUVzogQ291bGQgeW91IGNsZWFudXAgZXJyb3IgaGFuZGxpbmcgaGVyZSBh
IGJpdCBtb3JlPw0KDQpFLmcuIGFkZCBhbiBlcnJvcl9wdXRfbGlzdCBoYW5kbGUgYW5kIGRyb3Ag
dGhlICJpZiAoaW5mbykiIGFuZCBpbnN0ZWFkIA0KcmV0dXJuIGRpcmVjdGx5IGlmIHdlIGZhaWwg
dG8gYWxsb2NhdGUgaW5mby4NCg0KVGhhbmtzLA0KQ2hyaXN0aWFuLg0KDQo+PiBSZWdhcmRzLA0K
Pj4gQ2hyaXN0aWFuLg0KPj4NCj4+Pj4gUmVnYXJkcywNCj4+Pj4gQ2hyaXN0aWFuLg0KPj4+IFJl
Z2FyZHMsDQo+Pj4NCj4+PiBOaXJtb3kNCj4+Pg0KPj4+Pj4gICAgICAgCQl9DQo+Pj4+PiAgICAg
ICANCj4+Pj4+ICAgICAgIAkJaGFuZGxlID0gcjsNCg0K
