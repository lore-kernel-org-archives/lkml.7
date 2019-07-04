Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0EC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B0F216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NZvnV8sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGDGTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:19:01 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:20706
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMSmMOdtH3y6BovOloPIjE3DVQTNjALu3Ub4HyRnkcc=;
 b=NZvnV8sz4D/vQ+Mqunb900orfOsmCmpcXuQUPhCEmWSAE3D2Ch1Ag/fT9B5Rj96Ejg7vAmK9ZfpLF3QWuUo+YBfMOSB9p10X2w+fCxaBSJQ62dbhJ7noO3ftio0C9WGc094qRVzzMnIH6vkSceKnB7ckfgSGKw9GaAqpUX5nhG8=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 06:18:56 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:18:56 +0000
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
Thread-Index: AQHVMjBc6ENIwv9q1EWZDI2YhrNJoA==
Date:   Thu, 4 Jul 2019 06:18:56 +0000
Message-ID: <20190704061717.6854-7-james.qian.wang@arm.com>
References: <20190704061717.6854-1-james.qian.wang@arm.com>
In-Reply-To: <20190704061717.6854-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f96b871c-6a22-453b-4a7f-08d700477e83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
x-microsoft-antispam-prvs: <VE1PR08MB463712610ED53E45E0BFD0A6B3FA0@VE1PR08MB4637.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(99286004)(110136005)(14444005)(36756003)(68736007)(256004)(52116002)(102836004)(26005)(386003)(55236004)(3846002)(6116002)(6506007)(8676002)(5660300002)(103116003)(486006)(2906002)(54906003)(76176011)(2501003)(186003)(6436002)(81156014)(81166006)(2201001)(476003)(71200400001)(86362001)(305945005)(446003)(7736002)(11346002)(8936002)(478600001)(2616005)(6486002)(66476007)(64756008)(66066001)(66946007)(4326008)(53936002)(50226002)(66446008)(14454004)(316002)(73956011)(66556008)(71190400001)(6512007)(1076003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jIX8ZIKNtu87K4PrvPEL/fsdEWeQUU1UEudBhvi71+CxrrmLtxBi3JhcnUsqVosUiJwilj4/wPT5bbWW69Dnloh6rxizkhiRRMClix4ktcZ9rVlW5/fRu6wx0KfPd5vKNOvufSqhk7Ig2iMegB/drZR0/5td3kjlAuALNzGb7J9oBilNK30Ct9CHPpP6DBSAEXgm/q0WJjx1Jj08TBles9DacQfKQgmg+n4Yu71WYUMZEAMAsFhNdy5U/9VHhZCnvAvassybLkr30I99Oz8nxqdl5mA5SaAcNZFwqKoOzdT/zf5JIOe4v7m/lkdRfB/2d5Gcu2JCibB1LcA874vvlXxTAHHO43FEjnG4EI14RMtWy1d/ELXzH27WzGLvFJnmOJh10XR/Uq8HlPtdho5KsdkuqkH5EyYKYXeLOVhJ3BI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96b871c-6a22-453b-4a7f-08d700477e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:18:56.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4637
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
