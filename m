Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B358E218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HG+CJurs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfDXPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:04:17 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:58894
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727913AbfDXPER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIiI9M/jhmL0p7BFmuwxWiTVtiC1b6JZTr4idNRLSiU=;
 b=HG+CJursnLJQ0dF9hpdbkEi2GIPyCQqBp4c8CYvoNZi2x+6XeLJ4vrwAedI8dCC3PcJne8o530pQ6piv+OR0NgFbMbLviipwVvmbklBvBk8lsbnsBRHd4KvY4PqYLNrUFJX1r5AuklVg56iSTTkNdYA3kXGAVJy3FgFOhp7U5S4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2752.eurprd04.prod.outlook.com (10.175.22.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 15:04:12 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 15:04:12 +0000
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
Subject: [PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Topic: [PATCH v3 0/2] Enable wm8524 codec on i.MX8MM EVK
Thread-Index: AQHU+q75VO1frSIbAE6/1KPPYSNSdw==
Date:   Wed, 24 Apr 2019 15:04:12 +0000
Message-ID: <20190424150350.7963-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0016.eurprd05.prod.outlook.com
 (2603:10a6:800:92::26) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9289b4f3-2fde-4b2f-48a1-08d6c8c61bed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2752;
x-ms-traffictypediagnostic: VI1PR0402MB2752:
x-microsoft-antispam-prvs: <VI1PR0402MB275298CA56566AE42521D8F2F93C0@VI1PR0402MB2752.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(86362001)(52116002)(6512007)(53936002)(54906003)(6916009)(66066001)(2501003)(2906002)(4326008)(2351001)(25786009)(44832011)(6116002)(3846002)(66556008)(476003)(71200400001)(71190400001)(64756008)(2616005)(66446008)(316002)(256004)(73956011)(5640700003)(478600001)(5660300002)(66946007)(26005)(81156014)(50226002)(8936002)(66476007)(6486002)(4744005)(36756003)(7736002)(486006)(305945005)(8676002)(14454004)(102836004)(81166006)(68736007)(386003)(1730700003)(97736004)(186003)(1076003)(6506007)(6436002)(99286004)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2752;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o25fnSigWs5lPfy3C6T+2V5xUq6hhCSQKEzaNjOEdgA6MHGFZXOliPe1gxddCOrNrRm+kwjCPnMoFWKnwsWKoYJDLHfheTXijZjsBkGFvzyhAB+0f3bIje2o0mIpFDU0avuxjSCLhqUY9pAwLgxhwl2eC4p2CPrCKIgfmIrd0xBhxjqo5cKsyCU9bpdL+bK8lcnfiaXUFdLt7SZpAR5kaI8lXYzzE6tEds24daG8OniyI3uY8rw3JVlm2a54RqoT/gSwROe78hAh4ycoopAKWcodBToZeSDLluUI343th8zhzM/4WiIul5WKBm48qYOTqws+k7j1ktV9EKp4uE52KD4ELl1Ml7AcbA4NlxqAzNmQABFqpD8qexy0lQnRnnCU3pAovV2UKmaGVm/EBmvAsURemUGRKBX+C/5CqP0qx+U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9289b4f3-2fde-4b2f-48a1-08d6c8c61bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 15:04:12.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyB0aGUgU0FJIG5vZGVzIG9uIGkuTVg4TU0gRVZL
IHRoZW4NCmNyZWF0ZXMgdGhlIHdtODUyNCBjb2RlYyBub2RlIGFuZCBmaW5hbGx5IHVzZXMgc2lt
cGxlIGNhcmQgbWFjaGluZQ0KZHJpdmVyIHRvIGNyZWF0ZSBhIHNvdW5kIGNhcmQuDQoNCkNoYW5n
ZXMgc2luY2UgdjI6DQoJLSBwbGFjZSBjb21wYXRpYmxlIHN0cmluZ3Mgb25lIGEgc2luZ2xlIGxp
bmVzDQoJLSBtb3ZlIEdQSU8gcGluY3RybCBpbiBhIG5vZGUgb2YgaXRzIG93bg0KCS0gcmVtb3Zl
IGNvZGVjIHBoYW5kbGUNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAgICAgICAgLSB1c2UgImZzbCxp
bXg4bW0tc2FpIiwgImZzbCxpbXg4bXEtc2FpIiBjb21wYXRiaWxlIHN0cmluZ3MgYW5kDQogICAg
ICAgICAgcmVtb3ZlICJmc2wsaW14NnN4LXNhaSIgYmVjYXVzZSBTQUkgbW9kdWxlIG9uIGkuTVg4
TSBpcyBub3QNCiAgICAgICAgICBjb21wYXRiaWxlIHdpdGggU0FJIG1vZHVsZXMgZm9ybSBpLk1Y
Ng0KDQpEYW5pZWwgQmFsdXRhICgyKToNCiAgYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgU0FJIG5v
ZGVzDQogIGFybTY0OiBkdHM6IGlteDhtbS1ldms6IEVuYWJsZSBhdWRpbyBjb2RlYyB3bTg1MjQN
Cg0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzIHwgNTUgKysr
KysrKysrKysrKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNp
ICAgIHwgNjYgKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEyMSBpbnNl
cnRpb25zKCspDQoNCi0tIA0KMi4xNy4xDQoNCg==
