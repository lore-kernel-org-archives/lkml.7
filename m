Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5125F24672
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575576015;
	bh=rqMWnns6lhszBfCz46NO49QQ35oB1L0mfuooUiga/ow=;
	h=From:To:Subject:Date:List-ID:From;
	b=qpYdiXzWUMLd6ZZkaT4NKhBQOYDZLVjaoUcFtsFOkY/hwVHj89K0mtYu0VXCB3huY
	 vVrSfwgJYSGxKvfxsUWbpB31EGXj66CzX1oGbFjgAn4mKUJ1FC8bahnPAHb9u6xIh9
	 snrDE+AGA3PRzpyZYLBRVbP8VPbgM7CEi1yaxqk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfLEUAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfLEUAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:00:14 -0500
Received: from localhost.localdomain (unknown [194.230.155.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D187224670;
        Thu,  5 Dec 2019 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575576013;
        bh=rqMWnns6lhszBfCz46NO49QQ35oB1L0mfuooUiga/ow=;
        h=From:To:Subject:Date:From;
        b=jrOvRfxGmHBT0rouyjK6iV3sHT/UR9SNVCiKTLjeC86rGy37hqks1vdXk6DB9/iCq
         5uEGDt0XfmedBwhHykDOrpdNHA0pOJMKyJAQNS9d/8OV0ghvCHsCbgO7RpWga5hQ+C
         iM2ogEv5KqDS2T8F9QTU/QvdNTKAXczNlAIkgeJI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos_defconfig: Bring back explicitly wanted options
Date:   Thu,  5 Dec 2019 21:00:06 +0100
Message-Id: <20191205200006.5164-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few options KALLSYMS_ALL, SCSI, PM_DEVFREQ and mutex/spinlock debugging
were removed with savedefconfig because they were selected by other
options.  However these are user-visible options and they might not be
selected in the future.  Exactly this happened with commit 0e4a459f56c3
("tracing: Remove unnecessary DEBUG_FS dependency") removing the
dependency between DEBUG_FS and TRACING.

To avoid losing these options in the future, explicitly mention them in
defconfig.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e7e4bb5ad8d5..026407101cf2 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -38,6 +38,7 @@ CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
@@ -92,6 +93,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=y
@@ -291,6 +293,7 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXYNOS_IOMMU=y
+CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
@@ -355,4 +358,7 @@ CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
 CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_USER=y
-- 
2.17.1

