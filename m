Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCAC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B1B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ogADkfwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFYW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:56:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62522 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYW4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561503412; x=1593039412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZA+/stBEiltqseSxmuzq7O/QVj+jN7ZxS+dReMTEjRk=;
  b=ogADkfwe6J7UbltHwkkrSz6LtkP2a1YDsZ4wEI6ETToij5+l5Zpea2Xm
   +bELjnaxgwn5M//LK8cXAAEk41GDS7q2ARr6kmDa29HgjbarmWTVv5Uyp
   q2rkbRHoSIsvbeLHGwqXUPtuZQE2/ajVUh/oiTVra1RtGMt6Wwv8jROOV
   4e4NnEFScrLtsCNLsXWV6SJ6xSg3bvqEZIhLeIaEGWmxzapE9AHZFHwt7
   SBzmG0UAISHE4Yc1XD/TjPNqHNs9SXRxIEDCT8jATtCOILSPQ+AYWfcg6
   DxEgeAsoRf02JRHH+hJdCQmR0KDJGwR1lZKRWc0Qe/1LopQO3URVB8UHB
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,417,1557158400"; 
   d="scan'208";a="112746514"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 06:56:52 +0800
IronPort-SDR: vCwHRb4ABrTdbJjwivOVH/e+52CPvzDoqFSmkppGzkg87tCUDKeq1oEaxVEwEzinHxCQrw66qL
 TcnnIo3N1j/d2iIp07/vMdqvrDLazrI3qDHIomfsOL2pa/9WFpbcjzXVkYJAnTGcLnDWhA5Sq4
 +aykayhG0PIouXtXN9bHH4K0/N6dpSMfprbQJO2K07tyy4lkJR34256m5Y6+SZLTmARIYNJ5a1
 vX10oc4XhaPV0rly36NcSPlhEe84vkuN5Do0LgX7hxRBIOR2bgcxysQZUj1avnoJi53crvxlTN
 5qBRpfZ1Yf+IMLVKfzdvlcF0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jun 2019 15:56:08 -0700
IronPort-SDR: rbW7z9zmHKFPoMp7aRVaU2xWoTWiMDQuCULf5ZYv77U9EUL411lXIjjG3fAzgJjRj1J2/egoSl
 sQxGT1FwDWd1q0hJeQXyjSFYqMCSL2ilwZBgNdp43V6atd8IloXsbRpCn2RBDFY9/lTcI0cqes
 d+4iA+fKL4LCvjKdrAh8W40q33v2s48lpv4eZVEGfNCqKLjCzMTBiaJFREprUqd/uMyYxSAibS
 73Gv9azT8VL4utljy84bxvE0HYEXe8HQtPpjEMLbTwkgo/rx+0MEtgtYWOKWjt9cSDg3zTaKV7
 LZw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2019 15:56:52 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
Date:   Tue, 25 Jun 2019 15:56:36 -0700
Message-Id: <20190625225636.9288-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv upstream defconfig doesn't let you boot
through userspace if rootfs is on the SD card.

Let's enable MMC & SPI drivers as well so that one can boot
to the user space using default config in upstream kernel.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4f02967e55de..04944fb4fa7a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -69,6 +69,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_CLK_SIFIVE=y
 CONFIG_CLK_SIFIVE_FU540_PRCI=y
 CONFIG_SIFIVE_PLIC=y
+CONFIG_SPI_SIFIVE=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
@@ -84,4 +85,8 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
+CONFIG_SPI=y
+CONFIG_MMC_SPI=y
+CONFIG_MMC=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_RCU_TRACE is not set
-- 
2.21.0

