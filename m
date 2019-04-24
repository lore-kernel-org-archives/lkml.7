Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6BC21909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReDWkHzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfDXKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38377 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfDXKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so9163816pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1yGawMdPH0Fv9fDhuR+pFBsijS1BFsUiHagW2u6++o=;
        b=ReDWkHznXz/zS6fEKN+2yRSUY4j5PtogzJY5oo0wr/7FvQJUR3mhSqYK2SyQ6SkUAa
         JHCMVDtejuopLROonSKm1aXUaLDWcyrYYYvXJ4UCT0hOh4pa9uI+e/onqaifKULfDZn9
         BhGhmWmdrZDI/8weTEg2rdVPpo8mbFawFEQvWDALsy5VAWZJqtNwZ2fCczOWA3DqwGVK
         +/w7uGwUmQoqM/9qCUS8G23E9Fo4b0BfiBWnb2aZMoX7FsLJ9uedwqvTsrCAB27aYIyI
         xc5esJ5X8Wx+1E0qr5xnY9mZRYIANMfoEXpYQhoXv8Vs9SzvvzoNBcxnnbhxDC/RU252
         NqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1yGawMdPH0Fv9fDhuR+pFBsijS1BFsUiHagW2u6++o=;
        b=RL3anxstQN48uJtSeTWilY0SqmazK6B0dKRbeF6lNWSCaENzayUjiiZfAOSfjvh8Ks
         aoaiV/PLQ2tdhgcjuW0pdD7ScMrbJmdaycb4JtK4WzwCyhsEs1NX7OLrC4uBlqxabwLr
         blAIcWyM3Vw/LyPrWEX/59Q3Y7UO2gsHpzJLBc+nmykPcoLQVPmblHFfo5ohCpeWyNzz
         hUPobQKgukJiVsQBSw/apz563aMxK/dZvvVrt7tgUXl2o3NtjPr2Il2UOTiXhmyzv5Ua
         asCkJMPBAZ0mlEdzpFf5UZadj/E/+nUb+u8LJTUZpRAQM1C6VM04JiiHcVUcOcRUPgkt
         io7Q==
X-Gm-Message-State: APjAAAV55idT7LNyAt32L34PRrd0Vbfqr64w4HlcovnkyobIoOXICTn4
        GtKHIQnSePmqpIqX63d5tHI=
X-Google-Smtp-Source: APXvYqxKDSpFZD9TQcDNzfdnm6PhokliGOiXcJaGh+TYM+WzWRV6/7qXjrEZkv6NCglQoZ8EdfpnCw==
X-Received: by 2002:a63:b0b:: with SMTP id 11mr30357428pgl.445.1556101261637;
        Wed, 24 Apr 2019 03:21:01 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:01 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 11/28] locking/lockdep: Update comment
Date:   Wed, 24 Apr 2019 18:19:17 +0800
Message-Id: <20190424101934.51535-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An out-of-nowhere comment is removed. While at it, add more explanatory
comments. Such a trivial patch!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ec4043b..0543872 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2700,10 +2700,16 @@ static int validate_chain(struct task_struct *curr,
 		 * - is softirq-safe, if this lock is hardirq-unsafe
 		 *
 		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock.
+		 * could lead back to the previous lock:
 		 *
-		 * any of these scenarios could lead to a deadlock. If
-		 * All validations
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
 		 */
 		int ret = check_deadlock(curr, hlock, hlock->read);
 
-- 
1.8.3.1

