Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C528C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE2521019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568141240;
	bh=DtA1ZIJa0KT7HzP2wl8Z4/P/Ia1Bv1IRlb/FPekwQn4=;
	h=From:To:Subject:Date:List-ID:From;
	b=nioWzPgjb+h6a90q77TvSn4IcQ5zW7nmvysapyYPxHfYx3WkZPftuZj+Qc3I4sc05
	 5XXSMBdJh19vf/3ZgDZ0WZt9sDWyryIitb/hey1S3jfRM24v2LGCcbWwBCDQTjKhlu
	 HCYBhLBB2y8EmQwkpzYoUuVXb9stLXYjxv6Wp+hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfIJSrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfIJSrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:47:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75842084D;
        Tue, 10 Sep 2019 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568141238;
        bh=DtA1ZIJa0KT7HzP2wl8Z4/P/Ia1Bv1IRlb/FPekwQn4=;
        h=From:To:Subject:Date:From;
        b=wUC/GACTC0iPw/SDrWBq6bZSbqO3VxntVr5gffzzRoqfe1ZbXQpTc8HzlIGPc1r8O
         ODDOB3qHnSJSWzI116i0dob6pzIuRPyrgzGnw7zz9nAbQTN2zRCtB5SKY/rYIVIO4Z
         ZAB3TdHP1R8y+YXq7B1yOD7h+qC4To87AUHXA+pE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Richard Kuo <rkuo@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] hexagon: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue, 10 Sep 2019 20:47:10 +0200
Message-Id: <20190910184711.22153-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/hexagon/configs/comet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..d4320ebdb4b9 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=y
-- 
2.17.1

