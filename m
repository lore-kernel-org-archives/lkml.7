Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D621FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E6F217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909376;
	bh=FiFwcmYHHeLB5CagW34gpRQYI7hN2R9aKNRXUBcdFrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSQ6r17o0o+HIMajdn6vpk1EP7+bSnDzOCztCEpGbXpXU2WzaSxlaBE7soc+sgKkN
	 9t9GcUpX+xi9dXSLmco0PIFip6nKT4agFjzesR8J8nqSXsXYyBsuUPgB6fv3ZxKzCt
	 yZMCc3prHrIgJKdp2ALt/FTKrAZo1WsZRFYdycx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfC3B3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbfC3B3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07D9218D3;
        Sat, 30 Mar 2019 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909369;
        bh=FiFwcmYHHeLB5CagW34gpRQYI7hN2R9aKNRXUBcdFrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfaeUckAA8jpv/boWr3wOcwrAJqG579VtqJbJe6Urm0xCLxBXoglLRkXTCYtWNgE3
         FtnLSwtqOpoAgDrO6fM7lBUGtpjxH/ksg/hUAs4/njYRW6s9asRtSO0tHeGfqxo65H
         2ysu/aNOzsooN8g7zM5ovSZUISk/4rPy8MrG79KQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 16/57] ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms
Date:   Fri, 29 Mar 2019 21:28:09 -0400
Message-Id: <20190330012854.32212-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

[ Upstream commit 6862fdf2201ab67cd962dbf0643d37db909f4860 ]

"S3C2410 PM Suspend Memory CRC" feature (controlled by
SAMSUNG_PM_CHECK config option) is incompatible with highmem
(uses phys_to_virt() instead of proper mapping) which is used by
the majority of Exynos boards. The issue manifests itself in OOPS
on affected boards, i.e. on Odroid-U3 I got the following one:

Unable to handle kernel paging request at virtual address f0000000
pgd = 1c0f9bb4
[f0000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[<c0458034>] (crc32_le) from [<c0121f8c>] (s3c_pm_makecheck+0x34/0x54)
[<c0121f8c>] (s3c_pm_makecheck) from [<c0121efc>] (s3c_pm_run_res+0x74/0x8c)
[<c0121efc>] (s3c_pm_run_res) from [<c0121ecc>] (s3c_pm_run_res+0x44/0x8c)
[<c0121ecc>] (s3c_pm_run_res) from [<c01210b8>] (exynos_suspend_enter+0x64/0x148)
[<c01210b8>] (exynos_suspend_enter) from [<c018893c>] (suspend_devices_and_enter+0x9ec/0xe74)
[<c018893c>] (suspend_devices_and_enter) from [<c0189534>] (pm_suspend+0x770/0xc04)
[<c0189534>] (pm_suspend) from [<c0186ce8>] (state_store+0x6c/0xcc)
[<c0186ce8>] (state_store) from [<c09db434>] (kobj_attr_store+0x14/0x20)
[<c09db434>] (kobj_attr_store) from [<c02fa63c>] (sysfs_kf_write+0x4c/0x50)
[<c02fa63c>] (sysfs_kf_write) from [<c02f97a4>] (kernfs_fop_write+0xfc/0x1e4)
[<c02f97a4>] (kernfs_fop_write) from [<c027b198>] (__vfs_write+0x2c/0x140)
[<c027b198>] (__vfs_write) from [<c027b418>] (vfs_write+0xa4/0x160)
[<c027b418>] (vfs_write) from [<c027b5d8>] (ksys_write+0x40/0x8c)
[<c027b5d8>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_CHECK config option to hide it on Exynos platforms.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index b600e38364eb..377ff9cda667 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -256,7 +256,7 @@ config S3C_PM_DEBUG_LED_SMDK
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option
-- 
2.19.1

