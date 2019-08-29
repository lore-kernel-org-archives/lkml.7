Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C9E2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="merw0Q1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfH2Ibq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:31:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41349 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2Ibp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:31:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so1232438pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaze9bzG5aeP0yTMfZOycZ7PZoKMafcz3dH4+2jGdPU=;
        b=merw0Q1FbAuoLCzpH0+VL5as1ZGIz0BFteZoMOvHFnCav32SkwQDtJTYUf6/BO0cHA
         oEj1bPGB67zJ8pb3xjdnOqHa1++j9FSH6rvS2hbhfqA/RXF7+8XjRWCIouw2JB9k852I
         a51G3TeQTfZKeR74zwU/j/oDhy79m6vl6uT71fpAfzcmjfVi8cVRWRes8V2zIV6GqjZS
         W/lGVzJ7c9IDqkEM4Hk1pYHwcR1xdB6vwkegkkqM2kFuFr3OfL2um/Om1qHBvqTrzoR5
         G+YQ761rjnM4J/zYuHjYnfSmBxWYYLNfF6bG/AfdYmwpXBwOS15A5G85GQ70sf4+XYoz
         rE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaze9bzG5aeP0yTMfZOycZ7PZoKMafcz3dH4+2jGdPU=;
        b=gHUHhXW9M61W5fqWVP8tbNnxPKDQjYt0b79T4Xt/orSs5vLfJ7t6U1XxDR4kVy6lNp
         twzUEYd0ZpvymAsdqJ7IsPeFqDMSuSacHym/ONo5j0DyQVliOz8lSYAONs6qxqaajWtn
         hAePzRxvvWqIDlvh0LM+NXFyYRILKU7Pfa5UXpNK/5VwXwW/KIGRKZUhz4mwwq1Sycs/
         V/NfKsVkveUfuvlVAQ3dwAYZkcP1DLA3PmuNeLutlPjpqehkxLDpi2IJ9I/lV4NYP5hV
         8j3q+XoE4SfQ1uRGfr6o6Ga3ximLBxf5TCLGV2frtvNNpyQWiMij7y75U7z2/85TyP/r
         PrLA==
X-Gm-Message-State: APjAAAViLYBubMfdBKvfIVVR33wadYM6PDdx68Gr3bvvjWnLGq3pw4KQ
        uu7MppbzQ7Y4SwSTerA0Y2g=
X-Google-Smtp-Source: APXvYqzvQw/1hpYmHmqFZhtb9N3ZpNiMSR1LS0iHFr30ufagciXngTiBCCZsMN3xAVjU8g4nYxrKng==
X-Received: by 2002:a17:902:4d45:: with SMTP id o5mr8717952plh.146.1567067505261;
        Thu, 29 Aug 2019 01:31:45 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:31:44 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 00/30] Support recursive-read lock deadlock detection
Date:   Thu, 29 Aug 2019 16:31:02 +0800
Message-Id: <20190829083132.22394-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

This patchset proposes a general read-write lock deadlock detection
algorithm on the premise that exclusive locks can be seen as a
special/partial usage of read-write locks. The current Linux kernel
locks are all considered in this algorithm. Prominently, the
recursive-read lock can be well supported, which has not been for more
than a decade.

The bulk of the algorithm is in patch #27. Now that the recursive-read
locks are suppported, we have all the 262 cases passed.

Please, some of the minor fix and/or no-functional-change patches may
be reviewed at least.


Changes from v3:

 - Reworded some changelogs
 - Rebased to current code base
 - Per Boqun's suggestion, reordered patches
 - Much more time elapsed

Changes from v2:

 - Handle correctly rwsem locks hopefully.
 - Remove indirect dependency redundancy check.
 - Check direct dependency redundancy before validation.
 - Compose lock chains for those with trylocks or separated by trylocks.
 - Map lock dependencies to lock chains.
 - Consolidate forward and backward lock_lists.
 - Clearly and formally define two-task model for lockdep.


--

Yuyang Du (30):
  locking/lockdep: Rename deadlock check functions
  locking/lockdep: Change return type of add_chain_cache()
  locking/lockdep: Change return type of lookup_chain_cache_add()
  locking/lockdep: Pass lock chain from validate_chain() to
    check_prev_add()
  locking/lockdep: Add lock chain list_head field in struct lock_list
    and lock_chain
  locking/lockdep: Update comments in struct lock_list and held_lock
  locking/lockdep: Remove indirect dependency redundancy check
  locking/lockdep: Skip checks if direct dependency is already present
  locking/lockdep: Remove chain_head argument in validate_chain()
  locking/lockdep: Remove useless lock type assignment
  locking/lockdep: Remove irq-safe to irq-unsafe read check
  locking/lockdep: Specify the depth of current lock stack in
    lookup_chain_cache_add()
  locking/lockdep: Treat every lock dependency as in a new lock chain
  locking/lockdep: Combine lock_lists in struct lock_class into an array
  locking/lockdep: Consolidate forward and backward lock_lists into one
  locking/lockdep: Add lock chains to direct lock dependency graph
  locking/lockdep: Use lock type enum to explicitly specify read or
    write locks
  ocking/lockdep: Add read-write type for a lock dependency
  locking/lockdep: Add helper functions to operate on the searched path
  locking/lockdep: Update direct dependency's read-write type if it
    exists
  locking/lockdep: Introduce chain_hlocks_type for held lock's
    read-write type
  locking/lockdep: Hash held lock's read-write type into chain key
  locking/lockdep: Adjust BFS algorithm to support multiple matches
  locking/lockdep: Define the two task model for lockdep checks formally
  locking/lockdep: Introduce mark_lock_unaccessed()
  locking/lockdep: Add nest lock type
  locking/lockdep: Add lock exclusiveness table
  locking/lockdep: Support read-write lock's deadlock detection
  locking/lockdep: Adjust selftest case for recursive read lock
  locking/lockdep: Add more lockdep selftest cases

 include/linux/lockdep.h            |   91 ++-
 include/linux/rcupdate.h           |    2 +-
 kernel/locking/lockdep.c           | 1227 ++++++++++++++++++++++++------------
 kernel/locking/lockdep_internals.h |    3 +-
 kernel/locking/lockdep_proc.c      |    8 +-
 lib/locking-selftest.c             | 1109 +++++++++++++++++++++++++++++++-
 6 files changed, 1981 insertions(+), 459 deletions(-)

-- 
1.8.3.1

