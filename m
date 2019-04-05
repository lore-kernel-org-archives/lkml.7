Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959F52171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POG3ls9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfDERrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46825 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDERrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so3651597pfj.13;
        Fri, 05 Apr 2019 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+GhyNvJYnBsHzt2VYR0lhyQmkzqy+ME8pCoY+SKPNY=;
        b=POG3ls9DbEEMCD5ZaeH6mC8H2ulERz3laC/XzTfpfpSe5w2suJ9of1mImDy8oGuS8g
         N6zTOeNt2cgleiqrAYgjwx2J33+TTdwYT58hRor/xZz5fBS6FwWZkP83aLrZgAlUE1rv
         owF3hqd3WnXjaPrW+fKGUy4HHUa7dsUrL4fnHsb/+mc2nlsd53c9NRj/qAv1IIVQ4f0d
         dEkR6t9AwhNOOpAClDOI2SI+fjq68Qi/6AZoEl5U6z3oVNytVEO7EaSD6lsz7LsTh2Np
         nsQ63x5qoRqb0ppTobPrF/Urz1Ya0Kwb5UAVQmPgzgiAIi/DtEkoNkzBK8srWkxw151V
         +NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+GhyNvJYnBsHzt2VYR0lhyQmkzqy+ME8pCoY+SKPNY=;
        b=tIFfflA0C3KrgZqxGtPFyzxas8v1WNwYlIoicglOcE2IfO9Vjv9HHRzy+eUckyXzbg
         u3DYxXcNNfgG0BESwOfQjPjx8bbT2V0wJBrF8Sw+6N3EVisVU0JlXUSkliLBEQU8VVMH
         g54jXtxbLU7tBMk2DEaDCvGKR7cSpHa1FiOtSKL+D3DHH/yXhuGDC4RMQ/w+Kzk6yjC3
         4hRQXRV0vOALKkREgAiETE9A9cWZIxaNppsUAqhgSwEirUC8bcNxkqWmwBwt86UCniUY
         vWIBpxWH7iwYA3u0JDb0eFJaDHiUcTk7gzgnPqcYrVOHjCr89bNgYi4n4cWCs9KcA26A
         d1+A==
X-Gm-Message-State: APjAAAWYvjAw6OqTlTuj4vn5IGvcudetxy6vBrz6i8LFPebrIkuM8PMP
        eOYgslXSrBpovRUeAVT/dto=
X-Google-Smtp-Source: APXvYqwsRZWyG9TYEO6Eo0m/+4k1JrvP5InaItIhxuDwURzrmxv1gSCxeV913bSJsIop63JHamNARw==
X-Received: by 2002:a63:5c56:: with SMTP id n22mr2871223pgm.108.1554486451046;
        Fri, 05 Apr 2019 10:47:31 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:30 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 0/9] freezer for cgroup v2
Date:   Fri,  5 Apr 2019 10:46:59 -0700
Message-Id: <20190405174708.1010-1-guro@fb.com>
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

v10->v9:
  - removed redundant fatal_signal_pending() check
  - reworked vfork support
  - minor cleanups
  - rebase to cgroup/for-5.2

v9->v8:
  - added support for vfork
  - added a kselftest test for vfork case
  - several tests fixes/improvements
  - renamed stopped* into frozen* across the patchset
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
 kernel/cgroup/cgroup.c                        | 151 +++-
 kernel/cgroup/freezer.c                       | 647 +++++--------
 kernel/cgroup/legacy_freezer.c                | 481 ++++++++++
 kernel/fork.c                                 |   2 +
 kernel/signal.c                               |  70 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  58 +-
 tools/testing/selftests/cgroup/cgroup_util.h  |   5 +
 tools/testing/selftests/cgroup/test_freezer.c | 851 ++++++++++++++++++
 19 files changed, 2026 insertions(+), 432 deletions(-)
 create mode 100644 kernel/cgroup/legacy_freezer.c
 create mode 100644 tools/testing/selftests/cgroup/test_freezer.c

-- 
2.20.1

