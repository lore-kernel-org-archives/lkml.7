Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFEE2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfC0N2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:28:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfC0N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:28:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2RDS2EJ2873970
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Mar 2019 06:28:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2RDS2JV2873967;
        Wed, 27 Mar 2019 06:28:02 -0700
Date:   Wed, 27 Mar 2019 06:28:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matteo Croce <tipbot@zytor.com>
Message-ID: <tip-b929a500d68479163c48739d809cbf4c1335db6f@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        mingo@kernel.org, mcroce@redhat.com
Reply-To: mcroce@redhat.com, mingo@kernel.org, x86@kernel.org,
          hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
          mingo@redhat.com, tglx@linutronix.de
In-Reply-To: <20190326203046.20787-1-mcroce@redhat.com>
References: <20190326203046.20787-1-mcroce@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/realmode: Don't leak the trampoline kernel
 address
Git-Commit-ID: b929a500d68479163c48739d809cbf4c1335db6f
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

Commit-ID:  b929a500d68479163c48739d809cbf4c1335db6f
Gitweb:     https://git.kernel.org/tip/b929a500d68479163c48739d809cbf4c1335db6f
Author:     Matteo Croce <mcroce@redhat.com>
AuthorDate: Tue, 26 Mar 2019 21:30:46 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 27 Mar 2019 14:22:08 +0100

x86/realmode: Don't leak the trampoline kernel address

Since commit

  ad67b74d2469 ("printk: hash addresses printed with %p")

at boot "____ptrval____" is printed instead of the trampoline addresses:

  Base memory trampoline at [(____ptrval____)] 99000 size 24576

Remove the print as we don't want to leak kernel addresses and this
statement is not needed anymore.

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190326203046.20787-1-mcroce@redhat.com
---
 arch/x86/realmode/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d10105825d57..47d097946872 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -20,8 +20,6 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
 	void *base = __va(mem);
 
 	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
 }
 
 void __init reserve_real_mode(void)
