Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68082173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="aaMZJeD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfH1GNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:13:52 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:50081
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfH1GNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl8Li3b3gyQ/k0Yenh8KMHClSlLQCRqkxzv/i6eihaN/NdahVbouFZ+fge+5Gd4b6VfcWcBomTw4oGsoozTEaKSfY7Keu+357kPOajBV+ddrR/Q9hG6b0Y1Rn/MsmLuMC5fthpxaZ6+Ntm4cpAjWxmnEgwnKUZpR19fFI/9TLk7pCkT1la2Niq3vMXeoveMeHNM/xu13r650EcpXKlM984nXgeNIhmprIb4wxgH0mvoqaIv8TTvdyO0gTSSmns/bV3PS1I0UEcYiz2I+vcIQtOUxB16oboaNyXxvjoaWVcXNkD6WoTarnXaIRug5F4h5qhGtCpviJCNkGyTqVWT3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/AIOm9o1w4mlhdmaFn5nkRmUJBv12NFiQq3OIo3cow=;
 b=gPIMatjq9jeDVHMr0iKeIgMHREeVhdlZGr1zV8Y0mPXorp/UipW4QpHpuQUUTUKO2Nx29FbOF/e6pNyRM1SupsyNtoEzhr6FjTXeDjMFl2Wx46VCY05410VchHnoJjTXrkYAYJq/Og4B9uAQvyAMekYsKvtFhimDXoz/aGThs/TU0Stz1wrFwZnQGGfgSG00rVc/smsxBKTe3MEGngdT9k1V9LP4jemLJiW9Kl2mRabbOFP7Ji5qYvxaIyRMd3HW9UdJS+lTwqoQhOxA+i+AXuzcgLSF9kn3caLLsQkJL1Toc/aSia5cH9XDBDFX/3PFnTJiZHUSOjjJxlZ0uY2bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/AIOm9o1w4mlhdmaFn5nkRmUJBv12NFiQq3OIo3cow=;
 b=aaMZJeD8tlZj2oEB6tqUfV2AT48CCllaxy+7qY9d5jxwiT0QNxQ/l3bckL7kTQv+mW30+mhQfduisHFSYU0lWEAjpSoGDIDe/v70fgpCJqLJ8qRXRkgw+Ft/n4USM+ISOkh5O49qliY+c4sbjw9VoNHSDd9wfJ/2GNi3jweLKgc=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:13:49 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:13:49 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 8/8] regulator: sy8824x: add SY20278 support
Thread-Topic: [PATCH v2 8/8] regulator: sy8824x: add SY20278 support
Thread-Index: AQHVXWfC1+C1w4yPtUKrjfJse6cGuA==
Date:   Wed, 28 Aug 2019 06:13:49 +0000
Message-ID: <20190828140225.3875b868@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:404:14::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0c0e4fb-b296-4411-be4c-08d72b7ee43f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB450323FCDEAF5F367B562C29EDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(4744005)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Eb544EWDNMVHaL2UnvWE7M/y9t4S6pXVMXX/MIYBPuR/stZCC6abJGikWFkpTkwD4ln5MuaZJlck+BhSSdksdqbOZLaoVT26j/jY7df36xiaqxG7DGWSbWHoxTqxuKAyIAQ+y/XeIRtFsVu/RZLNNwIGxo4PYWbIY64Cy9LeakYvE5aQu3nnrq1NuDoz78qdqlKJAhMa9/Y9V35N5qGqCLamYH0lCF4aJowzRy4U9DaoO1Mj0M4hui8Vgl/lCkpsD9W549Iq0VT4ZMjG2X7A250wxzqcc1X4Yy2wjRYJopJDvKxHIUP7aY4oJtk2WaK+0MgtnB5KnYCvLSQ/TqOKQlkMcXWKstCUSvZP0p1cRpcNtLc7NeoL9ATS9HkI1HuWWOwXQQbYbKrkQj6gcB5hhT6OPooRkI1X8SYk1MQJ1w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70E73BCDEEC9A14EB36EEBCE74780CC3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c0e4fb-b296-4411-be4c-08d72b7ee43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:13:49.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8sVIcV/SWImGWTMkCgQfXTBjpURMP2tNztVem7ECnYLPqIfbYlzC7CUIl2sHsvtGwp0DM5hQkCCxdvbK+c8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The differences between SY8824C and SY20278 are different regs
for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 10d9180a0d77..f74ee7f36d74 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -180,6 +180,15 @@ static const struct sy8824_config sy20276_cfg =3D {
 	.vsel_count =3D 128,
 };
=20
+static const struct sy8824_config sy20278_cfg =3D {
+	.vol_reg =3D 0x00,
+	.mode_reg =3D 0x01,
+	.enable_reg =3D 0x01,
+	.vsel_min =3D 762500,
+	.vsel_step =3D 12500,
+	.vsel_count =3D 64,
+};
+
 static const struct of_device_id sy8824_dt_ids[] =3D {
 	{
 		.compatible =3D "silergy,sy8824c",
@@ -193,6 +202,10 @@ static const struct of_device_id sy8824_dt_ids[] =3D {
 		.compatible =3D "silergy,sy20276",
 		.data =3D &sy20276_cfg
 	},
+	{
+		.compatible =3D "silergy,sy20278",
+		.data =3D &sy20278_cfg
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
--=20
2.23.0.rc1

