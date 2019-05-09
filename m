Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE88C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B034021479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9+i2Zy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEINaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:30:39 -0400
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:29892
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfEINaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xv7YxBuTiBgX/OfNMXlKgvXNI8tx5NgnQL9GxV+8Ew=;
 b=Y9+i2Zy8SGbPn6r4rLzcX8Xdmq6IyI9puN+625hkkqjgOIJnCSgA/g22H8AKh3hy0IfgdSgyOsbAuoIIOFh/82rGTSaJ6C+UWc+5o0JfqL1SIbBI19I87mIKqncOAsbzCpA/ydkjsC+BcOUi9t85SS0jFhTTT1/E+ovZMZDUrbc=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4029.eurprd04.prod.outlook.com (10.171.182.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 13:30:35 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:30:35 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH 0/2] ASoC: ak4458: fail on probe if codec is not present
Thread-Topic: [PATCH 0/2] ASoC: ak4458: fail on probe if codec is not present
Thread-Index: AQHVBmtinATQNAne7kuK4xQqWxo8Xg==
Date:   Thu, 9 May 2019 13:30:35 +0000
Message-ID: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2db9afa-fc69-497b-dff6-08d6d4828458
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4029;
x-ms-traffictypediagnostic: VI1PR04MB4029:
x-microsoft-antispam-prvs: <VI1PR04MB4029411E2C9A56625766B07992330@VI1PR04MB4029.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(68736007)(36756003)(71200400001)(50226002)(66066001)(52116002)(2501003)(5660300002)(8936002)(86362001)(6506007)(478600001)(71190400001)(81166006)(8676002)(386003)(81156014)(2906002)(53936002)(25786009)(4326008)(476003)(305945005)(256004)(4744005)(6512007)(99286004)(7736002)(2201001)(66476007)(66556008)(64756008)(66446008)(26005)(66946007)(73956011)(110136005)(54906003)(44832011)(486006)(14454004)(186003)(2616005)(316002)(14444005)(3846002)(6486002)(102836004)(6116002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4029;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1f+rZJT6yvBFqptBV0k1nD630xRF5xxZKS5JrOliYJxrRyLhBbQnZufuzgAa6zo6fNk7ETJ7mjtwOzYiAxPC/RVUmWQprc37qTWOZfzRtMTSeqJGK+0zbWoCgLs6dSLsv8+k4yto8mfQdlEoeGCThd2sPGHe7jZkMdQ0dsapp6GcJMF17VTYV1Wa+96OrMgwa0zJK1wY3YVjG1BsdIK94R/jnUbZCfcJjrmB3zZh/UylIV4FBQ9OzlNIklZuLBuELgORkzWHvQ+iYkCraRdjey5XxKcBa3eu0omjHUqU99OrEj2qqCIQu7a9NApE6WV5opz5D129H/SPYXfEBuBKgY7x/GrR7WA7ouZmApL/xePLmWA066eBBT4YT+hc6rEG+rBIdUWcIc95brH7jurJRne8or+uffMTbOz9iC1Z9X8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db9afa-fc69-497b-dff6-08d6d4828458
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:30:35.3529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUs0NDU4IGlzIHByb2JlZCBzdWNjZXNzZnVsbHkgZXZlbiBpZiBBSzQ0NTggaXMgbm90IHByZXNl
bnQgLSB0aGlzDQppcyBjYXVzZWQgYnkgcHJvYmUgZnVuY3Rpb24gcmV0dXJuaW5nIG5vIGVycm9y
IG9uIGkyYyBhY2Nlc3MgZmFpbHVyZS4NClRoZSBwYXRjaHNldCBmaXhlcyB0aGlzLg0KDQpWaW9y
ZWwgU3VtYW4gKDIpOg0KICBBU29DOiBhazQ0NTg6IHJzdG5fY29udHJvbCAtIHJldHVybiBhIG5v
bi16ZXJvIG9uIGVycm9yIG9ubHkNCiAgQVNvQzogYWs0NDU4OiBhZGQgcmV0dXJuIHZhbHVlIGZv
ciBhazQ0NThfcHJvYmUNCg0KIHNvdW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMgfCAxNiArKysrKysr
KystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjcuNA0KDQo=
