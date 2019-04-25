Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E41C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C89214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERaNGG4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfDYI60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:58:26 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:28935
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfDYI6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxArzx5LapsSizRQ6GtpQd3NW5Bbr9O2nwqkeARy4Rc=;
 b=ERaNGG4vdMbLBLH8NA0Wjob4xNlMuw/Vh+sB6tFgp3pEP+PfvNWbi1oP/Lv0f0YOp8X3hvQziO956/wEBKcrLg/sP0EVf/rkeoRr6hr6Tr4WpGWO8KQ2DfFeBftWRQFm803HgD5f2/tkcmu3k46myuECTbJHwEo0DSTLpTKoFwo=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5503.eurprd04.prod.outlook.com (20.178.122.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 08:58:21 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:58:21 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH v2] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHU+0UI0uc08PbIX0aEjsibKUKapA==
Date:   Thu, 25 Apr 2019 08:58:21 +0000
Message-ID: <1556182715-6761-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a9b04b-a933-4ebc-1662-08d6c95c2ae4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5503;
x-ms-traffictypediagnostic: VI1PR04MB5503:
x-microsoft-antispam-prvs: <VI1PR04MB55039E7AABCAE9AA764FA4DFF33D0@VI1PR04MB5503.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(102836004)(81166006)(6486002)(316002)(81156014)(6436002)(476003)(110136005)(6512007)(2616005)(2906002)(8936002)(4326008)(5660300002)(68736007)(26005)(8676002)(52116002)(6506007)(386003)(14454004)(97736004)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(478600001)(256004)(36756003)(305945005)(186003)(2501003)(7736002)(86362001)(54906003)(99286004)(71190400001)(71200400001)(25786009)(44832011)(3846002)(6116002)(486006)(66066001)(14444005)(50226002)(53936002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5503;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bRWMbUiqalFo7H7fBUt8+7vutfFssLigVXdYQRRolUVcfAiNBQsrgyood/b6oTMysL/R7oJs3AmSgV52NECCssTI9upW8s9SsOhEjwRywKom59jzZIZ19/ZuU6gVV8p8jKBLry7vBsdncJLUEYy7uq8yF1h22/HRT1YO84eOzdJmOt2kNllneBP8fvjEdr3AmtcyV3dSuvc1EC+iMAQsVLFOIfqyYT3aK2kauz1MmuNGLcFVYD31X0PL1pnOJK/SuDpP9KJmQzf1A38LJr66m5LrLavjAgfLphtmTSrzJK699BPxbmdHV1agduQHd4TUzw4DREc2PJkCzq2WEHypVtfyHAdBJ1DBfsb/wWnHv9SGS+SA74/o8TF+eWJkbUypQsFRhzwHL8rCY3iuQdTXH/KWdE96Qpaz9gwhfdajfT8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a9b04b-a933-4ebc-1662-08d6c95c2ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:58:21.6391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpJbmNyZWFz
ZSBzaXplIG9mIGNtdXhfdG9fZ3JvdXAgYXJyYXksIHRvIGFjY29tZGF0ZSBlbnRyeSBvZg0KLTEg
dGVybWluYXRpb24uDQoNCkFkZGVkIC0xLCB0ZXJtaW5hdGVkLCBlbnRyeSBmb3IgNDA4MF9jbXV4
X2dycFguDQoNClNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhw
LmNvbT4NCkFja2VkLWJ5OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KQWNrZWQtYnk6
IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCg0KQ2hhbmdlcyBmb3IgdjI6DQotIElu
Y29ycG9yYXRlZCByZXZpZXcgY29tbWVudHMgZnJvbSBTdGVwaGVuIEJveWQNCi0gU3ViamVjdCBs
aW5lIG1vZGlmaWVkDQotIEluZGVudGF0aW9uIHVwZGF0ZQ0KLS0tDQogZHJpdmVycy9jbGsvY2xr
LXFvcmlxLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2
ZXJzL2Nsay9jbGstcW9yaXEuYw0KaW5kZXggMTIxMmE5Yi4uM2Q1MWQ3YyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jDQorKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0K
QEAgLTc5LDcgKzc5LDcgQEAgc3RydWN0IGNsb2NrZ2VuX2NoaXBpbmZvIHsNCiAJY29uc3Qgc3Ry
dWN0IGNsb2NrZ2VuX211eGluZm8gKmNtdXhfZ3JvdXBzWzJdOw0KIAljb25zdCBzdHJ1Y3QgY2xv
Y2tnZW5fbXV4aW5mbyAqaHdhY2NlbFtOVU1fSFdBQ0NFTF07DQogCXZvaWQgKCppbml0X3Blcmlw
aCkoc3RydWN0IGNsb2NrZ2VuICpjZyk7DQotCWludCBjbXV4X3RvX2dyb3VwW05VTV9DTVVYXTsg
LyogLTEgdGVybWluYXRlcyBpZiBmZXdlciB0aGFuIE5VTV9DTVVYICovDQorCWludCBjbXV4X3Rv
X2dyb3VwW05VTV9DTVVYKzFdOwkvKiBhcnJheSBzaG91bGQgYmUgLTEgdGVybWluYXRlZCAqLw0K
IAl1MzIgcGxsX21hc2s7CS8qIDEgPDwgbiBiaXQgc2V0IGlmIFBMTCBuIGlzIHZhbGlkICovDQog
CXUzMiBmbGFnczsJLyogQ0dfeHh4ICovDQogfTsNCkBAIC02MDEsNyArNjAxLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyBjaGlwaW5mb1tdID0gew0KIAkJCSZwNDA4
MF9jbXV4X2dycDEsICZwNDA4MF9jbXV4X2dycDINCiAJCX0sDQogCQkuY211eF90b19ncm91cCA9
IHsNCi0JCQkwLCAwLCAwLCAwLCAxLCAxLCAxLCAxDQorCQkJMCwgMCwgMCwgMCwgMSwgMSwgMSwg
MSwgLTENCiAJCX0sDQogCQkucGxsX21hc2sgPSAweDFmLA0KIAl9LA0KLS0gDQoyLjcuNA0KDQo=
