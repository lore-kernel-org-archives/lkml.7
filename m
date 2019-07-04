Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8FC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36172189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IZn9iDkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfGDGba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:31:30 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:20867
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMSmMOdtH3y6BovOloPIjE3DVQTNjALu3Ub4HyRnkcc=;
 b=IZn9iDkXNIcwxSevMbNMF8fu1wBBEgQp94j1X0trf544ET5/Y79VnP3JtntgQv9GCzM15m2awpwKiLFmINaU02HJw6L2z3YFlz1A9zxi2CRlHF6wQP6Ssue0TqRrsKYk49CtsSmVgSshaN0uyhfBHh1SinPu2zyvAlpzhJjhsC8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.112.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:31:24 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:31:24 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Thread-Topic: [PATCH 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Thread-Index: AQHVMjIaGnajnYeuekiJOo4o9cpOkg==
Date:   Thu, 4 Jul 2019 06:31:24 +0000
Message-ID: <20190704063011.7431-7-james.qian.wang@arm.com>
References: <20190704063011.7431-1-james.qian.wang@arm.com>
In-Reply-To: <20190704063011.7431-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc62f858-3051-4a93-6c41-08d700493c8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4799;
x-ms-traffictypediagnostic: VE1PR08MB4799:
x-microsoft-antispam-prvs: <VE1PR08MB47999218BA74FF3A59B3178CB3FA0@VE1PR08MB4799.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(14444005)(256004)(305945005)(8936002)(4326008)(99286004)(36756003)(110136005)(2616005)(486006)(2501003)(5660300002)(2906002)(316002)(3846002)(50226002)(1076003)(102836004)(26005)(55236004)(6116002)(66066001)(446003)(11346002)(52116002)(476003)(7736002)(66946007)(76176011)(66446008)(54906003)(66476007)(73956011)(386003)(64756008)(68736007)(66556008)(6506007)(6486002)(103116003)(186003)(53936002)(478600001)(25786009)(86362001)(6436002)(2201001)(6512007)(14454004)(81156014)(81166006)(8676002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S0DVrIP2OgRZz/J5rYtUKMKRLZQ59THAOvHNfb9rGnYTk8UGH0Sd6UMPyO1kvf5+1A9EiR1ktNCQYd06eo3UEhhFNXk6Na2xluqF5KYMvr24jlHFN7iv8a6vdtnXHW019HCP0ZqO1kGgp8WJ3Gd6DiKnula6J35jugX/kOJPVL2N8GJhQIprOp2oosHx5oDghjvx9N4Q/d/wKV7DflGhnhYk3Hu/o3uAoY+VuFWRud4vMNpTpz/l0AFQl3E76OlddSlgBqXeDtqY6zNUfyIeDmETgaPTxVpRDxT/KnpghYVN08jYFaAG46fl5yKbpyTEEAmjdvULONpl5/UyStsptgyZQQ3l3d0nrqh6NCjK6BYarv2QOsDzB+gS3QUFd01aYl+ZIlM4vmph+wrwLWyTijIDnxNVfw/k9zqZoROben8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc62f858-3051-4a93-6c41-08d700493c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:31:24.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some restrictions if HW works on side_by_side, expose it by
config_id to user for taking care them.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/include/malidp_product.h | 3 ++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers=
/gpu/drm/arm/display/include/malidp_product.h
index 1053b11352eb..96e2e4016250 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_product.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
@@ -27,7 +27,8 @@ union komeda_config_id {
 			n_scalers:2, /* number of scalers per pipeline */
 			n_layers:3, /* number of layers per pipeline */
 			n_richs:3, /* number of rich layers per pipeline */
-			reserved_bits:6;
+			side_by_side:1, /* if HW works on side_by_side mode */
+			reserved_bits:5;
 	};
 	__u32 value;
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 2aee735a683f..0fc7b9f6f649 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -82,6 +82,7 @@ config_id_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
 	memset(&config_id, 0, sizeof(config_id));

 	config_id.max_line_sz =3D pipe->layers[0]->hsize_in.end;
+	config_id.side_by_side =3D mdev->side_by_side;
 	config_id.n_pipelines =3D mdev->n_pipelines;
 	config_id.n_scalers =3D pipe->n_scalers;
 	config_id.n_layers =3D pipe->n_layers;
--
2.20.1
