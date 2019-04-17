Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E444C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4F820872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aJOptLGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfDQNwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:52:10 -0400
Received: from mail-eopbgr800077.outbound.protection.outlook.com ([40.107.80.77]:17312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729453AbfDQNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phI+wERMurnwcuWZdE9qWw9h4J0FfSc/XrmxonXaHxc=;
 b=aJOptLGW0rguSxhfwh/8cBM+7SvlqLdx3To+KgoMserNGACrYI9CV8XFVbeqcW3rkR+nBHQb8nM2MhR4bqqxeAiq6gRRO7N9PcjPIl7A7bo8UoaWcTEslBd6L7jGaj2onMsBP/X/J6Rp+ONmkAK+kimK7HK7oxMzDnK1yhIfNEY=
Received: from MN2PR12MB2910.namprd12.prod.outlook.com (20.179.81.219) by
 MN2PR12MB3470.namprd12.prod.outlook.com (20.178.244.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Wed, 17 Apr 2019 13:52:06 +0000
Received: from MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::71f5:c696:c706:9b7c]) by MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::71f5:c696:c706:9b7c%2]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 13:52:06 +0000
From:   Chunming Zhou <zhoucm1@amd.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: dynamic DMA-buf sharing between devices
Thread-Topic: dynamic DMA-buf sharing between devices
Thread-Index: AQHU9IOjpDvhBG68rU+RgcYdVAcWSKZAYFyA
Date:   Wed, 17 Apr 2019 13:52:06 +0000
Message-ID: <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To MN2PR12MB2910.namprd12.prod.outlook.com
 (2603:10b6:208:af::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [101.86.234.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f45b61d7-a50f-490b-5550-08d6c33be0bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3470;
x-ms-traffictypediagnostic: MN2PR12MB3470:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB3470927E132E0E1D2EBD81EBB4250@MN2PR12MB3470.namprd12.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(53754006)(189003)(486006)(476003)(256004)(11346002)(3846002)(66066001)(105586002)(2201001)(31696002)(97736004)(446003)(186003)(14454004)(478600001)(5024004)(25786009)(36756003)(966005)(6116002)(102836004)(68736007)(26005)(66574012)(72206003)(305945005)(5660300002)(229853002)(316002)(76176011)(53936002)(8676002)(2616005)(7736002)(99286004)(31686004)(52116002)(6436002)(6486002)(81166006)(6512007)(6506007)(2501003)(386003)(6306002)(110136005)(6246003)(81156014)(8936002)(106356001)(14444005)(71200400001)(71190400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3470;H:MN2PR12MB2910.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2c4qHS6GwJ3Kyf/bXhfuYzpP/BkECVkL/R/HzZc31YaRSsOMAw1sMkiNRHOAEq9KscWWRq6fgIQ/hloC/Huo9xpKKE5/PyYaRNwvcdI066KcYbhj/wpki6RdfLQbOQ8USex3D6EuDXoTgkFs57wPIakBiWYCRXIpkkA7ROoDjPJsgOevHcmYTVbqNotkwzn7vNENO6BCNwxfbyLpLp4y6pdnW+E5z/Y2c3BTWbKVT/a36iN66bhkte2btfO9SXX7Q3clPw+KKx3tKcK66RH0rsVCQsfq5eyxmdOKIzq0BSPCAcGimph4NgIPNFZMLFbHFfUcRs3kz1MdE6Yh0PigfBRczCNWykcZRAKSMQQ/0uQZGmWUmZzmTj2p7iowPASBKLArNkceLDbdWR5DYNuKlQy1h6J54qJ9XWAYV149y9c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A300D655748B3F4387A3AC013957A106@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b61d7-a50f-490b-5550-08d6c33be0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 13:52:06.6253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIENocmlzdGlhbiwgZ3JlYXQgam9iLiBJIHdpbGwgdmVyaWZ5IGl0IHRoaXMgd2VlayB3
aGVuIEkgZmluaXNoIG15IA0KY3VycmVudCB3b3JrIG9uIGhhbmQuDQoNCi1EYXZpZA0KDQrlnKgg
MjAxOS80LzE3IDI6MzgsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+IEhpIGV2ZXJ5Ym9keSwN
Cj4NCj4gY29yZSBpZGVhIGluIHRoaXMgcGF0Y2ggc2V0IGlzIHRoYXQgRE1BLWJ1ZiBpbXBvcnRl
cnMgY2FuIG5vdyBwcm92aWRlIGFuIG9wdGlvbmFsIGludmFsaWRhdGUgY2FsbGJhY2suIFVzaW5n
IHRoaXMgY2FsbGJhY2sgYW5kIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgZXhwb3J0ZXJzIGNhbiBu
b3cgYXZvaWQgcGlubmluZyBETUEtYnVmIG1lbW9yeSBmb3IgYSBsb25nIHRpbWUgd2hpbGUgc2hh
cmluZyBpdCBiZXR3ZWVuIGRldmljZXMuDQo+DQo+IEkndmUgYWxyZWFkeSBzZW5kIG91dCBhbiBv
bGRlciB2ZXJzaW9uIHJvdWdobHkgYSB5ZWFyIGFnbywgYnV0IGRpZG4ndCBoYWQgdGltZSB0byBm
dXJ0aGVyIGxvb2sgaW50byBjbGVhbmluZyB0aGlzIHVwLg0KPg0KPiBUaGUgbGFzdCB0aW1lIGEg
bWFqb3IgcHJvYmxlbSB3YXMgdGhhdCB3ZSB3b3VsZCBoYWQgdG8gZml4IHVwIGFsbCBkcml2ZXJz
IGltcGxlbWVudGluZyBETUEtYnVmIGF0IG9uY2UuDQo+DQo+IE5vdyBJIGF2b2lkIHRoaXMgYnkg
YWxsb3dpbmcgbWFwcGluZ3MgdG8gYmUgY2FjaGVkIGluIHRoZSBETUEtYnVmIGF0dGFjaG1lbnQg
YW5kIHNvIGRyaXZlciBjYW4gb3B0aW9uYWxseSBtb3ZlIG92ZXIgdG8gdGhlIG5ldyBpbnRlcmZh
Y2Ugb25lIGJ5IG9uZS4NCj4NCj4gVGhpcyBpcyBhbHNvIGEgcHJlcmVxdWlzaXRlIHRvIG15IHBh
dGNoc2V0IGVuYWJsaW5nIHNoYXJpbmcgb2YgZGV2aWNlIG1lbW9yeSB3aXRoIERNQS1idWYuDQo+
DQo+IFBsZWFzZSByZXZpZXcgYW5kL29yIGNvbW1lbnQsDQo+IENocmlzdGlhbi4NCj4NCj4NCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gZHJpLWRl
dmVsIG1haWxpbmcgbGlzdA0KPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsDQo=
