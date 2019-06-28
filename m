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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350BCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A11B214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOwALMmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfF1JRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42688 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF1JRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so2310846pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLUTJXLdQkLyhFcrj8g3pP1Z0g9YIhydqET4TRsDxNk=;
        b=AOwALMmPpDr219fQzQ4YfjSbYTm/+nRHtRNkmz3vdiEvs62orPSK80qJKwKUaxcHl5
         PDnwgd6BfTM+6ivi/UZ15WHTqyXjv0izdDKT3h1YZ/LfQyD6sGEFvTY2sfu6TJ3lMhnE
         D+MlnW/Zdp59Z0Vwx824oLGwwZdCNcB5h9V0eO6vuGBY7aB4wCovuX1vCmfGewYyHEbx
         TtsQ9QgB7cCeXxnlnUVY7Tm2wAx9WW9Ehip4JA31b5Dz84ockgvP8IaY9yU7DrQtOBsw
         xOxEWzP2gLdUL+myP4AXgfzSI7cxalVwzauePkljACdt7y/TrPi5Wyl4X4bnlQa0VFJ5
         nUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLUTJXLdQkLyhFcrj8g3pP1Z0g9YIhydqET4TRsDxNk=;
        b=e5Oub2P1rvIMGx24gI/+nXrEracgCe4ccYV9/6d9H8n48sjXuFFFrtKkvvpWblF53d
         +CNlV4MLgbF+g0lRgXHf4zPE8nrW1+boGaJIqyY8QmLndRrbKGa/UV0JgolwmOTucYDK
         N8yzANNy9Qvjeg14cN+gGnv+DMu0IaIjnd6XfnORyyyIJEbSJizoj5aTGP+QjhrnH5/B
         xiKAyYaG1zjPOYi7AsqvuxLTbNS8dg9x4O4Mry3bDGQu0OTN53ProTMg8SdwTmirXW2c
         vNk0UINFPFK1GSmLD5gU4s5ew0qbO+dXctY56fRWgrmSP+li8u3OmCVik3+dSPGP+TGy
         sDKg==
X-Gm-Message-State: APjAAAUDg0VXjfrJUSfiaqBMKsdDTTwseVc++cDzVkPEL8reZOWbuOKv
        gUwQlTsDu0vhmVxbt/uZKaY=
X-Google-Smtp-Source: APXvYqyYxvE7b1CBBlH1MlGCRdlM7n+xKStNN87rxPXf4yXPozHnDLk5K9fsRWxXziE2FFj2sQRPJQ==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr12038375pjf.86.1561713454883;
        Fri, 28 Jun 2019 02:17:34 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:34 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 25/30] locking/lockdep: Add nest lock type
Date:   Fri, 28 Jun 2019 17:15:23 +0800
Message-Id: <20190628091528.17059-26-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a macro LOCK_TYPE_NEST for nest lock type and mark the nested lock in
check_deadlock_current(). Unlike the other LOCK_TYPE_* enums, this lock type
is used only in lockdep.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 7 +++++--
 kernel/locking/lockdep_internals.h | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e7610d2..cb3a1d3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2517,6 +2517,7 @@ static inline void inc_chains(void)
  *  0: on deadlock detected;
  *  1: on OK;
  *  LOCK_TYPE_RECURSIVE: on recursive read
+ *  LOCK_TYPE_NEST: on nest lock
  */
 static int
 check_deadlock_current(struct task_struct *curr, struct held_lock *next)
@@ -2546,7 +2547,7 @@ static inline void inc_chains(void)
 		 * nesting behaviour.
 		 */
 		if (nest)
-			return LOCK_TYPE_RECURSIVE;
+			return LOCK_TYPE_NEST;
 
 		print_deadlock_bug(curr, prev, next);
 		return 0;
@@ -3049,12 +3050,14 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 
 		if (!ret)
 			return 0;
+
 		/*
 		 * Add dependency only if this lock is not the head of the
 		 * chain, and if it's not a second recursive-read lock. If
 		 * not, there is no need to check further.
 		 */
-		if (!(chain->depth > 1 && ret != LOCK_TYPE_RECURSIVE))
+		if (!(chain->depth > 1 && ret != LOCK_TYPE_RECURSIVE &&
+		      ret != LOCK_TYPE_NEST))
 			goto out_unlock;
 	}
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index e9a8ed6..56fac83 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -26,6 +26,8 @@ enum lock_usage_bit {
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
 
+#define LOCK_TYPE_NEST	NR_LOCK_TYPE
+
 /*
  * Usage-state bitmasks:
  */
-- 
1.8.3.1

