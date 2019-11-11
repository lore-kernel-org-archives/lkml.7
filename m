Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3E720679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="NvMeNPIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKGEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:04:35 -0500
Received: from mail-eopbgr30110.outbound.protection.outlook.com ([40.107.3.110]:59699
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfKKGEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+f69m76iqMTinTKnEVpb24yHyhoXXzGE/JRkpnKUuTKjRjuZIu5Ok+Hw85NcVQBnfn1mJbHSwgZZ46KuIYf0a22aL82vbKXvfTgdBZuWDQxqZWuVzo8D0Ppzm5F8hbgL9AXkjbKePzKNnNAGke1V+N8Mn4ZPl4GFkbhEwNmwRJ7pvfs4GYfgEVEC6NKAVkgFcF/n4q+zx7siZarIwR+JWcY+1cHKAI038q7SY4OEU0Bg/wHoFlyNGh6lS5/w8gXeZaaqV9O0A+5IVkiWbsw160a0ovHTYa93gB9Uht9CRBOb85xEd9YCCPjCp0Yjjul7CaS0oGxC+kOftRPxm5Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3LlkwxUPKsWeqPcqF2XJ+wTPvs6U9uWZ7cEBezucLA=;
 b=jutCJMeSwn8vAKYu+JC04l28yKZNEbkBw7tvHwWTpR5Wv8pZhN2KTw5rD04NXUXgZVtNcN5Qty3g+leposf2vgmErHfiK6p6PCRgYO7Yj2lojKI8jgLsRJSgtv/K2HD1t0AfQQMNwt7UzvkNkaXaGEFxegLnbD0YPwMjVh5Rd5Wl00omb9QRN8nL9VCp8igP88gSH1F+fwQQF1aICemm76PLsTHu2cvu8LVWkHVyaJWzSUR8Ohrmh2Kjo7nBIAnUkEW0x+M3Ms0xgMsN2YC0S46CBCIweGgy8Fk4mfkL3kVmNor1+2hG0zuxqZaHfepbm1U187MYeEQpoWwd7S6wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3LlkwxUPKsWeqPcqF2XJ+wTPvs6U9uWZ7cEBezucLA=;
 b=NvMeNPISs03QO+yLxhBZOITybQ+9EHqLwfdgjkuDYkaEQfxHH7Te/GK6kGPjMED+/KJuYWbFJgRvY4m8g/aoXhO1gjAzEKin+6rNlKBLNofTe1tJRvGFIw/EM5jzN6fTwb73NNBqmfUPldCFe4xgRL4wct/XsvWJRd6b9Zf4poQ=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3493.eurprd02.prod.outlook.com (52.133.31.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 06:04:31 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:04:31 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5/6] habanalabs: don't print error when queues are full
Thread-Topic: [PATCH 5/6] habanalabs: don't print error when queues are full
Thread-Index: AQHVmBGYC8imNZcx9kmxVBFayUGhdqeFe68w
Date:   Mon, 11 Nov 2019 06:04:31 +0000
Message-ID: <AM6PR0202MB338219721B8F2F018E964DC9B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
 <20191110215533.754-5-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-5-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b1a64a-94b9-401c-2a59-08d7666d04de
x-ms-traffictypediagnostic: AM6PR0202MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB34931FF907F91D36A796A333B8740@AM6PR0202MB3493.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(39840400004)(396003)(366004)(136003)(189003)(199004)(99286004)(66446008)(66946007)(66476007)(66556008)(64756008)(6636002)(55016002)(4326008)(9686003)(53546011)(6506007)(316002)(110136005)(26005)(52536014)(186003)(558084003)(76116006)(6246003)(102836004)(256004)(5660300002)(6436002)(66066001)(71200400001)(71190400001)(478600001)(2501003)(6116002)(3846002)(25786009)(74316002)(14454004)(76176011)(305945005)(7736002)(7696005)(229853002)(2906002)(33656002)(8936002)(476003)(446003)(11346002)(486006)(8676002)(81156014)(81166006)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3493;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjOscHLiusokf/XDgsEWFe/M4VaSeIlnTVJdCwme9sBi7Avw16Mj76SF8XIrBF0P3xiViOedI7IvFrKMcoAW8+PRi5agtvzDOMaItFKraZ+TEUzt/YmvsP/MoLYYQ8q6BNeFo7uRGBcx2F0rS/TmAiN6CeDNSdXttMU4/VhS5dT/90YWEcVFCbdpx60cVadbLl/S3y0sULdL6CCPPJWmXYiXpbmPNRJcDevn/pTlhux9IB2l+cRD/SMCKYX7fljMTxrDUBlmD5cJaLQR+06oeUobhoJx65jtBfhs/O30aV6KyZMRJNIog3ja25qraEaDQEd6FrXprI7JcIA5o6/kIQI3tLVl6LM4W/ozlMzcnZAok0TWk5OZ1+igVnUr/DKE6qUZ7P4+KnpB8v9pR0TeOXGtoqecwZjd8PAzpRe8fWlimRfxYf+RKlxoYiCPF93t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b1a64a-94b9-401c-2a59-08d7666d04de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:04:31.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0FCzLAvdnnX11GN0q2j5p1I+vX7bVf7mCcsrkWJJt5XZQ/Zjl45MyzFAgq4QzEou+Bmac8p/4f+yfZS3IOaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTYgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IElm
IHRoZSBxdWV1ZXMgYXJlIGZ1bGwgYW5kIHdlIHJldHVybiAtRUFHQUlOIHRvIHRoZSB1c2VyLCB0
aGVyZSBpcyBubyBuZWVkIHRvDQo+IHByaW50IGFuIGVycm9yLCBhcyB0aGF0IGNhc2UgaXNuJ3Qg
YW4gZXJyb3IgYW5kIHRoZSB1c2VyIGlzIGV4cGVjdGVkIHRvIHJlLQ0KPiBzdWJtaXQgdGhlIHdv
cmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEu
YWk+DQo=
