Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE2C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF13222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GcTMAUAd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Db/DgNAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfKMDzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:55:54 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:40950 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfKMDzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:55:53 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C1F3C08F3;
        Wed, 13 Nov 2019 03:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573617351; bh=xa2hnDJUhe0w6qNTI2D+FLWY5ywbReXE7n9vZPXR4bw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GcTMAUAdKxDa5arfSOhRvqo/aP9dws8RbdESPSbLiEHpRWnQ/aq71fYCS8QF/RmJj
         MzPl0Q1T0NhNZ0LL0+tY5L4f26Tnl22nWu22RXiqprPo9WVqMHDxEij56cmZMVD0nu
         AyQts2WclD+4lADn7K9YuUme/oiFTEWfjxFCHket3BaWlfp487ipG5hgJk+xXwDQTo
         fnUHBlrj1GUtFyYwdPRLQNZbj9JgH5LFq44obakoPNpfJQq5dlS1mb14yLIoxwqewE
         3tD8LajyGzgl0UdDSMH6v1TMqiia23BG7D3NdljTfS08E//RnpdiVKxt5J3zGDBxRl
         Nj8t1UZVpbFag==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DEFD8A0085;
        Wed, 13 Nov 2019 03:55:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Nov 2019 19:55:32 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 12 Nov 2019 19:55:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaGr9yLVqZflMJbKdpm7N5WkdVlVqr/BFkD6Ox6fUnbYlJ9qptachy17AKrR/u8tHvOeEkzoao9/uytaq41UcvBCVvLjQodL0JI41KX6Ihngj+QfLqZj0YuDRNmqPwBzh4bG1Kv9rjYvia7l8gTtsSe8OxUncn/jTqggjh0GgTLeaV7CSWqQIns8qeQ/7AwcHsQRFXvBkzvAC6QRtC0nDQzrACiOZcYZygprb0I+WX3570M50yzRYEjbUpomUV+Ub0q4SIuXl5y48sy0tbX5QnpwfH/Gp+jZLZN1AhbyKJnF7ZilH+wIsj18YVOvLc5lNvTmD8M9CWgQeRT+mYeydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa2hnDJUhe0w6qNTI2D+FLWY5ywbReXE7n9vZPXR4bw=;
 b=SHt/O63VfSMHUztogAe8cADI+UyfoEqo9cjZxtwzbOzkSkDNXUi1N5sJkndYK7Xa4AspsDnyHjAzXGdaYy9RateZKqwJcgto3R/8v5edx0bQHkd8CTg0XhzB7xR26ea+ux2tImMLIRjvHykPrtIRoz7Lk2Yy7PQU5WEcOKB/iDRyNXAwUkk+bBjMRTPr8IV5cAFj0BBe1gpKgQo+uWeze7NYYtmJfox02K+EgqOhTRkD4khC1fjAIDznzes+drqHSKn1yGEHgsaT/N293N9WSwgpOqCBZiR4cA0xQvdM2DCbQgf4HwrhfEzFk4NMomyp8hcILQ/rnH29vmLK+t1P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa2hnDJUhe0w6qNTI2D+FLWY5ywbReXE7n9vZPXR4bw=;
 b=Db/DgNAC+ts3WFYIFZ5BsQ6Et2WMN4XjIcNd8UwdLUETj03P/O+csuwWlgrwMOixwvKUpZG61hCq9n9ZXCAzYexu1Y0Vi+6fLtRcySTtNwE0NAjShclHwnKU7to/u5crKHAIw3octGoVoCMBp0GdMkmzG+2KBHKdB3Fvc8OfU+Q=
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) by
 CY4PR1201MB0008.namprd12.prod.outlook.com (10.172.118.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 03:55:31 +0000
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3]) by CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 03:55:31 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Michael Olbrich <m.olbrich@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Thread-Topic: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more
 robust
