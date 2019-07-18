Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F95C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2E208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ncseqEI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfGRTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:47:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391704AbfGRTr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:47:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJloer2136718
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:47:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJloer2136718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563479270;
        bh=1Je2KUaiTya9zcT84RXi+zABJ3OIOKD3Bvd4vMnat3M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ncseqEI2Dv6A4QrQeSmAo0tVV3TtWmiB/vWcumkHlEt19BdWWNNvCGwVctBsjVcRw
         MBvLlipeS7qn9ybtSiXYh3TUBjRVbjM0QdI0NtpevUke+gbnoxb7gjjaGZF8MHjdhc
         UJZZkjdoRcqhx3KZA//Vj5ewZb4c2zcLQ9D0oIbiLPuLHr1l8IdB8++LkufwkTa7BX
         pVcCtPWgkgsH2kQ+4xKiaUT9hq5iwzWmTOiefKlPlcLEGGziDQWmbJURHYl6D8pfdt
         /sTRYEsB7IbJPTzWZ7HMsMUocfiSvhDZu51TpQz7Wc6Wfnvflz61iOqfSv+dNT1ZrA
         MUc1NqAFF1xFQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJloCZ2136715;
        Thu, 18 Jul 2019 12:47:50 -0700
Date:   Thu, 18 Jul 2019 12:47:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-8c5477e8046ca139bac250386c08453da37ec1ae@git.kernel.org>
Cc:     hpa@zytor.com, zhenzhong.duan@oracle.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: zhenzhong.duan@oracle.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1563283092-1189-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1563283092-1189-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86, boot: Remove multiple copy of static function
 sanitize_boot_params()
Git-Commit-ID: 8c5477e8046ca139bac250386c08453da37ec1ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8c5477e8046ca139bac250386c08453da37ec1ae
Gitweb:     https://git.kernel.org/tip/8c5477e8046ca139bac250386c08453da37ec1ae
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Tue, 16 Jul 2019 21:18:12 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:41:57 +0200

x86, boot: Remove multiple copy of static function sanitize_boot_params()

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

---
 arch/x86/boot/compressed/misc.c | 1 +
 arch/x86/boot/compressed/misc.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 24e65a0f756d..53ac0cb2396d 100644
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
index d2f184165934..c8181392f70d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,7 +23,6 @@
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
-#include <asm/bootparam_utils.h>
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
