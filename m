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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9CB2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sefnPZfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfH2IdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36727 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfH2IdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so1250479plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNw8f3YA0DZukVEGbXPjsA/vyBkyObawvtOHlKkIee4=;
        b=sefnPZfKls3P9ky+DVoLfW6A9lqoVwcGMHP4hhzS9Zg3gRmN7U+dqe/r2YrY+Uo/oy
         GklTNg9vOjfWuglFaWiB6sBO5uncDBKJCZvUn9rjS/CeyaoFCmljJuL00NiYu2SpNRAb
         KE8ay6CZ3qh0skNs+IYNLSYIkIfhvv7M1j1bKA3fXb+AEArniVQ3oI2hF6sHXF+h/w8j
         etWCoAKJQo7c43elviTkvpfpjSYnFgiYCQXLxqX1hD5AeTxaLncgPh4JMKxzxO5FFl0h
         uCHnjNNBRjxtvpozgEF3/VnwMWLgNs0SR5rx3UXtQd5x0ffwUwiyaBEq/CIi2GclDo69
         ikHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNw8f3YA0DZukVEGbXPjsA/vyBkyObawvtOHlKkIee4=;
        b=Xd+N9pfrIRZeveyVCtM1WTdUwjlNIlLAKK6D/k2LukIG2Uf8MG9kbiYr3pcC9L/Yvq
         qUqD45+/dJaZJsJUmrvlUKkGz8eFcjBQThfGCIP9/JFAxEjUb1u1jHLBm5yJljdREpjC
         gvKDdHjRNiJZRgHD+uat99LmP2xtUhQzv0RFzodViX64t/CzVb2VaE7ZkLYVO3kFE8Uj
         WePlR8KPNcWS82bbtyeQTFB+q0rbP7zIugyChkyWJZ5TxaEYWK+r0hbpH/9XLhdLGblN
         45Ni8wZ2bXRjxC4zRtHZ7U3PsRABHiZMgNeAz5gt1lTwBGUhDFW4MZuGXWr/bKm7/Uhl
         anmg==
X-Gm-Message-State: APjAAAUki6WxmLDxwgmh/vwnAj7MVqSMv2/AyaXVKHUXGm05PVaQhECP
        OuyTaI1i7H58FLgBL/zZyqM=
X-Google-Smtp-Source: APXvYqxUIg3uZ/+/r1Bgjx0rPKDe0xLX2t3FWr19uDIX5PHEIem1Nds9yT8RFhZQZ/m/8Q1s3Zxr6A==
X-Received: by 2002:a17:902:a404:: with SMTP id p4mr8320726plq.185.1567067579478;
        Thu, 29 Aug 2019 01:32:59 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:58 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 19/30] locking/lockdep: Add helper functions to operate on the searched path
Date:   Thu, 29 Aug 2019 16:31:21 +0800
Message-Id: <20190829083132.22394-20-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - find_lock_in_path() tries to find whether a lock class is in the path.

 - find_next_dep_in_path() returns the next dependency after a
   given dependency in the path.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 18303ff..41cb735 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1535,6 +1535,37 @@ static inline int get_lock_depth(struct lock_list *child)
 }
 
 /*
+ * Return the dependency if @lock is in the path, otherwise NULL.
+ */
+static inline struct lock_list *
+find_lock_in_path(struct lock_class *lock, struct lock_list *target)
+{
+	while ((target = get_lock_parent(target)))
+		if (fw_dep_class(target) == lock)
+			return target;
+
+	return NULL;
+}
+
+/*
+ * Walk back to the next dependency after @source from @target. Note
+ * that @source must be in the path, and @source can not be the same as
+ * @target, otherwise this is going to fail and reutrn NULL.
+ */
+static inline struct lock_list *
+find_next_dep_in_path(struct lock_list *source, struct lock_list *target)
+{
+	while (get_lock_parent(target) != source) {
+		target = get_lock_parent(target);
+
+		if (!target)
+			break;
+	}
+
+	return target;
+}
+
+/*
  * Return the forward or backward dependency list.
  *
  * @lock:    the lock_list to get its class's dependency list
-- 
1.8.3.1

