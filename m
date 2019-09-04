Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BBA2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rixIuGRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbfIDQNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:13:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:42534 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733110AbfIDQLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:11:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3B2232A7BDB;
        Wed,  4 Sep 2019 12:11:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id WrxUKyOHNboE; Wed,  4 Sep 2019 12:11:18 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B92512A7BD6;
        Wed,  4 Sep 2019 12:11:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B92512A7BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567613478;
        bh=UvCTGqUCf4urIjnb3JtMZ9hbarJ4G87XaD/J1JfL2Sk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rixIuGRs3W8jXvPj13DrndaJXHwzFAXleVU6uHQ7aEkcBXVsSui0yny6uR/JL9o5i
         XTT17NiofQOSaweia9Arc7eYXjqJgK6Ln79A0hJNTwT0kJQI4TQFcGmiF5IYHc/xjq
         bekFPTzEbTz/H3uVi9odF/6UvG0ikUnj48ZYo+pWNzMgSjKdskh3xzfe6TSMKoGDxN
         NFGWe3ok1JD00qZ4jbh6CQ9sxKU/I4cZFtKHJszfkOKOAy652Y3WoPXQec2fZqt7Uj
         Ex6SnUMIIGG8O1Y009s37H7zG9J35F1dlQwzu6MAEMYzbsKmKHc+nL2qb0O0iTykGd
         f29PGkg3up6vQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id R42Tsp5JXwDz; Wed,  4 Sep 2019 12:11:18 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9E1712A7BBC;
        Wed,  4 Sep 2019 12:11:18 -0400 (EDT)
Date:   Wed, 4 Sep 2019 12:11:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1457548021.1684.1567613478460.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904111126.GB24568@redhat.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190904111126.GB24568@redhat.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: hfEVYLcRG2Y34JmTkaLiqVjU31tDtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 7:11 AM, Oleg Nesterov oleg@redhat.com wrote:

> with or without these changes...
> 
> Why do membarrier_register_*_expedited() check get_nr_threads() == 1?
> This makes no sense to me, atomic_read(mm_users) == 1 should be enough.

Indeed, if every thread within a process hold a mm_users refcount, then
the get_nr_threads() == 1 check becomes redundant.

AFAIR, this check started out as "get_nr_threads() == 1", and then I changed
the code to also cover the multi-process CLONE_VM use-case by adding the
additional check.

> And I am not sure I understand membarrier_mm_sync_core_before_usermode().
> OK, membarrier_private_expedited() can race with user -> kernel -> user
> transition, but we do not care unless both user's above have the same mm?
> Shouldn't membarrier_mm_sync_core_before_usermode() do
> 
>	if (current->mm != mm)
>		return;
> 
> at the start to make it more clear and avoid sync_core_before_usermode()
> if possible?

Indeed, if we have taskA -> kernel -> taskB, it implies that we go through
switch_mm() when scheduling taskB, which provides the required core serializing
guarantees.

Moreover, if we look closely at the call to membarrier_mm_sync_core_before_usermode(),
the mm it receives as parameter is the rq->prev_mm. So using the prev_mm membarrier
state to decide whether we need to issue a sync_core before returning to a
different next mm is not really relevant unless the next mm == rq->prev_mm.

Nothing there seem to be actively buggy, but those are indeed nice cleanups.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
