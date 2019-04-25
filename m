Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E7C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8838E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mCBrqgDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfDYJry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:47:54 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:24801
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfDYJrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+grDzYcg5Zf+Zh1JY9iuxS1XuAUQ8RspAWutLmDVmt0=;
 b=mCBrqgDFO0WUtrkTBdFJQeFRi2sV/kWr5YXiPLZmt/YgqSOjxJM5JBh9VEFOCvZg8EZbsTst9ft/2wjuKgEH7p48psbYxJbTj07G3b0/b0pwD3efZRr4GZfV2lUPD/MkfYpJW/QR81Z5fegsbrsE7uajhg5vXMZAzSldMHbfw74=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4782.eurprd04.prod.outlook.com (20.177.48.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 09:47:49 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 09:47:48 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2] clk: qoriq: increase array size of cmux_to_group
Thread-Topic: [PATCH v2] clk: qoriq: increase array size of cmux_to_group
Thread-Index: AQHU+0vwJnYS6QcNeEyXeRBp9/rMTw==
Date:   Thu, 25 Apr 2019 09:47:48 +0000
Message-ID: <1556185682-26205-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::19) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24f2f413-f42b-4887-43f4-08d6c963134a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4782;
x-ms-traffictypediagnostic: VI1PR04MB4782:
x-microsoft-antispam-prvs: <VI1PR04MB478219F3E2FF3FF4009607A7F33D0@VI1PR04MB4782.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(102836004)(97736004)(53936002)(86362001)(6512007)(6116002)(6506007)(386003)(36756003)(305945005)(186003)(3846002)(14454004)(26005)(2906002)(7736002)(5660300002)(68736007)(486006)(44832011)(316002)(71190400001)(71200400001)(66946007)(73956011)(25786009)(14444005)(2616005)(476003)(4326008)(52116002)(256004)(8676002)(6436002)(6486002)(66066001)(66476007)(81166006)(110136005)(54906003)(99286004)(66446008)(2501003)(81156014)(66556008)(478600001)(50226002)(8936002)(64756008)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4782;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: re06ED8RhduzvheIKJRwOU0Ed0PWJlaJZg7YzLzjbe//zxrGLxtjs0asQo+gDa6oxwhEDedZc6mEQ9QOAOKo/cd6xMJIymSD2cuhrTzYUcUwfC9WFh6Vfwo98+41dCJmc7SXet3zn/OEgXh++CDQvv0Ee7tSdUsB8RiKZ1shWuDqZTv3LtTuChs3EhK41a2KnSBPb8j7wbm0clK53KdLh+uOoHCsrReuX52Sdf5AvZwowTZZCMxyGNF39gBdwA+zouJKys8Tq0KEDe1vZa1fIT49gIDRnlt9NxtW5hzXGMrpYJHi9cTzM2NEBM1V9xBXvLcizwu7rrz//48FMmbgzZXo+mf9dLKOL6Zyn/XwP/oZF9Go9cyFQ4Cqta6RukosE4IGh17Bm5FCsMqswxWMHKyTA8fYxOJmj3Pwhns1sso=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f2f413-f42b-4887-43f4-08d6c963134a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 09:47:48.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4782
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
IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCi0tLQ0KQ2hhbmdlcyBmb3IgdjI6DQot
IEluY29ycG9yYXRlZCByZXZpZXcgY29tbWVudHMgZnJvbSBTdGVwaGVuIEJveWQNCi0gU3ViamVj
dCBsaW5lIG1vZGlmaWVkDQotIEluZGVudGF0aW9uIHVwZGF0ZQ0KDQogZHJpdmVycy9jbGsvY2xr
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
