Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDAAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E430623711
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hOsyYkkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfICQAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:00:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:48698 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:00:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BDD8A2AD035;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Gbzf7rDVwqKs; Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 726DB2AD02A;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 726DB2AD02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567526443;
        bh=gUk3pljBtH8Ogt61Qo674K1bU/UnRqImeuozcL/vWCE=;
        h=From:To:Date:Message-Id;
        b=hOsyYkkrvjTfqoU+jXzcUMNM7gJNezXOuX3FDCfwupwo4W/ItbmJygOH7SvolJ4Dg
         bGOCpmJT1PTRaCvw/TnJ3HIi3u0393lO6gt4HKiVTyBAvBjsWjn4fdl5zZELMyL9wT
         i7lNKUUITHF/KOrzir76KdCzcN36nn7Sls2CF+pv5TPhVbxXZmr8UmcYDbTGMsCFXq
         SEd4y1ig8GS/Xil0TmiOEU5A5rSF/lkSwtGY0V4+uYl1yCANFA02In77Tx8lbZFTW5
         CT1NUSlT71C4AvEwydyhBDiqY/Sob1enrYradHMQPPoJ2EsitafjmLXwLwh57fuUyP
         /1Gyi/pagf5OA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PkC6LTDp8a4V; Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 2900B2AD023;
        Tue,  3 Sep 2019 12:00:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/3] sched and membarrier probe_kernel_address fixes
Date:   Tue,  3 Sep 2019 12:00:33 -0400
Message-Id: <20190903160036.2400-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an ongoing discussion [1] about the need to fix use of
probe_kernel_address in task_rcu_deference (or provide additional
existence guarantees), and add missing READ_ONCE and
probe_kernel_address when reading other cpu runqueue's
mm->membarrier_state.

This patch set simply adds the missing probe_kernel_address checks
and use, aiming to be easily backported to stable kernels. Changing
the existence guarantees of sighand and mm objects is expected to
deprecate those changes for future kernels, but it's unclear whether
those more intrusive changes will be acceptable for stable kernel
branches.

Thanks,

Mathieu

[1] https://lore.kernel.org/r/20190902162036.GS2369@hirez.programming.kicks-ass.net

Mathieu Desnoyers (3):
  Fix: sched: task_rcu_dereference: check probe_kernel_address return
    value
  Fix: sched/membarrier: READ_ONCE p->mm in membarrier_global_expedited
  Fix: sched/membarrier: use probe_kernel_address to read
    mm->membarrier_state

 kernel/exit.c             |  3 ++-
 kernel/sched/membarrier.c | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.17.1

