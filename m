Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B47C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ECC20700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GTlFuhu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbfCZTLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:11:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:46183 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZTLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:11:32 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a79600000>; Wed, 27 Mar 2019 03:11:28 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 12:11:27 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 26 Mar 2019 12:11:27 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 19:11:27 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 19:11:27 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3160.namprd12.prod.outlook.com (20.179.92.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 19:11:24 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.014; Tue, 26 Mar 2019
 19:11:23 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?UmFuZG9scGggTWFhw59lbg==?= <gaireg@gaireg.de>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: tegra20-slink: change chip select action order
Thread-Topic: [PATCH] spi: tegra20-slink: change chip select action order
Thread-Index: AQHU4+F/55HpSiP6AkewsvaxAFrqJKYd/RuAgABFBiA=
Date:   Tue, 26 Mar 2019 19:11:23 +0000
Message-ID: <BYAPR12MB3398F38A7F38A0448016FC5CC25F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <20190326143050.26232-1-gaireg@gaireg.de>
 <20190326144437.GA21654@ulmo>
In-Reply-To: <20190326144437.GA21654@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f336f41-e6d4-45e2-e36e-08d6b21ed6ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3160;
x-ms-traffictypediagnostic: BYAPR12MB3160:
x-microsoft-antispam-prvs: <BYAPR12MB3160C6088F774D86082F63C3C25F0@BYAPR12MB3160.namprd12.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(6436002)(86362001)(486006)(14454004)(25786009)(8936002)(478600001)(52536014)(71190400001)(71200400001)(74316002)(229853002)(7736002)(256004)(305945005)(186003)(68736007)(476003)(81156014)(81166006)(11346002)(4326008)(8676002)(446003)(55016002)(6116002)(3846002)(33656002)(9686003)(26005)(66574012)(6506007)(97736004)(102836004)(14444005)(99286004)(7696005)(5660300002)(316002)(6246003)(53936002)(54906003)(110136005)(106356001)(105586002)(2906002)(66066001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3160;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +n+OOhZUwueCvpz+Tq6PCBX8mOJkHF+kM7JYroCzJoYW9T94ko6xL2T8KcLXWGtYplo++gZmv+cw1HeZccz+byI9M4cxkuuzovyVElwVNPI+blPkCf3hePqEBz8byxb8iuWwl6u2qZMWOimdCrQ/G05mXWGSJQhNCbGdb9BraaLIdIh55vzqNOsg9m3CK8ev8uHNyNHbdZxCz/aqk5CPLI1v7Kk3vnGLF7pMoQ3jhHmzxmDpKb4pIza3A0VjKTfk5LDeJWoJz/p11eTiAui3ATHP/AoeQ0akn1DCXupkpvP7ZOuiK0YusnNqUWeFaZybAOYqfRt/rMleEbl4ciy93pKJ2sFaYIwgjVDbAw/BScKHWZ3sVb2FTVo3BFy6uJ9NY/OAIY8jOG+x506FcJbaTwpgDg8zP6zLRvnUc2JR5zw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f336f41-e6d4-45e2-e36e-08d6b21ed6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 19:11:23.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553627488; bh=uQe+ODK1ZBad/4EgG+ne2MqiYIbnT6M5CJMKskPwdhE=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=GTlFuhu0x2ZnxddtOC1Z+GO5DoFBOthU34gJH4cCCifn0Vs7dhZXfhDpKD2pt9Wpi
         uioZCEw5FAfP1R/kU49bItUyxGIgHwBLqhHjYr7M9tUyr0yf7XGgKHxspouk4Cg0Ph
         tfJ/LhzDP68wAGUYAfUaniz42DuSjV8i0YgRu+es9D5ryvBVLHmrm7qf8FH8+T0AXe
         VNSJNhBSpBFbP9FtYzqSORZT95cOkcZZSdhlfXAWf5xYPNbYpc5X3dOsmgi47LzN71
         aEbWocAahp30JSggq/CwUrvMWmZy/Xbw51f9iBw8qPHL3jbYuWDaQE/EXT8cAc638e
         tX9UOt5Uvf81A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIE1hciAyNiwgMjAxOSBhdCAwMzozMDo1MFBNICswMTAwLCBSYW5kb2xwaCBNYWHD
n2VuIHdyb3RlOg0KPiA+IFRvIHRyYW5zZmVyIHZpYSBTUEkgdGhlIHRlZ3JhMjAtc2xpbmsgZHJp
dmVyIGZpcnN0IHNldHMgdGhlIGNvbW1hbmQgDQo+ID4gcmVnaXN0ZXIsIHdoaWNoIGNvbnRhaW5z
IHRoZSBjaGlwIHNlbGVjdCB2YWx1ZSwgYW5kIGFmdGVyIHRoYXQgdGhlDQo+ID4gY29tbWFuZDIg
cmVnaXN0ZXIsIHdoaWNoIGNvbnRhaW5zIHRoZSBjaGlwIHNlbGVjdCBsaW5lLiBUaGlzIGxlYWRz
IHRvIA0KPiA+IGEgc21hbGwgc3Bpa2UgaW4gdGhlIGNoaXAgc2VsY3QgMCBsaW5lIGJldHdlZW4g
dGhlIHNldCBvZiB0aGUgdmFsdWUgDQo+ID4gYW5kIHRoZSBzZWxlY3Rpb24gb2YgdGhlIGNoaXAg
c2VsZWN0IGxpbmUuDQo+ID4gDQo+ID4gVGhpcyBjb21taXQgY2hhbmdlcyB0aGUgb3JkZXIgb2Yg
dGhlIHJlZ2lzdGVyIHdyaXRlcyBzbyB0aGF0IGZpcnN0IHRoZSANCj4gPiBjaGlwIHNlbGVjdCBs
aW5lIGlzIGNob3NlbiBhbmQgdGhlbiB0aGUgdmFsdWUgaXMgc2V0LCByZW1vdmluZyB0aGUgDQo+
ID4gc3Bpa2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmFuZG9scGggTWFhw59lbiA8Z2Fp
cmVnQGdhaXJlZy5kZT4NCg0KVmVyeSBtaW5vciB0eXBvIGluIHRoZSBjb21tZW50IGJlbG93Og0K
DQpGaXggbG9va3MgZ29vZCBhcyBjaGlwIHNlbGVjdCBuZWVkIHRvIGJlIHNlbGVjdGVkIHByaW9y
IHRvIGFzc2VydGluZyBkdXJpbmcNCnN0YXJ0IG9mIHRyYW5zZmVyLg0KDQpSZXZpZXdlZC1ieTog
U293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0aW5lbmlAbnZpZGlhLmNvbT4NCg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3NwaS9zcGktdGVncmEyMC1zbGluay5jIHwgMTIgKysrKysrKysrLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IExvb2tzIGdvb2QgdG8gbWUuIEFkZGluZyBTb3dqYW55YSB3aG8gaGFzIGJlZW4gbG9va2luZyBp
bnRvIFNQSSByZWNlbnRseS4NCj4NCj4gVGhpZXJyeQ0KPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3NwaS9zcGktdGVncmEyMC1zbGluay5jIA0KPiA+IGIvZHJpdmVycy9zcGkvc3BpLXRlZ3Jh
MjAtc2xpbmsuYyBpbmRleCAxNDI3ZjM0M2IzOWEuLjZkNDY3OTEyNjIxMyANCj4gPiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktdGVncmEyMC1zbGluay5jDQo+ID4gKysrIGIvZHJp
dmVycy9zcGkvc3BpLXRlZ3JhMjAtc2xpbmsuYw0KPiA+IEBAIC03MTcsOSArNzE3LDYgQEAgc3Rh
dGljIGludCB0ZWdyYV9zbGlua19zdGFydF90cmFuc2Zlcl9vbmUoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSwNCj4gPiAgCWNvbW1hbmQyID0gdHNwaS0+Y29tbWFuZDJfcmVnOw0KPiA+ICAJY29tbWFu
ZDIgJj0gfihTTElOS19SWEVOIHwgU0xJTktfVFhFTik7DQo+ID4gIA0KPiA+IC0JdGVncmFfc2xp
bmtfd3JpdGVsKHRzcGksIGNvbW1hbmQsIFNMSU5LX0NPTU1BTkQpOw0KPiA+IC0JdHNwaS0+Y29t
bWFuZF9yZWcgPSBjb21tYW5kOw0KPiA+IC0NCj4gPiAgCXRzcGktPmN1cl9kaXJlY3Rpb24gPSAw
Ow0KPiA+ICAJaWYgKHQtPnJ4X2J1Zikgew0KPiA+ICAJCWNvbW1hbmQyIHw9IFNMSU5LX1JYRU47
DQo+ID4gQEAgLTcyOSw5ICs3MjYsMTggQEAgc3RhdGljIGludCB0ZWdyYV9zbGlua19zdGFydF90
cmFuc2Zlcl9vbmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwNCj4gPiAgCQljb21tYW5kMiB8PSBT
TElOS19UWEVOOw0KPiA+ICAJCXRzcGktPmN1cl9kaXJlY3Rpb24gfD0gREFUQV9ESVJfVFg7DQo+
ID4gIAl9DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIFdyaXRpbmcgdG8gdGhlIGNvbW1hbmQy
IHJlZ2lzdGVyIGJldm9yZSB0aGUgY29tbWFuZCByZWdpc3RlciBwcmV2ZW50cw0KPiA+ICsJICog
YSBzcGlrZSBpbiBjaGlwX3NlbGVjdCBsaW5lIDAuIFRoaXMgc2VsZWN0cyB0aGUgY2hpcF9zZWxl
Y3QgbGluZQ0KPiA+ICsJICogYmVmb3JlIGNoYW5naW5nIHRoZSBjaGlwX3NlbGVjdCB2YWx1ZS4N
Cj4gPiArCSAqLw0KDQpUeXBlICJiZWZvcmUiDQoNCj4gPiAgCXRlZ3JhX3NsaW5rX3dyaXRlbCh0
c3BpLCBjb21tYW5kMiwgU0xJTktfQ09NTUFORDIpOw0KPiA+ICAJdHNwaS0+Y29tbWFuZDJfcmVn
ID0gY29tbWFuZDI7DQo+ID4gIA0KPiA+ICsJdGVncmFfc2xpbmtfd3JpdGVsKHRzcGksIGNvbW1h
bmQsIFNMSU5LX0NPTU1BTkQpOw0KPiA+ICsJdHNwaS0+Y29tbWFuZF9yZWcgPSBjb21tYW5kOw0K
PiA+ICsNCj4gPiAgCWlmICh0b3RhbF9maWZvX3dvcmRzID4gU0xJTktfRklGT19ERVBUSCkNCj4g
PiAgCQlyZXQgPSB0ZWdyYV9zbGlua19zdGFydF9kbWFfYmFzZWRfdHJhbnNmZXIodHNwaSwgdCk7
DQo+ID4gIAllbHNlDQo+ID4gLS0NCj4gPiAyLjExLjANCj4gPiANCg==
