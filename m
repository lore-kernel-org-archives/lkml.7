Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84473C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E9206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7HLeJqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfDVTCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:02:35 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:10116
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbfDVTCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+RN83TExktH1D3DkBWK6UmuXPpvxogMg1Wv5ShCbrs=;
 b=a7HLeJqeWXNEnTaMMkVr2b+rMZYfcSQ6tgR/XGoIBnJKpMthuBKpbKLaPmKIBSg5UF+JlX2eZ4sLM4A+k8+K2TlD5aZN36lgtok46xWKsnHRsxFNdATOvs3AECZY/DkQtoH5cAwcfZkZaNUOzdGH8W8qOMxPyAFtcZdyXomb/00=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2815.eurprd04.prod.outlook.com (10.172.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Mon, 22 Apr 2019 19:02:28 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:02:28 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 1/3] ASoC: fsl_sai: Update is_slave_mode with correct value
Thread-Topic: [PATCH v3 1/3] ASoC: fsl_sai: Update is_slave_mode with correct
 value
Thread-Index: AQHU+T3ucLYQo18Ixk+PfyeYLkOx6w==
Date:   Mon, 22 Apr 2019 19:02:28 +0000
Message-ID: <20190422190213.30726-2-daniel.baluta@nxp.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com>
In-Reply-To: <20190422190213.30726-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 872b39ab-a166-4476-b324-08d6c755105d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2815;
x-ms-traffictypediagnostic: VI1PR0402MB2815:
x-microsoft-antispam-prvs: <VI1PR0402MB28159E6F95465E670E8E24C0F9220@VI1PR0402MB2815.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(2906002)(6512007)(53936002)(7736002)(305945005)(316002)(386003)(6506007)(99286004)(102836004)(52116002)(186003)(76176011)(8936002)(54906003)(50226002)(26005)(25786009)(4326008)(66066001)(8676002)(36756003)(6116002)(3846002)(6916009)(2501003)(81166006)(1730700003)(81156014)(68736007)(2351001)(5640700003)(14454004)(478600001)(71190400001)(64756008)(6486002)(66446008)(5660300002)(66556008)(97736004)(2616005)(476003)(44832011)(446003)(256004)(11346002)(86362001)(66476007)(73956011)(66946007)(6436002)(7416002)(486006)(1076003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2815;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tfDIJ2Eu85Z6S6ewrO56aZNo9taPM9byJhbV9ohGxzDECd0FaqJ2u/i/sLBZZoF+NF83g1AD+Yulpom1fXBmOdFf7CeS1RfS5RAQb5yGJdewaLvqQSk4q7ae5RCptpo2oHaDErZLF/V9+p0wZs/p4dvzFzcn/k+L1eraQA3kR6ScTayh+dY7fLe8suFMccPz/riTF6OsHzpLziKVf3dg2o9NJlWs6k16Oy2x1D65Ix1Weoaq9xNboJXW9IEYZWcvosxTeAuiItwP1D+HhN/P7yF0DvOW8dKLQXi+Epk+SDEoAM5iR5kcZDfmQTPkij26Av0mTKDxEqtuU5Aft9uNlUs1pe4MeqtUWuLM/6WUnHhhVF6g69OFGisW3NPSvu123u0fLF/D+npBWVorxvg4ky2IpPO5CWOl3vkEnaXZ1WE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872b39ab-a166-4476-b324-08d6c755105d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:02:28.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aXNfc2xhdmVfbW9kZSBkZWZhdWx0cyB0byBmYWxzZSBiZWNhdXNlIHNhaSBzdHJ1Y3R1cmUNCnRo
YXQgY29udGFpbnMgaXQgaXMga3phbGxvYydlZC4NCg0KQW55aG93LCBpZiB3ZSBkZWNpZGUgdG8g
c2V0IHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbg0KU0FJIHNsYXZlIC0+IFNBSSBtYXN0ZXIs
IGlzX3NsYXZlX21vZGUgd2lsbCByZW1haW4gc2V0IG9uIHRydWUNCmFsdG91Z2ggU0FJIGJlaW5n
IG1hc3RlciBpdCBzaG91bGQgYmUgc2V0IHRvIGZhbHNlLg0KDQpGaXggdGhpcyBieSB1cGRhdGlu
ZyBpc19zbGF2ZV9tb2RlIGZvciBlYWNoIGNhbGwgb2YNCmZzbF9zYWlfc2V0X2RhaV9mbXQuDQoN
ClNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCkFj
a2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+DQotLS0NCiBzb3Vu
ZC9zb2MvZnNsL2ZzbF9zYWkuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2ZzbF9zYWkuYyBiL3NvdW5kL3NvYy9m
c2wvZnNsX3NhaS5jDQppbmRleCBiNTYzMDA0ZmI4OWYuLmQ5ZGY5ODk3NWNmOCAxMDA2NDQNCi0t
LSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQorKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9zYWku
Yw0KQEAgLTI2OCwxMiArMjY4LDE0IEBAIHN0YXRpYyBpbnQgZnNsX3NhaV9zZXRfZGFpX2ZtdF90
cihzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWksDQogCWNhc2UgU05EX1NPQ19EQUlGTVRfQ0JT
X0NGUzoNCiAJCXZhbF9jcjIgfD0gRlNMX1NBSV9DUjJfQkNEX01TVFI7DQogCQl2YWxfY3I0IHw9
IEZTTF9TQUlfQ1I0X0ZTRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9tb2RlID0gZmFsc2U7DQog
CQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOg0KIAkJc2FpLT5pc19zbGF2
ZV9tb2RlID0gdHJ1ZTsNCiAJCWJyZWFrOw0KIAljYXNlIFNORF9TT0NfREFJRk1UX0NCU19DRk06
DQogCQl2YWxfY3IyIHw9IEZTTF9TQUlfQ1IyX0JDRF9NU1RSOw0KKwkJc2FpLT5pc19zbGF2ZV9t
b2RlID0gZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZTOg0K
IAkJdmFsX2NyNCB8PSBGU0xfU0FJX0NSNF9GU0RfTVNUUjsNCi0tIA0KMi4xNy4xDQoNCg==
