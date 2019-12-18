Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28AF2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FXhKWQKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLRSga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:36:30 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:3815
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfLRSga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:36:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMXoqjdKYb0wE6fKiJIMp6sc392Y5fM8gsIUcFRlTDflqQmYxrJa4OHX/MEhKd0JPNPxm5YNDSM3eai8a1BdzsduYJhOKe/MsVyYAZdn1qy8ZGN4w36LTEegRepN/QORCN0yAL0sgIdQ92jwBBXmh/GKzM/zeHSqGBuP6jQG0DGVzUppu5VHsu7bx7Q2lE7PzXMCzedJqeKip+hfnS0bWzs1Qv5SD7FxLyHk7My6jQzzSWvayG5KT02xPLeWKNG3T6lKNWdNmnXuzuSqLWdOxtAk/Pw4jJ9tQGOxaXKg+8yjfrDa+o2l7DhNZSQSdiQRe108lSPm0rX9lXZc67k70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9fp1neM2ZuJB67k0YLWpsIqQkE9CyljUJXOov+nVE=;
 b=Cn3qeWgryLXkXg8seVSPUIp3XBJ8QL8aHzzI0SnTgJRuYvCiHPNXgAENXb6nHj+jhzIzv9FAn+QwvrdGsC14q48eOZl/wgzr3tfX2LO3k+MsCF4SvtDiQhBUE0yYJKITgZmdKPjT+MnB7/WpgADPciw0J1ZKgoe1wSRffW0bDWiD+Z7MBlgU91SN6qssc56lG3xHdghJH5HLNSvxfEIIernyRve/FrqMJuhZI1Ud8lMhFxfCnr0lGJWxqdGaFB47j75lvsLXSyP09zQOWKavTiS+NHde1VDea+aHjjruyomXfV7Q2wXPIW2yQYdU3OwEzv7ygbOiyoeRL07mdcjicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d9fp1neM2ZuJB67k0YLWpsIqQkE9CyljUJXOov+nVE=;
 b=FXhKWQKEiwlFEiNotjEXX5JvFXR7w3Sll+nW0pZ4wqiWw0XZLLWlb15u0hU1MMYtTpkZTSs/LrP78JzbpBXPYVVHNJCVQoE4hRTuyCwVZ9FlJ9nJyp9xVSQgGrycmkK031BFKZNYGuvK8gZdBOMSojJdb7OB04VDSPXt/s3l5Vc=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4647.eurprd05.prod.outlook.com (10.168.21.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Wed, 18 Dec 2019 18:36:25 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987%4]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 18:36:25 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Topic: [PATCH v3] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Index: AQHVtbdkdC7X5TRbx0CQavEp0YMqiafALmuAgAAKB+A=
Date:   Wed, 18 Dec 2019 18:36:25 +0000
Message-ID: <DB6PR05MB3223550D527DC5C37FCF9720A1530@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
 <1576682676-31957-1-git-send-email-lsun@mellanox.com>
 <CAHp75VfYwxviATZnmYcgzkKKGw47ki=BZQYw4xRmUrfNqsiBww@mail.gmail.com>
