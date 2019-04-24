Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D01C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C4E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jeglYtiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfDXOy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:54:29 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:27013
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731113AbfDXOy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDV5bQxA5k+ndE95DZzEKl1CMuva2JheTFchkJZgn84=;
 b=jeglYtiKHfw44LvM+A6n4+ZYXE5nWMGT46CGE8fzThbenumJjqZmDip0498eC0rYdqbXZTerY/eSUC41lA5qBj0ZeQo4hlO1xYat+7IH6kVWJbK4I0xKi06BUO49e/B/Ycj2xUdjO99479tZzXudMG5WiAMFNIM01fsopukXTps=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5776.eurprd04.prod.outlook.com (20.178.127.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:54:24 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 14:54:24 +0000
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
Subject: [PATCH] arm64: drivers: clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH] arm64: drivers: clk: qoriq: Add clockgen support for
 lx2160a
Thread-Index: AQHU+q2bE74r8QWOEEW3f2AnJYEBpA==
Date:   Wed, 24 Apr 2019 14:54:24 +0000
Message-ID: <1556117674-27029-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::17) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83cdeac5-85fe-4316-fb84-08d6c8c4bd8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5776;
x-ms-traffictypediagnostic: VI1PR04MB5776:
x-microsoft-antispam-prvs: <VI1PR04MB577614B36BC688A4E88A0035F33C0@VI1PR04MB5776.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(71200400001)(71190400001)(14454004)(86362001)(53936002)(2201001)(102836004)(66476007)(66946007)(73956011)(54906003)(66556008)(64756008)(66446008)(2501003)(99286004)(5660300002)(6512007)(6116002)(97736004)(305945005)(3846002)(44832011)(50226002)(81166006)(81156014)(256004)(8676002)(8936002)(66066001)(25786009)(478600001)(26005)(52116002)(316002)(68736007)(2906002)(186003)(110136005)(486006)(2616005)(476003)(6506007)(386003)(6486002)(36756003)(7736002)(4326008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5776;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WFCiYoBGROylOuLe+8D7x/csgKBJ5ybwx3zDblw0XVjfdOU+9PNaaK5d5XBsaNuBgzAXkUS+U9k+Zx4iGoLaijuXUuz+3GE2u8f+Djvnfbn+AFXGjErD4JZ8Q4m4eKcbsU/cPpQN2DjGeFAGQmhQ0aKwRyxRbsRPCIUmZ2sT06IZKBnm/rOR4ZlCRSZ850JRUsBbLoMPoobVi2GQb2oSWps3DA53vpEs4Qd9vZXvfl2lYoeXOd96i3z4VgEqCqstYCddkOxG0cl4vXlxzvg9BtrABa03Pb/IftFS7PtxlsETQ7bG2nAv0gX4h3QWl+01xocXgmf3SPGpCuYBPyL/wU0kHqUUrk4glJYxgdeMjOAIP60XFx6ND5KiR+n1L6naJ8tBwEc0AC21RBF5HOW2tX/kKsFlxVqUtdtZLejoaD8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cdeac5-85fe-4316-fb84-08d6c8c4bd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:54:24.2606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5776
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
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCi0tLQ0KIGRyaXZlcnMvY2xrL2Nsay1xb3Jp
cS5jICAgICAgICAgfCAxMiArKysrKysrKysrKysNCiBkcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1
ZnJlcS5jIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEu
Yw0KaW5kZXggZjY2MDZjZi4uOTZkYjc4MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2Nsay1x
b3JpcS5jDQorKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KQEAgLTU3MCw2ICs1NzAsMTcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyBjaGlwaW5mb1tdID0gew0K
IAkJLmZsYWdzID0gQ0dfVkVSMyB8IENHX0xJVFRMRV9FTkRJQU4sDQogCX0sDQogCXsNCisJCS5j
b21wYXQgPSAiZnNsLGx4MjE2MGEtY2xvY2tnZW4iLA0KKwkJLmNtdXhfZ3JvdXBzID0gew0KKwkJ
CSZjbG9ja2dlbjJfY211eF9jZ2ExMiwgJmNsb2NrZ2VuMl9jbXV4X2NnYg0KKwkJfSwNCisJCS5j
bXV4X3RvX2dyb3VwID0gew0KKwkJCTAsIDAsIDAsIDAsIDEsIDEsIDEsIDEsIC0xDQorCQl9LA0K
KwkJLnBsbF9tYXNrID0gMHgzNywNCisJCS5mbGFncyA9IENHX1ZFUjMgfCBDR19MSVRUTEVfRU5E
SUFOLA0KKwl9LA0KKwl7DQogCQkuY29tcGF0ID0gImZzbCxwMjA0MS1jbG9ja2dlbiIsDQogCQku
Z3V0c19jb21wYXQgPSAiZnNsLHFvcmlxLWRldmljZS1jb25maWctMS4wIiwNCiAJCS5pbml0X3Bl
cmlwaCA9IHAyMDQxX2luaXRfcGVyaXBoLA0KQEAgLTE0MjcsNiArMTQzOCw3IEBAIENMS19PRl9E
RUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0M2EsICJmc2wsbHMxMDQzYS1jbG9ja2dlbiIsIGNs
b2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0NmEsICJm
c2wsbHMxMDQ2YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFv
cmlxX2Nsb2NrZ2VuX2xzMTA4OGEsICJmc2wsbHMxMDg4YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2lu
aXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMjA4MGEsICJmc2wsbHMyMDgw
YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KK0NMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2Nr
Z2VuX2x4MjE2MGEsICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENM
S19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3AyMDQxLCAiZnNsLHAyMDQxLWNsb2NrZ2VuIiwg
Y2xvY2tnZW5faW5pdCk7DQogQ0xLX09GX0RFQ0xBUkUocW9yaXFfY2xvY2tnZW5fcDMwNDEsICJm
c2wscDMwNDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCiBDTEtfT0ZfREVDTEFSRShxb3Jp
cV9jbG9ja2dlbl9wNDA4MCwgImZzbCxwNDA4MC1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVmcmVxLmMgYi9kcml2ZXJzL2Nw
dWZyZXEvcW9yaXEtY3B1ZnJlcS5jDQppbmRleCA0Mjk1ZTU0Li44MWYwMjg4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9jcHVmcmVxL3FvcmlxLWNwdWZyZXEuYw0KKysrIGIvZHJpdmVycy9jcHVmcmVx
L3FvcmlxLWNwdWZyZXEuYw0KQEAgLTI4NCw2ICsyODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBub2RlX21hdGNoZXNbXSBfX2luaXRjb25zdCA9IHsNCiAJeyAuY29tcGF0
aWJsZSA9ICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIsIH0sDQogCXsgLmNvbXBhdGlibGUgPSAiZnNs
LGxzMTA4OGEtY2xvY2tnZW4iLCB9LA0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxsczIwODBhLWNs
b2NrZ2VuIiwgfSwNCisJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsIH0s
DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLHA0MDgwLWNsb2NrZ2VuIiwgfSwNCiAJeyAuY29tcGF0
aWJsZSA9ICJmc2wscW9yaXEtY2xvY2tnZW4tMS4wIiwgfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJm
c2wscW9yaXEtY2xvY2tnZW4tMi4wIiwgfSwNCi0tIA0KMi43LjQNCg0K
