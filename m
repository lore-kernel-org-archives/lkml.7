Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8FB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SWnk3hMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392922AbfETRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:24:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37253 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392908AbfETRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:24:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so161135wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1UNYn9aAe8JQscyQQ3gmPIO3RF1hK/HxqPmp/TEvUE=;
        b=SWnk3hMRMWA1Ywzo9sYOJLzsc26fwYiCJTgaYBEo4y5L3YXG/1R0ukyAVRH8Y+bg+B
         f0BVbHk0x70KIIUy5TUhVxgGfxOufrsp25rNvY1f3kN/MxBujPb8v9nl7VA+0wMwq6G/
         iztjCKbYwbdD3Y+TsXpqQWLo9btyRAuA5DuRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1UNYn9aAe8JQscyQQ3gmPIO3RF1hK/HxqPmp/TEvUE=;
        b=PwAQUKIgeGBkLFRnN8wHOmV0XcXlKldrh7t/EnqoBTm3nxIYcVbtp/drlPGuqtHlgR
         kcrP2QdZm7T7lYZs91NQgiaxmICNWzFrBHdDCiBEYAGcap9gefpco+nL8izvS8k9Je6M
         ky7yori8wkF1claKC8GwhFkj+VWoIRvlHbBWRYcF+IGSNEZdfl73wgOKD14hP9Ehk4b6
         Cbdsmece8YQCtJPvvdjU1I0o7Wb4ust/Xv/StR0BouHnrtfXm81J7WsfqUowOwFYyW/M
         3WDBdfnHR2LD4g+IKooU2FhT0sjmQ1xVgurZI6QQaXxM21FWDFBg7HnAdJozBEtPiW5n
         iLhw==
X-Gm-Message-State: APjAAAURIA2kgv9HOTMUeY/sngcaz+1fUEftLc8AIiGtY8Qcr6UbwRMy
        JQ8uDkVnyRkDGpWmWW5cKWYOC+V/8KscxA==
X-Google-Smtp-Source: APXvYqxVu0ryN3dGrAHTImcZaVGZEuUna03629XF/XZ4NdSwQQQFMOvDysXzuR7tpScTcpzb4h2yMw==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr156500wmj.105.1558373086550;
        Mon, 20 May 2019 10:24:46 -0700 (PDT)
Received: from localhost.localdomain ([91.253.179.221])
        by smtp.gmail.com with ESMTPSA id b12sm180021wmg.27.2019.05.20.10.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 10:24:46 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] ceph: fix improper use of smp_mb__before_atomic()
Date:   Mon, 20 May 2019 19:23:58 +0200
Message-Id: <1558373038-5611-5-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic64_set() primitive.

Replace the barrier with an smp_mb().

Fixes: fdd4e15838e59 ("ceph: rework dcache readdir")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 fs/ceph/super.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 6edab9a750f8a..e02f4ff0be3f1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -541,7 +541,12 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
 					   long long release_count,
 					   long long ordered_count)
 {
-	smp_mb__before_atomic();
+	/*
+	 * Makes sure operations that setup readdir cache (update page
+	 * cache and i_size) are strongly ordered w.r.t. the following
+	 * atomic64_set() operations.
+	 */
+	smp_mb();
 	atomic64_set(&ci->i_complete_seq[0], release_count);
 	atomic64_set(&ci->i_complete_seq[1], ordered_count);
 }
-- 
2.7.4

