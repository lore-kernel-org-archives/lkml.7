Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD76CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1AF21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vf9aQ0Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407836AbfJRPI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:08:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44892 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfJRPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:08:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so6636237wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o5W9VgYXnIgDJi4qew7wyqADtnkL+d/wfqDqzr100Ho=;
        b=vf9aQ0OuGvq/CYfNG7WSIWGmBJI01xgMwOhDQ1j8co7p+dPCD1+UolzZ8TDESSm2PO
         5zIH7xOutbcEsK+iGjbK5qWwC+nQz27V8rK7fJ0avUdEn0GZk0ezScQKzEV2L1/D9wc+
         Gb0XYwrR8dhpvoSwv9Y2ZA6/LiJ2J2UoFZrGHCKbJeryng2u6N5GEQwSchBSWnqKYl0W
         q8LiMX5e+EKuvOmN2IBF+f8hv1dn4MKpoZstGnpYf7ffJ2KZn8kjC3hP2efYNYfoeqI5
         VWVlj9gO5XY+Ko43vRHqZot4ZD2ASmOvwMeJBNajlEj1snpZ4uRImOt4RcpsumC6sUGa
         h/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o5W9VgYXnIgDJi4qew7wyqADtnkL+d/wfqDqzr100Ho=;
        b=bA49FREuxFbyDqjmqet3Ux8utGgX8W+MToE6A18v82lA6XSfjGWpiemccZMtNSTX77
         3GnDcrp3urVt8xLFLkoF6k2mK4wNWrW4vJAKbOxonPebUfXtEQSMg+z6hMo199RiUK44
         OnuP4daCIo8Zg8v19KJXDsOiYQNcMltSdjrY3W6Cx1ccir+OwkJ/qCho4PIWIIweqxGo
         fDRdYMGk7VxHi+oPPMRM5h2EdSvUyDj11wZwr3H3qMGxOpHd1fsghdsYuYnIDehUa48t
         Xh2kj8lXW0OX1kUHT6Kl08OsWUTM+gPBDra1m+1FkeL957FEKf78IB0ru3AmCt4e30Eb
         THuA==
X-Gm-Message-State: APjAAAVgdp2jC2KKc3tJ9OlEtp+clSIz1o9TcoDF3Th9cnRaZxFvb9wx
        T8hMpcStJCDjUEc92xMXLQ==
X-Google-Smtp-Source: APXvYqwpdHyKFFc1HCfbQCApCnzL/QxIeJLHKFYzCADQjgVJp3ntp7nc+uxkrP0pGILbXNBoDF39Ng==
X-Received: by 2002:adf:9f08:: with SMTP id l8mr7862221wrf.325.1571411335396;
        Fri, 18 Oct 2019 08:08:55 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id z6sm6035074wro.16.2019.10.18.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 08:08:54 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v10 0/4] Some new features for the preempt/irqsoff tracers
Date:   Fri, 18 Oct 2019 17:08:48 +0200
Message-Id: <20191018150852.4322-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Changes in v10:

- [PATCH 1/4]:
  * Changed the #if statements to not depend on CONFIG_HWLAT_TRACER
  * Changed latency_fsnotify() to a static and removed the declaration from
    kernel/trace/trace.h.

- [PATCH 2/4]:
  * No change.

- [PATCH 3/4]:
  * No change.

- [PACTH 4/4]:
  * No change.
 
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

[PATCH 4/4] This adds the option trace_console_latency=1 to the kernel
parameters. This makes it possible to enable tracing of console latencies.

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
 kernel/trace/trace.c                          |   73 +-
 kernel/trace/trace.h                          |    7 +
 kernel/trace/trace_irqsoff.c                  |   32 +
 tools/Makefile                                |   14 +-
 tools/trace/Makefile                          |   20 +
 tools/trace/latency-collector.c               | 1212 +++++++++++++++++
 11 files changed, 1508 insertions(+), 32 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

