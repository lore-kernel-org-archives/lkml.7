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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE12C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948932133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By4INT2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfF1JRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF1JRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so2672174pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/MU7PygK8zh6vt4JAY4lXOfHMWy9RR6BrwI8h0UwRU=;
        b=By4INT2vAEDcFvmjebojzKfSO1h91NuEbQ/dYkSfXpTY6XtaYe6DFOAQOw7p6foyjJ
         M9S7443E5Hv+3qdSLyaAqFRKjkZxNAYx/CQ9E02TqwFKIjyLJCOBZIkIu1d4sYUdV92j
         d1gMDu/4nRqqYR89PVlzojoElPtGNHGMwDlQ9Ig9xYBAEzHfTYcHrtuZwSJ8nazM0IXl
         /2UTRL+pyGqJOQxu4Zv9H5lovFyeTVuF9Nq6NQ8IXddMqQH4nX4Lg1D+vOa/H4M8Qhpu
         D0ja6p0XvNUtiJZ63oY0ZF565d0Fg/ZKmDru2hJr69J7FadTy0ZwQnWj5aY4PkfO3BLw
         GBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/MU7PygK8zh6vt4JAY4lXOfHMWy9RR6BrwI8h0UwRU=;
        b=gV6sr61LMnOxFQpR5Pyh8fetmXza8EiHGvpNB3BZLf8VK0jj1OFzf9RNTHvwnfXCsI
         58kEQPdIyxv5wx6cbfZGLfRLgNLhKQ35ZvB57l/ECwqzPuucr9J+vBT+dx3IZB8ZIYdi
         28ArdHISsXmKg0jYsD6GvAlb0EkLI1LwrThTvLo9Cbpza6WXloC+3g+8Vc6gtiHPcSqI
         k90vzrMMfPWco3/4ZbRNRQf1QJHruPjqSC4S61zyoO4eO/z/72nl+VKQ4bLPZ/bGdcEC
         icqpGZxdCBJgfAMfRjR30JExbD876EdJGbUX1hahulNZIHlGncmBm60NWZgrtzGL25yQ
         lOQA==
X-Gm-Message-State: APjAAAVPAQVLPsnUGd+9ugOhdukuQ1szYdkvnc+dDhm9AusieiuQV9xr
        /IJg0zHRZHpeTptNVW8hLts=
X-Google-Smtp-Source: APXvYqzNVezJw0OGnz0SXX+WyseNaqlSLtlv7rUH8yyYnlGdMmgCzMF2kNrrkaONvmfs1UowoOCfQA==
X-Received: by 2002:a17:90a:9a95:: with SMTP id e21mr11587737pjp.98.1561713450983;
        Fri, 28 Jun 2019 02:17:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 24/30] locking/lockdep: Introduce mark_lock_unaccessed()
Date:   Fri, 28 Jun 2019 17:15:22 +0800
Message-Id: <20190628091528.17059-25-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since in graph search, multiple matches may be needed, a matched lock
needs to rejoin the search for another match, thereby introduce
mark_lock_unaccessed().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 444eb62..e7610d2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1449,6 +1449,15 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	lock->class[forward]->dep_gen_id = lockdep_dependency_gen_id;
 }
 
+static inline void mark_lock_unaccessed(struct lock_list *lock)
+{
+	unsigned long nr;
+
+	nr = lock - list_entries;
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+	fw_dep_class(lock)->dep_gen_id--;
+}
+
 static inline unsigned long lock_accessed(struct lock_list *lock, int forward)
 {
 	unsigned long nr;
-- 
1.8.3.1

