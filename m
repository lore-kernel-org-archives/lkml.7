Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41558C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F6F2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="YdtBAZhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGaLhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:37:47 -0400
Received: from mail-eopbgr10131.outbound.protection.outlook.com ([40.107.1.131]:4838
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfGaLhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:37:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR2x1acSmbYbMaNIB8NtoZ3kOhomuK0kuUId3YYbGTWG3F9Gfy2e+Ga05Cy82uW2NUyA6cMia7VOVluqHFTeHQPPYAqEizhLa+ql8wbbZ1tUqzH/5kYT4T9qOG6zVH7X7vj3Fp5n/MKxX9c9howx1DV0KzlF+OSUbUuitIUjCGkYjLT8scRiHzH3hrvQzZg1+s8cr241vljuoLOU2Ar5b7LB7ITkqy+hdo77qnOI5NDvp3pPMaFGJ/kMaUtKFKoIeJ4/xpHX+FRHoS51u5HGWntCNS/q+ZEVI1gbBhxbDrV1g07svnFnXvy5N+vn/eOk8J6oTwCjCi38uSqTtYkxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aFHZlTWyjlPsp6xp0vTSNG8pSRuXDYsXfXdUt+4/+8=;
 b=NGueaxUOseCuX+D4OENg9ZRGL2KFXGiC68qNSC10IjoCeVo6r50Nfv209Ota6VHWa2WLMcCq7WIaQ5KhiMZCluznKAuh4jqt/+0X0vB8X37ltjs1tJrOL1V5uKd3R5RfouzZ4RzfUHClS7SVWQvCM3XF6URp+RkZ72uwMPaqIu81/G+Ng+gzUqO40MHKHzmUlLKMhtftc7xmB1SJTMCYtD71Tch3cxpft9YlLsNwigR/iYhr+TkAeraoYbpxrHsQJg32PbABKOgKj8kr2aoVCpIE0WFskpKH5aHZnB9SYKNPSpwKZgvnLjxcrmQQCucLsuIDIWAokFlxwh7mJXVw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aFHZlTWyjlPsp6xp0vTSNG8pSRuXDYsXfXdUt+4/+8=;
 b=YdtBAZhZUT4lXBhxyPd5LGEiGR+AjI0Bbowm4d7t+F8ieLq5VyNkYPXoV3WQbb30Xz4gCDb7KZXlhh8BVnBg+T04Mg2+ySyXqJe8yG7cDCGLykEZtBurVMIcuHUqLR2jw3F6sx/+UG8XIaZ/C9HvgZg21hbFmM3HIbMk3BSmMeU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3936.eurprd05.prod.outlook.com (52.134.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 11:36:59 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 11:36:59 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH 14/22] ARM: dts: apalis-imx6: Add some example I2C devices
Thread-Topic: [PATCH 14/22] ARM: dts: apalis-imx6: Add some example I2C
 devices
Thread-Index: AQHVRucp6AbYXDObNEykhBnWam5wmKbjo94AgAD22QA=
Date:   Wed, 31 Jul 2019 11:36:59 +0000
Message-ID: <cd35b9553397f51153ccb5cea9205f91f659cfdf.camel@toradex.com>
References: <20190730144649.19022-1-dev@pschenker.ch>
         <20190730144649.19022-15-dev@pschenker.ch>
         <CAOMZO5BtXFR7kDuiHedsDA0AaNZqsO_L2x9d3u9ZuULkovChoQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BtXFR7kDuiHedsDA0AaNZqsO_L2x9d3u9ZuULkovChoQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826cc606-761f-409d-1108-08d715ab6622
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3936;
x-ms-traffictypediagnostic: VI1PR0502MB3936:
x-microsoft-antispam-prvs: <VI1PR0502MB393652737B36BF888197A43CF4DF0@VI1PR0502MB3936.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(66066001)(76116006)(66556008)(64756008)(66446008)(66476007)(71190400001)(66946007)(91956017)(2906002)(478600001)(316002)(44832011)(6916009)(446003)(2616005)(71200400001)(11346002)(6486002)(476003)(6246003)(7416002)(1411001)(486006)(229853002)(25786009)(14454004)(118296001)(4326008)(2351001)(8676002)(36756003)(86362001)(81156014)(3846002)(305945005)(6512007)(14444005)(76176011)(6436002)(256004)(102836004)(53546011)(6506007)(1730700003)(6116002)(99286004)(7736002)(5640700003)(5660300002)(54906003)(8936002)(2501003)(53936002)(68736007)(81166006)(26005)(1361003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3936;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Gi13gKNTvC/rCdxlnoiydr1SQuq4Z6/XSCXWPJgsuOtj1fSymBCp0kQpI9CojT1JY5tpHD09/es7tDVDJD07qGK6VpEgPLhGtcD5MchD1MTQfOxY/16jIMN1zrZ+4kjwiEtpWWBqhcVQlgbO4COV9bbQpiQuWZw8AUlFJ4oDNeGcs/JAV373IW0IRWM5i92RemBFgVUTlSbVVL6loiY5T6ypm2zNH5M6vFEbCbvaTIDSGjF7fh+R/izi0BPYAaYWtTN0LkrSBD1i0bpGqgMCm4oLJQxGxEXHC/oPwUmPzGasUawKTYuOy7AsV5I5rJTOzlfwC6nR03lUARN08hMPGJmcSFELkRkwhNpBeqDvPJeugLmJ0iwbhGn3+ICAKpSFGzIFdY8p+oXSwK+FIblVuTI4LnlSPFE4PEFwGK0wjM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95B9859292AAB34A95A9803C3C1320F2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826cc606-761f-409d-1108-08d715ab6622
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 11:36:59.2304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDE3OjUzIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAzMCwgMjAxOSBhdCAxMTo1NyBBTSBQaGlsaXBwZSBTY2hlbmtlciA8ZGV2
QHBzY2hlbmtlci5jaD4gd3JvdGU6DQo+IA0KPiA+ICAmYmFja2xpZ2h0IHsNCj4gPiBAQCAtMjA0
LDYgKzIyOCw3NyBAQA0KPiA+ICAgKi8NCj4gPiAgJmkyYzMgew0KPiA+ICAgICAgICAgc3RhdHVz
ID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArICAgICAgIGFkdjcyODA6IGFkdjcyODBAMjEgew0KPiA+
ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFkdjcyODAiOw0KPiA+ICsgICAgICAgICAg
ICAgICByZWcgPSA8MHgyMT47DQo+ID4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ID4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9pcHUx
X2NzaTAgJnBpbmN0cmxfY2FtX21jbGs+Ow0KPiA+ICsgICAgICAgICAgICAgICBjbG9ja3MgPSA8
JmNsa3MgMjAwPjsNCj4gDQo+IFBsZWFzZSByZXBsYWNlIHRoaXMgMjAwIHdpdGggYSBwcm9wZXIg
Y2xvY2sgbGFiZWwuDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJjc2lf
bWNsayI7DQo+ID4gKyAgICAgICAgICAgICAgIERPVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0K
PiA+ICsgICAgICAgICAgICAgICBBVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0KPiA+ICsgICAg
ICAgICAgICAgICBEVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0KPiA+ICsgICAgICAgICAgICAg
ICBQVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0KPiA+ICsgICAgICAgICAgICAgICBjc2lfaWQg
PSA8MD47DQo+IA0KPiBUaGlzIGlzIG5vdCBhIHZhbGlkIHByb3BlcnR5IHVwc3RyZWFtLg0KPiAN
Cj4gSXQgc2VlbXMgeW91IGp1c3QgcG9ydGVkIGl0IGZyb20gYSBkb3duc3RyZWFtIHZlbmRvciBr
ZXJuZWwuIFBsZWFzZQ0KPiBtYWtlIHN1cmUgeW91IHRlc3Qgd2l0aCB0aGUgZHQtYmluZGluZ3Mg
ZnJvbSBtYWlubGluZS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIG1jbGsgPSA8MjQwMDAwMDA+
Ow0KPiA+ICsgICAgICAgICAgICAgICBtY2xrX3NvdXJjZSA9IDwxPjsNCj4gPiArICAgICAgICAg
ICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAg
ICAvKiBWaWRlbyBBREMgb24gQW5hbG9nIENhbWVyYSBNb2R1bGUgKi8NCj4gPiArICAgICAgIGFk
djcxODA6IGFkdjcxODBAMjEgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFk
dixhZHY3MTgwIjsNCj4gPiArICAgICAgICAgICAgICAgcmVnID0gPDB4MjE+Ow0KPiA+ICsgICAg
ICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsgICAgICAgICAgICAg
ICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaXB1MV9jc2kwICZwaW5jdHJsX2NhbV9tY2xrPjsNCj4g
PiArICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbGtzIDIwMD47DQo+IA0KPiBjbG9jayBsYWJl
bCwgcGxlYXNlLg0KPiANCj4gPiArICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY3NpX21j
bGsiOw0KPiA+ICsgICAgICAgICAgICAgICBET1ZERC1zdXBwbHkgPSA8JnJlZ18zcDN2PjsgLyog
My4zdiAqLw0KPiA+ICsgICAgICAgICAgICAgICBBVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+OyAg
LyogMS44diAqLw0KPiA+ICsgICAgICAgICAgICAgICBEVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+
OyAgLyogMS44diAqLw0KPiA+ICsgICAgICAgICAgICAgICBQVkRELXN1cHBseSA9IDwmcmVnXzNw
M3Y+OyAgLyogMS44diAqLw0KPiA+ICsgICAgICAgICAgICAgICBjc2lfaWQgPSA8MD47DQo+IA0K
PiBTYW1lIGhlcmUNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIG1jbGsgPSA8MjQwMDAwMDA+Ow0K
PiA+ICsgICAgICAgICAgICAgICBtY2xrX3NvdXJjZSA9IDwxPjsNCj4gPiArICAgICAgICAgICAg
ICAgY3ZicyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgbWF4OTUyNjogbWF4OTUyNkAyMCB7
DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWF4aW0sbWF4OTUyNiI7DQo+IA0K
PiBUaGlzIGlzIG5vdCBkb2N1bWVudGVkIGluIG1haW5saW5lLg0KDQpZZWFoLCB0b28gbXVjaCBk
b3duc3RyZWFtIHN0dWZmIGluIGhlcmUuIEkgd2lsbCBkcm9wIHRoYXQgcGF0Y2ggZm9yIG5vdy4u
Lg0K
