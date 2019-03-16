Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A79C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BD8218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyIb2lSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCPR6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:58:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39619 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so8590782pgp.6;
        Sat, 16 Mar 2019 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z311MHt3CC+rWIY+JvSSnJyi2dtFznqAtBHN5psIhnY=;
        b=jyIb2lSVDjCiER7kocz7DLRkIPnubTaCgvUMKfn/ERUraRH3594eWn++PwpNODCAvn
         pJIgDdEZW7k5ipTU5WW7DzbFi0BKmcK5UXRY/UnR/WojKUz+JR3IzT46rOov6om8EHqY
         O15jGbgHl8xUKuom+nmhtAiD7eWfb+bufom3UhKaZz6jRrVsznw3Ce23uY1Ercg1KL9D
         UmybqpF4mb9WFT2ct1IwAtc2a2OsEyjwQPfcHaVI7zltGrn2jeNJqfpz4pWRxZBINeVB
         13n//iZErRHklu1TvzXBhYniI+VmFJVd3axGqcbFPqzatZ6uBb/Lh1zLnFbLilL3Qhcv
         SZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z311MHt3CC+rWIY+JvSSnJyi2dtFznqAtBHN5psIhnY=;
        b=ZRRv3jyf3tqP9zaNQBdnKQOwPpRaiNSQ5KRpt91XJ6EQx5gz21vR97Kr/wayavPF2r
         4wF7Bgm51lRX7FJ4iDcIBsiAiG+UKgqiE4cwdEQbx+N6QDxW8Eks71F101Znd32kUyJk
         mX3Sw9dV4yvDqVaqcitz6OUhsu5qIlLjjedGRQQTl0UVP8gGouH7c+dU4ibWzFIFsfl3
         RHf6OZdiH4mFntKZ9hZez0NPhsYt1Hfuevppbcj5n2Lt+WNw0gZIbMP3rufJfyqgHAuj
         7XUNKEUQCu3Gjn4reDQQ18s6rEY8IXo7P9N/oZvjK9o9GKB4iDTTAek99tzURNpVePF4
         ZGiQ==
X-Gm-Message-State: APjAAAUmMJbnDo/fwlvhCNtzC/yfcoIhh5Vgmr3VP6iQsaGFJEHGt5Ck
        m/JrK1uKBF7oFOUZit+KEmA9VkDNsgg=
X-Google-Smtp-Source: APXvYqwBGjGqnW+Cc8V4NjCeAwDj5KPVadPvuE8Iz9mYLPQrVyJOowsh/2E9tO8voMQqS5mb+b7+Zg==
X-Received: by 2002:a62:b508:: with SMTP id y8mr10546246pfe.140.1552759097107;
        Sat, 16 Mar 2019 10:58:17 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:15 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/9] freezer for cgroup v2
Date:   Sat, 16 Mar 2019 10:58:03 -0700
Message-Id: <20190316175812.6787-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements freezer for cgroup v2.

It provides similar functionality as v1 freezer, but the interface
conforms to the cgroup v2 interface design principles, and it
provides a better user experience: tasks can be killed, ptrace works,
there is no separate controller, which has to be enabled, etc.

Patches (1), (2) and (3) are some preparational work, patch (4) contains
the implementation, patch (5) is a small cgroup kselftest fix,
patch (6) covers freezer adds 6 new kselftests to cover the freezer
functionality. Patchse (7) and (8) adding tracing points to simplify
the debugging process. Patch (9) adds corresponding docs.

v9->v8:
  - added support for vfork
  - added a kselftest test for vfork case
  - several tests fixes/improvements
  - renamed stopped* into frozen* across the patchset
  - added trace points
  - other minor fixes

v8->v7:
  - reworked/simplified cgroup frozen task accounting by merging nr_stopped
  and nr_frozen and removing nr_tasks_to_freeze
  - don't notify the parent process if the child is going from the stopped
  to the frozen state

v7->v6:
  - handle properly the case, when a task is both stopped and frozen
  - check for CGRP_FREEZE instead of CGRP_FROZEN in cgroup_exit()
  - minor cosmetic changes and rebase

v6->v5:
  - reverted to clear TIF_SIGPENDING with additional checks before schedule(),
  as proposed by Oleg Nesterov
  - made cgroup v2 freezer working with the system freezer (by using
  freezable_schedule())
  - make freezer working with SIGSTOPped and PTRACEd tasks
  - added tests to cover freezing a cgroup with SIGSTOPped and PTRACEd tasks

v5->v4:
  - rewored cgroup state transition code (suggested by Tejun Heo)
  - look at JOBCTL_TRAP_FREEZE instead of task->frozen in
    recalc_sigpending(), check for task->frozen and JOBCTL_TRAP_FREEZE
    in signal_pending_state() (suggested by Oleg Nesterov)
  - some cosmetic changes in signal.c (suggested by Oleg Nesterov)
  - cleaned up comments

v4->v3:
  - reading nr_descendants doesn't require taking css_set_lock anymore
  - fixed docs based on Mike Rapoport's feedback
  - fixed double irq lock found by Dan Carpenter

v3->v2:
  - dropped TASK_FROZEN for now, frozen tasks are put into TASK_INTERRUPTIBLE
  state; it's probably not the final version, but the API question can be
  discussed separately
  - don't clear TIF_SIGPENDING before going to sleep, instead add
  task->frozen check in signal_pending_state() and recalc_sigpending()
  - cgroup-level counter are now synchronized using css_set_lock,
  which simplified the whole code (e.g. per-cgroup works were removed)
  - the amount of comments increased significantly
  - many other improvements incorporating feedback from Tejun and Oleg

v2->v1:
  - fixed locking aroung calling cgroup_freezer_leave()
  - added docs


Roman Gushchin (9):
  cgroup: rename freezer.c into legacy_freezer.c
  cgroup: implement __cgroup_task_count() helper
  cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
  cgroup: cgroup v2 freezer
  kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
  kselftests: cgroup: add freezer controller self-tests
  cgroup: make TRACE_CGROUP_PATH irq-safe
  cgroup: add tracing points for cgroup v2 freezer
  cgroup: document cgroup v2 freezer interface

 Documentation/admin-guide/cgroup-v2.rst       |  27 +
 include/linux/cgroup-defs.h                   |  33 +
 include/linux/cgroup.h                        |  43 +
 include/linux/sched.h                         |   2 +
 include/linux/sched/jobctl.h                  |   2 +
 include/trace/events/cgroup.h                 |  55 ++
 kernel/cgroup/Makefile                        |   4 +-
 kernel/cgroup/cgroup-internal.h               |   8 +-
 kernel/cgroup/cgroup-v1.c                     |  16 -
 kernel/cgroup/cgroup.c                        | 150 ++-
 kernel/cgroup/freezer.c                       | 640 +++++--------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++
 kernel/fork.c                                 |   6 +
 kernel/signal.c                               |  75 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  58 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   5 +
 tools/testing/selftests/cgroup/test_freezer.c | 851 ++++++++++++++++++
 19 files changed, 2028 insertions(+), 431 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.20.1

