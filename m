Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729FCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AC1214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eFVQEGs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfHNLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:38:10 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:39904
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbfHNLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxa6wmSrGB3ZJVor39rMCeSKLBVuSNzimQQ0R/c+0wpWvDdwjt+BLfF1VYocl3iVAVJXrBM2Xcp1V1Ms11JurV6JVzumZGMdIkOAzZEU++sj4GIa2MY+JMngemS+axG9yigI9zivAARXNWeclVPqVuPOvnnwA7GK3FYBJ7uoPwONyo7i2BLnbaB3yZOC2G6LQGz4WmfF3Bj3T0qCM1R4Wfz1eFUry/DoKgCoSZqqeH9KyO2PL+/dXMHBb0OtRExtMqNw1B2Ohf5xm4jl3dxOYBKDeckjkR5ovqjC0Dv2iqIRvv86xzUQ/wUxErIGUsGrjTbIoQLU4MvKQiPxpfDuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGvStH97hN5KA1jYJJxbzFMjQxTExgQzdZDrN9Dg4s=;
 b=d+AMifxjRLSZfK7dXjvYWC60+12kAyne/s8LefUNMEih8/DscNQuycxtWBwsvqDCPcvpdHBLA8eIlr0ujSehCwiHDxeZQXhOCITBLKiJZiDL8BnFm0qXjOsJ9X1OmXB/rUgAuMXi9n+NL9VnSkUygOu8dGtFl93f5bUec3XCoOdmKWzn8CyzuYr45d78yf7reZkcAk+gvjvOsdH+7ZR//JQYrtP4jvtwotsDLh1zJkwLapNImO+/C6tjDeqpVgjsL1XWF722Op9R5tyUyoMCssmvcd6ZWxtU1tkzSGc7f87VRbjsjXQdUyqlnBtHTdAycX19EJAcE/OeKL9nFo16GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGvStH97hN5KA1jYJJxbzFMjQxTExgQzdZDrN9Dg4s=;
 b=eFVQEGs6uiRJZl6tsrXMlxRJ8y8wB4a3LfM/aQgYqH+40/HnsOU0kEVb0ysfifj3H4YLgDZ5zZZVB6VyIKE1jS79TN2D/QGGS78aqh4b9BSYlGgQMWT2DvZyRn7BeKl4FKvO92sQbUljnxxD8mz1f/J+0QIunnWzhPUdaa8Urco=
