Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A1BC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466EC2087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5GdMIWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEPIAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32897 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so1177583pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UAtuX7IYUSdxLE+OnJ9wU1lsxMLJnRltRuwKyjIkJY=;
        b=F5GdMIWvELz2KvSlbX2VcJzJzrGFFCY+75kyejm68PV/a4/YoxMMzcD9YN7WowtSjj
         kU6B4a4bI32FfI0fh8XNACZOLg/k6hGDi450aXQz0zvkPf7rfqWbdATdNC3jU2p9GsBm
         rFEPMRfzclL78iS6glJi4IE+FS6f0UOZrivNe0znCCxfzYIBcEPALUnVX7H2QCgSuXL0
         gn2I2pwbHii2UKzQ1uxul+0XbYTD7Jgb/c5ZdSj0Bci/KxKN3bVGOdtrfV1lJ7BpQCyr
         4NnX27AsvfEQ6A7Zhk8wsTmoqxTrNlCuYdX8Kkoke5H8MA3F7ikM6hrMvcfLc5nxKrWT
         gTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UAtuX7IYUSdxLE+OnJ9wU1lsxMLJnRltRuwKyjIkJY=;
        b=S9nzj+MtIszQnHaeCjza4FkEdTJj9LGjrHLGecS1DktrpgSGcrb9Vef+JcUsr/JJOc
         DLP4LV/Wn73wWF75yOnxWeRrVGDpu9gKDGzxnb8iW1tWpZzfeo27wsCbogKVbAPXO5DB
         0JMnAuWreiCmlhh3Co9a2oJHg7y9UEs1XUk2Xl0f/XyZJcA9z797irxk/GMm4Cz/ZdNQ
         pBViRpCpumwJTslxBN9mtNuBDzZq22wweTaQy4t4zRaL8wgs5uqjtDEq6+i4Rm/K0+mL
         /nP8E7BUiCNMuQsOx38frNYGj885Bo2hT/3BBPXcdkMTghJ7mfGYHZ+4t0dPXcI+149L
         vcbA==
X-Gm-Message-State: APjAAAVqDeqx5vw9luFGV1eUc/pIUsSgxL4msPuFbZW5N56++yHS7Hot
        8RC867nHGmm3UvM/2IdZfIkiV21DflW54A==
X-Google-Smtp-Source: APXvYqwDLWdhMDfSKi1oYuDDsYu8fNpKqtYYpWAPbu30RpJ6hxf9XFsiBewGZWKRKbjagtRy/T+olw==
X-Received: by 2002:a63:8dc9:: with SMTP id z192mr3967654pgd.6.1557993634545;
        Thu, 16 May 2019 01:00:34 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:34 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 03/17] locking/lockdep: Add helper functions to operate on the searched path
Date:   Thu, 16 May 2019 16:00:01 +0800
Message-Id: <20190516080015.16033-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
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
index e7eedbf..595dc94 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1365,6 +1365,37 @@ static inline int get_lock_depth(struct lock_list *child)
 }
 
 /*
+ * Return the dependency if @lock is in the path, otherwise NULL.
+ */
+static inline struct lock_list *
+find_lock_in_path(struct lock_class *lock, struct lock_list *target)
+{
+	while ((target = get_lock_parent(target)))
+		if (target->class == lock)
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
  * @lock:   the lock_list to get its class's dependency list
-- 
1.8.3.1

