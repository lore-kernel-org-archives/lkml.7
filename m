Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701B421479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qW8x2nTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEINam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:30:42 -0400
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:29892
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbfEINal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8nEPId8Gc1wQVeEFvQHBscn8K0EIAfg1sbMmhKgNJs=;
 b=qW8x2nTA1Dxb7kn0TuhwE6avDStUAb0tFSHWN17cTwDAsjiwuACle/FokkBOotsWZ7589j7+k4aQg27byiXcV4jRhGjAu0fKG9naRoyEiY0lX5/qkdwtftOVrKzEiidxhrEOOYWNAlN5hYP4CTxy1+GtXPGP9Wx7pIQw8ONaQl4=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4029.eurprd04.prod.outlook.com (10.171.182.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 13:30:36 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7%2]) with mapi id 15.20.1878.022; Thu, 9 May 2019
 13:30:36 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH 1/2] ASoC: ak4458: rstn_control - return a non-zero on error
 only
Thread-Topic: [PATCH 1/2] ASoC: ak4458: rstn_control - return a non-zero on
 error only
Thread-Index: AQHVBmtiJsyVhgNMwkeHjZewPl9IIw==
Date:   Thu, 9 May 2019 13:30:36 +0000
Message-ID: <1557408607-25115-2-git-send-email-viorel.suman@nxp.com>
References: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1557408607-25115-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f166d46f-76b7-456c-8fbe-08d6d48284c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4029;
x-ms-traffictypediagnostic: VI1PR04MB4029:
x-microsoft-antispam-prvs: <VI1PR04MB402908C775B33C6E94D0D7E092330@VI1PR04MB4029.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(68736007)(36756003)(71200400001)(50226002)(66066001)(52116002)(2501003)(76176011)(5660300002)(8936002)(86362001)(6506007)(478600001)(71190400001)(81166006)(8676002)(386003)(81156014)(2906002)(53936002)(25786009)(4326008)(476003)(305945005)(256004)(4744005)(6512007)(99286004)(7736002)(2201001)(66476007)(66556008)(64756008)(66446008)(26005)(66946007)(73956011)(110136005)(54906003)(44832011)(11346002)(446003)(486006)(14454004)(186003)(2616005)(316002)(14444005)(3846002)(6486002)(102836004)(6116002)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4029;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ca4nsrRDZJUpXf5T/tPndGe5VfMrz07oDcNg8JAgQl7H+ygW+mxg07BEJ5izcrS6L3wZ0IqlhnSiNzPt+Ry2Tu5+zLHt7KFAVzl9pdGYf4+ZsUMVG7zigWhPBM6U7MM2pEkaDQZB0YwdNyKg6JYDcyyF9eXCdaQeYOURujRI/Og5wgruRaOAc+MITdmyM6w7wKAy4jZ89XcGgpDLHSJq1o730AYVK4K3NDTNR+i/aG1pcclSXbDyePxa01QSEsQZfLuBGuVq6x31AxZSOi0eS/+Z1AVzEuvUq2nfo81hFLvwDhsu5UsN2kYv1U1pBUNG4/FKCTpY1T2tx90bGg3XQlasl0/3cyA/Vwk4/41YFk1DSKhMwoDVRy5/+WkGcUN0WL5WzXgCWhRxYPqw2rDB8xOHgwhGi+aDc/Us1+cSe/A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f166d46f-76b7-456c-8fbe-08d6d48284c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:30:36.0804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c25kX3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMoKSBtYXkgcmV0dXJuIDEgaWYgb3BlcmF0aW9u
DQp3YXMgc3VjY2Vzc2Z1bCBhbmQgdGhlIHZhbHVlIG9mIHRoZSByZWdpc3RlciBjaGFuZ2VkLg0K
UmV0dXJuIGEgbm9uLXplcm8gaW4gYWs0NDU4X3JzdG5fY29udHJvbCBmb3IgYW4gZXJyb3Igb25s
eS4NCg0KU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29t
Pg0KU2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4NCi0t
LQ0KIHNvdW5kL3NvYy9jb2RlY3MvYWs0NDU4LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9j
b2RlY3MvYWs0NDU4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2FrNDQ1OC5jDQppbmRleCBlYWI3Yzc2
Li40Nzk1ZTMyIDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9hazQ0NTguYw0KKysrIGIv
c291bmQvc29jL2NvZGVjcy9hazQ0NTguYw0KQEAgLTMwNCw3ICszMDQsOCBAQCBzdGF0aWMgaW50
IGFrNDQ1OF9yc3RuX2NvbnRyb2woc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQs
IGludCBiaXQpDQogCQkJCQkgIEFLNDQ1OF8wMF9DT05UUk9MMSwNCiAJCQkJCSAgQUs0NDU4X1JT
VE5fTUFTSywNCiAJCQkJCSAgMHgwKTsNCi0JcmV0dXJuIHJldDsNCisJLyogUmV0dXJuIGEgbmVn
YXRpdmUgZXJyb3IgY29kZSBvbmx5LiAqLw0KKwlyZXR1cm4gKHJldCA8IDAgPyByZXQgOiAwKTsN
CiB9DQogDQogc3RhdGljIGludCBhazQ0NThfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLA0KLS0gDQoyLjcuNA0KDQo=
