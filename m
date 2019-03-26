Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AD12084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ3UrwKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZBkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:40:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34379 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfCZBkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:40:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so822581plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rN6an6BcrzqEETtbILhlhfnULtpHxjgScagIw1RjWdY=;
        b=DJ3UrwKErDUDYEwQ+5qW/vyHnRUkzXOLHvDGPzVZOBpZygLIwqbd6ffjlh6aWoHABr
         SgCatwXW6FHiRSwNKE0sbwH7TU8ycdGhvHmRlUhsQeSQiFxZGnxsQqrYxKydxJL99CmA
         WWD4Ip2Mr3NZzTcZnu8tFMo7HGqqUDt2t9A46QrEx+FyiWUeQuocFOifxabXjIOBckEG
         FYic90pe4dKQQKhpLD4pVM+tiG64EYAC6AnLJpsliDrVzdc5q12trM02qXy64D9M5AAU
         ayX5GQMorTeeBqNmj/G+jWQ3Kp/gBFj/RH5WwxtidrQY8lY260UZI+JS7Ng0Q2D7o+4j
         6S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rN6an6BcrzqEETtbILhlhfnULtpHxjgScagIw1RjWdY=;
        b=V64KiEhn+YZ6QTjcScytxd02xCbFrauJc8xqpz5pCg3tXP5eQHSdGYfok1t7i6BUBM
         EySisYECuoKuI8ueG3XX7gH5ddIbWkn3Vw12Co45JhogP2BfkiCvzYEyEx1lHCr5arHX
         5a+eq4blrVo2I6scxK5WBP8BmE90Pc3w+0khK90RNdCbZS5tpAMdMYkKZYJ9rE/pJNpW
         GZGhooOgQWfd66B1nEjflwER2DmYPMK2jDxwveC3RJj2IYf9jhw615c39IfMYwBVPrZ9
         qpKWkzTaeDuq/XlWjvZ5WOw35YGN6awK+4WpPY2g5Px1Jcvc6YAvmY9g9UddWAONPc81
         Jvcg==
X-Gm-Message-State: APjAAAXUB2cJ43icUPBBJXSm0rYSIUE8ue8iBQBIXT9CpGflBaf73tFT
        5BX3Huy7kJVVXK5t/WWJjbU=
X-Google-Smtp-Source: APXvYqx5FskUqOy7tN7D96FrYIbfwIVgthEV67gYTFYMNunq9B0FTyvHhpx80ESWBySNvaNfdxRmfw==
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr28726439pll.215.1553564423616;
        Mon, 25 Mar 2019 18:40:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m7sm41464119pgg.62.2019.03.25.18.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:40:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/3] tracing: introduce TRACE_EVENT_NONE and use it
Date:   Tue, 26 Mar 2019 09:40:04 +0800
Message-Id: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patchset, I introduce a new macro TRACE_EVENT_NONE(), which will
define a tracepoint as a do-nothing inline function.
	#define TRACE_EVENT_NONE(name, proto)			\
		static inline void trace_##name(proto)		\
		{ }						\
		static inline bool trace_##name##_enabled(void)	\
		{						\
			return false;				\
		}

Let's take some example for why this macro is needed.

- sched
The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
be not exposed to user if CONFIG_SCHEDSTATS is not set.
We can place #ifdef in the kernel/sched/fair.c to fix it, but we don't want
to sprinkle #ifdef.
So with TRACE_EVENT_NONE(), we can fix it in include/trace/events/sched.h.

- rcu
When CONFIG_RCU_TRACE is not set, some rcu tracepoints are define as
do-nothing macro without validating arguments, that is not proper.
We should validate the arguments.

Yafang Shao (3):
  tracing: introduce TRACE_EVENT_NONE()
  sched/fair: do not expose some tracepoints to user if
    CONFIG_SCHEDSTATS is not set
  rcu: validate arguments for rcu tracepoints

 include/linux/tracepoint.h   |  8 +++++
 include/trace/define_trace.h |  4 +++
 include/trace/events/rcu.h   | 84 ++++++++++++++++++++++++++++----------------
 include/trace/events/sched.h | 14 ++++++++
 kernel/rcu/rcu.h             |  9 ++---
 kernel/rcu/tree.c            |  8 ++---
 6 files changed, 86 insertions(+), 41 deletions(-)

-- 
1.8.3.1

