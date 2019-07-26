Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF48C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA6222CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149256;
	bh=6KIks1I9K7slzZ4k7PGXXjS0icOWDo+AY22dArQQoVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYgoCsMVb6Pfotdop5swbHZR9PXROMZEucLls02hplFh3n8GmWQGojKFo4Ox/xhIu
	 XXljgsmX6nqXiJ45OwxGkWh0TCaiXcObfFjqpYELmwEyrOFpljh1Y6+5Or6B76zpZG
	 5A8N7yNB/6xMDwJYKb84Hd2wUvpMggD1c85RmvWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfGZNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbfGZNmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:42:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5916122CC0;
        Fri, 26 Jul 2019 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148570;
        bh=6KIks1I9K7slzZ4k7PGXXjS0icOWDo+AY22dArQQoVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXxlcfIs+mWNOn34rNwJAc6a7TsI0neVQLcO6XwSodI/EiVdAchyh7wPUZtTrBEXd
         cZ/0dylnAmNU41kryiCVBWoNuqJ6neg0wbvHkYNtWlg31SHwui3pRy28nZmG7gxiIj
         aSMHMrJyRPQS6lB/2YTQSEOUmteNzgTLtyd3Anvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 25/47] ACPI: fix false-positive -Wuninitialized warning
Date:   Fri, 26 Jul 2019 09:41:48 -0400
Message-Id: <20190726134210.12156-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit dfd6f9ad36368b8dbd5f5a2b2f0a4705ae69a323 ]

clang gets confused by an uninitialized variable in what looks
to it like a never executed code path:

arch/x86/kernel/acpi/boot.c:618:13: error: variable 'polarity' is uninitialized when used here [-Werror,-Wuninitialized]
        polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
                   ^~~~~~~~
arch/x86/kernel/acpi/boot.c:606:32: note: initialize the variable 'polarity' to silence this warning
        int rc, irq, trigger, polarity;
                                      ^
                                       = 0
arch/x86/kernel/acpi/boot.c:617:12: error: variable 'trigger' is uninitialized when used here [-Werror,-Wuninitialized]
        trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
                  ^~~~~~~
arch/x86/kernel/acpi/boot.c:606:22: note: initialize the variable 'trigger' to silence this warning
        int rc, irq, trigger, polarity;
                            ^
                             = 0

This is unfortunately a design decision in clang and won't be fixed.

Changing the acpi_get_override_irq() macro to an inline function
reliably avoids the issue.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/acpi.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index de8d3d3fa651..b4d23b3a2ef2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -326,7 +326,10 @@ void acpi_set_irq_model(enum acpi_irq_model_id model,
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-#define acpi_get_override_irq(gsi, trigger, polarity) (-1)
+static inline int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
+{
+	return -1;
+}
 #endif
 /*
  * This function undoes the effect of one call to acpi_register_gsi().
-- 
2.20.1

