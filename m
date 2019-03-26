Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1E2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT3b9mNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZMNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:13:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41599 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZMNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:13:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so2540233pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZM4LeWXagDRpn4M/V2GVbYkaDTDMCPoOWYr2RZh5CsI=;
        b=OT3b9mNPXzlYofSBA6jIMFYWAfnmUJ0JmiUdyf1DS4lq40J2pb55BaNpWETU2F4Cqf
         jTSBXDDTzetchWoiFHjuHMGw0RatrYFRQpu0PQVjJKSpxuqA1ZMH+et3DADne9z3ohRk
         iYlOwIXHzw6Yz/sB/YxmNAyFWkAxPH3H+/zrooxiYdFPeqb9wdhlMjES/WL5cPLKXLeQ
         T/GOI70cOlrO/rQCv9GXQZC54mcrdZHTUZKtqzJgMhrTVeJhmf6T4H2RSwqNLnCItiNn
         UJl5C6R2nwoWLDR+0KiNzI705s+Ur8pZMGB+AFuOR71onM8hlVxxE5Av9h3RNu5yoNqW
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZM4LeWXagDRpn4M/V2GVbYkaDTDMCPoOWYr2RZh5CsI=;
        b=CVWuO5t8fTCdoTBytODxR7dVcVpIxfv8tVZl7hzyWg3FumkaYn6gJq9yrWHAtwyVEF
         s9csqkx1U1A1hgzf/IcX/d38S2YFTx07M8c4pVRgM5jw48Q6QGrLNV9Al8PI2FGKvlU/
         bGG8dFzlMs6mCyuQzfDMIKqlPPm1YTCHHvJriiDmgaWYaVS8cuPUR5zFaZs7oFk/49bW
         BRKS3J4fkPXkVWL98Xc3qwp5h2FTmqf8YPZ/HE7pzZWBn8Bx7k21j1/AzYxGVmyEmxRF
         k6uF8K6x+W5mR89B2tL8YGPi4VFnevR3LO20RWvlXljFs1CjXKVhYO/1CCII3j24nEeR
         /Wwg==
X-Gm-Message-State: APjAAAWB/MiL3qCmYMGRnNOptExH0+0eq7mGLqxqcjRdi1HiNLJnJKoq
        KzfkaD9HYM135OIhN8pMSjA=
X-Google-Smtp-Source: APXvYqyLkK5eDRdNpk+j+cE4wGpZb6ednOG9fKnt97Bo9hxdwmnIVaEbvfiNEkjrewW6Wll1JneyrA==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr28569320pgr.449.1553602422358;
        Tue, 26 Mar 2019 05:13:42 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e2sm31263881pfa.64.2019.03.26.05.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:13:41 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/3] tracing: introduce TRACE_EVENT_NOP and use it
Date:   Tue, 26 Mar 2019 20:13:08 +0800
Message-Id: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patchset, I introduce some new macros TRACE_EVENT_NOP,
DEFINE_EVENT_NOP and DECLARE_EVENT_CLASS_NOP, which will
define a tracepoint as do-nothing inline function.
	#define DECLARE_EVENT_NOP(name, proto)			\
		static inline void trace_##name(proto)		\
		{ }						\
		static inline bool trace_##name##_enabled(void)	\
		{						\
			return false;				\
		}

Let's take some examples for why these macros are needed.

- sched
The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
be not exposed to user if CONFIG_SCHEDSTATS is not set.

- rcu
When CONFIG_RCU_TRACE is not set, some rcu tracepoints are defined as
do-nothing macro without validating arguments, that is not proper.
We should validate the arguments.

Yafang Shao (3):
  tracing: introduce TRACE_EVENT_NOP()
  sched/fair: do not expose some tracepoints to user if
    CONFIG_SCHEDSTATS is not set
  rcu: validate arguments for rcu tracepoints

 include/linux/tracepoint.h   | 15 ++++++++
 include/trace/define_trace.h |  8 +++++
 include/trace/events/rcu.h   | 81 ++++++++++++++------------------------------
 include/trace/events/sched.h | 21 ++++++++----
 kernel/rcu/rcu.h             |  9 ++---
 kernel/rcu/tree.c            |  8 ++---
 6 files changed, 68 insertions(+), 74 deletions(-)

-- 
1.8.3.1

