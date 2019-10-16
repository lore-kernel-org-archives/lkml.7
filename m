Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE6FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0EB20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P69BrBNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392646AbfJPLOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:14:07 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:13125
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390471AbfJPLOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX4hycvLAiPTz/9rA9KBls+DzljUYg5XFtt/FL8tGyhOh9svl7Y2dUw7m6HuUwl+BtQSteCDW4Z14+6tAMV103S915ZOaQIT6kan6uF/my/eb95/ODWxjVsUmNRKhwqKWIQSC6KQ3rY/OPsLtenvg2xte34xch9+3k+XSLa9xaf3CMgLFQTd0yKs761QTaSPqRzyMSiuW8Ne54sX8ilNEyZA2rY6s2q7zawxD++B/M9o1Op8PD0gnhD+Pie2YqAesgTryU02wjxKufpb6J8BcpEedcQOG7LOXASPGhNx0F95EjmPiHYod4S9RZy57Q7S5c6JmeJAlUFk4BULvCOFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf7j5xtXdMuSThi7WjfxEfgX6e44woI9XB3HkeKiWPk=;
 b=Lz/yYq8u45sSnd7jkmDhib5fO3AtOdzKf1Hr7zdckvWes6stu6vRwFCsg41h+4MhR9P9lKI4LqRfR3KNPGZW37oQRdyq63XlHuL2c3nQJuxurzGLPIOBYt2WzE4R80jDcod/xAU23I0iM8DbwuIneeL1AxH2pjA3dhkxdvXBKly6+m15vYjVaix+KbY368daVZ8VIfv0AVVVwto4QqilS0Sht5nPH1sPGEcP0XEoVkOhvat9VsxPR7iNEN9NPoBItV0IoM9hbry/wVu8Kgx1LT1JrYC9/hpuwT0OfDJzqLv4in55c7taUa8mn6WsBnmzr2RcH8UHWnw+5Hwe9U0ubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf7j5xtXdMuSThi7WjfxEfgX6e44woI9XB3HkeKiWPk=;
 b=P69BrBNd7febrBKJgY07einPIR6T5GYunkeG9tnxdf16zqrii5nVF/H37dZwf3Ue4cnxvu+9NVBoTMx/o7AhUqXHY/zEIxmdC2ke7HmAY80lu0SoA0CLjk567KX7tvyTk5wzQOSHnwvL+wjwM4nyRNwiAIgE5/JSkH8yc1qFdoU=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB5728.eurprd04.prod.outlook.com (20.178.127.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 11:14:04 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::b835:b58c:26b2:ca8f%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 11:14:04 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ARM64: dts: imx8mm-evk: Assigned clocks for audio plls
Thread-Topic: [PATCH] ARM64: dts: imx8mm-evk: Assigned clocks for audio plls
Thread-Index: AQHVhA2D/VrUFzy1602vrssfnC7nGqddHYeA
Date:   Wed, 16 Oct 2019 11:14:03 +0000
Message-ID: <c878dec9a2d0c47f23806ce3db7b0361badf17c8.camel@nxp.com>
References: <20191016103513.13088-1-shengjiu.wang@nxp.com>
In-Reply-To: <20191016103513.13088-1-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb5ebbc5-e02a-4929-f73b-08d75229f438
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5728:|VI1PR04MB5728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5728166E0D6B812FC76C2351F9920@VI1PR04MB5728.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(6246003)(102836004)(25786009)(5660300002)(7736002)(44832011)(478600001)(118296001)(3846002)(186003)(229853002)(66476007)(6116002)(66946007)(26005)(81166006)(6506007)(2906002)(8676002)(71190400001)(71200400001)(81156014)(99286004)(8936002)(50226002)(76116006)(91956017)(76176011)(86362001)(2201001)(14454004)(7416002)(476003)(64756008)(6486002)(110136005)(4001150100001)(305945005)(316002)(446003)(6512007)(256004)(66066001)(11346002)(486006)(66446008)(2616005)(6436002)(2501003)(36756003)(66556008)(99106002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5728;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q35NQS/Nr2IloofI2VOnh0K+I01WEsrI1TyJq1qWjhhN5TfaE+st9pdUvjuCABCMiB7ikcaZXoe4DsQvAmUfLLC3bX3+xi+4dsqpTOzHpJmgpxQWPomLz26g7d5QKakYxPpZmXauVHx2+K0QkB8na84E2s3fyXN53d106tmGHl9wxgBI+LRU8USEEKLXn7BdQvYc4UVRNrPbBTxlsJh2wsB8zPIJK2TRyRFJ97HkVDQ0Bzls77VdaexNVD1O/Gsl6BB0Jzhg3x6whKc/NyReiSA3I+A26g/LBOHT4h/P5ZaMVeQew2veUSt7y2UxuMXZv6fL9NJdJ5fo7fsaj0Jn3iGOck4VKdcAmnZf6bX6go4N3GJ4Uy9YE0w0cmO2RFLbJfbYYvn2K+sIWLf7Cb0gtkSjdwXFuZ7badPRsaNVtLM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550357C19BD2FA49A77A0992F0D97170@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5ebbc5-e02a-4929-f73b-08d75229f438
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 11:14:03.9116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjev/YwwKxa9fgAHvBjYzOGOz+p4NQhiUihhbSckxP9jn+TXjJEAv2rzKoYoHsFKuQeTML0FuxKdqh1Y7HYmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDEwOjM2ICswMDAwLCBTLmouIFdhbmcgd3JvdGU6DQo+IEFz
c2lnbiBjbG9ja3MgYW5kIGNsb2NrLXJhdGVzIGZvciBhdWRpbyBwbGxzLCB0aGF0IGF1ZGlvDQo+
IGRyaXZlcnMgY2FuIHV0aWxpemUgdGhlbS4NCj4gDQo+IEFkZCBkYWktdGRtLXNsb3QtbnVtIGFu
ZCBkYWktdGRtLXNsb3Qtd2lkdGggZm9yIHNvdW5kLXdtODUyNCwNCj4gdGhhdCBzYWkgZHJpdmVy
IGNhbiBnZW5lcmF0ZSBjb3JyZWN0IGJpdCBjbG9jay4NCj4gDQo+IEZpeGVzOiAxM2YzYjlmZGVm
NmMgKCJhcm02NDogZHRzOiBpbXg4bW0tZXZrOiBFbmFibGUgYXVkaW8gY29kZWMNCj4gd204NTI0
IikNCj4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29t
Pg0KDQpSZXZpZXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0K
DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMg
fCAyICsrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSAgICB8
IDggKysrKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1ldmsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LWV2ay5kdHMNCj4gaW5kZXggZjdhMTVmMzkwNGMyLi4xMzEzNzQ1MWI0MzggMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQo+IEBAIC02Miw2
ICs2Miw4IEBADQo+ICANCj4gIAkJY3B1ZGFpOiBzaW1wbGUtYXVkaW8tY2FyZCxjcHUgew0KPiAg
CQkJc291bmQtZGFpID0gPCZzYWkzPjsNCj4gKwkJCWRhaS10ZG0tc2xvdC1udW0gPSA8Mj47DQo+
ICsJCQlkYWktdGRtLXNsb3Qtd2lkdGggPSA8MzI+Ow0KPiAgCQl9Ow0KPiAgDQo+ICAJCXNpbXBs
ZS1hdWRpby1jYXJkLGNvZGVjIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLmR0c2kNCj4gaW5kZXggNWY5ZDBkYTE5NmUxLi4yMTM5YzBhOWM0OTUgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IEBAIC00NzksMTQg
KzQ3OSwxOCBAQA0KPiAgCQkJCQkJPCZjbGsNCj4gSU1YOE1NX0NMS19BVURJT19BSEI+LA0KPiAg
CQkJCQkJPCZjbGsNCj4gSU1YOE1NX0NMS19JUEdfQVVESU9fUk9PVD4sDQo+ICAJCQkJCQk8JmNs
ayBJTVg4TU1fU1lTX1BMTDM+LA0KPiAtCQkJCQkJPCZjbGsNCj4gSU1YOE1NX1ZJREVPX1BMTDE+
Ow0KPiArCQkJCQkJPCZjbGsNCj4gSU1YOE1NX1ZJREVPX1BMTDE+LA0KPiArCQkJCQkJPCZjbGsN
Cj4gSU1YOE1NX0FVRElPX1BMTDE+LA0KPiArCQkJCQkJPCZjbGsNCj4gSU1YOE1NX0FVRElPX1BM
TDI+Ow0KPiAgCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsaw0KPiBJTVg4TU1fU1lT
X1BMTDNfT1VUPiwNCj4gIAkJCQkJCQkgPCZjbGsNCj4gSU1YOE1NX1NZU19QTEwxXzgwME0+Ow0K
PiAgCQkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LA0KPiAgCQkJCQkJCTw0MDAwMDAwMDA+
LA0KPiAgCQkJCQkJCTw0MDAwMDAwMDA+LA0KPiAgCQkJCQkJCTw3NTAwMDAwMDA+LA0KPiAtCQkJ
CQkJCTw1OTQwMDAwMDA+Ow0KPiArCQkJCQkJCTw1OTQwMDAwMDA+LA0KPiArCQkJCQkJCTwzOTMy
MTYwMDA+LA0KPiArCQkJCQkJCTwzNjEyNjcyMDA+Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJc3Jj
OiByZXNldC1jb250cm9sbGVyQDMwMzkwMDAwIHsNCg==
