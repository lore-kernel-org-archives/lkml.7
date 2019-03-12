Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89661C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430402173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r3RYacp2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CuRCk5ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCLWIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:08:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30535 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLWIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552428498; x=1583964498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w4dVKfN5ZmXiG15CA3JMTgfloONM1rxnpuZsSQQesj8=;
  b=r3RYacp2d9J/g0GARRrW4Km5vYTr3W3l8F2AjG7wzslBnYHkHkBEvhYU
   4aTMOeGJfXdOsC9mhLVyUrF1AVUz+KXe2KKv7nw2CZOwk4rLgZa79jgyV
   a0SDBY9nd0sGmB3akUW77K9hgMuKvEb5Bgy7O4+9SuFxksRzlMznAEv9R
   eOtH037FEmCXpLRjQBIzb+xyfyCgl2MVtuKVYA4+OhDeXqFblam0IV2xe
   ROY8p6ewIze9Epbg9RY/m7mLcuysPyiPQBxrJvoDVOVUrn7dI6HtvJEYg
   U/oy1FVFx5W2Z4MnCfxqi/VFS2zinQhaFRiqFiuQlEregMclRsXm5yRZd
   w==;
X-IronPort-AV: E=Sophos;i="5.58,471,1544457600"; 
   d="scan'208";a="104620467"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2019 06:08:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5TIGr+xISzJZCK8B6VvVozLxUD4U89lHpLv+XA3rBM=;
 b=CuRCk5veR7fi5DTP9gG1sn9LzaTziz8ablWOkyVWVJoCmriapYzglcbnadv3ebP28y5e18aA0H/ygTnsbrn6dpeGJslWPKcRypaAPEAdYGzvSrJqe9IzdSwypTPoPm0nO4CCtUuP19+9i/KKeizpLABOGT+1ysWtAF5lAIX4ctM=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4201.namprd04.prod.outlook.com (20.176.76.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 22:08:13 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:08:12 +0000
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
Subject: [PATCH 1/3] RISC-V: Add separate defconfig for 32bit systems
Thread-Topic: [PATCH 1/3] RISC-V: Add separate defconfig for 32bit systems
Thread-Index: AQHU2SAVT5p6H2iYlEy5gQkEIbe7Lg==
Date:   Tue, 12 Mar 2019 22:08:12 +0000
Message-ID: <20190312220752.128141-2-anup.patel@wdc.com>
References: <20190312220752.128141-1-anup.patel@wdc.com>
In-Reply-To: <20190312220752.128141-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d7d8031-3356-44d5-5765-08d6a73737e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4201;
x-ms-traffictypediagnostic: DM6PR04MB4201:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB42013C034981305DFA78443F8D490@DM6PR04MB4201.namprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(71200400001)(66574012)(478600001)(26005)(305945005)(106356001)(76176011)(7736002)(105586002)(72206003)(102836004)(6506007)(1076003)(386003)(71190400001)(66066001)(97736004)(36756003)(4326008)(5660300002)(14444005)(25786009)(186003)(14454004)(316002)(256004)(6116002)(53936002)(54906003)(99286004)(2906002)(110136005)(2171002)(8936002)(50226002)(486006)(446003)(476003)(11346002)(2616005)(44832011)(81156014)(6436002)(6512007)(8676002)(81166006)(68736007)(86362001)(52116002)(6486002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4201;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6J7d3jd3Awp6C/miF4aRXwminj6CxNmn+OMip9D66zpN4E0jPTkhkUTIaQCpyeF1INGG1kG8OERmzet0aDKquxOFHdgzmcZP3OMtjtgARjcJZrkjuH3itG9RyQzJ3gBS23dNlWYAFVtUSYPnMkxoI/knG38UqsQ3M48/PTPvlWlOXTPk12IridRE9CuPMUb7glAS5kbLKa1ihtSSIPBovS6kO88+Yzu4wUAllVTezEAsBDATEC8d6YfYYoaT8gw0nf/Vc6uPSnjcqXKvdSpjMjOoqg0o70LQbTL9sfjCnxFRqF+/pOf9Gwg/tz18kCBntc9+MuB69x8MPEiWiL0IkEWdcTWgBzyCATAboKF65R/IIofRgd/u8rfMr3ojdSFWHSPjYEDS/UdEVFfMTTY3tY0pDycYHIFEYxGr4BB7gBY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7d8031-3356-44d5-5765-08d6a73737e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:08:12.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4201
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

