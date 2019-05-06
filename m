Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A0EC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B672087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiDkS4zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEFIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfEFIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so6334745pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUGgnBE5twSTtjE0GGP0JI8EGLp+1ZG15lAdVhxxXbA=;
        b=NiDkS4zwWSm38mORkyBURO587JKzxrsID9Zdpb2iq52x87ENYYubMyr4XHTCAHHdKe
         4F1Hh/N4kEMEnzK4B6WLLEft2XkkZPbZi3nYNU269uMoI2Zw7fGQuGQI///0bWewEs/J
         LEvOhx4bKGY7Jcaz8eg+AD5/MNjYUWXLxgxDPtQNXgG8peY9EhRG2JWbE3zuNWpMYCDI
         zDHm8wSZZuw5jt6h7uwzy8U9dPmyWMkTse+ieN98e3MBJ9pOmg9fVuamEpweZ99xIG7f
         wVP1Ax2p3ZlJS/qO1NP8EHUso2ssY6bPxwR0SvdX6moR/jZbBd7aMbdsSEsWKKrxlC/r
         SuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUGgnBE5twSTtjE0GGP0JI8EGLp+1ZG15lAdVhxxXbA=;
        b=BSTk6R1FFNDip5UDbRxEfrOSBTNqTKW+aNzsDfFRMbslhiWu18h0OAG22wieik/7pJ
         bOxEUULqvgAVfVbM7ZzTPndbBBwzc3unWzwV0iohYAYNIDstm4c0pckwJoGGqpKVV3dm
         wKRpq+vXeVbLJV93QbWi3J8kUjLHWXaDqF7BsC/QhB1uS4+t1QAOCL3qqQnqTRA++Uco
         dHJSBHXbVHtEYpqe2I0JDyISQfjCJEtYeTc77J7HcgNrKrL4iKcOFd9ny5UZCUpTasC4
         +H7/vWrdLPBuaBbx3Q7YEEDSMGHJtz3/4dYgLXCpJzrre32JSUiUvdwU3TzGMsw292fP
         g/1w==
X-Gm-Message-State: APjAAAX4zzUPIqtZhLNFOlrQa7TgjzBxzQasSqHKlRPlepW2lUK+B4gg
        ZasVo/jek9yIqleJXzCmkj0=
X-Google-Smtp-Source: APXvYqyybdtAeqlSeH0Ya7dmTpakVRbj0lfuNfo68FjxXOtTWnoBDixz2TvJdCZmsydJaBqIBV9w6Q==
X-Received: by 2002:a63:1354:: with SMTP id 20mr13391683pgt.356.1557130802143;
        Mon, 06 May 2019 01:20:02 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:01 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 04/23] locking/lockdep: Remove useless conditional macro
Date:   Mon,  6 May 2019 16:19:20 +0800
Message-Id: <20190506081939.74287-5-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
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
index 720d195..a0837a0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1669,7 +1669,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return result;
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_TRACE_IRQFLAGS
 
 static inline int usage_accumulate(struct lock_list *entry, void *mask)
 {
@@ -2147,7 +2147,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2828,7 +2828,7 @@ static inline int validate_chain(struct task_struct *curr,
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
-- 
1.8.3.1

