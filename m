Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631592073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G0fhdgPK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cXCj26N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLCDtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:49:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65119 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfLCDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575344976; x=1606880976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NO9w9lB7AJuukixFLlNldJDxscUXD2JzMPM23TCSldU=;
  b=G0fhdgPK9Zw8xzoxN+VPSP4K2utfhgDL0lQQrjz1mnD/vOAtZr3zy2eu
   hFPZypG1+jsfgJ0qbMewUuyl66kBJjWkdnd1PmhEtFHcz05hoN89mALdN
   ovjg60CuyFaVRW0YiSyqXmohktHyJ5U0OJC0eZvduD4FEyifjsGxWJ9Q/
   saiuyK8ErhuSc/1yg0ON4g7otQTap8Wkg2+qC1Jem8apzK6Ax4yJJKJ6X
   028IPGRoqU9s5617vgWSV2d3FTRFXGWHiBkBhs+YStzKHBUPF4Khhfo94
   7O6pV7mPpgooNC9L3l0D01swAFxOuwT5LzJMwl/L+hHfZ6fBvLEU5ntQW
   g==;
IronPort-SDR: 3BmLAjAjAz0tAdzLDV85L+3TLCWzFzJFxyB50hYVj6qJhTVZ55KRvg19KxzrOgmTUkHDM9k3Hp
 cpOuHFGyGmMsl7Gor/ozBOCuhElKHdnb50KdLldymzqfOonTGzs4CQFXBvWl6kH9nKmcaeJKvo
 e1S0iozi8fTkmd2ZY04FOM4xvjiKyxVrzJN61F9wybP8yTpzvC0Do9bV/jxwdkU+Jw6iSNCBRN
 ZCWIzzrK+/wGAAl/3/ZyKmXQOnVXnXXK3nmdGobaonF6RE37XVjNWtXd/JY0cR2sjOp5OWHjxL
 Qnw=
X-IronPort-AV: E=Sophos;i="5.69,271,1571673600"; 
   d="scan'208";a="231947963"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 11:49:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR44+wwizk5Esy/2u841jzoy36nt19cxe0G4VFTTMIJh/7WSB5gnCX6t/IH3pz2T5iDNo4ZNEMNm2W2iTI1sG0K34ozGCaZLjVP2GTf7286WPmWdrImsJwH2+FyBvtB3f6qpoz7E6yvGBJldhEzKwHKmWx0jRRARZkrjhYWb5nx6GbJfagsB3M+DEticow7FMCHdf8RVG2oBdt5ByBiwKPmn6GR29sWL9zyF4Y9MU8UcAarUoznlht3TCn7tmuAv2dUJ5e6zS9heoc8eRAQAihCLfKlRD1Mrhz7OKPtAB8imM5FzVx62wZhAaSgkO+lDppoky50biW/9OcMeE/C2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNLQUEmoIThA+eYb+O5wL+CNfw3SQk64rwLApSwQsv0=;
 b=fovrgrfY9Mxws5IQJqAC5JIf7FVNgSplzEj6c9jaS0SjzfRa7cVk4Sy2Ws0AvAQdXljrSxhKcKwz2zhP4vf9WIM9l4+pHwpGNwFqwDb78r6zI8kJ9cAlWi8tle14Hp8I3PxxQbglBXD3eHa223wKOXwHMCLQFyP3TGiDr0PPgXaheO4Ae7nhj5T6xijyPyKBNRZfpLYZsUfAYk0Gf6cuM6B8tM4Tlz2prYrN+lIRtcIHIohHUaPT+UciYy6xzdPMPiY4pPFgRkSZHsxhRr8DYc2rRI/kEpEPnPMr4p623ZLcSOlWaOhl+xGTO4xFbpaSWbX2tDvkbHMQQtKY+gh51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNLQUEmoIThA+eYb+O5wL+CNfw3SQk64rwLApSwQsv0=;
 b=cXCj26N8zkssbpSdrUTw5n50aEZPPlfG/ePApXSyfjMpcSOtDcVTWolnqBn2YVPb09sXwxnYlQ9kQkzBcoIBSfrjBbnWeDAlmTLIMWZ9q8YWaAivuxXrVj12/lXJA0YeJ6ZZabyFWO4O8Te1V9GgXGA3IeQeeZcU4a5XYvRmhp8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5807.namprd04.prod.outlook.com (20.179.22.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 03:49:34 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 03:49:34 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 2/4] RISC-V: Enable QEMU virt machine support in defconfigs
