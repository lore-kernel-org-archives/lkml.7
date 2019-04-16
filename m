Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38490C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D9520872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfDPRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:02:29 -0400
Received: from foss.arm.com ([217.140.101.70]:59826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfDPRC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:02:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D69580D;
        Tue, 16 Apr 2019 10:02:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB08B3F59C;
        Tue, 16 Apr 2019 10:02:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     olof@lixom.net, marc.w.gonzalez@free.fr, john.stultz@linaro.org,
        liwei213@huawei.com
Subject: [PATCH] arm64: defconfig: Update UFSHCD for Hi3660 soc
Date:   Tue, 16 Apr 2019 18:02:21 +0100
Message-Id: <20190416170221.13764-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7ee7ef24d02d ("scsi: arm64: defconfig: enable configs for Hisilicon ufs")
set 'CONFIG_SCSI_UFS_HISI=y', but the configs it depends
on

  (CONFIG_SCSI_HFSHCD_PLATFORM && CONFIG_SCSI_UFSHCD)

were left to being built as modules.

Commit 1f4fa50dd48f ("arm64: defconfig: Regenerate for v4.20") "fixed"
that by reverting to 'CONFIG_SCSI_UFS_HISI=m'.

Thing is, if the rootfs is stored in the on-board flash (which
is the "canonical" way of doing things), we either need these drivers
to be built-in, or we need to fiddle with an initramfs to access that
flash and eventually load the modules installed over there.

The former is the easiest, do that.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/configs/defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..32fb03503b0b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -222,10 +222,10 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
-CONFIG_SCSI_UFSHCD=m
-CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
 CONFIG_SCSI_UFS_QCOM=m
-CONFIG_SCSI_UFS_HISI=m
+CONFIG_SCSI_UFS_HISI=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
--
2.20.1

