Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC34C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE332073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1c/Ykbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfH2Idb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43744 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfH2Id1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so1232442pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LJVFKQfKTSHL4xQ7udZmCSm37xuo5vIf7hCSAgl2TE=;
        b=Y1c/YkbvEu8VxRKySUAjl0c3lltLPJzcabPKdRLw/Ss/jFZdxHg4k4hHceucFICQSq
         g7Nc5pMM8yxsnKbqAZDIqpOl0NlvZDBD0DnzN+B3KG0gwc/2T8yEtonUitDtfH4ZthEB
         s5dZ4KqEjvmaS9euEqqvWeR8eXEWO0M688zYnh/LMeGw9quvDXwB9fOG5QrRHw3d88pf
         RK6uPAHcnj9zGd36QScxfJkkrLWWf1/gn2CPNr+Igy6fsfaBH5PjJcaf7xtkWsdP8f/X
         h60dkTa2k+f86VoQRAmGGhcI1sjK052T2bqdoOdQ8ZwZ5O2hN2NuOsxkfL4nhU+OugGK
         GxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LJVFKQfKTSHL4xQ7udZmCSm37xuo5vIf7hCSAgl2TE=;
        b=pUcW1kjGOdFeg482q7LPwgY2V61qXJ4npzuKfIGLgHumKll0VR05DQEyBKC1fco3CK
         ejzqGnqxYjGIWf33sZmp1sb/YmYE6LpPdvZmQ/fduaK48LPbJmNxc2VG/JOPQjTh4NOM
         LO2Jw9e2LSSo8w5/FN9TWp4/f0Gr3/+nlsY+vyshxh2b2PcTHY1gItFPbEtnNRcVL2jQ
         2MXpN1dLdqRQcRJxA5u62qktJh0+Wz4y6HE6cMSc19xcci7gJBfURIFRqJOcZ4ulXi9X
         ukUls9dgKoxI/E3rytUIyGF70W5BEBYfWXgH+p3BmWSUB9FKQQkPqr9sPZ1IzyPbPpoS
         fLYA==
X-Gm-Message-State: APjAAAVIUYph/KwsXKICehpu5TQxfSgoOkSNKMVBS5St7T/ogHQF6SWe
        OfMhem/UTJRE9h2R2otTnIk=
X-Google-Smtp-Source: APXvYqzQvZTftpsiYDjO1O76plvw56CJ3r0uCtXd6bOvaq/C3J0Z5lXbtd2Ezxz9abVkXWHvUbfOmA==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12mr8594649plr.81.1567067606874;
        Thu, 29 Aug 2019 01:33:26 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:26 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 26/30] locking/lockdep: Add nest lock type
Date:   Thu, 29 Aug 2019 16:31:28 +0800
Message-Id: <20190829083132.22394-27-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
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
index 4cd844e..755b584 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2591,6 +2591,7 @@ static inline void inc_chains(void)
  *  0: on deadlock detected;
  *  1: on OK;
  *  LOCK_TYPE_RECURSIVE: on recursive read
+ *  LOCK_TYPE_NEST: on nest lock
  */
 static int
 check_deadlock_current(struct task_struct *curr, struct held_lock *next)
@@ -2620,7 +2621,7 @@ static inline void inc_chains(void)
 		 * nesting behaviour.
 		 */
 		if (nest)
-			return LOCK_TYPE_RECURSIVE;
+			return LOCK_TYPE_NEST;
 
 		print_deadlock_bug(curr, prev, next);
 		return 0;
@@ -3126,12 +3127,14 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 
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
index f499426..37f6b0d 100644
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

