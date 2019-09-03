Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89323C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98C2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9W6jfMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfICG5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:57:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38464 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfICG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:57:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so4028592pgo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AeeV14OyLBTF7KaAD5jDBEtXBCp8zTp9/udCZix5Xks=;
        b=p9W6jfMk6gjNMTcRQ3sw84ltehgzUrnBrlh77posPmyU5yfQhoe+6buCNhGW0ouOGj
         fLnPvg2yonl4VXRxfOkrpbcSHkZHd5RiscvSIOx0ZOJ1y1Mw2BDydU+Tq8i/qIRcBIZx
         +kx/N9qbHhYCGyQIec7LgW6gKOBQYvgFJt2UMX6odCHU2GQWEMxkr04++3zHyCeXc34L
         7eZJiEuJTgcyNT/uahiEanGfJOlJFyMwu44Dr5DfitUxj8zsp5SQ7BWzq2z52GmNkFUl
         3SedRw8KmftQPXKutX0FC5A5QVg0B13e2mT1t0uKzT/BB0taIQEJma/91cTQ5vfguCNO
         LMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AeeV14OyLBTF7KaAD5jDBEtXBCp8zTp9/udCZix5Xks=;
        b=P3pWl2MBJw6G+tbv7b6Epuk4nv9IBd4xc0g5IGYdWATiHG4t1FTa5Ljb3WN3bvbPBH
         9x2911aYufLLpHuEQOBXZFVhVRiH7CzScGo3AWhvX3rWRf1jPXGdg1nVk8fObNfdIwB6
         sBld/ab7JQIZ1OSjENE7gpFofJqkFGE2WpuTNVEcSEwb+nmrNS62jmlKTQ+Q/5b3b5KN
         +2deTcvE53Zmc8XyzfzKYWOlR74BGugD3SnduiA8IctFaIAX6Pqwa+FZOGiBnxnZKCTT
         trCfzjrcOQdhtl+NcXbpjmAlc9LMEoNae7e7/YGk5dmQYvISi3BJ71mk8BAhZMIucLX5
         WoqQ==
X-Gm-Message-State: APjAAAXI0OYpEM4tmlT+nmWGs+knTOOEDywjyWpKuuY+vPu4L/BL4L0H
        N0Unhw19X3Bt6R7SnrN5s1uD6Q==
X-Google-Smtp-Source: APXvYqw+7WbV27ga/InS0ExF8ZO/V01r9VugBLs7kebePYey1RQXVTmSVaNT4QvEWAHG7OpHeIYVHw==
X-Received: by 2002:a17:90a:b781:: with SMTP id m1mr16250972pjr.141.1567493873489;
        Mon, 02 Sep 2019 23:57:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n66sm307197pfn.90.2019.09.02.23.57.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 23:57:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     longman@redhat.com, arnd@arndb.de, baolin.wang@linaro.org,
        orsonzhai@gmail.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 3/8] locking/lockdep: Add debug_locks check in __lock_downgrade()
Date:   Tue,  3 Sep 2019 14:57:21 +0800
Message-Id: <ecdae1a4a913695b66404f0d34250b6812f7c1dd.1567492316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567492316.git.baolin.wang@linaro.org>
References: <cover.1567492316.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
warning right after a previous lockdep warning. It is likely that the
previous warning turned off lock debugging causing the lockdep to have
inconsistency states leading to the lock downgrade warning.

Fix that by add a check for debug_locks at the beginning of
__lock_downgrade().

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1547093005-26085-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 kernel/locking/lockdep.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 565005a..5c370c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3650,6 +3650,9 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 	unsigned int depth;
 	int i;
 
+	if (unlikely(!debug_locks))
+		return 0;
+
 	depth = curr->lockdep_depth;
 	/*
 	 * This function is about (re)setting the class of a held lock,
-- 
1.7.9.5

