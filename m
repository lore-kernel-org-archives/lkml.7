Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5672147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8zNQMgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfD3B50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:57:26 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:28027
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbfD3B50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfff3VUuI7FcOhQjulztNG48leP+fI44AuIkflJgl58=;
 b=m8zNQMgmesbA5Qvqbu73itjk8fopxZ2wxo/NZp5eUir5WEd7SnUlPnJAucEl3j09Xnyde8W0/lYs1khktAFJ+oS/Wl2JR6Ly9V/vnT0JYy6tL9tqsdo/SM5CmbGtf3AQoHGHy0qrIFuoYOMVf8o0mjk1CobjmnoP9NE78TjDH4o=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3829.eurprd04.prod.outlook.com (52.133.29.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 30 Apr 2019 01:55:18 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::55cc:4406:327:9259]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::55cc:4406:327:9259%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 01:55:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Topic: [PATCH] clk: imx: pllv3: Fix fall through build warning
Thread-Index: AQHU/vfDJ+hnJuSvCk6GSL1CreUf2Q==
Date:   Tue, 30 Apr 2019 01:55:18 +0000
Message-ID: <1556589033-6080-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68c6c806-fef6-46d2-40f5-08d6cd0ee578
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3829;
x-ms-traffictypediagnostic: AM6PR0402MB3829:
x-microsoft-antispam-prvs: <AM6PR0402MB382940A6A3A42D3A816F67AAF53A0@AM6PR0402MB3829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(86362001)(4326008)(2501003)(2201001)(6436002)(81166006)(8936002)(6486002)(66066001)(52116002)(7736002)(66446008)(81156014)(110136005)(64756008)(73956011)(66476007)(66556008)(305945005)(99286004)(50226002)(316002)(25786009)(8676002)(6512007)(53936002)(256004)(14454004)(4744005)(66946007)(186003)(3846002)(6116002)(14444005)(26005)(2906002)(386003)(68736007)(71190400001)(97736004)(478600001)(476003)(486006)(5660300002)(6506007)(2616005)(71200400001)(36756003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3829;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: um4Cp4BkeckDFY5Y5DLx3bezGZvre+JlN93QVKB+XsfrzCraQGIqgnMK4mLAqpassiMGSuJpW+AvZA9DXftPvH71t+bQ9JhPbeZMobX2yJ0SUi+GYVLS5jdapUU5ZSbBFLCHJHIsHS0JupB8dcdVf/vR5GCNffOC9NXjpDJ8iGj4cqKRXOja3XURtnPX+RDCpYpABNFT+j+j89n6WAPS585vpYqWd5W6N3JZgjeFMBUN7ctOk07Lsluoo1GF6QSWivOEW7W+iWjKosPelKohnz2PgjNhCn1VcNu0dCzhRuQMezYQ3smQIvcZ2nh43z8HBJXTcmb53N9ETZLUPtjugnkyZKQgiEtpXNRhvodt781BMQyUBluGkFYIeYLMROpkGN7C7RIjJ4Qb0YTAFFVZtnEgKj05V5nDx0Aybu9UVJA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c6c806-fef6-46d2-40f5-08d6cd0ee578
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 01:55:18.7396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IGJlbG93IGZhbGwgdGhyb3VnaCBidWlsZCB3YXJuaW5nOg0KDQpkcml2ZXJzL2Nsay9pbXgv
Y2xrLXBsbHYzLmM6NDUzOjIxOiB3YXJuaW5nOg0KdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhy
b3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQoNCiAgIHBsbC0+ZGVub21fb2Zmc2V0ID0g
UExMX0lNWDdfREVOT01fT0ZGU0VUOw0KICAgICAgICAgICAgICAgICAgICAgXg0KZHJpdmVycy9j
bGsvaW14L2Nsay1wbGx2My5jOjQ1NDoyOiBub3RlOiBoZXJlDQogIGNhc2UgSU1YX1BMTFYzX0FW
Og0KICBefn5+DQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LXBsbHYzLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMNCmluZGV4IGU4OTJiOWEuLmZi
ZTRmZTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMNCisrKyBiL2Ry
aXZlcnMvY2xrL2lteC9jbGstcGxsdjMuYw0KQEAgLTQ1MSw2ICs0NTEsNyBAQCBzdHJ1Y3QgY2xr
ICppbXhfY2xrX3BsbHYzKGVudW0gaW14X3BsbHYzX3R5cGUgdHlwZSwgY29uc3QgY2hhciAqbmFt
ZSwNCiAJY2FzZSBJTVhfUExMVjNfQVZfSU1YNzoNCiAJCXBsbC0+bnVtX29mZnNldCA9IFBMTF9J
TVg3X05VTV9PRkZTRVQ7DQogCQlwbGwtPmRlbm9tX29mZnNldCA9IFBMTF9JTVg3X0RFTk9NX09G
RlNFVDsNCisJCS8qIGZhbGwgdGhyb3VnaCAqLw0KIAljYXNlIElNWF9QTExWM19BVjoNCiAJCW9w
cyA9ICZjbGtfcGxsdjNfYXZfb3BzOw0KIAkJYnJlYWs7DQotLSANCjIuNy40DQoNCg==
