Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CA024D44
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635265;
	bh=3h/Nr6WaRFlqDk+2M+DPyVkXGT3hhjSyN/lx6RKPwQQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KoVMH2upYMJbFY14ABdOs6os9Ga0v4vnJhrdqZpPTjS2loyqcljEdxnge5zBz0lQJ
	 wlZ9b1+2dmBXN0vu+8yT//1Hvbct9MwUiFGVWFvnz+lUZrA1TRimXX4QWGpo4yY5Z+
	 wDyx5JP6c5JUIifaoGEN7osvVGhS56KY2Zc5LNn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFDIBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfFDIBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:01:03 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7B324D43;
        Tue,  4 Jun 2019 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635262;
        bh=3h/Nr6WaRFlqDk+2M+DPyVkXGT3hhjSyN/lx6RKPwQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=xFy3xZ1qrWFKirbd9n/PTBpB316Unk8Vrhp7t8OHAY06T2tOLV1QJvP+PJcQaY28l
         Loh4L6GBwUAUaaM8r16rvV+VES07PWRbwpOj/bJxAJrO2JWfJF48+TdPR4ub0zwsET
         rbtc4vh4hBgJuEzr/XUIUv+he7hvEdEWdnlcdGlk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sparc: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 10:00:59 +0200
Message-Id: <1559635259-21585-1-git-send-email-krzk@kernel.org>
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
 arch/sparc/configs/sparc32_defconfig | 1 -
 arch/sparc/configs/sparc64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 2d4f34c52c67..7b3efe5edc1a 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -27,7 +27,6 @@ CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_NET_PKTGEN=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index ea547d596fcf..6c325d53a20a 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -57,7 +57,6 @@ CONFIG_IPV6_TUNNEL=m
 CONFIG_VLAN_8021Q=m
 CONFIG_NET_PKTGEN=m
 CONFIG_NET_TCPPROBE=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
-- 
2.7.4

