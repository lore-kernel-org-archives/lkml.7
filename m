Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ACDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187A3206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/hAgi6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfDZGxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:53:42 -0400
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:44771
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfDZGxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDYTaVAZSg7zapxRu1QeU8TgZlNrN8xGKGlOs6aQyl8=;
 b=H/hAgi6TIO66P1Wf0isQV/96efu2+O3Ww4A5bKniZkRi/hgVESOV+FQWVv+PevP6/fBoLoS+eGOUhe6EAR1zduapQiQ3gohFo4KrM0+0+XzBrY9bEO/sAmRVLvPjEtBnrec+zV8XwVokfFVznWSnRxCGPI+DE/PffWJ0wfl54Vs=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB6294.eurprd04.prod.outlook.com (20.179.7.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 06:53:38 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::2c:6837:2927:a618%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 06:53:38 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Topic: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+/zGE8MPZcMnA0GP8h3OejDbYA==
Date:   Fri, 26 Apr 2019 06:53:38 +0000
Message-ID: <1556261624-20504-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::17) To AM6PR04MB4789.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adccf153-552e-4302-7f71-08d6ca13e8e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6294;
x-ms-traffictypediagnostic: AM6PR04MB6294:
x-microsoft-antispam-prvs: <AM6PR04MB62941C5DB3F49EA2EAE35274F33E0@AM6PR04MB6294.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(68736007)(2501003)(81156014)(86362001)(2616005)(256004)(26005)(4326008)(486006)(316002)(44832011)(186003)(8676002)(476003)(66066001)(6506007)(386003)(6486002)(36756003)(2906002)(6436002)(6116002)(3846002)(478600001)(66476007)(102836004)(54906003)(99286004)(25786009)(73956011)(66946007)(5660300002)(66556008)(64756008)(66446008)(110136005)(7736002)(8936002)(6512007)(52116002)(305945005)(81166006)(71200400001)(50226002)(14454004)(53936002)(97736004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6294;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K4VuOCJyX1JmJ0f57gzTAjH057Rd2anntePv/X0uJUzywUDfoYF/LybOqFEyl5NBSZF+mbcXHJa3krB2oKSbqDKGle9IozS0RIeqBlwLfRSt7dwwuXRPnrWD7ZFAX5k28rVLeOrnc39+i3pDmMAw+bbxVpoOJm8RjVQOVbiWSpfnmsVrh1Hum+O0JEDtnBylurG+YZ/f7BOtHOIxO4HpsFOgclUAmYF3l0qwMjdrRX6gAV5y2mWAgn27434SEyAilZgv/0wXK3iyygjOx7fSyPsDdTrfE3js62Yn8e53IQoo1Moz8dQ/QvvPpAyfrOaT8ciI2J4EN80r9leEp3rArIDBB3W2YpRVF5JEI0wOYp4mKr/ZuVQW3zM9mM1ugBGBipVkpVzT/3JclWoG6uaGMoAadmSZWC9F6oe5eThZprA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adccf153-552e-4302-7f71-08d6ca13e8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 06:53:38.3584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsb2NrZ2VuIHN1cHBvcnQgYW5kIGNvbmZpZ3VyYXRpb24gZm9yIE5YUCBTb0MgbHgyMTYw
YQ0Kd2l0aCBjb21wYXRpYmxlIHByb3BlcnR5IGFzICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIuDQoN
ClNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAuY29tPg0KU2lnbmVk
LW9mZi1ieTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KU2lnbmVk
LW9mZi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KQWNrZWQtYnk6
IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+DQpBY2tlZC1ieTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KQWNrZWQtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc+DQotLS0NCkNoYW5nZXMgZm9yIHY0Og0KLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNv
bW1lbnRzIGZyb20gU3RlcGhlbiBCb3lkDQogDQpDaGFuZ2VzIGZvciB2MzoNCi0gSW5jb3Jwb3Jh
dGVkIHJldmlldyBjb21tZW50cyBvZiBSYWZhZWwgSi4gV3lzb2NraQ0KLSBVcGRhdGVkIGNvbW1p
dCBtZXNzYWdlDQoNCkNoYW5nZXMgZm9yIHYyOg0KLSBTdWJqZWN0IGxpbmUgdXBkYXRlZA0KDQog
ZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgfCAxMiArKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlx
LmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KaW5kZXggM2Q1MWQ3Yy4uMWExNTIwMSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jDQorKysgYi9kcml2ZXJzL2Nsay9jbGst
cW9yaXEuYw0KQEAgLTU3MCw2ICs1NzAsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbG9ja2dl
bl9jaGlwaW5mbyBjaGlwaW5mb1tdID0gew0KIAkJLmZsYWdzID0gQ0dfVkVSMyB8IENHX0xJVFRM
RV9FTkRJQU4sDQogCX0sDQogCXsNCisJCS5jb21wYXQgPSAiZnNsLGx4MjE2MGEtY2xvY2tnZW4i
LA0KKwkJLmNtdXhfZ3JvdXBzID0gew0KKwkJCSZjbG9ja2dlbjJfY211eF9jZ2ExMiwgJmNsb2Nr
Z2VuMl9jbXV4X2NnYg0KKwkJfSwNCisJCS5jbXV4X3RvX2dyb3VwID0gew0KKwkJCTAsIDAsIDAs
IDAsIDEsIDEsIDEsIDEsIC0xDQorCQl9LA0KKwkJLnBsbF9tYXNrID0gMHgzNywNCisJCS5mbGFn
cyA9IENHX1ZFUjMgfCBDR19MSVRUTEVfRU5ESUFOLA0KKwl9LA0KKwl7DQogCQkuY29tcGF0ID0g
ImZzbCxwMjA0MS1jbG9ja2dlbiIsDQogCQkuZ3V0c19jb21wYXQgPSAiZnNsLHFvcmlxLWRldmlj
ZS1jb25maWctMS4wIiwNCiAJCS5pbml0X3BlcmlwaCA9IHAyMDQxX2luaXRfcGVyaXBoLA0KQEAg
LTE0MjcsNiArMTQzOCw3IEBAIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0M2Es
ICJmc2wsbHMxMDQzYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJF
KHFvcmlxX2Nsb2NrZ2VuX2xzMTA0NmEsICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIsIGNsb2NrZ2Vu
X2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA4OGEsICJmc2wsbHMx
MDg4YS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Ns
b2NrZ2VuX2xzMjA4MGEsICJmc2wsbHMyMDgwYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0K
K0NMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2x4MjE2MGEsICJmc2wsbHgyMTYwYS1jbG9j
a2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KIENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX3Ay
MDQxLCAiZnNsLHAyMDQxLWNsb2NrZ2VuIiwgY2xvY2tnZW5faW5pdCk7DQogQ0xLX09GX0RFQ0xB
UkUocW9yaXFfY2xvY2tnZW5fcDMwNDEsICJmc2wscDMwNDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9p
bml0KTsNCiBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9wNDA4MCwgImZzbCxwNDA4MC1j
bG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KLS0gDQoyLjcuNA0KDQo=
