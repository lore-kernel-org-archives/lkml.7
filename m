Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77A42087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfcOhsiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCRI6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35276 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfCRI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so261346pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1XLCw9PbTG5cmcCj0Lx2C8KpF/SggNGbCfQvyRLmgpU=;
        b=VfcOhsiqNnKC6Rfx5p/G5E/s8VpUVhOVp054AkK1GidmKv3iEmsG+uTcpBzLFxDH1T
         Tp3YbB0ljv5PKFeMxlO4R1CTOxBXtE8YQcG4xDvJMtagpykgxipoRPanmRx7YGrWFpT+
         ED4nDMqlmvENUMZBsXBfneoSFNNAOGdupFD9EHdKiOLTvNCqzh0uPVO9SPrnEqnIxRNJ
         z09/1skqx7RXlS2d4tThKsYjo4ODwPtBvbXO326ismT/qiDR+55uWTl7T4qEe/rC16mc
         JHp/Wcwv0zv9aoGlZXAV0UQ4Am6b40Dp17E94ghqVgHb2kQSLMHdQxcp9gJwTD1lcg/p
         4twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1XLCw9PbTG5cmcCj0Lx2C8KpF/SggNGbCfQvyRLmgpU=;
        b=b3VUAAFqwcTUAae1Y6j3Hsk7hjWvV8iIy5KDF29VX1m/iFK6qckVC7pxPzbNZoizt/
         hAgkkYi3VfYniEMnFD/gCHCFTMclZV2vdTMVOiUmeA9vT+RdfKeiHXh1LzHiolj4e1dK
         DxVp0/N3Ono++rPn4rQLGZ1cvTJI8DFOGxRpQO9FsKFvuJilJPlLi6pOPFofflH2Wk+e
         cn3B8Cf0Y9uaOJ7iPyjU0/qly0Q6hBi06jzq7x0w8+qBguupKwh8FF2eanaodoKswWAi
         3RzoYN9+t/23UmQxqcdp4tHfqOEaTPtz/63GJV6biKHEn39iK0LmytS9nGdcrBj/MtCk
         bO1A==
X-Gm-Message-State: APjAAAU18hC6fPwxk7vEQvrwkCSGmKgzaEUiWDQu1FncB7vVlxGVpNkB
        SxfYnHmtZOfPZjaf15on8N8=
X-Google-Smtp-Source: APXvYqyM5//HBeIcdTOLcdwUo6juqEIy2bCBXHrXOjyn80iRAe0uOWCo5qjroPUs4m7jKhbIxD+kww==
X-Received: by 2002:a63:4550:: with SMTP id u16mr16311485pgk.73.1552899500164;
        Mon, 18 Mar 2019 01:58:20 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:19 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 13/19] locking/lockdep: Remove unnecessary function pointer argument
Date:   Mon, 18 Mar 2019 16:57:27 +0800
Message-Id: <20190318085733.3143-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prev_add() always has save_trace() as an input argument, which is
unnecessary.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 250ba64..de731b8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2190,8 +2190,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace,
-	       int (*save)(struct stack_trace *trace))
+	       struct held_lock *next, int distance, struct stack_trace *trace)
 {
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
@@ -2231,11 +2230,11 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 	if (unlikely(!ret)) {
 		if (!trace->entries) {
 			/*
-			 * If @save fails here, the printing might trigger
+			 * If save_trace fails here, the printing might trigger
 			 * a WARN but because of the !nr_entries it should
 			 * not do bad things.
 			 */
-			save(trace);
+			save_trace(trace);
 		}
 		print_circular_bug(&this, target_entry, next, prev, trace);
 		return 0;
@@ -2290,7 +2289,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 	}
 
 
-	if (!trace->entries && !save(trace))
+	if (!trace->entries && !save_trace(trace))
 		return 0;
 
 	/*
@@ -2355,7 +2354,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 		 * added:
 		 */
 		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
+			int ret = check_prev_add(curr, hlock, next, distance, &trace);
 			if (!ret)
 				return 0;
 
-- 
1.8.3.1

