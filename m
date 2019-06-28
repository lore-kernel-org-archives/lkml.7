Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4BBC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070F2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiCZtsiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfF1JQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44278 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF1JQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so2653184pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VH86yFaB5XJe7jw+7qGZ7P0YCVRI4LhDxPHcnbIX8ZU=;
        b=tiCZtsiJPbuPaUiAHILfiyYybQLVhAixRn2r8ZMk51dyTyGaQne/szn0kApgP38iGf
         lVd79ATOpPd/0YH/xmzrkAtPifR78f1Nsl8kYLRC9mykYYac95PM78bcGfy0My9g4P77
         ZtZn0CsbUPrqmD4t9NuOohoyPM6HIzaLblLCl1YygT6SFweMk1FTUab597pGeGQkoVAl
         sA+t4piKpotjzJsSLMfSMNXG4mArvAeM81Gp+QEL6K3wnDto6HK3i+f64ehiz5jnvLFa
         2sR9pvRKkQrQxIKLO8O/fbLh9kibR/119lJk1wB8t6DYfubLdCGo8OqZomoeGAYTb0W9
         LdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VH86yFaB5XJe7jw+7qGZ7P0YCVRI4LhDxPHcnbIX8ZU=;
        b=ABpcrLgNtFalZI5WDleirKFdrG++0yaX7iAQ7Y8EJUqhRw4++3X8aCEI7hKEuKhROB
         13weKUvY3/MOXq0zVkLJxPaXSyNWlSW796RO1MR08CCC9NQqB/68QPE3QqYklMgrbEX8
         BmrDWt+K9IFJQIA9vKR6YMbyxvEZ5gKJ5Vv8f/MXfQaSq3PZmGLPbYfxBS7hjrPFHFQX
         rUlcB+Lydu3x+84Gvaks/X3elcJYF698QJTpupRb8w23k4Wp0pk3AJkaM1Fskp/mqy0O
         HcwUTKMl76QRte7o40eIBau3270LlCK2WBOFbUYu9A59iIhac7eWnWlFkoZlbm0E9WVH
         diaA==
X-Gm-Message-State: APjAAAUdr9zCJTvnVXFZPy0F5AJ9ysWbf16wtyu0OyJQi0nElLhk3UDr
        D4mlkzs1jQTbiqDCcg8sFDc=
X-Google-Smtp-Source: APXvYqxUn/BEtaMFPAsRUiYPOmK1YrnbUH4byvfSdBoSGcxq6uNALwchPvPkXChEacFhYkK7FAzEeA==
X-Received: by 2002:a17:90a:372a:: with SMTP id u39mr11887122pjb.2.1561713388854;
        Fri, 28 Jun 2019 02:16:28 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:28 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 10/30] locking/lockdep: Remove useless lock type assignment
Date:   Fri, 28 Jun 2019 17:15:08 +0800
Message-Id: <20190628091528.17059-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next lock to acquire has its lock type set already, so there is no
need to reassign it regardless of whether it is recursive read.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e2ad673..095e532 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2846,13 +2846,6 @@ static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
 		if (!ret)
 			return 0;
 		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
-		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-- 
1.8.3.1

