Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F855C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E9A2182B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ed5X/W0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfGPE3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:29:25 -0400
Received: from mail-eopbgr740052.outbound.protection.outlook.com ([40.107.74.52]:55427
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfGPE3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAzzLPTmRp6PToehzQk6nxx3x++5MjhTXBmhHVPlx8um/ky/S7RYCivSPf4XFsNs8Riuzbloy8L7VRAHYP2jx2pF5Sg3azmTJtYpKNRbTUPm6ALkbYMwlQ1qta19NyexB/nJA0mSJxG+28pwB0bd/9q7LQDDrAwcbtcg0GaKXAESbdlWLAx1XJ+iiDdQWHdDMn8sX9tZg5kz4LF/e5TDN5CKZwp7hLAJYlcux4arQHQby36JqLNJwp3RmYGdsm0hGjqJ2R2lkfAzqwKtkauev9kbvd0jCcVjLZhdlIdyn0WzM3Cc0WQIBMbcc8VwUAQWHluy+9+hJq2kEuBixcKKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JLFDDbA2n3Q/swjVGeE018zBh4aJbOcPgy2I6UrTpo=;
 b=ZZso0ixdyyDZY8lgBSfTXB0SZ+/EGD/YKpp5L/W4d4P8OjtIBnwW1N5k6ORaoodCLMaAztg8KD2ldcaMreiTKEeN5G6AzU2synL+eb0v9u6j0uR++jB0MrJkJ+wPckbsGJQvO/bY3jkCGWVv1ZVymgMvEauBuQwsoDdfdso6sSCp1+0OjU1sdP5A1I6SH3w/70xIEsBmNFBxkaxMcDpOF+sgUbAylF1KJkETB3IqOeOpymQ3n56HlrwOKoTzMM5z99PfYXjOCB9IGtgfEFcsvSDtsneWUJm1nczsjAbmcJvlGanAGtEUsQNl9WIZEbAwcoRV5G8G4qEsh67CBi4uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JLFDDbA2n3Q/swjVGeE018zBh4aJbOcPgy2I6UrTpo=;
 b=Ed5X/W0W02MGQR/OFkuKtMcYJb/SWG3jOuiEXlKE3zbm5yX3lU1OTIUg2E/YTLG/CByfvAMk8r1H80bayb0j2bjTcJRlLzaCvHS+moGAwVJ/TfUddofSJyN2NJckUXr6XPHu5qEcXwDSVlkmPqg8nRolFo4XX3pN5VNto8U6lF4=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3513.namprd12.prod.outlook.com (20.179.106.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Tue, 16 Jul 2019 04:29:16 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 04:29:16 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Topic: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Index: AQHVO48Hx/kfNidzeESmMCe8zpPtAw==
Date:   Tue, 16 Jul 2019 04:29:16 +0000
Message-ID: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.78.1]
x-clientproxiedby: SN4PR0501CA0018.namprd05.prod.outlook.com
 (2603:10b6:803:40::31) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac88e62b-1451-4e2a-9019-08d709a6299a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3513;
x-ms-traffictypediagnostic: DM6PR12MB3513:
x-microsoft-antispam-prvs: <DM6PR12MB3513D234D6D42D5F383EC095F3CE0@DM6PR12MB3513.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(86362001)(316002)(7736002)(110136005)(81166006)(8936002)(6486002)(81156014)(5660300002)(50226002)(2906002)(6512007)(66946007)(4326008)(54906003)(6436002)(25786009)(64756008)(66556008)(8676002)(4720700003)(386003)(26005)(102836004)(66446008)(6116002)(6506007)(476003)(2501003)(14444005)(256004)(99286004)(3846002)(2616005)(486006)(71190400001)(36756003)(305945005)(53936002)(14454004)(66066001)(66476007)(71200400001)(52116002)(478600001)(186003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3513;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V1YNTyRfLF9As29T0fnAuYRMxLeAKf9OhRNTo8tm34JITnzg4tI/mV7RxGQEUdQWGoTe/+wTJkFKR/Mo+kcqHzRmkDJuzyvwgLix32KCNCgZSebQRyKHDPXejR7K0WjapokCxJQRy9hwhLMeCx0smsIWvI8GknV/TjIPpGmETDe7PG6Ts9wQKXCnGgAAUODCDWGSngpJlnFZZR9Moq3a3AlYfKuRNKyw5JMGypqcm1CBjAZQbPsRHESBmvQgeIdIi5lZhJ+623WIfECiQT/9VAwAcTlGj0c1XxuBQRBGP6iSEyjvXMvpmLBLOspqHYgZkDPeS9JrV/byFZRKz1X6WmLUjiKTrsJQGbHih4b1HFGBSOqoa5bWuhaXNpgWKXdRrdT5p43k9UJXCA7bHcK2dk6qdje8v4Tr8yf6jskl5pM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac88e62b-1451-4e2a-9019-08d709a6299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 04:29:16.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IOMMU requires IntCapXT registers to be setup in order to generate
its own interrupts (for Event Log, PPR Log, and GA Log) with 32-bit
APIC destination ID. Without this support, AMD IOMMU MSI interrupts
will not be routed correctly when booting the system in X2APIC mode.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c  | 90 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/iommu/amd_iommu_types.h |  9 +++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.=
c
index ff40ba7..a4c5b1e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -35,6 +35,8 @@
 #include <linux/mem_encrypt.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
+#include <asm/apic.h>
+#include <asm/msidef.h>
 #include <asm/gart.h>
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
@@ -1935,6 +1937,90 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	return 0;
 }
=20
+#define XT_INT_DEST_MODE(x)	(((x) & 0x1ULL) << 2)
+#define XT_INT_DEST_LO(x)	(((x) & 0xFFFFFFULL) << 8)
+#define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
+#define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
+
+/**
+ * Setup the IntCapXT registers with interrupt routing information
+ * based on the PCI MSI capability block registers, accessed via
+ * MMIO MSI address low/hi and MSI data registers.
+ */
+static void iommu_update_intcapxt(struct amd_iommu *iommu)
+{
+	u64 val;
+	u32 addr_lo =3D readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
+	u32 addr_hi =3D readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
+	u32 data    =3D readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
+	bool dm     =3D (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
+	u32 dest    =3D ((addr_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xFF);
+
+	if (x2apic_enabled())
+		dest |=3D MSI_ADDR_EXT_DEST_ID(addr_hi);
+
+	val =3D XT_INT_VEC(data & 0xFF) |
+	      XT_INT_DEST_MODE(dm) |
+	      XT_INT_DEST_LO(dest) |
+	      XT_INT_DEST_HI(dest);
+
+	/**
+	 * Current IOMMU implemtation uses the same IRQ for all
+	 * 3 IOMMU interrupts.
+	 */
+	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+}
+
+static void _irq_notifier_notify(struct irq_affinity_notify *notify,
+				 const cpumask_t *mask)
+{
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu) {
+		if (iommu->dev->irq =3D=3D notify->irq) {
+			iommu_update_intcapxt(iommu);
+			break;
+		}
+	}
+}
+
+static void _irq_notifier_release(struct kref *ref)
+{
+}
+
+static int iommu_init_intcapxt(struct amd_iommu *iommu)
+{
+	int ret;
+	struct irq_affinity_notify *notify =3D &iommu->intcapxt_notify;
+
+	/**
+	 * IntCapXT requires XTSup=3D1, which can be inferred
+	 * amd_iommu_xt_mode.
+	 */
+	if (amd_iommu_xt_mode !=3D IRQ_REMAP_X2APIC_MODE)
+		return 0;
+
+	/**
+	 * Also, we need to setup notifier to update the IntCapXT registers
+	 * whenever the irq affinity is changed from user-space.
+	 */
+	notify->irq =3D iommu->dev->irq;
+	notify->notify =3D _irq_notifier_notify,
+	notify->release =3D _irq_notifier_release,
+	ret =3D irq_set_affinity_notifier(iommu->dev->irq, notify);
+	if (ret) {
+		pr_err("Failed to register irq affinity notifier (devid=3D%#x, irq %d)\n=
",
+		       iommu->devid, iommu->dev->irq);
+		return ret;
+	}
+
+	iommu_update_intcapxt(iommu);
+	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
+	return ret;
+}
+
 static int iommu_init_msi(struct amd_iommu *iommu)
 {
 	int ret;
@@ -1951,6 +2037,10 @@ static int iommu_init_msi(struct amd_iommu *iommu)
 		return ret;
=20
 enable_faults:
+	ret =3D iommu_init_intcapxt(iommu);
+	if (ret)
+		return ret;
+
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
=20
 	if (iommu->ppr_log !=3D NULL)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index 87965e4..39be804f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -72,6 +72,12 @@
 #define MMIO_PPR_LOG_OFFSET	0x0038
 #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
 #define MMIO_GA_LOG_TAIL_OFFSET	0x00e8
+#define MMIO_MSI_ADDR_LO_OFFSET	0x015C
+#define MMIO_MSI_ADDR_HI_OFFSET	0x0160
+#define MMIO_MSI_DATA_OFFSET	0x0164
+#define MMIO_INTCAPXT_EVT_OFFSET	0x0170
+#define MMIO_INTCAPXT_PPR_OFFSET	0x0178
+#define MMIO_INTCAPXT_GALOG_OFFSET	0x0180
 #define MMIO_CMD_HEAD_OFFSET	0x2000
 #define MMIO_CMD_TAIL_OFFSET	0x2008
 #define MMIO_EVT_HEAD_OFFSET	0x2010
@@ -162,6 +168,7 @@
 #define CONTROL_GALOG_EN        0x1CULL
 #define CONTROL_GAINT_EN        0x1DULL
 #define CONTROL_XT_EN           0x32ULL
+#define CONTROL_INTCAPXT_EN     0x33ULL
=20
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
 #define CTRL_INV_TO_NONE	0
@@ -604,6 +611,8 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 #endif
+	/* IRQ notifier for IntCapXT interrupt */
+	struct irq_affinity_notify intcapxt_notify;
 };
=20
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
--=20
1.8.3.1

