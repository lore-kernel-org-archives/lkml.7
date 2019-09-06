Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D49206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kW2arRLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404360AbfIFDNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:13:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:40074 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390487AbfIFDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:13:08 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 39D6032CD6E;
        Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GC6-ubqlKqoI; Thu,  5 Sep 2019 23:13:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E32FC32CD65;
        Thu,  5 Sep 2019 23:13:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E32FC32CD65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567739586;
        bh=7wE/bXua4x37URnFRoC5IpUkqr3wkvqpnzXNrSLxCNE=;
        h=From:To:Date:Message-Id;
        b=kW2arRLEXR8wnXWDNtq3oWbwVLbNdDxyQ+xUAnABfnsfACiUMTYectkRI2zyfgvCA
         KBO0f85Lg7kayl+7HE8/Bhq5Dv0Az4kRt6pbQb9vfR3hSbxNr1EOJwHC62QLwGQGNQ
         LjthS01tj1aOEvYhI5YRfEw801bn67MvOkBhzLT0bxXUrpFUBW3jDysKrXDDYYnLBI
         3nzQQpZei9G5OqgpjeHPPPZDszsxFGnNtGbjUXxsYOJddmdKkEAWWMnbn2fbsEmhMQ
         hg8N8rMK+hKFSLLzlVIQIaoh9PJEVZTTmTh3ZFNLezq8/AAapWr2lIzR9DUaxZG7Nr
         gTQd2z/Za+4jw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 0Iar9-RX7Qmd; Thu,  5 Sep 2019 23:13:06 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 957D132CD5F;
        Thu,  5 Sep 2019 23:13:06 -0400 (EDT)
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
Subject: [RFC PATCH 0/4] Membarrier fixes/cleanups
Date:   Thu,  5 Sep 2019 23:12:56 -0400
Message-Id: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of fixes/cleanups is submitted for feedback. It takes care
of membarrier issues recently discussed.

Thanks,

Mathieu

Mathieu Desnoyers (4):
  Fix: sched/membarrier: private expedited registration check
  Cleanup: sched/membarrier: remove redundant check
  Cleanup: sched/membarrier: only sync_core before usermode for same mm
  Fix: sched/membarrier: p->mm->membarrier_state racy load

 include/linux/mm_types.h  |   7 +-
 include/linux/sched/mm.h  |   8 +--
 kernel/sched/core.c       |   1 +
 kernel/sched/membarrier.c | 141 +++++++++++++++++++++++++++-----------
 kernel/sched/sched.h      |  33 +++++++++
 5 files changed, 143 insertions(+), 47 deletions(-)

-- 
2.17.1

