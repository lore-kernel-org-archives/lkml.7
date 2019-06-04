Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C457C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E86243FA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635009;
	bh=D0Qrq4sKFLskuFYhwur8nTIHFHwug4s9KfA3AH5IIkQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zwNzX5X+m7VskNKyaz10ZDOPQ7h3RqTNYnT4c8k4iLLvunZVpq0ewsc8WnhUhy+dS
	 6L25e/MxLM5efCci96W62WdtK9wM0U5yeH5f9FujLQ+ufVWOrjabRmlXQV+GA1ltmU
	 fcIe0nwjv9FBlexdl+lQScP3kauj3bH0Ar5MbSsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFDH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFDH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:56:47 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DAB32423F;
        Tue,  4 Jun 2019 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635007;
        bh=D0Qrq4sKFLskuFYhwur8nTIHFHwug4s9KfA3AH5IIkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=xVvKMrYOtaWwKFKs5IwkiB4m0cHwnsQelrIeHfhtADtWIS60x6+6qZRFfGUQz4FDH
         PFhJEWEMXMZPudRv3VJGfTyBO9hYUMOq6s+4f8YUnknaOeK3FT5QPb9Rctj00z/GI4
         yHM347w1mtdA1/dS0RCXjQ40w/xBq2ovo/Psung4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ia64: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:56:42 +0200
Message-Id: <1559635002-20533-1-git-send-email-krzk@kernel.org>
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
 arch/ia64/configs/generic_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index 81f686dee53c..e7b5927e7b86 100644
--- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -37,7 +37,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 # CONFIG_PNP_DEBUG_MESSAGES is not set
 CONFIG_BLK_DEV_LOOP=m
-- 
2.7.4

