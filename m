Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBE3218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7RJe13w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfDXKXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:23:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41585 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfDXKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so9076425pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byZGzHb7mBNvQYwj1NTd7kgCiIjW1R3pXbNxGql0JSY=;
        b=l7RJe13wIUPyhqAezRTph1hO06w08OQqzXcgrOTHCGZrOCgt3Nd7fngbQbOy3594Od
         Nwn5wqo0LPKZJ40jVWtOd7XhgnmTlxxbuUMF3E8kIxSJqcHJDb9pbB9M4J/h8bcZeUPI
         x90gDkU396re3dG9QYmvA8FdNSAuICtJfljAhAJQxGLRI9zFUWzVW7h9NUX8wy6KwuCX
         jX9woaf1v267+HRaj3JD4RzxATeU4h0emJVJBRJXqj61Qsg6RX+cXh3Blpt0dp9hprRr
         RsoaQKIBo4FQpb/O1k81pbI4m56xnAP97uQ65tUJfFq0QxVrQ7N9NM4mOz5wabJMg/sv
         x6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byZGzHb7mBNvQYwj1NTd7kgCiIjW1R3pXbNxGql0JSY=;
        b=ufwSTy8o0MmvQ/sjjP9/i+/WBWGB/7nwwswO7+2XWiKJE8iPO/q4+kykxKwPO98LkZ
         6+hEI+X2LovGWK0hVrJxdPprs0LFwUxsBMXuaSRzJq3KeYYyC5miWjfkGRsLSEsOxv6P
         k6zJv7htEkbnNsxmptso9UnhGWGqCe5Kr+wTV48cZtPAO99W5aqDOj1Jw0TmCjQVIBJT
         D5xMqCKkWobCQaTG17rdSDPQTv9Fun7bx9KfSCQK8wLoCgsHZGoQSBFAEGfVboqkAb6K
         vKc+pmos6qNEzfhoaS9vTTkwpJYUWNYNcP/s5fBRx8N54puj+PKX1mkaQ+/l/jSySPbj
         8EEQ==
X-Gm-Message-State: APjAAAV76Tx5sCBwg8zOa+FQjahz3MS9LBviCwIF6JnKXWXp5VxVJCiH
        DcoTYxH1p6QahVk3GrUujzc=
X-Google-Smtp-Source: APXvYqz2d565h29uKjEh7JBAgOy8m/5h+2Bo01y3LRLBN7+LyASaSuCZleXGuQFbJv9NIzxDCDvgBA==
X-Received: by 2002:a62:1249:: with SMTP id a70mr32727130pfj.160.1556101237377;
        Wed, 24 Apr 2019 03:20:37 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:36 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 03/28] locking/lockdep: Adjust lock usage bit character checks
Date:   Wed, 24 Apr 2019 18:19:09 +0800
Message-Id: <20190424101934.51535-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock usage bit characters are defined and determined with tricks.
Add some explanation to make it a bit clearer, then adjust the logic to
check the usage, which optimizes the code a bit.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4bf396b..ba0080a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -499,15 +499,26 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
+	/*
+	 * The usage character defaults to '.' (i.e., irqs disabled and not in
+	 * irq context), which is the safest usage category.
+	 */
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+	/*
+	 * The order of the following usage checks matters, which will
+	 * result in the outcome character as follows:
+	 *
+	 * - '+': irq is enabled and not in irq context
+	 * - '-': in irq context and irq is disabled
+	 * - '?': in irq context and irq is enabled
+	 */
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK)) {
 		c = '+';
-	if (class->usage_mask & lock_flag(bit)) {
-		c = '-';
-		if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+		if (class->usage_mask & lock_flag(bit))
 			c = '?';
-	}
+	} else if (class->usage_mask & lock_flag(bit))
+		c = '-';
 
 	return c;
 }
-- 
1.8.3.1

