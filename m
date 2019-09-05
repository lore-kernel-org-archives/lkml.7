Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B570C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB6C206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8U6mjQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbfIENZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:25:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35539 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfIENZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:25:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so3055713wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sVzpyvy1k5HtW5ekEgMhgd/SyXFZp1iLl9DCyajTt40=;
        b=c8U6mjQcwgB44VBX4TPpCGVrMc4MVRiJPyZnu3TsCCz3pgaL4eD5qen4ktixjDgbjg
         luZPXFPR0nR6T6zfLaL3QouFmB1whJGV8d5AJ4v8JLJRzwlnNzPepZ80jRxitrfTQgiY
         SkwFjoIzizymIMtkJf5ubEpGHaeKBpdrPRtFdYqUQwKvLlWyo0+CsaJWmmOxuiK/3uVe
         AvFa9QnciSut/zIOYrd3gP1KBzQm6A+PgLX5bi2O88uaooZ9skU+rwmAhdQ9XZcdxku+
         URoT9IZ8VN84SaX9sGVyBSe41UfYZNCNYlsiyszxzwZJIPE23RQNE8B/immPRA/L3Kxp
         xcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sVzpyvy1k5HtW5ekEgMhgd/SyXFZp1iLl9DCyajTt40=;
        b=JPXfDkJhgJ5vri9N0FMhXbwgcEDb38tiXSOx9QdhFbZ7w3MMJre44yhJqrQZg1MYt5
         qsS+F9kvVvhqJ5eJkia258c70Pn5IVAR9nKOOWW7RFjwhxVKzI/AME8X6QShYu4VyWV5
         t5ljLijukehwuGSmp9wNfggKPEzE8Yc7S0J2CF+vsGW8X/dyVcd8KtXSBaLXYCwoipwN
         klL2DYoQ/ieL+huyQLuPUQ4mODA/Bww2cX5kQsi7utOqrD4QGLXxeAdy3Xx+b2gh0t1F
         uqJrLo2p6Nu9b1rkKhuso1qAnSof0gZtYu9xnMnDumsZNg6AfMtF9wmhY16t0BrdSQnP
         AmFw==
X-Gm-Message-State: APjAAAUkgntoeebDt1Je4uXvuimGryDXHRUckwwx3WWw6Bq1cioqv5Hp
        jHD6SfV92j/hg6wxJZAPzw==
X-Google-Smtp-Source: APXvYqyXQd9iIM5rGSl6VgmSMenLKGcFUKAs5sXXEhjYjsExpnY4VtdvVdh6q5hI4m6OKzAuuY1qEg==
X-Received: by 2002:a1c:3904:: with SMTP id g4mr3177816wma.116.1567689952147;
        Thu, 05 Sep 2019 06:25:52 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id y3sm8652635wmg.2.2019.09.05.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:25:51 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v6 0/4] Some new features for the preempt/irqsoff tracers
Date:   Thu,  5 Sep 2019 15:25:44 +0200
Message-Id: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v5:
- [PATCH 1/4]:
  * Using the irq_work mechanism instead of the games with linked lists, percpu
    variables and modifications to the scheduling and idle code.

- [PATCH 2/4]:
  * Updated the copyright message, adding my own name and what I did.

- [PATCH 3/4]:
  * Added my own name as author to the copyright message.

- [PACTH 4/4]:
  * Improved the build on sh architecture with gcc 7.4.0 by including
    linux/types.h. The build on sh architecture still fails for me later in the
    build process with an ICE error from the compiler but the same failure also
    happens without any of my patches.

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

 include/linux/irqflags.h             |   22 +
 kernel/printk/printk.c               |    6 +-
 kernel/trace/Kconfig                 |    6 +-
 kernel/trace/preemptirq_delay_test.c |  147 +++-
 kernel/trace/trace.c                 |   75 +-
 kernel/trace/trace.h                 |   19 +
 kernel/trace/trace_hwlat.c           |    4 +-
 kernel/trace/trace_irqsoff.c         |   12 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1212 ++++++++++++++++++++++++++
 11 files changed, 1504 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

