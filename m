Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19924B4E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559634759;
	bh=/q6ifgaArkLKdkaDnn87c6mI1o//fVbPCP/Yo+7tFsI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lUEJZ5rp/tto+dswZf81pbFsoIm3OlnJ6wntpsz9Q1Wh+O5yJ8rtB13JBV8RX4k4g
	 7yJqQzMDicB5GYl+jtoVK+k2JO90WpnfF+vNkgFrzW9cRla6MndBy528naGqXJID2U
	 gKiGmlDwpkfWMwkr0MzIDZytsskyTclgFwGqHGec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFDHwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFDHwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:52:37 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EEBA2423F;
        Tue,  4 Jun 2019 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559634757;
        bh=/q6ifgaArkLKdkaDnn87c6mI1o//fVbPCP/Yo+7tFsI=;
        h=From:To:Cc:Subject:Date:From;
        b=yCMXWA5GGSKL5nJRx7XYN+zSSv+uVVZ4anFsrsr81oG6h6U67C2RuJQA6aQwCwFus
         rIKJHXj0Tf2v3ngy8fNWTYldyON09v3sADEz/jEhEgIIznyiL7e7UwBwwe7P0e6uEJ
         MidY9PYgyZpIPvvF3DKtweA8YzhgYTJic2Et2zaI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arm64: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:52:28 +0200
Message-Id: <1559634748-19546-1-git-send-email-krzk@kernel.org>
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
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d1b72f99e2f4..45488fcc6352 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -192,7 +192,6 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_HISILICON_LPC=y
-- 
2.7.4

