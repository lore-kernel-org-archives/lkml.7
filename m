Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A81C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2964F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uOTYF5Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEFJSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:18:21 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:33095
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfEFJSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvupcNc3kIJUHVCg48c8wRDL5KYRa4AKC9t8nOiyIFY=;
 b=uOTYF5Zl+BUs53Uj7vyNYmF/Fof/En6UTmClCcn7MjmTbos60UqefoNFWE47YjWHWbaOxJa2Lsv/qnhpY2nndP+doUGAUeY+npi7JYDX9fsZW5SH1mYmbh32NfazahJGU4QIzZZQTxznya+TSbAAgMxFScGHkp1GVaS1WkHXgac=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 09:18:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:18:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/3] clk: imx8mm: add GPIO clocks to clock tree
Thread-Topic: [PATCH 2/3] clk: imx8mm: add GPIO clocks to clock tree
Thread-Index: AQHVA+yi5NPf00G6iE6AT2QNzPBJNA==
Date:   Mon, 6 May 2019 09:18:15 +0000
Message-ID: <1557133994-5061-2-git-send-email-Anson.Huang@nxp.com>
References: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 902a063e-0ede-4829-877f-08d6d203c4cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB38330ED79130B72020A88F10F5300@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(446003)(486006)(68736007)(8936002)(3846002)(2906002)(99286004)(386003)(6506007)(52116002)(476003)(11346002)(76176011)(2616005)(6116002)(4326008)(7736002)(25786009)(305945005)(2201001)(110136005)(7416002)(478600001)(86362001)(316002)(81156014)(66066001)(6486002)(66946007)(66476007)(64756008)(66446008)(73956011)(14454004)(66556008)(71200400001)(71190400001)(36756003)(256004)(8676002)(186003)(6512007)(26005)(102836004)(2501003)(50226002)(6436002)(5660300002)(81166006)(53936002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aYTeKjU+6DTOKZl7rSwoujTz4HJyun0nWQKBaRw+RpY7UUYDjcHoUtn51beou7EDPyEkKtviVZzrf8DDv1rkmltM0YuUNp4Z8EAIw2ykKC9JKTLdbFf/cLGf47hNaH8lxvXXC1Rr0nUiVD92WkrfZftVVzAZtWBbXq7dDx/Sjc3o+UcbDtifn84y8uHVXFFRIrsg8QhF6SSNn5MVrrM0DaoEa9NBGGMTJzcMzHNJeP45zuIK3nNb9CbMthOIgLHsggrEevadac7Ut9hNwjMCr7wXX/+3lmEyz6Q7ia7P0+pE9xFRKgQZWcStd5Uml00CuxL/XRvLrehe8LJLSLfJLk63mk3qWTMCIwfKEILvYd8ao9Bdgy3a/hQ+tWY5l0u7twSa3vDNvSorRjEQ3dxXCaoULCn2Zx5vkfFe9RJ/Vv4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902a063e-0ede-4829-877f-08d6d203c4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:18:15.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgY2xvY2sgZ2F0ZSBmb3IgZWFjaCBHUElPIGJhbmssIGFkZCB0aGVtDQppbnRv
IGNsb2NrIHRyZWUgZm9yIEdQSU8gZHJpdmVyIHRvIG1hbmFnZS4NCg0KU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgv
Y2xrLWlteDhtbS5jIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDhtbS5jDQppbmRleCAxZWY4NDM4Li43MzNjYTIwIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYw0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg4bW0uYw0KQEAgLTU5MCw2ICs1OTAsMTEgQEAgc3RhdGljIGludCBfX2luaXQgaW14OG1tX2Ns
b2Nrc19pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2NtX25vZGUpDQogCWNsa3NbSU1YOE1NX0NM
S19FQ1NQSTJfUk9PVF0gPSBpbXhfY2xrX2dhdGU0KCJlY3NwaTJfcm9vdF9jbGsiLCAiZWNzcGky
IiwgYmFzZSArIDB4NDA4MCwgMCk7DQogCWNsa3NbSU1YOE1NX0NMS19FQ1NQSTNfUk9PVF0gPSBp
bXhfY2xrX2dhdGU0KCJlY3NwaTNfcm9vdF9jbGsiLCAiZWNzcGkzIiwgYmFzZSArIDB4NDA5MCwg
MCk7DQogCWNsa3NbSU1YOE1NX0NMS19FTkVUMV9ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImVuZXQx
X3Jvb3RfY2xrIiwgImVuZXRfYXhpIiwgYmFzZSArIDB4NDBhMCwgMCk7DQorCWNsa3NbSU1YOE1N
X0NMS19HUElPMV9ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImdwaW8xX3Jvb3RfY2xrIiwgImlwZ19y
b290IiwgYmFzZSArIDB4NDBiMCwgMCk7DQorCWNsa3NbSU1YOE1NX0NMS19HUElPMl9ST09UXSA9
IGlteF9jbGtfZ2F0ZTQoImdwaW8yX3Jvb3RfY2xrIiwgImlwZ19yb290IiwgYmFzZSArIDB4NDBj
MCwgMCk7DQorCWNsa3NbSU1YOE1NX0NMS19HUElPM19ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImdw
aW8zX3Jvb3RfY2xrIiwgImlwZ19yb290IiwgYmFzZSArIDB4NDBkMCwgMCk7DQorCWNsa3NbSU1Y
OE1NX0NMS19HUElPNF9ST09UXSA9IGlteF9jbGtfZ2F0ZTQoImdwaW80X3Jvb3RfY2xrIiwgImlw
Z19yb290IiwgYmFzZSArIDB4NDBlMCwgMCk7DQorCWNsa3NbSU1YOE1NX0NMS19HUElPNV9ST09U
XSA9IGlteF9jbGtfZ2F0ZTQoImdwaW81X3Jvb3RfY2xrIiwgImlwZ19yb290IiwgYmFzZSArIDB4
NDBmMCwgMCk7DQogCWNsa3NbSU1YOE1NX0NMS19HUFQxX1JPT1RdID0gaW14X2Nsa19nYXRlNCgi
Z3B0MV9yb290X2NsayIsICJncHQxIiwgYmFzZSArIDB4NDEwMCwgMCk7DQogCWNsa3NbSU1YOE1N
X0NMS19JMkMxX1JPT1RdID0gaW14X2Nsa19nYXRlNCgiaTJjMV9yb290X2NsayIsICJpMmMxIiwg
YmFzZSArIDB4NDE3MCwgMCk7DQogCWNsa3NbSU1YOE1NX0NMS19JMkMyX1JPT1RdID0gaW14X2Ns
a19nYXRlNCgiaTJjMl9yb290X2NsayIsICJpMmMyIiwgYmFzZSArIDB4NDE4MCwgMCk7DQotLSAN
CjIuNy40DQoNCg==
