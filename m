Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA95C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BCD22D37
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149008;
	bh=VAAcgzlTSNbXDwOTW5wflG1mcZbHh+1fNnpw+vBm8qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LeUeo22hdGJZQ6KOPhLPomDlWS2u3SGndhIXUjRaQMjUytTAqXF4tYy2bWM4c5Lv9
	 hJS6BHb4LybLdAE1vhe0I4yhZ+XUcRXk9TxGoKcHmiXZNk+0hh0A14rCpaJUuJvcCG
	 kwX/i8w6N48TmyTHogA/egTzy0ift+uES8MLwCg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfGZNog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388346AbfGZNob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6F122CD7;
        Fri, 26 Jul 2019 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148670;
        bh=VAAcgzlTSNbXDwOTW5wflG1mcZbHh+1fNnpw+vBm8qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcU51rXW3GynLIcPoHKXHeFwX3r1slnxifVEkIGemjwIRh+NOgnWuU8LpS9kABtzE
         ydSeoKT6Wdo6tn1edR1s+14EPnkkwUxdB79jK//s7JBZcfvkqSkYxiIMeeGXM5Lbr5
         iNKHeLZVe2n/q3LhfPqlYhohwRl5lFpFEPRT0ZoQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 36/37] x86, boot: Remove multiple copy of static function sanitize_boot_params()
Date:   Fri, 26 Jul 2019 09:43:31 -0400
Message-Id: <20190726134332.12626-36-sashal@kernel.org>
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

From: Zhenzhong Duan <zhenzhong.duan@oracle.com>

[ Upstream commit 8c5477e8046ca139bac250386c08453da37ec1ae ]

Kernel build warns:
 'sanitize_boot_params' defined but not used [-Wunused-function]

at below files:
  arch/x86/boot/compressed/cmdline.c
  arch/x86/boot/compressed/error.c
  arch/x86/boot/compressed/early_serial_console.c
  arch/x86/boot/compressed/acpi.c

That's becausethey each include misc.h which includes a definition of
sanitize_boot_params() via bootparam_utils.h.

Remove the inclusion from misc.h and have the c file including
bootparam_utils.h directly.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1563283092-1189-1-git-send-email-zhenzhong.duan@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 1 +
 arch/x86/boot/compressed/misc.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 252fee320816..fb07cfa3f2f9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -16,6 +16,7 @@
 #include "error.h"
 #include "../string.h"
 #include "../voffset.h"
+#include <asm/bootparam_utils.h>
 
 /*
  * WARNING!!
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 32d4ec2e0243..5380d45b1c6e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -19,7 +19,6 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
-#include <asm/bootparam_utils.h>
 
 #define BOOT_BOOT_H
 #include "../ctype.h"
-- 
2.20.1

