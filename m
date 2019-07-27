Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C18C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC22086D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="gdQJKM3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfG0Q5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:57:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35627 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfG0Q5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:57:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so25900201plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSiTEs4GnvQUthZXAEw0M0m3Gr1AaMhHdaiJba5YFEQ=;
        b=gdQJKM3LtB1pYFZIldqGVPKVqPJ0g9e7coADlJlyLx0D1YI6BPBgwX4/nESQpdzhDS
         RDuFhvZT1tRJrTT/h+F3+pqeppKWDkkSiWyq6Fi4XYraB85kwz+4edHSCD1Eq6I0gGQm
         +jPjJ60wLdc+YR9hdeLGQcvOqAp4L8PZD+eKQ29XIAP+RkcBfyCkxRoSyHAamb3k88QK
         g1iHHyVlca6CQK9SRWHpTsLtXEopSB3d2+zXvpTuxTWU+EGFLhxjUn2gJ2Vr3XJWs+Q3
         p00BIEdfUup642WBu/dAiV7fUTb26XC+wRctswvapjTXhBALHz2Lj6+bzRM9kJ2MFqIX
         wF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CSiTEs4GnvQUthZXAEw0M0m3Gr1AaMhHdaiJba5YFEQ=;
        b=N0SxqSZamogDy+GlmINUCm1wowDkGb3IBqDzD6Jy6A/U2dKEdNVSf8l/jWA8p3A2FB
         rl3gCjmmdUQqFV/Z728RPVHF35JeMUV2DzzAQNeMTBAGw2koPziKcpZezd6SRfnTbN/4
         EEzWERspHmLu/2rFM4grkhmAJZfStNdrR2MpRCMGkrbTsPNUeb8KMoeJnib577d3sRfW
         RTVoJumT3qMxbHR/SHNMeJsTvO6FKQTJqbe8PchISJJj8nDJi4ns2k/hoP+yAU1FggzJ
         THX6T1eTa9+qXLzqSe52Yt2pSmIe1fxWC0pkpG6fk6ho+3QytEBDaxskSd0YCR/MOXSy
         nCfg==
X-Gm-Message-State: APjAAAWanavJsp9UQ9BZXfS9LmMPXfIul86Vx7Ar/maqk7aOp+wIw9rB
        1k2m1I4qIfusNOhaqkdtxug=
X-Google-Smtp-Source: APXvYqxt3y1uXvPN4NlxBkzbEVyYtwFJ5bY/z9lHGeUmITYZrhcM0WbtYKdSOnhpwa0280GLiXnvLA==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr100874121plb.108.1564246656467;
        Sat, 27 Jul 2019 09:57:36 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id 10sm62412034pfb.30.2019.07.27.09.57.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 09:57:35 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] sched/core: Remove the unused schedule_user() function
Date:   Sun, 28 Jul 2019 01:55:13 +0900
Message-Id: <20190727165513.25636-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 02bc7768fe44 ("x86/asm/entry/64: Migrate error and IRQ exit
work to C and remove old assembly code"), it's no longer used.

Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/sched/core.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..0079bebe0086 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3973,25 +3973,6 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
-asmlinkage __visible void __sched schedule_user(void)
-{
-	/*
-	 * If we come here after a random call to set_need_resched(),
-	 * or we have been woken up remotely but the IPI has not yet arrived,
-	 * we haven't yet exited the RCU idle mode. Do it here manually until
-	 * we find a better solution.
-	 *
-	 * NB: There are buggy callers of this function.  Ideally we
-	 * should warn if prev_state != CONTEXT_USER, but that will trigger
-	 * too frequently to make sense yet.
-	 */
-	enum ctx_state prev_state = exception_enter();
-	schedule();
-	exception_exit(prev_state);
-}
-#endif
-
 /**
  * schedule_preempt_disabled - called with preemption disabled
  *
-- 
2.21.0

