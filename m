Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A600C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BF321721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO0taNum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfJHWId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:08:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46115 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:08:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so412676qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zLB6UH61hboTBGSGqJl91EXRJvTD/qzhPv92zVVjRxk=;
        b=RO0taNumliylndcto+7lvjMZPARXjWXE4KjjrLHzE8etCEvB7pUkPYTfwb8tJxrFSH
         RSF+tu0BWjDzLiEKk2syAhcM6/LOS5BiUoJV/f+VtmXp6GnY7AUgmmvIExdtgc+0lOtS
         T26ArMul1CjhydAmROYii9xdf3NZaC3y0vDouj+HEGq3H9wsYuqJhWHU3LlXES1o61q/
         mbKffbB/C7lDhXY+HKhvqGs8OYN6mPpXjBia5Ju3zxAgKGAKqb+W8S4Sm7h/TzeUUMJR
         F5hgwt3trwGzbpb4n93LgHBgwN/0iYZfVKciip6z4OfNzLqPXIBaAUC4LOYaUmMib8Ai
         1YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zLB6UH61hboTBGSGqJl91EXRJvTD/qzhPv92zVVjRxk=;
        b=UjCCAyCiuMcvAlPrdG/D/Ey8pZIBasEmfZKDDROkorCCTR9BbokwkX3GWEK5kdWspN
         6ME/XYjRXzIAcTXkkwy/VYTYEMqG5PHGACDQtDIsESrW2wwPr9nLIj1vxiovmg/MRjj3
         W+yr8FwdLA0nxI/DZ3inOI1ZTqh4bNa/VapJRezw2W0hDWGDfwRnfsI3ZLDNITwOFfF8
         1950FbnIMb8PlgFPms3rnNcij4vyR+LUC92WrJrqzA8o0xrDVpfy3zyE+bpxYTXsS1WV
         imiMFqIih0LLccibkV7/FucvVlVkmVYV0EvdF4xw6WMbmYixoFZemTCy5U5k4eX8l4M5
         YfJg==
X-Gm-Message-State: APjAAAVi9FSIbhW2dk0pj/kEVe5gKHN3DRORjEN4dFiKc8pGdvWH6lYd
        ZkGgN1QI+k+8mtKheSgOvQ==
X-Google-Smtp-Source: APXvYqwFjFPpL+OngsFhU/IFzJLehoDbYX6XaU35C+dT3mRercJxrSuxSa62IlQImLrOMQ00tEZktQ==
X-Received: by 2002:ad4:4449:: with SMTP id l9mr416095qvt.81.1570572511613;
        Tue, 08 Oct 2019 15:08:31 -0700 (PDT)
Received: from localhost.localdomain ([92.117.168.143])
        by smtp.gmail.com with ESMTPSA id m19sm42346qke.22.2019.10.08.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:08:30 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v8 0/4] Some new features for the preempt/irqsoff tracers
Date:   Wed,  9 Oct 2019 00:08:20 +0200
Message-Id: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have retained the fourth patch, although it was suggested that is becoming
obsolete soon. I have retained it only because I do not know the status of
the code that will make it obsolete. It's the last patch of the series and
if there indeed is some code that will remove the latency issues from the
printk code, then of course it makes sense to drop it. The first three patches
will work without it.

Changes in v8:

- [PATCH 1/4]:
  * Moved a forward declaration in order to make code a bit more robust.
  * Converted a macro NOP to a static function so that the type is checked.

- [PATCH 2/4]:
  * No change.

- [PATCH 3/4]:
  * No change

- [PACTH 4/4]:
  * Added a comment to explain an optimization in console_tracing_disabled().

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
 kernel/trace/trace_irqsoff.c         |   18 +
 tools/Makefile                       |   14 +-
 tools/trace/Makefile                 |   20 +
 tools/trace/latency-collector.c      | 1212 ++++++++++++++++++++++++++
 11 files changed, 1507 insertions(+), 33 deletions(-)
 create mode 100644 tools/trace/Makefile
 create mode 100644 tools/trace/latency-collector.c

-- 
2.17.1

