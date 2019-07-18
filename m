Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A66C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC07A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="tlhOVyGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbfGRIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:52:50 -0400
Received: from mail-eopbgr30119.outbound.protection.outlook.com ([40.107.3.119]:11234
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfGRIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qia7xmC4rW2z/lv6Dfm+CpAnMUjisuPA6iasUkPSw9PlM4gUrAXk5IekytEslCYZoVBog08HZBR7XKVtB74odMl76KhXmxk/mrds+zTpCgbM1RKSI47Ym2T5FjLyUHjN73TIa4tbkmUm5LIXdquXJTdTck1THJFmDFqETQD35b5J/o6bqz/GcuhANuilH4ygm5VNu7C6hAyz/McVY5x/lOuHhhjo/YeGtTDE32Qyr2AIier7WQ8XlYgU9XuXHAd/MFoGMpghnHd9abwjIhWaJ72cp2VWc6EGo6pik5fVpRf03K0rccTDY8bAyhTccmU7Cm4pkGHApfj3+ozsTyGC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub94ymI8FlpYx4SfXhX8VP/jaONHeDjXg0cCmWtMtz0=;
 b=KECIzpGKOlvr4Hkwfohx6cJsMmRNvEUDZt75NsJaYex1XjyGJNrxZV+iYILwR0OxkJ3gfH1Dr94B7H9XemEZDK+hTWHSP3X3r8EyacEn9TRKgfO7xigLyo0ChlspyDJ5A87oOhoGUcF0KUSlHQn0f/evDnTHSz3H/jC3Dh7jVuLxYuIO3+um+bYvSzq7t6+bj79fFO0yTlktqbn6YlaCNE3ITxrto3qUhoDhJikWwQJYVNQPJSzLngQRg8CIs+czmPkQacIqIwxCxphaWZGkmzz1sFKxYEKNcGkKTL08iK3fCftw1YmNay7Gk7cZpAKh/6ntojFFpD2fYWGeAxaOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub94ymI8FlpYx4SfXhX8VP/jaONHeDjXg0cCmWtMtz0=;
 b=tlhOVyGHwAY+CiErY4Q2QxQKEFJXHq0bfCJ+b303LPZnor1WYolgEuKVYdDqhUyiyOvFAeh4okO88iVjiziYZZEY4KfUcBoXcsIJhSCLaRxaEnVRpjVT8Qp8i5OyoX5ckQ7+7z4TQX7W4EvHN7cprVkJT8UD5aZcGiPP7Maef8k=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3366.eurprd02.prod.outlook.com (52.133.10.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 08:52:46 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::85d6:dc30:6af9:37a0%3]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 08:52:46 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: cap simulator timeout
Thread-Topic: [PATCH] habanalabs: cap simulator timeout
Thread-Index: AQHVPUWVwIswRq76ikC5lTLOpWNPw6bQEXbg
Date:   Thu, 18 Jul 2019 08:52:46 +0000
Message-ID: <AM6PR0202MB3382504BD486ABC59A5D235FB8C80@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190718084828.8581-1-oded.gabbay@gmail.com>
In-Reply-To: <20190718084828.8581-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a28a92-69c1-43d5-df45-08d70b5d4e2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3366;
x-ms-traffictypediagnostic: AM6PR0202MB3366:
x-microsoft-antispam-prvs: <AM6PR0202MB336659179E31743B9BB478C3B8C80@AM6PR0202MB3366.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39840400004)(189003)(199004)(5660300002)(110136005)(256004)(4326008)(316002)(33656002)(7696005)(2906002)(186003)(74316002)(446003)(11346002)(76176011)(102836004)(14454004)(229853002)(26005)(6506007)(99286004)(476003)(6636002)(486006)(86362001)(25786009)(6116002)(3846002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(4744005)(8676002)(478600001)(2501003)(9686003)(55016002)(6436002)(68736007)(53936002)(6246003)(8936002)(52536014)(81156014)(71190400001)(81166006)(7736002)(71200400001)(66066001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3366;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oyT3Fc/QaGq2DvacDP/LkRpKQ+IH9vzO9zZsNGmLprzesK1ygQsKEbyVQVOPRagnY8miUabAH8FNoDJqqkrtZvtwSNnfaSrfRAosFa3VUu2b6ym1jRGZ8zpKaH+Gz1hF5Fu9w/aHbulfbi8OPZyuWeaesl6Q6I05KKn+HLd2lqozETTSisTA9+eD54EMQ2LKFF730oBanDVVc7BexjnDlKbsUyvZbHcGd6smNwoweSpre1P3ohpWpPy5VwtdRK0VYs0bWJr+AMmWU6NUoLxEjwoRxRvFHE31OFtIwg/rp7mgXPeETalAsnI49cZiJn1QLWsgpcrsIeI233sYTgxoz5BQdUUtWVTTYDrP2VFatuQfIX5BhichIOEgg3KTydpJoiAKVxIp7tVm/tgTAnUhVCWZugQnpdQm/ncD/6ARv5c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a28a92-69c1-43d5-df45-08d70b5d4e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 08:52:46.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IFRodXJzZGF5
LCAxOCBKdWx5IDIwMTkgMTE6NDgNCg0KPiBJbiB0aGUgZHJpdmVyIHRpbWVvdXQgZnVuY3Rpb25z
LCB3ZSBnaXZlIHRoZSBzaW11bGF0b3IgYSBmYWN0b3Igb2YgMTAgaW4gdGhlDQo+IHRpbWVvdXQu
IFRoaXMgd2FzIG5lY2Vzc2FyeSB3aGVuIHRoZSByZXF1ZXN0ZWQgdGltZW91dCBpcyBzbWFsbCBi
dXQgaWYgaXQNCj4gd2FzIGEgZmV3IHNlY29uZHMsIHRoaXMgY2FuIHJlc3VsdCBpbiBhIHZlcnkg
bGFyZ2UgdGltZW91dCB3aGljaCBpcw0KPiB1bm5lY2Vzc2FyeS4NCj4gDQo+IFRoaXMgcGF0Y2gg
Y2FwcyB0aGUgbWF4aW11bSB0aW1lb3V0IG9mIHRoZSBzaW11bGF0b3IgdG8gMTAgc2Vjb25kcywg
d2hpY2gNCj4gaXMgb3VyIGxhcmdlc3QgdGltZW91dCBpbiB0aGUgY29kZS4gVGhhdCBpcyBtb3Jl
IHRoZW4gZW5vdWdoIGZvciBhbnl0aGluZyB0aGUNCj4gc2ltdWxhdG9yIGlzIGRvaW5nLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
