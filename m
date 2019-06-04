Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1520C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA46524D45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635290;
	bh=UlhymmxyyOFctVldJWiEk2/kWL6dB/H9KTUPn7ACi5o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jdyVxWSKt5iZYeNyGO4MjFtyI4oFjmaXhxLhShDeOynqIL2QXTs6IZ/n+aJVYFsNC
	 A2+yn5DkjI3BsPkhzMoC+czIcgrrNmR4Ro7v9q87XInye71D9fA4aZMe8sKmxDSx/Y
	 Rb+UpHusPvK8AzdQFIWChXI982vjpDm7vJM3IW+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfFDIB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfFDIB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:01:28 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8901F24D44;
        Tue,  4 Jun 2019 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635288;
        bh=UlhymmxyyOFctVldJWiEk2/kWL6dB/H9KTUPn7ACi5o=;
        h=From:To:Cc:Subject:Date:From;
        b=enffSLLtgh5S8Rsy0vY8Lb8aiGIHXbu5GF9ntagT2/lGs6gQMB3VV5d2tQE1Z2CCP
         CxKqDcqViNO+L6HuFf9NssOxmtiQwo2y0XQYhGFrKPRqJ2WWVx9xEJqoPdNn54kZAF
         mf1Ib0on1zn4J8+xOmpZtOZvZ2wWwkNjwcw+C/gM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] x86: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 10:01:24 +0200
Message-Id: <1559635284-21696-1-git-send-email-krzk@kernel.org>
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
 arch/x86/configs/i386_defconfig   | 1 -
 arch/x86/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 2b2481acc661..59ce9ed58430 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -130,7 +130,6 @@ CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e8829abf063a..d0a5ffeae8df 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -129,7 +129,6 @@ CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
-- 
2.7.4

