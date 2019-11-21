Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0DF206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4OkVN57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKUXmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:42:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKUXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:42:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so6557120wrr.1;
        Thu, 21 Nov 2019 15:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OAvYihfmyprlGMvA6yzZoAqR+VZTgepZzdSCOU+JSMg=;
        b=j4OkVN578Nk3P1Yb7bJTWjRt39+EvXssobNseLXDr5x1EeupAX3UpRHyZ4fDMeZAYo
         G+Ofv4j+cA5lhaboP4aSgxCqaPBRMX2sQ8Cexjt/eQUdAxmQ07msyeAXh7mR7PTesmts
         7bex8Qduk98W19C6ApX4c4qK4nn3P3GNgv0qBtpu7qt5x/bV3j9YZ9GmylqWQ3c+yz9J
         bZNMzBsQHCdyjsUPM2H7zApNQhXxNuoL69wvhqY6kIZIxNTdP1cKu71fT2eg21n9cdMa
         qT4jDdSn7q7HTeOuX9Xk/eCxLx3jQdR5HZY5y033T7i0f3LIcEfzI4Jd29hrO208MrhD
         pPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OAvYihfmyprlGMvA6yzZoAqR+VZTgepZzdSCOU+JSMg=;
        b=nQDsXScYM2ck5/fsaOzJ12IZsqATTlLJbjoI2x94aCqGbatEHH8lU9vbydcMYzw8vp
         1Nhb1mBqK1D1+NjdgLGUwY4hI1hVP2GIo5sYl0j6s8/6zGMNAAnhvaGndEgwLWuBq1Ng
         kYOWWrX+f4UNRxf3mODezkIezAjaCVLkFxYNxfjVRO6/ghK4Ngoy97bd6VzgyrkJca8w
         TAh4tC/OLEls3DJV5wIYG+pT2ekjKJh2RQ9MeyAlH7dTHK+G7vS+qw6plNi8orJtVid8
         W2L9SQ1J60cr77uEeXFv3Iy0Lm3hrw6xFWwnwuw2QNBU2yVe/URTO9Qu2C8D2cjXcbOC
         p9IQ==
X-Gm-Message-State: APjAAAVy9BqW8GI25ohGDg9yAJhxyufqaqQuQFh4NLiNdV8RVyZ6J8wt
        drWas5GFvcnl8wqyn9KgrsQ=
X-Google-Smtp-Source: APXvYqx57bK7QTv0yOxPXmNGqsAgfEZP2WAOXZPs2isu0c+d88W5xtrCC3FtwLdZvEbxQpWscsM9Jg==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr5895957wrs.234.1574379718574;
        Thu, 21 Nov 2019 15:41:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id l10sm5894420wrg.90.2019.11.21.15.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:57 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     corbet@lwn.net, will@kernel.org, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 5/7] docs/memory-barriers.txt: Remove remaining references to mmiowb()
Date:   Fri, 22 Nov 2019 00:41:23 +0100
Message-Id: <20191121234125.28032-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191121234125.28032-1-sj38.park@gmail.com>
References: <20191121234125.28032-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes references to sections erased by Commit 915530396c78
("Documentation: Kill all references to mmiowb()").

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/memory-barriers.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..ec3b5865c1be 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -63,7 +63,6 @@ CONTENTS
 
      - Compiler barrier.
      - CPU memory barriers.
-     - MMIO write barrier.
 
  (*) Implicit kernel memory barriers.
 
@@ -75,7 +74,6 @@ CONTENTS
  (*) Inter-CPU acquiring barrier effects.
 
      - Acquires vs memory accesses.
-     - Acquires vs I/O accesses.
 
  (*) Where are memory barriers needed?
 
@@ -492,10 +490,9 @@ And a couple of implicit varieties:
      happen before it completes.
 
      The use of ACQUIRE and RELEASE operations generally precludes the need
-     for other sorts of memory barrier (but note the exceptions mentioned in
-     the subsection "MMIO write barrier").  In addition, a RELEASE+ACQUIRE
-     pair is -not- guaranteed to act as a full memory barrier.  However, after
-     an ACQUIRE on a given variable, all memory accesses preceding any prior
+     for other sorts of memory barrier.  In addition, a RELEASE+ACQUIRE pair is
+     -not- guaranteed to act as a full memory barrier.  However, after an
+     ACQUIRE on a given variable, all memory accesses preceding any prior
      RELEASE on that same variable are guaranteed to be visible.  In other
      words, within a given variable's critical section, all accesses of all
      previous critical sections for that variable are guaranteed to have
@@ -1512,8 +1509,6 @@ levels:
 
   (*) CPU memory barriers.
 
-  (*) MMIO write barrier.
-
 
 COMPILER BARRIER
 ----------------
-- 
2.17.2

