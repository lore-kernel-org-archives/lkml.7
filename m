Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C98C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B43A20850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C5UlVygj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GrKb2FLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfCUJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:47:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33279 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553161667; x=1584697667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w4dVKfN5ZmXiG15CA3JMTgfloONM1rxnpuZsSQQesj8=;
  b=C5UlVygjoZ3aw8fqDylNg2N6N3AmesARTBPqSASiso8C53rE8dc5nOI0
   PJWwhJiFsnCLHUkVdDO1BuzZ9WtG/hL/l6uVHIkn5TZko098dfgiLLUT7
   3sWyhvHlkfX0zhF6GO6qtxTEpijd8o3PySo8mv+VQVpThDkKMvcl+EiYU
   0aab/+ilZNvUF11OLZk/IoyUNqkaZ4RQfH8ZGZKLqnKOP+svucrb8HF4Y
   z4kfJjDgaBPW7KSozc8L0WTDb+UoV2Vn/JFNS1rJDo2UmDKJ7NgVvzgRl
   4bS94ULoyesqc68yTy/fM9OkMj01uJtF5hJl01hyAt+P3oaNkrsnPXJRN
   w==;
X-IronPort-AV: E=Sophos;i="5.60,252,1549900800"; 
   d="scan'208";a="105647550"
Received: from mail-by2nam05lp2050.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.50])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 17:47:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5TIGr+xISzJZCK8B6VvVozLxUD4U89lHpLv+XA3rBM=;
 b=GrKb2FLfO2z/qnl3SiaNik/Vdi+taUNTwrp1gd4PDJtqWA0LkSRsXn9u0kDtf6ggr1A9HsS5AbTPdjaK8+xcnRWOhJFWLpay5Ynj+Q1QrWMiZNX4lgxvDVYSGGqGl163l2TGNL2woVbhoOQ4qdEhhnmOEq1CI7jDqPC4H9YbIDo=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5757.namprd04.prod.outlook.com (20.179.21.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 09:47:43 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:47:43 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 1/5] RISC-V: Add separate defconfig for 32bit systems
