Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAE4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F56C208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0E6l8PL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfCHSnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:19 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53958 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfCHSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:19 -0500
Received: by mail-pf1-f201.google.com with SMTP id o67so23026714pfa.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ACm0jVzCyuutlk8CKHsubOzb2TygYzufZCwbrPfQ1JQ=;
        b=J0E6l8PLxa5AD+SoFiGGjQrXKPVXQ7Cx91Pa0ZqDnL4UDnfiPF53kuY9n0IrxtSJiM
         EIMnT7i9kQ+MVedAntcAllJrZpI4iOUum/s1tw+sRsvJ4hwpOnCAsLrq1Bjgn5EAsHn6
         63AjOaYrP0ccldyFwZsJ0TY2SmZpeFs1HC280O5/5PUWcwrYCg0URIhkoBBt3tD121nY
         gjebWK2xb+jE87wqcSqDIS3q9gc5xe2SgWxrcUBr2POsuqcgVIgQ4zLSHPNt3Ba/++Iu
         08MHlYhpV7pNvDPrwT9m2ejAUuXL5nsURLT6CZT97fJchmrfMW81badeAl+Zd4jnRhF6
         1OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ACm0jVzCyuutlk8CKHsubOzb2TygYzufZCwbrPfQ1JQ=;
        b=t4IyIMANhF5gyuw1Rju7KjEOPpnUn3kIcBg0EG+5drXFP+PeVR1SGxoW3U2E/BEvCr
         /jIpVdn4nz/mAdMjhsZYbTkcXx8R1NHUKg06Tl20ueyVyrYi48VmWoGbDUZpS3hpNcJd
         O4woziKNdoe9LdPfFhHpMtaw+Ve86CSE0tqGXbMGLD75pYW5qB75z2EXf7fd8qncYsWP
         O3oUalstch8fFCROn61bPjRl5H1DHNuMDPObDJCBtMfqD5QlMs8tb/5A42kHvpmq1kKP
         jr8MQyKJ76cW2Z1U/fcBJ3J1iwl5WhtEHJtEHkBmXrkgxddilC716/m/X6/bExkTd4Ac
         JV3g==
X-Gm-Message-State: APjAAAV5WTeuHS5VP0F7pRoa4JHHaLK0MjK0gyORCQcoJcen+3Etv1Vo
        TO9LrNjguqfbn0QqhYG/4zSxMqIJJ/w=
X-Google-Smtp-Source: APXvYqy9OwpfshRBnwEzf4DRMpDWh9yi53/pJqTjDnVCsZY46HDQRmUGVPGKcekhVOLLENr+XNITRbfI8MY=
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr6275215plo.17.1552070597966;
 Fri, 08 Mar 2019 10:43:17 -0800 (PST)
Date:   Fri,  8 Mar 2019 10:43:04 -0800
Message-Id: <20190308184311.144521-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v5 0/7] psi: pressure stall monitors v5
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
  https://lwn.net/ml/linux-kernel/20190206023446.177362-1-surenb%40google.com/

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

The patches are based on 5.0-rc8 (Merge tag 'drm-next-2019-03-06').

Suren Baghdasaryan (7):
  psi: introduce state_mask to represent stalled psi states
  psi: make psi_enable static
  psi: rename psi fields in preparation for psi trigger addition
  psi: split update_stats into parts
  psi: track changed states
  refactor header includes to allow kthread.h inclusion in psi_types.h
  psi: introduce psi monitor

 Documentation/accounting/psi.txt | 107 ++++++
 include/linux/kthread.h          |   3 +-
 include/linux/psi.h              |   8 +
 include/linux/psi_types.h        | 105 +++++-
 include/linux/sched.h            |   1 -
 kernel/cgroup/cgroup.c           |  71 +++-
 kernel/kthread.c                 |   1 +
 kernel/sched/psi.c               | 613 ++++++++++++++++++++++++++++---
 8 files changed, 833 insertions(+), 76 deletions(-)

Changes in v5:
- Fixed sparse: error: incompatible types in comparison expression, as per
 Andrew
- Changed psi_enable to static, as per Andrew
- Refactored headers to be able to include kthread.h into psi_types.h
without creating a circular inclusion, as per Johannes
- Split psi monitor from aggregator, used RT worker for psi monitoring to
prevent it being starved by other RT threads and memory pressure events
being delayed or lost, as per Minchan and Android Performance Team
- Fixed blockable memory allocation under rcu_read_lock inside
psi_trigger_poll by using refcounting, as per Eva Huang and Minchan
- Misc cleanup and improvements, as per Johannes

Notes:
0001-psi-introduce-state_mask-to-represent-stalled-psi-st.patch is unchanged
from the previous version and provided for completeness.

-- 
2.21.0.360.g471c308f928-goog

