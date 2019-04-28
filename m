Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA9C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F4C206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t8f5bxDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfD1Jwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:52:55 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:49793
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfD1Jwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH/3FWEXzmXk6SRD8UQBZdibKbpa0jZEZRwSldsIEdw=;
 b=t8f5bxDnVwuk1+OHy2RvAuYdarIH4nS3fMiupJSWg1eXsF/Cq0Yh6zZim4u68XrEg0iXDqrMv3r7z/75P6qUCymYXD1pTFrLApw5P0DbbbLxkjMtzFawN/H7sl/YPN2JnrAQsqKafWHjTT1BNhWRdwBdH2e13NsqLDpJGwQs0Sc=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6350.eurprd04.prod.outlook.com (10.255.118.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Sun, 28 Apr 2019 09:52:49 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 09:52:49 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: imx6sx: add MQS register definition for iomuxc gpr
Thread-Topic: [PATCH] mfd: imx6sx: add MQS register definition for iomuxc gpr
Thread-Index: AQHU/agjfPz5ks/OzEakw7KYMflrHQ==
Date:   Sun, 28 Apr 2019 09:52:48 +0000
Message-ID: <1556445161-29477-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95739329-d3ea-4b7e-9f3b-08d6cbbf456f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6350;
x-ms-traffictypediagnostic: VE1PR04MB6350:
x-microsoft-antispam-prvs: <VE1PR04MB635094D55453A52860F7F9ECE3380@VE1PR04MB6350.eurprd04.prod.outlook.com>
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(189003)(199004)(6116002)(81166006)(2201001)(86362001)(68736007)(256004)(8676002)(2501003)(3846002)(99286004)(305945005)(7736002)(81156014)(8936002)(50226002)(71190400001)(71200400001)(476003)(486006)(2616005)(26005)(4326008)(6512007)(102836004)(6436002)(386003)(25786009)(6506007)(2906002)(186003)(6486002)(66066001)(5660300002)(316002)(53936002)(73956011)(52116002)(36756003)(97736004)(66476007)(66556008)(64756008)(66446008)(66946007)(110136005)(14454004)(478600001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6350;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zTSsNZ0jfOmgDnz97nDkAn8DxHeXNQOsWUtC2fz8XhhEzBLwvTarxJNK0VLuO87y07VwLjzDL3yUprSFbeoR3dZXoByVC3JfjwYAgPgiUt99/oxauSEnPE8m6Y3Thg6lkm1wyf2AtqEWdy7w5c1J0QUJQG7/biu87cVW0WTyHw2eHc5nRehFkC1KuxcoEacM7x+9KgWxVMqSvwE/sMf8DFvhslt5Q1TUuB3G6khM1YY0CDsyzi1vwWAry/heeNGDrgM2WQAyuk6T8/Bca0ncruyNoFbAEclrxIoji8896go9L2uB7RsJxOqhTC/4gfQieYonarinB+X1AJcoGfWoopMA0o9sRlLU2napsJi/mwqQ5JN2JneUcv8dBP+3b+DtHRHtZEtST5KSMJvIelDe3Kc3SGDhyFTLjTP0XtXOV2Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95739329-d3ea-4b7e-9f3b-08d6cbbf456f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 09:52:49.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1hY3JvcyB0byBkZWZpbmUgbWFza3MgYW5kIGJpdHMgZm9yIGlteDZzeCBNUVMgcmVnaXN0
ZXJzDQoNClNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAbnhwLmNv
bT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9pbXg2cS1pb211eGMtZ3ByLmggfCA5
ICsrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9pbXg2cS1pb211eGMtZ3ByLmggYi9pbmNsdWRl
L2xpbnV4L21mZC9zeXNjb24vaW14NnEtaW9tdXhjLWdwci5oDQppbmRleCBjMWIyNWY1ZTM4NmQu
LmYyMzJjODEzMGQwMCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9pbXg2
cS1pb211eGMtZ3ByLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9pbXg2cS1pb211
eGMtZ3ByLmgNCkBAIC00MTAsNiArNDEwLDE1IEBADQogI2RlZmluZSBJTVg2U1hfR1BSMV9GRUNf
Q0xPQ0tfUEFEX0RJUl9NQVNLCQkoMHgzIDw8IDE3KQ0KICNkZWZpbmUgSU1YNlNYX0dQUjFfRkVD
X0NMT0NLX01VWF9TRUxfRVhUCQkoMHgzIDw8IDEzKQ0KIA0KKyNkZWZpbmUgSU1YNlNYX0dQUjJf
TVFTX09WRVJTQU1QTEVfTUFTSwkJCSgweDEgPDwgMjYpDQorI2RlZmluZSBJTVg2U1hfR1BSMl9N
UVNfT1ZFUlNBTVBMRV9TSElGVAkJKDI2KQ0KKyNkZWZpbmUgSU1YNlNYX0dQUjJfTVFTX0VOX01B
U0sJCQkJKDB4MSA8PCAyNSkNCisjZGVmaW5lIElNWDZTWF9HUFIyX01RU19FTl9TSElGVAkJCSgy
NSkNCisjZGVmaW5lIElNWDZTWF9HUFIyX01RU19TV19SU1RfTUFTSwkJCSgweDEgPDwgMjQpDQor
I2RlZmluZSBJTVg2U1hfR1BSMl9NUVNfU1dfUlNUX1NISUZUCQkJKDI0KQ0KKyNkZWZpbmUgSU1Y
NlNYX0dQUjJfTVFTX0NMS19ESVZfTUFTSwkJCSgweEZGIDw8IDE2KQ0KKyNkZWZpbmUgSU1YNlNY
X0dQUjJfTVFTX0NMS19ESVZfU0hJRlQJCQkoMTYpDQorDQogI2RlZmluZSBJTVg2U1hfR1BSNF9G
RUNfRU5FVDFfU1RPUF9SRVEJCQkoMHgxIDw8IDMpDQogI2RlZmluZSBJTVg2U1hfR1BSNF9GRUNf
RU5FVDJfU1RPUF9SRVEJCQkoMHgxIDw8IDQpDQogDQotLSANCjEuOS4xDQoNCg==
