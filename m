Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE5217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="AFdwJTs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbfHGI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:58 -0400
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:6210
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbfHGI0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuAVcj03Rsxf7VAyG0dy+F9gCnN4kY7dmQuGPZmFwWLIYWsqfqt3ZpexZT/sXksWUfsrfodKIweNkTDArR7zTv2n5JJl0MfcBCz0jJxnnljDiDJph8cRN+tUSpf5eoKstfulGm3jNdBGhzU89z1jO9BFxSGhYaqlq5sKUfm7hWMrAc2tT+KVnjnR7NoAWvszU4UjuzcgvnrOIPnseuv+n4KWFh+f0c3oVOqDud2iHwvKnEPfsoCmDQa/edxllP1ykY0vpCubXvWO7uKFwbRE8B15DElTAus/ygF9WZ5fgGjcBSl/PV6N+pA1xXjb0K1nwbt8Z7lgRj/dIEwjh04IPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Ir+N5Ubp3qBJ4EbxAC4nu+WTl+G3a+BREAAsZ6ips=;
 b=UhGGRHaSQoEndD/rRjDkmvCFuyhXRSC01mI/iKTtDJ3Gkuuac/00+xbT/K1wsAas/1XV8Lf2nUDr+iHQhI8Xde1yKpoS6DynUEPZVT2j9aL3X8bqTEIg0I96EMLNA9NoTXVqowAusjI55Z5RMF4K/SCD0mIDiOM0bdMlQS679KgGQzQpnL29/4sAZhSmq6V6EaQGkkcWm7/8sgoC5xYrZLoSTw9oA+vbq4pOvYOk6MYuV2hz5Q/gxN2tq+5Q07AHvK1vDgpu/yi+63VbPeumRhmxCrmzHY2BbokzmAUlufcPAJ9Mcahe3jKnKrgqzvOkXZ+PlRBmzAaJ4qcIbZYsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0Ir+N5Ubp3qBJ4EbxAC4nu+WTl+G3a+BREAAsZ6ips=;
 b=AFdwJTs26yG6NGC/mbp3ZH62jinSdVOWIh8jPHg8sa4zKLah2ytRc+29PEjIE9+mYCLghQJ1T+cmviVF4qvchLAdHMIa+gCvhKKGifNlJKDuCQ0Zc4+ISVDXbK2qYldp5HAUU1PNC24FYXhxuHs1BWiqZupdxFZ4bUDizrjjTcQ=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:49 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:49 +0000
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
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 21/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Topic: [PATCH v3 21/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Index: AQHVTPnbj0jToHnKjkCtlwoMjdIJNA==
Date:   Wed, 7 Aug 2019 08:26:49 +0000
Message-ID: <20190807082556.5013-22-philippe.schenker@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56b62bec-df0b-4870-e05a-08d71b10fde1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614A94C84CDB8BE292CB039F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UdX47PZ4WXRcXH4fTKZ86yVf4NE9t1OLPlTDR4YZZJ9xzjdqTndNDuFSf0X3kCqsIzbNwXpJsFGtXkJ2RH+gHoqiT23kfngxXBWKMDpAnRDiv2GPYtDtyTQQ+fEuheNM/wN59WRAk4xNyR6AaqbDqWoWqhprV4WMdaBOa4EakVHdPcZ+RxJtxwtW0/rk6WlnhG8qrMBE3SlvSE3fCwgoUoMCLXvYAY95/ndqN109/ALMFwdn8JpvJ9/WRe+JFDQ1sXwruYrnUpF6j/ktphztYEG4UuIMV7Poya+HTJvphu5yz/pboKzeG5vRpJJwiWb3nMsnv5/o7+WpPrhXL1ubbMyG+DiO47pd/QIuBatf+emAy0NCIAtiFTyrLa+ESUiJtM+KIhQdV/XKsx0LmrjmXw2zXWSsGLidTPK9oxkyHqw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3139A4FF8FACE4784DFE15E9B07434E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b62bec-df0b-4870-e05a-08d71b10fde1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:49.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kTrjp4ZkmN+A+Ydc5MAeNqF4BjnISWu3OaStFuTHqqsYv+Yl/vEdVuXVjGcuNVbounLkzNGnhDR7eyzMGKi7xAFnVwSERqDE8eScjuJpYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBVSFMgY2FwYWJpbGl0eSB0byBUb3JhZGV4IEV2YWwgQm9hcmRzDQoN
ClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hlbmtlckB0b3Jh
ZGV4LmNvbT4NCg0KLS0tDQoNCkNoYW5nZXMgaW4gdjM6DQotIE5ldyBwYXRjaCB0byBtYWtlIHVz
ZSBvZiBBUk06IGR0czogaW14Ny1jb2xpYnJpOiBmaXggMS44Vi9VSFMgc3VwcG9ydA0KDQpDaGFu
Z2VzIGluIHYyOiBOb25lDQoNCiBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12
My5kdHNpIHwgMTEgKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1j
b2xpYnJpLWV2YWwtdjMuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFs
LXYzLmR0c2kNCmluZGV4IDU3NmRlYzlmZjgxYy4uOTAxMjFmYmU1NjFmIDEwMDY0NA0KLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KQEAgLTIxMCw5ICsyMTAsMTYg
QEANCiB9Ow0KIA0KICZ1c2RoYzEgew0KLQlrZWVwLXBvd2VyLWluLXN1c3BlbmQ7DQotCXdha2V1
cC1zb3VyY2U7DQorCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzdGF0ZV8xMDBtaHoiLCAi
c3RhdGVfMjAwbWh6IjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJsX3VzZGhjMSAmcGluY3RybF9j
ZF91c2RoYzE+Ow0KKwlwaW5jdHJsLTEgPSA8JnBpbmN0cmxfdXNkaGMxXzEwMG1oeiAmcGluY3Ry
bF9jZF91c2RoYzE+Ow0KKwlwaW5jdHJsLTIgPSA8JnBpbmN0cmxfdXNkaGMxXzIwMG1oeiAmcGlu
Y3RybF9jZF91c2RoYzE+Ow0KIAl2bW1jLXN1cHBseSA9IDwmcmVnXzN2Mz47DQorCXZxbW1jLXN1
cHBseSA9IDwmcmVnX0xETzI+Ow0KKwljZC1ncGlvcyA9IDwmZ3BpbzEgMCBHUElPX0FDVElWRV9M
T1c+Ow0KKwlkaXNhYmxlLXdwOw0KKwllbmFibGUtc2Rpby13YWtldXA7DQorCWtlZXAtcG93ZXIt
aW4tc3VzcGVuZDsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQogDQotLSANCjIuMjIuMA0KDQo=
