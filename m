Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA4C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy3LW1Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfCUH6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCUH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so3659729pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RfktU7rJBVHx94ewl890E3HySsCK23Wf99IM2kYHMY=;
        b=jy3LW1JpKTzgJXgBNDZOg7atAXympm1AshgHHt44MMtAl0KgL3gW5+2821kRvqAfIF
         WNb5MSlkDVz85KWNCmVEGYS8etem4rEoE/EBcH/fFsUQDFVlrLbt3IVWsXqs2dsJo4Me
         ZazhMqmhyuvTtOrVH2AqVcuNrhMKTrd9bZGwDWK+0PE+jRixoS337eG50j3nb4c2NBYv
         SBqs0vHVtCguqiARR0lDHB4TWoX4N+DonDwhwDMFFSdvMsFesD7v9MAh8uc+IJZsMWXT
         4YQne8OoDJ7DGaObU2XcYesaQPWAhnmIRwCzrrgD9hhUAiG+L0o8dJJtL3amp/WZWhZW
         Y2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RfktU7rJBVHx94ewl890E3HySsCK23Wf99IM2kYHMY=;
        b=YP9kZXx0NdIuw962Y62xQIXzl2mCNCtOvgzkCQEkg2Cikw+BBSzi3RVniaUyGDfg7j
         VYgX5drEHROvjd9hQjoCUNjx4vaO6b4KwbKdMGX/EhHo2p5M9TBHNhK1KIPu2cSdi7UW
         kqcqKuWHvvlknRve+IR9aM92M0GqRiLyJla8pxsCIchrRbwA+IJgFKn9mAOeK2Ls7Hdb
         29z7/Z7l/QUtnEa4Ivlz6bjY6XNMeFIDmvEYV+BuBaUV2VvChcHdewmcb5VaUNMZ5IsS
         wQDQJ8U5ijaqPv2/IjHgfs5SEyntMQOdx/mry9xNMzjwUN7jkNTYG+15aZiBU1qCMgug
         91ow==
X-Gm-Message-State: APjAAAXlkcQBS0AMC+3r7X+s9N0Yl21zfB3fi+L5wKoRUWGa5Sgj8qHa
        v3gmXmR15fasiqXdswQINgs=
X-Google-Smtp-Source: APXvYqxbvFGY6RfUREXd0GOluVbBl+fg50W2Xzd+F24pV5D2HrsbnWVIeI3lYgmwnRUMSea7OUMo5w==
X-Received: by 2002:aa7:9211:: with SMTP id 17mr2038837pfo.220.1553155089307;
        Thu, 21 Mar 2019 00:58:09 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:08 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 12/18] locking/lockdep: Remove unnecessary function pointer argument
Date:   Thu, 21 Mar 2019 15:57:19 +0800
Message-Id: <20190321075725.14054-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_prev_add() always has save_trace() as an input argument, which is
unnecessary, so remove it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index eccfb0b..f46695a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2193,8 +2193,7 @@ static inline void inc_chains(void)
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace,
-	       int (*save)(struct stack_trace *trace))
+	       struct held_lock *next, int distance, struct stack_trace *trace)
 {
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
@@ -2234,11 +2233,11 @@ static inline void inc_chains(void)
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
@@ -2293,7 +2292,7 @@ static inline void inc_chains(void)
 	}
 
 
-	if (!trace->entries && !save(trace))
+	if (!trace->entries && !save_trace(trace))
 		return 0;
 
 	/*
@@ -2358,7 +2357,7 @@ static inline void inc_chains(void)
 		 * added:
 		 */
 		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
+			int ret = check_prev_add(curr, hlock, next, distance, &trace);
 			if (!ret)
 				return 0;
 
-- 
1.8.3.1

