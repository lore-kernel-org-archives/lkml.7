Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EC1206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lGb/HCIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLRP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:27:08 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:64654
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfLRP1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:27:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3I83IGFCxIO7Mew/Hgqdt64cie4ySSfOcSnfKaTUFRh7C9QRfYrr4EJfvjzJOGMrNBf2PyGI0VSNpjRUZb2bN8Z/GtaalZ+XWgYYU10grRmldXc8QP8NBxxnNCPSy/kIK3VsWJ6YK0FWsrC5IOO+2tA5kuXo7h8WGKFSs3y30ta2ACSVsmITlTw83FEYpU0Qd6Qw1UgjSrP/vtL5cC4eXp8oE5jkR7MsZM7tbWdZsOdmVUo5oz7V4N1ujMEmZCn1kGkILG1AEYH/o/B7CpNTr5HrTlcgtc/cmfYz2hLNDdjTK2AwUF97Movtd8MZt2/90xJhHsXprWrBPGy1PT6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk9SQ5olCWQ3ll1HQq3RaPwV6q5C8ARBnm2s0UYtlCk=;
 b=RtyfAsyg8eHmORfz5eX1MKA3oghSpOvNgRh5fdRQfITGNg36JAqzSRc6Gn5z9eO6cPkKIbE1Q4HoIpc04y8Su1e49zIWVT5gcYSslVKcA5Dd9Srjs9Arset284kOTTC6DR0i7y8FmCi2owgqJqZspqsW2PJVfUkugoq95fkBXIINCnbIGtmyq/jGpKHXXre+gcRUOHMmYVnOAjLmVHCpCVifRZcKrcpnc0FRmQRJUAGbCMcTitrIb2p0elt/O9kD1vug6GaNmu8CW+EpYFfkUyjBT1woYeTxr62eWzUw4iBnodWcAU4GdPW09RTlhYXXk3dVqr0l2Cy3Z4buXq1cWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk9SQ5olCWQ3ll1HQq3RaPwV6q5C8ARBnm2s0UYtlCk=;
 b=lGb/HCIiT1Wm5GECzzZy4bKri4MXH8CkZoEiQPOE0n8EVEicx/Do9jX5+xfbBIv2/rbOx5rcAQcBKwcqZW9wSqp5Mr1ze/lc+C1oGA0bkCE2xVXPJi7g27ZOg2g13i6Ys+1q3zCBtOKTanCTUcfxJPVnpIVfsOGj4QFXXjHpm5Y=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3335.eurprd05.prod.outlook.com (10.170.221.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 15:26:23 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 15:26:23 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Topic: [PATCH v2] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Index: AQHVsckIeUPdxRAr4kSaRQ7hc7r5rKe/4tCAgAAoYxA=
Date:   Wed, 18 Dec 2019 15:26:23 +0000
Message-ID: <DB6PR05MB3223ED6CFF01AE972F608B6EA1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
 <1576250484-27291-1-git-send-email-lsun@mellanox.com>
 <CAHp75VfVL8fs_VXQgL85QPnW2N+zsLq4dWYkhs3xdMAjcfRgTg@mail.gmail.com>
In-Reply-To: <CAHp75VfVL8fs_VXQgL85QPnW2N+zsLq4dWYkhs3xdMAjcfRgTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9ad2a92-e8fd-4c21-1c25-08d783cea432
x-ms-traffictypediagnostic: DB6PR05MB3335:|DB6PR05MB3335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR05MB33355361FEFBA32402404B82A1530@DB6PR05MB3335.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(13464003)(8676002)(52536014)(6916009)(26005)(6506007)(53546011)(186003)(81156014)(66946007)(64756008)(81166006)(5660300002)(66556008)(33656002)(66446008)(8936002)(7696005)(66476007)(76116006)(54906003)(478600001)(316002)(55016002)(2906002)(71200400001)(9686003)(86362001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3335;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoTrnTtmfIMjUOpSM3rUPbDmDXgPz6gGhDu98rJZGjSE4Y8HdjOM6Aaa0NHB3hYExYMusXvQnkcRZPlQL9oUQU3xLOd1cRVLJt762aJsL69U2XaAUl1aeFR34EUC4eU5n2B2NAqJvxodmjaxISKX3DdVtViVsxv+bNxJj6GSnmYA8lp8N8vdY3b4epc1NjdoPA4xz74m3NxwsZSAyepdpKlMhc1Oy1zgAv0LvjmOaLq8nyuG7Wa5xxJynUV0wdabWa9FrQOx/t9QmbZr2pyCtpeOTuciCD6rr6hfChsprurj5/baz6UlRfyuxmBEpgT0DRT8w5aN0OhZpbiATSg/GIuFI7vCWxAb08hki2Vda9dLQL6OqNiIWerrssDb9JDEftLTvN6UOjAllfI8hUHTvfzQsnjuhHgHzCFCvYTn8BwRWsYYFGOZJwjBOtb4+KXqafC/O0WF/Vs3vM8lHamtQALFETRL+GVN3sznM1NnUjtD8U/z0fkyJEEUXDP+s+Z2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ad2a92-e8fd-4c21-1c25-08d783cea432
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 15:26:23.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzXUPZUWNb8AToE63rZRBCY/ezNkzRLgNwTOws/sVb7VhYAtCUxmpaYEgIT2oAfn1axTXvyJ/ism/q794/ZZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHkgZm9yIHRoZSBjb21tZW50cy4gdjMgaGFzIGJlZW4gcG9zdGVkIHdpdGggdGhl
IHVwZGF0ZXMuDQoNCi0gTGltaW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIERlY2VtYmVyIDE4LCAyMDE5IDg6MDEgQU0NCj4gVG86IExpbWluZyBTdW4g
PGxzdW5AbWVsbGFub3guY29tPg0KPiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVh
ZC5vcmc+OyBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBWYWRpbSBQYXN0ZXJu
YWsgPHZhZGltcEBtZWxsYW5veC5jb20+OyBEYXZpZA0KPiBXb29kcyA8ZHdvb2RzQG1lbGxhbm94
LmNvbT47IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5v
cmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gcGxhdGZvcm0vbWVsbGFub3g6IGZp
eCB0aGUgbWx4LWJvb3RjdGwgc3lzZnMNCj4gDQo+IE9uIEZyaSwgRGVjIDEzLCAyMDE5IGF0IDU6
MjEgUE0gTGltaW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KPiANCj4gPiArICAg
ICAgIHJldCA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmZGV2LT5rb2JqLCAmbWx4YmZfYm9vdGN0bF9n
cm91cCk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGNyZWF0ZSBhdHRyaWJ1dGVzLCBlcnI9JWRcbiIsIHJldCk7DQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+
ICAgICAgICAgLyogRW5zdXJlIHdlIGhhdmUgdGhlIFVVSUQgd2UgZXhwZWN0IGZvciB0aGlzIHNl
cnZpY2UuICovDQo+ID4gICAgICAgICBhcm1fc21jY2Nfc21jKE1MWEJGX0JPT1RDVExfU0lQX1NW
Q19VSUQsIDAsIDAsIDAsIDAsIDAsIDAsIDAsICZyZXMpOw0KPiA+ICAgICAgICAgZ3VpZF9wYXJz
ZShtbHhiZl9ib290Y3RsX3N2Y191dWlkX3N0ciwgJmd1aWQpOw0KPiA+IEBAIC0zMDUsOCArMzEy
LDE2IEBAIHN0YXRpYyBpbnQgbWx4YmZfYm9vdGN0bF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IG1seGJmX2Jvb3RjdGxfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gK3sNCj4gPiArICAgICAgIHN5c2ZzX3JlbW92ZV9ncm91cCgmcGRldi0+ZGV2LmtvYmos
ICZtbHhiZl9ib290Y3RsX2dyb3VwKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbWx4YmZfYm9v
dGN0bF9kcml2ZXIgPSB7DQo+ID4gICAgICAgICAucHJvYmUgPSBtbHhiZl9ib290Y3RsX3Byb2Jl
LA0KPiA+ICsgICAgICAgLnJlbW92ZSA9IG1seGJmX2Jvb3RjdGxfcmVtb3ZlLA0KPiA+ICAgICAg
ICAgLmRyaXZlciA9IHsNCj4gPiAgICAgICAgICAgICAgICAgLm5hbWUgPSAibWx4YmYtYm9vdGN0
bCIsDQo+ID4gICAgICAgICAgICAgICAgIC5ncm91cHMgPSBtbHhiZl9ib290Y3RsX2dyb3VwcywN
Cj4gDQo+IFBsZWFzZSwgdXNlIGRldl9ncm91cHMgbWVtYmVyIG9mIHRoZSBzdHJ1Y3QgZHJpdmVy
IGluc3RlYWQgb2YgYWJvdmUgYXBwcm9hY2guDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJk
cywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
