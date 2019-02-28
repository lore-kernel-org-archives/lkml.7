Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B027C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA0218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfB1T1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:27:50 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.109]:15733 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfB1T1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:27:50 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 93D58336A0F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:27:48 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id zRLQgGMrIiQerzRLQgSkWR; Thu, 28 Feb 2019 13:27:48 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=56084 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gzRLP-000ePX-DP; Thu, 28 Feb 2019 13:27:47 -0600
Date:   Thu, 28 Feb 2019 13:27:46 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190228192746.GA13021@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gzRLP-000ePX-DP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:56084
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough by default, mark
switch-case statements where fall-through is intentional, explicitly
in order to fix a bunch of -Wimplicit-fallthrough warnings.

In order to get the warnings mentioned above, the following
line was added to the top Makefile:

KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough=3,)

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Expand commit text as requested by Thomas Gleixner.
 - Add Kees' Reviewed-by.

 arch/x86/include/asm/syscall.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index d653139857af..04fc5c120558 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -125,23 +125,30 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			*args++ = regs->bx;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			*args++ = regs->cx;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			*args++ = regs->dx;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			*args++ = regs->si;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			*args++ = regs->di;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			*args++ = regs->bp;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -152,23 +159,30 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			*args++ = regs->di;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			*args++ = regs->si;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			*args++ = regs->dx;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			*args++ = regs->r10;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			*args++ = regs->r8;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			*args++ = regs->r9;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -186,23 +200,30 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			regs->bx = *args++;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			regs->cx = *args++;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			regs->dx = *args++;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			regs->si = *args++;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			regs->di = *args++;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			regs->bp = *args++;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
@@ -213,23 +234,30 @@ static inline void syscall_set_arguments(struct task_struct *task,
 		case 0:
 			if (!n--) break;
 			regs->di = *args++;
+			/* fall through */
 		case 1:
 			if (!n--) break;
 			regs->si = *args++;
+			/* fall through */
 		case 2:
 			if (!n--) break;
 			regs->dx = *args++;
+			/* fall through */
 		case 3:
 			if (!n--) break;
 			regs->r10 = *args++;
+			/* fall through */
 		case 4:
 			if (!n--) break;
 			regs->r8 = *args++;
+			/* fall through */
 		case 5:
 			if (!n--) break;
 			regs->r9 = *args++;
+			/* fall through */
 		case 6:
 			if (!n--) break;
+			/* fall through */
 		default:
 			BUG();
 			break;
-- 
2.21.0

