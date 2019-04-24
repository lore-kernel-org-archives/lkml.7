Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B866C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxHS+olC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfDXKV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36203 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfDXKVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so9180027pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pTq7jrXEldgj0Ejryxa6yOJ611xz6wLmDAwb/Xjyvo=;
        b=lxHS+olCIoaKhRvBghhmKcpteS1W0g6FzDefUmbjfDv6fexpqKinePOTLR0Cb1RUA/
         Q3HNqxBfsl2yZR36TqgYtHvHR5F9+YBYD89ZkjI/wU7rRPkOgAeE0KiRtZ55hR0U2JVS
         Hw29kWCZeHpOkCe6KPR2hPkHFdO9D2stcWlt3eGqR5QJ3lNKaaVDCi8i4XwrplStH1YU
         4zWFBeoWGw1rzE/eAqHZ8a78rylmGXA0eo8RfkKHL/RZBlE0ihIBaHD2r9Iw/zce2vNs
         CUk4tTBUO/BM6q7aE85L45r4cjDG37wBGcIOSpA6+v7atKdGiZoF6Yw9Xt0via/HZt5U
         Vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pTq7jrXEldgj0Ejryxa6yOJ611xz6wLmDAwb/Xjyvo=;
        b=SlFaGhRp4AbbpO7H9upMmT0omosbj5S+lKyTYY+Zzb72SBVb/XstQxguknhJhrF+ZJ
         WlFZOjvzbKlZgeaqEuwZwHVGNgDNXwlzASJGP3MbgMR0w7pwlE4CY/phFqrLrwcG5ogP
         hYkdyhhqOFx2V1ccG1cjbJnOe8NOQ3r94Apz1zgpKJMDPZ0c090r4Y5VsaJKxWbk2HQX
         UXC9ZMK8P/Xk6Jj8RVvDqrUoN82i+JB/sD9WKwuQhGN48ZzFUu28tHQMsX98KTcVPgon
         eudhccZSEz/sczLY2YB7iRasxgOtrhaQGwPjDsIBWteWYtEHgAOKA4yAiJcOCgd8xw6C
         XEWg==
X-Gm-Message-State: APjAAAW0b6fQkx8KbFtQzXT+PiTBpKSnqDYFmnvL/qtwImOCyHMU+nkn
        l3e+sSwy26m2kltg0Iu//OE=
X-Google-Smtp-Source: APXvYqwQZc2gT5Sf9aXcv1fB206qY6Y+TuajAl6sJW9VUhmWiSQjet98hu1oU+97ri023Dx9Is3sUA==
X-Received: by 2002:a62:e816:: with SMTP id c22mr33381413pfi.54.1556101279903;
        Wed, 24 Apr 2019 03:21:19 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:19 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 17/28] locking/lockdep: Remove redundant argument in check_deadlock
Date:   Wed, 24 Apr 2019 18:19:23 +0800
Message-Id: <20190424101934.51535-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
index d153b97..eb85183 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2143,7 +2143,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2162,7 +2162,7 @@ static inline void inc_chains(void)
 		 * Allow read-after-read recursion of the same
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((read == 2) && prev->read)
+		if ((next->read == 2) && prev->read)
 			return 2;
 
 		/*
@@ -2727,7 +2727,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock, hlock->read);
+		int ret = check_deadlock(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

