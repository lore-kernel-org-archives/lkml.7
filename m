Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8E20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bX2JsWi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfDVTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:36:37 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:46957
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfDVTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPCiOZL/E9ahtFPgEQmiaIDbjupg3LKtyuLtkayLq8o=;
 b=bX2JsWi58nQ79XtY+CJbuZRqbtmP0Qw4b988bjQCTG/ATJSOwimaRFZSHdUba/ZqNLAEceRQVtknxy2/qDrbmnNaY3/IniQEr9em/5uyymYsMDNWb6X5JgTEfSbfN6uukSj7wtezHQ6x8htxEWHevhm05ULjOWqZRf88kibynwQ=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2861.eurprd04.prod.outlook.com (10.175.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 19:35:59 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:35:59 +0000
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
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Topic: [PATCH v2 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Index: AQHU+UKcr+wyzOSsv0KzOf+0LVklgA==
Date:   Mon, 22 Apr 2019 19:35:58 +0000
Message-ID: <20190422193542.2853-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3149411b-c529-47bb-50e7-08d6c759bed3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2861;
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-microsoft-antispam-prvs: <VI1PR0402MB2861CD1E78D3629F91DA3C6EF9220@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(102836004)(6116002)(3846002)(54906003)(2616005)(386003)(2906002)(6506007)(476003)(25786009)(4326008)(97736004)(26005)(186003)(44832011)(36756003)(73956011)(5660300002)(2501003)(5640700003)(1076003)(71190400001)(71200400001)(66946007)(86362001)(66476007)(66066001)(64756008)(66446008)(66556008)(99286004)(478600001)(7736002)(68736007)(6436002)(52116002)(6486002)(6916009)(256004)(53936002)(6512007)(486006)(316002)(14454004)(4744005)(305945005)(8676002)(2351001)(81166006)(81156014)(50226002)(1730700003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2861;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hwJFsLkzw9LBLjs81K7NOFjuHXbgY5YMn3CgTZ4sWU6gXZy8+F0Lb0sFTZ3g7o/2xv7BYmASa/19ABQ7BODOK/m/80UvG9B7Qyuq/Z7oVFeVgkNN2VCdNEYzYN9wewIM0Cc5rqH/MFFCRGyIX7SHZMPKiM8mnECF8rpfG6zrpKG1jT6S3fYRmRYAz7wq6Z2izWrp9JVkzxCWodJjMonYStpAXMh3RFyaDDKUvoj/yJAW7shc36sGkNIkp0ketCDnx4i3CubiJHjjhfEXOtB1YS+S3J81Xtkp/wP64KuhdtnI53Pz1JL2c+22apSxz5pQ4t7AP5/HBKd8K5izkWbIpqsHTXdBC/csewBVltmnDlRu4CNKXSvcZk29vtQ6pZkn1GG2qyB7hD6f9qr46vgYqT7iAN5h4skFDbmk9Qyw12A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149411b-c529-47bb-50e7-08d6c759bed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:35:58.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyB0aGUgU0FJIG5vZGVzIG9uIGkuTVg4TU0gRVZL
IHRoZW4NCmNyZWF0ZXMgdGhlIHdtODUyNCBjb2RlYyBub2RlIGFuZCBmaW5hbGx5IHVzZXMgc2lt
cGxlIGNhcmQgbWFjaGluZQ0KZHJpdmVyIHRvIGNyZWF0ZSBhIHNvdW5kIGNhcmQuDQoNCkNoYW5n
ZXMgc2luY2UgdjE6DQoJLSB1c2UgImZzbCxpbXg4bW0tc2FpIiwgImZzbCxpbXg4bXEtc2FpIiBj
b21wYXRiaWxlIHN0cmluZ3MgYW5kDQoJICByZW1vdmUgImZzbCxpbXg2c3gtc2FpIiBiZWNhdXNl
IFNBSSBtb2R1bGUgb24gaS5NWDhNIGlzIG5vdA0KCSAgY29tcGF0YmlsZSB3aXRoIFNBSSBtb2R1
bGVzIGZvcm0gaS5NWDYNCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIGFybTY0OiBkdHM6IGlteDht
bTogQWRkIFNBSSBub2Rlcw0KICBhcm02NDogZHRzOiBpbXg4bW0tZXZrOiBFbmFibGUgYXVkaW8g
Y29kZWMgd204NTI0DQoNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZr
LmR0cyB8IDQ4ICsrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaSAgICB8IDcxICsrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2Vk
LCAxMTkgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMTcuMQ0KDQo=
