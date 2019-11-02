Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD2ECA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40F21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKBMrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:47:23 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42056 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfKBMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th-p51w_1572698837;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-p51w_1572698837)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:17 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 0/7] rcu: introduce percpu rcu_preempt_depth
Date:   Sat,  2 Nov 2019 12:45:52 +0000
Message-Id: <20191102124559.1135-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
Reply-To: <20191101162109.GN20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than using the generic version of preempt_count, x86 uses
a special version of preempt_count implementation that take advantage
of x86 (single instruction to access/add/decl/flip-bits of percpu
counter). It makes the preempt_count operations really cheap.

For x86, rcu_preempt_depth can also take the same advantage by
using the same technique.

After the patchset:
 - No function call when using rcu_read_[un]lock().
     It is minor improvement, other arch can also achieve it via
     moving ->rcu_read_lock_nesting and ->rcu_read_unlock_special
     to thread_info, but inlined rcu_read_[un]lock() generates
     more instructions and footprint in other arch generally.
 - Only single instruction for rcu_read_lock().
 - Only 2 instructions for the fast path of rcu_read_unlock().

Patch4 simplifies rcu_read_unlock() by avoid using negative
->rcu_read_lock_nesting, Patch7 introduces the percpu rcu_preempt_depth.
Other patches are for preparation.

changed from v1:
  drop patch1/2 of the v1
  drop merged patches

  Using special.b.deferred_qs to avoid wakeup in v1 is changed to using
  preempt_count. And special.b.deferred_qs is removed.

Lai Jiangshan (7):
  rcu: use preempt_count to test whether scheduler locks is held
  rcu: cleanup rcu_preempt_deferred_qs()
  rcu: remove useless special.b.deferred_qs
  rcu: don't use negative ->rcu_read_lock_nesting
  rcu: wrap usages of rcu_read_lock_nesting
  rcu: clear the special.b.need_qs in rcu_note_context_switch()
  x86,rcu: use percpu rcu_preempt_depth

 arch/x86/Kconfig                         |   2 +
 arch/x86/include/asm/rcu_preempt_depth.h |  87 +++++++++++++++++++
 arch/x86/kernel/cpu/common.c             |   7 ++
 arch/x86/kernel/process_32.c             |   2 +
 arch/x86/kernel/process_64.c             |   2 +
 include/linux/rcupdate.h                 |  24 ++++++
 include/linux/sched.h                    |   2 +-
 init/init_task.c                         |   2 +-
 kernel/fork.c                            |   2 +-
 kernel/rcu/Kconfig                       |   3 +
 kernel/rcu/tree_exp.h                    |  35 ++------
 kernel/rcu/tree_plugin.h                 | 101 ++++++++++++++---------
 12 files changed, 196 insertions(+), 73 deletions(-)
 create mode 100644 arch/x86/include/asm/rcu_preempt_depth.h

-- 
2.20.1

