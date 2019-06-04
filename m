Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D74FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F8724D3E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635200;
	bh=TaIOuGpo5ycVLlsAVSbxNAXrTlNmKkCcdHWhp2t8UWo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hxvup8cG/Eg6H/0Wjujt9U9WhVvBrue+666JfL5eun2uDY6gHB/LNbvl6i6/PqAnB
	 R/WRcMS0+H7CDzeOHY/IvQhG/DO7UIQXgb4DL3oicJcZWWEdF+ZofCX1caQT1c5qop
	 IMXkCQrPPhwveD1vG6wZ0a/mH/28KUOsjy3/yDbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFDH77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfFDH76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:59:58 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D6724D3D;
        Tue,  4 Jun 2019 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635198;
        bh=TaIOuGpo5ycVLlsAVSbxNAXrTlNmKkCcdHWhp2t8UWo=;
        h=From:To:Cc:Subject:Date:From;
        b=YJYf3cm+0KoSHe03XKXMv8zZPcrDVcFzifrD7hoZm5IMx3fBkcevnO9kcoxocsWUW
         9debgWJbf7NFPeN/W1RlVA6KvdnfikquIV5YaOjDDPyarSAeHdfY3iXDUEd+XxDchh
         jWh/0V+XPPtX67QQMIMbf3Hj6yqyrFsUM6h/2cJg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] um: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:59:53 +0200
Message-Id: <1559635193-21151-1-git-send-email-krzk@kernel.org>
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
 arch/um/configs/i386_defconfig   | 1 -
 arch/um/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 8f114e3b0a7a..73e98bb57bf5 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -36,7 +36,6 @@ CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
 CONFIG_UML_SOUND=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_UBD=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 5d0875fc0db2..3281d7600225 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -34,7 +34,6 @@ CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
 CONFIG_UML_SOUND=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_UBD=y
-- 
2.7.4

