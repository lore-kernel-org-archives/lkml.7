Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E1AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BF82083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ha7C/oP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbfDRIyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:54:14 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:26434
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfDRIyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftedEL5YcIyd6GVzZ0adl1YQDvgiExdlIw9IcP5GXbQ=;
 b=Ha7C/oP9Pu57Zqsq0UolnmM9oKxuohQOpuo9tHbx7AxKSLuyaY95IT+jOz+hXda3/Js447On5M05uNPktA6bcwksAuE4URAu+uWe9WOPHdP/GQD9JWDdUoPZyUUCtVV8yYovPTPLW3LCD8+FAoTB3KT1uSVWQligO9pxYp4n0cc=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4943.eurprd04.prod.outlook.com (20.177.49.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 08:54:07 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1792.022; Thu, 18 Apr 2019
 08:54:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Angus Ainslie <angus.ainslie@puri.sm>,
        "angus@akkea.ca" <angus@akkea.ca>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/3] dmaengine: imx-sdma: Only check ratio on parts
 that support 1:1
Thread-Topic: [PATCH v2 2/3] dmaengine: imx-sdma: Only check ratio on parts
 that support 1:1
Thread-Index: AQHU5kMf8SHxIesVX0ekA25GcdTQ3KZBulEA
Date:   Thu, 18 Apr 2019 08:54:07 +0000
Message-ID: <1555577278.24617.6.camel@nxp.com>
References: <20190328133828.20999-1-angus@akkea.ca>
         <20190329152130.18411-1-angus@akkea.ca>
         <20190329152130.18411-3-angus@akkea.ca>
