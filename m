Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EBAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577D92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJqPC+lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfDXKUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42864 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfDXKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so4711486pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GNpNFrtbUPs1OkHRgpCloIO05ldjgSD5I8sfdgOvuTA=;
        b=rJqPC+lR7CqHJ356EHRILeDMqKNqLyyJyVcA//aO6JwgoqBv4SYOAqk9qjg5Hi7QXT
         oxtIzSeDnthwD3j330m6eLzsxk1+VrBmJNFyiWzy3jmCughBC1Js4BwU5nKFABlzeM12
         itAsGundIj6yMZz061K9z5vbhyEv1Gj0RxiTBaTxTN8ex0mA6vnaUiRqVjT1GCatKkc3
         boGBlkwvkEe/r8jMDf8TvOeJYX9t75LqJdGAfFjoBc4iqyrwIKU8fPAig81dwTrChxS4
         djSrw0ZRlgBTQJ8QVb3pa0zgOajgLWmOGfm50hccMBUp3mrjW8hE9XnQFBPvdamOwSbl
         T1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GNpNFrtbUPs1OkHRgpCloIO05ldjgSD5I8sfdgOvuTA=;
        b=ZiI9Rrv/4a5mvhAln+cWJz6zgVTJar49HQTey/kFOs6aTrmJC+0l7koLFYTH16Ucu/
         cooaTVVkIuTF4TLlN8BMY5xpgJ+YB1gpEkp/G59Ih7FikbojfV4xdZvK2cE/O9il+Ctq
         uuAqH+kvXURyjkFINslVPaxShfwOpZdvLyYPOP81J5iRndMRBz4yLTj50FXb50fTpyPd
         w8/0MyLpL6mYhqBzgk6ScOVUF2FnOHkytifq5+Uapk8EyfHzxtkMQAe2ojVC+AFtbxC7
         ThBGJXBIzbMOicvMPQZsXf0Dy0hMkrgL9VbojKI7LGGIoLGU7DF/l9PAzEMrjGB663MF
         SGoA==
X-Gm-Message-State: APjAAAWnBvBbHU3TAbs0AtxtcSDzzBQLLgR97vy83CWjJs6EtbfDsI+6
        g/R4Mn2xZ6wn4kn592CV/Tc=
X-Google-Smtp-Source: APXvYqwlJ7pzYhEvD/H0NOjUcd/wDHcWJC1Ks67qpbgKZud3ainRFT3jkmkk0ix+uC5rcAAHHj5cXQ==
X-Received: by 2002:a17:902:8604:: with SMTP id f4mr30734417plo.245.1556101227774;
        Wed, 24 Apr 2019 03:20:27 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:27 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 00/28] Optimize IRQ usage checks and other small bits
Date:   Wed, 24 Apr 2019 18:19:06 +0800
Message-Id: <20190424101934.51535-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be desirable to optimize IRQ usage related checks as they
traverse dependency graph multiple times, especially for irq-unsafe
usage checks with backward search since most of the locks are
irq-unsafe.

This series completely removes backward dependencies. The idea is to
mark locks whether they can be reached from irq-safe locks in forward
graph traverses after irq-safe locks are encountered.

As a result, this series not only cuts the dependency list entries by
half and saves memory, but also significantly reduces both forward and
backward checks, which is briefly demonstrated on a simple workload:
Linux kernel build (i.e., make clean; reboot; make vmlinux -j8).

Results:

------
Before
------

direct dependencies:                  6900 [max: 32768]
max bfs queue depth:                   272
find-mask forwards checks:            2875
find-mask backwards checks:          50229

-----
After
-----

direct dependencies:                  3444 [max: 16384]   ( -  50 % )
max bfs queue depth:                   223                ( -  18 % )
find-mask forwards checks:             370                ( -  87 % )
find-mask backwards checks:              0                ( - 100 % )


The patches are organized as follows:

Patches 1 - 18
--------------
My previous small improvements. They are trivial but each is made for a
reason, so I still post them here. Please give them a look, Peter. I
have carried them for a while and rebased them a couple of times solving
confilicts.

Patches 19 - 28
---------------
The new IRQ check algorithm implementation is fairly long, so I tried to
divide it into as many patches as I can (actually this does not help
much). Also I tried to describe what it does in changelogs as detailed
as I can.

The performance numbers have not considered Frederic's recent big
improvements. Anyway, this series happened in parallel and I'd be happy
to rebase it.

HEAD: 7037e8d0af6c8ce5657c83e894c756ee1d33ce80

Thanks,
Yuyang

--

Yuyang Du (28):
  locking/lockdep: Change all print_*() return type to void
  locking/lockdep: Add description and explanation in lockdep design doc
  locking/lockdep: Adjust lock usage bit character checks
  locking/lockdep: Remove useless conditional macro
  locking/lockdep: Print the right depth for chain key colission
  locking/lockdep: Update obsolete struct field description
  locking/lockdep: Use lockdep_init_task for task initiation
    consistently
  locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
  locking/lockdep: Change the range of class_idx in held_lock struct
  locking/lockdep: Remove unused argument in validate_chain() and
    check_deadlock()
  locking/lockdep: Update comment
  locking/lockdep: Change type of the element field in circular_queue
  locking/lockdep: Change the return type of __cq_dequeue()
  locking/lockdep: Avoid constant checks in __bfs by using offset
    reference
  locking/lockdep: Update comments on dependency search
  locking/lockdep: Add explanation to lock usage rules in lockdep design
    doc
  locking/lockdep: Remove redundant argument in check_deadlock
  locking/lockdep: Remove unused argument in __lock_release
  locking/lockdep: Optimize irq usage check when marking lock usage bit
  locking/lockdep: Refactorize check_noncircular and check_redundant
  locking/lockdep: Consolidate lock usage bit initialization
  locking/lockdep: Adjust new bit cases in mark_lock
  locking/lockdep: Update irqsafe lock bitmaps
  locking/lockdep: Remove !dir in lock irq usage check
  locking/lockdep: Implement new IRQ usage checking algorithm
  locking/lockdep: Remove __bfs
  locking/lockdep: Remove locks_before
  locking/lockdep: Reduce lock_list_entries by half

 Documentation/locking/lockdep-design.txt |  107 +++-
 include/linux/lockdep.h                  |   51 +-
 init/init_task.c                         |    2 +
 kernel/fork.c                            |    3 -
 kernel/locking/lockdep.c                 | 1033 ++++++++++++++++++------------
 kernel/locking/lockdep_internals.h       |   19 +-
 kernel/locking/lockdep_proc.c            |    1 -
 7 files changed, 757 insertions(+), 459 deletions(-)

-- 
1.8.3.1

