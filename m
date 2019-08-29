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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AAAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D3C2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP9ohIGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH2Ide (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33378 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfH2Idb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so1593599pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPoseDSzRuNPOpt9zW4ALw1+RrmLBrCqsgwnhxrqn6o=;
        b=aP9ohIGGtJXY/hW0QfbtSz1//dgSS6Jvea1e/W2goYQ6paQp5shd/Bj9uWLrM7zGJR
         0GoM2gmGHN0p9oGhFOMOBB7yAVLLQeAgq8WQROJ4cY2QE11QYxmOjYZxBocbWh+rVTgc
         E/EYNAgjwpVjXnN6c2pC8sbrS7kZyT1v9REUKtL0I89aE+UWmrd0hag7md5ZNWIoHhDK
         Oduq6FgSR9cTB/2+EaigdOgoq9qbLATh1JIeyw1DcRODjOo/o16E9+FMsoU+C6jpxdFK
         7DSW4BGD/g/3n/TUYssHQ45p6fOWLg2T4DjCU0eE845nz81iJzkkSKpIIaTEKd5jxjy1
         szFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPoseDSzRuNPOpt9zW4ALw1+RrmLBrCqsgwnhxrqn6o=;
        b=rXyiUfcDMhPfvXUD3cX0yiSdxe1Lvm9WVmr6aEubdsX0+HagBhRVmGdRHSx7Syu4iU
         00/L+8zUoTg0chNompg9jACr08P3JW7cz7Toxx7Rtw08nyZBQbuVAfmTexxkN+QfDEjr
         Tu6mky1UzuSKc16ytf7/kMaOrcnQ14Yc9zBBs30aNwBphdT4I7ymKq9gJo9HmNBwLL7s
         qQkTiQAwrX1iKrgCmXL+1zZefOUS5EiyW0RYnhDc65B91kXqhqldoiLWqWuTSWfiZCVX
         hBsQ/lAHAZKEH3Yw75rlFaY2ENj/XFzBvHqyOgB2grbM4hAZEBVGSairDgrRfj8iEeJF
         +3/Q==
X-Gm-Message-State: APjAAAXAFRvw/cTOW9YskOX2oONqGyL9qvacbcV8sb70QO5WQRCDzOp3
        U17cxFS558teEalzIjxX2zY=
X-Google-Smtp-Source: APXvYqwHobgB06P/yBO1hxRYxv2jWggAU1fyWRJC/Im2dgxOn7Kpf8yvcfx6dprPClwYlMrR9Vq8JQ==
X-Received: by 2002:aa7:9a04:: with SMTP id w4mr9968113pfj.126.1567067610616;
        Thu, 29 Aug 2019 01:33:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 27/30] locking/lockdep: Add lock exclusiveness table
Date:   Thu, 29 Aug 2019 16:31:29 +0800
Message-Id: <20190829083132.22394-28-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock exclusiveness table gathers the information about whether two lock
acquisitions for the same lock instance can be granted concurrently.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 755b584..5c97dbf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -962,6 +962,36 @@ static bool class_lock_list_valid(struct lock_class *c, int forward)
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
+
+/*
+ * Lock exclusiveness table.
+ *
+ * With lock X.A and X.B (X.A is on top and X.B is on bottom):
+ *
+ *   T1        TB                        T1        TB
+ *   --        --                        --        --
+ *
+ *   X.A                   or                      X.A
+ *             X.B                       X.B
+ *
+ * in the table Yes means the two locks are exclusive and No otherwise.
+ *
+ * +---------------------+------------+-----------+---------------------+
+ * |     X.A vs. X.B     | Write lock | Read lock | Recursive-read lock |
+ * +---------------------+------------+-----------+---------------------+
+ * |      Write lock     |     Yes    |    Yes    |         Yes         |
+ * +---------------------+------------+-----------+---------------------+
+ * |      Read lock      |     Yes    |    Yes    |         No          |
+ * +---------------------+------------+-----------+---------------------+
+ * | Recursive-read lock |     Yes    |    Yes    |         No          |
+ * +---------------------+------------+-----------+---------------------+
+ *
+ */
+static int lock_excl_table[3][3] = {
+	{1, 1, 1},	/* Write lock vs. X.B */
+	{1, 1, 0},	/* Read lock vs. X.B */
+	{1, 1, 0},	/* Recursive-read lock vs. X.B */
+};
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
-- 
1.8.3.1

