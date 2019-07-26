Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE39C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62622CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148618;
	bh=j8UdqbXss2ij3xQo9vuqKrcuT8ASYMeNoVUI7QsGNNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n20HvcQPXYQ+Ikyy0RxyG/lCPQ+DotW/oxolbHptUJFzxHC/0j//ZG7J/KufidbG7
	 tVtespfDMgZVyReFrugCTWu+PdQ2mm4oS0PHqcnRGX+sJz9NwKnLnhd4HvwKbIJQz6
	 FfTUwPisPrl8sIgy1x1PJU5XxsfO+8ug3HOh7sJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfGZNnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbfGZNnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B4222CD0;
        Fri, 26 Jul 2019 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148610;
        bh=j8UdqbXss2ij3xQo9vuqKrcuT8ASYMeNoVUI7QsGNNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdc3XzpPGg+hPZb4NkgDRnRmP5kYMoLQwfMTP0YgDdXsDL434wBN6oHDQhnKwUuzs
         s2YKGcz0GUbeW+RDS7XUDUcf8aqm6Q/wUvH3xtErN5GYFh0U4Vz/DV9HdNLX/1WJa/
         PhpAA/1ZCFHvnPUT2sEn97viHFviNkeyU2mdEeEY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 46/47] x86, boot: Remove multiple copy of static function sanitize_boot_params()
Date:   Fri, 26 Jul 2019 09:42:09 -0400
Message-Id: <20190726134210.12156-46-sashal@kernel.org>
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
index 8dd1d5ccae58..0387d7a96c84 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -17,6 +17,7 @@
 #include "pgtable.h"
 #include "../string.h"
 #include "../voffset.h"
+#include <asm/bootparam_utils.h>
 
 /*
  * WARNING!!
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a423bdb42686..47fd18db6b3b 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -22,7 +22,6 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
-#include <asm/bootparam_utils.h>
 
 #define BOOT_BOOT_H
 #include "../ctype.h"
-- 
2.20.1

