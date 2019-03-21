Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE9F218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfCULky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:40:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCULky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:40:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBemPq109373
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:40:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBelet109370;
        Thu, 21 Mar 2019 04:40:47 -0700
Date:   Thu, 21 Mar 2019 04:40:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-0f4d3aa761b71cd6984330baca1e18bf0590e441@git.kernel.org>
Cc:     tglx@linutronix.de, tedheadster@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tedheadster@gmail.com, tglx@linutronix.de
In-Reply-To: <1552596361-8967-3-git-send-email-tedheadster@gmail.com>
References: <1552596361-8967-3-git-send-email-tedheadster@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu/cyrix: Remove {get,set}Cx86_old macros
 used for Cyrix processors
Git-Commit-ID: 0f4d3aa761b71cd6984330baca1e18bf0590e441
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

Commit-ID:  0f4d3aa761b71cd6984330baca1e18bf0590e441
Gitweb:     https://git.kernel.org/tip/0f4d3aa761b71cd6984330baca1e18bf0590e441
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Thu, 14 Mar 2019 16:46:01 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:28:50 +0100

x86/cpu/cyrix: Remove {get,set}Cx86_old macros used for Cyrix processors

The getCx86_old() and setCx86_old() macros have been replaced with
correctly working getCx86() and setCx86(), so remove these unused macros.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/1552596361-8967-3-git-send-email-tedheadster@gmail.com

---
 arch/x86/include/asm/processor-cyrix.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/processor-cyrix.h b/arch/x86/include/asm/processor-cyrix.h
index aaedd73ea2c6..df700a6cc869 100644
--- a/arch/x86/include/asm/processor-cyrix.h
+++ b/arch/x86/include/asm/processor-cyrix.h
@@ -3,19 +3,6 @@
  * NSC/Cyrix CPU indexed register access. Must be inlined instead of
  * macros to ensure correct access ordering
  * Access order is always 0x22 (=offset), 0x23 (=value)
- *
- * When using the old macros a line like
- *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
- * gets expanded to:
- *  do {
- *    outb((CX86_CCR2), 0x22);
- *    outb((({
- *        outb((CX86_CCR2), 0x22);
- *        inb(0x23);
- *    }) | 0x88), 0x23);
- *  } while (0);
- *
- * which in fact violates the access order (= 0x22, 0x22, 0x23, 0x23).
  */
 
 static inline u8 getCx86(u8 reg)
@@ -29,11 +16,3 @@ static inline void setCx86(u8 reg, u8 data)
 	outb(reg, 0x22);
 	outb(data, 0x23);
 }
-
-#define getCx86_old(reg) ({ outb((reg), 0x22); inb(0x23); })
-
-#define setCx86_old(reg, data) do { \
-	outb((reg), 0x22); \
-	outb((data), 0x23); \
-} while (0)
-
