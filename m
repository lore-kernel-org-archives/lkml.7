Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA5EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF020643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611651;
	bh=ZIyGuThsbVKGaQNbGgxjt4Jx+6Beoi4C6pE0ktsuEZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wT7N5edodFmILGmZOJ9GsVJo4JUav+1NZM48lRL59r0p2hCmcFJlCiRDx0j7HJgxv
	 ffbOtxhvd3saX+bNntmJ4HZl+D9nr+PVVZvWtnLi0gBZ7BnLeuT9/vbz2rOGfmOIr1
	 OVckaeTAvoHv9ghRnujEqQopxmtWRMkTAhrkaTOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfDRSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391212AbfDRSIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98DFA2186A;
        Thu, 18 Apr 2019 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610902;
        bh=ZIyGuThsbVKGaQNbGgxjt4Jx+6Beoi4C6pE0ktsuEZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2g74nOEFpYi96rysuloP8rZYeTDRIdkE0sUUFzP3W0FTfaR/KS4Dhc3K5NTQT5/yN
         36MylwiNKGOhvCww+DxuxuyAL2tERPi8CVyDlI8VmOnLEf6Gx26Nikt7kZl1Audvnb
         TDNVznSNmhrHYYmhZMt94CGn6JdtljwK07ROtKpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 35/50] ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms
Date:   Thu, 18 Apr 2019 19:57:46 +0200
Message-Id: <20190418160426.918588431@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e8229b9fee4a..3265b8f86069 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -258,7 +258,7 @@ config S3C_PM_DEBUG_LED_SMDK
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option
-- 
2.19.1



