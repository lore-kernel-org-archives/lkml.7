Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD03C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBD921019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568141178;
	bh=rQ/nvK3T9rENRRBG/OIG+/iIDCn7OyCZ4JAA2hbwlf8=;
	h=From:To:Subject:Date:List-ID:From;
	b=P6v2CTiAqllplRNL2Yuc4UkYd0vgrynE71ijqgNTs7U+zD18uDAPkI/Jpac5L8jpc
	 LczjKBCKL1z46vcOwtfxDpY/7qpLOEP4iyvi7bGXcNurzU+MRTk6ktfm4/mJadD1YR
	 E1twanPTrPrgffXqqjLhHX7T8z0uJdtgYMeuxCg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfIJSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfIJSqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:46:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7DF2084D;
        Tue, 10 Sep 2019 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568141176;
        bh=rQ/nvK3T9rENRRBG/OIG+/iIDCn7OyCZ4JAA2hbwlf8=;
        h=From:To:Subject:Date:From;
        b=F9pwHGOzODffz54jObJUi5RmOvoC49GZ2Uq69cWJmiDkebXOFkE6n6Cv6doNUrs2k
         ZcGqaUxqWSG/NBp3/LP3UiaoEKoU+dZSH+oDEP64WHC9hJUHvrH9zcUL2jsw/O9uUW
         yYqoq9zcdYb7USbibjI3TqhRQq+4Ga6BwsPkQzQY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] ia64: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue, 10 Sep 2019 20:46:05 +0200
Message-Id: <20190910184605.21959-1-krzk@kernel.org>
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
 arch/ia64/configs/generic_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index 661d90b3e148..d60851066389 100644
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
2.17.1

