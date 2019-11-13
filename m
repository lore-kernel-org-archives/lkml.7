Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE33C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2377206DC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BLrNPWpb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="cdLbx9FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:40:40 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43294 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfKMTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:40:40 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0B062C024B;
        Wed, 13 Nov 2019 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573674038; bh=aGko5Oxd08GPvWqL3UPWkLPD3rX5nz2MmVGDMqzNOdc=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=BLrNPWpbj0ILbVD+XlaF0TvZdxKVggNZ4aUJKYs92PU1D/WZZA0XdbmVipwku7jV8
         PJYMdtfjbcJxR/QNd9Y7FJ9w0yIi/xb8uiSN5uqd1gvqAqpXtSpjvF2sDm6MJRkA3H
         DDvjS9sYmKE9Ok1CYxXrnZLu/Ih7xMI9wydJd0Z2z4DdTgQgxUFCV5xq72vrkuDZVa
         ZDD8euJsFIF2xQGAbEyUZ3BEd+nQM1P5M1sJMv5QkBf1WbLmDXp6mEXrNxe4WUxwNp
         GuasCuqzB3GZqLFVyPyR/uUtNzTzi1J7fvUnVUc+r+X8q9f2vwZVFVIv6xlcc4FA3X
         gLisDZT0egx8g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 14312A0069;
        Wed, 13 Nov 2019 19:40:29 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Nov 2019 11:40:28 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 13 Nov 2019 11:40:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWLaMQ9yu2ISZIJtT7+xGe++ya8GEkoYtco9YpV9DodQC5HenSvcbKRLRIb0/UVzqVNvDACJm5UYzRfyRqoRDUspiAA3x5r5/Ox35xqSGB3JL6h5YdF7BTyAnTmGXvBkW/EY1yfr803qO0PS4iiqFlx2Se7ncJ6Yx0Owfisd0mVBMLWW7FGlaqXWJMLGGdOh92qs2hEfqHAUR8OFMS9F4a/FaMWVTqdPvZWXiOFiZvdaHgJ6xW3/v3d+AQZEsXtckMbLwQXd2f/agzHVVtK+M0uTHXw+MzZ6kO9i02C5SZyxdgTVFdeP6dpetodNlr1K3/65m8fQSeWmvIHCgJDUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGko5Oxd08GPvWqL3UPWkLPD3rX5nz2MmVGDMqzNOdc=;
 b=SCWWoVdJX3SbRrNch7oIYmsfM6lstjhQrbt9qhVrGGtuBDS18XBYWFOjGCFJxidjWb7XlL2l9Xt+estwRCu2bGl9mzMY1BmKLvaTlNmSuJmFP1YjnQ1fddfD9pJt/43ON+F7ZjZzVQk09RrOeyPc5RzHwCQ4Qbd4iP97AvYEgTjxRFC7bb3xyjxR436gdmVdTQVbu81XjnfbyWgYJ2VMBTmSPj+wgLWS6RI+D7obiAPff4RTJbPIVoxCOE8F5Z7Q2ilBva0BbLevOfyau3dG/wyLkjU72obl7nTQYh3TSUHjbugRYC61QFH9bIfZrQfk7nL78RE4n7s1EyPtIEt40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGko5Oxd08GPvWqL3UPWkLPD3rX5nz2MmVGDMqzNOdc=;
 b=cdLbx9FHevnhouseUXelxxcnQvbkD8ReAxp0MXyNmzuGAG+CqHPrCewhhrn4ds31i1WkDYhfto4MTLCfimocAi02MlNhlbc7t0UDsarWke/B5IBNKgiUPTsRUyETHpPOs9EK9TRjZ80eo+YfRTruMZIdT6JPRse0OASgjp3jvUU=
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) by
 CY4PR1201MB0006.namprd12.prod.outlook.com (10.172.117.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 19:40:25 +0000
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3]) by CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 19:40:25 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Thread-Topic: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Thread-Index: AQHVmKSIKei7LJoy3kCzXLTfw8XpmaeIexeAgABE5oCAAMMcAA==
Date:   Wed, 13 Nov 2019 19:40:25 +0000
Message-ID: <4762d3c8-a4e5-c133-fbbf-e7374f05b2ed@synopsys.com>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
 <20191111152645.13792-2-m.olbrich@pengutronix.de>
 <49416a44-6317-c3e5-dca6-d33f3d8c9c89@synopsys.com>
 <20191113080205.tsqnzjgwtdmmudef@pengutronix.de>
