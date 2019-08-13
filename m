Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F077C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6D206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KJh6VI2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfHMXgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:36:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfHMXgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565739379; x=1597275379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hs97oi1bXDwsAKNjlRuuADCZCDyWXPRBIwJFAwfMXmw=;
  b=KJh6VI2GYjcJW0PcLyvfniAwAoTcnnJWFiTbzaIUOlEwgLRmreJNHG6t
   PcJdUCWLSXc8ZpRJwUDBDnLCj0w/Jil1yiuGC3+rpuqju/SFCvkG6Ajq4
   na5OpetWUHEqHj//jAJBwT/gByg4DmZCYjmxxqT6wjxkzr+bhlFaA1jVj
   Jy857pXuCywdeiKrGQqZua6SSLmKV5d8WXj+8q4PxUN7qsUjNuLw/X29H
   CXt/cUk1xdzmbSYDAey7WeBpS6y4q8FfhkrqD/iZkrMT7RqquTP6f/gEI
   kHnMJKff8npkZJlzTofSzRBcs/Ci8s7uxfycpxz8u6mvP02Z84FYHm7XE
   Q==;
IronPort-SDR: DGYRZ2ahVtTMJDXlUOOgSjL7qkpYT5a6V81EqPtcanMwmc64q1RK1506Da3BQ8Tx2su7KXF+RV
 8hKLKcM++mu9NnZwvFZQbJ2Kqrqj9jAMP3NNAG7fp3IVOVx7aAPhk85cZtF3i+xq+vboM04g92
 80/cUkUC3idV8Fp23U7CXGbMqIat6rLmfbzjyBSO5C5sFE4GzBNR8FSmSSo1mxtnheXiL5vXwi
 9VL8PeP0nOo4U7+mtdWyjZGUGkUT2XOw6lQvLzqvDh3zEH0SxvlZLBV+Z9FA4LmKDXMJH+76uu
 f4k=
X-IronPort-AV: E=Sophos;i="5.64,382,1559491200"; 
   d="scan'208";a="120378576"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2019 07:36:19 +0800
IronPort-SDR: OgK4lOLEQ5c1PLTqcBvODW67lelHXmJw5ygBCuMty2PmOAWFyLmrNTD6OmRbdkLGi6YJpX2NQ0
 e7qs8+PfHRhilYCrLlJAcZImsPTzpM+swWPQYeceajlr+gO//XYFs54FDXmC33ry8kP20XxU4G
 GaWjqrDDxtkcpKmQS6V6f1T1u2Out4Anufaea759ngq6ULBR7GpTtDR2jzZCyed2aS4koF/XT+
 OQg9GDN0uJn9RZNbEm6U8Q95Llq7+a63nKbf2743NiTpCT15roKqk4Nn48A4GRVOPuv2S+uFuu
 Hc+bbGNufv3NS70jg6fzWiqW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 16:33:53 -0700
IronPort-SDR: q4Durlzmo8hA1bu/t7Y4lpef2eadOlWFzAB0fDsP6ScLa6+o+Vd+rmyWPm/Rp6/PZmeH8B+hSm
 4Y/DMk8kspCtWOjCIBp2ePxOm2/iUzIyxg5sZe+TZArOGLTrVPYIFLffTpAPQ9BKJ1TqYjaR15
 1R8lRrWsl1AMpNLJnaeJGurfP0Fe7clKvYo8T//oFSmbmEBOVc+3twFBejBAchJG84kMXq5DAE
 UYnT+f1ANMpPAQ9myL06jLYosOpYfXsv+BlE/0kpP6KTgxQ2FhZRVxPJBTACmW+HputN8zDPip
 sn8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Aug 2019 16:36:19 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] riscv: defconfig: Update the defconfig
Date:   Tue, 13 Aug 2019 16:32:30 -0700
Message-Id: <20190813233230.21804-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813233230.21804-1-alistair.francis@wdc.com>
References: <20190813233230.21804-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the defconfig:
 - Add CONFIG_HW_RANDOM=y and CONFIG_HW_RANDOM_VIRTIO=y to enable
   VirtIORNG when running on QEMU

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 93205c0bf71d..3efff552a261 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -54,6 +54,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
-- 
2.22.0

