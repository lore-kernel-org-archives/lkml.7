Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0630C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FE20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="aXXrZdqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfHLOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:20 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728965AbfHLOWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajKnqoIuUDjrJKvRs2WM598i2cBf1iELCC4sgo9gPaSRfWF4kPJF0rAU+YJIKWuV/ZNlVp0M7wePvdtz+lIhb7KH3LKJVyrmJVn34DwRR2mq7bt021PLBP7Y4uVmn9Xx1kuKFaqytOTS/yntRR/VJraKXjhsXwDj8TSHgu4+y4CaVGNdGL5cobbFDZjIwli1KhLTk5v45NYqkLRBp7QczLHAq0k6Y7gZG4j8RefXc91MrCK1IJijKtA1LXq2usEe95De56HAAO5ZjfOcqM32ihNyS3r0lVc9+PvBgZPg/pCziEs51ijXFUtxISHXrPLr3tAs040w0HqhSof8KwI88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tAr1GIzPqc9erXN+gVJpeUYVqBdlaXWfA3rv6//Yl4=;
 b=HyNrA+4Yv2QA+xK74IAXI07VaTLlFs5Lkje5HI6aJrx0RzGfjs0nQO82kddDVZMDOpBftn8pqvctJ+4JKahCcI+vWeu5JYlzRga9qWzcb4b7WSOPYAiFdd3/i683knswcS6tV5UnNti2rJLaBkwN9RnOFWDGmF645iDP+v1jikIH3dzGQloZRzK6vFa8x/3XFkbKj/HVfqtapI9LHY8DW+dFkzPFt6Q350wk0TYE8QYlaASHkW8/y3yiJXTiKL8hT+p2La65knnOd+7dEMygxKJlXIun7LVdDv7oEn4o/MWzrnJuvUClJOaWTEHd9KDofBzl7OdjJ/9xL+K7/OUTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tAr1GIzPqc9erXN+gVJpeUYVqBdlaXWfA3rv6//Yl4=;
 b=aXXrZdqdwPxmYAKbeOIC6e1TD8bxykK+iUs10OiYGMIzAYbMnX0BN9dN66N8y+OHuAytP60MmJz7EaQP6C4wjYlozbhFXcBBUmPKmZjZeQahwUqSk+nzeh/wmUQPb+zYGHHfIGPaIwzZSybQPWFgcX7A0RZq7srQ5Ce+4Omg6fU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:47 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:47 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 21/21] ARM: dts: imx6qdl-colibri.dtsi: UHS-I support for
 v1.1a hw
Thread-Topic: [PATCH v4 21/21] ARM: dts: imx6qdl-colibri.dtsi: UHS-I support
 for v1.1a hw
