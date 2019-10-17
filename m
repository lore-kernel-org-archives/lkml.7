Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD7FA372D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ag6vyrxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408174AbfJQIKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:10:04 -0400
Received: from mail-eopbgr130138.outbound.protection.outlook.com ([40.107.13.138]:18752
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392887AbfJQIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCrEJnc//Ftw3lSu2WhPeZOgNWRpjDFCaGpIm93NCJDR/4NJ9bxu5SiGk/u+DrYzNkGC5kVchQwv1CoRK8FhzJRKQ40sIey1RD5ytcPmyKVRZAFlOKj4IJrP0ccZsmT3qgVylrNPlbWS9/LQ83cOBmJLmtUN0gSfpQON5eMIBhqI+DUYsjFu6ucRfO0BFF5CIshYFmxBd74S6h/k2d7l/T40ihSxvMjvbb9GmMD2C5uTk1kFYjetEU79+7LaI/T00WR5mlZTej1IqOqhz89wFmurjtsPlNamdnqCrMjl9fOVkMbe8tE2XMlOXhQodTgOZsD9A/oZ2RjAOHk2n8aOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl6NUUHBW12Zsc0JeyEoOsLdUgM3nSisJc4Ix8k11KE=;
 b=cIBWeD2mfjZ/T1Hq0JvN3np6HXlJQoprZaDTL734rII9cmB/N1cCj0s9bf8VEMo877A/dKlNMJ1kKo5YMskj6UR/NQZFraFmE5/PF2IWXD/T7RitXAD8fqPGrBvq7wWlwa6jIK2Grg4j4jifjs1ciR4PhKNV63cn1auOkCuzv10tDgFeOYxgR6beG73cXcMhem5mSJdboB2vpGogdqs+pS4elYj7pjzu15r9zZFI5rLulop158YWxyA2o2AHumzprv6HC1ucIxdve5CxZfGGP34AdR1pWLcrZMhFf0CrSZK/Xy+f4bF5UhcEQMVvBQIjS7OTtgzAnc5ouXPP55uR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl6NUUHBW12Zsc0JeyEoOsLdUgM3nSisJc4Ix8k11KE=;
 b=ag6vyrxu37dYvKzlNeIkIyEXyalmiuP4fzegAXgFwYfBuLvhTfgrcflEU+LjQpuzo48OjFfkkzMtywQbZXCeKwhCUoSpF7uujT/KDikYtj481/rzLgLQhVsiUKy/ckdlMX5J5RED7q6dHVqSh6X88rpB0ZLmMo9pwBPGEWUoc5Q=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB4080.eurprd05.prod.outlook.com (52.134.18.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 08:09:20 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 08:09:20 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: [PATCH v1 2/3] tty: serial: lpuart: Use defines that correspond
 to correct register
Thread-Topic: [PATCH v1 2/3] tty: serial: lpuart: Use defines that correspond
 to correct register
Thread-Index: AQHVhDUHkqKVuU+c6E+orQizzb4u3qddtmYAgADFiYA=
Date:   Thu, 17 Oct 2019 08:09:20 +0000
Message-ID: <543cd256f408a175c734c7be5b5210839bc33b49.camel@toradex.com>
References: <20191016151845.15859-1-philippe.schenker@toradex.com>
         <20191016151845.15859-2-philippe.schenker@toradex.com>
         <8512c4712d0500c1c46186c2b52a7350@agner.ch>
In-Reply-To: <8512c4712d0500c1c46186c2b52a7350@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5626db2d-61d9-4674-8acb-08d752d95052
x-ms-traffictypediagnostic: VI1PR0502MB4080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB4080DCCA48773EC622827E9DF46D0@VI1PR0502MB4080.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(189003)(199004)(486006)(5640700003)(2616005)(8676002)(71190400001)(3846002)(14454004)(99286004)(6116002)(4326008)(446003)(81166006)(11346002)(81156014)(1730700003)(6436002)(53546011)(2501003)(102836004)(8936002)(71200400001)(36756003)(5660300002)(6506007)(76176011)(6916009)(66066001)(186003)(26005)(6246003)(6512007)(476003)(44832011)(2351001)(7736002)(86362001)(66946007)(256004)(64756008)(66476007)(66556008)(76116006)(4001150100001)(91956017)(66446008)(25786009)(316002)(229853002)(2906002)(54906003)(118296001)(478600001)(6486002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4080;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHHUyySLCaFJvH+oapNvLZBMBuQC6tb8vtWcxTQsH4E+upzr53oJwA1fYG2CQ4bl9L1vRNm/+SPIoXg2hbmxB1lYp3wVZEQ9VYV561UKBjDM9eHgEJoYCdI29plMYnWmAC5Hrvb9SYP/36ulLaER1UK0JXhcrVYFbvCMMsOBv1a9fvkVYRTYyH8xb37fMeZUYq0H7Cki4aNJJeW87doPBeAfMoPU62Uz3idFLi8ftzFWb0eVRqQLf3u+bPz60F1JGfjig38R7U6gu6DyGMTGaFfWD2VjKDhf7mcbMwBw5ifaUSYHIiUuvo4S3TIl9yb53l0Zi5ik/76M957VB0r+eTZ8YfeVPT6nG8A+arwmHlH3IEUW3mpybyRHfalGh29lC8VhKBomp1Fatt/U4gyXh7qb9NV2FJZvH4JkdKHX5yg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF47106BEA92FA4ABDD1DB0391264BEB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5626db2d-61d9-4674-8acb-08d752d95052
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 08:09:20.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNSn33x3dqWjJU1qlYRQ++j3AZygaD5sOga5hzut2zmDfSiOqdjeEUQVYy+/SGSpHNCPYngKvpUCQSbtXHfD/6sjtZnDUhSfTPrYgO7H5eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDIyOjIyICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDIwMTktMTAtMTYgMTc6MTgsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IFVzZSBV
QVJUTU9ESVIgZGVmaW5lcyBpbnN0ZWFkIG9mIFVBUlRNT0RFTSBhcyBpdCBpcyBhIDMyLWJpdA0K
PiA+IGZ1bmN0aW9uDQo+IA0KPiBUaGlzIHJlYWRzIGEgYml0IHN0cmFuZ2UgYXQgZmlyc3QuIEFs
c28gaXQgaXMgaGVscGZ1bCBmb3IgbGF0ZXIgdG8NCj4gc3RhdGUNCj4gdGhhdCB0aGlzIGRvZXMg
bm90IG1ha2UgYSBkaWZmZXJlbmNlIGluIHByYWN0aXNlLCBzbyBob3cgYWJvdXQ6DQo+IA0KPiBV
c2UgZGVmaW5lIGZyb20gdGhlIDMyLWJpdCByZWdpc3RlciBkZXNjcmlwdGlvbiBVQVJUTU9ESVJf
KiBpbnN0ZWFkIG9mDQo+IFVBUlRNT0RFTV8qLiBUaGUgdmFsdWUgaXMgdGhlIHNhbWUsIHNvIHRo
ZXJlIGlzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gT3RoZXJ3aXNlIGxvb2tzIGdvb2Qg
dG8gbWU6DQo+IA0KPiBSZXZpZXdlZC1ieTogU3RlZmFuIEFnbmVyIDxzdGVmYW4uYWduZXJAdG9y
YWRleC5jb20+DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnQuIEFuZCBhbHNv
IHRoYW5rcyB0byBBbmR5IER1YW4gZm9yIGhpcw0KcmV2aWV3cyENCg0KWW91J3JlIHJpZ2h0LCBJ
IGNvdWxkIGhhdmUgaW5jbHVkZWQgdGhhdCBzbyBpdCBpcyBjbGVhciB0aGF0IG5vdGhpbmcgaXMN
CmNoYW5nZWQuIEkgd2lsbCBzZW5kIGEgdjIgdG9kYXkgd2l0aCB5b3VyIHN1Z2dlc3RlZCBjb21t
aXQgbWVzc2FnZQ0KDQpQaGlsaXBwZQ0KDQo+IA0KPiAtLQ0KPiBTdGVmYW4NCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXgu
Y29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5j
IHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1
YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBpbmRleCBm
MzI3MTg1NzYyMWMuLjM0NmI0YTA3MGNlOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVh
cnQuYw0KPiA+IEBAIC0xODc5LDEwICsxODc5LDEwIEBAIGxwdWFydDMyX3NldF90ZXJtaW9zKHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsDQo+ID4gc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zLA0KPiA+
ICAJfQ0KPiA+ICANCj4gPiAgCWlmICh0ZXJtaW9zLT5jX2NmbGFnICYgQ1JUU0NUUykgew0KPiA+
IC0JCW1vZGVtIHw9IFVBUlRNT0RFTV9SWFJUU0UgfCBVQVJUTU9ERU1fVFhDVFNFOw0KPiA+ICsJ
CW1vZGVtIHw9IChVQVJUTU9ESVJfUlhSVFNFIHwgVUFSVE1PRElSX1RYQ1RTRSk7DQo+ID4gIAl9
IGVsc2Ugew0KPiA+ICAJCXRlcm1pb3MtPmNfY2ZsYWcgJj0gfkNSVFNDVFM7DQo+ID4gLQkJbW9k
ZW0gJj0gfihVQVJUTU9ERU1fUlhSVFNFIHwgVUFSVE1PREVNX1RYQ1RTRSk7DQo+ID4gKwkJbW9k
ZW0gJj0gfihVQVJUTU9ESVJfUlhSVFNFIHwgVUFSVE1PRElSX1RYQ1RTRSk7DQo+ID4gIAl9DQo+
ID4gIA0KPiA+ICAJaWYgKHRlcm1pb3MtPmNfY2ZsYWcgJiBDU1RPUEIpDQo=
