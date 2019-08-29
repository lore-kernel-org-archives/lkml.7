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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE04C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E59D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyiB/Oxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfH2IdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46304 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfH2IdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so1549685pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZmSNSHjFH64m7mQTqiUGyFNSFmpZt3lLAAG/sBWU8k0=;
        b=fyiB/Oxg8WQgWvGKS91BB4dDCchEVhcC5tCtywOGuZ+CWEUtP6gp6CNS7/OupmuFdr
         d55sYdvHOI+DQXpbCnWg41y/HPTtHawQuzH9cpdv4i1fGOtRFl6HMZ1PjC6mO9eU30oz
         VInCzmiGVW3xjNrRYSlk1PvHkI6BTQnpZnqa6iM9UYvK/8ptBzF8RK2vVIqGNeD+d/d9
         dd9JNN7mk8yvvSQj4nyltKv15rCtQNVNrYDugdA3NxqhppxCD8dktUod9PpmCZiIB0np
         13JwhZwrXAx8VrPDqxHAsK3ltpQmE4Ia8maL2PkJnXsyrNsSYEpdSF3mgPHZxcG8jsd+
         7nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmSNSHjFH64m7mQTqiUGyFNSFmpZt3lLAAG/sBWU8k0=;
        b=ZTuBh6KYdVQU0li3CzShAdAmWM08x5fz4VltRIUNeA9UGEYWmfAUg5WGy++9ZVu/Yj
         pwB3RZgdAJUyIrSUmC1f26Oc2tvidcCWSBuXudTPDuKT+iL91Oz7zq+6pxRlxC+i+QN3
         RNf8jPE3geWvJa/DHMHinD3r4bq8fx5FsW9cJ3loZ3mRRHFlxLOhmu1LEhuVD9ZV3sbm
         w2odEwrOiZBgOxF0mG25e36Azzl7OC9Mgaz762iC/xXzaE+UB1utFj3JLoo8OPJgV5Nh
         gKKAe1NHYCX+RuM1/zzP6782KTKdikoemcgpe3EuxgrWIiBMwz1gPavZFjZ8NeRmmwE4
         HTkw==
X-Gm-Message-State: APjAAAWB+8blZarmOTOqaloljtRSI6uUXlj42HErDMMiGztCRItBhyPC
        lBmraA5kZLDBoEEscTnTS5U=
X-Google-Smtp-Source: APXvYqw8H53X8kNnYjLyc5jeT6Z3vjl+pXNEG/kBV7lJiHP+knfb4QnSvcxv53OdVwDdqHM9MA9Oxg==
X-Received: by 2002:a62:4ed1:: with SMTP id c200mr9767191pfb.218.1567067583230;
        Thu, 29 Aug 2019 01:33:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:02 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 20/30] locking/lockdep: Update direct dependency's read-write type if it exists
Date:   Thu, 29 Aug 2019 16:31:22 +0800
Message-Id: <20190829083132.22394-21-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a dependency, if the dependency exists the dependency's
read-write type will be "upgraded" if the new dependency has more
exclusive lock types. The order toward more exclusiveness is:

    recursive read -> read -> write.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 41cb735..eb88314 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1588,6 +1588,21 @@ static inline int get_lock_type2(struct lock_list *lock)
 	return lock->lock_type2;
 }
 
+static inline int hlock_type(struct held_lock *hlock)
+{
+	return hlock->read;
+}
+
+static inline void set_lock_type1(struct lock_list *lock, int read)
+{
+	lock->lock_type1 = read;
+}
+
+static inline void set_lock_type2(struct lock_list *lock, int read)
+{
+	lock->lock_type2 = read;
+}
+
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
@@ -2585,6 +2600,17 @@ static inline void inc_chains(void)
 			list_add_tail_rcu(&chain->chain_entry, &entry->chains);
 			__set_bit(chain - lock_chains, lock_chains_in_dep);
 
+			/*
+			 * For a direct dependency, smaller type value
+			 * generally means more lock exlusiveness; we
+			 * keep the more exlusive one, in other words,
+			 * we "upgrade" the dependency if we can.
+			 */
+			if (prev->read < get_lock_type1(entry))
+				set_lock_type1(entry, prev->read);
+			if (next->read < get_lock_type2(entry))
+				set_lock_type2(entry, next->read);
+
 			if (distance == 1)
 				entry->distance = 1;
 
-- 
1.8.3.1

