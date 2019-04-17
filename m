Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ACD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B8zYhRJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfDQOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:14:24 -0400
Received: from mail-eopbgr810080.outbound.protection.outlook.com ([40.107.81.80]:45536
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731743AbfDQOOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa+Xx0Ur9rKStclOcCm/vnEU8ha/TlRnNRgxJTGEPiM=;
 b=B8zYhRJS1UhbkgW3c5s6vyr0xbTj1XT/3ndwOhhR1vFu6NATp7ag5xq4mFP+/XW/TZYrpGGEZuA49XwrUiKcuz2hcEnrGhA3uHzXIdJRXct1VHzSap8JHrtaLDy1y/yAYOw+cErdsn7odq/CFgXxXLgCBvj3sbIVjgmmuxxpdl0=
Received: from MN2PR12MB2910.namprd12.prod.outlook.com (20.179.81.219) by
 MN2PR12MB2925.namprd12.prod.outlook.com (20.179.81.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 14:14:20 +0000
Received: from MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::71f5:c696:c706:9b7c]) by MN2PR12MB2910.namprd12.prod.outlook.com
 ([fe80::71f5:c696:c706:9b7c%2]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 14:14:20 +0000
From:   Chunming Zhou <zhoucm1@amd.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: dynamic DMA-buf sharing between devices
Thread-Topic: dynamic DMA-buf sharing between devices
Thread-Index: AQHU9IOjpDvhBG68rU+RgcYdVAcWSKZAYFyAgAACQ4CAAAPzgA==
Date:   Wed, 17 Apr 2019 14:14:20 +0000
Message-ID: <5457e417-f710-5e81-fc9b-c78378af49e6@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
 <04558379-9788-bbcc-5c64-7fa9ad92f60d@gmail.com>
In-Reply-To: <04558379-9788-bbcc-5c64-7fa9ad92f60d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To MN2PR12MB2910.namprd12.prod.outlook.com
 (2603:10b6:208:af::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [101.86.234.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b5775a2-4893-4e98-ebdc-08d6c33efbc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB2925;
x-ms-traffictypediagnostic: MN2PR12MB2925:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB292580148A33388AD7C951C0B4250@MN2PR12MB2925.namprd12.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(53754006)(72206003)(110136005)(478600001)(186003)(6246003)(66066001)(316002)(11346002)(446003)(102836004)(229853002)(36756003)(53936002)(26005)(6306002)(6512007)(2501003)(31696002)(2906002)(5660300002)(97736004)(3846002)(6116002)(66574012)(106356001)(6506007)(68736007)(105586002)(386003)(71190400001)(71200400001)(52116002)(5024004)(14444005)(2201001)(76176011)(256004)(6436002)(81166006)(81156014)(8676002)(8936002)(486006)(2616005)(6486002)(31686004)(305945005)(14454004)(25786009)(7736002)(476003)(966005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2925;H:MN2PR12MB2910.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zF88F9G9e3CIOx0bsn5SWkeJHFX1y3pxkA7WkfvhKfHtdQY7WB7aEpV9rAeG1iXOpDq/WUkxfcClY6/AP1dsvbsXQZEMu1DTfsLiNjHNqTteQKNTO/2ZlJ7PT2klCo7dgJ0QigCsADOTWpHtipKdnWQ12tNKEhz0+DOjdgUDOLVzS6aW5+J24YwiVApjt3ilmoLCWugtXMhmvjqMSfUHGRQy/jbekAoEfXcmHGqFsns/kB9mlOCLA/KNNTY2CgPkpBfmEsP5+eFIblCCKm75aPXRKVwT2aQAY+FoLw6WIZwITbhbVX381EzFJ0kFlutYn8pqhT7nVAo3MfxU1KuDzMdqalDB8VZgzO1I4HfnOOW+PjEC2Jr2e9x+xqR6gD6CPH83rEQW4u/Uyri7/CbFEjNOicE9+ZvPqShvHxpJzTk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2091E5407278418416B28BA280320C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5775a2-4893-4e98-ebdc-08d6c33efbc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 14:14:20.4243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBsaWtlIHlvdSBkbyBzb21ldGhpbmdzIHN0ZXAgYnkgc3RlcCwgeW91IGNhbiBwaW5nIG1lIHdo
ZW4gdGhleSBhcmUgcmVhZHkuDQoNCi1EYXZpZA0KDQrlnKggMjAxOS80LzE3IDIxOjU5LCBDaHJp
c3RpYW4gS8O2bmlnIOWGmemBkzoNCj4gT24gdG9wIG9mIHRob3NlIEkgaGF2ZSA2IG1vcmUgcGF0
Y2hlcyBpbiB0aGUgcGlwZWxpbmUgdG8gZW5hYmxlIFZSQU0gDQo+IFAyUCB3aXRoIERNQS1idWYu
DQo+DQo+IFNvIHRoYXQgaXMgbm90IHRoZSBlbmQgb2YgdGhlIHBhdGNoIHNldCA6KQ0KPg0KPiBD
aHJpc3RpYW4uDQo+DQo+IEFtIDE3LjA0LjE5IHVtIDE1OjUyIHNjaHJpZWIgQ2h1bm1pbmcgWmhv
dToNCj4+IFRoYW5rcyBDaHJpc3RpYW4sIGdyZWF0IGpvYi4gSSB3aWxsIHZlcmlmeSBpdCB0aGlz
IHdlZWsgd2hlbiBJIGZpbmlzaCBteQ0KPj4gY3VycmVudCB3b3JrIG9uIGhhbmQuDQo+Pg0KPj4g
LURhdmlkDQo+Pg0KPj4g5ZyoIDIwMTkvNC8xNyAyOjM4LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Og0KPj4+IEhpIGV2ZXJ5Ym9keSwNCj4+Pg0KPj4+IGNvcmUgaWRlYSBpbiB0aGlzIHBhdGNoIHNl
dCBpcyB0aGF0IERNQS1idWYgaW1wb3J0ZXJzIGNhbiBub3cgDQo+Pj4gcHJvdmlkZSBhbiBvcHRp
b25hbCBpbnZhbGlkYXRlIGNhbGxiYWNrLiBVc2luZyB0aGlzIGNhbGxiYWNrIGFuZCB0aGUgDQo+
Pj4gcmVzZXJ2YXRpb24gb2JqZWN0IGV4cG9ydGVycyBjYW4gbm93IGF2b2lkIHBpbm5pbmcgRE1B
LWJ1ZiBtZW1vcnkgDQo+Pj4gZm9yIGEgbG9uZyB0aW1lIHdoaWxlIHNoYXJpbmcgaXQgYmV0d2Vl
biBkZXZpY2VzLg0KPj4+DQo+Pj4gSSd2ZSBhbHJlYWR5IHNlbmQgb3V0IGFuIG9sZGVyIHZlcnNp
b24gcm91Z2hseSBhIHllYXIgYWdvLCBidXQgDQo+Pj4gZGlkbid0IGhhZCB0aW1lIHRvIGZ1cnRo
ZXIgbG9vayBpbnRvIGNsZWFuaW5nIHRoaXMgdXAuDQo+Pj4NCj4+PiBUaGUgbGFzdCB0aW1lIGEg
bWFqb3IgcHJvYmxlbSB3YXMgdGhhdCB3ZSB3b3VsZCBoYWQgdG8gZml4IHVwIGFsbCANCj4+PiBk
cml2ZXJzIGltcGxlbWVudGluZyBETUEtYnVmIGF0IG9uY2UuDQo+Pj4NCj4+PiBOb3cgSSBhdm9p
ZCB0aGlzIGJ5IGFsbG93aW5nIG1hcHBpbmdzIHRvIGJlIGNhY2hlZCBpbiB0aGUgRE1BLWJ1ZiAN
Cj4+PiBhdHRhY2htZW50IGFuZCBzbyBkcml2ZXIgY2FuIG9wdGlvbmFsbHkgbW92ZSBvdmVyIHRv
IHRoZSBuZXcgDQo+Pj4gaW50ZXJmYWNlIG9uZSBieSBvbmUuDQo+Pj4NCj4+PiBUaGlzIGlzIGFs
c28gYSBwcmVyZXF1aXNpdGUgdG8gbXkgcGF0Y2hzZXQgZW5hYmxpbmcgc2hhcmluZyBvZiANCj4+
PiBkZXZpY2UgbWVtb3J5IHdpdGggRE1BLWJ1Zi4NCj4+Pg0KPj4+IFBsZWFzZSByZXZpZXcgYW5k
L29yIGNvbW1lbnQsDQo+Pj4gQ2hyaXN0aWFuLg0KPj4+DQo+Pj4NCj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+IGRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QNCj4+PiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwNCj4NCg==
