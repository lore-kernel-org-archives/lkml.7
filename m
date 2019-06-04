Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BD9248E7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559634949;
	bh=NZG+kgsujmO3Jg394X+zVaDLzGta+dFs9SolrOcNGaA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zcpy8uPORIXfobyU4nKfkZx+HwfFkVOevYlip9GUYh5am8WsLbZcXst66PRyUqXK9
	 pVCERqFYrtV0jRGiJU8YUZxmzl0zMB3U6H9i79+xHkgjI6AGCEAnxcgW5a81aXb2i/
	 YqbAZyj8reoPNOseOASQdi5VOogqWM1e0+QP5/CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfFDHzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfFDHzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:55:48 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C02A2423F;
        Tue,  4 Jun 2019 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559634947;
        bh=NZG+kgsujmO3Jg394X+zVaDLzGta+dFs9SolrOcNGaA=;
        h=From:To:Cc:Subject:Date:From;
        b=IdAxSeq+8r9Y0+WaaICWoVtKQ5e99WB+5azOWgbQG0l2WiSdXhZJubd8jzvPwsXF5
         Ln4tAGzRI3jw9CIcCXxU7fOv4AcbooAcEwQhZNB3E0fuFShhUpirKdSbX+MufUpvf3
         YZ4kORtmMNG9HOMFJAmPMPy4DTRQuD/oiEa+UKfk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Richard Kuo <rkuo@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hexagon: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:55:42 +0200
Message-Id: <1559634942-20369-1-git-send-email-krzk@kernel.org>
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
2.7.4