In-Reply-To: <CAHp75VfYwxviATZnmYcgzkKKGw47ki=BZQYw4xRmUrfNqsiBww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6789040-3fe1-4ea5-8013-08d783e93054
x-ms-traffictypediagnostic: DB6PR05MB4647:|DB6PR05MB4647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR05MB46471D1434F51272B46415ADA1530@DB6PR05MB4647.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(13464003)(189003)(199004)(8936002)(81166006)(54906003)(478600001)(9686003)(55016002)(81156014)(6916009)(2906002)(8676002)(5660300002)(86362001)(71200400001)(6506007)(66446008)(64756008)(66556008)(66946007)(7696005)(316002)(53546011)(66476007)(186003)(76116006)(26005)(52536014)(33656002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4647;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKJa2GmR/sY3NNSVi8u+uaIM9x04KibNiMfJkB6FHl1vx5jzW/JR7cHu22VpNWNfn1BpU0qNsOP9Fsoce+b5sM0fymNjMpeV1QPMnl3DUNcRkb5YXRbY0QQVMFMJ86nNsIrBpsOD5qqa+Pib5DYh0qFyvuZufcoDg/KWJ3oOYQqgZxiXgsxfzCxEnKatLQtkgZ67v16ITGMBSvkKDNmhjPpwf/gfyy/mwCB0FVpVPuYYT5AlziIMN+qkH5jHlDcrNaERIQl91+MKts/3g8/Xc7AGel0xp8mSAUsbrlZXDILiKwjfKyJ4ualHUu9UkkiV52eAn1VceytwrCaptv8cjXxLuVc+2aZEZciDuDNbNo1299CkwnkkSbF1R+T1DAjqfDr2flNf9x8vBxw0Wjhxek6gqGoQMiw9+LUDgX/F6p0+x/Xk/huRBVghfFAjTP9jMmsBVKzqV3HY3CV7Mft2XPCP1RqhOY8xNCHKCGJGC+2JvVlJ8aBuEXnyAZDQs1+p
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6789040-3fe1-4ea5-8013-08d783e93054
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 18:36:25.5758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdE79rbCzMxY3pZ8GdPH6DkhzFuVs7jD31ES21acwy8upW89xlw8QfaPyYOw8iykwA9VamBZEpxXa/acgqmf4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgSSBtaXN1bmRlcnN0b29kIHRoZSBsYXN0IGNvbW1lbnQuIFZlcmlmaWVkIGFuZCBwb3N0
ZWQgdjQuDQoNCi0gTGltaW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIERlY2VtYmVyIDE4LCAyMDE5IDE6MDAgUE0NCj4gVG86IExpbWluZyBTdW4gPGxz
dW5AbWVsbGFub3guY29tPg0KPiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVhZC5v
cmc+OyBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBWYWRpbSBQYXN0ZXJuYWsg
PHZhZGltcEBtZWxsYW5veC5jb20+OyBEYXZpZA0KPiBXb29kcyA8ZHdvb2RzQG1lbGxhbm94LmNv
bT47IFBsYXRmb3JtIERyaXZlciA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gcGxhdGZvcm0vbWVsbGFub3g6IGZpeCB0
aGUgbWx4LWJvb3RjdGwgc3lzZnMNCj4gDQo+IE9uIFdlZCwgRGVjIDE4LCAyMDE5IGF0IDU6MjUg
UE0gTGltaW5nIFN1biA8bHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBp
cyBhIGZvbGxvdy11cCBjb21taXQgZm9yIHRoZSBzeXNmcyBhdHRyaWJ1dGVzIHRvIGNoYW5nZQ0K
PiA+IGZyb20gRFJJVkVSX0FUVFIgdG8gREVWSUNFX0FUVFIgYWNjb3JkaW5nIHRvIHNvbWUgaW5p
dGlhbCBjb21tZW50cy4NCj4gPiBJbiBzdWNoIGNhc2UsIGl0J3MgYmV0dGVyIHRvIHBvaW50IHRo
ZSBzeXNmcyBwYXRoIHRvIHRoZSBkZXZpY2UNCj4gPiBpdHNlbGYgaW5zdGVhZCBvZiB0aGUgZHJp
dmVyLiBUaGUgQUJJIGRvY3VtZW50IGlzIGFsc28gdXBkYXRlZC4NCj4gPg0KPiA+IEZpeGVzOiA3
OWUyOWNiOGZiYzUgKCJwbGF0Zm9ybS9tZWxsYW5veDogQWRkIGJvb3RjdGwgZHJpdmVyIGZvciBN
ZWxsYW5veCBCbHVlRmllbGQgU29jIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxs
c3VuQG1lbGxhbm94LmNvbT4NCj4gDQo+IC4uLg0KPiANCj4gPiAtQVRUUklCVVRFX0dST1VQUyht
bHhiZl9ib290Y3RsKTsNCj4gDQo+IFdoYXQncyB3cm9uZyB3aXRoIGFib3ZlIG1hY3JvPw0KPiAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgbWx4YmZfYm9vdGN0bF9n
cm91cCA9IHsNCj4gPiArICAgICAgIC5hdHRycyAgPSBtbHhiZl9ib290Y3RsX2F0dHJzLA0KPiA+
ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9n
cm91cCAqbWx4YmZfYm9vdGN0bF9kZXZfZ3JvdXBzW10gPSB7DQo+ID4gKyAgICAgICAmbWx4YmZf
Ym9vdGN0bF9ncm91cCwNCj4gPiArICAgICAgIE5VTEwNCj4gPiArfTsNCj4gDQo+IC0tDQo+IFdp
dGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
