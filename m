Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83CC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD83233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfICN6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:58:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfICN6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:58:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1216B307CDFC;
        Tue,  3 Sep 2019 13:58:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id EBBDA1001B05;
        Tue,  3 Sep 2019 13:58:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Sep 2019 15:58:35 +0200 (CEST)
Date:   Tue, 3 Sep 2019 15:58:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 0/3] task: Making tasks on the runqueue rcu protected
Message-ID: <20190903135830.GB17626@redhat.com>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 03 Sep 2019 13:58:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02, Eric W. Biederman wrote:
>
> Oleg do you have any issues with this code?

OK, let it be refcount_t, I agree it looks more readable.

> Eric W. Biederman (3):
>       task: Add a count of task rcu users
>       task: RCU protect tasks on the runqueue
>       task: Clean house now that tasks on the runqueue are rcu protected
> 
>  include/linux/rcuwait.h    | 20 +++----------
>  include/linux/sched.h      |  5 +++-
>  include/linux/sched/task.h |  2 +-
>  kernel/exit.c              | 74 ++++------------------------------------------
>  kernel/fork.c              |  8 +++--
>  kernel/sched/core.c        |  7 +++--
>  kernel/sched/fair.c        |  2 +-
>  kernel/sched/membarrier.c  |  4 +--
>  8 files changed, 27 insertions(+), 95 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

