Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2258C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691292084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fD8JgNRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDJBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:47:40 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:52633
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDJBrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWVgAfaTP2sCroy2l/4MCJHMU9AduJrenYinRUDOr9s=;
 b=fD8JgNRgJ1DSVTVHjjK0avaih4wZiP3N6RKT7aW+Vb5xl4z37gXQlyLXOd+EhqLHXwVYEcTQ/YYPUsLYGQmHD+4VkNGkcZOgls1B7wdIYSFRTdNpmNS2codN4U9unub7scD8hmRlinvTicZ77zf1MNj02bYUHY9nC5D1G03dTKY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 01:47:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 01:47:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V11 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU7z9edm8y96fMfkmO0qtUJzaAHA==
Date:   Wed, 10 Apr 2019 01:47:34 +0000
Message-ID: <1554860547-18237-2-git-send-email-Anson.Huang@nxp.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8657d559-f147-4a07-b6f8-08d6bd568099
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-antispam-prvs: <DB3PR0402MB37215CC19F6C4CBEBD02BAE2F52E0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(2201001)(71190400001)(71200400001)(97736004)(105586002)(68736007)(6436002)(14454004)(8676002)(8936002)(478600001)(50226002)(81166006)(81156014)(7736002)(256004)(53936002)(25786009)(6512007)(305945005)(4326008)(6486002)(26005)(7416002)(106356001)(36756003)(66066001)(186003)(3846002)(6116002)(52116002)(316002)(102836004)(6506007)(386003)(446003)(486006)(2906002)(76176011)(110136005)(86362001)(2616005)(476003)(2501003)(11346002)(5660300002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BKpkWzlQJaMCPlErDKp/CKR0ua5gjAFDgnDQZfS9p2NwbEMI2BIjf4YmPnRV06VXMg2Yv6/R2pjGRaZdpMYXZ83+foxoJR8luCgy2z3ITOUNSOYkOEN2J4tnnCar6SCQ5M+2wSF+7v0lwCeUpCiKGKxLOn/TJ0gXQ29eVWjn5sLu6yzdMfE9McXeGsL/N3Z0EfXbDZ1bzRnVFthjnlLuIcowGA8EIhionnplS98wExUui/O47hNpzX1bZ12nJ8+sVthV2qME0erwpbkXhgj+vBw3TAlrLxRoYTGFHn2YvbBh255Mtu4yFHDzjnxM+tftLfO5qkwsO8Viz5owt2iPbPlv3TdHfSiNv52lNODJM1jwVdV8TpCPtZ5/N1+2laaKF9X4SJoFky816XE0+4Yr0YEyL2KT67dAo8PnG4chO2Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8657d559-f147-4a07-b6f8-08d6bd568099
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 01:47:34.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVggVFBNKExvdyBQb3dlciBUaW1lci9QdWxzZSBXaWR0aCBNb2R1bGF0aW9uIE1vZHVs
ZSkgUFdNIGJpbmRpbmcuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQot
LS0NCk5vIGNoYW5nZXMuDQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRw
bS1wd20udHh0ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBtLXB3bS50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC10cG0tcHdtLnR4dA0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjNiYTk1OGQNCi0tLSAvZGV2L251bGwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20u
dHh0DQpAQCAtMCwwICsxLDIyIEBADQorRnJlZXNjYWxlIGkuTVggVFBNIFBXTSBjb250cm9sbGVy
DQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCistIGNvbXBhdGlibGUgOiBTaG91bGQgYmUgImZz
bCxpbXg3dWxwLXB3bSIuDQorLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3Ro
IG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXJzLg0KKy0gI3B3bS1jZWxsczogU2hvdWxkIGJl
IDMuIFNlZSBwd20udHh0IGluIHRoaXMgZGlyZWN0b3J5IGZvciBhIGRlc2NyaXB0aW9uIG9mIHRo
ZSBjZWxscyBmb3JtYXQuDQorLSBjbG9ja3MgOiBUaGUgY2xvY2sgcHJvdmlkZWQgYnkgdGhlIFNv
QyB0byBkcml2ZSB0aGUgUFdNLg0KKy0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBmb3IgdGhl
IFBXTSBjb250cm9sbGVyLg0KKw0KK05vdGU6IFRoZSBUUE0gY291bnRlciBhbmQgcGVyaW9kIGNv
dW50ZXIgYXJlIHNoYXJlZCBiZXR3ZWVuIG11bHRpcGxlIGNoYW5uZWxzLCBzbyBhbGwgY2hhbm5l
bHMNCitzaG91bGQgdXNlIHNhbWUgcGVyaW9kIHNldHRpbmcuDQorDQorRXhhbXBsZToNCisNCit0
cG00OiBwd21ANDAyNTAwMDAgew0KKwljb21wYXRpYmxlID0gImZzbCxpbXg3dWxwLXB3bSI7DQor
CXJlZyA9IDwweDQwMjUwMDAwIDB4MTAwMD47DQorCWFzc2lnbmVkLWNsb2NrcyA9IDwmcGNjMiBJ
TVg3VUxQX0NMS19MUFRQTTQ+Ow0KKwlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZzY2cxIElN
WDdVTFBfQ0xLX1NPU0NfQlVTX0NMSz47DQorCWNsb2NrcyA9IDwmcGNjMiBJTVg3VUxQX0NMS19M
UFRQTTQ+Ow0KKwkjcHdtLWNlbGxzID0gPDM+Ow0KK307DQotLSANCjIuNy40DQoNCg==
