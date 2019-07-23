Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C5AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA9D21901
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSyIOGxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbfGWMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:50:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40944 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGWMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:50:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so19094392pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ScN8WzRMKv9ujMKagsG6pPThL/4YrWzQ0Mh2lGU8I9Q=;
        b=TSyIOGxIgaDKwv/VxCj9bFdSyEYkKmwRWtQYccafT2FZwvSVPVcwGy9p6YB3jYyvfE
         IeYF5PtZPvSwA/3F6zkI8ozhCAqW8aWMETFoQu8cRdcCNYvdZCXrki5P2bKeogpqBf1U
         WMbprsYbetR4G+JcREVUCLaDKpwNV683KXqQjMVypckUH0XsUeWzZmjF92kDBtefSYzV
         pqwB917WJ7+yZsTh8QnRa9ZYQCRByw9Z3GBy9V58gi2Rk3qUvUosmftkhYzYmXk5taoN
         Dn4Cu3sHOB1KHX5a6R+ensmxSRb8PpYckJXntTO3mH+0JCiq2XsT7/my9jVxTIJo1f6L
         FXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ScN8WzRMKv9ujMKagsG6pPThL/4YrWzQ0Mh2lGU8I9Q=;
        b=QeCedJmevMijKN7VOJxIxsn9vZ3gIZQyfTwt3tn7XWR5247dAllUjYUgPnLJTSk1HK
         igzqmZCGJEL0F6CCDFKJ2sp8quncbDcZDcAPa+qYcb1qJDiBpq3fOJWVy961NqQUzJuh
         hW/4DLBsCctpGUZR4osp+usGtW0uxFFszbi6QzuWmKSuOv/6lFjo4wbE0eIbtN6n5Vuw
         LqcHf+YyY94g8Xf4bn85FZ05fKkTwFKKCgnvd7P/5YRn/vc4gUFz/bZ1GfWCzG7hMQw1
         64MkTU4Do4mfp0FaINuVzKP5PjYUyTyzcw6YAAnCCQUiei061R6hZSUdUBKJzNb56IAd
         E90g==
X-Gm-Message-State: APjAAAV6J9xkitD7u8H9wGvh73GNLB7KYM4zhjAiS1xtYxHh5pdqt5iZ
        mIw0oO92r6jV5S8VA4u26Cs=
X-Google-Smtp-Source: APXvYqxF0qCyIETGsOEUtisC5gjWspQwU9DqLrwTq+1COsi6j95zH/CKSyJl1TUBThdLpBE6qoH3GA==
X-Received: by 2002:a62:4e58:: with SMTP id c85mr5635177pfb.176.1563886200947;
        Tue, 23 Jul 2019 05:50:00 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id e17sm33750479pgm.21.2019.07.23.05.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 05:50:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] kernel: auditfilter: Fix a possible null-pointer dereference in audit_watch_path()
Date:   Tue, 23 Jul 2019 20:49:51 +0800
Message-Id: <20190723124951.25713-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In audit_find_rule(), there is an if statement on line 894 to check
whether entry->rule.watch is NULL:
    else if (entry->rule.watch)

If entry->rule.watch is NULL, audit_compare_rule on 910 is called:
    audit_compare_rule(&entry->rule, &e->rule))

In audit_compare_rule(), a->watch is used on line 720:
    if (strcmp(audit_watch_path(a->watch), ...)

In this case, a->watch is NULL, and audit_watch_path() will use:
    watch->path

Thus, a possible null-pointer dereference may occur in this case.

To fix this possible bug, an if statement is added in
audit_compare_rule() to check a->watch before using a->watch.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 kernel/auditfilter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b0126e9c0743..b0ad17b14609 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -717,6 +717,8 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 				return 1;
 			break;
 		case AUDIT_WATCH:
+			if (!a->watch)
+				break;
 			if (strcmp(audit_watch_path(a->watch),
 				   audit_watch_path(b->watch)))
 				return 1;
-- 
2.17.0

