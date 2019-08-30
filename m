Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A642DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789EF2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH3Qol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3Qol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:44:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 817D7898102;
        Fri, 30 Aug 2019 16:44:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0AFD861F22;
        Fri, 30 Aug 2019 16:44:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 30 Aug 2019 18:44:40 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:44:37 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190830164436.GD2634@redhat.com>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 30 Aug 2019 16:44:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Linus Torvalds wrote:
>
> But yes, your hack is I guess optimal for this particular case where
> you simply can depend on "we know the pointer was valid, we just don't
> know if it was freed".
>
> Hmm. Don't we RCU-free the task struct? Because then we don't even
> need to care about CONFIG_DEBUG_PAGEALLOC. We can just always access
> the pointer as long as we have the RCU read lock.

For example,

	rcu_read_lock();
	p = task_rcu_dereference(&cpu_rq(cpu)->curr);
	rcu_read_unlock();

->curr is not protected by RCU, the last schedule does put_task_struct()
in finish_task_switch().

Of course we can change this and add another call_rcu (actually we can do
better), and after that we do not need task_rcu_dereference() at all.

Oleg.