Received: from DB8PR04MB6715.eurprd04.prod.outlook.com (20.179.251.14) by
 DB8PR04MB6521.eurprd04.prod.outlook.com (20.179.249.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Wed, 14 Aug 2019 11:38:04 +0000
Received: from DB8PR04MB6715.eurprd04.prod.outlook.com
 ([fe80::b0ab:d127:ca27:e1fa]) by DB8PR04MB6715.eurprd04.prod.outlook.com
 ([fe80::b0ab:d127:ca27:e1fa%7]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 11:38:04 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     dl-linux-imx <linux-imx@nxp.com>, "marex@denx.de" <marex@denx.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v2 04/15] drm/mxsfb: Reset vital register for a
 proper initialization
Thread-Topic: [EXT] Re: [PATCH v2 04/15] drm/mxsfb: Reset vital register for a
 proper initialization
Thread-Index: AQHVUo3iq1oLFGPb4kudfeiwmFE2Gab6fM+AgAAHjQA=
Date:   Wed, 14 Aug 2019 11:38:04 +0000
Message-ID: <1565782684.3209.70.camel@nxp.com>
References: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
         <1565779731-1300-5-git-send-email-robert.chiras@nxp.com>
         <18d5f58deba8044042ab7b8d98a72803@agner.ch>
In-Reply-To: <18d5f58deba8044042ab7b8d98a72803@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d930685-c849-46bd-2062-08d720abdeb8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6521;
x-ms-traffictypediagnostic: DB8PR04MB6521:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6521B5B7FB34A7C3139C886BE3AD0@DB8PR04MB6521.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(76116006)(91956017)(86362001)(8676002)(229853002)(2351001)(6916009)(66446008)(66946007)(71200400001)(25786009)(6512007)(71190400001)(66556008)(103116003)(66476007)(14444005)(53936002)(64756008)(4326008)(6486002)(6246003)(2906002)(2501003)(5640700003)(256004)(305945005)(7736002)(3846002)(76176011)(6116002)(5660300002)(6436002)(6506007)(478600001)(99286004)(7416002)(66066001)(1730700003)(50226002)(54906003)(36756003)(316002)(81156014)(486006)(14454004)(446003)(44832011)(11346002)(476003)(2616005)(81166006)(8936002)(26005)(102836004)(186003)(53546011)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6521;H:DB8PR04MB6715.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y1LlJK0tuldwy09FA/SlsekgAsVo0NcDd4CJBZxPFQbfmxHopM4uJ5wprBO/J08Mj5JsBp0XSUe8QKrMUd21LAIyyV74DBZGSiPsHUJqCjsOgpMrlBiNLfXbarF2loJ/45XIZmBYAlShOnZypVLTVKWwmjpx+LOHCUklWHDPV9ZQJ25eDWAq7N3y8lDY3jwNJpCr76Nk/KoH81afyPtrRmmmcZujcaLVOfpr+pNdYFlic3tgLNRY8YeFbx8sAo0+6NxyOTIpxihsaqCyUcrJLidkZsTf581aJ5GyyAeRGPGhIOqyLT6l9LDb+tEN79f+i6q2GWO/3e4Jxm7XMDEjX9W7SLzewwrxK40HtbGugywJcIDSCF0jqDvX+paW7uktuIDA54v5JhfBjYyjswMGP9ClL2BZFXQLJ11sCPRpPCI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AC5ED09E3F817418DF1D1C078A6B676@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d930685-c849-46bd-2062-08d720abdeb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 11:38:04.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4itAu+j9mMZWNtBJQmAJH18c+4daP+k/QOsrhzu15l53JqZZMrGgmOyk9VKt0RGhJRLPcxGO5zybhlV9nf1MCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlZmFuLA0KDQpPbiBNaSwgMjAxOS0wOC0xNCBhdCAxMzoxMSArMDIwMCwgU3RlZmFuIEFn
bmVyIHdyb3RlOg0KPiBPbiAyMDE5LTA4LTE0IDEyOjQ4LCBSb2JlcnQgQ2hpcmFzIHdyb3RlOg0K
PiA+IA0KPiA+IFNvbWUgb2YgdGhlIHJlZ2l0ZXJzIG5lZWQsIGxpa2UgTENEQ19DVFJMIGFuZA0K
PiA+IENUUkwyX09VVFNUQU5ESU5HX1JFUVMNCj4gVHlwbyBpbiByZWdpc3RlcnMsIGFuZCB0aGVy
ZSBpcyBhIG5lZWQgdG8gbWFueS4NClRoYW5rcywgd2lsbCBmaXggdGhpcy4NCj4gDQo+ID4gDQo+
ID4gbmVlZHMgdG8gYmUgcHJvcGVybHkgY2xlYXJlZCBhbmQgaW5pdGlhbGl6ZWQgZm9yIGEgYmV0
dGVyIHN0YXJ0IGFuZA0KPiA+IHN0b3ANCj4gPiByb3V0aW5lLg0KPiANCj4gDQo+ID4gDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0IENoaXJhcyA8cm9iZXJ0LmNoaXJhc0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL214c2ZiL214c2ZiX2NydGMuYyB8IDEy
ICsrKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL214c2ZiL214c2ZiX2NydGMuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL214c2ZiL214c2ZiX2NydGMuYw0KPiA+IGluZGV4IGI2OWFj
ZTguLjVlNDRmNTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL214c2ZiL214c2Zi
X2NydGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9teHNmYi9teHNmYl9jcnRjLmMNCj4g
PiBAQCAtMTI3LDYgKzEyNywxMCBAQCBzdGF0aWMgdm9pZCBteHNmYl9lbmFibGVfY29udHJvbGxl
cihzdHJ1Y3QNCj4gPiBteHNmYl9kcm1fcHJpdmF0ZSAqbXhzZmIpDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNsa19wcmVwYXJlX2VuYWJsZShteHNmYi0+Y2xrX2Rpc3BfYXhpKTsN
Cj4gPiDCoMKgwqDCoMKgwqBjbGtfcHJlcGFyZV9lbmFibGUobXhzZmItPmNsayk7DQo+ID4gDQo+
ID4gK8KgwqDCoMKgwqBpZiAobXhzZmItPmRldmRhdGEtPmlwdmVyc2lvbiA+PSA0KQ0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdyaXRlbChDVFJMMl9PVVRTVEFORElOR19SRVFTKFJF
UV8xNiksDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteHNm
Yi0+YmFzZSArIExDRENfVjRfQ1RSTDIgKyBSRUdfU0VUKTsNCj4gPiArDQo+ID4gwqDCoMKgwqDC
oMKgLyogSWYgaXQgd2FzIGRpc2FibGVkLCByZS1lbmFibGUgdGhlIG1vZGUgYWdhaW4gKi8NCj4g
PiDCoMKgwqDCoMKgwqB3cml0ZWwoQ1RSTF9ET1RDTEtfTU9ERSwgbXhzZmItPmJhc2UgKyBMQ0RD
X0NUUkwgKyBSRUdfU0VUKTsNCj4gPiANCj4gPiBAQCAtMTM2LDEyICsxNDAsMTkgQEAgc3RhdGlj
IHZvaWQgbXhzZmJfZW5hYmxlX2NvbnRyb2xsZXIoc3RydWN0DQo+ID4gbXhzZmJfZHJtX3ByaXZh
dGUgKm14c2ZiKQ0KPiA+IMKgwqDCoMKgwqDCoHdyaXRlbChyZWcsIG14c2ZiLT5iYXNlICsgTENE
Q19WRENUUkw0KTsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqB3cml0ZWwoQ1RSTF9SVU4sIG14c2Zi
LT5iYXNlICsgTENEQ19DVFJMICsgUkVHX1NFVCk7DQo+ID4gK8KgwqDCoMKgwqB3cml0ZWwoQ1RS
TDFfUkVDT1ZFUllfT05fVU5ERVJGTE9XLCBteHNmYi0+YmFzZSArIExDRENfQ1RSTDENCj4gPiAr
IFJFR19TRVQpOw0KPiBUaGlzIHNlZW1zIG5vdCB0byBiZSBhY2NvdW50ZWQgZm9yIGluIHRoZSBj
b21taXQgbWVzc2FnZS4gQ2FuIHlvdSBkbw0KPiB0aGlzIGluIGEgc2VwYXJhdGUgY29tbWl0Pw0K
PiANCj4gQWxzbyBJIHN1Z2dlc3QgdG8gaW50cm9kdWNlIENUUkwxX1JFQ09WRVJZX09OX1VOREVS
RkxPVyBpbiB0aGF0IHNhbWUNCj4gY29tbWl0Lg0KWW91IGFyZSByaWdodCwgSSBtaXNzZWQgdGhp
cyBvbmUgaW4gdGhlIGRlc2NyaXB0aW9uLiBJIHdpbGwgYWRkIHRoaXMNCm9uZSB0b28uDQo+IA0K
PiAtLQ0KPiBTdGVmYW4NCj4gDQo+ID4gDQo+ID4gwqB9DQo+ID4gDQo+ID4gwqBzdGF0aWMgdm9p
ZCBteHNmYl9kaXNhYmxlX2NvbnRyb2xsZXIoc3RydWN0IG14c2ZiX2RybV9wcml2YXRlDQo+ID4g
Km14c2ZiKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqDCoHUzMiByZWc7DQo+ID4gDQo+ID4gK8Kg
wqDCoMKgwqBpZiAobXhzZmItPmRldmRhdGEtPmlwdmVyc2lvbiA+PSA0KQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHdyaXRlbChDVFJMMl9PVVRTVEFORElOR19SRVFTKDB4NyksDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBteHNmYi0+YmFzZSAr
IExDRENfVjRfQ1RSTDIgKyBSRUdfQ0xSKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqB3cml0ZWwo
Q1RSTF9SVU4sIG14c2ZiLT5iYXNlICsgTENEQ19DVFJMICsgUkVHX0NMUik7DQo+ID4gKw0KPiA+
IMKgwqDCoMKgwqDCoC8qDQo+ID4gwqDCoMKgwqDCoMKgwqAqIEV2ZW4gaWYgd2UgZGlzYWJsZSB0
aGUgY29udHJvbGxlciBoZXJlLCBpdCB3aWxsIHN0aWxsDQo+ID4gY29udGludWUNCj4gPiDCoMKg
wqDCoMKgwqDCoCogdW50aWwgaXRzIEZJRk9zIGFyZSBydW5uaW5nIG91dCBvZiBkYXRhDQo+ID4g
QEAgLTI5NSw2ICszMDYsNyBAQCB2b2lkIG14c2ZiX2NydGNfZW5hYmxlKHN0cnVjdCBteHNmYl9k
cm1fcHJpdmF0ZQ0KPiA+ICpteHNmYikNCj4gPiDCoMKgwqDCoMKgwqBkbWFfYWRkcl90IHBhZGRy
Ow0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoG14c2ZiX2VuYWJsZV9heGlfY2xrKG14c2ZiKTsNCj4g
PiArwqDCoMKgwqDCoHdyaXRlbCgwLCBteHNmYi0+YmFzZSArIExDRENfQ1RSTCk7DQo+ID4gwqDC
oMKgwqDCoMKgbXhzZmJfY3J0Y19tb2RlX3NldF9ub2ZiKG14c2ZiKTsNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqAvKiBXcml0ZSBjdXJfYnVmIGFzIHdlbGwgdG8gYXZvaWQgYW4gaW5pdGlhbCBjb3Jy
dXB0IGZyYW1lICovDQoNClRoYW5rcywNClJvYmVydA==
