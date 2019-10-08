Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57534C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DB321721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JBzxdnVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfJHB2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:28:20 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:49221
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbfJHB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mey6uwVXetKQLI+hXLmjqYI84bTB45yh4nDqOnkTKi20uJg2NKc3zV/jTK7II6egQ81R/ybkFT0ZLQULdNu5IZclrR2qUK8mTXK0SjDnDAEPF+ag6nGdlgtlEe1kQf9YyDHiHvjtzn5SM9ZHLsGdrXsmK27inqMDIoRRT0BgIdyrDz65b0Jh7NFjke13YUdjjVjsnRavEcI+JVBmWSXL5XsBgYgTuai4W2czyoXMXKmI9TYW/XM9doyi8dqfvibUHayStoeM5UNeBLUYt3VH+DZTMRrYTtpnLctiW/ibpJ60MQ9IBSK8l+DM7OkVfCXh83gABprXQ3XVvqVQxYjueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEMJmBzAly6NDZmLoajwujNdMQMkHcu1Hk85AvMEopg=;
 b=lm6ShDmXX5gIHznmLAp9C2v3gRgTHgocqswD37Scfms4oeN/ga5WkbtyEp1gAxbHVWLWHr0mN71+HUo+70qtiuqJGGo4XvDHuRCwd/tZwRXwJ0cCwGZC708ziDVDRD+xfCE4IsnXSCvNoNplCSlYScWv/N7OMq+OywYnlG831dw+4ZYoKob9itkrT2h4w1oedZjbJZPgitAhhoyGasTicuXfZDK4IkL9bQQ8xg9diCLuA/+x3dzIDflSu1q2Nubnndm3im7yp9VlPlK3SbLZoj6Wp6g1Qj58uP+rpclRYeAyn3kV3jcHSSc/17kQ1WlvN9pyPpONxFMKrhXGQBgrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEMJmBzAly6NDZmLoajwujNdMQMkHcu1Hk85AvMEopg=;
 b=JBzxdnVDXnFDHM4hpIgLdqryyM6x3w+TlFKTqeH6sGwaF2D2Q/M/BpMeIHOjPv/QahKEX5ZefkWbUPxgVs8VPOCHpZL4UQmOleubmkoVf5IMFyKPuf1cEteNxkODIEF3JEWmzXigG2cmlgtgdqHPVyQ7hUt3mRMZhmi45vdkf9s=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3846.eurprd04.prod.outlook.com (52.133.28.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 01:28:15 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::b0c2:4fbb:fae7:991%5]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 01:28:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mm-evk: Add i2c3 support
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm-evk: Add i2c3 support
Thread-Index: AQHVbs9cKzo2IwFQHkWnSns6k6P0dqdPNl4AgADbL8A=
Date:   Tue, 8 Oct 2019 01:28:15 +0000
Message-ID: <AM6PR0402MB3911D2C2A28C177CBA0D34AFF59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1568886408-18168-1-git-send-email-Anson.Huang@nxp.com>
 <20191007122313.GJ7150@dragon>
In-Reply-To: <20191007122313.GJ7150@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2854ef6d-0cd3-4b0b-e8ce-08d74b8ecab1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR0402MB3846:|AM6PR0402MB3846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB38463FAACCBD951E7DED48D6F59A0@AM6PR0402MB3846.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(25786009)(14454004)(71190400001)(76116006)(66066001)(478600001)(71200400001)(33656002)(11346002)(446003)(486006)(5660300002)(8936002)(81156014)(81166006)(476003)(8676002)(44832011)(4744005)(26005)(186003)(6506007)(2906002)(7696005)(3846002)(76176011)(102836004)(99286004)(6116002)(55016002)(256004)(6436002)(4326008)(7736002)(316002)(229853002)(86362001)(66556008)(52536014)(64756008)(66946007)(66446008)(66476007)(9686003)(6246003)(6916009)(305945005)(74316002)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3846;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQWJJkHMsxn5H9qjWQxR3nqTWkMV861Z5ns5t0S/lOhJv9Tl8j1rAWrF+a5MMpS+cAZ7N3vY3FXLPl6O3XRHVSEv6G+hcVmpOoGy4BnpZsxUV+hVktpDG05XZbv4yDFWkbVKQu7/lZrSsrugrliUb+aIIFV7Zj3SiCWBCwNTT5hZX5SPnz0yKava8SG8zqWlgVpmEeGmphOA4Z/my5gAefLV7WOeT3JoRjpJLk/FjvMTkMXP7s9fvdJ+1WNorDQnBetwBww2y2sstCYLT7i89C64xRWz4CCMfevJs7WEyuOuf8XJjSaq4fmhqgiKaYlhFgPOwUPsE2HFMz6hw2lNAGz+XkOZhgjyLBmKbdX/vD3AbBf8BMKYcmwFBMs2VzIjmyC1eKjp4xp3H3Yj+Y7qtQ9f3NwiBjdEBw8LaNuw7rU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2854ef6d-0cd3-4b0b-e8ce-08d74b8ecab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 01:28:15.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECi93ePy0PoAwQmA2MkUXDW8cAMvvGJ1vTY+StC7Kfw7Wa++UvpJH3XCkI8E+jtZX0eiiPMjTNmINsL47XpbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDU6NDY6NDdQTSArMDgwMCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gRW5hYmxlIGkyYzMgZm9yIGkuTVg4TU0gRVZLIGJvYXJk
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1l
dmsuZHRzIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0tZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLWV2ay5kdHMNCj4gPiBpbmRleCBmN2ExNWYzLi43NzU4YzFjIDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMNCj4gPiBAQCAt
MzA2LDYgKzMwNiwxMyBAQA0KPiA+ICAJfTsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmaTJjMyB7DQo+
ID4gKwljbG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwPjsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjMz47DQo+ID4gKwlzdGF0
dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICAmaW9tdXhjIHsNCj4gDQo+IFRoZSBp
b211eGMgbm9kZSBpcyBiZWluZyBwdXQgYXQgZW5kIG9mIGZpbGUgYmVjYXVzZSBvZiBpdHMgaHVn
ZSBwaW5jdHJsIGRhdGEuDQo+IEkyQyBkZXZpY2VzIHNob3VsZCBiZSBwbGFjZWQgaW4gYWxwaGFi
ZXRpY2FsIHNvcnQgdGhvdWdoLiAgQ2FuIHlvdSBwbGVhc2UNCj4gaGF2ZSBhIHBhdGNoIG1vdmlu
ZyBpMmMxIGFuZCBpMmMyIHRvIGNvcnJlY3QgcGxhY2UgZmlyc3QsIGFuZCB0aGVuIGFkZCBpMmMz
Pw0KDQpEb25lIGluIFYyLg0KDQpUaGFua3MsDQpBbnNvbg0K