In-Reply-To: <20191113080205.tsqnzjgwtdmmudef@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b678a04e-eeba-4be2-f550-08d76871546c
x-ms-traffictypediagnostic: CY4PR1201MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB000630342FD7AD78F44BADBFAA760@CY4PR1201MB0006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(2616005)(66556008)(25786009)(476003)(6506007)(99286004)(31696002)(486006)(2906002)(66476007)(66946007)(64756008)(76116006)(76176011)(6512007)(6436002)(110136005)(229853002)(6486002)(86362001)(66446008)(36756003)(11346002)(81156014)(7736002)(316002)(31686004)(8676002)(2501003)(305945005)(5660300002)(186003)(446003)(81166006)(6116002)(14454004)(6246003)(256004)(14444005)(66066001)(478600001)(8936002)(102836004)(71190400001)(71200400001)(2201001)(3846002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0006;H:CY4PR1201MB0037.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aOCQxM5AJZtL2M18/12nlRDns5VzZqqu8Gg7SvCrCekwYX2WeBkDMDa1wQj3iPx+g35hKAPjF/L8xOf+bFOCUKtUk9zMJA6AP3/CCKmaGhOXRwu9jpoQEVZ6qEQLKRxjLlfhfBEFlPCEXiQC7zybRmWhqi1/L2NcXIHCLzaYxlzMolzdiEWf5Fvn40gfxkxWVrWUa6pm8FeWDCxB1CSNa8rWaHAvH/86WZ+/GVTVOjJ3Ncw9IaxmxHmX9nQtHom3z24OHXQm6c+yVL2ucJsxd1dy6eBtItlwrovvuN1yK7GJRscH2B7VglLK5yBsvtFChaBteRDEmXDwmQPrBDQrH2I+fXhpNlts/u4bDV2zS+xpMayR1AeXK+LU8+NV70iT/s+VGH1/YTHYziiIoXcn7I2B1Q7ggNQNZNCEP0m3DlxmDFHHz5Jk7QUhCbB9Zbk
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAC479F06928BD48A21DADC398308E05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b678a04e-eeba-4be2-f550-08d76871546c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 19:40:25.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDzXltVirvDUrUCIoqVlfz+ZfFz6CYev/+UCR2f9NJ9o8M5E+6SC3YTrdW/tnZj/j/PlDcbqu09sL5ZlZlSY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk1pY2hhZWwgT2xicmljaCB3cm90ZToNCj4gSGksDQo+DQo+IE9uIFdlZCwgTm92IDEz
LCAyMDE5IGF0IDAzOjU1OjMwQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IE1pY2hh
ZWwgT2xicmljaCB3cm90ZToNCj4+PiBDdXJyZW50bHkgX19kd2MzX2dhZGdldF9zdGFydF9pc29j
IG11c3QgYmUgY2FsbGVkIHZlcnkgc2hvcnRseSBhZnRlcg0KPj4+IFhmZXJOb3RSZWFkeS4gT3Ro
ZXJ3aXNlIHRoZSBmcmFtZSBudW1iZXIgaXMgb3V0ZGF0ZWQgYW5kIHN0YXJ0IHRyYW5zZmVyDQo+
Pj4gd2lsbCBmYWlsLCBldmVuIHdpdGggc2V2ZXJhbCByZXRyaWVzLg0KPj4+DQo+Pj4gRFNUUyBw
cm92aWRlcyB0aGUgbG93ZXIgMTQgYml0IG9mIHRoZSBmcmFtZSBudW1iZXIuIFVzZSBpdCBpbiBj
b21iaW5hdGlvbg0KPj4+IHdpdGggdGhlIGZyYW1lIG51bWJlciBwcm92aWRlZCBieSBYZmVyTm90
UmVhZHkgdG8gZ3Vlc3MgdGhlIGN1cnJlbnQgZnJhbWUNCj4+PiBudW1iZXIuIFRoaXMgd2lsbCBz
dWNjZWVkIHVubGVzcyBtb3JlIHRoYW4gb25lIDE0IHJvbGxvdmVyIGhhcyBoYXBwZW5lZA0KPj4+
IHNpbmNlIFhmZXJOb3RSZWFkeS4NCj4+Pg0KPj4+IFN0YXJ0IHRyYW5zZmVyIG1pZ2h0IHN0aWxs
IGZhaWwgaWYgdGhlIGZyYW1lIG51bWJlciBpcyBpbmNyZWFzZWQNCj4+PiBpbW1lZGlhdGVseSBh
ZnRlciBEU1RTIGlzIHJlYWQuIFNvIHJldHJpZXMgYXJlIHN0aWxsIG5lZWRlZC4NCj4+PiBEb24n
dCBkcm9wIHRoZSBjdXJyZW50IHJlcXVlc3QgaWYgdGhpcyBoYXBwZW5zLiBUaGlzIHdheSBpdCBp
cyBub3QgbG9zdCBhbmQNCj4+PiBjYW4gYmUgdXNlZCBpbW1lZGlhdGVseSB0byB0cnkgYWdhaW4g
d2l0aCB0aGUgbmV4dCBmcmFtZSBudW1iZXIuDQo+Pj4NCj4+PiBXaXRoIHRoaXMgY2hhbmdlLCBf
X2R3YzNfZ2FkZ2V0X3N0YXJ0X2lzb2MgaXMgc3RpbGwgbm90IHN1Y2Nlc3NmdWxseSBpbiBhbGwN
Cj4+PiBjYXNlcyBiaXQgaXQgaW5jcmVhc2VzIHRoZSBhY2NlcHRhYmxlIGRlbGF5IGFmdGVyIFhm
ZXJOb3RSZWFkeQ0KPj4+IHNpZ25pZmljYW50bHkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIE9sYnJpY2ggPG0ub2xicmljaEBwZW5ndXRyb25peC5kZT4NCj4+PiAtLS0NCj4+PiAg
ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDEgKw0KPj4+ICAgIGRyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4+PiBpbmRleCAzZGQ3ODNiODg5Y2IuLmM1YjIyMzY1NmUwOCAxMDA2NDQNCj4+
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5oDQo+Pj4gQEAgLTcwOSw2ICs3MDksNyBAQCBzdHJ1Y3QgZHdjM19lcCB7DQo+Pj4g
ICAgCXU4CQkJdHlwZTsNCj4+PiAgICAJdTgJCQlyZXNvdXJjZV9pbmRleDsNCj4+PiAgICAJdTMy
CQkJZnJhbWVfbnVtYmVyOw0KPj4+ICsJdTMyCQkJbGFzdF9mcmFtZV9udW1iZXI7DQo+PiBUaGVy
ZSdzIG5vIG5lZWQgdG8gYWRkIGEgbmV3IGZpZWxkIGZvciBsYXN0X2ZyYW1lX251bWJlci4gSnVz
dCBzdG9yZSB0aGUNCj4+IHZhbHVlIGluIGEgbG9jYWwgdmFyaWFibGUgaW4gX19kd2MzX2dhZGdl
dF9zdGFydF9pc29jKCkuDQo+IEknbSB1c2luZyBpdCB0byBjaGVjayBmb3Igcm9sbG92ZXIsIHNv
IF9fZHdjM19nYWRnZXRfc3RhcnRfaXNvYyBkb2VzIG5vdA0KPiBoZWxwLiBJIGludHJvZHVjZWQg
aXQgYmVjYXVzZSBJIGNhdXNlZCBhIHNlY29uZCAoaW5jb3JyZWN0KSByb2xsb3ZlciB3aGVuDQo+
IHRoZSBmaXJzdCB0cnkgZmFpbGVkLiBCdXQgbm93IHRoYXQgSSB0aGluayBhYm91dCBpdCwgaXQg
c2hvdWxkIGJlIHBvc3NpYmxlDQo+IHdpdGhvdXQgdGhlIGV4dHJhIHZhcmlhYmxlLg0KDQpXZSBk
b24ndCBuZWVkIHRoaXMgZXh0cmEgZmllbGQgZm9yIGR3YzNfZXAuIElmIHlvdSBuZWVkIHRvIGFk
ZCBhIG5ldyANCm9uZSwgdGhlbiB5b3UgbmVlZCB0byBhbHNvIGRlc2NyaWJlIHRoYXQgZmllbGQg
aW4gdGhlIHN0cnVjdCBkd2MzX2VwLg0KDQo+DQo+Pj4gICAgCXUzMgkJCWludGVydmFsOw0KPj4+
ICAgIA0KPj4+ICAgIAljaGFyCQkJbmFtZVsyMF07DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gaW5kZXgg
MTczZjUzMjlkM2Q5Li5hYzQ2NzNkOTE5MzkgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+PiBA
QCAtMTIwNCw3ICsxMjA0LDcgQEAgc3RhdGljIHZvaWQgZHdjM19wcmVwYXJlX3RyYnMoc3RydWN0
IGR3YzNfZXAgKmRlcCkNCj4+PiAgICAJfQ0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiAtc3RhdGlj
IGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+
PiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAg
KmRlcCwgYm9vbCBrZWVwX3JlcSkNCj4+PiAgICB7DQo+Pj4gICAgCXN0cnVjdCBkd2MzX2dhZGdl
dF9lcF9jbWRfcGFyYW1zIHBhcmFtczsNCj4+PiAgICAJc3RydWN0IGR3YzNfcmVxdWVzdAkJKnJl
cTsNCj4+PiBAQCAtMTI0Miw3ICsxMjQyLDcgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tp
Y2tfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+PiAgICAJfQ0KPj4+ICAgIA0KPj4+
ICAgIAlyZXQgPSBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZChkZXAsIGNtZCwgJnBhcmFtcyk7DQo+
Pj4gLQlpZiAocmV0IDwgMCkgew0KPj4+ICsJaWYgKHJldCA8IDAgJiYgKCFrZWVwX3JlcSB8fCBy
ZXQgIT0gLUVBR0FJTikpIHsNCj4+PiAgICAJCS8qDQo+Pj4gICAgCQkgKiBGSVhNRSB3ZSBuZWVk
IHRvIGl0ZXJhdGUgb3ZlciB0aGUgbGlzdCBvZiByZXF1ZXN0cw0KPj4+ICAgIAkJICogaGVyZSBh
bmQgc3RvcCwgdW5tYXAsIGZyZWUgYW5kIGRlbCBlYWNoIG9mIHRoZSBsaW5rZWQNCj4+PiBAQCAt
MTI1NCw3ICsxMjU0LDcgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIo
c3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+PiAgICAJCXJldHVybiByZXQ7DQo+Pj4gICAgCX0NCj4+
PiAgICANCj4+PiAtCXJldHVybiAwOw0KPj4+ICsJcmV0dXJuIHJldDsNCj4+PiAgICB9DQo+Pj4g
ICAgDQo+Pj4gICAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2dldF9mcmFtZShzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPj4+IEBAIC0xMzc3LDcgKzEzNzcsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0
X3N0YXJ0X2lzb2NfcXVpcmsoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4+PiAgICAJZGVwLT5zdGFy
dF9jbWRfc3RhdHVzID0gMDsNCj4+PiAgICAJZGVwLT5jb21ib19udW0gPSAwOw0KPj4+ICAgIA0K
Pj4+IC0JcmV0dXJuIF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXApOw0KPj4+ICsJcmV0
dXJuIF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXAsIGZhbHNlKTsNCj4+PiAgICB9DQo+
Pj4gICAgDQo+Pj4gICAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0X2lzb2Moc3RydWN0
IGR3YzNfZXAgKmRlcCkNCj4+PiBAQCAtMTQwMiw5ICsxNDAyLDIzIEBAIHN0YXRpYyBpbnQgX19k
d2MzX2dhZGdldF9zdGFydF9pc29jKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+Pj4gICAgCX0NCj4+
PiAgICANCj4+PiAgICAJZm9yIChpID0gMDsgaSA8IERXQzNfSVNPQ19NQVhfUkVUUklFUzsgaSsr
KSB7DQo+Pj4gLQkJZGVwLT5mcmFtZV9udW1iZXIgPSBEV0MzX0FMSUdOX0ZSQU1FKGRlcCwgaSAr
IDEpOw0KPj4+ICsJCS8qDQo+Pj4gKwkJICogbGFzdF9mcmFtZV9udW1iZXIgaXMgc2V0IGZyb20g
WGZlck5vdFJlYWR5IGFuZCBtYXkgYmUNCj4+PiArCQkgKiBhbHJlYWR5IG91dCBvZiBkYXRlLiBE
U1RTIG9ubHkgcHJvdmlkZXMgdGhlIGxvd2VyIDE0IGJpdA0KPj4+ICsJCSAqIG9mIHRoZSBjdXJy
ZW50IGZyYW1lIG51bWJlci4gU28gYWRkIHRoZSB1cHBlciB0d28gYml0cyBvZg0KPj4+ICsJCSAq
IGxhc3RfZnJhbWVfbnVtYmVyIGFuZCBoYW5kbGUgYSBwb3NzaWJsZSByb2xsb3Zlci4NCj4+PiAr
CQkgKiBUaGlzIHdpbGwgcHJvdmlkZSB0aGUgY29ycmVjdCBmcmFtZV9udW1iZXIgdW5sZXNzIG1v
cmUgdGhhbg0KPj4+ICsJCSAqIHJvbGxvdmVyIGhhcyBoYXBwZW5lZCBzaW5jZSBYZmVyTm90UmVh
ZHkuDQo+Pj4gKwkJICovDQo+Pj4gKwkJdTMyIGZyYW1lID0gX19kd2MzX2dhZGdldF9nZXRfZnJh
bWUoZHdjKTsNCj4+PiArDQo+Pj4gKwkJZGVwLT5mcmFtZV9udW1iZXIgPSAoZGVwLT5sYXN0X2Zy
YW1lX251bWJlciAmIH4weDNmZmYpIHwgZnJhbWU7DQo+Pj4gKwkJaWYgKGZyYW1lIDwgKGRlcC0+
bGFzdF9mcmFtZV9udW1iZXIgJiAweDNmZmYpKQ0KPj4+ICsJCQlkZXAtPmZyYW1lX251bWJlciAr
PSAweDQwMDA7DQo+PiBVc2UgQklUKDE0KSByYXRoZXIgdGhhbiAweDQwMDA/IEl0J3MgY2xlYXJl
ciBpbiBpbiBteSBvcGluaW9uLiBXZQ0KPiBPay4NCj4NCj4+IHN0YXJ0ZWQgdXNpbmcgMHgzZmZm
IGluIG11bHRpcGxlIHBsYWNlcyBub3csIGNhbiB3ZSBjcmVhdGUgYSBtYWNybyBmb3IgdGhhdD8N
Cj4gTWFrZXMgc2Vuc2UuIEFueSBwcmVmZXJlbmNlcyBmb3IgdGhlIG5hbWU/IDxzb21ldGhpbmc+
X01BU0sgSSBndWVzcywgYnV0IEkNCj4gZG9uJ3Qga25vdyB3aGF0IHRoZSBjb3JyZWN0IG5hbWUg
Zm9yIHRoZSAxNCBiaXQgZnJhbWUgbnVtYmVyIHNob3VsZCBiZS4NCg0KTWF5YmUgeW91IGNhbiB1
c2UgRFdDM19EU1RTX1NPRkZOKH4wKSBhcyBhIG1hc2suDQoNCkJSLA0KVGhpbmgNCg==
