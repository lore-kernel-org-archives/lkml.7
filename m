Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B22C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87B8217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bphqXoPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfDYJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:00:20 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:16289
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfDYJAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1xv8iTfGalx80tXbxq8F0wBjv2P9+kdKUZon7r4Ayg=;
 b=bphqXoPNkDsrlv7HGSyNfASmzq1N/Bo0WO62ZGGfKS/q//fQZopYL+V1vCyJzylS1teIDlkiQE4cg5P93HnEb9U5ib65df+AyHAMfu9lqjoleuReLjnaTHbsMQNGsC5pv1SkmbNikIu2wj1gXo/UzA1/qHMBQbZ1A7/mTpolIdk=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5087.eurprd04.prod.outlook.com (20.177.50.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 09:00:16 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 09:00:16 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHU+0VMeG1ON/JzDEWQk7OLyeNdaw==
Date:   Thu, 25 Apr 2019 09:00:16 +0000
Message-ID: <1556182821-9187-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0449846-a59d-4c43-fe34-08d6c95c6f45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5087;
x-ms-traffictypediagnostic: VI1PR04MB5087:
x-microsoft-antispam-prvs: <VI1PR04MB50872858EA1885AE75ED8865F33D0@VI1PR04MB5087.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(478600001)(71190400001)(305945005)(71200400001)(6512007)(6116002)(3846002)(5660300002)(53936002)(97736004)(6486002)(64756008)(7736002)(25786009)(6436002)(66446008)(14454004)(4326008)(6506007)(386003)(68736007)(66946007)(2906002)(486006)(44832011)(8936002)(73956011)(2616005)(476003)(36756003)(66476007)(102836004)(66556008)(66066001)(26005)(186003)(316002)(54906003)(110136005)(99286004)(2201001)(81166006)(81156014)(86362001)(8676002)(52116002)(50226002)(256004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5087;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bLHQZfFx2CzotfS9+tz7tMCX6oqcAlWvkm8bzEjLzt7wWTPaCoMeqbr78VfAoicNLHtuTnb++tr8zoRBi3m7FrHpWiNfHa9VGJ4eBMc4bS8zDowikqltta3Vwc/20YhXEgdfpOcNDLl9QP5X0cjz0aeJaNCjvfbaOvHHeUawM1R3/TQigu89mJZ2dfaK+QRKcoLZN/mPhvUTKojtyrtPzLmbSI2QqCooYeVGS4KvJ9yRnOwjX24RgnVQNJ9YBQRCr3dWQnIQBRo43JKggAAeGQCQdgqo9qsn/4+LtDZfFhPpfV5qBhPjR9YlrGlDh8W5z0SFk8wbDKNfMzYIhx+C5Pp7tBjxfVJ39ohvT9K+h4EfRFcLmmpKpEM1UmuwO/64UnJT7Z5KaR0U8E7RLv4Gmlq7r86b5OOnFs8MiEsoe4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0449846-a59d-4c43-fe34-08d6c95c6f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 09:00:16.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpBZGQgY2xv
Y2tnZW4gc3VwcG9ydCBmb3IgbHgyMTYwYS4NCkFkZGVkIGVudHJ5IGZvciBjb21wYXQgJ2ZzbCxs
eDIxNjBhLWNsb2NrZ2VuJy4NCg0KU2lnbmVkLW9mZi1ieTogVGFuZyBZdWFudGlhbiA8YW5keS50
YW5nQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5n
YXVyQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1h
QG54cC5jb20+DQpBY2tlZC1ieTogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD4NCkFja2Vk
LWJ5OiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQpBY2tlZC1ieTogVmlyZXNoIEt1
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCg0KQ2hhbmdlcyBmb3IgdjI6DQotIFN1Ympl
Y3QgbGluZSB1cGRhdGVkDQotLS0NCiBkcml2ZXJzL2Nsay9jbGstcW9yaXEuYyAgICAgICAgIHwg
MTIgKysrKysrKysrKysrDQogZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYyB8ICAxICsN
CiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2Nsay1xb3JpcS5jIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCmluZGV4IDNkNTFk
N2MuLjFhMTUyMDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KKysrIGIv
ZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCkBAIC01NzAsNiArNTcwLDE3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8gY2hpcGluZm9bXSA9IHsNCiAJCS5mbGFncyA9IENH
X1ZFUjMgfCBDR19MSVRUTEVfRU5ESUFOLA0KIAl9LA0KIAl7DQorCQkuY29tcGF0ID0gImZzbCxs
eDIxNjBhLWNsb2NrZ2VuIiwNCisJCS5jbXV4X2dyb3VwcyA9IHsNCisJCQkmY2xvY2tnZW4yX2Nt
dXhfY2dhMTIsICZjbG9ja2dlbjJfY211eF9jZ2INCisJCX0sDQorCQkuY211eF90b19ncm91cCA9
IHsNCisJCQkwLCAwLCAwLCAwLCAxLCAxLCAxLCAxLCAtMQ0KKwkJfSwNCisJCS5wbGxfbWFzayA9
IDB4MzcsDQorCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwNCisJfSwNCisJ
ew0KIAkJLmNvbXBhdCA9ICJmc2wscDIwNDEtY2xvY2tnZW4iLA0KIAkJLmd1dHNfY29tcGF0ID0g
ImZzbCxxb3JpcS1kZXZpY2UtY29uZmlnLTEuMCIsDQogCQkuaW5pdF9wZXJpcGggPSBwMjA0MV9p
bml0X3BlcmlwaCwNCkBAIC0xNDI3LDYgKzE0MzgsNyBAQCBDTEtfT0ZfREVDTEFSRShxb3JpcV9j
bG9ja2dlbl9sczEwNDNhLCAiZnNsLGxzMTA0M2EtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsN
CiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczEwNDZhLCAiZnNsLGxzMTA0NmEtY2xv
Y2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9s
czEwODhhLCAiZnNsLGxzMTA4OGEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCiBDTEtfT0Zf
REVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczIwODBhLCAiZnNsLGxzMjA4MGEtY2xvY2tnZW4iLCBj
bG9ja2dlbl9pbml0KTsNCitDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9seDIxNjBhLCAi
ZnNsLGx4MjE2MGEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCiBDTEtfT0ZfREVDTEFSRShx
b3JpcV9jbG9ja2dlbl9wMjA0MSwgImZzbCxwMjA0MS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQp
Ow0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3AzMDQxLCAiZnNsLHAzMDQxLWNsb2Nr
Z2VuIiwgY2xvY2tnZW5faW5pdCk7DQogQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDQw
ODAsICJmc2wscDQwODAtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNw
dWZyZXEuYw0KaW5kZXggNDI5NWU1NC4uODFmMDI4OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9xb3JpcS1jcHVmcmVxLmMNCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVx
LmMNCkBAIC0yODQsNiArMjg0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
bm9kZV9tYXRjaGVzW10gX19pbml0Y29uc3QgPSB7DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxz
MTA0NmEtY2xvY2tnZW4iLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxsczEwODhhLWNsb2Nr
Z2VuIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMyMDgwYS1jbG9ja2dlbiIsIH0sDQor
CXsgLmNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtY2xvY2tnZW4iLCB9LA0KIAl7IC5jb21wYXRp
YmxlID0gImZzbCxwNDA4MC1jbG9ja2dlbiIsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLHFv
cmlxLWNsb2NrZ2VuLTEuMCIsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLHFvcmlxLWNsb2Nr
Z2VuLTIuMCIsIH0sDQotLSANCjIuNy40DQoNCg==
