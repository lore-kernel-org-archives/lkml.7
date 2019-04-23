Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33533C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E02175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rxff0Qc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDWKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:46:24 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:14144
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfDWKqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp34DEcJC0O3rNbpjGvHZXNMATERqiweHNPhkF8qYrs=;
 b=rxff0Qc+MBllNf8QPk/h8k7a12Brk/tkvFS4T+j4EaVgvnS0qpQM6tOJ9RTwFBKJtVioee9jQFNfG7bKvsLOpILeiZj1jFCILxUVROQX/8ACGptKlB2yx6bN7nqixN76Qc5BJCFZ22JTZArzNMVR3sgb1p6ekJOySXlD0+nkA7Q=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4901.eurprd04.prod.outlook.com (20.177.33.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:46:20 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:46:20 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] spi: lpspi: add NULL check when probe device
Thread-Topic: [PATCH 1/3] spi: lpspi: add NULL check when probe device
Thread-Index: AQHU+cHJBHHatzNdukyh2ONacwbbug==
Date:   Tue, 23 Apr 2019 10:46:20 +0000
Message-ID: <20190423104649.24483-2-xiaoning.wang@nxp.com>
References: <20190423104649.24483-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190423104649.24483-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KU1PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:802:19::36) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 200b9d0f-c702-47a6-cf01-08d6c7d8eafb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4901;
x-ms-traffictypediagnostic: AM6PR04MB4901:
x-microsoft-antispam-prvs: <AM6PR04MB490170E6302F05F9AE25150BF3230@AM6PR04MB4901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(26005)(186003)(66066001)(102836004)(11346002)(6506007)(386003)(2616005)(486006)(316002)(76176011)(476003)(52116002)(446003)(256004)(2351001)(2906002)(66946007)(73956011)(86362001)(6116002)(3846002)(99286004)(36756003)(66446008)(66556008)(66476007)(64756008)(54906003)(5660300002)(71200400001)(50226002)(478600001)(71190400001)(305945005)(8676002)(2501003)(6512007)(8936002)(6436002)(68736007)(1730700003)(81156014)(25786009)(4744005)(81166006)(6916009)(4326008)(14454004)(5640700003)(1076003)(53936002)(6486002)(97736004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4901;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LbUcxDiGSu6n+HRBzXQ9OZBOWY8Ptmu/Xf5BqvbBXu6GXy6cb0rW3MiWLuIrw2pHMnak/RF7B7QMAbQq6ptyNBDblYohZegomgkww+VSKRNpsO6n8gBDwVSFQHuTX/B8jAh+Y9KL+E2aqQgbasOaL12a8fGG/U9DvcvYxAn8RI5pCrYmpYK7AalnkpM+w+TcmPZT6Sg0If7et4ReQRTlD3ggBCxi/3lZuhtDNsWI96od1GoOW/l4MciDJ2bzWym60mctOrti81GHBKo5nijHGkWUjIN9+WMXsoRCjOXi+VEdJS6T7VNWOgAarQsYoVFvi84gjybMksjoHiwf9ZCyQzYiMwGCJukUzYKunwWWSPUkCD8HuuBhgzxi3K/SWAju/87M1moIzb3CWvScELoqxkOq0f6zt8DIPquvGOwWskk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b9d0f-c702-47a6-cf01-08d6c7d8eafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:46:20.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgTlVMTCBjaGVjayBmb3IgZGV2aWNlIG5vZGUgYW5kIGxwc3BpX3BsYXRmb3JtX2luZm8g
d2hlbiBscHNwaQ0KZGV2aWNlIHByb2JlLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGFyayBXYW5nIDx4
aWFvbmluZy53YW5nQG54cC5jb20+DQpBY2tlZC1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFu
QG54cC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktZnNsLWxwc3BpLmMgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
cGkvc3BpLWZzbC1scHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQppbmRleCBk
MDhlOTMyNDE0MGUuLjE5MDQwYjVlZjM0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1m
c2wtbHBzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQpAQCAtODQ1LDYg
Kzg0NSwxMSBAQCBzdGF0aWMgaW50IGZzbF9scHNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAl1MzIgdGVtcDsNCiAJYm9vbCBpc19zbGF2ZTsNCiANCisJaWYgKCFucCAm
JiAhbHBzcGlfcGxhdGZvcm1faW5mbykgew0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2FuJ3Qg
Z2V0IHRoZSBwbGF0Zm9ybSBkYXRhXG4iKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQog
CWlzX3NsYXZlID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKCgmcGRldi0+ZGV2KS0+b2Zfbm9kZSwg
InNwaS1zbGF2ZSIpOw0KIAlpZiAoaXNfc2xhdmUpDQogCQljb250cm9sbGVyID0gc3BpX2FsbG9j
X3NsYXZlKCZwZGV2LT5kZXYsDQotLSANCjIuMTcuMQ0KDQo=
