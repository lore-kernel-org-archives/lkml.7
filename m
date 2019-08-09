Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C0D2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BFwtgRlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407127AbfHIOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:20:44 -0400
Received: from mail-eopbgr20100.outbound.protection.outlook.com ([40.107.2.100]:57157
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfHIOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhaCGdb5sGdiCRkpwVYHYFogVDE0Er9Xy4nXr7hXwdvqiVcv0akj5eYJXgFVf2LVWxi3lRhV3yXG4b8mqYJDuCSsPi7+Dz/p5eUIud7b37vxMZqvehncT/7WIs0yVXECStvQIM194X9ICO8VdW8TYXP71lAy/G15IY1d/BT52Qngj2rg/1UC3ZNwaTXtLKRhjzPdp1X2z5QSulniaK8DZBIlVRWczqnhbS9uMnAn9dsm7b5HpHrXZ9AA7GRMyPR+uIcfRXeQLwWzvNqGi42BFlmfGbe+aMvprlqiaAW5OipkDVU6aBhZUkQPuAs/fuYqqnBhM6WxA/Wg5LTRa3KR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn5/d5Ol5Ve/V4u+MRpEZPDqiH3nlEUVUkcqsBU1ans=;
 b=XnC0XEs1SD0JmTOQHjHXviyC3hkHpEEayEYmi7KGiHMMlmJqzGamuWurqzhWFFC2nhUDz50/0jp7lMGZxerSJ4FSSFePr3iwoA37seyL/LL/VHD8sdiwvOn1fqGW3ZFBtActn4eTbJbPnY/AXsF7Mt1pShSAbXxSqDmL4jAJGH+eSYnQHBUr2hzDaFPwvCaHmdsF+7j7FM0yXRs1BJa4KeFNRj2e6VVjuOnHE+wNKdIqPLKKflwECrOk2XLhlctgLwcMbSuG/0mWFEE0lfidGhi1Tgz8LXXi6TeqlXJ3Q6ZsYs6qlmMW9cUmvePGPxztiVF+7n34wDXaaiQbmxFKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn5/d5Ol5Ve/V4u+MRpEZPDqiH3nlEUVUkcqsBU1ans=;
 b=BFwtgRlXhG98R6WfrzcVOdbay7AgeDY1TUnp+bTLLYhGX2x3JMrW0g9rXVtfIQnKlqJIVW1vHsBKSo47+9fkVdDMQm1Nlx6+BZX4nNMCOjWstxp9if/KxwakLAWhqQ6WckdjDDrEXugULlEGnuaO5dFqRv+oHwph4j1Ib70ZcPw=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB3293.eurprd05.prod.outlook.com (10.170.238.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 9 Aug 2019 14:20:38 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:20:38 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 04/21] ARM: dts: imx7-colibri: Add sleep mode to
 ethernet
Thread-Topic: [PATCH v3 04/21] ARM: dts: imx7-colibri: Add sleep mode to
 ethernet
Thread-Index: AQHVTPnH96JuUo3YOEOwLp+M+8nuNqby4UaA
Date:   Fri, 9 Aug 2019 14:20:38 +0000
Message-ID: <fc209916b83968d019017efcf065b9a29e6e061f.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-5-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-5-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40f53518-5b10-40fd-1a9e-08d71cd4c095
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB3293;
x-ms-traffictypediagnostic: VI1PR05MB3293:
x-microsoft-antispam-prvs: <VI1PR05MB32935D066048163EAF9DB7F1FBD60@VI1PR05MB3293.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39850400004)(396003)(199004)(189003)(81156014)(6506007)(71190400001)(71200400001)(6436002)(6116002)(81166006)(118296001)(478600001)(2201001)(7736002)(6486002)(66476007)(66446008)(2616005)(66946007)(6512007)(8676002)(305945005)(14444005)(46003)(66556008)(44832011)(64756008)(446003)(2906002)(11346002)(229853002)(53936002)(14454004)(36756003)(86362001)(4326008)(102836004)(486006)(256004)(110136005)(476003)(2501003)(6246003)(91956017)(186003)(76116006)(8936002)(76176011)(25786009)(7416002)(99286004)(5660300002)(316002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3293;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9wF8GmM7+jtmJGKKSzONaxKA9lgsuAUHFhgyiEeHyPB91OyH6m9blGkWf67BbHoLqE1BnHe9c9zp+WPUBg341Vy/3o1kqgfZIXKpEU7EupgSSDsqiwMi5RtlJK1ftgAM14OMVdlwFCowKZnhunMb0hROAasZorauokGdX83XcV2WPorlmt15lfbZC9zbDsK1DZ6CfE7PMtsu3YLnGdv92m9gDC8dditKdFdtzE3VtSFzN0hHcyWjxQ2VYPJHbZlq0mbbt6mcYAdsVMgS4XHFRBwfttjX2wgF1MYQ0a+xZRCDogC/yHxu3KtFNztcRGiRSTM8JeJiJLnQZ2lkdXZ8SrWVAyhDVhMnayB3Jfjf5nyzYFf6LL9LfR9f8dSJWxVHRo6OyWrv/SknvyXLPsRXgX8cB7yLbKY7Qot0j2WzsUs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA86C9A909602842B2DD0C11F584CD61@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f53518-5b10-40fd-1a9e-08d71cd4c095
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:20:38.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djYNQ99C5UGXjlBI3OsKJgvcErJaFTn7lbSyJv8uqKh1mU6hRUr+z+PGnobcjQtpvhIbRGoh84RoAnZ2/4bdwWpBEof9jzddVfq240ZQdwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gQWRkIHNsZWVwIHBpbm11eCB0byB0aGUgZmVjIHNvIGl0IGNhbiBwcm9wZXJseSBzbGVl
cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hl
bmtlckB0b3JhZGV4LmNvbT4NCg0KQWNrZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzogTm9uZQ0K
PiBDaGFuZ2VzIGluIHYyOiBOb25lDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xp
YnJpLmR0c2kgfCAxOSArKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTgg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1j
b2xpYnJpLmR0c2kNCj4gaW5kZXggNTIwNDYwODVjZTZmLi5hOGQ5OTJmM2U4OTcgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+IEBAIC0xMDEsOCArMTAxLDkgQEANCj4g
IH07DQo+ICANCj4gICZmZWMxIHsNCj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAr
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ICAJcGluY3RybC0wID0gPCZw
aW5jdHJsX2VuZXQxPjsNCj4gKwlwaW5jdHJsLTEgPSA8JnBpbmN0cmxfZW5ldDFfc2xlZXA+Ow0K
PiAgCWNsb2NrcyA9IDwmY2xrcyBJTVg3RF9FTkVUX0FYSV9ST09UX0NMSz4sDQo+ICAJCTwmY2xr
cyBJTVg3RF9FTkVUX0FYSV9ST09UX0NMSz4sDQo+ICAJCTwmY2xrcyBJTVg3RF9FTkVUMV9USU1F
X1JPT1RfQ0xLPiwNCj4gQEAgLTQ2Myw2ICs0NjQsMjIgQEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAg
DQo+ICsJcGluY3RybF9lbmV0MV9zbGVlcDogZW5ldDFzbGVlcGdycCB7DQo+ICsJCWZzbCxwaW5z
ID0gPA0KPiArCQkJTVg3RF9QQURfRU5FVDFfUkdNSUlfUlhfQ1RMX19HUElPN19JTzQJCQ0KPiAw
eDANCj4gKwkJCU1YN0RfUEFEX0VORVQxX1JHTUlJX1JEMF9fR1BJTzdfSU8wCQkNCj4gMHgwDQo+
ICsJCQlNWDdEX1BBRF9FTkVUMV9SR01JSV9SRDFfX0dQSU83X0lPMQkJDQo+IDB4MA0KPiArCQkJ
TVg3RF9QQURfRU5FVDFfUkdNSUlfUlhDX19HUElPN19JTzUJCQ0KPiAweDANCj4gKw0KPiArCQkJ
TVg3RF9QQURfRU5FVDFfUkdNSUlfVFhfQ1RMX19HUElPN19JTzEwCQkNCj4gMHgwDQo+ICsJCQlN
WDdEX1BBRF9FTkVUMV9SR01JSV9URDBfX0dQSU83X0lPNgkJDQo+IDB4MA0KPiArCQkJTVg3RF9Q
QURfRU5FVDFfUkdNSUlfVEQxX19HUElPN19JTzcJCQ0KPiAweDANCj4gKwkJCU1YN0RfUEFEX0dQ
SU8xX0lPMTJfX0dQSU8xX0lPMTIJCQkNCj4gMHgwDQo+ICsJCQlNWDdEX1BBRF9TRDJfQ0RfQl9f
R1BJTzVfSU85CQkJDQo+IDB4MA0KPiArCQkJTVg3RF9QQURfU0QyX1dQX19HUElPNV9JTzEwCQkJ
DQo+IDB4MA0KPiArCQk+Ow0KPiArCX07DQo+ICsNCj4gIAlwaW5jdHJsX2Vjc3BpM19jczogZWNz
cGkzLWNzLWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg3RF9QQURfSTJDMl9TREFf
X0dQSU80X0lPMTEJCTB4MTQNCg==