Thread-Topic: [PATCH v2 1/5] RISC-V: Add separate defconfig for 32bit systems
Thread-Index: AQHU38shr0lS/xpi+k6cJOWF2UHeng==
Date:   Thu, 21 Mar 2019 09:47:43 +0000
Message-ID: <20190321094710.16552-2-anup.patel@wdc.com>
References: <20190321094710.16552-1-anup.patel@wdc.com>
In-Reply-To: <20190321094710.16552-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b75087-114d-4b85-8c30-08d6ade243b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5757;
x-ms-traffictypediagnostic: MN2PR04MB5757:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5757835F9CF3F5B3E90C18438D420@MN2PR04MB5757.namprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(54906003)(1076003)(68736007)(110136005)(316002)(6436002)(81166006)(2906002)(78486014)(8936002)(66574012)(5660300002)(25786009)(50226002)(6486002)(52116002)(102836004)(6506007)(36756003)(386003)(26005)(9456002)(186003)(76176011)(97736004)(99286004)(11346002)(446003)(476003)(486006)(2616005)(44832011)(81156014)(105586002)(14454004)(4326008)(72206003)(14444005)(106356001)(256004)(86362001)(55236004)(6512007)(71190400001)(7736002)(71200400001)(66066001)(3846002)(478600001)(305945005)(6116002)(53936002)(2171002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5757;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sxwMIfO2PXIXFu6EtTE7ykI1eJjQ7nvhWI8oxWMXqp+8A5BWa4IjpbK/f7K/ZFPetbOboS04BFRC/YWIIhAZplAypWhr02j+nEWsuz4vKbeZuHSLnWIHawegHsuGQKv23cMrFRD1h7lBSmZzF6hmxSYdLTcnbLiqeGlw6q86kzJs5gxghsmi4s6+mxW36chHWA6ZUDYsNE3oCOOtPUElKJO9k1quo34L+veY8xV2B5+6RPHyZQTzJQ5Pihbnp0Qce7arCYJFMN7SDqCs/FTzPoHbznJCRuvorHJ/nDw7EaHVIhzVHGJzj6n5d0j4p84YOtoxW0Bx1EJo++G0dg6gr6nvOGgMlBxueVpfpWk+0pirsxFeGMqZZQ76qVvsP3jVTfp08ZKqQPBMwMOGs7oi5wyQTVoukXA86sANCgEQofA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b75087-114d-4b85-8c30-08d6ade243b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:47:43.2514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds rv32_defconfig for 32bit systems. The only
difference between rv32_defconfig and defconfig is that
rv32_defconfig has  CONFIG_ARCH_RV32I=3Dy.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/configs/rv32_defconfig | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/riscv/configs/rv32_defconfig

diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
new file mode 100644
index 000000000000..1a911ed8e772
--- /dev/null
+++ b/arch/riscv/configs/rv32_defconfig
@@ -0,0 +1,84 @@
+CONFIG_SYSVIPC=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_CGROUPS=3Dy
+CONFIG_CGROUP_SCHED=3Dy
+CONFIG_CFS_BANDWIDTH=3Dy
+CONFIG_CGROUP_BPF=3Dy
+CONFIG_NAMESPACES=3Dy
+CONFIG_USER_NS=3Dy
+CONFIG_CHECKPOINT_RESTORE=3Dy
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_EXPERT=3Dy
+CONFIG_BPF_SYSCALL=3Dy
+CONFIG_ARCH_RV32I=3Dy
+CONFIG_SMP=3Dy
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+CONFIG_NET=3Dy
+CONFIG_PACKET=3Dy
+CONFIG_UNIX=3Dy
+CONFIG_INET=3Dy
+CONFIG_IP_MULTICAST=3Dy
+CONFIG_IP_ADVANCED_ROUTER=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
+CONFIG_IP_PNP_RARP=3Dy
+CONFIG_NETLINK_DIAG=3Dy
+CONFIG_PCI=3Dy
+CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCI_HOST_GENERIC=3Dy
+CONFIG_PCIE_XILINX=3Dy
+CONFIG_DEVTMPFS=3Dy
+CONFIG_BLK_DEV_LOOP=3Dy
+CONFIG_VIRTIO_BLK=3Dy
+CONFIG_BLK_DEV_SD=3Dy
+CONFIG_BLK_DEV_SR=3Dy
+CONFIG_ATA=3Dy
+CONFIG_SATA_AHCI=3Dy
+CONFIG_SATA_AHCI_PLATFORM=3Dy
+CONFIG_NETDEVICES=3Dy
+CONFIG_VIRTIO_NET=3Dy
+CONFIG_MACB=3Dy
+CONFIG_E1000E=3Dy
+CONFIG_R8169=3Dy
+CONFIG_MICROSEMI_PHY=3Dy
+CONFIG_INPUT_MOUSEDEV=3Dy
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+CONFIG_SERIAL_OF_PLATFORM=3Dy
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
+CONFIG_HVC_RISCV_SBI=3Dy
+# CONFIG_PTP_1588_CLOCK is not set
+CONFIG_DRM=3Dy
+CONFIG_DRM_RADEON=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE=3Dy
+CONFIG_USB=3Dy
+CONFIG_USB_XHCI_HCD=3Dy
+CONFIG_USB_XHCI_PLATFORM=3Dy
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
+CONFIG_USB_OHCI_HCD=3Dy
+CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
+CONFIG_USB_STORAGE=3Dy
+CONFIG_USB_UAS=3Dy
+CONFIG_VIRTIO_MMIO=3Dy
+CONFIG_SIFIVE_PLIC=3Dy
+CONFIG_EXT4_FS=3Dy
+CONFIG_EXT4_FS_POSIX_ACL=3Dy
+CONFIG_AUTOFS4_FS=3Dy
+CONFIG_MSDOS_FS=3Dy
+CONFIG_VFAT_FS=3Dy
+CONFIG_TMPFS=3Dy
+CONFIG_TMPFS_POSIX_ACL=3Dy
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V4=3Dy
+CONFIG_NFS_V4_1=3Dy
+CONFIG_NFS_V4_2=3Dy
+CONFIG_ROOT_NFS=3Dy
+CONFIG_CRYPTO_USER_API_HASH=3Dy
+CONFIG_CRYPTO_DEV_VIRTIO=3Dy
+CONFIG_PRINTK_TIME=3Dy
+# CONFIG_RCU_TRACE is not set
--=20
2.17.1

