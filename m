Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE874C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF12077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JSdqHGUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfDYFT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:19:56 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:20964
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfDYFTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o3Vj4fiz80yoIwvOK9Ez13nnuRlSb1hS62y8OBsB3o=;
 b=JSdqHGUZ4iTRalKlbvuLNOAuoZfC2a4OZ2KY9+WFaIDXgCZ2LlaAh9pspglvAMOwXIBywyhAErWiVt4AYm/ZUzfp4dQLUPz6aMUvEXpzB6nSMmE637PngJVUyoVNpDl6nhstXmsoSD36Plg/iDvKI9a2IiNoET/gW7pbJlRFpXc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 05:19:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 05:19:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Topic: [PATCH 2/2] clk: imx: disable i.mx7ulp composite clock during
 initialization
Thread-Index: AQHU+yZqSSaC+SqMKEqyvy0FwIJdyA==
Date:   Thu, 25 Apr 2019 05:19:12 +0000
Message-ID: <1556169264-31683-2-git-send-email-Anson.Huang@nxp.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0070.apcprd03.prod.outlook.com
 (2603:1096:203:52::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff4242ae-d202-4e56-e79b-08d6c93d8d1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB394633135FFE0A7899D17896F53D0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(11346002)(26005)(2616005)(3846002)(66946007)(2906002)(64756008)(81166006)(81156014)(8936002)(476003)(6116002)(66066001)(50226002)(446003)(6486002)(8676002)(52116002)(110136005)(102836004)(73956011)(6436002)(14454004)(386003)(66476007)(66446008)(99286004)(66556008)(186003)(478600001)(486006)(76176011)(14444005)(6512007)(4326008)(71200400001)(53936002)(86362001)(71190400001)(25786009)(256004)(2201001)(5660300002)(97736004)(36756003)(7736002)(316002)(7416002)(305945005)(2501003)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I83jSHysOpI4gG66ARpVLY9VM9hkkRdp60G/nkMaO3WonWuYxPM/R8Z1Wm3aMJqr8QdvjHKOct35O/aXRk1Ah9pbKJpFUAfOgccwO4ocOftJjQv13KVSDu5/6tYhAind+016uw3caYvYo4gFSVaUVz2qD+TZkuvH9C8+7x7sPfOMyaEJHN6R8jaEL0xxyszg6q3dl1mOtWU/CM/IC5bTpvhrqJR5Iw9TXGVIPNXCYT4Ym4QFmbAL2D4pFyGKS4vOmSaWNffGvkSOICs/xxsx3sT9Evd+xzPvYduZXQfuFVwiEINdgpVv+RqxAJDFcp2LC2bzzPH9R/8rx0GQq06NwJ24+/1SR8+HnZ9KAel/gfB+YYjVSVjkyJaCIc6d0j51+gXh0JKeFkJuk9NvOWCZTfG2Pd4u9xwlMQ4RxIQf7f0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4242ae-d202-4e56-e79b-08d6c93d8d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 05:19:12.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDdVTFAgcGVyaXBoZXJhbCBjbG9jayBPTkxZIGFsbG93IHBhcmVudC9yYXRlIHRvIGJlIGNo
YW5nZWQNCndpdGggY2xvY2sgZ2F0ZWQsIGhvd2V2ZXIsIGR1cmluZyBjbG9jayB0cmVlIGluaXRp
YWxpemF0aW9uLCB0aGUNCnBlcmlwaGVyYWwgY2xvY2sgY291bGQgYmUgZW5hYmxlZCBieSBib290
bG9hZGVyLCBidXQgdGhlIHByZXBhcmUNCmNvdW50IGluIGNsb2NrIHRyZWUgaXMgc3RpbGwgemVy
bywgc28gY2xvY2sgY29yZSBkcml2ZXIgd2lsbCBhbGxvdw0KcGFyZW50L3JhdGUgY2hhbmdlZCBl
dmVuIHdpdGggQ0xLX1NFVF9SQVRFX0dBVEUvQ0xLX1NFVF9QQVJFTlRfR0FURQ0Kc2V0LCBidXQg
dGhlIGNoYW5nZSB3aWxsIGZhaWwgZHVlIHRvIEhXIE5PVCBhbGxvdyBwYXJlbnQvcmF0ZSBjaGFu
Z2UNCndpdGggY2xvY2sgZW5hYmxlZC4gSXQgd2lsbCBjYXVzZSBjbG9jayBIVyBzdGF0dXMgbWlz
bWF0Y2ggd2l0aA0KY2xvY2sgdHJlZSBpbmZvIGFuZCBsZWFkIHRvIGZ1bmN0aW9uIGlzc3VlLiBC
ZWxvdyBpcyBhbiBleGFtcGxlOg0KDQp1c2RoYzAncyBwY2MgY2xvY2sgdmFsdWUgaXMgMHhDNTAw
MDAwMCBkdXJpbmcga2VybmVsIGJvb3QgdXAsIGl0DQptZWFucyB1c2RoYzAgY2xvY2sgaXMgZW5h
YmxlZCwgaXRzIHBhcmVudCBpcyBBUExMX1BGRDEuIEluIERUIGZpbGUsDQp0aGUgdXNkaGMwIGNs
b2NrIHNldHRpbmdzIGFyZSBhcyBiZWxvdzoNCg0KYXNzaWduZWQtY2xvY2tzID0gPCZwY2MyIElN
WDdVTFBfQ0xLX1VTREhDMD47DQphc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZzY2cxIElNWDdV
TFBfQ0xLX05JQzFfRElWPjsNCg0Kd2hlbiBrZXJuZWwgYm9vdCB1cCwgdGhlIGNsb2NrIHRyZWUg
aW5mbyBpcyBhcyBiZWxvdywgYnV0IHRoZSB1c2RoYzANClBDQyByZWdpc3RlciBpcyBzdGlsbCAw
eEM1MDAwMDAwLCB3aGljaCBtZWFucyBpdHMgcGFyZW50IGlzIHN0aWxsDQpmcm9tIEFQTExfUEZE
MSwgd2hpY2ggaXMgaW5jb3JyZWN0IGFuZCBjYXVzZSB1c2RoYzAgTk9UIHdvcmsuDQoNCm5pYzFf
Y2xrICAgICAgIDIgICAgICAgIDIgICAgICAgIDAgICAxNzYwMDAwMDAgICAgICAgICAgMCAgICAg
MCAgNTAwMDANCiAgICB1c2RoYzAgICAgICAgMCAgICAgICAgMCAgICAgICAgMCAgIDE3NjAwMDAw
MCAgICAgICAgICAwICAgICAwICA1MDAwMA0KDQpBZnRlciBtYWtpbmcgc3VyZSB0aGUgcGVyaXBo
ZXJhbCBjbG9jayBpcyBkaXNhYmxlZCBkdXJpbmcgY2xvY2sgdHJlZQ0KaW5pdGlhbGl6YXRpb24s
IHRoZSB1c2RoYzAgaXMgd29ya2luZywgYW5kIHRoaXMgY2hhbmdlIGlzIG5lY2Vzc2FyeQ0KZm9y
IGFsbCBpLk1YN1VMUCBwZXJpcGhlcmFsIGNsb2Nrcy4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWNv
bXBvc2l0ZS03dWxwLmMgfCAxMyArKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRl
LTd1bHAuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLTd1bHAuYw0KaW5kZXggMDYw
Zjg2MC4uMWEwNTQxMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRl
LTd1bHAuYw0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtN3VscC5jDQpAQCAt
MzIsNiArMzIsNyBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3dWxwX2Nsa19jb21wb3NpdGUoY29uc3Qg
Y2hhciAqbmFtZSwNCiAJc3RydWN0IGNsa19nYXRlICpnYXRlID0gTlVMTDsNCiAJc3RydWN0IGNs
a19tdXggKm11eCA9IE5VTEw7DQogCXN0cnVjdCBjbGtfaHcgKmh3Ow0KKwl1MzIgdmFsOw0KIA0K
IAlpZiAobXV4X3ByZXNlbnQpIHsNCiAJCW11eCA9IGt6YWxsb2Moc2l6ZW9mKCptdXgpLCBHRlBf
S0VSTkVMKTsNCkBAIC03MCw2ICs3MSwxOCBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3dWxwX2Nsa19j
b21wb3NpdGUoY29uc3QgY2hhciAqbmFtZSwNCiAJCWdhdGVfaHcgPSAmZ2F0ZS0+aHc7DQogCQln
YXRlLT5yZWcgPSByZWc7DQogCQlnYXRlLT5iaXRfaWR4ID0gUENHX0NHQ19TSElGVDsNCisJCS8q
DQorCQkgKiBtYWtlIHN1cmUgY2xvY2sgaXMgZ2F0ZWQgZHVyaW5nIGNsb2NrIHRyZWUgaW5pdGlh
bGl6YXRpb24sDQorCQkgKiB0aGUgSFcgT05MWSBhbGxvdyBjbG9jayBwYXJlbnQvcmF0ZSBjaGFu
Z2VkIHdpdGggY2xvY2sgZ2F0ZWQsDQorCQkgKiBkdXJpbmcgY2xvY2sgdHJlZSBpbml0aWFsaXph
dGlvbiwgY2xvY2tzIGNvdWxkIGJlIGVuYWJsZWQNCisJCSAqIGJ5IGJvb3Rsb2FkZXIsIHNvIHRo
ZSBIVyBzdGF0dXMgd2lsbCBtaXNtYXRjaCB3aXRoIGNsb2NrIHRyZWUNCisJCSAqIHByZXBhcmUg
Y291bnQsIHRoZW4gY2xvY2sgY29yZSBkcml2ZXIgd2lsbCBhbGxvdyBwYXJlbnQvcmF0ZQ0KKwkJ
ICogY2hhbmdlIHNpbmNlIHRoZSBwcmVwYXJlIGNvdW50IGlzIHplcm8sIGJ1dCBIVyBhY3R1YWxs
eQ0KKwkJICogcHJldmVudCB0aGUgcGFyZW50L3JhdGUgY2hhbmdlIGR1ZSB0byB0aGUgY2xvY2sg
aXMgZW5hYmxlZC4NCisJCSAqLw0KKwkJdmFsID0gcmVhZGxfcmVsYXhlZChyZWcpOw0KKwkJdmFs
ICY9IH4oMSA8PCBQQ0dfQ0dDX1NISUZUKTsNCisJCXdyaXRlbF9yZWxheGVkKHZhbCwgcmVnKTsN
CiAJfQ0KIA0KIAlodyA9IGNsa19od19yZWdpc3Rlcl9jb21wb3NpdGUoTlVMTCwgbmFtZSwgcGFy
ZW50X25hbWVzLCBudW1fcGFyZW50cywNCi0tIA0KMi43LjQNCg0K
