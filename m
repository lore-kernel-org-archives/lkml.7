Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CCBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735B72089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc7sfMAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEAUg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:36:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39686 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEAUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:36:58 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so129975iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9hoKklcqwu8/e5MlWrwF49C36jdjucRoYxjO67aKqwM=;
        b=nc7sfMAbtwSdpUnNCNPkMOO+dAinjyrQPCn6qQ8tH44HtPBMueTwmlbhPupxyV8V7B
         XgDWYfBUcL27pML2BsQj1PmFtxgF0MLZMI5q/wUx4mnEatk6qjncije4IPZ6hUtNIY9i
         2yshDjDVuuBOIZdCfiuvcS0WWhRoQIFlB++voJDvXw/Al9wtH83WQSk7JnFss60QDRB8
         iadHr+KhIblcAjKHJ6wu04uZEQGe8TAFT88EtQzI4cBetWT7gYRHFj4R42aVcH9woScV
         kUUh7sZGU54d8sCCM8co3lNWS+tyxer36v/9egcIcS3dAt8apGg0RryPawAJT1fyn3F0
         W+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9hoKklcqwu8/e5MlWrwF49C36jdjucRoYxjO67aKqwM=;
        b=IoM6TSkL8AvkUUb33qJdJG67hLKOjmyux15b5AOXlPzxkHne7sjzMKdavhgcKIK8ea
         yzILMN+Tc6iVlDjsl9hTVFaQSYbHnY+0UNSSSX6pjpDOPDZtti/s43BGYKTzPqKTdCGi
         2WKNDVlbYprLf6f1YmmQas/MwPI7rqB+VlUlXq9H01lkeR0EAqp0vZGpJt+s/5vehsOw
         r2Rb0kpJQf9fUUwl3p/EeazAzBy7QqaC0RJ6A6tHfSoWIsbVct/IsfLZcnDcSnx/VZIo
         84NOlb4PH08eZ8jJP/J651VGA+E6XIwpjxJt2DU+IpNn6aT2R49P6TSvuaXsBvz/dk8X
         5c0w==
X-Gm-Message-State: APjAAAVXSx2YwSd7AZ2zMFeiMc2WO/ZCwiA06YIk+3b/Nn0pmNgBtycM
        dWEG5n+DF3rXu6WOQcIjQA==
X-Google-Smtp-Source: APXvYqx9xxULUKdpxFmB2gekWW1s4WkySrTUJZGTrNn5c2c8L/dv4NgABRQAnd6e7IWoSgcNBm8PGw==
X-Received: by 2002:a6b:9056:: with SMTP id s83mr832798iod.34.1556743017673;
        Wed, 01 May 2019 13:36:57 -0700 (PDT)
Received: from localhost.localdomain ([92.117.183.162])
        by smtp.gmail.com with ESMTPSA id u16sm9323998iol.66.2019.05.01.13.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 13:36:57 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v2 0/4] Some new features for the preempt/irqsoff tracers
Date:   Wed,  1 May 2019 22:36:46 +0200
Message-Id: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v2:
- I have tried to improve some of the commit messages by adding
  additional explanations.
- [PATCH 2/4]: We use burst size checking instead of the confusing
  modulo game. The example given in the Kconfig file is corrected and
  extended. I was not able to find a way to use the module parameters
  as trigger, so I have left the sysfs trigger file as is.


This series is meant to address two issues with the latency tracing.

The first three patches provide a method to trace latencies that
always occurs very close to each other and to differentiate between
them, in spite of the fact that the latency tracers always work in
overwrite mode.

[PATCH 1/4] This implement fs notification for preempt/irqsoff. It
makes it possible for userspace to detect when a new latency has
been detected.

[PATCH 2/4] This extends the preemptirq_delay_test module so that
it can be used to generate a burst of closely occurring latencies.

[PATCH 3/4] This adds a user space program to the tools directory
that utilizes the fs notification feature and a randomized algorithm
to print out any of the latencies in a burst with approximately equal
probability.

The last patch is not directly connected but doesn't apply cleanly on
its own:

[PATCH 4/4] This adds the option CONFIG_TRACE_CONSOLE_LATENCY to
decide whether we want to trace prints to the console or not.

best regards,

Viktor Rosendahl

Viktor Rosendahl (4):
  ftrace: Implement fs notification for preempt/irqsoff tracers
  preemptirq_delay_test: Add the burst feature and a sysfs trigger
  Add the latency-collector to tools
  ftrace: Add an option for tracing console latencies

 include/linux/irqflags.h             |   13 +
 kernel/printk/printk.c               |    5 +-
 kernel/trace/Kconfig                 |   27 +-
 kernel/trace/preemptirq_delay_test.c |  145 +++-
 kernel/trace/trace.c                 |   31 +-
 kernel/trace/trace.h                 |    5 +
 kernel/trace/trace_irqsoff.c         |   35 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1190 ++++++++++++++++++++++++++
 10 files changed, 1453 insertions(+), 32 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

