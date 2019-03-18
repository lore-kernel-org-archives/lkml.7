Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4671BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457A20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF5G5RXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCRI6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32932 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfCRI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so7708313pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZtu1dgITnZTUGFaUngQpYQEU/UJAEfhiDxYPu729A8=;
        b=jF5G5RXmbh2pKZRfGIv5zBhsCCaSTcopeQiY+lLygdWh5Y50Fg1PN8FHnQAX/u8X2U
         uOIRWRdzaenR3wBAy3loc5PCrjSz/Gu2fdYWugeDrDCyTow3aS+wd47QN0JOBUXAZgMs
         jZv/Yohi/bcS5Z9gx+DK6FeRisa3stlK+r5NPNQZnMwXwl0KHwoozQwRDevV8KsYjM4i
         lzSKhFD1oMF/LcQXCjjSZOPVuyeT9BMk/AN+d/Zl/vGQ7pY0tpF1BtATf62EZ/Ygdvhe
         8ZvbQVRH4FJatuEkClZhKKQr9yrMK3nvEXyoY5C8hIdO8TmBQmLfp1uEi/HGQxh1muWd
         kPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HZtu1dgITnZTUGFaUngQpYQEU/UJAEfhiDxYPu729A8=;
        b=hjDogFSKN82h0bM3/nixBdTiCLoTBIcOHi1ec/RiRrLWcl0EwC2T71+RBA4xUlzHb5
         rf96T7GmrW5ttOlal+pJaIeljOCWo/iQ3t7EeZVb18nNYJjpHDbHdhLMLIV4Wg/D0syN
         CiUGm6hoAlCrsmd0UPFB6VxS8/Iz23sVMYYyu5fTipJD1PnsynqG6+jod9jbKVy6gqKY
         e8RoQFEfeTh2OwV4D9T+FNe6Et/jNGMk8LR1tb4e+yIZ/GFzN+635ZCkadGR3jSorgbH
         JdIMHbCYahOpmP3ap7VO4n6QzG3i+Hv1UoBG6dk1jdPNc7ITifOOGC2n55mI7xaTMBTP
         oXrg==
X-Gm-Message-State: APjAAAWNo94D9RATGLQW5OxtCJZb3CLYUKDsYvNu0w7AeiBZSLjWp6i3
        8lWeQixM0V0Z3UD13bxOR8WXVIUAF8jhWw==
X-Google-Smtp-Source: APXvYqzO7PAN/cWTyhNk+RIm6kKE+OKVxNOwgi+dmG9VIuLMY3/C5T6EqHKM+Tf19nwuJjwSaSrkZw==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr18612945plr.36.1552899497274;
        Mon, 18 Mar 2019 01:58:17 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:16 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 12/19] locking/lockdep: Update comment
Date:   Mon, 18 Mar 2019 16:57:26 +0800
Message-Id: <20190318085733.3143-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An out-of-nowhere comment is removed. While at it, add more explanatory
comments. Such a trivial patch!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dcff644..250ba64 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2717,10 +2717,16 @@ static int validate_chain(struct task_struct *curr,
 		 * - is softirq-safe, if this lock is hardirq-unsafe
 		 *
 		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock.
+		 * could lead back to the previous lock:
 		 *
-		 * any of these scenarios could lead to a deadlock. If
-		 * All validations
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
 		 */
 		int ret = check_deadlock(curr, hlock, hlock->read);
 
-- 
1.8.3.1

