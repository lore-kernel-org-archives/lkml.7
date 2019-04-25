Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02701C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3FC218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VAlYI+nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbfDYJsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:48:17 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:6878
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfDYJsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbAmk4fhM9pJg4VaU8hayUvNVHPODR7oQTKPQmxxeow=;
 b=VAlYI+nzczPLlK5pvH4P/w19D9OOJwQ1PnfrLMx5UDLbgC59uSMbOymlP5vND6hxp8sLbmRaFzOu0BBHruRB0lZpIxD4qmq0QINuBVmv2yLVqYWyJQ4nojoneFb3i4kERqePKdaL38FSMeYLqaPEn6HXoIXmceFFNlS781ajFqs=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4782.eurprd04.prod.outlook.com (20.177.48.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 09:48:11 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 09:48:11 +0000
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
Thread-Index: AQHU+0v+B00Z51pg7EC3G4Yx/RLSjQ==
Date:   Thu, 25 Apr 2019 09:48:10 +0000
Message-ID: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::32) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8e3f86-c1cf-4fac-1cb7-08d6c96320ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4782;
x-ms-traffictypediagnostic: VI1PR04MB4782:
x-microsoft-antispam-prvs: <VI1PR04MB47820A9D6098CB2C91E0AE60F33D0@VI1PR04MB4782.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(102836004)(97736004)(53936002)(2201001)(86362001)(6512007)(6116002)(6506007)(386003)(36756003)(305945005)(186003)(3846002)(14454004)(26005)(2906002)(7736002)(5660300002)(68736007)(486006)(44832011)(316002)(71190400001)(71200400001)(66946007)(73956011)(25786009)(2616005)(476003)(4326008)(52116002)(256004)(8676002)(6436002)(6486002)(66066001)(66476007)(81166006)(110136005)(54906003)(99286004)(66446008)(2501003)(81156014)(66556008)(478600001)(50226002)(8936002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4782;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3WM2X38LU1GS8tj1qHSl7TRxlVxxgk/aKN1F4sO05lPkXVrApBv/2rAsyyZmkdj5d8HWVxlfUNl79U9UxbO1A69mtBTuxhnc5qSuqf3Ea6D+OFjr5ZDpdcAUOE32fvmVoHuNgRdK4GDmEsSK+F8Qx6Y44jzFoWrQxuJx77cguzS92oYGnUVc96MYFI5sRmSQSXkZcLfieHhSuprRwG51a+XkH7ynQ6EIE47dBflQMahQWknDaD7WiA1t4dNcbL3/zN8cufU2mJR0gLgLVKgoIJhHt03ovqm4LK+2Tfcsi1Rodq3Yiyh4XhgfaTwhi4zKyqsSt0AeqlZuhuR5qOx5pUWulJZsLZJmEJX4SVC7VvbTU3+C+PVC6+B0zEpDvlkGPdTPs2ZmWUs7YEn5pBIB/ePrgA/1WtJXPLshwZhf60E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e3f86-c1cf-4fac-1cb7-08d6c96320ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 09:48:11.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4782
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
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCi0tLQ0KQ2hhbmdlcyBmb3IgdjI6DQotIFN1
YmplY3QgbGluZSB1cGRhdGVkDQoNCiBkcml2ZXJzL2Nsay9jbGstcW9yaXEuYyAgICAgICAgIHwg
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
