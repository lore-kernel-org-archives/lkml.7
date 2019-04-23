Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C96C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E92206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JXAj3DFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfDWNu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:50:56 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:54149
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbfDWNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne8lUTHYIL86i2wNgDyCIKewW238BE0WWwtYB4rlmGc=;
 b=JXAj3DFmEOFru6x0/lPR7HlgtaLcZ71yZFnjURs1JZR5Qw+5bngWWmwCD0snzz5scI7hnF26UBn1Dn48ikakAF7wyYM5pMAQI4l3050dzpo3KBzhfXApS89BM3IHew6GmzztGuDBYDpW4xt8YlY99SXklEqcg7JtlNj/CtRX7Kk=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:50:51 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:50:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 03/15] Revert "dmaengine: imx-sdma: refine to load context
 only once"
Thread-Topic: [PATCH v1 03/15] Revert "dmaengine: imx-sdma: refine to load
 context only once"
Thread-Index: AQHU+duPqWP1++sN+UeKcuN3QVbcKA==
Date:   Tue, 23 Apr 2019 13:50:50 +0000
Message-ID: <1556027045-5269-4-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2355795-1a6b-4c9d-1e91-08d6c7f2b23b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-microsoft-antispam-prvs: <VI1PR04MB5901E31F841BBD25E487A62E89230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(52116002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IImAdT2rTldZKHduYiJCEXu0WHBpmnVmIOOSl+PkPRpzqkPxOTZP9Pfs7iSy16xpFv2vJO6TQb/zKI+H6YcZ9kr2BRrXo26kG2GNlbmnUMv/V4A/lBft0buujNeyZ4Nb79zV0dvywIuRi0WcezSZSp4drUwp8OIeXjFbuhToNIv7ILCu5qyH4JaHpi7SNMym7qBb9jG23u5q9n9yA2Mgb5HGDmsc3uH2pkl2w8uWMBzBa7swjz5E4bodDPiLIr4ZJ4yEbtKF1r5W6FP5B/ynYZ0VAM+C4z+uW9qM23iGazqhqggXnospk9ihYo1Q1Ixd3aJQ9jUJSn85RDqwx/PWtC5QaknlmWyxpl28CDMc2szIFFx5F7rcjJV9iKPIcoqfHJjb9glbGBhTt+x62Zzx+car7eXBWI2ROI7VW/E9sHc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2355795-1a6b-4c9d-1e91-08d6c7f2b23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:50:50.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBhZDBkOTJkN2JhNmFlY2JlMjcwNTkwN2MzOGZmOGQ4YmU0ZGEx
ZTljLCBiZWNhdXNlDQppbiBzcGktaW14IGNhc2UsIGJ1cnN0IGxlbmd0aCBtYXkgYmUgY2hhbmdl
ZCBkeW5hbWljYWxseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDcgLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDk5ZDlmNDMuLjQwN2E1NmUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jDQpAQCAtMzc3LDcgKzM3Nyw2IEBAIHN0cnVjdCBzZG1hX2NoYW5uZWwgew0KIAl1
bnNpZ25lZCBsb25nCQkJd2F0ZXJtYXJrX2xldmVsOw0KIAl1MzIJCQkJc2hwX2FkZHIsIHBlcl9h
ZGRyOw0KIAllbnVtIGRtYV9zdGF0dXMJCQlzdGF0dXM7DQotCWJvb2wJCQkJY29udGV4dF9sb2Fk
ZWQ7DQogCXN0cnVjdCBpbXhfZG1hX2RhdGEJCWRhdGE7DQogCXN0cnVjdCB3b3JrX3N0cnVjdAkJ
dGVybWluYXRlX3dvcmtlcjsNCiB9Ow0KQEAgLTk4OCw5ICs5ODcsNiBAQCBzdGF0aWMgaW50IHNk
bWFfbG9hZF9jb250ZXh0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIAlpbnQgcmV0Ow0K
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KLQlpZiAoc2RtYWMtPmNvbnRleHRfbG9hZGVkKQ0K
LQkJcmV0dXJuIDA7DQotDQogCWlmIChzZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fTUVN
KQ0KIAkJbG9hZF9hZGRyZXNzID0gc2RtYWMtPnBjX2Zyb21fZGV2aWNlOw0KIAllbHNlIGlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKQ0KQEAgLTEwMzMsOCArMTAyOSw2IEBA
IHN0YXRpYyBpbnQgc2RtYV9sb2FkX2NvbnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMp
DQogDQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNkbWEtPmNoYW5uZWxfMF9sb2NrLCBmbGFn
cyk7DQogDQotCXNkbWFjLT5jb250ZXh0X2xvYWRlZCA9IHRydWU7DQotDQogCXJldHVybiByZXQ7
DQogfQ0KIA0KQEAgLTEwNzQsNyArMTA2OCw2IEBAIHN0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF90
ZXJtaW5hdGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCXNkbWFjLT5kZXNjID0g
TlVMTDsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsN
CiAJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KCZzZG1hYy0+dmMsICZoZWFkKTsNCi0Jc2RtYWMt
PmNvbnRleHRfbG9hZGVkID0gZmFsc2U7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9kaXNhYmxl
X2NoYW5uZWxfYXN5bmMoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KLS0gDQoyLjcuNA0KDQo=
