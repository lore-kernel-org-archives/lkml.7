Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095A421926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfGXSx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:53:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32905 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfGXSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:53:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so21393753pfq.0;
        Wed, 24 Jul 2019 11:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L7bWzjBJyEbT7zsV5SFsXnXnKd4LtcokagI4T+/4CWY=;
        b=Qw4FJgv0SGNbNd1CqiInQVEM6mkb0N8jD4gwuKZgdjsvvrPVpMZ9CRdwlto8fVjYNx
         VFAasKfe9rcaLKcPnHkjb0Ns9bZjKagfv3iXtX9hRupU6qD9CV7LHgFV11PUqNEa4jrB
         ifT32AX0MlGGQlcAF+tdxh8z8pcIP8+54wZ3ZFemwvCYi6g+NbT2PoQXd4IcPnM19sWi
         m8ruqyE0P7IZVLn2Agpo9VoFRMK5xKqyfjWJ0tOSyijUFSyXKTqKeBRrUgDdTUhIOE/m
         HOEC5nmsEDiqxFDysqk9tAD+cg3EEYiH8zqhbudf1lzGPoX72SdhcBN7RwlwynKxo4Kv
         xY8Q==
X-Gm-Message-State: APjAAAUWeNp7dsIM3o+ExRI+sQyoiPxOm7VPy3bA7iYT9RFB0qkFt+pf
        +flFiyZ63lPk5koErj188Co=
X-Google-Smtp-Source: APXvYqwhQqeyh2m7qTp5zGBU78gNNt/Vbi4mI1qQS2AsCWVc08dNVW17eL8iaLy62qxuuurRahR9Qw==
X-Received: by 2002:a63:d30f:: with SMTP id b15mr81937093pgg.341.1563994404628;
        Wed, 24 Jul 2019 11:53:24 -0700 (PDT)
Received: from localhost.localdomain ([64.124.23.162])
        by smtp.gmail.com with ESMTPSA id b29sm78868092pfr.159.2019.07.24.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 11:53:24 -0700 (PDT)
From:   Phil Frost <indigo@bitglue.com>
Cc:     Ingo Molnar <mingo@elte.hu>, trivial@kernel.org,
        Phil Frost <indigo@bitglue.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Correct documentation for /proc/schedstat
Date:   Wed, 24 Jul 2019 11:50:27 -0700
Message-Id: <20190724185029.26822-1-indigo@bitglue.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 425e0968a25fa3f111f9919964cac079738140b5 ("sched: move code into
kernel/sched_stats.h") appears to have inadvertently changed the unit of
time from jiffies to nanoseconds as part of the implementation of CFS.

Signed-off-by: Phil Frost <indigo@bitglue.com>
---
 Documentation/scheduler/sched-stats.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.txt b/Documentation/scheduler/sched-stats.txt
index 8259b34a66ae..b6c1807a01b3 100644
--- a/Documentation/scheduler/sched-stats.txt
+++ b/Documentation/scheduler/sched-stats.txt
@@ -19,6 +19,11 @@ are no architectures which need more than three domain levels. The first
 field in the domain stats is a bit map indicating which cpus are affected
 by that domain.
 
+2.6.23 introduced the CFS scheduler, and also an inadvertent
+backwards-incompatible change to the statistics. Although the schedstat version
+is 14 in either case, in 2.6.23 and later, counters accumulate time in
+nanoseconds. Prior to that, jiffies.
+
 These fields are counters, and only increment.  Programs which make use
 of these will need to start with a baseline observation and then calculate
 the change in the counters at each subsequent observation.  A perl script
@@ -48,9 +53,10 @@ Next two are try_to_wake_up() statistics:
      6) # of times try_to_wake_up() was called to wake up the local cpu
 
 Next three are statistics describing scheduling latency:
-     7) sum of all time spent running by tasks on this processor (in jiffies)
+     7) sum of all time spent running by tasks on this processor (in
+        nanoseconds, or jiffies prior to 2.6.23)
      8) sum of all time spent waiting to run by tasks on this processor (in
-        jiffies)
+        nanoseconds, or jiffies prior to 2.6.23)
      9) # of timeslices run on this cpu
 
 
-- 
2.20.1 (Apple Git-117)

