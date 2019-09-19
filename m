Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D551C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B3B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MneGUpLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbfISRic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:38:32 -0400
Received: from mail.efficios.com ([167.114.142.138]:33568 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390836AbfISRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:38:32 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CAB9B331857;
        Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mrezv5ym_4UR; Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 86A9933184D;
        Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 86A9933184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568914710;
        bh=KnKcXKEkIMkqdp4HXN5cX4LEdLVW1MHR4ztVUhXXKkA=;
        h=From:To:Date:Message-Id;
        b=MneGUpLNTfCJ556IsihLNzENaQ99pLyNUxOeW+9Ul2k+5gPZFCJuImYokA/hEZW2i
         mgBtBCDDqabRWTe1Kj1S4gtrrPjV2dcECEPMZwKpAQowVT/CgmjH+musRkDQTmaHL2
         Nqgxg31W3mUcZ3ELkV1oe8bPAfbeJvzAR8+uzv+e9IXWjCFcpsjb/e6qTFSIcVz+e5
         dsHjKqJUFzFkdjyEYkl4Z2ZKev1oZN3l+Z6iEL/aYtmtNGCiq+9n6mdBHxjf+XAE14
         4X5BboxOYXlHiPqY0vKEHhUEknI5twYgjKJ/IlOanc/Dfzw3mgmkpzcDiuA2x5ANID
         8Fiyf9gpn9IvA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id qI43mt25MZMR; Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 3CF38331847;
        Thu, 19 Sep 2019 13:38:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 5.4 0/7] Membarrier fixes and cleanups
Date:   Thu, 19 Sep 2019 13:36:58 -0400
Message-Id: <20190919173705.2181-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Those series of fixes and cleanups are initially motivated by the report
of race in membarrier, which can load p->mm->membarrier_state after mm
has been freed (use-after-free).

Thanks,

Mathieu

Mathieu Desnoyers (7):
  Fix: sched/membarrier: Private expedited registration check
  Cleanup: sched/membarrier: Remove redundant check
  Cleanup: sched/membarrier: Only sync_core before usermode for same mm
  Fix: sched/membarrier: p->mm->membarrier_state racy load (v4)
  selftests: sched/membarrier: Add multi-threaded test
  sched/membarrier: Skip IPIs when mm->mm_users == 1
  sched/membarrier: Return -ENOMEM to userspace on memory allocation
    failure

 fs/exec.c                                     |   2 +-
 include/linux/mm_types.h                      |  14 +-
 include/linux/sched/mm.h                      |  10 +-
 kernel/sched/core.c                           |   4 +-
 kernel/sched/membarrier.c                     | 236 +++++++++++-------
 kernel/sched/sched.h                          |  34 +++
 tools/testing/selftests/membarrier/.gitignore |   3 +-
 tools/testing/selftests/membarrier/Makefile   |   5 +-
 ...mbarrier_test.c => membarrier_test_impl.h} |  40 +--
 .../membarrier/membarrier_test_multi_thread.c |  73 ++++++
 .../membarrier_test_single_thread.c           |  24 ++
 11 files changed, 329 insertions(+), 116 deletions(-)
 rename tools/testing/selftests/membarrier/{membarrier_test.c => membarrier_test_impl.h} (95%)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_single_thread.c

-- 
2.17.1

