Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15446C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6AD20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jvVL7xp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfDJKhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:37:32 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:17066
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfDJKhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V/zkhgtVorgv2fBqpM/7kGWvitxwIjl6pPRlIX1ZS0=;
 b=jvVL7xp2BUwuJHXzOZ/uj1UYe0lxYmlQNAOCDB6KXCXnJrDMpXI1U/6Vpo961C+j1qoU1vmG09/L7o63vaWr/4IcO0HXN5MbjfHdM5dxH23Kn1QFJLtbkZRS7mtRIZw9DDk38uVPGs2k1yimalnYJ+mntkx/TuBhocGPH2OIIE8=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5549.eurprd04.prod.outlook.com (20.178.122.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:37:28 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:37:27 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>
CC:     Viorel Suman <viorel.suman@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/4] ASoC: fsl: audmix: remove "model" attribute and fix
 ref leaks
Thread-Topic: [PATCH v3 0/4] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Thread-Index: AQHU74lkymub95Zy1EyaXekIZ9/Vuw==
Date:   Wed, 10 Apr 2019 10:37:27 +0000
Message-ID: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85ae8b24-03ce-42d7-57ee-08d6bda086e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5549;
x-ms-traffictypediagnostic: VI1PR04MB5549:
x-microsoft-antispam-prvs: <VI1PR04MB554923A1E3601D1DC74EBFBB922E0@VI1PR04MB5549.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(105586002)(71190400001)(71200400001)(256004)(5660300002)(68736007)(106356001)(8676002)(81166006)(81156014)(508600001)(36756003)(66066001)(97736004)(102836004)(6506007)(486006)(25786009)(2616005)(50226002)(386003)(26005)(4326008)(186003)(14454004)(8936002)(6436002)(53936002)(7416002)(6486002)(2906002)(52116002)(6116002)(44832011)(54906003)(99286004)(3846002)(316002)(110136005)(86362001)(305945005)(4744005)(6512007)(7736002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5549;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VQTUquFelKUWoSDMRvG6g/h/z/R10ixQSZc94yXXX6jJ7J8YkBMK2GS8f/cLI17sguJ1Pk6MB3afRXOc8Tzres6MJNJyMQ+CQ31LWxQRll36De0jogawnBvnKWKdCibqZwZOqLVJYxbrsNDowb9AM80+8Bome7Upo4Ib4gj5kpwD4mSA4cjPfz9d8FPyEWeJacgJsaKHGZ7wU6lp5Moq3PONXz/YgbHGtnvq8NEUN4bXR7XUN80/XJhkljXf+xQqgFMJr8Mfpw36+cyNmqgWwyWl+keYYv5tnKe74Tg0DvXP59OmYJVddazHFGauVePG0WqqHNLaZ30jLJxhlU2nG/dUV/wSk0KDM0ySoRrLc6uHP8XAsFTlgnT3zOn0ANd2JvlOEDuEoJ1S8jXpiY0NF2+D3IVTlgraegEMi9KmHk8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae8b24-03ce-42d7-57ee-08d6bda086e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:37:27.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxhdGVzdCBhdWRtaXggcGF0Y2gtc2V0ICh2NSkgaGFkIHRoZSAibW9kZWwiIGF0dHJpYnV0
ZSByZW1vdmVkIGFzDQpyZXF1ZXN0ZWQgYnkgTmljb2xpbiBDaGVuLCBidXQgbG9va3MgbGlrZSAo
djQpIHZlcnNpb24gb2YgREFJIGRyaXZlcg0KcmVhY2hlZCAiZm9yLW5leHQiIGJyYW5jaCAtIGZp
eCB0aGlzIGJ5IHJlbW92aW5nICJtb2RlbCIgYXR0cmlidXRlLg0KQXNzaWRlIG9mIHRoaXMgZml4
IG9iamVjdCByZWZlcmVuY2UgbGVha3MgaW4gbWFjaGluZSBwcm9iZSByZXBvcnRlZCBieQ0KSnVs
aWEgTGF3YWxsLg0KDQpWaW9yZWwgU3VtYW4gKDQpOg0KICBBU29DOiBmc2xfYXVkbWl4OiByZW1v
dmUgIm1vZGVsIiBhdHRyaWJ1dGUNCiAgZHQtYmluZGluZ3M6IGZzbCxhdWRtaXg6IHJlbW92ZSAi
bW9kZWwiIGF0dHJpYnV0ZQ0KICBBU29DOiBpbXgtYXVkbWl4OiBmaXggb2JqZWN0IHJlZmVyZW5j
ZSBsZWFrcyBpbiBwcm9iZQ0KICBBU29DOiBmc2xfYXVkbWl4OiBjYWNoZSBwZGV2LT5kZXYgcG9p
bnRlcg0KDQpDaGFuZ2VzIHNpbmNlIFYxOg0KICBhKSBSZW1vdmVkICJtb2RlbCIgYXR0cmlidXRl
IGZyb20gZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbg0KICBiKSBBZHJlc3NlZCBEYW5pZWwncyBj
b21tZW50cw0KDQpDaGFuZ2VzIHNpbmNlIFYyOg0KICBhKSBDYWNoZSBwZGV2LT5kZXYgcG9pbnRl
ciBpbiBmc2xfYXVkbWl4IHByb2JlIGFzIHN1Z2dlc3RlZCBieSBOaWNvbGluDQoNCiAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXVkbWl4LnR4dCAgICAgICB8ICA0IC0tDQogc291
bmQvc29jL2ZzbC9mc2xfYXVkbWl4LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MSArKysr
KysrKysrKystLS0tLS0tLS0tDQogc291bmQvc29jL2ZzbC9pbXgtYXVkbWl4LmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgNCArKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgMzMgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
