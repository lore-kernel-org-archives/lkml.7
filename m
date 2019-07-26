Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF8122CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149089;
	bh=vzNNaYikDY21v23/2zO3IPUtpcgrGZDW0AIPcGzNqA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJiqILdTcF1wL7hlgA7froPQPhdOnXxhLQgqSFRM4SFkp4DX1ZqcN01MuzJg/J9iY
	 GhxNiei4BIj6GYZ56U8BUmjTCFlQN/2rP2q/fcIFF6UKx90MZ57gNThbBfyJzNlAF3
	 5Lzlfol/CEY5waJoQKqw00BalyDc1mMKSUV5TY2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGZNv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfGZNnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB44F22BF5;
        Fri, 26 Jul 2019 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148632;
        bh=vzNNaYikDY21v23/2zO3IPUtpcgrGZDW0AIPcGzNqA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOmDqrtj4oVBkidZnkzhNq+Y5NXnscfqIYPqN2zRixs/WcVWsqRs4Gwd8GUivU3dL
         TixBA+kcHCivm0ynX0RhNPCqVwyWNbzWbLWapHHOgYhWsXvcDYFUiEMR0pXo8ZeyIF
         GrlpdqFTWN+XJUIPdgNanC3iU5LsAqC6u7d+LsNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 15/37] ACPI: blacklist: fix clang warning for unused DMI table
Date:   Fri, 26 Jul 2019 09:43:10 -0400
Message-Id: <20190726134332.12626-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134332.12626-1-sashal@kernel.org>
References: <20190726134332.12626-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b80d6a42bdc97bdb6139107d6034222e9843c6e2 ]

When CONFIG_DMI is disabled, we only have a tentative declaration,
which causes a warning from clang:

drivers/acpi/blacklist.c:20:35: error: tentative array definition assumed to have one element [-Werror]
static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;

As the variable is not actually used here, hide it entirely
in an #ifdef to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/blacklist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 995c4d8922b1..761f0c19a451 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -30,7 +30,9 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_DMI
 static const struct dmi_system_id acpi_rev_dmi_table[] __initconst;
+#endif
 
 /*
  * POLICY: If *anything* doesn't work, put it on the blacklist.
@@ -74,7 +76,9 @@ int __init acpi_blacklisted(void)
 	}
 
 	(void)early_acpi_osi_init();
+#ifdef CONFIG_DMI
 	dmi_check_system(acpi_rev_dmi_table);
+#endif
 
 	return blacklisted;
 }
-- 
2.20.1

