Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E252087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edhO8K4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEQUei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:34:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42613 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfEQUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:34:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id j53so9521728qta.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RbAOSk8QxR8pxMSSXPbl0/7Hv6ZMJZsH4C4gzrbPVXg=;
        b=edhO8K4Cnt/bF/BJMP1DFGm/5VM2bDJXF7LvFdaUAWXJbc/tROILr+8hinTr91esi8
         mg/hpeAUtdKQTg2dywpC1hUw7wsz+zn06CNqqgBIuOywq93RQPh1CRnCNxZT/ybvPGBM
         WY365EuQJEd5jYwZA8h5KGD5PQfxMiAC7bY4f9BJnl7i7yoTuGRBRWpX6rLgpUwWWT42
         00qFlfFvaCNGjHze7NXxI86Elsa4Xc3s5ng66w1zjLEDFB5XY3Ybuci2pUnAcT4L9z2L
         zvI8f9GSaX7XtH1oJi+XJ/Xba9X63ymtEspl7YrpZPbwilibvTFm2eBQy1k/gXFiSkq7
         nx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RbAOSk8QxR8pxMSSXPbl0/7Hv6ZMJZsH4C4gzrbPVXg=;
        b=mG1uDZ0seoP0MfLj7Y8aH5MKEOvl5LpWMzs6P4UrVeqgtL4WGgHVUwFbfYas6WUZAe
         z2E/AJ/+eingMHxw1hbg7WdEAC1KIiST9LCkoaOZKQ/sGIQ6OVqsLrNK/+/Ly4Ltwh+U
         0eAc7Caq/v8Y2JhiilOZSOODTvHmhypSse2Hk9tzw1dnWu3+eP4gorcEGhQ6aG7JF6Yx
         xQzgTm6AqrBKoNGTYlogoEjlcOAPSFqWbB0rHfR3ZMWJwWHhZjgF6xxebHA8wohH2BmB
         zDTA2hLNZZVCCu7aiDI9wkM+UitHujhvt3hXKAB3bWjUuCFF032fP75He8Bvqia6pxsF
         utGA==
X-Gm-Message-State: APjAAAUBcFTEwi9JDjQ7Acevqxsd1c31KEqhcIIEdx0CpQuBtTEtMr06
        dXfq6TzYi1U0CdRUBl4A/w==
X-Google-Smtp-Source: APXvYqy2M0jlxliLATGgVjWH4P9MYuaDZU4a3gCEqnRNwtY36ESB0RRWnMfMLaFQsRNuE2ZDqI/YVA==
X-Received: by 2002:aed:3501:: with SMTP id a1mr50458608qte.265.1558125276742;
        Fri, 17 May 2019 13:34:36 -0700 (PDT)
Received: from localhost.localdomain ([92.117.189.151])
        by smtp.gmail.com with ESMTPSA id u5sm5499145qtj.95.2019.05.17.13.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 13:34:36 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v4 0/4] Some new features for the latency tracers
Date:   Fri, 17 May 2019 22:34:26 +0200
Message-Id: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v4:

- [PATCH 1/4]:
  * Improved support for multiple active trace instances by storing entries
    that cannot be notified immediately in a linked list instead of a
    single pointer. With multiple instances this could happen.

  * Register trace_maxlat_fsnotify_init() with late_initcall_sync().
    Previously it was piggy backed on tracer_init_tracefs() and it got
    called more than once.

  * Added some comments.

- [PATCH 3/4]:
  * Some of the code was incorrectly added in the next patch. Improved
    commit message.

- [PATCH 4/4]:
  * Some code from the previous patch was incorrectly included here.


This series is meant to address two issues with the latency tracing.

The first three patches provide a method to trace latencies that always
occurs very close to each other and to differentiate between them, in spite
of the fact that the latency tracers work in overwrite mode.

[PATCH 1/4] This implement fs notification for tracing_max_latency. It
makes it possible for userspace to detect when a new latency has been
detected.

[PATCH 2/4] This extends the preemptirq_delay_test module so that it can be
used to generate a burst of closely occurring latencies.

[PATCH 3/4] This adds a user space program to the tools directory that
utilizes the fs notification feature and a randomized algorithm to print out
any of the latencies in a burst with approximately equal probability.

The last patch is not directly connected but doesn't apply cleanly on
its own:

[PATCH 4/4] This adds the option console-latency to the trace options. This
makes it possible to enable tracing of console latencies.

best regards,

Viktor

Viktor Rosendahl (4):
  ftrace: Implement fs notification for tracing_max_latency
  preemptirq_delay_test: Add the burst feature and a sysfs trigger
  Add the latency-collector to tools
  ftrace: Add an option for tracing console latencies

 include/linux/irqflags.h             |   21 +
 include/trace/events/power.h         |   40 +
 include/trace/events/sched.h         |   40 +
 kernel/printk/printk.c               |    6 +-
 kernel/sched/core.c                  |    2 +
 kernel/sched/idle.c                  |    2 +
 kernel/trace/Kconfig                 |    6 +-
 kernel/trace/preemptirq_delay_test.c |  145 ++-
 kernel/trace/trace.c                 |  168 +++-
 kernel/trace/trace.h                 |   13 +
 kernel/trace/trace_hwlat.c           |    4 +-
 kernel/trace/trace_irqsoff.c         |   12 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1211 ++++++++++++++++++++++++++
 15 files changed, 1671 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

