Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67693C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4997722D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfICNGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfICNGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52040305D637;
        Tue,  3 Sep 2019 13:06:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35A6360126;
        Tue,  3 Sep 2019 13:06:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Sep 2019 15:06:10 +0200 (CEST)
Date:   Tue, 3 Sep 2019 15:06:06 +0200
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
Subject: Re: [PATCH 3/3] task: Clean house now that tasks on the runqueue are
 rcu protected
Message-ID: <20190903130606.GA17626@redhat.com>
References: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <8736het20c.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736het20c.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 03 Sep 2019 13:06:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02, Eric W. Biederman wrote:
>
> @@ -1644,7 +1644,7 @@ static void task_numa_compare(struct task_numa_env *env,
>  		return;
>  
>  	rcu_read_lock();
> -	cur = task_rcu_dereference(&dst_rq->curr);
> +	cur = rcu_dereference(dst_rq->curr);
>  	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
>  		cur = NULL;

afaics rq->curr can't be NULL, so you can also simplify the "if" check

	cur = task_rcu_dereference(&dst_rq->curr);
	if ((cur->flags & PF_EXITING) || is_idle_task(cur))
		cur = NULL;

Same for membarrier_global_expedited/membarrier_private_expedited changed
by this patch.

Oleg.

