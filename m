Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE492C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295820821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZetQu7da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfDSUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:20:45 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27715
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfDSUUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CZJLHVhzogxR71pV2C3GZjwlr9G/OUF3tkW+5TbGys=;
 b=ZetQu7da1gNQB+O17fMi+sXxWcrTDV8HuGJB+IGB52rSL3WRz7UHtPHe3c4ObfIJXaUx7ygwNGpksvbzeqnVCveCDLSx2d8tpvalGYF/cjs+XnCYyQEeONr/u6bX5UQokyaGvxmcYUZp4bvIZUAmo2LUa/bbtuJxq/YiXzEaUM4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 20:20:38 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 20:20:38 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Topic: [PATCH 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Index: AQHU9u1a10bNYzI7b0W19kRGdhUvhQ==
Date:   Fri, 19 Apr 2019 20:20:38 +0000
Message-ID: <20190419202024.27314-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36eb1ab6-e9eb-434d-6bf3-08d6c5047cc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3392;
x-ms-traffictypediagnostic: VI1PR0402MB3392:
x-microsoft-antispam-prvs: <VI1PR0402MB3392B132BDCBC64EDE6DC6F2F9270@VI1PR0402MB3392.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(81166006)(68736007)(1730700003)(8936002)(81156014)(44832011)(1076003)(4744005)(2501003)(50226002)(71200400001)(54906003)(4326008)(52116002)(71190400001)(25786009)(8676002)(99286004)(316002)(66066001)(5660300002)(305945005)(7736002)(53936002)(86362001)(6436002)(6486002)(73956011)(5640700003)(14454004)(36756003)(6916009)(97736004)(102836004)(66556008)(66476007)(66446008)(386003)(64756008)(6512007)(478600001)(3846002)(256004)(6116002)(26005)(2906002)(66946007)(6506007)(2616005)(486006)(476003)(2351001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3392;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iRXTpVbS+FJwDRsSGVDBO1b796t2tqOap/8/pHn8zcDNCpmcOyMc7tKIx1Dnb0ZlxP29Si38mXUkD8lFy4f/bmGQf4XTsKUr5n2LgPEMi+rRFdPC3aY1H6JyXJzfhI79H6BGSgRnMiN4sPTuVEQEcvtiRImx6z+h9Qtj+5xbUjuV6Q/kiRvxEuuMKQQ6iVbaFLbYqU1DNq4AYh9rdnbLUIL26V13dbyq5Q5NaTH4p6AQWpGD8ISgOQG536vkHDAov665kVwZQBWiENEbk5JROvh0Dz7hRdid//uWRo1BwfKTQBPOYM0H7H6kx59v744isF0zwcPLF24w1CIaDEmYApTKS+zld9wMugtEaIuNI8eu0owaDM0kSPTZgpa5yGWJwBMGX5+0v7xuDh6afEjI/oXD98+wJPrP8AG6nqEARac=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eb1ab6-e9eb-434d-6bf3-08d6c5047cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 20:20:38.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyB0aGUgU0FJIG5vZGVzIG9uIGkuTVg4TU0gRVZL
IHRoZW4NCmNyZWF0ZXMgdGhlIHdtODUyNCBjb2RlYyBub2RlIGFuZCBmaW5hbGx5IHVzZXMgc2lt
cGxlIGNhcmQgbWFjaGluZQ0KZHJpdmVyIHRvIGNyZWF0ZSBhIHNvdW5kIGNhcmQuDQoNCkRhbmll
bCBCYWx1dGEgKDIpOg0KICBhcm02NDogZHRzOiBpbXg4bW06IEFkZCBTQUkgbm9kZXMNCiAgYXJt
NjQ6IGR0czogaW14OG1tLWV2azogRW5hYmxlIGF1ZGlvIGNvZGVjIHdtODUyNA0KDQogYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMgfCA0OCArKysrKysrKysrKysr
Kw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpICAgIHwgNjggKysr
KysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRpb25zKCspDQoN
Ci0tIA0KMi4xNy4xDQoNCg==
