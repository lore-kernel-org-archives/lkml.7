Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C32085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TJOgSRC5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i0wrcs0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfCYJXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:23:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38365 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfCYJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553505787; x=1585041787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w4dVKfN5ZmXiG15CA3JMTgfloONM1rxnpuZsSQQesj8=;
  b=TJOgSRC5VvpifFEbtezhllP4FUK540uskEYyZ0M+B43RKizBZfHYXDu6
   RN5nvx3pmThmP9pbTrip3r2q94KLI3ynb8jkSS9JGMST+2Hb4izDWModX
   a08RtTdr1V3gJyQ+z4IcYFwjg/yXdDSmeA8v2ssY1rHPENKAZJGZMdxP7
   brASuyKmd4Fq9xPLDe1xlKScLETyhw6TD5q45UNVsJdvrFmInkRE5B4ue
   PeKIbUh7ahnkNAG7VbftiOoR7q9I3jrGTC/SHuowvm991+DFMLF/SVo4I
   gdzTFgJikDMa00CyoizqHqEPWD2OSxZBbtLovaQ+EeGhuwhhVkv3cxS3w
   g==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109204920"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 17:23:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5TIGr+xISzJZCK8B6VvVozLxUD4U89lHpLv+XA3rBM=;
 b=i0wrcs0tbrGk4qOt2TZDGyYluLaXxXZaQk1GgyxOvHf4CSDloLaZGIZH0b9pEYiEKlCSWyH67stXL6TKWG5tANcF7bjT65F529i/Hqx6l0pcBGsubJAA218hiDejdpw8eqqEaMHnXQUkJKQZmpAqonAndjlFRO2Svv+DRDIMzZs=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6141.namprd04.prod.outlook.com (20.178.246.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 09:23:05 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:23:05 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3 1/4] RISC-V: Add separate defconfig for 32bit systems
Thread-Topic: [PATCH v3 1/4] RISC-V: Add separate defconfig for 32bit systems
Thread-Index: AQHU4uxZI+7Q/CZyAkSTA9/wBNCfkQ==
Date:   Mon, 25 Mar 2019 09:23:05 +0000
Message-ID: <20190325092234.5451-2-anup.patel@wdc.com>
References: <20190325092234.5451-1-anup.patel@wdc.com>
In-Reply-To: <20190325092234.5451-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c109fd0d-5db4-4cae-6e8e-08d6b1037c37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6141;
x-ms-traffictypediagnostic: MN2PR04MB6141:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB614156FB5E8C04B293E529F78D5E0@MN2PR04MB6141.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(68736007)(54906003)(66066001)(53936002)(446003)(110136005)(71200400001)(316002)(256004)(11346002)(1076003)(50226002)(25786009)(8936002)(86362001)(72206003)(14444005)(476003)(8676002)(3846002)(105586002)(5660300002)(4326008)(6512007)(305945005)(486006)(2906002)(478600001)(7736002)(106356001)(102836004)(81156014)(6116002)(99286004)(81166006)(76176011)(386003)(44832011)(6486002)(2171002)(2616005)(6506007)(66574012)(26005)(52116002)(6436002)(14454004)(97736004)(36756003)(71190400001)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6141;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ukut514nvSaWzTQ/kcFDR+gGjDg3l2BfwwGWBvWAwH+a+OzW5GN1/b9dvjo5r9qv+I1Rak9dpJZYLfpOdXK+VyI76WOdxh4NdoY6AqoogMQiPzET+sMZFCjWkDfQ6bXE8uAZTgqYXLJ8lDwewAOxmI8ZPvyfZK3jgDhx1vj18kVpFvtWTmUQzIYfm4jeErqpj4nKdKukK8V6CO1pcKaiOpHRvLFuvIAzTfHRi9EmvmKLeiLS8nwxldQLIbFPXUjADeFmw5XzCPDvCT+67liT1w2NIMirT6Mjk3M3Oexe7Ad2OsQUSxlp4nXDVEs4/DrgqgNI/YZct7jbWb408ie9x6Y4eTXj5M/8TvprLlwoegsuOImoW/VDyzQRPr1FN+DUnNnxsrSBETvz+fSwhDX5XEm8bzLppdkLh/6erZZEin8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c109fd0d-5db4-4cae-6e8e-08d6b1037c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:23:05.0402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6141
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

