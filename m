Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010A20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCFV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:58:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:58:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26LwBLV1897174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 13:58:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26LwA6p1897171;
        Wed, 6 Mar 2019 13:58:10 -0800
Date:   Wed, 6 Mar 2019 13:58:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Louis Taylor <tipbot@zytor.com>
Message-ID: <tip-e4a0bd0308f05c1354d28feec8439e869eae6372@git.kernel.org>
Cc:     louis@kragniz.eu, tglx@linutronix.de, natechancellor@gmail.com,
        mingo@kernel.org, hpa@zytor.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, ndesaulniers@google.com,
          linux-kernel@vger.kernel.org, louis@kragniz.eu,
          tglx@linutronix.de, natechancellor@gmail.com
In-Reply-To: <20190302184929.28971-1-louis@kragniz.eu>
References: <20190302184929.28971-1-louis@kragniz.eu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Always return a value from
 process_mem_region
Git-Commit-ID: e4a0bd0308f05c1354d28feec8439e869eae6372
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

Commit-ID:  e4a0bd0308f05c1354d28feec8439e869eae6372
Gitweb:     https://git.kernel.org/tip/e4a0bd0308f05c1354d28feec8439e869eae6372
Author:     Louis Taylor <louis@kragniz.eu>
AuthorDate: Sat, 2 Mar 2019 18:49:29 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 22:55:30 +0100

x86/boot/KASLR: Always return a value from process_mem_region

When compiling with -Wreturn-type, clang warns:

arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
      non-void function [-Wreturn-type]

This function's return statement should have been placed outside the
ifdeffed region. Move it there.

Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")
Signed-off-by: Louis Taylor <louis@kragniz.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: bhe@redhat.com
Cc: kirill.shutemov@linux.intel.com
Cc: jflat@chromium.org
Link: https://lkml.kernel.org/r/20190302184929.28971-1-louis@kragniz.eu
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index fa0332dda9f2..2e53c056ba20 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -697,8 +697,8 @@ static bool process_mem_region(struct mem_vector *region,
 			return 1;
 		}
 	}
-	return 0;
 #endif
+	return 0;
 }
 
 #ifdef CONFIG_EFI