In-Reply-To: <20190329152130.18411-3-angus@akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77fe0424-7e9b-4001-6031-08d6c3db6aee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4943;
x-ms-traffictypediagnostic: VI1PR04MB4943:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB4943E36FD9EE5DFE0B6303E289260@VI1PR04MB4943.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(25786009)(3846002)(6116002)(5660300002)(54906003)(7416002)(50226002)(103116003)(99286004)(476003)(316002)(486006)(36756003)(110136005)(66066001)(11346002)(446003)(71190400001)(71200400001)(6512007)(53936002)(4326008)(6246003)(229853002)(14454004)(8936002)(14444005)(478600001)(256004)(81166006)(97736004)(6486002)(2616005)(81156014)(2501003)(8676002)(305945005)(53546011)(2906002)(86362001)(6506007)(186003)(6436002)(68736007)(102836004)(76176011)(7736002)(26005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4943;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LGWHVPtTRnt6Sxa9PEe83RmmS4fEdTGkbizkuvbBCJGNTkYf+HvBYOqsPwIyRZcbvOCfK0GjiCp5dSbMnxk8p1DRrNU7H/Eu6xn/JB2+mLlMFZrSQzzjnDu4LH9wi2J8L9bMyoRcpPfj0vfxbpOeqb8AsRiBtJrUs/ZdswdLhcv1ObiQEaTU1Pd8SRxxPbdb3Sxwk1/KYikVj6n6X4pilm4m61qnwwtoEBlxYAohVswYseWOBFCEFuqYoMOYYEVbRw35IHrfuJI7vOXtVDOepQoQh1Xix7/njXkS/9AyS71NtcZs3w/Wp2hKlylhfH+xop9hj+agFVzP1EmrFccOuWI3K56TlJ+zWY59rd/9dHver+3BbQpwVCkuq7vE7MCZRz0NOn2HKn8eFehBNmiv/I8lCnvLAgBJ2huRpTYCqGE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <180C68F3FABDB24BB48245062CAFE008@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fe0424-7e9b-4001-6031-08d6c3db6aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 08:54:07.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCk9uIDIwMTktMDMtMjkg
YXQgMTU6MjEgKzAwMDAsIEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgd3JvdGU6DQo+IE9uIGlteDht
cSBCMCBjaGlwLCBBSEIvU0RNQSBjbG9jayByYXRpbyAyOjEgY2FuJ3QgYmUgc3VwcG9ydGVkLA0K
PiBzaW5jZSBTRE1BIGNsb2NrIHJhdGlvIGhhcyB0byBiZSBpbmNyZWFzZWQgdG8gMjUwTWh6LCBB
SEIgY2FuJ3QgcmVhY2gNCj4gdG8gNTAwTWh6LCBzbyB1c2UgMToxIGluc3RlYWQuDQo+IA0KPiBU
byBsaW1pdCB0aGlzIGNoYW5nZSB0byB0aGUgaW14OG1xIGZvciBub3cgdGhpcyBwYXRjaCBhbHNv
IGFkZHMgYW4NCj4gaW04bXEtc2RtYSBjb21wYXRpYmxlIHN0cmluZy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ3VzIEFpbnNsaWUgKFB1cmlzbSkgPGFuZ3VzQGFra2VhLmNhPg0KPiAtLS0NCj4g
wqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTUgKysrKysrKysrKysrKystDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KPiBp
bmRleCA1ZjNjMTM3OGI5MGUuLjk5ZDlmNDMxYWUyYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9k
bWEvaW14LXNkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+IEBAIC00MTks
NiArNDE5LDcgQEAgc3RydWN0IHNkbWFfZHJpdmVyX2RhdGEgew0KPiDCoAlpbnQgY2huZW5ibDA7
DQo+IMKgCWludCBudW1fZXZlbnRzOw0KPiDCoAlzdHJ1Y3Qgc2RtYV9zY3JpcHRfc3RhcnRfYWRk
cnMJKnNjcmlwdF9hZGRyczsNCj4gKwlib29sIGNoZWNrX3JhdGlvOw0KPiDCoH07DQo+IMKgDQo+
IMKgc3RydWN0IHNkbWFfZW5naW5lIHsNCj4gQEAgLTU1Nyw2ICs1NTgsMTMgQEAgc3RhdGljIHN0
cnVjdCBzZG1hX2RyaXZlcl9kYXRhIHNkbWFfaW14N2QgPSB7DQo+IMKgCS5zY3JpcHRfYWRkcnMg
PSAmc2RtYV9zY3JpcHRfaW14N2QsDQo+IMKgfTsNCj4gwqANCj4gK3N0YXRpYyBzdHJ1Y3Qgc2Rt
YV9kcml2ZXJfZGF0YSBzZG1hX2lteDhtcSA9IHsNCj4gKwkuY2huZW5ibDAgPSBTRE1BX0NITkVO
QkwwX0lNWDM1LA0KPiArCS5udW1fZXZlbnRzID0gNDgsDQo+ICsJLnNjcmlwdF9hZGRycyA9ICZz
ZG1hX3NjcmlwdF9pbXg3ZCwNCj4gKwkuY2hlY2tfcmF0aW8gPSAxLA0KPiArfTsNCj4gKw0KPiDC
oHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIHNkbWFfZGV2dHlwZXNbXSA9
IHsNCj4gwqAJew0KPiDCoAkJLm5hbWUgPSAiaW14MjUtc2RtYSIsDQo+IEBAIC01NzksNiArNTg3
LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQNCj4gc2RtYV9kZXZ0
eXBlc1tdID0gew0KPiDCoAl9LCB7DQo+IMKgCQkubmFtZSA9ICJpbXg3ZC1zZG1hIiwNCj4gwqAJ
CS5kcml2ZXJfZGF0YSA9ICh1bnNpZ25lZCBsb25nKSZzZG1hX2lteDdkLA0KPiArCX0sIHsNCj4g
KwkJLm5hbWUgPSAiaW14OG1xLXNkbWEiLA0KPiArCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQg
bG9uZykmc2RtYV9pbXg4bXEsDQo+IMKgCX0sIHsNCj4gwqAJCS8qIHNlbnRpbmVsICovDQo+IMKg
CX0NCj4gQEAgLTU5Myw2ICs2MDQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBzZG1hX2R0X2lkc1tdID0NCj4gew0KPiDCoAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgzMS1z
ZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXgzMSwgfSwNCj4gwqAJeyAuY29tcGF0aWJsZSA9ICJmc2ws
aW14MjUtc2RtYSIsIC5kYXRhID0gJnNkbWFfaW14MjUsIH0sDQo+IMKgCXsgLmNvbXBhdGlibGUg
PSAiZnNsLGlteDdkLXNkbWEiLCAuZGF0YSA9ICZzZG1hX2lteDdkLCB9LA0KPiArCXsgLmNvbXBh
dGlibGUgPSAiZnNsLGlteDhtcS1zZG1hIiwgLmRhdGEgPSAmc2RtYV9pbXg4bXEsIH0sDQo+IMKg
CXsgLyogc2VudGluZWwgKi8gfQ0KPiDCoH07DQo+IMKgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwg
c2RtYV9kdF9pZHMpOw0KPiBAQCAtMTg1Miw3ICsxODY0LDggQEAgc3RhdGljIGludCBzZG1hX2lu
aXQoc3RydWN0IHNkbWFfZW5naW5lICpzZG1hKQ0KPiDCoAlpZiAocmV0KQ0KPiDCoAkJZ290byBk
aXNhYmxlX2Nsa19pcGc7DQo+IMKgDQo+IC0JaWYgKGNsa19nZXRfcmF0ZShzZG1hLT5jbGtfYWhi
KSA9PSBjbGtfZ2V0X3JhdGUoc2RtYS0NCj4gPmNsa19pcGcpKQ0KPiArCWlmIChzZG1hLT5kcnZk
YXRhLT5jaGVja19yYXRpbyAmJg0KPiArCcKgwqDCoMKgKGNsa19nZXRfcmF0ZShzZG1hLT5jbGtf
YWhiKSA9PSBjbGtfZ2V0X3JhdGUoc2RtYS0NCj4gPmNsa19pcGcpKSkNCj4gwqAJCXNkbWEtPmNs
a19yYXRpbyA9IDE7DQo+IMKgDQo+IMKgCS8qIEJlIHN1cmUgU0RNQSBoYXMgbm90IHN0YXJ0ZWQg
eWV0ICov
