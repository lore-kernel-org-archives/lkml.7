Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78866214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FXCct+jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDZJce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:32:34 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:18717
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDZJcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IazLXwc71o1/8ca6HqydOeHii79txbKZU8tSwBYMFUM=;
 b=FXCct+jyWewlKqibGn89bLikQP55DixYxyhcTA9qW/x2wuaXBk2TbMAKA/xtOoh5iWndAGpJApNY3kHbLyVorQMdfDW2sGTtck/9G1nTts9moia6ZcWM2Hqo4bk/8clPPNQo+dpwL5mwIo5gA6HaHUzxXHjBJ/Qp+4c9ilZsKp8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4174.eurprd04.prod.outlook.com (52.134.30.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 09:32:29 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 09:32:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround
 on i.mx6ul
Thread-Topic: [EXT] Re: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround
 on i.mx6ul
Thread-Index: AQHU/AbaiLNd2lkp3kyyQFeWzzS7gqZOJ5QAgAAEjIA=
Date:   Fri, 26 Apr 2019 09:32:29 +0000
Message-ID: <1556270773.32214.5.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-8-git-send-email-yibin.gong@nxp.com>
         <1556269796.2584.25.camel@pengutronix.de>
In-Reply-To: <1556269796.2584.25.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7f356c2-c461-4e67-40ee-08d6ca2a1a02
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4174;
x-ms-traffictypediagnostic: VI1PR04MB4174:
x-microsoft-antispam-prvs: <VI1PR04MB4174B58796BC9474B5F0D6BA893E0@VI1PR04MB4174.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(71190400001)(3846002)(53936002)(6512007)(71200400001)(36756003)(229853002)(2906002)(97736004)(5660300002)(4326008)(103116003)(6436002)(6246003)(6116002)(25786009)(256004)(6486002)(14444005)(305945005)(7416002)(7736002)(14454004)(64756008)(99286004)(66066001)(478600001)(316002)(186003)(102836004)(6506007)(66946007)(110136005)(73956011)(76116006)(91956017)(66556008)(53546011)(26005)(68736007)(446003)(50226002)(476003)(2616005)(11346002)(486006)(86362001)(8676002)(2201001)(54906003)(8936002)(81166006)(81156014)(2501003)(66476007)(76176011)(66446008)(99106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4174;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: acY8Ts2tiUcXiDv7xG5AAfbx7A9EZ7KtA3YKy+aIgSZSwuEEU7cGRo2G27lLaa35EWU5A1E1rVOMzwV86dpoA65XpHWvb26w+JFhxpVNO6OpAeXVwQIz2/6GvvYvD7G53cHVXqHVdz4Y4+Bo2YLSM2mp7nN1z/Z8Yl25LO1pUDbqBDkXJlAFc9w3ACzFVHpDs6ZAe2c0gWzT3klPXM/nHoYFhkbvoSWcmfpwPKIqUgDcPfMNcperB6g9EdJ25BEuXA4UsiPG7oy6DAR6Ae4duh3+ZFZSiKPLF1EQGCpTLwziTG9Vlo7xX8bPcTy5xzEmsfkCXokWI3uk4RgifTAvWtMq3mUunBH416dp9gIZZ5bf4KgM3yqc9VoRvvjX6zCqrHuN1gja7KyQHAN4+BRiep/N/7D77eQk4Tt/vMI9bDI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4809C4EB129E94C9772A7F15C79E018@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f356c2-c461-4e67-40ee-08d6ca2a1a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 09:32:29.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNiBhdCAxMTowOSArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+wqANCj4g
PiDCoHN0YXRpYyBpbmxpbmUgaW50IGlzX2lteDUzX2Vjc3BpKHN0cnVjdCBzcGlfaW14X2RhdGEg
KmQpDQo+ID4gQEAgLTU4NSw5ICs1ODcsMTYgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBh
cmVfdHJhbnNmZXIoc3RydWN0DQo+ID4gc3BpX2lteF9kYXRhICpzcGlfaW14LA0KPiA+IMKgwqDC
oMKgwqDCoGN0cmwgfD0gbXg1MV9lY3NwaV9jbGtkaXYoc3BpX2lteCwgdC0+c3BlZWRfaHosICZj
bGspOw0KPiA+IMKgwqDCoMKgwqDCoHNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOw0KPiA+IA0K
PiA+IC3CoMKgwqDCoMKgLyogRVJSMDA5MTY1OiB3b3JrIGluIFhIQyBtb2RlIGFzIFBJTyAqLw0K
PiA+IC3CoMKgwqDCoMKgaWYgKHNwaV9pbXgtPnVzZWRtYSkNCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOw0KPiA+ICvCoMKgwqDCoMKg
LyoNCj4gPiArwqDCoMKgwqDCoMKgKiBFUlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUgaW5zdGVh
ZCBvZiBTTUMgYXMgUElPIG9uIHRoZQ0KPiA+IGNoaXBzDQo+ID4gK8KgwqDCoMKgwqDCoCogYmVm
b3JlIGkubXg2dWwuDQo+ID4gK8KgwqDCoMKgwqDCoCovDQo+ID4gK8KgwqDCoMKgwqBpZiAoc3Bp
X2lteC0+dXNlZG1hKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHNwaV9p
bXgtPmRldnR5cGVfZGF0YS0+ZGV2dHlwZSA9PSBJTVg2VUxfRUNTUEkpDQo+ID4gDQo+ID4gPSwg
b3RoZXJ3aXNlIHRoZSB3b3JrYXJvdW5kIG1pZ2h0IGJlIGFwcGxpZWQgdG8gbGF0ZXIgZ2VuZXJh
dGlvbnMNCj4gPiBvZg0KPiB0aGUgY29yZSBpZiBtb3JlIGFyZSBhZGRlZCBsYXRlci4NCj4gDQo+
IFJlZ2FyZHMsDQo+IEx1Y2FzDQpVbmRlcnN0b29kIHlvdXIgcG9pbnQsIGJ1dCBmb3Igbm93IGNo
b29zZSBkaWZmZXJlbnQgY29tcGF0aWJsZSBuYW1lDQpjb3VsZCBhcHBseSB0aGlzIHdvcmthcm91
bmQgb3Igbm90LiBJIHByZWZlciB0byBsZWF2ZSBpdCBmb3IgbmV4dCBlY3NwaQ0KSVAgdXBncmFk
ZSBpZiBpdCByZWFsbHkgY29tZSBpbiB0aGUgZnV0dXJlLCBvdGhlcndpc2UgdGhhdCAnPj0nIGJy
aW5nDQphIGxpdHRsZSBiaXQgY29uZnVzZSBpZiB0aGVyZSBpcyBubyB1cGRhdGUgZm9yIGVjc3Bp
IElQLi4u