Thread-Topic: [PATCH v2 2/4] RISC-V: Enable QEMU virt machine support in
 defconfigs
Thread-Index: AQHVqYyt4dS06imzoUaWBf5val2QOA==
Date:   Tue, 3 Dec 2019 03:49:34 +0000
Message-ID: <20191203034909.37385-3-anup.patel@wdc.com>
References: <20191203034909.37385-1-anup.patel@wdc.com>
In-Reply-To: <20191203034909.37385-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [12.169.102.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6464c6d7-4ca5-43ee-54ef-08d777a3cf93
x-ms-traffictypediagnostic: MN2PR04MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5807950AE40F111EF5980FCA8D420@MN2PR04MB5807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(66556008)(6116002)(3846002)(66446008)(66476007)(64756008)(66946007)(25786009)(52116002)(76176011)(6506007)(386003)(186003)(305945005)(7736002)(26005)(102836004)(478600001)(316002)(71190400001)(71200400001)(14454004)(44832011)(446003)(256004)(14444005)(11346002)(2616005)(2906002)(66066001)(81166006)(8676002)(50226002)(81156014)(8936002)(110136005)(54906003)(4326008)(5660300002)(99286004)(2171002)(6436002)(36756003)(6486002)(6512007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5807;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZK38xy+nJYpUmm0OrBCFO9XBr4dVCDB2wVFX5tR6t3W94i0dFFW+h1DQJ3pYSTQiuRJ1mD19FAR+NfN9QIkMe2dWUDmR71EucmiqvCzlci5Bg8G0aP7vTvpVHPp4aQuyY6VWyUbLuculuiMNl8aH1CLvL68QDh2UAqHujuVWNT+Z0JyiKimA/4ASz2alxSGl4GjyFMrTZfjS0nCuYt3iN9VczzMBpONix0skiRtLdMjvMWF/RRMtSB497yMlkrpMdq0UjmFzlcg44oFmqyJ5/1W/RdegD84LZw3D9fBPeCbCA0RexIVYlctvQR0kUgKbTxOO7x7OTXM0bSESCTL9gRb9GITfOQ63sNnX0WyGs7Ruv0WYXkmXpBdxC94Hynoy46Yu8v79Rm3FU/a2jMh8FILOMRoVZ5JSYoW7uKKxW0sYCRgwwdAeojbKPD9hviCM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6464c6d7-4ca5-43ee-54ef-08d777a3cf93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 03:49:34.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoEcNtbRcvWbKgu2lxeSWSb9uq25GILac1Wagyh+jP4i9Ljx4zTBMbNB59JydHKkDFBFsVx+oGrNIsvxDRvpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have kconfig option for QEMU virt machine so let's enable it
in RV32 and RV64 defconfigs. Also, we remove various VIRTIO configs
from RV32 and RV64 defconfigs because these are now selected by
QEMU virt machine kconfig option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/configs/defconfig      | 15 +--------------
 arch/riscv/configs/rv32_defconfig | 16 +---------------
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 420a0dbef386..2515fe6417e1 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_EXPERT=3Dy
 CONFIG_BPF_SYSCALL=3Dy
 CONFIG_SOC_SIFIVE=3Dy
+CONFIG_SOC_VIRT=3Dy
 CONFIG_SMP=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
@@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=3Dy
 CONFIG_IP_PNP_RARP=3Dy
 CONFIG_NETLINK_DIAG=3Dy
 CONFIG_NET_9P=3Dy
-CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_HOST_GENERIC=3Dy
@@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
-CONFIG_VIRTIO_BLK=3Dy
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_BLK_DEV_SR=3Dy
-CONFIG_SCSI_VIRTIO=3Dy
 CONFIG_ATA=3Dy
 CONFIG_SATA_AHCI=3Dy
 CONFIG_SATA_AHCI_PLATFORM=3Dy
 CONFIG_NETDEVICES=3Dy
-CONFIG_VIRTIO_NET=3Dy
 CONFIG_MACB=3Dy
 CONFIG_E1000E=3Dy
 CONFIG_R8169=3Dy
@@ -57,15 +54,12 @@ CONFIG_SERIAL_8250_CONSOLE=3Dy
 CONFIG_SERIAL_OF_PLATFORM=3Dy
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
 CONFIG_HVC_RISCV_SBI=3Dy
-CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
-CONFIG_HW_RANDOM_VIRTIO=3Dy
 CONFIG_SPI=3Dy
 CONFIG_SPI_SIFIVE=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
-CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
@@ -78,12 +72,6 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
 CONFIG_MMC=3Dy
 CONFIG_MMC_SPI=3Dy
-CONFIG_VIRTIO_PCI=3Dy
-CONFIG_VIRTIO_BALLOON=3Dy
-CONFIG_VIRTIO_INPUT=3Dy
-CONFIG_VIRTIO_MMIO=3Dy
-CONFIG_RPMSG_CHAR=3Dy
-CONFIG_RPMSG_VIRTIO=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
@@ -98,6 +86,5 @@ CONFIG_NFS_V4_2=3Dy
 CONFIG_ROOT_NFS=3Dy
 CONFIG_9P_FS=3Dy
 CONFIG_CRYPTO_USER_API_HASH=3Dy
-CONFIG_CRYPTO_DEV_VIRTIO=3Dy
 CONFIG_PRINTK_TIME=3Dy
 # CONFIG_RCU_TRACE is not set
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_de=
fconfig
index 87ee6e62b64b..bbcf14fd6f40 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -14,6 +14,7 @@ CONFIG_CHECKPOINT_RESTORE=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_EXPERT=3Dy
 CONFIG_BPF_SYSCALL=3Dy
+CONFIG_SOC_VIRT=3Dy
 CONFIG_ARCH_RV32I=3Dy
 CONFIG_SMP=3Dy
 CONFIG_MODULES=3Dy
@@ -30,7 +31,6 @@ CONFIG_IP_PNP_BOOTP=3Dy
 CONFIG_IP_PNP_RARP=3Dy
 CONFIG_NETLINK_DIAG=3Dy
 CONFIG_NET_9P=3Dy
-CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
 CONFIG_PCI_HOST_GENERIC=3Dy
@@ -38,15 +38,12 @@ CONFIG_PCIE_XILINX=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
-CONFIG_VIRTIO_BLK=3Dy
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_BLK_DEV_SR=3Dy
-CONFIG_SCSI_VIRTIO=3Dy
 CONFIG_ATA=3Dy
 CONFIG_SATA_AHCI=3Dy
 CONFIG_SATA_AHCI_PLATFORM=3Dy
 CONFIG_NETDEVICES=3Dy
-CONFIG_VIRTIO_NET=3Dy
 CONFIG_MACB=3Dy
 CONFIG_E1000E=3Dy
 CONFIG_R8169=3Dy
@@ -57,13 +54,10 @@ CONFIG_SERIAL_8250_CONSOLE=3Dy
 CONFIG_SERIAL_OF_PLATFORM=3Dy
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
 CONFIG_HVC_RISCV_SBI=3Dy
-CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
-CONFIG_HW_RANDOM_VIRTIO=3Dy
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=3Dy
 CONFIG_DRM_RADEON=3Dy
-CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_XHCI_HCD=3Dy
@@ -74,13 +68,6 @@ CONFIG_USB_OHCI_HCD=3Dy
 CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
 CONFIG_USB_STORAGE=3Dy
 CONFIG_USB_UAS=3Dy
-CONFIG_VIRTIO_PCI=3Dy
-CONFIG_VIRTIO_BALLOON=3Dy
-CONFIG_VIRTIO_INPUT=3Dy
-CONFIG_VIRTIO_MMIO=3Dy
-CONFIG_RPMSG_CHAR=3Dy
-CONFIG_RPMSG_VIRTIO=3Dy
-CONFIG_SIFIVE_PLIC=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_AUTOFS4_FS=3Dy
@@ -95,6 +82,5 @@ CONFIG_NFS_V4_2=3Dy
 CONFIG_ROOT_NFS=3Dy
 CONFIG_9P_FS=3Dy
 CONFIG_CRYPTO_USER_API_HASH=3Dy
-CONFIG_CRYPTO_DEV_VIRTIO=3Dy
 CONFIG_PRINTK_TIME=3Dy
 # CONFIG_RCU_TRACE is not set
--=20
2.17.1

