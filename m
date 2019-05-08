Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B5DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A3C205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jEwn/rsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfEHGEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:04:40 -0400
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:31106
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfEHGEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsJBt/rh2JZdRN0sgVlRhpR8FAR3c3LN/urSjCC8uAE=;
 b=jEwn/rsfWXv6qEoTf+GqR74x3Ne2cby2jg0U2wNd/zq+lL+UAF7hAopR9TLOQ4fbUX395tlQWSHWcwCvbxtVVMsvHNRQT8sV8gmAk9N8Bg1Zyz6uWxUQaG1Hevcv8blxMqpCOSJz1TELs3g1/MER8KZRIr2QtGxwokYX+RHvftA=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4141.eurprd04.prod.outlook.com (52.133.14.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 06:04:35 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:04:35 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: [PATCH v5 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Topic: [PATCH v5 1/5] usb: fsl: Set USB_EN bit to select ULPI phy
Thread-Index: AQHVBWPplmBKYnpFSEWIawQlwwrKjA==
Date:   Wed, 8 May 2019 06:04:35 +0000
Message-ID: <20190508060608.33882-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ae5964b-d030-4304-627e-08d6d37b0b77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4141;
x-ms-traffictypediagnostic: VI1PR04MB4141:
x-microsoft-antispam-prvs: <VI1PR04MB41412FE44C788B08A7A323AEE9320@VI1PR04MB4141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(52116002)(316002)(478600001)(8936002)(386003)(99286004)(102836004)(5660300002)(186003)(3846002)(66446008)(73956011)(66946007)(26005)(66556008)(64756008)(66476007)(71200400001)(256004)(71190400001)(6486002)(6436002)(14454004)(6512007)(305945005)(7736002)(44832011)(6116002)(486006)(81156014)(68736007)(2906002)(54906003)(8676002)(81166006)(66066001)(476003)(6506007)(2616005)(86362001)(4744005)(1076003)(36756003)(6916009)(53936002)(25786009)(4326008)(50226002)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4141;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6x1dB+kRU1AHLKH8jcHH2Lbxh5/wvwodYPFchbzwOkAbNbdP4d7FOmWhApqmQuDKAvRin3ImAa63OVU56Gx9zawUCryjg0lmIieiV0FCVjtjtYod+1P1ixQ8Dr+Cs5At5OMgRezUirRG5/P760KbzMU7tuSQyezvTzIzUXQJTyvFWKumudvfUAjb7uWuwJkWJsWQrgnRP5bjmGdMpb8XQBtaOKVbTCgTKlj2UhQkSp87pgj8TeL9VnlNeCPWLE99B/Kr25axb2TUgE7Nd6we37AI+0mtu13cRpdJ0Q3R4vpohPPxVTAzsbkIdoSw8CQt7/eG+pEOi8KbtbCZ8YaziXL6r4s4p5xYj6ds39N5WZhbQag79C41odJihsHZhi7knG4XTXZTYT5DIuLZ/iGE/t1qe22hWmgpGemsNVA+j40=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae5964b-d030-4304-627e-08d6d37b0b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:04:35.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmlraGlsIEJhZG9sYSA8bmlraGlsLmJhZG9sYUBmcmVlc2NhbGUuY29tPg0KDQpTZXQg
VVNCX0VOIGJpdCB0byBzZWxlY3QgVUxQSSBwaHkgZm9yIFVTQiBjb250cm9sbGVyIHZlcnNpb24g
Mi41DQoNClNpZ25lZC1vZmYtYnk6IE5pa2hpbCBCYWRvbGEgPG5pa2hpbC5iYWRvbGFAZnJlZXNj
YWxlLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQot
LS0NCiBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgfCAgICA2ICsrKysrKw0KIDEgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5j
DQppbmRleCBlM2QwYzFjLi4zODY3NGI3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9l
aGNpLWZzbC5jDQorKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMNCkBAIC0xMjIsNiAr
MTIyLDEyIEBAIHN0YXRpYyBpbnQgZnNsX2VoY2lfZHJ2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogCQl0bXAgfD0gMHg0Ow0KIAkJaW93cml0ZTMyYmUodG1wLCBoY2QtPnJl
Z3MgKyBGU0xfU09DX1VTQl9DVFJMKTsNCiAJfQ0KKw0KKwkvKiBTZXQgVVNCX0VOIGJpdCB0byBz
ZWxlY3QgVUxQSSBwaHkgZm9yIFVTQiBjb250cm9sbGVyIHZlcnNpb24gMi41ICovDQorCWlmIChw
ZGF0YS0+Y29udHJvbGxlcl92ZXIgPT0gRlNMX1VTQl9WRVJfMl81ICYmDQorCSAgICBwZGF0YS0+
cGh5X21vZGUgPT0gRlNMX1VTQjJfUEhZX1VMUEkpDQorCQlpb3dyaXRlMzJiZShVU0JfQ1RSTF9V
U0JfRU4sIGhjZC0+cmVncyArIEZTTF9TT0NfVVNCX0NUUkwpOw0KKw0KIAkvKg0KIAkgKiBFbmFi
bGUgVVRNSSBwaHkgYW5kIHByb2dyYW0gUFRTIGZpZWxkIGluIFVUTUkgbW9kZSBiZWZvcmUgYXNz
ZXJ0aW5nDQogCSAqIGNvbnRyb2xsZXIgcmVzZXQgZm9yIFVTQiBDb250cm9sbGVyIHZlcnNpb24g
Mi41DQotLSANCjEuNy4xDQoNCg==
