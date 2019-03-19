Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E04EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E602175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWam6T+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCSX42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:56:28 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56556 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSX42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id e5so545987pfi.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kx1U4HzcGCDUD7FXkKAwi3uQa2G8CItUW21Wgf4ughs=;
        b=TWam6T+qQmrNZ7BniGuFoFdA0Bom65bX9YYOcvGrtw+jSpwzeqDyGdcmm0fjhAgkD+
         5BAR3ZlcHWxbchcmC0Or5zypwA+ur2abK3ZEa+RtFtFWaCHmQ8xiRDw/CrQEBu4wZnuc
         FGpXzWPyLYYxrKlUTQZnEK7A3OfpkBwWp/U5QEB1flxIyHjq0ZcxXy5EOZj6P4NwAPMv
         hw5VrtC2hptHTLyyO/3W0bZpBIko9kaDlaIeHMT+4URsSZRzhdtzsf1dwIULDqHiVqLZ
         4Ypbj7cH7GT7qOb/s+OZUS/VWIhK1IGe/EXblQTIkr1zZKwZHpKUPpEvs+D/fV8Cqzdd
         ucmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kx1U4HzcGCDUD7FXkKAwi3uQa2G8CItUW21Wgf4ughs=;
        b=V0ZeN6sVzJR6naejc6N/qMpsMTQ/x89qNg8o+YySDJ9bnU6qrVm/v4eSYwev/Ck3q0
         I0qCZVfYuDvev5XYhe2Q/316WxqByvoj1aOFs9t5uOQ7yxl3kvjSztoBp0HxeIKoCbu/
         8oCin9P70DIWu1WLoZG9ctiH1SSdROpi4IoBRu5fBnWnMYKwV7MHS1lGN836ztkDDu8a
         czpng7X6gATLGPXJydlyuLfbFoD0gmrFup5T4rI/eKXDkX7JFc+fwOW66u2peleuo41m
         v2WELymkfM105pb4u43V/Cu2rPJduf5jKmAY5VZlR/SwSojcoGJ4sJiElMaz3d2Arnpc
         1F2Q==
X-Gm-Message-State: APjAAAVFnZIum7q8L1kJ91HQmKggyKUoLC6eeWJrRTs8OgRtoD7+pb2A
        a377Wbs0KGvDiGPRCOIfy6bkQfCCboo=
X-Google-Smtp-Source: APXvYqz/sHzZ+g6QFo17d//l//tblh/zsc+22QsrPhUP5kHVqLG5xyt/2VwRmx08JzSCz52Pk3ado9Ya3y4=
X-Received: by 2002:a63:db08:: with SMTP id e8mr8323996pgg.46.1553039787302;
 Tue, 19 Mar 2019 16:56:27 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:12 -0700
Message-Id: <20190319235619.260832-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 0/7] psi: pressure stall monitors v6
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is respin of:
  https://lwn.net/ml/linux-kernel/20190308184311.144521-1-surenb%40google.com/

Android is adopting psi to detect and remedy memory pressure that
results in stuttering and decreased responsiveness on mobile devices.

Psi gives us the stall information, but because we're dealing with
latencies in the millisecond range, periodically reading the pressure
files to detect stalls in a timely fashion is not feasible. Psi also
doesn't aggregate its averages at a high-enough frequency right now.

This patch series extends the psi interface such that users can
configure sensitive latency thresholds and use poll() and friends to
be notified when these are breached.

As high-frequency aggregation is costly, it implements an aggregation
method that is optimized for fast, short-interval averaging, and makes
the aggregation frequency adaptive, such that high-frequency updates
only happen while monitored stall events are actively occurring.

With these patches applied, Android can monitor for, and ward off,
mounting memory shortages before they cause problems for the user.
For example, using memory stall monitors in userspace low memory
killer daemon (lmkd) we can detect mounting pressure and kill less
important processes before device becomes visibly sluggish. In our
memory stress testing psi memory monitors produce roughly 10x less
false positives compared to vmpressure signals. Having ability to
specify multiple triggers for the same psi metric allows other parts
of Android framework to monitor memory state of the device and act
accordingly.

The new interface is straight-forward. The user opens one of the
pressure files for writing and writes a trigger description into the
file descriptor that defines the stall state - some or full, and the
maximum stall time over a given window of time. E.g.:

        /* Signal when stall time exceeds 100ms of a 1s window */
        char trigger[] = "full 100000 1000000"
        fd = open("/proc/pressure/memory")
        write(fd, trigger, sizeof(trigger))
        while (poll() >= 0) {
                ...
        };
        close(fd);

When the monitored stall state is entered, psi adapts its aggregation
frequency according to what the configured time window requires in
order to emit event signals in a timely fashion. Once the stalling
subsides, aggregation reverts back to normal.

The trigger is associated with the open file descriptor. To stop
monitoring, the user only needs to close the file descriptor and the
trigger is discarded.

Patches 1-6 prepare the psi code for polling support. Patch 7 implements
the adaptive polling logic, the pressure growth detection optimized for
short intervals, and hooks up write() and poll() on the pressure files.

The patches were developed in collaboration with Johannes Weiner.

The patches are based on 5.1-rc1

Suren Baghdasaryan (7):
  psi: introduce state_mask to represent stalled psi states
  psi: make psi_enable static
  psi: rename psi fields in preparation for psi trigger addition
  psi: split update_stats into parts
  psi: track changed states
  refactor header includes to allow kthread.h inclusion in psi_types.h
  psi: introduce psi monitor

 Documentation/accounting/psi.txt | 107 ++++++
 drivers/spi/spi-rockchip.c       |   1 +
 include/linux/kthread.h          |   3 +-
 include/linux/psi.h              |   8 +
 include/linux/psi_types.h        | 105 +++++-
 include/linux/sched.h            |   1 -
 kernel/cgroup/cgroup.c           |  71 +++-
 kernel/kthread.c                 |   1 +
 kernel/sched/psi.c               | 615 ++++++++++++++++++++++++++++---
 9 files changed, 836 insertions(+), 76 deletions(-)

Changes in v6:
- Fixed psi averaging regression introduced in 4/7 and caused by lack of
checking for avg_next_update before calling update_averages in psi_show
- Fixed missing header include in spi-rockchip.c causing kbuild test bot's
warning in 6/7

-- 
2.21.0.225.g810b269d1ac-goog

