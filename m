Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050E12148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="h7t5XH2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCQMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:23:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:23:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id f65so10394029wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VjG0kRzlBwR8YGaPDB6PFGDHZQlihIoW/wLAoir9C6s=;
        b=h7t5XH2PM9T1GfnLSkLWRzEdRNSs47JxDFqrJG+d/OIH/8SyW+DoHFfzB6PdUSlzsx
         LW5/9fl/4W6U3k/wp6c/82PrDLiEPrST+sQcgX0VffsDZJEpZtpz/80NIrR9+pPcXlBJ
         caAyK2F0UvItWGPvGWJ1f1NoR9jYrMgJUXZJCYlQMn6QJUFAUkZMGtsuqpg4miIJAz4T
         HQ0hKzqbzeoa+nDuOZRT3Huhi6hUNXfGfjR6AxcoZdWiZEmoxsRH5Xh496Iwrmm/tVuz
         iuAZ65nVJJL+PXNZbes+HLoQ72GScTVuuBD6H0qlxCc3ERtnBDyhWB4EDka0DsVaZk0J
         LWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VjG0kRzlBwR8YGaPDB6PFGDHZQlihIoW/wLAoir9C6s=;
        b=Z+MQNWe3Ohfq+2UB/wXuDH8verkZStZGZXIOam0ZJxhb+ElVyGFWBcqgTHA3Il2tDM
         0XFBGW82DDwyuRyUnDyKlb0JLxn5vpJbM0UbvY9YuSrthmYbzqdWgDDvMy4Asaw4BRim
         Yt91OddTNkxTBaiHiryDoN5yTKBZrkahqLpurpsw8itQKc4Wz7zCEU3hR/hAS0HSkKZw
         THkPFlXCnq4uBRr8/n8XsSLmaM7iVhxYit5JIboAwNaieLpIN0Bu2LhQfSK+9y5DRhib
         mpOiTs2GmLEMT7khzD+eXoLaWHJ41u6ONRTSXYYFdZVXuVXt/M60Rbfq1Wnhqs5Q5GMB
         lJUA==
X-Gm-Message-State: APjAAAUoDD7Ltyiz8BgCXp8achwZbGCj1cBGIP2KvMY0Is/JAVGgED44
        eNZc/8pNbomKA/Mn2PKUTIPTKg==
X-Google-Smtp-Source: APXvYqyMJyha9n/BqjuPYtl9H8kEeJRJ9AyYsISWHIBvbXB70exu3BpBG5W5C4NdH5XRKXYgEN9FSA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr8175785wmb.40.1552825380974;
        Sun, 17 Mar 2019 05:23:00 -0700 (PDT)
Received: from snf-864.vm.snf.arr ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id z10sm5453292wrs.11.2019.03.17.05.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:23:00 -0700 (PDT)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com
Cc:     mpatocka@redhat.com, paulmck@linux.ibm.com, hch@infradead.org,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] dm snapshot: Improve performance using a more fine-grained locking scheme
Date:   Sun, 17 Mar 2019 14:22:52 +0200
Message-Id: <20190317122258.21760-1-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-snapshot uses a single mutex to serialize every access to the
snapshot state, including accesses to the exception hash tables. This
mutex is a bottleneck preventing dm-snapshot to scale as the number of
threads doing IO increases.

The major contention points are __origin_write()/snapshot_map() and
pending_complete(), i.e., the submission and completion of pending
exceptions.

This patchset substitutes the single mutex with:

  * A read-write semaphore, which protects the mostly read fields of the
    snapshot structure.

  * Per-bucket bit spinlocks, that protect accesses to the exception
    hash tables.

fio benchmarks using the null_blk device show significant performance
improvements as the number of worker processes increases. Write latency
is almost halved and write IOPS are nearly doubled.

The relevant patch provides detailed benchmark results.

A summary of the patchset follows:

  1. The first patch removes an unnecessary use of WRITE_ONCE() in
     hlist_add_behind().

  2. The second patch adds two helper functions to linux/list_bl.h,
     which is used to implement the per-bucket bit spinlocks in
     dm-snapshot.

  3. The third patch removes the need to sleep holding the snapshot lock
     in pending_complete(), thus allowing us to replace the mutex with
     the per-bucket bit spinlocks.

  4. Patches 4, 5 and 6 change the locking scheme, as described
     previously.

Changes in v3:
  - Don't use WRITE_ONCE() in hlist_bl_add_behind(), as it's not needed.
  - Fix hlist_add_behind() to also not use WRITE_ONCE().
  - Use uintptr_t instead of unsigned long in hlist_bl_add_before().

v2: https://www.redhat.com/archives/dm-devel/2019-March/msg00007.html

Changes in v2:
  - Split third patch of v1 into three patches: 3/5, 4/5, 5/5.

v1: https://www.redhat.com/archives/dm-devel/2018-December/msg00161.html

Nikos Tsironis (6):
  list: Don't use WRITE_ONCE() in hlist_add_behind()
  list_bl: Add hlist_bl_add_before/behind helpers
  dm snapshot: Don't sleep holding the snapshot lock
  dm snapshot: Replace mutex with rw semaphore
  dm snapshot: Make exception tables scalable
  dm snapshot: Use fine-grained locking scheme

 drivers/md/dm-exception-store.h |   3 +-
 drivers/md/dm-snap.c            | 359 +++++++++++++++++++++++++++-------------
 include/linux/list.h            |   2 +-
 include/linux/list_bl.h         |  26 +++
 4 files changed, 269 insertions(+), 121 deletions(-)

-- 
2.11.0

