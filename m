Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5038AC73C43
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259BD21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QdGxTeui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGIMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:03:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGIMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:03:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69C2nmN1901935
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 05:02:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69C2nmN1901935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562673770;
        bh=/2x53xsaYjEwZKhCR+Lna7knUXf4AE91SwNYN698RMw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QdGxTeui5l/K6vaqHAAl4eSFbofhRjow3vkmtkZMSaXn9htXgW2hUGymop60E6/XN
         P5UuumlSlesvzF0V8J71XrkdvAfEzkj800SnrBC181ACLBckX16rjXgQn72QNwO5bC
         6dZI870m6T7a/HIKZTOARdhe1CLxMb5MuaWfml4sdZzlqEsu7ZHNCe2mu/VLftkKil
         9qXFUIvGlc7utnXGaaycDS/8FPUbt4UZB9WpzBUoyG9R4jDV8QnqooB0UYk46hKLrO
         rR7ir7/NuOQ/CGa3lJ65rxJyp3QGzfIJPv8XQNWhIkhqnFodOCJgqvA4CYDlZwqv6K
         6c7LqcBtEZjpA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69C2nNm1901932;
        Tue, 9 Jul 2019 05:02:49 -0700
Date:   Tue, 9 Jul 2019 05:02:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-39ca5fb4920a96eeab478be2cfa6a2369fef6b02@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, namit@vmware.com
Reply-To: hpa@zytor.com, peterz@infradead.org, luto@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, namit@vmware.com,
          tglx@linutronix.de, bigeasy@linutronix.de
In-Reply-To: <20190701173354.2pe62hhliok2afea@linutronix.de>
References: <20190701173354.2pe62hhliok2afea@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ldt: Initialize the context lock for init_mm
Git-Commit-ID: 39ca5fb4920a96eeab478be2cfa6a2369fef6b02
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

Commit-ID:  39ca5fb4920a96eeab478be2cfa6a2369fef6b02
Gitweb:     https://git.kernel.org/tip/39ca5fb4920a96eeab478be2cfa6a2369fef6b02
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Mon, 1 Jul 2019 19:33:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Jul 2019 13:57:27 +0200

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
