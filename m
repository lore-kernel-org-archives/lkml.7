Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85430C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EE92084F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2PI4uQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEMVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:50:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46238 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEMVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:50:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so19637203edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hov/pCeC1dnaeog3UO9V4+XwoPV+/3/2gv4pYq+t7W8=;
        b=j2PI4uQZAUXecuffmlcE1djUzaj9k8/4wV+sYCML2smEZm3KqEQc44/gjJ0iKsMkbu
         P9Uo9dA5qrag/GpYyxI+dU/ULJ8xJkWrw8XnvdL7outoIrgEXgST3LT/iuxxEEZXU+Ar
         C5S+toPXxlJijMjKAG3XCYgQ5w7va+uwfF+zlszaLFPaGK3Q2PFDRvyDZH9u003aUinZ
         4k6qtiJIdETNzWiJe77pLFXuo9RYd6IH+FU3+3mPFLIYTXSZ/tEoiZlux05qtrBpcloo
         1dY00x1apOcLxX12Hg3ALrlXKtR0hB//ciic6ddGpYfIOTyH2w1ILtWHRayFIVREFueu
         vKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hov/pCeC1dnaeog3UO9V4+XwoPV+/3/2gv4pYq+t7W8=;
        b=s6tCin8CZUVQ1L5FfVCZsIuP5VLLrMKiOsXi41oNAZZNv706tCDJTFeqNuUelDjYOe
         y3VTeogzKvpc+jG1WwERqkvd3jWQm7AMp5ogV0B8gpbMl7uUh+pDSlHcgeBKlObXnNML
         /1FAGpLWtTQBK5410/t27yorzjR7IHCK0hYYNMxfarEXKSgDFBMq3WeiXtuiVYGCmoyq
         +ivwpfYeSqEHu2PZTEJlT5uolwQIHv84ugK08+dyd8z0wkL4Ez9dqMUP4Kme8ukWDNU9
         2oBHQhkq+50UJh7K23LoZBSw0k917bQ0GDpiopc9oz+iZrt44yMfPGcJ+TQiRkjLbOce
         KY6w==
X-Gm-Message-State: APjAAAWGapGQxywJWslFdyyx213kpGIXD9Artz0AHDKwhzzmLKGe0Tfx
        NnC34Ih+hRS4/+IUnB7fvQ==
X-Google-Smtp-Source: APXvYqznyyRJRTdn7aFIn/mMiVK4MlSISgsmNaZy/nOXY2KoMIcMdHAEYsRz9OtZKf3hLkyCA2jYvg==
X-Received: by 2002:a50:a941:: with SMTP id m1mr31956525edc.157.1557784212192;
        Mon, 13 May 2019 14:50:12 -0700 (PDT)
Received: from localhost.localdomain ([92.117.184.230])
        by smtp.gmail.com with ESMTPSA id g11sm4040891eda.42.2019.05.13.14.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:50:11 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v3 0/4] Some new features for the latency tracers
Date:   Mon, 13 May 2019 23:50:04 +0200
Message-Id: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v3:
- [PATCH 1/4]: 
  * I have generalized this to send the fsnotify() notifications for all
    tracers that use tracing_max_latency.

  * There are large additions of code to prevent queue_work() from being
    called while we are in __schedule() or do_idle(). This was a bug also
    in the previous version but had gone unnoticed. It became very visible
    when I tried to make it work with the wakeup tracers because they are
    always invoked from the sched_switch tracepoint.

  * The fsnotify notification is issued for tracing_max_latency, not trace.

  * I got rid of the kernel config option. The facility is always compiled
    when CONFIG_FSNOTIFY is enabled and any of the latency tracers are
    enabled.

- [PATCH 2/4]:
  * No significant changes.

- [PATCH 3/4]:
  * The latency-collector help messages have been tuned to the fact that it
    can be used also with wakeup and hwlat tracers.

  * I increased the size of the buffer for reading from
    /sys/kernel/debug/tracing/trace.

  * Adapted it to monitor tracing_max_latency instead of trace

- [PATCH 4/4]:
  * I converted this from a kernel config option to a trace config option
    that can be changed at runtime.


This series is meant to address two issues with the latency tracing.

The first three patches provide a method to trace latencies that always
occurs very close to each other and to differentiate between them, in spite
of the fact that the latency tracers always work in overwrite mode.

[PATCH 1/4] This implement fs notification for preempt/irqsoff. It makes it
possible for userspace to detect when a new latency has been detected.

[PATCH 2/4] This extends the preemptirq_delay_test module so that it can be
used to generate a burst of closely occurring latencies.

[PATCH 3/4] This adds a user space program to the tools directory that
utilizes the fs notification feature and a randomized algorithm to print out
any of the latencies in a burst with approximately equal probability.

The last patch is not directly connected but doesn't apply cleanly on
its own:

[PATCH 4/4] This adds the option console-latency to the trace options.

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
 kernel/trace/trace.c                 |  160 +++-
 kernel/trace/trace.h                 |   11 +
 kernel/trace/trace_hwlat.c           |    4 +-
 kernel/trace/trace_irqsoff.c         |   12 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1211 ++++++++++++++++++++++++++
 15 files changed, 1661 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