Thread-Index: AQHVURlGJmcIK6KxnkK60xS6fTE6VQ==
Date:   Mon, 12 Aug 2019 14:21:47 +0000
Message-ID: <20190812142105.1995-22-philippe.schenker@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec61211-e0a6-463f-aa50-08d71f3068a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942D12104097B1D8C9ECACCF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(1496009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PBPUIGfqklvjJtYGZGEQwJPWAuE9bLNT6VJsspJvXhZKU5kYdEK8vwkIeHBVTXAOHDHJ+AIZJHwP1hTiC/9v2dd5iHs6iSEwaNdDp2t2g27Xwe90dJtU7PVQTs8fZ2BN9J6dHlYnQhzbRptAYuuwOaefDFzRdAbCgy+3dbsguGsnlU4MvQh76jY3ilNLTcFajfpGRvUaz+zeLIcH23QttsB7wGVOhsB8xJ7mIpGTzVpgFVyQFlxcZkF9G2NevC+SXS6oe/kCsRt8hAOw7v0MMWchbP7eMDqF6gcAd5Dq3xH7zRRkgPVyPh0tcIeBLp0BvzUNMC0oiRyHg9Hu/+KB3D3TiyWGL66y62d1G7SxZzV4U4SBsvDdFBUTGAB/by+/x9GZJ/i0f63BpDPVZhiUssfnthF3+9BHjD2RKhV4RKI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E152F845EAF2941B1550AFAB2D71F5C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec61211-e0a6-463f-aa50-08d71f3068a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:47.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2bR9RbEdhp23xGRWW9hCtsM/ok4FJnG1wDF4VsTOcMHysaRAlbYpzwSaqyA3mrTE504HoFoi3QqS6NtlARNqnoiLvuT9+0kaMQrjsA+v+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQoNClByb3ZpZGUg
cHJvcGVyIGNvbmZpZ3VyYXRpb24gZm9yIFZHRU4zLCB0byBtYWtlIHN1cmUgaXQncyBpcyBhbHdh
eXMgcG93ZXJlZA0Kd2hpY2ggYWxsb3dzIHRoYXQgcmFpbCB0byBiZSBhdXRvbWF0aWNhbGx5IHN3
aXRjaGVkIHRvIDEuOCB2b2x0cw0KZm9yIHByb3BlciBVSFMtSSBvcGVyYXRpb24uIEJ5IGRlZmF1
bHQgaXQncyBkaXNhYmxlZC4NCg0KV2l0aCBVSFMtSSBlbmFibGVkOg0KWyAgMTA0LjE1Mzg5OF0g
bW1jMTogbmV3IHVsdHJhIGhpZ2ggc3BlZWQgU0RSMTA0IFNESEMgY2FyZCBhdCBhZGRyZXNzIDU5
YjQNClsgIDEwNC4xNjYyMDJdIG1tY2JsazE6IG1tYzE6NTliNCBVU0QwMCAxNS4wIEdpQg0KWyAg
MTA0LjE3MzkyM10gIG1tY2JsazE6IHAxDQoNCnJvb3RAY29saWJyaS1pbXg2On4jIGhkcGFybSAt
dCAvZGV2L21tY2JsazENCi9kZXYvbW1jYmxrMToNClRpbWluZyBidWZmZXJlZCBkaXNrIHJlYWRz
OiAyMjYgTUIgaW4gIDMuMDEgc2Vjb25kcyA9ICA3NS4wMSBNQi9zZWMNCg0KU2lnbmVkLW9mZi1i
eTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCi0t
LQ0KDQpDaGFuZ2VzIGluIHY0Og0KLSBOZXcgcGF0Y2ggYXMgb2YgdGhlIHJlY29tbWVuZGF0aW9u
IGZyb20gTWFyY2VsIG9uIE1MDQoNCkNoYW5nZXMgaW4gdjM6IE5vbmUNCkNoYW5nZXMgaW4gdjI6
IE5vbmUNCg0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgNDMgKysr
KysrKysrKysrKysrKysrKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
ZGwtY29saWJyaS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kN
CmluZGV4IDlhNjNkZWJhYjBiNS4uMDI0MTYxM2I1ZTJiIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtY29saWJyaS5kdHNpDQpAQCAtMjI2LDcgKzIyNiwxMiBAQA0KIAkJCQlyZWd1bGF0b3It
YWx3YXlzLW9uOw0KIAkJCX07DQogDQotCQkJLyogdmdlbjM6IHVudXNlZCAqLw0KKwkJCXZnZW4z
X3JlZzogdmdlbjMgew0KKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsN
CisJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQorCQkJCXJlZ3VsYXRv
ci1ib290LW9uOw0KKwkJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KKwkJCX07DQogDQogCQkJdmdl
bjRfcmVnOiB2Z2VuNCB7DQogCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+
Ow0KQEAgLTM5NCwxMyArMzk5LDIxIEBADQogDQogLyogQ29saWJyaSBNTUMgKi8NCiAmdXNkaGMx
IHsNCi0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IiwgInN0YXRlXzEwMG1oeiIsICJzdGF0ZV8yMDBtaHoiOw0KIAlwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfdXNkaGMxICZwaW5jdHJsX21tY19jZD47DQorCXBpbmN0cmwtMSA9IDwmcGluY3RybF91
c2RoYzFfMTAwbWh6ICZwaW5jdHJsX21tY19jZD47DQorCXBpbmN0cmwtMiA9IDwmcGluY3RybF91
c2RoYzFfMjAwbWh6ICZwaW5jdHJsX21tY19jZD47DQorCXZxbW1jLXN1cHBseSA9IDwmdmdlbjNf
cmVnPjsNCisJc2QtdWhzLXNkcjEyOw0KKwlzZC11aHMtc2RyMjU7DQorCXNkLXVocy1zZHI1MDsN
CisJc2QtdWhzLXNkcjEwNDsNCisJbGFiZWwgPSAiTU1DMSI7DQogCWNkLWdwaW9zID0gPCZncGlv
MiA1IEdQSU9fQUNUSVZFX0xPVz47IC8qIE1NQ0QgKi8NCiAJZGlzYWJsZS13cDsNCi0JdnFtbWMt
c3VwcGx5ID0gPCZyZWdfbW9kdWxlXzN2Mz47DQorCWVuYWJsZS1zZGlvLXdha2V1cDsNCisJa2Vl
cC1wb3dlci1pbi1zdXNwZW5kOw0KIAlidXMtd2lkdGggPSA8ND47DQotCW5vLTEtOC12Ow0KIAlz
dGF0dXMgPSAiZGlzYWJsZWQiOw0KIH07DQogDQpAQCAtNzA2LDYgKzcxOSwyOCBAQA0KIAkJPjsN
CiAJfTsNCiANCisJcGluY3RybF91c2RoYzFfMTAwbWh6OiB1c2RoYzFncnAxMDBtaHogew0KKwkJ
ZnNsLHBpbnMgPSA8DQorCQkJTVg2UURMX1BBRF9TRDFfQ01EX19TRDFfQ01EICAgIDB4MTcwYjEN
CisJCQlNWDZRRExfUEFEX1NEMV9DTEtfX1NEMV9DTEsgICAgMHgxMDBiMQ0KKwkJCU1YNlFETF9Q
QURfU0QxX0RBVDBfX1NEMV9EQVRBMCAweDE3MGIxDQorCQkJTVg2UURMX1BBRF9TRDFfREFUMV9f
U0QxX0RBVEExIDB4MTcwYjENCisJCQlNWDZRRExfUEFEX1NEMV9EQVQyX19TRDFfREFUQTIgMHgx
NzBiMQ0KKwkJCU1YNlFETF9QQURfU0QxX0RBVDNfX1NEMV9EQVRBMyAweDE3MGIxDQorCQk+Ow0K
Kwl9Ow0KKw0KKwlwaW5jdHJsX3VzZGhjMV8yMDBtaHo6IHVzZGhjMWdycDIwMG1oeiB7DQorCQlm
c2wscGlucyA9IDwNCisJCQlNWDZRRExfUEFEX1NEMV9DTURfX1NEMV9DTUQgICAgMHgxNzBmMQ0K
KwkJCU1YNlFETF9QQURfU0QxX0NMS19fU0QxX0NMSyAgICAweDEwMGYxDQorCQkJTVg2UURMX1BB
RF9TRDFfREFUMF9fU0QxX0RBVEEwIDB4MTcwZjENCisJCQlNWDZRRExfUEFEX1NEMV9EQVQxX19T
RDFfREFUQTEgMHgxNzBmMQ0KKwkJCU1YNlFETF9QQURfU0QxX0RBVDJfX1NEMV9EQVRBMiAweDE3
MGYxDQorCQkJTVg2UURMX1BBRF9TRDFfREFUM19fU0QxX0RBVEEzIDB4MTcwZjENCisJCT47DQor
CX07DQorDQogCXBpbmN0cmxfdXNkaGMzOiB1c2RoYzNncnAgew0KIAkJZnNsLHBpbnMgPSA8DQog
CQkJTVg2UURMX1BBRF9TRDNfQ01EX19TRDNfQ01ECTB4MTcwNTkNCi0tIA0KMi4yMi4wDQoNCg==
