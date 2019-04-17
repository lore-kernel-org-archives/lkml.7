Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D839C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB64C20674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XU6pZ8xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfDQQMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:12:34 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:30542
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729512AbfDQQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXA6i/VvEUcf/XD5fpJYxZWmtLgT+XDApuJchH8ddxA=;
 b=XU6pZ8xlbeZTJTiOAjNzlpNYLkeqZSXiFpVcmMZHAjxKUZEIclRQXrd2m64iw4Zj5UIqE/UP5QOghRKYbYocfCoS7PEZdS45XMQCqGDbX6WPO8m1v7UgcERCJR3XG5gKE8peKUqc/hCxcyteBfM6QgI1/4wLBKtqlsp/Sy9pv5U=
Received: from AM0PR08MB5105.eurprd08.prod.outlook.com (10.255.30.86) by
 AM0PR08MB4260.eurprd08.prod.outlook.com (20.179.32.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 16:12:29 +0000
Received: from AM0PR08MB5105.eurprd08.prod.outlook.com
 ([fe80::7de4:87d1:9c4b:b25e]) by AM0PR08MB5105.eurprd08.prod.outlook.com
 ([fe80::7de4:87d1:9c4b:b25e%3]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 16:12:29 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] kernfs: keep kernfs node alive for
 __kernfs_remove()
Thread-Topic: [PATCH RFC 1/1] kernfs: keep kernfs node alive for
 __kernfs_remove()
Thread-Index: AQHU9GyPWQ+YPVfbiESxIBDX1jg2naY/KTWAgAFevIA=
Date:   Wed, 17 Apr 2019 16:12:29 +0000
Message-ID: <0469256f-7af9-c9cb-1c64-5d4bebfad095@virtuozzo.com>
References: <20190416155335.14627-1-khorenko@virtuozzo.com>
 <20190416155335.14627-2-khorenko@virtuozzo.com>
 <20190416191727.GD374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190416191727.GD374014@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::26) To AM0PR08MB5105.eurprd08.prod.outlook.com
 (2603:10a6:208:160::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f8c3b5f-a737-4813-4d86-08d6c34f7d5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR08MB4260;
x-ms-traffictypediagnostic: AM0PR08MB4260:
x-microsoft-antispam-prvs: <AM0PR08MB42601A4BF9A44876BF9FF68FC8250@AM0PR08MB4260.eurprd08.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39850400004)(366004)(189003)(199004)(186003)(106356001)(6246003)(102836004)(68736007)(2906002)(8676002)(81166006)(53936002)(386003)(81156014)(6506007)(97736004)(53546011)(7736002)(31696002)(4326008)(8936002)(316002)(6436002)(6486002)(6116002)(446003)(3846002)(54906003)(305945005)(86362001)(71200400001)(71190400001)(229853002)(11346002)(2616005)(52116002)(105586002)(5660300002)(478600001)(66066001)(14454004)(76176011)(25786009)(486006)(99286004)(256004)(14444005)(6916009)(476003)(31686004)(6512007)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB4260;H:AM0PR08MB5105.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aGJfL3BfdSWGiYFeO4xIBA6cpBf3prqL35XkSIHUkespCCUgZZ18mw2BNwjh31A01Pn+N6iUi73iXnnJpD1V3ymQUvxcch85/XLWpyh1ZOu6xnpMguHcP8+gz0xMwSQSapJpqISQxi2Wl5raPeNlEWFa9YpjZIifEO5SFL1Ahhwtzg3ddiBNrNib+2Z2Yk1YP/WZNUIbXvc4u58wyfSgyCcP7AsXG0fEo2b9EjOf3HoPJ7rjmuysbgpnyyQpZ33X7CplcSdoN3rRg99StDrKuPMKhgRQKQcsF4jFRVAfpiNA+yT4TpJxlky1K4GVFrMGyeiB4m7hE8OvklgJeeQ6SvgWfOdWc2WBofP742BWNOGsqj+YTh41+oTZptwy9KSuby63320lxYGTJg1uBZLv1v1x+T+JyEfbOtoZEqTI5b4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F41F548708D1148B1EBAD5B9C1EBE95@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8c3b5f-a737-4813-4d86-08d6c34f7d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 16:12:29.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMTYvMjAxOSAxMDoxNyBQTSwgVGVqdW4gSGVvIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAx
NiwgMjAxOSBhdCAwNjo1MzozNVBNICswMzAwLCBLb25zdGFudGluIEtob3JlbmtvIHdyb3RlOg0K
Pj4gX19rZXJuZnNfcmVtb3ZlKCkgd2hpY2ggaXMgY2FsbGVkIHVuZGVyIGtlcm5mc19tdXRleCwN
Cj4+IGFzc3VtZXMgbm9ib2R5IGtpbGxzIGtlcm5mcyBub2RlIHdoaWUgaXQncyB3b3JraW5nIG9u
IGl0DQo+PiBhbmQgImdldCJzIGN1cnJlbnQga2VybmZzIG5vZGUgZm9yIHRoYXQuDQo+Pg0KPj4g
QnV0IHdlIGhpdCBhIHdhcm5pbmcgaW4ga2VybmZzX2dldCgpOiBrbi0+Y291bnRlciA9PSAwIGFs
cmVhZHk6DQo+PiAgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPj4gICBX
QVJOSU5HOiBDUFU6IDIgUElEOiA2MzkyMyBhdCBmcy9rZXJuZnMvZGlyLmM6Mzc3IGtlcm5mc19n
ZXQrMHgyZi8weDQwDQo+PiAgIC4uLg0KPj4gICBDYWxsIFRyYWNlOg0KPj4gICAgWzxmZmZmZmZm
ZmE3ZjkyZTY3Pl0gZHVtcF9zdGFjaysweDE5LzB4MWINCj4+ICAgIFs8ZmZmZmZmZmZhNzg5ODdi
OD5dIF9fd2FybisweGQ4LzB4MTAwDQo+PiAgICBbPGZmZmZmZmZmYTc4OTg4ZmQ+XSB3YXJuX3Ns
b3dwYXRoX251bGwrMHgxZC8weDIwDQo+PiAgICBbPGZmZmZmZmZmYTdhZWNhZmY+XSBrZXJuZnNf
Z2V0KzB4MmYvMHg0MA0KPj4gICAgWzxmZmZmZmZmZmE3YWVkMjMzPl0gX19rZXJuZnNfcmVtb3Zl
KzB4MTEzLzB4MjYwDQo+PiAgICBbPGZmZmZmZmZmYTdhZWUyMDE+XSBrZXJuZnNfcmVtb3ZlKzB4
MjEvMHgzMA0KPj4gICAgWzxmZmZmZmZmZmE3YWYxMDEwPl0gc3lzZnNfcmVtb3ZlX2RpcisweDUw
LzB4ODANCj4+ICAgIFs8ZmZmZmZmZmZhN2I5ZmIzOD5dIGtvYmplY3RfZGVsKzB4MTgvMHg1MA0K
Pj4gICAgWzxmZmZmZmZmZmE3YTM4YTRkPl0gc3lzZnNfc2xhYl9yZW1vdmUrMHgzZC8weDUwDQo+
PiAgICBbPGZmZmZmZmZmYTc5ZjFlNmI+XSBkb19rbWVtX2NhY2hlX3JlbGVhc2UrMHgzYi8weDcw
DQo+PiAgICBbPGZmZmZmZmZmYTc5ZjJhYTE+XSBtZW1jZ19kZXN0cm95X2ttZW1fY2FjaGVzKzB4
YjEvMHhmMA0KPj4gICAgWzxmZmZmZmZmZmE3YTRlZDVjPl0gbWVtX2Nncm91cF9jc3NfZnJlZSsw
eDRjLzB4MjgwDQo+PiAgICBbPGZmZmZmZmZmYTc5Mzc3ZmM+XSBjZ3JvdXBfZnJlZV9mbisweDRj
LzB4MTIwDQo+PiAgICBbPGZmZmZmZmZmYTc4YmMyMjI+XSBwcm9jZXNzX29uZV93b3JrKzB4MTgy
LzB4NDQwDQo+PiAgICBbPGZmZmZmZmZmYTc4YmQzZDY+XSB3b3JrZXJfdGhyZWFkKzB4MTI2LzB4
M2MwDQo+PiAgICBbPGZmZmZmZmZmYTc4YzQ0NDE+XSBrdGhyZWFkKzB4ZDEvMHhlMA0KPj4NCj4+
IFRoaXMgY291bGQgYmUgZm9yIGV4YW1wbGUgYmVjYXVzZSBvZiBrZXJuZnNfbm90aWZ5X3dvcmtm
bigpIHdoaWNoDQo+PiBkb2VzIGtlcm5mc19wdXQoa24pIG91dCBvZiBrZXJuZnNfbXV0ZXggaGVs
ZCBzZWN0aW9uLA0KPj4gc28gbW92ZSBrZXJuZnNfcHV0KGtuKSB1bmRlciB0aGUgbXV0ZXguDQo+
DQo+IFRoaXMgcGF0Y2ggZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZSB0byBtZS4gIENhbiB5b3Ug
Z2l2ZSBhIG1vcmUNCj4gY29uY3JldGUgc2NlbmFyaW8gd2hlcmUgdGhpcyB3b3VsZCBoZWxwPw0K
DQppIGRvbid0IGtub3cgdGhlIGZ1bGwgc2NlbmFyaW8gdW5mb3J0dW5hdGVseSwgYnV0IHRoZSBp
ZGVhIGlzIHRoZSBmb2xsb3dpbmc6DQoNCl9fa2VybmZzX3JlbW92ZSgpIGlzIGNhbGxlZCB1bmRl
ciBrZXJuZnNfbXV0ZXggYW5kIGlmDQogICAhKCFrbiB8fCAoa24tPnBhcmVudCAmJiBSQl9FTVBU
WV9OT0RFKCZrbi0+cmIpKSkNCg0KaXQgYXNzdW1lcyB0aGF0IG5vdGhpbmcgY2FuIGNoYW5nZSB3
aGlsZSB3ZSBob2xkIHRoZSBtdXRleCBhbmQNCmZvciBlYWNoIGtlcm5mcyBkZXNjZW5kYW50IHNo
b3VsZCBoYXZlIGtuLT5jb3VudCA+IDAuDQoNCj09PT09DQogICAgICAgICAvKiBkZWFjdGl2YXRl
IGFuZCB1bmxpbmsgdGhlIHN1YnRyZWUgbm9kZS1ieS1ub2RlICovDQogICAgICAgICBkbyB7DQog
ICAgICAgICAgICAgICAgIHBvcyA9IGtlcm5mc19sZWZ0bW9zdF9kZXNjZW5kYW50KGtuKTsNCg0K
ICAgICAgICAgICAgICAgICAvKg0KICAgICAgICAgICAgICAgICAgKiBrZXJuZnNfZHJhaW4oKSBk
cm9wcyBrZXJuZnNfbXV0ZXggdGVtcG9yYXJpbHkgYW5kIEBwb3Mncw0KICAgICAgICAgICAgICAg
ICAgKiBiYXNlIHJlZiBjb3VsZCBoYXZlIGJlZW4gcHV0IGJ5IHNvbWVvbmUgZWxzZSBieSB0aGUg
dGltZQ0KICAgICAgICAgICAgICAgICAgKiB0aGUgZnVuY3Rpb24gcmV0dXJucy4gIE1ha2Ugc3Vy
ZSBpdCBkb2Vzbid0IGdvIGF3YXkNCiAgICAgICAgICAgICAgICAgICogdW5kZXJuZWF0aCB1cy4N
CiAgICAgICAgICAgICAgICAgICovDQogICAgICAgICAgICAgICAgIGtlcm5mc19nZXQocG9zKTsN
Cj09PT09DQoNCkF0IHRoZSBzYW1lIHRpbWUga2VybmZzX25vdGlmeV93b3JrZm4oKSBjYW4gZG8g
YSBrZXJuZnNfcHV0KCkgb3V0IG9mIGtlcm5mc19tdXRleA0Kd2hpY2ggcHJvYmFibHkgY2FuIGJl
IHRoZSBsYXN0IHB1dCBhbmQgZGVjIGtuLT5jb3VudCB0byAwIGFueSBtb21lbnQuDQoNCg0KVGhh
bmsgeW91Lg0KDQotLQ0KQmVzdCByZWdhcmRzLA0KDQpLb25zdGFudGluIEtob3JlbmtvLA0KVmly
dHVvenpvIExpbnV4IEtlcm5lbCBUZWFtDQo=
