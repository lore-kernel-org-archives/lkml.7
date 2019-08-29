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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F8B2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZkLAh2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfH2Id0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfH2IdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so1196443pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZLyNbjwnYq3EhNtQGE8AtBJxMBei1zy6n7Azk1R3aA=;
        b=mZkLAh2KWYrMI6XyZaHgsHZ0ICfjNRgDBN0M06N7cN0in+EMFQmMZTyk91YC2N9dsK
         jmB0hPO2laJTKXwZohaPlOsefKd9PPKtO8Jm+K54avQ0lLFEzR4Mi4DrFxnrWDJFDXml
         kZmupxcnoRN2uESJYX81wE95YMtiSsoRZ2hxl+gSisjTUE2zzXoZ319s2SPNFdkAK9Am
         ZgUGqkN48W9tRLoP8yZyDNgzBXFRQaVzgWKje6b5VnWWLNydauR55CiJsIjhSGDzos3/
         KlWz0rUrK0afe1QPKQ1U3EdaCQWa4ziTGwY1W99stuC9yTpAoWfGxXpRVu3KHvqyXL3a
         naEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZLyNbjwnYq3EhNtQGE8AtBJxMBei1zy6n7Azk1R3aA=;
        b=Hmw9AwZzhYEYDrvR8kfP8n1dh8OeLWhuQLsDGcYzf3L3oWbdqoY8/DjXYB1hQoxl+4
         qpgDJG9hAHR1d3+prCJa9LBzM8/RKZYvW97Cp40yHxIAVhtw8wNNAXf00s3fTGnb4rD8
         LuWEeW0HiUUYWmNY264QEebh9JtVeHnteD7ZvfrZsSBZFNVWbaUuvFrsTA9Zh+4b4rOn
         WNunFUCKkIAYZpKdkf+mt4ZdFmXQ1kbI1SKkjxts5XDLSaGgwK5eTtBAecRlKn8RUog6
         oMLF7WhzcrKLVsXQR8xfqorDHfTI4tGgSg7xqhjcG2GVs/GhqaSXDjz71bW1pCCjhseY
         rxMg==
X-Gm-Message-State: APjAAAW6aXv5q1GkmWmpfDrMxq5yxPqcZ9KJpv73dCkhEVBGzKNh0Srf
        YCI1dmHso/1OEXNZ7N4chR8=
X-Google-Smtp-Source: APXvYqz8rMVvpL0rAlFetR6dz1+IcOtgNxIcP8QKzIkVdGx+4krhmfkvlSeFl/gMz3CxemWmdEWq4g==
X-Received: by 2002:a62:6489:: with SMTP id y131mr9658230pfb.124.1567067603012;
        Thu, 29 Aug 2019 01:33:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:22 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 25/30] locking/lockdep: Introduce mark_lock_unaccessed()
Date:   Thu, 29 Aug 2019 16:31:27 +0800
Message-Id: <20190829083132.22394-26-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since in the graph search, multiple matches may be needed, a matched lock
needs to rejoin the search for another match, thereby introduce
mark_lock_unaccessed().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 05c70be..4cd844e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1521,6 +1521,15 @@ static inline void mark_lock_accessed(struct lock_list *lock,
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

