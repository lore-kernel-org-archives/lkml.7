Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F276723431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHuuxSNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfICN01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:26:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34153 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:26:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so17539380wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HmKS5icR2XtM6EbIPJ1Tm+uhnGjDveYu0mDP7J5zs5M=;
        b=NHuuxSNBjql75Uxyhs5UQ7ebPNnmCrojO43NCrbKqNn9pFTfsVBGUYlR4mTrzlWwNy
         axw9WtCxhIG1CcfCxHwBqJje84SsPLFmT8VidVo1QWP01h27QlcQr9u/IFLD/1V9ogm6
         mchcZVhJwWLcFSbIosgwAGYeSEcRQvr/IUjsA+052HXWNOlUPfm+RrdReBR8ARmjdSxU
         zsFuxCeTrFE8ZnDkYzu1ZifOQP3wFOVMCX5eSXz4hZUEFynPOrQntA8RfVY/14jSowBv
         Mwb3xxCHwQCtJiNAQ1OkaSdO96mb62Ke9L0fV+be0Ags2eplGep541Id+3ri5NDawdDw
         MF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HmKS5icR2XtM6EbIPJ1Tm+uhnGjDveYu0mDP7J5zs5M=;
        b=qZvTgBKUHdGj+4pK+rWaAu+P4VwmySSMKCqZpnN1Ej6IupWoKyNa91dQ1vAVu9OlgS
         fkldT8v/sIFiCdJk/AK1GQpjJItkjuD9ZmGd8qG3M41YWA6nyw+nU7S6V2entbzdmfcc
         GCsurGIgDF1t33QWYyyVIMAojM6+YgsonBfZEYvc7h/UxL0ATeO3S7uhyPRzyExYF8Gq
         XI8a4MNM+G853+xtQVdW6s3Sl5YbnszSn7fp+zPGv6OYy7aQM1mauUqLAuSitgfytubp
         55aZ5ieFKQn7oqtUgzuiKzv4V6TtSUDjrJP/sOKfFvshLoLvH/ttimeyTuVBNSA83z1P
         3sKQ==
X-Gm-Message-State: APjAAAV9XZ7tPaZ2G0eBKAiWz8hsnpE7TZxdcj2f0K+C6Xvc3MiJDIHe
        zaMAkGq/+0jFqmGyZ7SSNA==
X-Google-Smtp-Source: APXvYqzkIanIQj5e4CVmC+QaWFRjE2YizgOH8DnmHYqCoFnV18oZufWvm+JsUZxtL8No30cUTm1tZA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr14929216wrm.20.1567517184457;
        Tue, 03 Sep 2019 06:26:24 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id w9sm3906668wra.15.2019.09.03.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:26:23 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v5 0/4] Some new features for the preempt/irqsoff tracers
Date:   Tue,  3 Sep 2019 15:25:58 +0200
Message-Id: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v5:
- [PATCH 1/4]:
  * trace_disable_fsnotify() => latency_fsnotify_disable(), in order to avoid
    naming conflicts with trace points.

  * Using more appropriate operations for the percpu variables.

  * Moved around the calls to latency_fsnotify_enable/disable() a bit.

  * Added static branches to reduce overhead when the facility is not in use.

  * Does not add any trace points anymore. Instead using explicit function
    calls from sched and idle code.

  * Unfortunately still adds some gunk to sched and idle code. I do not know
    how to avoid this.

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

The last patch is not directly connected but earlier it didn't apply
cleanly on its own. However, now it does, so in principle it could be
applied separately from the others.

[PATCH 4/4] This adds the option console-latency to the trace options. This
makes it possible to enable tracing of console latencies.

best regards,

Viktor

Viktor Rosendahl (4):
  ftrace: Implement fs notification for tracing_max_latency
  preemptirq_delay_test: Add the burst feature and a sysfs trigger
  Add the latency-collector to tools
  ftrace: Add an option for tracing console latencies

 include/linux/ftrace.h               |   31 +
 include/linux/irqflags.h             |   21 +
 kernel/printk/printk.c               |    6 +-
 kernel/sched/core.c                  |    3 +
 kernel/sched/idle.c                  |    3 +
 kernel/sched/sched.h                 |    1 +
 kernel/trace/Kconfig                 |    6 +-
 kernel/trace/preemptirq_delay_test.c |  145 ++-
 kernel/trace/trace.c                 |  112 ++-
 kernel/trace/trace.h                 |   23 +
 kernel/trace/trace_hwlat.c           |    4 +-
 kernel/trace/trace_irqsoff.c         |   16 +
 kernel/trace/trace_sched_wakeup.c    |    4 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1211 ++++++++++++++++++++++++++
 16 files changed, 1587 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

