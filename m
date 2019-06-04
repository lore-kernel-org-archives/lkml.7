Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF72A24D3E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635093;
	bh=fVZcLXOpTcocoP/RV/mCkAqh6yuq/1+H20sck/RyaRc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dlimT7nao9YFhSjiy9Kxy6JXy9UvFIKTxXZ8ZYdhjLVO12cdY2djOpl7Di3ar2QNA
	 MsVhqm35udMZs+n27OxoO7u4RGhHVOYuTTCia4ahktSB607yQI5wSadgqxkpiElK1n
	 uPahl+AaBu7lN3GhD3indrpn6vqWPdSxyGt8s2OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFDH6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfFDH6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:58:12 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA51724D3D;
        Tue,  4 Jun 2019 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635091;
        bh=fVZcLXOpTcocoP/RV/mCkAqh6yuq/1+H20sck/RyaRc=;
        h=From:To:Cc:Subject:Date:From;
        b=zXTDtAB15PaV9aBLruCLvBtodNVH5Ju32u+C2xiJ6K2Y4v2GFwHfXl7eocCw+XAsi
         tI09lIWypKGdTlibD1LFLuHEtfISZ4Mq7HQf9PuVbeszrzuE1XEOPZIpLURwFDQR+v
         DpsoGfHpjQL3GXfpAjEYUjQ4GgpqelwD+B9qvIkw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ley Foon Tan <lftan@altera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nios2: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:58:07 +0200
Message-Id: <1559635087-20757-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/nios2/configs/10m50_defconfig | 1 -
 arch/nios2/configs/3c120_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
index 7977ab7e2ca6..1137ef2ed3b0 100644
--- a/arch/nios2/configs/10m50_defconfig
+++ b/arch/nios2/configs/10m50_defconfig
@@ -35,7 +35,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
diff --git a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
index ceb97cd85ac1..a0f160ba7598 100644
--- a/arch/nios2/configs/3c120_defconfig
+++ b/arch/nios2/configs/3c120_defconfig
@@ -37,7 +37,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
-- 
2.7.4

