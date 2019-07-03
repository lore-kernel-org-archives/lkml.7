Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDFC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F07E218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ySIPEOGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGCI2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:28:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGCI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:28:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638S2083205103
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:28:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638S2083205103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562142483;
        bh=9UlTJipWCRtOw5/9IBZBryeb5TA2GQdlEvSESszGafI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ySIPEOGI5mK+Gn8qHTjkIwe+1RLMC+ynOGLDKY3Oj54hYncVX+l2VypfxGB3jR1ZV
         pEhP+SyCOi+cImO3ghDgUDHUkEmFsK7aPal67rswvTYdDvExeWkOCZ+XEd2D+ogxpB
         1hXI/ihExpKncZ55Ua5XNLX2J0I6dW6Pr9hZBmEeRm9lvtdyYjOODqUt/S+NgYjACQ
         yhwrPVCBhlDVwIpGEncett0ADrGhFdgWZ7wm0nV3725z2T9hKWUZZ6741YYGsgUM1e
         Fm7L6iNenqmg5p3kevCCikRonjilJNdJNCyxh3F4Y7Fu8RVMachhgd+tFIzB+xruMZ
         X+VPsrtTbrMWA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638S2TQ3205100;
        Wed, 3 Jul 2019 01:28:02 -0700
Date:   Wed, 3 Jul 2019 01:28:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-32232b350d7cd93cdc65fe5a453e6a40b539e9f9@git.kernel.org>
Cc:     namit@vmware.com, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, bigeasy@linutronix.de,
        luto@kernel.org, linux-kernel@vger.kernel.org
Reply-To: luto@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          namit@vmware.com, mingo@kernel.org, bigeasy@linutronix.de
In-Reply-To: <20190701173354.2pe62hhliok2afea@linutronix.de>
References: <20190701173354.2pe62hhliok2afea@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ldt: Initialize the context lock for init_mm
Git-Commit-ID: 32232b350d7cd93cdc65fe5a453e6a40b539e9f9
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

Commit-ID:  32232b350d7cd93cdc65fe5a453e6a40b539e9f9
Gitweb:     https://git.kernel.org/tip/32232b350d7cd93cdc65fe5a453e6a40b539e9f9
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Mon, 1 Jul 2019 19:33:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:25:04 +0200

x86/ldt: Initialize the context lock for init_mm

The mutex mm->context->lock for init_mm is not initialized for init_mm.
This wasn't a problem because it remained unused. This changed however
since commit
	4fc19708b165c ("x86/alternatives: Initialize temporary mm for patching")

Initialize the mutex for init_mm.

Fixes: 4fc19708b165c ("x86/alternatives: Initialize temporary mm for patching")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20190701173354.2pe62hhliok2afea@linutronix.de

---
 arch/x86/include/asm/mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c20..e78c7db87801 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -59,6 +59,7 @@ typedef struct {
 #define INIT_MM_CONTEXT(mm)						\
 	.context = {							\
 		.ctx_id = 1,						\
+		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
 void leave_mm(int cpu);
