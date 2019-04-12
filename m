Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA544C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="otZiKvwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDLPPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:15:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40258 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:15:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so11604796qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ExcVMXKMLAIGNf5KmSqXrW5PdcB9ts4NWl7/RwgO/jI=;
        b=otZiKvwBqdW+yp5E+sxlXMkmP/ZdX7vWtbD/mtd0dHs4PrW2KX3YuzFsZUDMkuJgc/
         w0UCkKwKdoYReI/dgPptzYV3khKBw7sj2riOqQ8G6vyQd6uSAtjgisNqVmD8di5ZiEqs
         Zw4BXpu40szBooKU5UTvQRGYhF7Gg+ic4rFebiZ5bv3sypeI/TiR625hnOx3fhnSWwzk
         aY9eyFzrLAiiyGiQYzvyO9HFpdX3PZ4wj/lfwRflCHJJUwNEBFWwL7sZvDIJ31Owagc4
         4KHAfGjPzWg9oqhFZ0KqE8gwCnV8C7jmrR+57NKQuzD6XBgU9SRxPlt99lPgk9K2KgXl
         JEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ExcVMXKMLAIGNf5KmSqXrW5PdcB9ts4NWl7/RwgO/jI=;
        b=Ceq5cHC2uL87cAPNCKFet5FzkUhjeuuS8HJGEfF2I6UuJ5ren9NpC5B/9oDeKihsOK
         00tU5mmwGYfNDOK73stqoZYYG4wnrckzC869KXlL0nV6a2hKFL65rH+w45Q9VeZZHwNM
         enSOP5gys3vDndrkfutilRft6OS5rfYCNzEL50/EhbyGRRXVn70YrrBtqvnDwBozXi4A
         P+1mF+Pj56AGa+kxFuyla2oILwAJrP6hGACNloABIGfgwgGzCvvkpNthf3wgDCItVJx3
         fvD+ZjhDkOlHOcgR8GAKqqW3An6C+X3aCLHkMURUiMLo+im1EE5QVZ97OjYCb91l2o02
         8jMw==
X-Gm-Message-State: APjAAAXrA63YSi8417/BsAKyPRdRfGHf4mn5NIkge9RSgrA8yXrOUQqu
        yFRR/OSPh0/LHZtrNQP6n3Vufw==
X-Google-Smtp-Source: APXvYqzWgvKc4Fr5gRxDaJ6QTk0PaB7XEaAOjXMkq0vmcXUP6Zld9Yt2kxhFXms6m0K7drFhzvTUhQ==
X-Received: by 2002:a0c:89b5:: with SMTP id 50mr46177023qvr.156.1555082115847;
        Fri, 12 Apr 2019 08:15:15 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id b7sm23214436qkc.47.2019.04.12.08.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:15:15 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] mm: memcontrol: memory.stat cost & correctness
Date:   Fri, 12 Apr 2019 11:15:03 -0400
Message-Id: <20190412151507.2769-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup memory.stat file holds recursive statistics for the entire
subtree. The current implementation does this tree walk on-demand
whenever the file is read. This is giving us problems in production.

1. The cost of aggregating the statistics on-demand is high. A lot of
system service cgroups are mostly idle and their stats don't change
between reads, yet we always have to check them. There are also always
some lazily-dying cgroups sitting around that are pinned by a handful
of remaining page cache; the same applies to them.

In an application that periodically monitors memory.stat in our fleet,
we have seen the aggregation consume up to 5% CPU time.

2. When cgroups die and disappear from the cgroup tree, so do their
accumulated vm events. The result is that the event counters at
higher-level cgroups can go backwards and confuse some of our
automation, let alone people looking at the graphs over time.

To address both issues, this patch series changes the stat
implementation to spill counts upwards when the counters change.

The upward spilling is batched using the existing per-cpu cache. In a
sparse file stress test with 5 level cgroup nesting, the additional
cost of the flushing was negligible (a little under 1% of CPU at 100%
CPU utilization, compared to the 5% of reading memory.stat during
regular operation).

 include/linux/memcontrol.h |  96 +++++++-------
 mm/memcontrol.c            | 290 +++++++++++++++++++++++++++----------------
 mm/vmscan.c                |   4 +-
 mm/workingset.c            |   7 +-
 4 files changed, 234 insertions(+), 163 deletions(-)


