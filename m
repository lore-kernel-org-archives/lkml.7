Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E9C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C76F22CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149480;
	bh=iwQDFSN7zjXide0iIrgB2USrYsqXeWDcsDEBy8CQEoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHJd962dJfJRXjAhy659Y12l5Yk/XUnt1fDzIYp0Kq4qzO0lIVlXHxEgkHiJjy+gL
	 v6X0DhZLAPrLJMkb4DmKR1wVIlYx6jWqq6x5Rre/u/NoJox/aPoVtpyGKYHkyiJfSp
	 xaGHXbaBBGYETNyTcGT3dHOkjeYn44gp4GUO0JUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbfGZNkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387567AbfGZNkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E659622CBD;
        Fri, 26 Jul 2019 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148446;
        bh=iwQDFSN7zjXide0iIrgB2USrYsqXeWDcsDEBy8CQEoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcIAIJzYsfw4zArWmwqg2xoB04Isf2ePeWyfNkwUd2NDjEBBPLqQdFttj0O00611q
         L/p5W5UyX5ON3pVAF3CuaPs/kVX5xn5BuYV9vcw+tEhaRdqg7QwEzhe+9yqGrEjx2a
         D0DsbOM/kL/5SjgHMQjgv/WBt2Irrc/qz2k0tZ/U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 44/85] ACPI: fix false-positive -Wuninitialized warning
Date:   Fri, 26 Jul 2019 09:38:54 -0400
Message-Id: <20190726133936.11177-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
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
index d315d86844e4..872ab208c8ad 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -317,7 +317,10 @@ void acpi_set_irq_model(enum acpi_irq_model_id model,
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

