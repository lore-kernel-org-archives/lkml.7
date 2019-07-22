Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABB21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfGVSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:24:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44437 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGVSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so17751695pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Buvwdc6bVgaISm+g6FWfaaalfuYElof6jhW4XAj/6pM=;
        b=M1VTGcJHnAx/nPKJtOs0xX8HXAzV9mTtnSx32tovrnWDgdqzLeeFj4t6FoTo3z7I9Z
         ofTiiolzxIHBXUuBRjJqGTXe9N4KFCVDjwf/KyATqnyEHLKljrymba4r2Fl2Fb+ILvd7
         PS86igmoMiE0InuRdjs4e8/bCeW+M1ECm0VE2UU6nKkBw+9p9NrJbd8wy5MbVJM68eOt
         yypI6qYnwLjKqXBLxSVQggFljhnnyxmZmFGLmwQsleqFMfgWC2Mz1WFjnETFS1nvcLPF
         uXX7SPPN8Qw1Z6wq2/3+TSGEwl9dDgS5cfBd4r828KbMZ13EUCTQNjg89H6Aucp4/ycs
         Rb8A==
X-Gm-Message-State: APjAAAUg4/dl+83Y8h9yXn/JJkwRKHTZbKuFftEHvV685t0ICFInfF0+
        uDrf1/lUtgfCfQZ3ELAp1Es=
X-Google-Smtp-Source: APXvYqwi5pkLIF5g+F/BmVn5Fbxs/dBaG1ZhIt7DbRhCk4Nq6yGuQ1ng/NQHXFCxI+twCrfwwrKBLQ==
X-Received: by 2002:a62:770e:: with SMTP id s14mr1496700pfc.150.1563819890357;
        Mon, 22 Jul 2019 11:24:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p23sm44556008pfn.10.2019.07.22.11.24.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:24:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Lockdep: Reduce stack trace memory usage
Date:   Mon, 22 Jul 2019 11:24:39 -0700
Message-Id: <20190722182443.216015-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

An unfortunate side effect of commit 669de8bda87b ("kernel/workqueue: Use
dynamic lockdep keys for workqueues") is that all stack traces associated
with the lockdep key are leaked when a workqueue is destroyed. Fix this by
storing each unique stack trace once. Please consider this patch series
for Linux kernel v5.4.

Thanks,

Bart.

Bart Van Assche (4):
  locking/lockdep: Make it clear that what lock_class::key points at is
    not modified
  stacktrace: Constify 'entries' arguments
  locking/lockdep: Reduce space occupied by stack traces
  locking/lockdep: Report more stack trace statistics

 include/linux/lockdep.h            |  11 +-
 include/linux/stacktrace.h         |   4 +-
 kernel/locking/lockdep.c           | 159 ++++++++++++++++++++++-------
 kernel/locking/lockdep_internals.h |   9 +-
 kernel/locking/lockdep_proc.c      |   8 +-
 kernel/stacktrace.c                |   4 +-
 6 files changed, 143 insertions(+), 52 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

