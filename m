Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0226CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5AD21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="NuBGn7lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392087AbfJWNjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:39:45 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com ([40.107.8.114]:44758
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391615AbfJWNjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpOl8WzxRWxQUIpZ7lzBfKSFYQWZF5I1IaGZrruaR53jgSsgx77TezGiEST243nG0lNBVE0czv3e8P3og9Ak/CcdNLd5QF9pRR8YTu2yUbmGDWI75DK964/myU2p2mlzeMWSeFBTR50g2sla0bAG8/NN+xkIEi288/RVJ6+i4i6bDzOGxzMqPwagWgyljVkdgREjWKIkYv8eIhcubEhKtQEYmoVL/9SRiHPphDwgUy7eGWBV6nILw/C28oaNiT68wrvHqgtBh8bSuTLGjC0qja615fz3H5Fwl+KUpvisr5qP4ONAmoJtRSZiSL/gzrI/PEgP1oG/Tm7OlnAmGKRphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT1PRXvpLeXkddn7h7qxO7ktFLA+CLYY4s31dKPhjsY=;
 b=ZNfC4KIdlqrRS6TBKpcmqQc8IoY1XCiafAWs/92jZBWQs62fabzbH05BP+26auAZQgiEK+Z+UDkHHRBqq7aFOfxb675C1Zow6b1UC7XuoX4WVnuC/MKimkwK2JmESL92+uIZoCrxXkqqXupb0BnqTzqYGENLYUQYE/TomzJwrof/E1NDfPtqHxGVEEcWbGCsybh7gzbr1gcCew2XxdB07ZN7FBo/e9Kg84o/KcopzYANa+gLN3nPy5JAUg0MUGcQawmmvB3BSzlevyYM4Q6TLF/aQjCLVaAHNci4qNNMOYDhgvGZuDXGbztiTueJ7MnivIAcPN0TIq20WaFWzJAl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT1PRXvpLeXkddn7h7qxO7ktFLA+CLYY4s31dKPhjsY=;
 b=NuBGn7lY+IrpKdAHRUjJSwzQ1okYXtl0fmAdc8u16AZaT9zHMJQpcyWAmuX/oeJ6uA5Mq1tgwPuqYHYWB4MIbzuSvhEkKT9uhFgMkMWkqAmgSavgxhZc6DORnGVtLbkXIJNIqwxIf8ThZT88Y3XP79Xh+y0ti1Jqvu57AyLYR/8=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3400.eurprd02.prod.outlook.com (52.133.8.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 13:39:41 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 13:39:41 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Topic: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Index: AQHViKI2kzFSWJT/Dk6DGcovF5gSd6dn9PuAgABElLA=
Date:   Wed, 23 Oct 2019 13:39:41 +0000
Message-ID: <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
 <20191023092035.GA12222@infradead.org>
In-Reply-To: <20191023092035.GA12222@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e524e25-f8c7-4f22-eaa2-08d757be7520
x-ms-traffictypediagnostic: AM6PR0202MB3400:
x-microsoft-antispam-prvs: <AM6PR0202MB34005B2A17E7DD7E2E9B89D1B86B0@AM6PR0202MB3400.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(39840400004)(366004)(346002)(189003)(199004)(74316002)(8676002)(53546011)(6506007)(4326008)(76176011)(7696005)(14454004)(81156014)(81166006)(6916009)(26005)(6436002)(102836004)(6116002)(186003)(305945005)(25786009)(7736002)(99286004)(478600001)(486006)(446003)(55016002)(2906002)(9686003)(11346002)(6246003)(3846002)(476003)(229853002)(33656002)(76116006)(66446008)(64756008)(66476007)(316002)(71190400001)(71200400001)(66066001)(66946007)(5660300002)(52536014)(54906003)(4744005)(86362001)(8936002)(66556008)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3400;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pk7xD0J16oinzFx/+N8Pm6io0ykJv5MpVJcfRlGjXBv+Pg9R+cZXRMTudBaRnbvEwQ3RrJ7MoPSCK+J57FLJBmdiVdfN/2KaZVL+U5J6pq0SG5jJYIOGHvGa7W27bxc4L1whSb+X6ONS+rmvp9S/LwwN4W6ejUJV2Mu56R0T9PitOzTqLH+qZwk8K4a8ILphUhMdpwJTb70+hMeQzYg6H65udqIJnmgsN55Bw6ocpnhvwliVGDDsmohyEwWqLzzef+cuVeeQvNwbWHzC5QREMDU14IlwObi3z06XVj68YxRS8rAkTlrESud1qk5NR2rMBpXsU+We0+y1rVDAaQ7YqvoWSZteB7KCQe7tGzN2wYX2iZth7GgEFIrv0PXs6/tBqgdzN9WAcKtpD79613gAB4+LTwJvEKca4PraohkMPjOrq2N6Me2G84+GuZmuXxfz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e524e25-f8c7-4f22-eaa2-08d757be7520
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 13:39:41.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0W6hVTtvnsj1gxsnDGBlS3rFeV+di2ef2g6zDhrMgfsgZwuFv/W4drAGQmictzneABWpsOUJkt7025L5NVILSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMjMsIDIwMTkgYXQgMTI6MjEgUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gT24gVHVlLCBPY3QgMjIsIDIwMTkgYXQgMDY6MzA6MzVB
TSArMDAwMCwgT21lciBTaHBpZ2VsbWFuIHdyb3RlOg0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4g
IC0gdXNlIGEgYm9vbGVhbiBwYXJhbWV0ZXIgdG8gaW5kaWNhdGUgZm9yIGtlcm5lbCBhZGRyZXNz
IHJhdGhlciB0aGFuDQo+ID4gICAgY2FsbGluZyBpc192bWFsbG9jX2FkZHIsIGFzIGtlcm5lbCBh
bmQgdXNlciBhZGRyZXNzZXMgY2FuIG92ZXJsYXAgb24NCj4gPiAgICBzb21lIGFyY2hpdGVjdHVy
ZXMuDQo+IA0KPiBUaGF0IGlzIHN0aWxsIGJyb2tlbi4gIFBsZWFzZSB1c2UgYW4gYWN0dWFsIGtl
cm5lbCBwb2ludGVyIGluc3RlYWQgb2YgbG9zaW5nIGFsbA0KPiB0eXBlIHNhZmV0eSBieSBjYXN0
aW5nIGl0IGFuIGludGVnZXIgdHlwZS4NCg0KSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gQ2Fu
IHlvdSBwbGVhc2UgcGluIHBvaW50IHRoZSBwcm9ibGVtYXRpYyBsaW5lPw0K
