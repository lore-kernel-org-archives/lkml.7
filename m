Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9640DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FFF206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctO8sNKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfDWKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:46:31 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:29070
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfDWKq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrfg9MidvALwNhszPgwQhtMWz5vUUsbMcyPEP6uOPRM=;
 b=ctO8sNKYv05hLXgBIjhLDV0fcDgjvbFZq/vBaV5tXCQJ9XiD2ddhWIS7PWqWTx+m3DpwWdF5zBFeKCrT7FV/9K2Ng5KArNS/9vUS0JoH9uWUc7wangPWG0+EjhKVr25upV9cE1FNoq5TVfnVOM20QC/wRhXCJobe2ZEGdvJm3KI=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4901.eurprd04.prod.outlook.com (20.177.33.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:46:24 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:46:24 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] spi: lpspi: remove fsl_lpspi->chipselect
Thread-Topic: [PATCH 3/3] spi: lpspi: remove fsl_lpspi->chipselect
Thread-Index: AQHU+cHL/I8KHu5KYE69/PerGlL+Cg==
Date:   Tue, 23 Apr 2019 10:46:24 +0000
Message-ID: <20190423104649.24483-4-xiaoning.wang@nxp.com>
References: <20190423104649.24483-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190423104649.24483-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KU1PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:802:19::36) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f5b74d6-b1df-4918-dcef-08d6c7d8edde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4901;
x-ms-traffictypediagnostic: AM6PR04MB4901:
x-microsoft-antispam-prvs: <AM6PR04MB49014ABC299AB60F742618CDF3230@AM6PR04MB4901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(26005)(186003)(66066001)(102836004)(11346002)(6506007)(386003)(2616005)(14444005)(486006)(316002)(76176011)(476003)(52116002)(446003)(256004)(2351001)(2906002)(66946007)(73956011)(86362001)(6116002)(3846002)(99286004)(36756003)(66446008)(66556008)(66476007)(64756008)(54906003)(5660300002)(71200400001)(50226002)(478600001)(71190400001)(305945005)(8676002)(2501003)(6512007)(8936002)(6436002)(68736007)(1730700003)(81156014)(25786009)(81166006)(6916009)(4326008)(14454004)(5640700003)(1076003)(53936002)(6486002)(97736004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4901;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J1ixT+dNlqg3aOw1LIfCjiEXsFwLZly2luBqF1XjwXkeWMzyK8MDUZcH+iNntzJ7EwRYEM9Y3dcncHuF9yizA/Kh3+J3LMYgEEozbWoaDNB/EMRXZcT9GgS9L1mnd9unYPXM/3tA++aM1ejLlJi7GCBQjY7h7UT6iDNfLUUJbwUPA44994ySwMEwISySrtyuz88LrHPsN1Q7r65fFyLx7I3VF3f5dZm4IbZBWku9ew1QdhPmLvZeZgQkxLztZ+CctD8zIpiDqEsE1mmNB0aw7kSmaHMWK28luzADv0WhFqgM6C0jsXsiKnkARFp2aiI278OyQroCu2Av3u+IzpHA8oFxvt7cb16asN5VEw/neNdmv33RKJl2chKBy0Ftmm3XyRnvOywwwiUdNb+jWJx53Xy+kI1w2HIf+yvRPYHEFSs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5b74d6-b1df-4918-dcef-08d6c7d8edde
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:46:24.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBmc2xfbHBzcGktPmNoaXBzZWxlY3QgYnkgY29udHJvbGxlci0+Y3NfZ3Bpb3MuIENs
ZWFuIHVwIHRoZQ0KY29kZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2xhcmsgV2FuZyA8eGlhb25pbmcu
d2FuZ0BueHAuY29tPg0KQWNrZWQtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29t
Pg0KLS0tDQogZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jIHwgMTQgKysrKysrLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZz
bC1scHNwaS5jDQppbmRleCBhOGU4M2NiOTZmNjEuLmFhNjIxOGNiYzllOCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1s
cHNwaS5jDQpAQCAtMTI0LDggKzEyNCw2IEBAIHN0cnVjdCBmc2xfbHBzcGlfZGF0YSB7DQogCWJv
b2wgdXNlZG1hOw0KIAlzdHJ1Y3QgY29tcGxldGlvbiBkbWFfcnhfY29tcGxldGlvbjsNCiAJc3Ry
dWN0IGNvbXBsZXRpb24gZG1hX3R4X2NvbXBsZXRpb247DQotDQotCWludCBjaGlwc2VsZWN0WzBd
Ow0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgZnNsX2xwc3BpX2R0
X2lkc1tdID0gew0KQEAgLTIzMCwxMCArMjI4LDggQEAgc3RhdGljIGludCBscHNwaV91bnByZXBh
cmVfeGZlcl9oYXJkd2FyZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmNvbnRyb2xsZXIpDQogc3Rh
dGljIGludCBmc2xfbHBzcGlfcHJlcGFyZV9tZXNzYWdlKHN0cnVjdCBzcGlfY29udHJvbGxlciAq
Y29udHJvbGxlciwNCiAJCQkJICAgICBzdHJ1Y3Qgc3BpX21lc3NhZ2UgKm1zZykNCiB7DQotCXN0
cnVjdCBmc2xfbHBzcGlfZGF0YSAqZnNsX2xwc3BpID0NCi0JCQkJCXNwaV9jb250cm9sbGVyX2dl
dF9kZXZkYXRhKGNvbnRyb2xsZXIpOw0KIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpID0gbXNnLT5z
cGk7DQotCWludCBncGlvID0gZnNsX2xwc3BpLT5jaGlwc2VsZWN0W3NwaS0+Y2hpcF9zZWxlY3Rd
Ow0KKwlpbnQgZ3BpbyA9IGNvbnRyb2xsZXItPmNzX2dwaW9zW3NwaS0+Y2hpcF9zZWxlY3RdOw0K
IA0KIAlpZiAoZ3Bpb19pc192YWxpZChncGlvKSkNCiAJCWdwaW9fZGlyZWN0aW9uX291dHB1dChn
cGlvLCBzcGktPm1vZGUgJiBTUElfQ1NfSElHSCA/IDAgOiAxKTsNCkBAIC04NzcsNiArODczLDkg
QEAgc3RhdGljIGludCBmc2xfbHBzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCiAJZnNsX2xwc3BpLT5kZXYgPSAmcGRldi0+ZGV2Ow0KIAlmc2xfbHBzcGktPmlzX3NsYXZl
ID0gaXNfc2xhdmU7DQogDQorCWNvbnRyb2xsZXItPmNzX2dwaW9zID0gZGV2bV9remFsbG9jKCZj
b250cm9sbGVyLT5kZXYsDQorCQkJc2l6ZW9mKGludCkgKiBjb250cm9sbGVyLT5udW1fY2hpcHNl
bGVjdCwgR0ZQX0tFUk5FTCk7DQorDQogCWlmICghZnNsX2xwc3BpLT5pc19zbGF2ZSkgew0KIAkJ
Zm9yIChpID0gMDsgaSA8IGNvbnRyb2xsZXItPm51bV9jaGlwc2VsZWN0OyBpKyspIHsNCiAJCQlp
bnQgY3NfZ3BpbyA9IG9mX2dldF9uYW1lZF9ncGlvKG5wLCAiY3MtZ3Bpb3MiLCBpKTsNCkBAIC04
ODQsMTkgKzg4MywxOCBAQCBzdGF0aWMgaW50IGZzbF9scHNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIAkJCWlmICghZ3Bpb19pc192YWxpZChjc19ncGlvKSAmJiBscHNw
aV9wbGF0Zm9ybV9pbmZvKQ0KIAkJCQljc19ncGlvID0gbHBzcGlfcGxhdGZvcm1faW5mby0+Y2hp
cHNlbGVjdFtpXTsNCiANCi0JCQlmc2xfbHBzcGktPmNoaXBzZWxlY3RbaV0gPSBjc19ncGlvOw0K
KwkJCWNvbnRyb2xsZXItPmNzX2dwaW9zW2ldID0gY3NfZ3BpbzsNCiAJCQlpZiAoIWdwaW9faXNf
dmFsaWQoY3NfZ3BpbykpDQogCQkJCWNvbnRpbnVlOw0KIA0KIAkJCXJldCA9IGRldm1fZ3Bpb19y
ZXF1ZXN0KCZwZGV2LT5kZXYsDQotCQkJCQkJZnNsX2xwc3BpLT5jaGlwc2VsZWN0W2ldLA0KKwkJ
CQkJCWNvbnRyb2xsZXItPmNzX2dwaW9zW2ldLA0KIAkJCQkJCURSSVZFUl9OQU1FKTsNCiAJCQlp
ZiAocmV0KSB7DQogCQkJCWRldl9lcnIoJnBkZXYtPmRldiwgImNhbid0IGdldCBjcyBncGlvc1xu
Iik7DQogCQkJCWdvdG8gb3V0X2NvbnRyb2xsZXJfcHV0Ow0KIAkJCX0NCiAJCX0NCi0JCWNvbnRy
b2xsZXItPmNzX2dwaW9zID0gZnNsX2xwc3BpLT5jaGlwc2VsZWN0Ow0KIAkJY29udHJvbGxlci0+
cHJlcGFyZV9tZXNzYWdlID0gZnNsX2xwc3BpX3ByZXBhcmVfbWVzc2FnZTsNCiAJfQ0KIA0KLS0g
DQoyLjE3LjENCg0K
