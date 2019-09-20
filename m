Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982CF2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBiMJbJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392297AbfITPW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:22:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391431AbfITPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:22:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so7177144wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M41FWwfMZykUG3UM5E046d+kFCa62CVo9tq7sqloUQo=;
        b=lBiMJbJ8SP2xPJnxD0QXmaCiaGVgc/luSB7quljeb/tNOQjbiTWde10YS5NC0o+lIo
         XACAsxAt2dHCFZpuiygDF+VG+/zdkw5c+q6DpIZSJYu2ysKszIH5a0kEgfiCRLswID87
         U1YcBsvAEpuW465UoCfxOO2zfxpI7DrHV1rnqkdpfkMUhg4hAnSqNrrkWiGt+VkC5+CD
         AM8x5EZmghdQtwIq+MV5t36Zwzi5+Iv6SxRGhJOj1QlOGJUiy9IJHDyP3NNxnRrITkMZ
         9lWgWSzcuCvKhQMr//5T+7lshh74WGoHFBj9cblwOwW3zCQ5cCzsRsto/0YGiYjBUbtw
         earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M41FWwfMZykUG3UM5E046d+kFCa62CVo9tq7sqloUQo=;
        b=QRbLev4XiDmy+gZe5thfO+J3OWpbX7t9ruE8MhnpnLF0qsqMGjN3ByNiuFhcnWyxhh
         17O72VOJRxC+94G7VGjDX1GWON9VijSzwoMyT78k3gRQaphgkRz4Qd6hIy6bkROq9PyR
         EgRFdj+Lwux8lAAfnf+D4ogCsHEtWcQpR8ADUTpOFKFdzLI6jpGUgCzQ6NEBOGbYa/O/
         x+WF8cvxGNi1NbtQ3xXNw/iSWWT2ZdjgfLTziu0QXG3RDypb8Wx3H126XFH/UiriLLtj
         RBuBT5rA+wjjR79NhEVFB5gygBqgLS0uXVC7VofWmK5TzFpSFPWxrefvMKNRysSCVXmh
         5Plw==
X-Gm-Message-State: APjAAAXB+ZlxUC3xv8+oBEEUP/ZXoT6fyo6wEU1FKGkI6mxmrs3/RKfQ
        ZCvpb3pzPPYc455DGywaPA==
X-Google-Smtp-Source: APXvYqz5PvVcL7hZ4s7uRgz13dCdRpKSUwPca8d0Rfd0sw1PnoV+1iH696zUK7TIfiul2u/BEeMZFw==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr11707893wrw.174.1568992943758;
        Fri, 20 Sep 2019 08:22:23 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id x2sm3152901wrn.81.2019.09.20.08.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:22:23 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v7 0/4] Some new features for the preempt/irqsoff tracers
Date:   Fri, 20 Sep 2019 17:22:15 +0200
Message-Id: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

There are not many changes this time. I mainly changed my email address,
tweaked a commit message and removed the cluttering of a copyright message.

Changes in v7:
- [PATCH 1/4]:
  * I have added some reasons to end of the commit message why I believe that
    it makes sense to create a new workqueue.

- [PATCH 2/4]:
  * Removed the cluttering of the copyright message.

- [PATCH 3/4]:
  * No change

- [PACTH 4/4]:
  * No change

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

Viktor Rosendahl (BMW) (4):
  ftrace: Implement fs notification for tracing_max_latency
  preemptirq_delay_test: Add the burst feature and a sysfs trigger
  Add the latency-collector to tools
  ftrace: Add an option for tracing console latencies

 include/linux/irqflags.h             |   22 +
 kernel/printk/printk.c               |    6 +-
 kernel/trace/Kconfig                 |    6 +-
 kernel/trace/preemptirq_delay_test.c |  144 ++-
 kernel/trace/trace.c                 |   75 +-
 kernel/trace/trace.h                 |   19 +
 kernel/trace/trace_hwlat.c           |    4 +-
 kernel/trace/trace_irqsoff.c         |   12 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1212 ++++++++++++++++++++++++++
 11 files changed, 1501 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

