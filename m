Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E488C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCA20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+og0q+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfDXVIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:08:38 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:4030
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729032AbfDXVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+wEvndaxB2q9nE13nG+m5UVzBdo6Iso7ASKP+rwyZM=;
 b=a+og0q+28gThIAIJ4sPqVOE4j95NukOITZb4QI2KrSODqGK+nw3b/Mwfb4H/gOEsxwcg1LojDt0J2gHXoGetED73USNeqCddFAieJKSy6+JCwfxRjNqwt/Lxxe1pY5C7Btj7x5LWpHhshYOQGs6VEmz5FlKRfRYT1a4orSK1HzM=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.33.210) by
 AM6PR04MB4503.eurprd04.prod.outlook.com (20.177.37.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 21:08:33 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::ac11:250f:e99e:8fd3]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::ac11:250f:e99e:8fd3%5]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:08:33 +0000
From:   Han Xu <han.xu@nxp.com>
To:     "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
CC:     "boris.brezillon@free-electrons.com" 
        <boris.brezillon@free-electrons.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add prep/unprep for spi_nor_resume
Thread-Topic: [PATCH] mtd: spi-nor: Add prep/unprep for spi_nor_resume
Thread-Index: AQHU+uHfbtBiSaKzx0CN/OQDDONR1g==
Date:   Wed, 24 Apr 2019 21:08:33 +0000
Message-ID: <20190424210818.25205-1-han.xu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:805:2a::31) To AM6PR04MB4967.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::18)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b62abdc2-a5df-4fce-4fe6-08d6c8f9021b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4503;
x-ms-traffictypediagnostic: AM6PR04MB4503:
x-microsoft-antispam-prvs: <AM6PR04MB45032F7E6F76985F6297406E973C0@AM6PR04MB4503.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(486006)(36756003)(68736007)(2616005)(6512007)(6486002)(6506007)(476003)(386003)(73956011)(256004)(14444005)(4326008)(186003)(44832011)(66446008)(102836004)(64756008)(7736002)(66556008)(53936002)(305945005)(66476007)(25786009)(6436002)(66946007)(54906003)(5660300002)(6116002)(81166006)(8676002)(8936002)(478600001)(14454004)(99286004)(50226002)(1076003)(66066001)(26005)(86362001)(71190400001)(52116002)(2501003)(316002)(2906002)(71200400001)(3846002)(97736004)(110136005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4503;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsDWoSmcpb5dy0G5txBtKvhhAB4zl1DW/l96pxX9xT8BnLlwt/8Ov7wXRmg3KHu8ugXZhPo1cZEVVEJjnpuQf/AN4yVafvyQIjQ5nx0L+E2NcWhLwkzjIImZOuyp0aQnndqs1efkC/BbTOSYAUHEP28vJCdEnrsAsztqZuCkF/yRYSvmYxdybmgH8mbZy3Lmcgf1zMETgFBB9rzRZRaLuGUsHxketq3NtjGP4u+7uGlMnOwMX0hyRYLcXule/oOYe1OULFlT64sgvJEuU541lPyQEy6Dg+idZ5nVnE4qorhBvh0W9ZysU/qDlx1p3kH+cT4zqZlM+9tBG3xHQnehquxYzNMJDs2q/G++AP3NTGoevJAxt4OqSUH2pP3k6sCg/x3o21/iK4ouZF8G3XIU8cV/iGt+EzPuj6Id6POqKcM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62abdc2-a5df-4fce-4fe6-08d6c8f9021b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:08:33.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIG5ldyBpbXBsZW1lbnRlZCBzcGlfbm9yX3Jlc3VtZSBmdW5jdGlvbiwgdGhlIHNwaV9u
b3JfaW5pdCgpDQpzaG91bGQgYmUgYnJhY2VkIGJ5IHByZXAvdW5wcmVwIGZ1bmN0aW9ucy5fDQoN
ClNpZ25lZC1vZmYtYnk6IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+DQotLS0NCiBkcml2ZXJzL210
ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDggKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L210ZC9zcGkt
bm9yLmggICB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3Ivc3BpLW5vci5jDQppbmRleCA3MzE3MmQ3ZjUxMmIuLmY2NDkxODg1ZmE0ZiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQorKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL3NwaS1ub3IuYw0KQEAgLTM5NTYsMTAgKzM5NTYsMTggQEAgc3RhdGljIHZvaWQgc3BpX25v
cl9yZXN1bWUoc3RydWN0IG10ZF9pbmZvICptdGQpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9IG5v
ci0+ZGV2Ow0KIAlpbnQgcmV0Ow0KIA0KKwlyZXQgPSBzcGlfbm9yX2xvY2tfYW5kX3ByZXAobm9y
LCBTUElfTk9SX09QU19SRVNVTUUpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgInBy
ZXBhcmUoKSBmYWlsZWRcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQogCS8qIHJlLWluaXRpYWxp
emUgdGhlIG5vciBjaGlwICovDQogCXJldCA9IHNwaV9ub3JfaW5pdChub3IpOw0KIAlpZiAocmV0
KQ0KIAkJZGV2X2VycihkZXYsICJyZXN1bWUoKSBmYWlsZWRcbiIpOw0KKw0KKwlzcGlfbm9yX3Vu
bG9ja19hbmRfdW5wcmVwKG5vciwgU1BJX05PUl9PUFNfUkVTVU1FKTsNCiB9DQogDQogdm9pZCBz
cGlfbm9yX3Jlc3RvcmUoc3RydWN0IHNwaV9ub3IgKm5vcikNCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L210ZC9zcGktbm9yLmggYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCmluZGV4
IGIzZDM2MGIwZWUzZC4uNTBjZjcxZGQ3ZTllIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9t
dGQvc3BpLW5vci5oDQorKysgYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCkBAIC0yMzEs
NiArMjMxLDcgQEAgZW51bSBzcGlfbm9yX29wcyB7DQogCVNQSV9OT1JfT1BTX0VSQVNFLA0KIAlT
UElfTk9SX09QU19MT0NLLA0KIAlTUElfTk9SX09QU19VTkxPQ0ssDQorCVNQSV9OT1JfT1BTX1JF
U1VNRSwNCiB9Ow0KIA0KIGVudW0gc3BpX25vcl9vcHRpb25fZmxhZ3Mgew0KLS0gDQoyLjE3LjEN
Cg0K
