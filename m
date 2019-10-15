Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD7ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6621835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtp5tFzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfJOLTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:19:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfJOLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:19:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so23375711wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LQfssd5nXxyv61l5qUfqbKthqcXNcPFHlDg2/hu8FbQ=;
        b=Jtp5tFziLnGYeCdbPmXeXUfQo7V9bjCqEwty+MkVWg2BRTEq44H74Ypif8Ocz63a8e
         w3eFfXHHnc1fdFXiOXIJuu27vMigSIuNyV4h+UnHxa+VeFAZW0p5chJqUx93JewVbibq
         ED9+86m4ofovwU6OKHuCauQeYQaA3+cCfKvhcp5dxwWutlgk1Wy/mYqwkalsnoLlMeQw
         Ew7GuNGdK9M6BPNDHUbrrF5M6RBFdYPwgVsH8yRlISJFwXQJPswSXLOrB0vhyve7nWtL
         xhWOeMLqj/nnzf6X4ihhWNWxjVG6DvyvKUCT6/shDvnFP/n9EwfstvgPfRVR0jtmCzkJ
         9DOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LQfssd5nXxyv61l5qUfqbKthqcXNcPFHlDg2/hu8FbQ=;
        b=K6TMbhemiWcz1WSue9KwiSjwKqr8Dn96Wbxv6FUHUTypBfX4MStFtgIFtJjlUx2NkB
         UeRKU0o1TZff0sBai3M0UbsusFj6QSX4JKIoo/FfQ6OAB17VlPRGjORUvmNDttxFDHgf
         UvHgodYhYiTxUdYJEytsNCKj5XoPi5AXk9hFgLQflhwcIVavuOADauQfUlvO8JWqMNb4
         EBhp6dZ1SaX7vJo1U3tjZgNfVIPHxtwR0lajQIp9uORPGDpwRw85HpKSfvUu3AFE4wje
         RbUK/wH8B9hDCOinemvvlzZsSTR3MF+6Rfv2SSaz1zlJMTzPWPu+1O6Xo4BNNmnlkHTz
         pmGA==
X-Gm-Message-State: APjAAAUtZlJVdyMvkM72/Q97Q0iVagQ5wKyjZv5svFnG9bWrytNDEv+y
        IVMpTb9yrKtJsS9B6Bc/dg==
X-Google-Smtp-Source: APXvYqxqeo8OqB9JW/d38slPgTZcyPDaWBromdACS614dT2zMzBCaXW28f1gCl2+stsHkGYA10o6fg==
X-Received: by 2002:a5d:5591:: with SMTP id i17mr16921794wrv.352.1571138353912;
        Tue, 15 Oct 2019 04:19:13 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id l9sm18487303wme.45.2019.10.15.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:19:13 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v9 0/4] Some new features for the preempt/irqsoff tracers
Date:   Tue, 15 Oct 2019 13:19:06 +0200
Message-Id: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v9:

- [PATCH 1/4]:
  * Rebased the patch for v5.4-rc3+
  * Dropped support for the hwlat tracer. It seems to me, both from testing
    and looking at the code, that hwlat doesn't actually update
    /sys/kernel/debug/tracing/tracing_max_latency. I think it would be a bit
    weird to send fsnotify for changes to a file that are not visible to
    userspace. Also, the hwlat use case is not very interesting from
    my perspective because hwlat works in non-overwrite mode by default. For me,
    the effort needed to make it work properly would be more than what it's
    worth.
  * Because of the changes mentioned above, I removed the Reviewed-by tag.

- [PATCH 2/4]:
  * No change.

- [PATCH 3/4]:
  * Removed the mention of hwlat from the commit and help messages.

- [PACTH 4/4]:
  * Changed the trace-option to a kernel parameter. This would hopefully make
    it easier to remove it if it becomes obsolete.

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

 .../admin-guide/kernel-parameters.txt         |    4 +
 include/linux/irqflags.h                      |   22 +
 kernel/printk/printk.c                        |    6 +-
 kernel/trace/Kconfig                          |    6 +-
 kernel/trace/preemptirq_delay_test.c          |  144 +-
 kernel/trace/trace.c                          |   75 +-
 kernel/trace/trace.h                          |   18 +
 kernel/trace/trace_irqsoff.c                  |   32 +
 tools/Makefile                                |   14 +-
 tools/trace/Makefile                          |   20 +
 tools/trace/latency-collector.c               | 1212 +++++++++++++++++
 11 files changed, 1521 insertions(+), 32 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

