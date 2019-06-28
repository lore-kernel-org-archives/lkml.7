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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336A0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0833A215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgKhK0sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfF1JRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35861 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1JRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2672733pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hNfLq2QCvJHZK9LmMDQloHxl/I8j8TcQn+ws0k98tc=;
        b=TgKhK0sx1k7Pcoah+JCOd06OKSvwWJhHk3l6le8+L8ozLhqbujQ7eYWVafDdiGvhf1
         +23ruH2QlZYvhCRgbb3BcOVprL+Y2TPh9Ow3yBYaGuVsQ3E0mVBA/c5Jd8YAybSTHkHE
         DUv3LEYoifiNcdSB+CkX3VO9Z5ALqpykIOjVYCU+3tvV6sILYyp4Q5Em4AQTGxDji5Cd
         b6gcK5uoD13fopTVhThDrwjnSZH9ibmnlhPTBcfsZuG/PAp/f4EjPxf/FfBn8g6aqDIr
         9AKL0dZHllkRHubgjgwsm2hV9ord9jlBWpwUFPkgHRUOValGuHAdx41jXSYHQe66HkAw
         qSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hNfLq2QCvJHZK9LmMDQloHxl/I8j8TcQn+ws0k98tc=;
        b=tz7j+k5rJb8aM2CGtlGobKwG57MkEF27TvRJ/VQkTFpteBUjLbybFE0mEP9AeSpyXA
         7FKoVYjBjSl4rqWGcKxmlfrb5l34wQpy++SrwBFmj4TS1al32ukEYHse26aUx1DaSjwB
         AkxDbUbavTrttw0Eyn8Ay+Jp/MoUZPLlwLt6Wjouki6jRRjPKTNt79PGzjz4F0aDO4+i
         XAoxttHbZ8xxxsYx4Y5IRll0VsF5jLgRLeTVuDaLkyVEB+d2YjazJ3LOnw5rKXxprszn
         lo9M2fca5YiJKUoEP7x22EEB9BLQGn3Bzg4eJiEzWia8eXYjpM+Ml6NpcZxacC0C6qq2
         8k2Q==
X-Gm-Message-State: APjAAAUEtr5lsAvL+V4v1/nlfvePYa/QnyYGK07WzdelxZPqkwMyqkgR
        cjNZiN4w+0rX5yDIOQ7yVIg=
X-Google-Smtp-Source: APXvYqzPzSvtIzPqktKoz50uxgLFrBNVvI332ZIR4OgTutemRdyKvqjGf0FkD9cwkQSvSAxGmWW95g==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr1293724pgc.303.1561713424155;
        Fri, 28 Jun 2019 02:17:04 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:03 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 18/30] locking/lockdep: Add helper functions to operate on the searched path
Date:   Fri, 28 Jun 2019 17:15:16 +0800
Message-Id: <20190628091528.17059-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
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
index 1805017..9fa38fb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1463,6 +1463,37 @@ static inline int get_lock_depth(struct lock_list *child)
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

