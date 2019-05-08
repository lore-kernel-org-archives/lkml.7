Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1049C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A03421019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K98dhjJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEHHLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:11:00 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:22950
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfEHHK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYai1Jw0xFNYTIJz3DBdoBUYq/FaVCz9WjPVRNeowUA=;
 b=K98dhjJcT6xY8RGG+XnVXbufWGQuUL44SwWEASsHJtBi+s3VfrnMJxqLYoNdvFWN8uN+IezANZ4atDjeaTZ3s7apDFA3tj2Wxrdo2W6N2glOJhdbMSRAwt2KOnh0bzCYJuxo3UCgzKtvmAFg+HwdqE0waANDknFf/qmDZEtAgeg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3695.eurprd04.prod.outlook.com (52.134.15.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 07:10:55 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 07:10:55 +0000
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
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Topic: [RESEND PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Index: AQHVBW0tmuRPzu4TeUu6rOV/fWl/SA==
Date:   Wed, 8 May 2019 07:10:54 +0000
Message-ID: <20190508071032.31808-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0278.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::45) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61558c64-afb4-4a95-9bd6-08d6d3844fbb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3695;
x-ms-traffictypediagnostic: VI1PR0402MB3695:
x-microsoft-antispam-prvs: <VI1PR0402MB3695FFDA2AAC4A961CB838F9F9320@VI1PR0402MB3695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(1730700003)(81156014)(256004)(71190400001)(6916009)(6116002)(3846002)(36756003)(2906002)(25786009)(66066001)(8936002)(44832011)(486006)(186003)(316002)(71200400001)(305945005)(478600001)(7736002)(7416002)(50226002)(2616005)(5660300002)(26005)(476003)(6486002)(4744005)(5640700003)(2351001)(14454004)(66476007)(66556008)(64756008)(66446008)(2501003)(6436002)(8676002)(81166006)(53936002)(86362001)(6506007)(386003)(102836004)(52116002)(73956011)(68736007)(6512007)(54906003)(99286004)(66946007)(1076003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3695;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bWCukq7qUiPXbep1oojpahO6bIVgb+gPQC1fhGknyT3+V2GFa2Mlig3s73xMAZ3fgCj5jODofd7SXg9C2I1uPszyDHmzvlj+16AVv4kuwRvUyXaxiwEZ5RYm8Q9JUdgLkaVEBvvb/uPq2hbMgBiWburzkW8INoy3kEGSCvd9fs4nhxU1axW3Dq29LvcfhJfpashGrCvT/zhTLBIrO038uB6m+U6OtT2T1Kk3gZFSLbxB2FUhXLS13B/dpPtxBOdFiokTZ+Vx3H539gQN8qynDKZO8oymEdNGYeKypzj2RalJylAjponMCd5FljNFUHL5UADo0XFidHaY5tSd/kdlh75RDO5xELD1bp/qO3gHQWmi3Zo23UeIkdDhs4LwpzKCD6+58d9otb46gjsPOBmFaErHVpS6wJ3bwwc5rK7BJAE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61558c64-afb4-4a95-9bd6-08d6d3844fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 07:10:54.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyB0aGUgU0FJIG5vZGVzIG9uIGkuTVg4TU0gRVZL
IHRoZW4NCmNyZWF0ZXMgdGhlIHdtODUyNCBjb2RlYyBub2RlIGFuZCBmaW5hbGx5IHVzZXMgc2lt
cGxlIGNhcmQgbWFjaGluZQ0KZHJpdmVyIHRvIGNyZWF0ZSBhIHNvdW5kIGNhcmQuDQoNCkNoYW5n
ZXMgc2luY2UgdjI6DQogICAgICAgLSBwbGFjZSBjb21wYXRpYmxlIHN0cmluZ3Mgb25lIGEgc2lu
Z2xlIGxpbmVzDQogICAgICAgLSBtb3ZlIEdQSU8gcGluY3RybCBpbiBhIG5vZGUgb2YgaXRzIG93
bg0KICAgICAgIC0gcmVtb3ZlIGNvZGVjIHBoYW5kbGUNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAg
ICAgICAgLSB1c2UgImZzbCxpbXg4bW0tc2FpIiwgImZzbCxpbXg4bXEtc2FpIiBjb21wYXRiaWxl
IHN0cmluZ3MgYW5kDQogICAgICAgICAgcmVtb3ZlICJmc2wsaW14NnN4LXNhaSIgYmVjYXVzZSBT
QUkgbW9kdWxlIG9uIGkuTVg4TSBpcyBub3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgICAgY29tcGF0YmlsZSB3aXRoIFNBSSBtb2R1bGVzIGZvcm0gaS5NWDYNCg0KRGFuaWVs
IEJhbHV0YSAoMik6DQogIGFybTY0OiBkdHM6IGlteDhtbTogQWRkIFNBSSBub2Rlcw0KICBhcm02
NDogZHRzOiBpbXg4bW0tZXZrOiBFbmFibGUgYXVkaW8gY29kZWMgd204NTI0DQoNCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cyB8IDU1ICsrKysrKysrKysrKysr
KysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSAgICB8IDY2ICsr
KysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKQ0K
DQotLSANCjIuMTcuMQ0KDQo=
