Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D27C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028EE2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNlEyEgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfEFIVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:21:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43950 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfEFIVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:21:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so6082241pgi.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxG1O4WWZxwFIRqkhxWEPqmVT9qEXuTD/gGlj/tlLpY=;
        b=rNlEyEgKW6hDoDHLX1fSr9fvlWUxtHa2VzHauzurG1LLg2qyLoh6pvJ+9Hx4oWzRbM
         FvSdAuMncfV9vcjlZDNcgXwOgntveG6ft1R7AeFmpe04Fx9ke6OWChd/OzJJcs+1pGmA
         /EOlea2I/IYveP8rNmifPzg4aVKduwNJA+5flBQilwBSutmZAOziGf+WIrVODD0jeDDc
         HJJTfpcvHI8rzB1RGSaVe9AUPFsdoMu32gb/OvGDrYiGO+c3gMCfHSPr0GBfCIXmdVTD
         J3DjOCwiqOAcdbe92gI04Ar1jIrM6yQuwmMYCeDRw1wnY3qvDKYVwvJNFSnFrKm7FZ1y
         Lknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxG1O4WWZxwFIRqkhxWEPqmVT9qEXuTD/gGlj/tlLpY=;
        b=ehFgqr39nfSg8OkqK/4pnEwHhh+z/nTGXIuiFyrbqDkFc+/2elri9OLbdOxJ/7Qvkq
         7YjhwONUpNlAKw2yyQncA/5qxbD+X80LhGI0y+MeG0MiF8yRlLVZ4QQBRUYmjg0cGK12
         DRyXUj0QjHQGiCmEDNtEo1zxdtbW8IzAuJZiTLg0l4Dg0HTS2RDyVqrY/DeSlsjge1SP
         PTaCntSMgICcXy0EptraSOHGK6AsZbXnAQXck5SjGt8c7d7r6MoxRDTtQx6g3xBEfyJ2
         4YBAygfcoDNgF//lXAR+GqWl7fZ5IMFJk0/e9c1i+VUSSKnCkvObgDTgONEL4KiFRGDk
         tQtw==
X-Gm-Message-State: APjAAAVSbTD1pnyxlRLDskA8s6yUSMzZ+sY8xzpNsD9J06Gc/mqMKzXM
        ZvK0OelX5oc3fjhAJCpQwm0=
X-Google-Smtp-Source: APXvYqy8oPFmoJ0+3Yv6z8UJPjmBg6ptnYHJlV3AThNTOQ4AIMorgVWk/L5VgnWZMUy+OkAZLrJBsQ==
X-Received: by 2002:aa7:80d0:: with SMTP id a16mr32496632pfn.206.1557130859204;
        Mon, 06 May 2019 01:20:59 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:58 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 22/23] locking/lockdep: Adjust new bit cases in mark_lock
Date:   Mon,  6 May 2019 16:19:38 +0800
Message-Id: <20190506081939.74287-23-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new bit can be any possible lock usage except it is garbage, so the
cases in switch can be made simpler. Warn early on if wrong usage bit is
passed without taking locks. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 79bc6cd..24e3bca 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3581,6 +3581,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
 
+	if (new_bit >= LOCK_USAGE_STATES) {
+		DEBUG_LOCKS_WARN_ON(1);
+		return 0;
+	}
+
 	/*
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
@@ -3604,25 +3609,13 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		return 0;
 
 	switch (new_bit) {
-#define LOCKDEP_STATE(__STATE)			\
-	case LOCK_USED_IN_##__STATE:		\
-	case LOCK_USED_IN_##__STATE##_READ:	\
-	case LOCK_ENABLED_##__STATE:		\
-	case LOCK_ENABLED_##__STATE##_READ:
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
-		break;
 	case LOCK_USED:
 		debug_atomic_dec(nr_unused_locks);
 		break;
 	default:
-		if (!debug_locks_off_graph_unlock())
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
 			return 0;
-		WARN_ON(1);
-		return 0;
 	}
 
 	graph_unlock();
-- 
1.8.3.1

