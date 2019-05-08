Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F0C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7660205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bBJHDRkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEHGFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:05:19 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:3088
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfEHGFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5HcUnI7n/IagTVqPKdOVRgCZ2PwXt52Vwz1y5MvR4A=;
 b=bBJHDRkJfLiqHEkrY67vpIDq17a5HAEi2pWl8CWWatp0eiks4Y1djYz0iEknwLY7Bg3mlb4rgONttASJxzp7nRwthbmq/eFuQeftIrcmUoV1YoT7Wx7WZBuUgUzx2zbJeugfm7kZc+yhhxeB/ToE9sXJSkehkOEkDXRYFFnEfJA=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4141.eurprd04.prod.outlook.com (52.133.14.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 06:04:42 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:04:42 +0000
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
Subject: [PATCH v5 3/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Topic: [PATCH v5 3/5] usb: linux/fsl_device: Add platform member
 has_fsl_erratum_a006918
Thread-Index: AQHVBWPtfEHsDOgUrECiiuPrEjxPLw==
Date:   Wed, 8 May 2019 06:04:42 +0000
Message-ID: <20190508060608.33882-3-yinbo.zhu@nxp.com>
References: <20190508060608.33882-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190508060608.33882-1-yinbo.zhu@nxp.com>
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
x-ms-office365-filtering-correlation-id: 7ccc80b5-30b4-4a5f-8710-08d6d37b100e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4141;
x-ms-traffictypediagnostic: VI1PR04MB4141:
x-microsoft-antispam-prvs: <VI1PR04MB4141A6CE29847DE685056506E9320@VI1PR04MB4141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(68736007)(446003)(54906003)(2906002)(6116002)(81156014)(11346002)(486006)(476003)(6506007)(2616005)(66066001)(81166006)(8676002)(76176011)(7736002)(305945005)(44832011)(6916009)(36756003)(2171002)(50226002)(53936002)(4326008)(25786009)(86362001)(1076003)(4744005)(8936002)(186003)(5660300002)(3846002)(52116002)(99286004)(102836004)(316002)(386003)(478600001)(256004)(71190400001)(71200400001)(14444005)(14454004)(6512007)(6486002)(6436002)(66446008)(73956011)(66946007)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4141;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +AkbYLMEeAZORaurYOT+9TZ/zd9RlczwVgOLMrRVE5jVvyx7ZnwGlfOG1B4af2qgrv9oTWPFojfGCRNGHmdVer7xcPNoVcKqgkThXOjxeDfDa3RObIW4lcNAmLY9bmArFPGIFnYgUoTtsOUvX60X0WfR+yy02JO45eJMOB7pLeYQE7OvqjGxLkpKo3yW0dg26aAsvEHAeI+r0CoTyg3L4sHgC2hFj76SdI9WeZWnsZiqjP2O2X8YdBWhc51kR2Bv8S8H8bc8LTQSYBJ1d8b/qau7acrZMYatg7HI9Y7Qbs89uKkXLxlyWO/LM2SSyDkfJ0HT7q9/eNArQyGGz0eKV5g/5pUa60HHTGqKGCLZ3Pg1hcZk3GDiONGu3By919KqLY9semm5/Lth5miqPLMpKI1kqaKsrfpY3VDH3Riw3IE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccc80b5-30b4-4a5f-8710-08d6d37b100e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:04:42.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBpcyB0byBh
ZGQgbWVtYmVyIGhhc19mc2xfZXJyYXR1bV9hMDA2OTE4IGluIHBsYXRmb3JtIGRhdGENCg0KU2ln
bmVkLW9mZi1ieTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCi0tLQ0KIGluY2x1ZGUv
bGludXgvZnNsX2RldmljZXMuaCB8ICAgIDEgKw0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc2xf
ZGV2aWNlcy5oIGIvaW5jbHVkZS9saW51eC9mc2xfZGV2aWNlcy5oDQppbmRleCA1ZGE1NmE2Li40
YzYxM2RhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9mc2xfZGV2aWNlcy5oDQorKysgYi9p
bmNsdWRlL2xpbnV4L2ZzbF9kZXZpY2VzLmgNCkBAIC0xMDIsNiArMTAyLDcgQEAgc3RydWN0IGZz
bF91c2IyX3BsYXRmb3JtX2RhdGEgew0KIAl1bnNpZ25lZAloYXNfZnNsX2VycmF0dW1fMTQ6MTsN
CiAJdW5zaWduZWQJaGFzX2ZzbF9lcnJhdHVtX2EwMDUyNzU6MTsNCiAJdW5zaWduZWQJaGFzX2Zz
bF9lcnJhdHVtX2EwMDU2OTc6MTsNCisJdW5zaWduZWQgICAgICAgIGhhc19mc2xfZXJyYXR1bV9h
MDA2OTE4OjE7DQogCXVuc2lnbmVkCWNoZWNrX3BoeV9jbGtfdmFsaWQ6MTsNCiANCiAJLyogcmVn
aXN0ZXIgc2F2ZSBhcmVhIGZvciBzdXNwZW5kL3Jlc3VtZSAqLw0KLS0gDQoxLjcuMQ0KDQo=
