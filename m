Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97F5218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+7OJ9UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfIHMF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:05:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39685 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfIHMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:05:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id bd8so5282364plb.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pocKy7bl+9/9OQKHIyv1k4AbSxuOk9ge9kKmyhR5kl0=;
        b=S+7OJ9UU0EX1d47DhqK4fa1fzUmL9aIhmNjnArnbNCikxuPW07LemUdK6WLNQ+RkPM
         QSR1tr+fOOqLWmKP58c7yyBTFrT5WCB5Nh3Hmc3/8GeDRV2rSE5FBJfMZrecvr63oKr1
         GU6X++U46LiOtZvICPkJ87VfC2nMV8XRiKeyGpZk5AMPNntUgu2llIz0W5/rzblE3mQJ
         ruOnuLSkdGeZVbHuiX6W99BEW1ksVVqXrTUO05jqM0qfTieNJu/M95nzJCSZKu4VkcUZ
         6gPtGFSejr+3CYtt1pwoCqofstto0aT50+g+n2Ai6I+qsnjP9WNsJQ3fI2fVykbHAlxB
         w/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pocKy7bl+9/9OQKHIyv1k4AbSxuOk9ge9kKmyhR5kl0=;
        b=heMBwAzgwn8XdVhaCbD1Ng4Uhm24fu3PD0f++rp0QCS4ocmUB7CCQ3ls9B7sQgLWFd
         Mqu3fNqYl+iVSDsFHXYSjwQGnyET7Qn9f5PCriK2UI4cnMp3Ervb2CNWUnwD5VsabPB2
         XZ1sP5dNqANc1hFKsGoCWvnInqjTw7OtzCBQKun+TdKTWvF1ivTN6l6JDGl3Udn+5pmm
         p7DmhzZ04JeIGjIhNACTQxtRtNYllSVYHu7wg/CpqwxrAoNYWDDiopHAwpBYSKAt08uh
         z+2r2xdYGFp71rvZlAp8VvziQY63CPBrm58EPg0d9acyA1fYPNVN9FM7144sY/0NVgCC
         l/Tw==
X-Gm-Message-State: APjAAAVkJPprSQA/BLpTz31bqHNKJE/D32s8upd55bg7jif7m2wLYoJb
        YdQ9c103P7rmt8Bu7qfT0WU=
X-Google-Smtp-Source: APXvYqxLIyU2FkUeL9Wj0l/iDK5k40wl6THEYMKwThp3gzWLaoWZITTgsFoF6CkwDk0sTt4fWSHkKQ==
X-Received: by 2002:a17:902:b40c:: with SMTP id x12mr19300553plr.236.1567944356110;
        Sun, 08 Sep 2019 05:05:56 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id v22sm9327843pgk.69.2019.09.08.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 05:05:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] ftrace: simplify ftrace hash lookup code
Date:   Sun,  8 Sep 2019 20:05:45 +0800
Message-Id: <20190908120545.11614-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ftrace_lookup_ip() will check empty hash table. So we don't
need extra check outside.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/ftrace.c | 15 ++++-----------
 kernel/trace/trace.h  |  6 ------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9821a3374e9..85115deca667 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1461,10 +1461,8 @@ static bool hash_contains_ip(unsigned long ip,
 	 * considered a match for the filter hash, but an empty
 	 * notrace hash is considered not in the notrace hash.
 	 */
-	return (ftrace_hash_empty(hash->filter_hash) ||
-		__ftrace_lookup_ip(hash->filter_hash, ip)) &&
-		(ftrace_hash_empty(hash->notrace_hash) ||
-		 !__ftrace_lookup_ip(hash->notrace_hash, ip));
+	return ftrace_lookup_ip(hash->filter_hash, ip) &&
+	       !ftrace_lookup_ip(hash->notrace_hash, ip);
 }
 
 /*
@@ -2890,8 +2888,7 @@ ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 		return true;
 
 	/* The function must be in the filter */
-	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
-	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, rec->ip))
+	if (!ftrace_lookup_ip(ops->func_hash->filter_hash, rec->ip))
 		return false;
 
 	/* If in notrace hash, we ignore it too */
@@ -6036,11 +6033,7 @@ clear_func_from_hash(struct ftrace_init_func *func, struct ftrace_hash *hash)
 {
 	struct ftrace_func_entry *entry;
 
-	if (ftrace_hash_empty(hash))
-		return;
-
-	entry = __ftrace_lookup_ip(hash, func->ip);
-
+	entry = ftrace_lookup_ip(hash, func->ip);
 	/*
 	 * Do not allow this rec to match again.
 	 * Yeah, it may waste some memory, but will be removed
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..74162bc4024d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -941,11 +941,6 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 
 	preempt_disable_notrace();
 
-	if (ftrace_hash_empty(ftrace_graph_hash)) {
-		ret = 1;
-		goto out;
-	}
-
 	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
 
 		/*
@@ -967,7 +962,6 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 		ret = 1;
 	}
 
-out:
 	preempt_enable_notrace();
 	return ret;
 }
-- 
2.20.1

