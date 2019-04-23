Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45694C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F842217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aUPw9X3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDWKq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:46:27 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:14144
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfDWKqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUIIGy3Kfn8LdkNcOefMbRCNB/8qw3c+dz2BKE77vk8=;
 b=aUPw9X3dX5JOTmHokPPHoeyxTUY0oVaowAg2e7ltMXgrsBegdsMONGjGzx4N5VoaY6Ic2STkMddypWA8dImx2x5NPwcClsFa5RyqEy3DcFEQ2Cum3F7BOzcDox8lpvT/MByi2pBRDST5zNINt8dNvMrKQjVUbaRbhGZa1l9uMI4=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4901.eurprd04.prod.outlook.com (20.177.33.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Tue, 23 Apr 2019 10:46:22 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::b953:a9de:d0bf:7159%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 10:46:22 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] spi: lpspi: add multi SS support in PIO mode
Thread-Topic: [PATCH 2/3] spi: lpspi: add multi SS support in PIO mode
Thread-Index: AQHU+cHKq71me01A3EuIkqhmibfqDQ==
Date:   Tue, 23 Apr 2019 10:46:22 +0000
Message-ID: <20190423104649.24483-3-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 39921b8b-390f-4abb-53d9-08d6c7d8ec97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4901;
x-ms-traffictypediagnostic: AM6PR04MB4901:
x-microsoft-antispam-prvs: <AM6PR04MB49018908942A782ABA984AA3F3230@AM6PR04MB4901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(26005)(186003)(66066001)(102836004)(11346002)(6506007)(386003)(2616005)(14444005)(486006)(316002)(76176011)(476003)(52116002)(446003)(256004)(2351001)(2906002)(66946007)(73956011)(86362001)(6116002)(3846002)(99286004)(36756003)(66446008)(66556008)(66476007)(64756008)(54906003)(5660300002)(71200400001)(50226002)(478600001)(71190400001)(305945005)(8676002)(2501003)(6512007)(8936002)(6436002)(68736007)(1730700003)(81156014)(25786009)(81166006)(6916009)(4326008)(14454004)(5640700003)(1076003)(53936002)(6486002)(97736004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4901;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F1cywFmk6Km1w2FB/jiB4xaxu/tPeyw80Lv7nBFxguYZmNYJboQd9DmNRlzuQZTBM4bRZPW3BefZ1qQqxT69LkLMGN0GBAKsIvXLfH93qohhMjzitTaxuBgPNf1zhCW3kClevVxTpPkSvYOEP9wrz6Gl90ktUhWJFxncLxogTGdZ1miv7VZMKE38w94E0XcSbLkL2BWzoSeobxWvJyXfjcryyidVhbDHONUNAub027pSZcSP8k9jH6cez3XzkHhaSNeLxPbzSVCOyo9ZhmTpw1kkuu/Vp51bKtFMhw59nlwHD9vuDvqhx2OOwmhBpSBEjg/y5A+F/4QdgWt1v0OMchluvkFVKWjaLZAReULJzIVxueYrc8m7oClxo8fanLX0CQa3R+cT97cTCzLBZOrd9mN1bNnXUTu8sxYIa/LrKUc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39921b8b-390f-4abb-53d9-08d6c7d8ec97
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 10:46:22.2042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJmc2wsc3BpLW51bS1jaGlwc2VsZWN0cyIgY2hlY2sgdG8gc3VwcG9ydCBtdWx0aSBTUyBm
dW5jdGlvbiBpbiBQSU8NCm1vZGUuDQoNClNpZ25lZC1vZmYtYnk6IENsYXJrIFdhbmcgPHhpYW9u
aW5nLndhbmdAbnhwLmNvbT4NCkFja2VkLWJ5OiBGdWdhbmcgRHVhbiA8ZnVnYW5nLmR1YW5Abnhw
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYyB8IDEyICsrKysrKysrKysr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLWxwc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGkt
ZnNsLWxwc3BpLmMNCmluZGV4IDE5MDQwYjVlZjM0OS4uYThlODNjYjk2ZjYxIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQorKysgYi9kcml2ZXJzL3NwaS9zcGktZnNs
LWxwc3BpLmMNCkBAIC04NDEsNyArODQxLDcgQEAgc3RhdGljIGludCBmc2xfbHBzcGlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJc3RydWN0IHNwaV9pbXhfbWFzdGVyICps
cHNwaV9wbGF0Zm9ybV9pbmZvID0NCiAJCWRldl9nZXRfcGxhdGRhdGEoJnBkZXYtPmRldik7DQog
CXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KLQlpbnQgaSwgcmV0LCBpcnE7DQorCWludCBpLCByZXQs
IGlycSwgbnVtX2NzOw0KIAl1MzIgdGVtcDsNCiAJYm9vbCBpc19zbGF2ZTsNCiANCkBAIC04NjMs
NiArODYzLDE2IEBAIHN0YXRpYyBpbnQgZnNsX2xwc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogDQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGNvbnRyb2xsZXIp
Ow0KIA0KKwlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgImZzbCxzcGktbnVtLWNoaXBz
ZWxlY3RzIiwgJm51bV9jcyk7DQorCWlmIChyZXQgPCAwKSB7DQorCQlpZiAobHBzcGlfcGxhdGZv
cm1faW5mbykgew0KKwkJCW51bV9jcyA9IGxwc3BpX3BsYXRmb3JtX2luZm8tPm51bV9jaGlwc2Vs
ZWN0Ow0KKwkJCWNvbnRyb2xsZXItPm51bV9jaGlwc2VsZWN0ID0gbnVtX2NzOw0KKwkJfQ0KKwl9
IGVsc2Ugew0KKwkJY29udHJvbGxlci0+bnVtX2NoaXBzZWxlY3QgPSBudW1fY3M7DQorCX0NCisN
CiAJZnNsX2xwc3BpID0gc3BpX2NvbnRyb2xsZXJfZ2V0X2RldmRhdGEoY29udHJvbGxlcik7DQog
CWZzbF9scHNwaS0+ZGV2ID0gJnBkZXYtPmRldjsNCiAJZnNsX2xwc3BpLT5pc19zbGF2ZSA9IGlz
X3NsYXZlOw0KLS0gDQoyLjE3LjENCg0K
