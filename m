Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B264AC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8495F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYrnxC+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfEFIUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEFIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so2386924pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKYp824sV52iVA5xCpuAmZ1milKgy4gJjXqB3YKplKQ=;
        b=LYrnxC+RUl1AAvsFrPANYyFpmGaeZaKA2Omy4NayExV/OtWjJX+Pp02UcjWWeYaJ6W
         ui020TlrTCzKPIhmSky/bxGGo0pRHwzS3UvRyNJaqeW2eLK8fQNYcq6HR11jHS5TKAeQ
         A8Ce8NpCd6u6bjkWBJAwti1tVqEH2bGo5py2b9jzfLwT9JfOURzUyr5m6Ub+D75LOGB6
         FkdDT36OL8Kr8DFc4YDHr5tt5MOBKKFJ8BFtOFO6skbaV3/v4LU+etwOzL7958zbZuCl
         J0CttbzArUXrKaRscmkORA+ziFaIEshKR8Lb5fj5wLqJ/cS5fVrNva91rNqIpq+jwS09
         pUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKYp824sV52iVA5xCpuAmZ1milKgy4gJjXqB3YKplKQ=;
        b=Buqcvdwkh/pG63765I92Q2UrwkLaUBclM9+dyOAMH/gUd7lUHk/xXPL1KFH+YpT/Jb
         vbVBjLS8CpOO7RaW1bLPl6AC4RiEZnTPzjktza4Yw1E14jEQTvwduAwJK6DiLjEc3x8+
         cFlQuGFg1I48iSTEPoR3PFl0N5vZJx6sWKqQLTkzGtC7aoLEUgYo6O1yYZhpUUGsGigS
         EjekIjUBpZNa5n8fL1eWd4lE5sMNjMfxjCb3fE+khEgaG4YshNMC+5inpq6A3c/pzxrN
         5ZltuUKDWxudxEthGyDM9Xxx8oumDoAB5AJPDa5bGSQIMLrbVcebmmCTXXhaCkEITupJ
         Q/TQ==
X-Gm-Message-State: APjAAAUfXYW2r2J58H4XZOGcnxbjBl++/uHyfqbSfXjJHMO/V48XENQI
        ITcsaVfv6RJSoDmp8LkV6yw=
X-Google-Smtp-Source: APXvYqz2rYU1+D7dRxi/5jj5hY7xCaTnGabIrgvSeuCovNAq+TXSHb59X+vNme4IUeZpMIpsM6F1QA==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr30552874pgj.396.1557130843097;
        Mon, 06 May 2019 01:20:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:42 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 17/23] locking/lockdep: Remove redundant argument in check_deadlock
Date:   Mon,  6 May 2019 16:19:33 +0800
Message-Id: <20190506081939.74287-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In check_deadlock(), the third argument read comes from the second
argument hlock so that it can be removed. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7bd62e2..67b6a76 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2241,7 +2241,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2260,7 +2260,7 @@ static inline void inc_chains(void)
 		 * Allow read-after-read recursion of the same
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((read == 2) && prev->read)
+		if ((next->read == 2) && prev->read)
 			return 2;
 
 		/*
@@ -2834,7 +2834,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock, hlock->read);
+		int ret = check_deadlock(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

