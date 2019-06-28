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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3611C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BE3208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTk4unz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfF1JRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35522 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1JRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2913834plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJUauKN/so7Khj/FpE4yerAjuRI4hWRsB8P/SwQ+7Do=;
        b=VTk4unz7sBDk/ccWUYysrD7fSgCff1if+nDX57Z1FQfmoBQ4OMM+P7ZbJMez4MMyN1
         lOtsigCL6vlfHp/Ecz7RF6s3/7NpqHG92rC8oD59hVf3570+OsEbWUG0MHAYivcktqdl
         SdIeYC1/c2qKnBHWlk2llAMeSVkjSmDDPEOLnPEQjWrWBL6EFcuLYvvmM55BhYhO068z
         9iyiEe3QPlThweTFVjm0yGT9EbftVVfsG2kHaMhgX8RBTCbS07lNrDu7QpDDf+bVnfU0
         X8ntRPBagohy9ZCpcBHzgKlDaG2HEpgnOe7fJqjj0z2iEAUznIjvUcWKJUQUc2X93jMY
         4n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJUauKN/so7Khj/FpE4yerAjuRI4hWRsB8P/SwQ+7Do=;
        b=nnDiycuQwooLDjUYKoNGs37ORzhv3caAgzPcQLvKTrYNI/3XR3PnSQ4ueK8SE0n6jA
         4cRI1iyN0YPGCjaFU4yAdx73epBnEhbLefxIKZFKBHxbAI64bjDlnfXImv3cVuJe5kAh
         llld0Zw6swctlbVBMToH/hM3TynCnFJ6kFRAChtDDuG437Aupa+2m4QOLVk2D9L6NWCx
         ypUIPBKx8oLc5dwtkt7wA5wCYetIk5oJiYvywJMJ6tbSuI97+8DDIR0W8bS01EKkfW4e
         LWQZ0OSMPYEgSUE4AWec0cfwz0qDVwDh9taQqo/HHXI0sHeej7n/ytlLpFs0ypu4rsWj
         u4GA==
X-Gm-Message-State: APjAAAUJdY8y5SVhKP8LLd9e2yINavpzYjXs+PbitrI2MsjIu1vQbOwP
        88JLOWp76gsKwWfBhLxVjeI=
X-Google-Smtp-Source: APXvYqx59tUE5GAe7Us2m+Mx57pEopV6zzTPPL1zsljvEmhRdpydR+4664K3NmnHaCCQhvCFawXZCw==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr9488821plk.99.1561713428498;
        Fri, 28 Jun 2019 02:17:08 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:08 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 19/30] locking/lockdep: Update direct dependency's read-write type if it exists
Date:   Fri, 28 Jun 2019 17:15:17 +0800
Message-Id: <20190628091528.17059-20-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a dependency, if the dependency exists the dependency's
read-write type will be "upgraded" if the new dependency has more
exclusive lock types. The order toward more exclusiveness: recursive
read -> read -> write.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9fa38fb..2329add 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1516,6 +1516,21 @@ static inline int get_lock_type2(struct lock_list *lock)
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
@@ -2511,6 +2526,17 @@ static inline void inc_chains(void)
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

