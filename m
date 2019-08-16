Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196B1C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F9206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y8Qjc9QV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHPKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:08:49 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:57198
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfHPKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1Ow1zzUunnCOctsNUE1ZNSh/8i1sM+sa06FWr3UaiZ3B2/Lykayf/iklkZVy2XDweZBN12z8cic/4ojF92eYganC2/gp4IN+aEHifa3YUTUC8d6ThGsTwuzOVeqjl2YE66jBV3pYZuoKiq1lwqIKKJ/NnnGIr1Y5YohYCgvKfn6iJAiZTRkwRMqjHjQl+Y1kWbqOPytYsWNAjNhABSjZSfcT1WpCTYQdKfABdLdhlOHPNC6L5WZRmOUuU31MycvvcjUboPQ63wKvheqiGW2sb0nGzujix52/Z1iFd6mTEbKFL9muUUmQ9WZOJu5QPTToEEEKNQbEwutzJb8s0oeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwwETmB8aLqb0AEB2ENlSiDWD/sITnifXYYDH7q9LFM=;
 b=HGtBgBQdp/fhDOQ4ijP2JNqUFfFCp0xDZV9cKzip/LYhG44BAcH1Tx7gC6/rlYMYr6DYHYouyP9y+naFtcan/MyJWvswwN4L2qG0AG/hkM1cGahFrC9GjFHWudWI8FBtXaHXIkeVcIAHcFViQQj0c8ikJOxBVv1oRtZyfar9NJD17mLgXSZ00tdbIZwalZHp9TvsZj56c0TOY4uJRgphP7ijj/fgkYA16tV6tLsBjsAZHEG/4JRQrLCOxUvvt6r2bfJ6ijYAyOKfuU6Ij1DtAHAqif+7yFGFqT+uIusYPkM03weQUJ23i9AUtjMDFW9tnt6lUcigoxEaEOINP1NzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwwETmB8aLqb0AEB2ENlSiDWD/sITnifXYYDH7q9LFM=;
 b=Y8Qjc9QVC6QQU/z2XaeJUdKECmygVMZUrzrBrlj+wPEgyNXvWO0HPz/XMcj8AUxZ5VGq3wL93mnBW1vBrzWL1zDHjS05m0a+MlsenDe/LPaB6k1asgfuzfyB3v3Hebn+U4yksacLUBhTHOYWNJnPVGkyCYqj+xxnmG9AuvwBwOw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 16 Aug 2019 10:08:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 10:08:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/4] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Topic: [PATCH V6 4/4] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Index: AQHVU82SFvIqTYVX002fkrtVdPy2g6b9ix+AgAABRwA=
Date:   Fri, 16 Aug 2019 10:08:44 +0000
Message-ID: <DB3PR0402MB3916E469219C7CC68D55C90AF5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1565915925-21009-1-git-send-email-Anson.Huang@nxp.com>
 <1565915925-21009-4-git-send-email-Anson.Huang@nxp.com>
 <e62d26b9-8c9b-644f-d2b3-485586e07e35@linaro.org>
In-Reply-To: <e62d26b9-8c9b-644f-d2b3-485586e07e35@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ece5082-5b29-42b5-dba7-08d72231b906
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3708F6C733A4B8E140C1238CF5AF0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(189003)(446003)(53936002)(4326008)(6246003)(74316002)(3846002)(99286004)(26005)(9686003)(66066001)(7696005)(25786009)(2201001)(102836004)(53546011)(55016002)(76176011)(4744005)(6506007)(110136005)(478600001)(71200400001)(71190400001)(14454004)(2906002)(66476007)(52536014)(64756008)(486006)(8936002)(186003)(316002)(6436002)(256004)(33656002)(66556008)(66446008)(8676002)(66946007)(76116006)(6116002)(5660300002)(2501003)(7416002)(44832011)(11346002)(476003)(86362001)(305945005)(7736002)(81156014)(81166006)(229853002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6ce8yJ+uWyRi3I2LPljSTL9r+TH79tJrnMAmuFzQQafrJ3Kj7w8Ts8IcolNQNcclQkxq7OxJtmbJIuCNuIDC1ZRP3jnIdgf+30NaRz0JBcFXGYBz76kPRGq067kikthdQATof8FKX7s9sje086jF7GtOkXhPL64YpFxcL5l7ndAW188mVU9PMzcmO9joIBfePF5JiZ34tyJ2TAQLbtIcvCMFIT4SnWlCNt7uoKw93AD3eaRE7KWrbMSXwUTHXYX4zgX8JdOJJQtnEPUWI5JYzBOQ/ZSg297plO056pqny1exah9wXr2VPKYtri7s3CJ8VFw/zZ11WVpXLqVLGur0Htq/B7W6cbGtyXGZJiEbBorKkSJSA0POra17vIuWP88MS4+s/WdOCJMPt9SFkspDKnI0erKQC7LMnDCB5dSPiu0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ece5082-5b29-42b5-dba7-08d72231b906
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 10:08:44.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJxymtZefIEW+o+BHutOn2kY/uTrDuxdz5gwpiCnFpr9irLA/CGHQ0MqMxX/l1/6qa58xXalSM+l+OPSDGmctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbC9TaGF3bg0KDQo+IE9uIDE2LzA4LzIwMTkgMDI6MzgsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IEVuYWJsZSBpLk1YOE1NIGNwdS1pZGxlIHVzaW5nIGdlbmVyaWMgQVJNIGNwdS1p
ZGxlIGRyaXZlciwgMiBzdGF0ZXMNCj4gPiBhcmUgc3VwcG9ydGVkLCBkZXRhaWxzIGFzIGJlbG93
Og0KPiA+DQo+ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0DQo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTAvbmFtZQ0KPiA+IFdGSQ0KPiA+IHJvb3RAaW14OG1tZXZr
On4jIGNhdA0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTAv
dXNhZ2UNCj4gPiAzOTczDQo+ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0DQo+IC9zeXMvZGV2aWNl
cy9zeXN0ZW0vY3B1L2NwdTAvY3B1aWRsZS9zdGF0ZTEvbmFtZQ0KPiA+IGNwdS1wZC13YWl0DQo+
ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1
MC9jcHVpZGxlL3N0YXRlMS91c2FnZQ0KPiA+IDY2NDcNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gSGkgQW5zb24sDQo+IA0K
PiBJJ3ZlIGFwcGxpZWQgdGhlIHBhdGNoZXMgMS0zIGJ1dCB0aGlzIG9uZSBkb2VzIG5vdCBhcHBs
eS4NCg0KVGhhbmtzLg0KDQo+IA0KPiBZb3UgY2FuIGVpdGhlciByZXNwaW4gaXQgYWdhaW5zdCB0
aXAvdGltZXJzL2NvcmUgYW5kIHRha2UgaXQgdGhyb3VnaCBTaGF3bidzDQo+IHRyZWUuIElmIHRo
ZSBsYXRlciwgeW91IGNhbiBhZGQgbXkgQWNrZWQtYnkuDQoNCkhpLCBTaGF3bg0KCUNhbiB5b3Ug
dGFrZSB0aGlzIHBhdGNoIGFuZCBhZGQgYmVsb3cgQWNrZWQtYnk/IEl0IHNob3VsZCBjYW4gYmUg
YXBwbGllZCB0byB5b3VyIHRyZWUgZGlyZWN0bHkuDQoNCglBY2tlZC1ieTogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQoNClRoYW5rcywNCkFuc29uDQoNCg0K
