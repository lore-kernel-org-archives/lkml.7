Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9381727CF1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="HuILqGGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfFCLZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:25:09 -0400
Received: from mail-eopbgr20131.outbound.protection.outlook.com ([40.107.2.131]:57671
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727853AbfFCLZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gixPxJfYdF7FcoI84HFVfhTX+E/oD9amO4p/Zvfk05E=;
 b=HuILqGGqOV9xPyYXHtSeTI0wqArPCwGTClVBtJNfIfsRRWRkdG/tJ5nCVpfgkVr2fe83HdPUOAOUNNOJZi4frBfyWhYD7ys9Tz8HSGJNyk5PR2aKhB7axtAmdGazOGroh3afhR2jGKioOxY0F6+LGPT3BC2XcwM2e26ElS4pMbM=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3232.eurprd02.prod.outlook.com (10.170.237.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 11:25:05 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::d45e:25f0:5b42:30e2]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::d45e:25f0:5b42:30e2%2]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 11:25:04 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Fix virtual address access via debugfs for 2MB
 pages
Thread-Topic: [PATCH] habanalabs: Fix virtual address access via debugfs for
 2MB pages
Thread-Index: AQHVGf79ZEQbNjIpkUW9KoWkAlg3zQ==
Date:   Mon, 3 Jun 2019 11:25:04 +0000
Message-ID: <20190603112453.20097-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:203:2::28) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afdfe035-254a-42cd-f02f-08d6e8162013
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB3232;
x-ms-traffictypediagnostic: VI1PR02MB3232:
x-microsoft-antispam-prvs: <VI1PR02MB3232885F8211F466B67FDDE1D2140@VI1PR02MB3232.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39850400004)(199004)(189003)(316002)(50226002)(74482002)(186003)(81156014)(81166006)(8676002)(1361003)(5660300002)(2906002)(102836004)(52116002)(71200400001)(71190400001)(7736002)(478600001)(476003)(2501003)(3846002)(305945005)(6116002)(386003)(486006)(6506007)(2616005)(66446008)(64756008)(66476007)(66556008)(86362001)(25786009)(6436002)(5640700003)(66946007)(36756003)(14454004)(6486002)(73956011)(4326008)(2351001)(66066001)(26005)(6916009)(256004)(6512007)(99286004)(14444005)(68736007)(53936002)(1076003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3232;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DQQD6sXx9W3U2VHdUpIWn74Dr8B6kKIrPWIc/Ab6aZq1oNUlKcATKtPMsGA0/oYiUdjLglGzqVtIqrzFml19EIHiQXZ5M7hOAaU81wWtHmxEm9qgIjBQUnpDXJFFdw/fCOogUckhUk3GUQq+hCvFoeSyl6Wtq0i/b+uXivn5wEp22w7P6o7ooYvRDScs1Eu7BeYHSQumw/oeSoqPdwHcNBT0K6wRJaFiDCrQ/0VmZzOhOnHZphLXe1vYIxizUP2i0lLMmrZ2HCwqNABiXZvEZuaG5qhT+2fBw1/+rNOUBs8Lvz7hC8+cPmM94wQPJA2qZwBOXTNgJx22E4o0o7v5H02+nuw6bKNewG+UgBp3azpDeqG0+yTvcQ7oDABFZ6hlL3QBag/4Tscf58r0fFoSB1DFsq07w6WCbMdAcJonFZQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: afdfe035-254a-42cd-f02f-08d6e8162013
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 11:25:04.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRlYnVnZnMgaW50ZXJmYWNlIGZvciBhY2Nlc3NpbmcgRFJBTSB2aXJ0dWFsIGFkZHJlc3Nl
cyBjdXJyZW50bHkNCnVzZXMgdGhlIDEyIExTQnMgb2YgYSB2aXJ0dWFsIGFkZHJlc3MgYXMgYW4g
b2Zmc2V0Lg0KSG93ZXZlciwgaXQgc2hvdWxkIHVzZSB0aGUgMjAgTFNCcyBpbiBjYXNlIHRoZSBk
ZXZpY2UgTU1VIHBhZ2Ugc2l6ZSBpcw0KMk1CIGluc3RlYWQgb2YgNEtCLg0KVGhpcyBwYXRjaCBm
aXhlcyB0aGUgb2Zmc2V0IGNhbGN1bGF0aW9uIHRvIGJlIGJhc2VkIG9uIHRoZSBwYWdlIHNpemUu
DQoNClNpZ25lZC1vZmYtYnk6IFRvbWVyIFRheWFyIDx0dGF5YXJAaGFiYW5hLmFpPg0KLS0tDQog
ZHJpdmVycy9taXNjL2hhYmFuYWxhYnMvZGVidWdmcy5jIHwgNSArKysrLQ0KIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbWlzYy9oYWJhbmFsYWJzL2RlYnVnZnMuYyBiL2RyaXZlcnMvbWlzYy9oYWJhbmFsYWJzL2Rl
YnVnZnMuYw0KaW5kZXggMGNlNTYyMWMxMzI0Li5iYTQxOGFhYTQwNGMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL21pc2MvaGFiYW5hbGFicy9kZWJ1Z2ZzLmMNCisrKyBiL2RyaXZlcnMvbWlzYy9oYWJh
bmFsYWJzL2RlYnVnZnMuYw0KQEAgLTUwMCw2ICs1MDAsNyBAQCBzdGF0aWMgaW50IGRldmljZV92
YV90b19wYShzdHJ1Y3QgaGxfZGV2aWNlICpoZGV2LCB1NjQgdmlydF9hZGRyLA0KIHsNCiAJc3Ry
dWN0IGhsX2N0eCAqY3R4ID0gaGRldi0+dXNlcl9jdHg7DQogCXU2NCBob3BfYWRkciwgaG9wX3B0
ZV9hZGRyLCBob3BfcHRlOw0KKwl1NjQgb2Zmc2V0X21hc2sgPSBIT1A0X01BU0sgfCBPRkZTRVRf
TUFTSzsNCiAJaW50IHJjID0gMDsNCiANCiAJaWYgKCFjdHgpIHsNCkBAIC01NDIsMTIgKzU0Mywx
NCBAQCBzdGF0aWMgaW50IGRldmljZV92YV90b19wYShzdHJ1Y3QgaGxfZGV2aWNlICpoZGV2LCB1
NjQgdmlydF9hZGRyLA0KIAkJCWdvdG8gbm90X21hcHBlZDsNCiAJCWhvcF9wdGVfYWRkciA9IGdl
dF9ob3A0X3B0ZV9hZGRyKGN0eCwgaG9wX2FkZHIsIHZpcnRfYWRkcik7DQogCQlob3BfcHRlID0g
aGRldi0+YXNpY19mdW5jcy0+cmVhZF9wdGUoaGRldiwgaG9wX3B0ZV9hZGRyKTsNCisNCisJCW9m
ZnNldF9tYXNrID0gT0ZGU0VUX01BU0s7DQogCX0NCiANCiAJaWYgKCEoaG9wX3B0ZSAmIFBBR0Vf
UFJFU0VOVF9NQVNLKSkNCiAJCWdvdG8gbm90X21hcHBlZDsNCiANCi0JKnBoeXNfYWRkciA9ICho
b3BfcHRlICYgUFRFX1BIWVNfQUREUl9NQVNLKSB8ICh2aXJ0X2FkZHIgJiBPRkZTRVRfTUFTSyk7
DQorCSpwaHlzX2FkZHIgPSAoaG9wX3B0ZSAmIH5vZmZzZXRfbWFzaykgfCAodmlydF9hZGRyICYg
b2Zmc2V0X21hc2spOw0KIA0KIAlnb3RvIG91dDsNCiANCi0tIA0KMi4xNy4xDQoNCg==