Thread-Index: AQHVmKSIKei7LJoy3kCzXLTfw8XpmaeIexeA
Date:   Wed, 13 Nov 2019 03:55:30 +0000
Message-ID: <49416a44-6317-c3e5-dca6-d33f3d8c9c89@synopsys.com>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
 <20191111152645.13792-2-m.olbrich@pengutronix.de>
In-Reply-To: <20191111152645.13792-2-m.olbrich@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5954fb7f-0bb6-4e96-c87c-08d767ed5401
x-ms-traffictypediagnostic: CY4PR1201MB0008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB000885595F853E9C5A705250AA760@CY4PR1201MB0008.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(31696002)(66556008)(14444005)(81156014)(36756003)(8936002)(8676002)(66476007)(316002)(81166006)(99286004)(25786009)(76116006)(110136005)(71190400001)(2501003)(54906003)(71200400001)(66946007)(64756008)(256004)(5660300002)(6246003)(66446008)(4326008)(86362001)(229853002)(11346002)(6506007)(6512007)(446003)(26005)(102836004)(7736002)(14454004)(305945005)(31686004)(6486002)(478600001)(2906002)(186003)(486006)(66066001)(6116002)(2616005)(476003)(6436002)(76176011)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0008;H:CY4PR1201MB0037.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87fDV2WoE2IRC/t+SLml9f0rWdSQCYfS9R5PSitEE1HFNP2N5iD7JpBVPNd5DVcG0onYHKn97+5vOk17qZIJuLN0NHlCzfiSLBR1fziS8kmIPY3oIzKJUtLVXd6HZhwh6cHL/317RRzVSV5dPWQfntsMWKHeUf4UDw/I2dGEK9ErcW9iUZDcgjgzlnLozEsDQyj17hqac1sPMRdh4CMclpju5wXkYtlw31BnvJqxRHZCXxawJzMPkdGHnJhOc0n4T8fR/OGjrEUDub1Rob9WkiPE3k8Hp/El105fDHSC4sw3aMQv0PHVNHtpwmKs/e23mMkP7f4RqDaMHxcaDA35UiUqjdVouCBK43mwIluDpjylQ9kk5YWAXFw21Uqd+AnFMyVWGE7jjqmDUlDatE+fcSbTUKksCR4mtP5CdnfaepJJXKJ4ljPX0EkbnU3lTZat
Content-Type: text/plain; charset="utf-8"
Content-ID: <3954C857FD5EAE4BAC66B704465101F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5954fb7f-0bb6-4e96-c87c-08d767ed5401
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 03:55:30.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01S512yMGjb8IWVjF1sxg0nB+KZsSeGSW990T4YUVF380Sy3bwVYRyWwRFmrXgEovqJ5tnuGMhMRMF+Ash9lBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk1pY2hhZWwgT2xicmljaCB3cm90ZToNCj4gQ3VycmVudGx5IF9fZHdjM19nYWRnZXRf
c3RhcnRfaXNvYyBtdXN0IGJlIGNhbGxlZCB2ZXJ5IHNob3J0bHkgYWZ0ZXINCj4gWGZlck5vdFJl
YWR5LiBPdGhlcndpc2UgdGhlIGZyYW1lIG51bWJlciBpcyBvdXRkYXRlZCBhbmQgc3RhcnQgdHJh
bnNmZXINCj4gd2lsbCBmYWlsLCBldmVuIHdpdGggc2V2ZXJhbCByZXRyaWVzLg0KPg0KPiBEU1RT
IHByb3ZpZGVzIHRoZSBsb3dlciAxNCBiaXQgb2YgdGhlIGZyYW1lIG51bWJlci4gVXNlIGl0IGlu
IGNvbWJpbmF0aW9uDQo+IHdpdGggdGhlIGZyYW1lIG51bWJlciBwcm92aWRlZCBieSBYZmVyTm90
UmVhZHkgdG8gZ3Vlc3MgdGhlIGN1cnJlbnQgZnJhbWUNCj4gbnVtYmVyLiBUaGlzIHdpbGwgc3Vj
Y2VlZCB1bmxlc3MgbW9yZSB0aGFuIG9uZSAxNCByb2xsb3ZlciBoYXMgaGFwcGVuZWQNCj4gc2lu
Y2UgWGZlck5vdFJlYWR5Lg0KPg0KPiBTdGFydCB0cmFuc2ZlciBtaWdodCBzdGlsbCBmYWlsIGlm
IHRoZSBmcmFtZSBudW1iZXIgaXMgaW5jcmVhc2VkDQo+IGltbWVkaWF0ZWx5IGFmdGVyIERTVFMg
aXMgcmVhZC4gU28gcmV0cmllcyBhcmUgc3RpbGwgbmVlZGVkLg0KPiBEb24ndCBkcm9wIHRoZSBj
dXJyZW50IHJlcXVlc3QgaWYgdGhpcyBoYXBwZW5zLiBUaGlzIHdheSBpdCBpcyBub3QgbG9zdCBh
bmQNCj4gY2FuIGJlIHVzZWQgaW1tZWRpYXRlbHkgdG8gdHJ5IGFnYWluIHdpdGggdGhlIG5leHQg
ZnJhbWUgbnVtYmVyLg0KPg0KPiBXaXRoIHRoaXMgY2hhbmdlLCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0
X2lzb2MgaXMgc3RpbGwgbm90IHN1Y2Nlc3NmdWxseSBpbiBhbGwNCj4gY2FzZXMgYml0IGl0IGlu
Y3JlYXNlcyB0aGUgYWNjZXB0YWJsZSBkZWxheSBhZnRlciBYZmVyTm90UmVhZHkNCj4gc2lnbmlm
aWNhbnRseS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBPbGJyaWNoIDxtLm9sYnJpY2hA
cGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAg
MSArDQo+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDMxICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDNkZDc4M2I4ODljYi4uYzViMjIzNjU2
ZTA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtNzA5LDYgKzcwOSw3IEBAIHN0cnVjdCBkd2MzX2Vw
IHsNCj4gICAJdTgJCQl0eXBlOw0KPiAgIAl1OAkJCXJlc291cmNlX2luZGV4Ow0KPiAgIAl1MzIJ
CQlmcmFtZV9udW1iZXI7DQo+ICsJdTMyCQkJbGFzdF9mcmFtZV9udW1iZXI7DQoNClRoZXJlJ3Mg
bm8gbmVlZCB0byBhZGQgYSBuZXcgZmllbGQgZm9yIGxhc3RfZnJhbWVfbnVtYmVyLiBKdXN0IHN0
b3JlIHRoZSANCnZhbHVlIGluIGEgbG9jYWwgdmFyaWFibGUgaW4gX19kd2MzX2dhZGdldF9zdGFy
dF9pc29jKCkuDQoNCj4gICAJdTMyCQkJaW50ZXJ2YWw7DQo+ICAgDQo+ICAgCWNoYXIJCQluYW1l
WzIwXTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDE3M2Y1MzI5ZDNkOS4uYWM0NjczZDkxOTM5IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTEyMDQsNyArMTIwNCw3IEBAIHN0YXRpYyB2b2lkIGR3
YzNfcHJlcGFyZV90cmJzKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICAgCX0NCj4gICB9DQo+ICAg
DQo+IC1zdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3QgZHdjM19l
cCAqZGVwKQ0KPiArc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoc3RydWN0
IGR3YzNfZXAgKmRlcCwgYm9vbCBrZWVwX3JlcSkNCj4gICB7DQo+ICAgCXN0cnVjdCBkd2MzX2dh
ZGdldF9lcF9jbWRfcGFyYW1zIHBhcmFtczsNCj4gICAJc3RydWN0IGR3YzNfcmVxdWVzdAkJKnJl
cTsNCj4gQEAgLTEyNDIsNyArMTI0Miw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9raWNr
X3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICAgCX0NCj4gICANCj4gICAJcmV0ID0g
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoZGVwLCBjbWQsICZwYXJhbXMpOw0KPiAtCWlmIChyZXQg
PCAwKSB7DQo+ICsJaWYgKHJldCA8IDAgJiYgKCFrZWVwX3JlcSB8fCByZXQgIT0gLUVBR0FJTikp
IHsNCj4gICAJCS8qDQo+ICAgCQkgKiBGSVhNRSB3ZSBuZWVkIHRvIGl0ZXJhdGUgb3ZlciB0aGUg
bGlzdCBvZiByZXF1ZXN0cw0KPiAgIAkJICogaGVyZSBhbmQgc3RvcCwgdW5tYXAsIGZyZWUgYW5k
IGRlbCBlYWNoIG9mIHRoZSBsaW5rZWQNCj4gQEAgLTEyNTQsNyArMTI1NCw3IEBAIHN0YXRpYyBp
bnQgX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICAg
CQlyZXR1cm4gcmV0Ow0KPiAgIAl9DQo+ICAgDQo+IC0JcmV0dXJuIDA7DQo+ICsJcmV0dXJuIHJl
dDsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2dldF9mcmFtZShz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiBAQCAtMTM3Nyw3ICsxMzc3LDcgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9zdGFydF9pc29jX3F1aXJrKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICAgCWRlcC0+
c3RhcnRfY21kX3N0YXR1cyA9IDA7DQo+ICAgCWRlcC0+Y29tYm9fbnVtID0gMDsNCj4gICANCj4g
LQlyZXR1cm4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCk7DQo+ICsJcmV0dXJuIF9f
ZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXAsIGZhbHNlKTsNCj4gICB9DQo+ICAgDQo+ICAg
c3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X3N0YXJ0X2lzb2Moc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4gQEAgLTE0MDIsOSArMTQwMiwyMyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfc3RhcnRf
aXNvYyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7
IGkgPCBEV0MzX0lTT0NfTUFYX1JFVFJJRVM7IGkrKykgew0KPiAtCQlkZXAtPmZyYW1lX251bWJl
ciA9IERXQzNfQUxJR05fRlJBTUUoZGVwLCBpICsgMSk7DQo+ICsJCS8qDQo+ICsJCSAqIGxhc3Rf
ZnJhbWVfbnVtYmVyIGlzIHNldCBmcm9tIFhmZXJOb3RSZWFkeSBhbmQgbWF5IGJlDQo+ICsJCSAq
IGFscmVhZHkgb3V0IG9mIGRhdGUuIERTVFMgb25seSBwcm92aWRlcyB0aGUgbG93ZXIgMTQgYml0
DQo+ICsJCSAqIG9mIHRoZSBjdXJyZW50IGZyYW1lIG51bWJlci4gU28gYWRkIHRoZSB1cHBlciB0
d28gYml0cyBvZg0KPiArCQkgKiBsYXN0X2ZyYW1lX251bWJlciBhbmQgaGFuZGxlIGEgcG9zc2li
bGUgcm9sbG92ZXIuDQo+ICsJCSAqIFRoaXMgd2lsbCBwcm92aWRlIHRoZSBjb3JyZWN0IGZyYW1l
X251bWJlciB1bmxlc3MgbW9yZSB0aGFuDQo+ICsJCSAqIHJvbGxvdmVyIGhhcyBoYXBwZW5lZCBz
aW5jZSBYZmVyTm90UmVhZHkuDQo+ICsJCSAqLw0KPiArCQl1MzIgZnJhbWUgPSBfX2R3YzNfZ2Fk
Z2V0X2dldF9mcmFtZShkd2MpOw0KPiArDQo+ICsJCWRlcC0+ZnJhbWVfbnVtYmVyID0gKGRlcC0+
bGFzdF9mcmFtZV9udW1iZXIgJiB+MHgzZmZmKSB8IGZyYW1lOw0KPiArCQlpZiAoZnJhbWUgPCAo
ZGVwLT5sYXN0X2ZyYW1lX251bWJlciAmIDB4M2ZmZikpDQo+ICsJCQlkZXAtPmZyYW1lX251bWJl
ciArPSAweDQwMDA7DQoNClVzZSBCSVQoMTQpIHJhdGhlciB0aGFuIDB4NDAwMD8gSXQncyBjbGVh
cmVyIGluIGluIG15IG9waW5pb24uIFdlIA0Kc3RhcnRlZCB1c2luZyAweDNmZmYgaW4gbXVsdGlw
bGUgcGxhY2VzIG5vdywgY2FuIHdlIGNyZWF0ZSBhIG1hY3JvIGZvciB0aGF0Pw0KDQpBbHNvLCBh
ZGQgYW4gZW1wdHkgbGluZSBoZXJlLg0KDQo+ICsJCWRlcC0+ZnJhbWVfbnVtYmVyID0gRFdDM19B
TElHTl9GUkFNRShkZXAsIDEpOw0KPiAgIA0KPiAtCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X2tpY2tf
dHJhbnNmZXIoZGVwKTsNCj4gKwkJcmV0ID0gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRl
cCwNCj4gKwkJCQlpICsgMSA8IERXQzNfSVNPQ19NQVhfUkVUUklFUyk7DQo+ICAgCQlpZiAocmV0
ICE9IC1FQUdBSU4pDQo+ICAgCQkJYnJlYWs7DQo+ICAgCX0NCj4gQEAgLTE0NjEsNyArMTQ3NSw3
IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgZHdjM19lcCAqZGVw
LCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpDQo+ICAgCQl9DQo+ICAgCX0NCj4gICANCj4gLQly
ZXR1cm4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRlcCk7DQo+ICsJcmV0dXJuIF9fZHdj
M19nYWRnZXRfa2lja190cmFuc2ZlcihkZXAsIGZhbHNlKTsNCj4gICB9DQo+ICAgDQo+ICAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVz
Yl9yZXF1ZXN0ICpyZXF1ZXN0LA0KPiBAQCAtMjQ2Nyw3ICsyNDgxLDcgQEAgc3RhdGljIGludCBk
d2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0KHN0cnVjdCBkd2MzX2VwICpk
ZXAsDQo+ICAgDQo+ICAgCWlmICghZHdjM19nYWRnZXRfZXBfcmVxdWVzdF9jb21wbGV0ZWQocmVx
KSAmJg0KPiAgIAkJCXJlcS0+bnVtX3BlbmRpbmdfc2dzKSB7DQo+IC0JCV9fZHdjM19nYWRnZXRf
a2lja190cmFuc2ZlcihkZXApOw0KPiArCQlfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVw
LCBmYWxzZSk7DQo+ICAgCQlnb3RvIG91dDsNCj4gICAJfQ0KPiAgIA0KPiBAQCAtMjQ5Nyw2ICsy
NTExLDcgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZW5kcG9pbnRfZnJhbWVfZnJvbV9ldmVu
dChzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiAgIAkJY29uc3Qgc3RydWN0IGR3YzNfZXZlbnRfZGVw
ZXZ0ICpldmVudCkNCj4gICB7DQo+ICAgCWRlcC0+ZnJhbWVfbnVtYmVyID0gZXZlbnQtPnBhcmFt
ZXRlcnM7DQo+ICsJZGVwLT5sYXN0X2ZyYW1lX251bWJlciA9IGV2ZW50LT5wYXJhbWV0ZXJzOw0K
PiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lbmRwb2ludF90cmFuc2Zl
cl9pbl9wcm9ncmVzcyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KDQpPdGhlciB0aGFuIHRoZSBjb21t
ZW50cyBJIHByb3ZpZGVkLCB0aGlzIHBhdGNoIGxvb2tzIGZpbmUgdG8gbWUuDQoNCkJSLA0KVGhp
bmgNCg==
