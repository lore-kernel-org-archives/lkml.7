Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73242175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trrMIzR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfDXKUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34624 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfDXKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so9178960pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lw0o9j9VIAN1GrG4IFYyY9YZcauz4Vi1nMZzr+KIlp0=;
        b=trrMIzR6ygBF8Kkv4Dcn8SX7mnZZVwQtZqgGIoqwkpWifusVXUMSkqUEE3TtYbMmqN
         n4apmq5qM7ixcscxHjT5AtU1LAniyDusQmcGvygcJfKlLWfOJnWHi+Dt8JB3UExgMqVj
         2o1wo/XnPgqnDFMSTZEZjqv+lvaIYoBwdMsbt/yrA0mUKG6fl7L2rPd3oYkzsiPN0IaW
         6hlxtLuk47tzwOFGv9TVUnchxLGYcXDU2m3CKEunUu869aq5ZesrUgIylzjA1XBow+5p
         cL4/jzxZ5CZhif0956EyJ4YH74Ex3ts9d7f6Le51ySMKwBYteWs5YfjTKsrdic9Ioa2s
         YiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lw0o9j9VIAN1GrG4IFYyY9YZcauz4Vi1nMZzr+KIlp0=;
        b=P+/e34ghCwEv+3FfSC84sF/CSc9bDYfx3GPxOrHE1VH4u8qgE10PZyRq6nP0VVU1oh
         bZUDxjvPTC+ZbgcsCmr0SQDz6CwhSliYnB5CsNLTkEKCu9cSl8S5vttiiAfmVtLHbYMx
         H+seXpcT2Gx4iksigRViPgBksrXerr2ONg8gkM/9dkU8g9u8Jn9KCCX4LZRCrW3ykoVd
         0tl8Jkdw2Ei7ti1yHgrgV0x7wAToYgTjm1SiXkkGy2L+pfpUdsI8LHJbXE2ePj0r8pi4
         FnBxCQ44jm0rndqL5WVbolhxy+urD6h2sJA7x60t0MeDau1o8MvOfM922eWip7MJKVZf
         f8Rg==
X-Gm-Message-State: APjAAAVW6ItFfN/EkAlY5NzRIUAEVuc0X8zNawMqE1iHvlyZ9C/rDWN8
        68RATdfyXck23B/k9+7828lW5syxZRLbdA==
X-Google-Smtp-Source: APXvYqzC5psIE5MqMS4ov17PmEKThePvqXjSAGwZHjAjgVXgHe5Uhbp0Ql8cEOO+qhL1g48nMMfm0A==
X-Received: by 2002:a62:a515:: with SMTP id v21mr33079364pfm.41.1556101240414;
        Wed, 24 Apr 2019 03:20:40 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:39 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 04/28] locking/lockdep: Remove useless conditional macro
Date:   Wed, 24 Apr 2019 18:19:10 +0800
Message-Id: <20190424101934.51535-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #defined(CONFIG_PROVE_LOCKING) is used in the scope of #ifdef
CONFIG_PROVE_LOCKING, it can be removed.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ba0080a..2cc2a15 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1669,7 +1669,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 /*
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
@@ -2050,7 +2050,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2723,7 +2723,7 @@ static inline int validate_chain(struct task_struct *curr,
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
-- 
1.8.3.1

