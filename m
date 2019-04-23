Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D45C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E2206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BjU5eBMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDWKqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:46:20 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:18775
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfDWKqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fReABTocCEitXDlQCELWMYvr1FXGn296Mte1CWtmniY=;
 b=BjU5eBMVP/n0S6+Ayh0mkWXGoz4oLMU3+Yc/1/PQ+G9nT6ZLtXlqiukn9Dz2MveNv/nty9eXNzujx0008bmpYJCLPBrkVcpLOEzqVC9GIkeDQ8XdWWho0WH2+kfM1v3816m0k1EhdkGssr5/cvVo8I/OSAxQ7bpcfvS4gZRge3A=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4901.eurprd04.prod.outlook.com (20.177.33.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:46:17 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:46:17 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] spi: lpspi: SS function related changes
Thread-Topic: [PATCH 0/3] spi: lpspi: SS function related changes
Thread-Index: AQHU+cHHvMHbCMl4Jk+hyIjKMw2iwQ==
Date:   Tue, 23 Apr 2019 10:46:16 +0000
Message-ID: <20190423104649.24483-1-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: c76e2e31-a21f-48de-2a81-08d6c7d8e871
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4901;
x-ms-traffictypediagnostic: AM6PR04MB4901:
x-microsoft-antispam-prvs: <AM6PR04MB49013111F12E29501B4822F2F3230@AM6PR04MB4901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(26005)(186003)(66066001)(102836004)(6506007)(386003)(2616005)(486006)(316002)(476003)(52116002)(256004)(2351001)(2906002)(66946007)(73956011)(86362001)(6116002)(3846002)(99286004)(36756003)(66446008)(66556008)(66476007)(64756008)(54906003)(5660300002)(71200400001)(50226002)(478600001)(71190400001)(305945005)(8676002)(2501003)(6512007)(8936002)(6436002)(68736007)(1730700003)(81156014)(25786009)(4744005)(81166006)(6916009)(4326008)(14454004)(5640700003)(1076003)(53936002)(6486002)(97736004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4901;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VeZ2AfLpaP8aq+cynfB8T+mDHA2hdIMXwbhilt1q8+sEXEm5KamoJTqFUmkqcupaAJaTcSe6YyCt4A8Fd6+xy9Ps5WMFFjwQ7nZetwDGI1pzge8DOCeu0kLV0iKgECtaMUAwo++Ufxq5mjGl2HWp9joRERhQBz5KYP3E3ebR6QpVzkjQUHppBFgPZd5sdzPITEdvjMP0v6HJVfAX8orW2Ct93X5XTd10wM72KOHct54pEC0yytnsw3Xo5AFyaoVfgkPcv89fEhN0z/eIL02WYLYuPGC98lWNUkCBd7mj9JE3X+UmI9KKy5ZLaKKvCu08Q0ZetYb8uoU88VPjhlfoJdQg3nH5tg6neP6sgVsqLy3+E56O32tZPXTXfPtckNWHvMZ/GC0FYtKrryk2YH/kgvFPr+bkZIFsWCG2lUZFJN8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76e2e31-a21f-48de-2a81-08d6c7d8e871
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:46:17.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KVGhlc2UgdGhyZWUgcGF0Y2hlcyBkbyBzb21lIGNvZGUgY2xlYW4gdXAgd29y
a3MgYW5kIGZpeCBhIHByb2JsZW0NCndoZW4gdXNlIG11bHRpIFNTIGluIFBJTyBtb2RlLg0KDQpD
bGFyayBXYW5nICgzKToNCiAgc3BpOiBscHNwaTogYWRkIE5VTEwgY2hlY2sgd2hlbiBwcm9iZSBk
ZXZpY2UNCiAgc3BpOiBscHNwaTogYWRkIG11bHRpIFNTIHN1cHBvcnQgaW4gUElPIG1vZGUNCiAg
c3BpOiBscHNwaTogcmVtb3ZlIGZzbF9scHNwaS0+Y2hpcHNlbGVjdA0KDQogZHJpdmVycy9zcGkv
c3BpLWZzbC1scHNwaS5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQotLSANCjIu
MTcuMQ0KDQo=
