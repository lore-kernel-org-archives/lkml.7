Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87982C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516C321479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J/u3pHBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfIORIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:08:38 -0400
Received: from mail-eopbgr790074.outbound.protection.outlook.com ([40.107.79.74]:14896
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfIORIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGew9d5vyFaaLCCujUOmKLy1BcHicVEuADswNLvdFm8qBe7DGBmggkVH8WPfAHtk1GoBD51J7477X5mR6bcPhAKiMcRzkfP7rBYtQ+0q+Xrlgn0NsbsIT04hmFZufe2GgEBuGgwCO4RwdoBfBH9zZdDx7nJhN027cJ90He1FVwgIX/7wc0Pnro3IpfC2emW9pib/C4Ds5XZadHyaWM37BWGSTU7Gy2L2lolM7YTj3trzlbITG5lkz6cO2xZxGCxNEWpHxHYD+t6c+j2B4pau/DTWBsjZfXYhRRDMx/0S3td1DUec1Pn2iFtNxpUsduTrBA9vFdT9K/8mj44R5zytdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqZVAMZ+RjzyFLGAEX3hXjrzDB6SOb595bQZhQ7ckFA=;
 b=cm9yw8AoaGn7G0Bx9hbaNIiy4a0T1hqxuEHN1zdTIqMm7gFoWxp+pfZCt2b4J8FeIXSceTZ13KEiAITiH6BKfP9s5qHIkm37Q/Qn7nEHO8JpwkMcSXZWq3g1NwvFNtbQ7ecufraKgEeW0QTL+uI7OrnGEXxdbIzo948Nf8VkDFMyKWch+NURo1FKycAwoTEEcI3geN3Iu3/K94Ff00KUexl07ZR/tVwZtC5QgkH0Jr+91QWlXkBf5GTHTbkuEsCdvlhoT10youpORC8w9VH9hrmQldKcDfmWNFxJYBQ+qm0GyPAEaY/eUTWo/MzTSRomIWsHHojIrDwA234QLTPSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqZVAMZ+RjzyFLGAEX3hXjrzDB6SOb595bQZhQ7ckFA=;
 b=J/u3pHBoXAhtZMCLxF0JgkKos4ySvAz3j40trYOjBU93GwSda77DJeYkTKNWEaRLjijCghkVNxySP+Wip8ebVQsZBAUL/6TRs4LYVlcQ43r4eCzn3oHaIXa52yu2sscdlgGdTciTNyw0p8NTI1XOfi+FRUAmMqCEctdIHYf8iWA=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Sun, 15 Sep 2019 17:08:35 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::ec02:b95d:560a:ad36%7]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019
 17:08:35 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 2/2] ntb_hw_amd: Add memory window support for new AMD
 hardware
Thread-Topic: [PATCH 2/2] ntb_hw_amd: Add memory window support for new AMD
 hardware
