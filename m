Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C1C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F4920859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmBi66Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDVEwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:52:07 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:51382
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfDVEwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3H8Q9kd8tFCZUR1NlLb5dUSbC2Rd6MwBMq3O+TS+GM=;
 b=XmBi66NeXVOE86LUEb7jWnJZLcFIkfxG94hxvCcKQlMzE14829VRNM92Q9AfG4uoRgJZIySlL5fTok1t/q9mSjJWnx1e+4VWteivuMqKaBhiABJz8OM5hu567EXgAc3h4mm+p++SmSWSCMweTZuKNzEof/odQKSQaJTK1LWAFFU=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 04:52:02 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 04:52:02 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 1/3] ASoC: fsl_asrc: Fix the issue about unsupported rate
Thread-Topic: [PATCH V6 1/3] ASoC: fsl_asrc: Fix the issue about unsupported
 rate
Thread-Index: AQHU+McgVNj7ktVW0Uue8cCdIrU9yg==
Date:   Mon, 22 Apr 2019 04:52:02 +0000
Message-ID: <2cea4cb992a445863e88fa7865f55a02a83e031e.1555908545.git.shengjiu.wang@nxp.com>
References: <cover.1555908545.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1555908545.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5036c537-a8da-4936-ab3a-08d6c6de424c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6479;
x-ms-traffictypediagnostic: VE1PR04MB6479:
x-microsoft-antispam-prvs: <VE1PR04MB64792FB717CFBA8B9F91A601E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(486006)(26005)(99286004)(6436002)(5660300002)(186003)(316002)(66066001)(6486002)(86362001)(81156014)(81166006)(8676002)(118296001)(476003)(2616005)(11346002)(446003)(305945005)(7736002)(8936002)(50226002)(2501003)(97736004)(54906003)(3846002)(14454004)(76176011)(110136005)(4326008)(6512007)(2906002)(68736007)(478600001)(71200400001)(71190400001)(386003)(6506007)(53936002)(66556008)(52116002)(66476007)(256004)(36756003)(64756008)(73956011)(66446008)(66946007)(6116002)(102836004)(14444005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6479;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zeEumKPe5252r5HZfwy9jB7aFIN/NseazT4YK5vfNssq3Yk2QTvUOKEitSjeOdM/VCrLqMFId3h55vB4kpkZDwJIF4uxvaWScq0Z1h9wWlY2bSaKzrV4MUDGsPFNXc0vGDQKB8RiNPnWe3Xq4rJcHPskHEgtW1xXnjZEXVaagfoE12mppomlSsgN7zUskkj52DpEAhx+nOZTHVlTsJGZz4JnOOW7IBWnSY9TEVKzzQZ5hDApZWIgOvzxo5C1tjwO5ZQTpvbKua5VLpa6qwEvl7pZvzCXMMZFVTGpaL0GWfq8O+Bs9dbHyUUFU1NsyAidBAuJJxa4NbhoEmaU5LOulNTruQ5SXCSd5fZO02OMdqydfvFmP4isTsQMeAFrtRF08O4Iih55rI9CcMAXm9GbeKXRqVXtN0xyPCeXRVzL/D8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5036c537-a8da-4936-ab3a-08d6c6de424c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 04:52:02.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiB0aGUgb3V0cHV0IHNhbXBsZSByYXRlIGlzIFs4a0h6LCAzMGtIel0sIHRoZSBsaW1pdGF0
aW9uDQpvZiB0aGUgc3VwcG9ydGVkIHJhdGlvIHJhbmdlIGlzIFsxLzI0LCA4XS4gSW4gdGhlIGRy
aXZlcg0Kd2UgdXNlICg4a0h6LCAzMGtIeikgaW5zdGVhZCBvZiBbOGtIeiwgMzBrSHpdLg0KU28g
dGhpcyBwYXRjaCBpcyB0byBmaXggdGhpcyBpc3N1ZSBhbmQgdGhlIHBvdGVudGlhbCByb3VuZGlu
Zw0KaXNzdWUgd2l0aCBkaXZpZGVyLg0KDQpGaXhlczogZmZmNmUwM2M3YjY1ICgiQVNvQzogZnNs
X2FzcmM6IGFkZCBzdXBwb3J0IGZvciA4LTMwa0h6DQpvdXRwdXQgc2FtcGxlIHJhdGUiKQ0KQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8
c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KQWNrZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3Rz
dWthQGdtYWlsLmNvbT4NCi0tLQ0KIHNvdW5kL3NvYy9mc2wvZnNsX2FzcmMuYyB8IDQgKystLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hc3Jj
LmMNCmluZGV4IDBiOTM3OTI0ZDJlNC4uZWEwMzVjMTJhMzI1IDEwMDY0NA0KLS0tIGEvc291bmQv
c29jL2ZzbC9mc2xfYXNyYy5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMNCkBAIC0y
ODIsOCArMjgyLDggQEAgc3RhdGljIGludCBmc2xfYXNyY19jb25maWdfcGFpcihzdHJ1Y3QgZnNs
X2FzcmNfcGFpciAqcGFpcikNCiAJCXJldHVybiAtRUlOVkFMOw0KIAl9DQogDQotCWlmICgob3V0
cmF0ZSA+IDgwMDAgJiYgb3V0cmF0ZSA8IDMwMDAwKSAmJg0KLQkgICAgKG91dHJhdGUvaW5yYXRl
ID4gMjQgfHwgaW5yYXRlL291dHJhdGUgPiA4KSkgew0KKwlpZiAoKG91dHJhdGUgPj0gODAwMCAm
JiBvdXRyYXRlIDw9IDMwMDAwKSAmJg0KKwkgICAgKG91dHJhdGUgPiAyNCAqIGlucmF0ZSB8fCBp
bnJhdGUgPiA4ICogb3V0cmF0ZSkpIHsNCiAJCXBhaXJfZXJyKCJleGNlZWQgc3VwcG9ydGVkIHJh
dGlvIHJhbmdlIFsxLzI0LCA4XSBmb3IgXA0KIAkJCQlpbnJhdGUvb3V0cmF0ZTogJWQvJWRcbiIs
IGlucmF0ZSwgb3V0cmF0ZSk7DQogCQlyZXR1cm4gLUVJTlZBTDsNCi0tIA0KMS45LjENCg0K
