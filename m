Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEAC636D8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8F82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Kg+XIEEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbfFJOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:19:13 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com ([40.107.68.47]:34966
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390734AbfFJOTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf6QK3T/QOTnyOdaVMxWSs6ohjKlJSgm+6wmLJ2tC3M=;
 b=Kg+XIEEy3GCBgTr/byVEImBA2h+kdAhNdKFiJ78vWmqjxrIAVgraxK3x8+c4zny6YHYbrL/Z5TRS3FwSTGaFkgnKfF8UH9q26uOqhu/MrJ8YxA3blFyv2p8+8euziDYcAXwVzHWzXV5DfLu9gLZmcFs4/4ah/S5YK4AF1P489qY=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6031.namprd05.prod.outlook.com (20.178.243.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.5; Mon, 10 Jun 2019 14:19:08 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::5088:14e2:252d:98d0]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::5088:14e2:252d:98d0%6]) with mapi id 15.20.1987.008; Mon, 10 Jun 2019
 14:19:08 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH v3] drm/vmwgfx: fix a warning due to missing dma_parms
Thread-Topic: [PATCH v3] drm/vmwgfx: fix a warning due to missing dma_parms
Thread-Index: AQHVH5d38LG+xo4FWUO9Rk24fF+76A==
Date:   Mon, 10 Jun 2019 14:19:08 +0000
Message-ID: <20190610141835.2849-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:803:14::29) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f9068c6-8b1b-4d78-9952-08d6edae99a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR05MB6031;
x-ms-traffictypediagnostic: MN2PR05MB6031:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB60316F24E7412A76E3302AE2A1130@MN2PR05MB6031.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(6512007)(8676002)(73956011)(386003)(6506007)(2906002)(81156014)(86362001)(5640700003)(1076003)(50226002)(476003)(25786009)(6916009)(26005)(486006)(2351001)(66946007)(66446008)(64756008)(66556008)(66476007)(2616005)(53936002)(186003)(6486002)(54906003)(7736002)(6436002)(81166006)(66066001)(71190400001)(36756003)(305945005)(5660300002)(316002)(2501003)(52116002)(14444005)(5024004)(256004)(107886003)(3846002)(6116002)(99286004)(478600001)(14454004)(8936002)(68736007)(71200400001)(4326008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6031;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pcSjJFm83gY65kUPplTzq2PMpleHkJIxIU2DadzwKXza+5OT8jeLiqKC76WvN8g50CLfCRnzSH+sJM99ZIZC+ErqvPQ5GfZKT7ouQYuuhlXhlhvmxLxRI18xk9PgR1NPEsQYiEueqqJ23HAzslEAckRK2aqmjZ8nGmCGJvDqqZ7eE5TK8oaEqFsyBlm3i6SAjg5brf5bb0/mH5Lk+J6pnmKSnZZ3jHPf13Y7loBp2Us6AnaqPPuNs9dhz1XsDpdLHDtkBi5cyc6rp0TKNzSERKl9XSb2LDISS9nn2mpRDMUHX+f0CktXTHK09jbWWo2omKDcuF8K6jb5SDJilH1PBprovvy8Ei2BEwI5JR5PnOWM5w7uezcXTkPKU2Til1JqhGcg/xzlw+dJl+92XWxIXJMvlYm+oWZmFfKEJ4z1xH8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9068c6-8b1b-4d78-9952-08d6edae99a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 14:19:08.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thellstrom@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUWlhbiBDYWkgPGNhaUBsY2EucHc+DQoNCkJvb3RpbmcgdXAgd2l0aCBETUFfQVBJX0RF
QlVHX1NHPXkgZ2VuZXJhdGVzIGEgd2FybmluZyBkdWUgdG8gdGhlIGRyaXZlcg0KZm9yZ290IHRv
IHNldCBkbWFfcGFybXMgYXBwcm9wcmlhdGVseS4gU2V0IGl0IGp1c3QgYWZ0ZXIgdm13X2RtYV9t
YXNrcygpDQppbiB2bXdfZHJpdmVyX2xvYWQoKS4NCg0KRE1BLUFQSTogdm13Z2Z4IDAwMDA6MDA6
MGYuMDogbWFwcGluZyBzZyBzZWdtZW50IGxvbmdlciB0aGFuIGRldmljZQ0KY2xhaW1zIHRvIHN1
cHBvcnQgW2xlbj0yMDk3MTUyXSBbbWF4PTY1NTM2XQ0KV0FSTklORzogQ1BVOiAyIFBJRDogMjYx
IGF0IGtlcm5lbC9kbWEvZGVidWcuYzoxMjMyDQpkZWJ1Z19kbWFfbWFwX3NnKzB4MzYwLzB4NDgw
DQpIYXJkd2FyZSBuYW1lOiBWTXdhcmUsIEluYy4gVk13YXJlIFZpcnR1YWwgUGxhdGZvcm0vNDQw
QlggRGVza3RvcA0KUmVmZXJlbmNlIFBsYXRmb3JtLCBCSU9TIDYuMDAgMDQvMTMvMjAxOA0KUklQ
OiAwMDEwOmRlYnVnX2RtYV9tYXBfc2crMHgzNjAvMHg0ODANCkNhbGwgVHJhY2U6DQogdm13X3R0
bV9tYXBfZG1hKzB4M2IxLzB4NWIwIFt2bXdnZnhdDQogdm13X2JvX21hcF9kbWErMHgyNS8weDMw
IFt2bXdnZnhdDQogdm13X290YWJsZXNfc2V0dXArMHgyYTgvMHg3NTAgW3Ztd2dmeF0NCiB2bXdf
cmVxdWVzdF9kZXZpY2VfbGF0ZSsweDc4LzB4YzAgW3Ztd2dmeF0NCiB2bXdfcmVxdWVzdF9kZXZp
Y2UrMHhlZS8weDRlMCBbdm13Z2Z4XQ0KIHZtd19kcml2ZXJfbG9hZC5jb2xkKzB4NzU3LzB4ZDg0
IFt2bXdnZnhdDQogZHJtX2Rldl9yZWdpc3RlcisweDFmZi8weDM0MCBbZHJtXQ0KIGRybV9nZXRf
cGNpX2RldisweDExMC8weDI5MCBbZHJtXQ0KIHZtd19wcm9iZSsweDE1LzB4MjAgW3Ztd2dmeF0N
CiBsb2NhbF9wY2lfcHJvYmUrMHg3YS8weGMwDQogcGNpX2RldmljZV9wcm9iZSsweDFiOS8weDI5
MA0KIHJlYWxseV9wcm9iZSsweDFiNS8weDYzMA0KIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhhMy8w
eDFhMA0KIGRldmljZV9kcml2ZXJfYXR0YWNoKzB4OTQvMHhhMA0KIF9fZHJpdmVyX2F0dGFjaCsw
eGRkLzB4MWMwDQogYnVzX2Zvcl9lYWNoX2RldisweGZlLzB4MTUwDQogZHJpdmVyX2F0dGFjaCsw
eDJkLzB4NDANCiBidXNfYWRkX2RyaXZlcisweDI5MC8weDM1MA0KIGRyaXZlcl9yZWdpc3Rlcisw
eGRjLzB4MWQwDQogX19wY2lfcmVnaXN0ZXJfZHJpdmVyKzB4ZGEvMHhmMA0KIHZtd2dmeF9pbml0
KzB4MzQvMHgxMDAwIFt2bXdnZnhdDQogZG9fb25lX2luaXRjYWxsKzB4ZTUvMHg0MGENCiBkb19p
bml0X21vZHVsZSsweDEwZi8weDNhMA0KIGxvYWRfbW9kdWxlKzB4MTZhNS8weDFhNDANCiBfX3Nl
X3N5c19maW5pdF9tb2R1bGUrMHgxODMvMHgxYzANCiBfX3g2NF9zeXNfZmluaXRfbW9kdWxlKzB4
NDMvMHg1MA0KIGRvX3N5c2NhbGxfNjQrMHhjOC8weDYwNg0KIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCg0KRml4ZXM6IGZiMWQ5NzM4Y2EwNSAoImRybS92bXdnZng6
IEFkZCBEUk0gZHJpdmVyIGZvciBWTXdhcmUgVmlydHVhbCBHUFUiKQ0KQ28tZGV2ZWxvcGVkLWJ5
OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0cm9tQHZtd2FyZS5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBRaWFuIENhaSA8Y2FpQGxjYS5wdz4NClNpZ25lZC1vZmYtYnk6IFRob21hcyBIZWxsc3Ryb20g
PHRoZWxsc3Ryb21Adm13YXJlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13
Z2Z4X2Rydi5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYyBiL2RyaXZlcnMv
Z3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jDQppbmRleCA2ZDQxN2UyOWJjZWMuLjQ0N2I0OWQ2
YWRlMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KQEAgLTc0NSw2ICs3NDUs
OSBAQCBzdGF0aWMgaW50IHZtd19kcml2ZXJfbG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1
bnNpZ25lZCBsb25nIGNoaXBzZXQpDQogCWlmICh1bmxpa2VseShyZXQgIT0gMCkpDQogCQlnb3Rv
IG91dF9lcnIwOw0KIA0KKwlkbWFfc2V0X21heF9zZWdfc2l6ZShkZXYtPmRldiwgbWluX3QodW5z
aWduZWQgaW50LCBVMzJfTUFYICYgUEFHRV9NQVNLLA0KKwkJCQkJICAgICBTQ0FUVEVSTElTVF9N
QVhfU0VHTUVOVCkpOw0KKw0KIAlpZiAoZGV2X3ByaXYtPmNhcGFiaWxpdGllcyAmIFNWR0FfQ0FQ
X0dNUjIpIHsNCiAJCURSTV9JTkZPKCJNYXggR01SIGlkcyBpcyAldVxuIiwNCiAJCQkgKHVuc2ln
bmVkKWRldl9wcml2LT5tYXhfZ21yX2lkcyk7DQotLSANCjIuMjEuMA0KDQo=
