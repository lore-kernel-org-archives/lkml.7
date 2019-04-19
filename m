Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890CDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F5820643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BwxllDd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDSTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbfDSTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFwknE334341
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:58:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFwknE334341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689527;
        bh=AAV3ry0AzgbUpVWD30jm1mnozefBAWDO5zImAOTMiTg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BwxllDd1r58T3fxGM7ssCyIrJBiLcSeZHqbwN+OQcd3EsNGjWy+SUo1ZmmFER95Gc
         2+znB5lpbHnRV9rdvvHnQMmze+XMy8Ys1DXeVzHMXc9YSqaQiuRF7Xaa1bPzNKzI2i
         /c/ccCP1sxiumsoEl/RkHPywQXw6kNYsmUXRz8eNd3bPCa4TYaC8lENJWgMKNvsAqK
         S0g8f4hxlnAc0pnqZ+bjsN0ziZ05UFf/iYORAIpaUp3kXzJ9qQj3jsWAAJn524voul
         ySQTM5p0mz5asipkxzbbtBsyyF1aABwnzPLh2Ox8XDjryTR8S0ZlOI3KMmgNrfjs39
         a+UgoZ6k7bq7w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFwk89334338;
        Fri, 19 Apr 2019 08:58:46 -0700
Date:   Fri, 19 Apr 2019 08:58:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-6ea26c21941cc313bc05f340019fe454900d21bd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, hpa@zytor.com, mhiramat@kernel.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          mhiramat@kernel.org
In-Reply-To: <20190330004743.29541-7-andi@firstfloor.org>
References: <20190330004743.29541-7-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/kprobes: Make trampoline_handler() global and
 visible
Git-Commit-ID: 6ea26c21941cc313bc05f340019fe454900d21bd
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

Commit-ID:  6ea26c21941cc313bc05f340019fe454900d21bd
Gitweb:     https://git.kernel.org/tip/6ea26c21941cc313bc05f340019fe454900d21bd
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:41 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:55:30 +0200

x86/kprobes: Make trampoline_handler() global and visible

This function is referenced from assembler, so in LTO
it needs to be global and visible to not be optimized away.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20190330004743.29541-7-andi@firstfloor.org

---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..a7b2a5c4d969 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -751,7 +751,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 /*
  * Called from kretprobe_trampoline
  */
-static __used void *trampoline_handler(struct pt_regs *regs)
+__used __visible void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