Thread-Index: AQHVa+g1U8wnuc3ADUCHbHDfjwwgYQ==
Date:   Sun, 15 Sep 2019 17:08:35 +0000
Message-ID: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2babc224-bd83-4a94-45bc-08d739ff5800
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR12MB3309;
x-ms-traffictypediagnostic: MN2PR12MB3309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3309961E66F82F9B052208DDE58D0@MN2PR12MB3309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(66476007)(66556008)(6436002)(36756003)(64756008)(66446008)(66946007)(7736002)(2616005)(186003)(2906002)(305945005)(14454004)(3846002)(6116002)(316002)(26005)(86362001)(2201001)(8676002)(50226002)(8936002)(81166006)(25786009)(81156014)(2501003)(71200400001)(476003)(71190400001)(54906003)(102836004)(110136005)(66066001)(6486002)(478600001)(5660300002)(486006)(6512007)(4326008)(6506007)(256004)(386003)(53936002)(99286004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3309;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oAYdD+lf+mWt6z8ksLPG9uZxaUgnG0u4Y/NcrGeJZkDiuIGOOYja2bhC8aEw+tJGDV/2G57y1evrsEbky5u6hpUuecTVzkpBKCFGgjfi3zVHuJHJBA6+fGTDgT11DH+nWBhO3gx9vfv3p7l31ie6pGaAPHOUQFgdiyc2KBseC1zs9OWQyn+bLlLDEf09rPbyjWuMQtnP0f5hscqxWTNgzyD9jGlJOtwuouKXxb6ZrSyBdF6/7IkhFZYAi5/eud5e3ZmDo65A8GwHzZM1r7IfAFCXBDS2EJ/8/E6RdxTQdg1k4w4YHA8xK6/DaDu/LlBHRMlsbvVOOkAWAFhpe3JqFq1hNn22C3wVICwx6L06E4LyU+w374FjztygbGqoHplj+fegfYMkxAlp0jzs7lZwhNvI2wRh1H5/fAM6enF1Npc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2babc224-bd83-4a94-45bc-08d739ff5800
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 17:08:35.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVgkaqtJ6VWQ9zEWKoqA/2o6ZJMvLOnurLgBvml+EkieJLw0PMyCHmeh3JG6Y5wB/cQjJyvzbGmM5PcdW/sO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

The AMD new hardware uses BAR23 and BAR45 as memory windows
as compared to previos where BAR1, BAR23 and BAR45 is used
for memory windows.

This patch add support for both AMD hardwares.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 23 ++++++++++++++++++-----
 drivers/ntb/hw/amd/ntb_hw_amd.h |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index e9286cf..156c2a1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -78,7 +78,7 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int i=
dx)
 	if (idx < 0 || idx > ndev->mw_count)
 		return -EINVAL;
=20
-	return 1 << idx;
+	return ndev->dev_data->mw_idx << idx;
 }
=20
 static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
@@ -909,7 +909,7 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio =3D ndev->self_mmio;
=20
-	ndev->mw_count =3D AMD_MW_CNT;
+	ndev->mw_count =3D ndev->dev_data->mw_count;
 	ndev->spad_count =3D AMD_SPADS_CNT;
 	ndev->db_count =3D AMD_DB_CNT;
=20
@@ -1069,6 +1069,8 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
 		goto err_ndev;
 	}
=20
+	ndev->dev_data =3D (struct ntb_dev_data *)id->driver_data;
+
 	ndev_init_struct(ndev, pdev);
=20
 	rc =3D amd_ntb_init_pci(ndev, pdev);
@@ -1123,10 +1125,21 @@ static const struct file_operations amd_ntb_debugfs=
_info =3D {
 	.read =3D ndev_debugfs_read,
 };
=20
+static const struct ntb_dev_data dev_data[] =3D {
+	{ /* for device 145b */
+		.mw_count =3D 3,
+		.mw_idx =3D 1,
+	},
+	{ /* for device 148b */
+		.mw_count =3D 2,
+		.mw_idx =3D 2,
+	},
+};
+
 static const struct pci_device_id amd_ntb_pci_tbl[] =3D {
-	{PCI_VDEVICE(AMD, 0x145b)},
-	{PCI_VDEVICE(AMD, 0x148b)},
-	{0}
+	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
+	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
=20
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_am=
d.h
index 3aac994..139a307 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -92,7 +92,6 @@ static inline void _write64(u64 val, void __iomem *mmio)
=20
 enum {
 	/* AMD NTB Capability */
-	AMD_MW_CNT		=3D 3,
 	AMD_DB_CNT		=3D 16,
 	AMD_MSIX_VECTOR_CNT	=3D 24,
 	AMD_SPADS_CNT		=3D 16,
@@ -169,6 +168,11 @@ enum {
 	AMD_PEER_OFFSET		=3D 0x400,
 };
=20
+struct ntb_dev_data {
+	const unsigned char mw_count;
+	const unsigned int mw_idx;
+};
+
 struct amd_ntb_dev;
=20
 struct amd_ntb_vec {
@@ -184,6 +188,7 @@ struct amd_ntb_dev {
 	u32 cntl_sta;
 	u32 peer_sta;
=20
+	struct ntb_dev_data *dev_data;
 	unsigned char mw_count;
 	unsigned char spad_count;
 	unsigned char db_count;
--=20
2.7.4

