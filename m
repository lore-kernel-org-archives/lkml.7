Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA96C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278F22CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567608260;
	bh=d6KRgwdX/Y5jmEPyibbuMlgSXAKDThwT3pnBJ8rXseE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCLPB7rG3+UqYe3sex+Su6rAiIpaGyfhXuC4K6gHh3pMvdpdNMBvQ9oKQKWh1ub87
	 bqQ0JwlNlK1aJjYBuekfcCGelQev+llg+ypgPAykFkxTWLcrDrPOMOsxvPgN4fUjV2
	 FZkF4K/R6GxCQ2M7gNur7xoVQKAxG76MtS2Ya9Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfIDOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfIDOoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:44:19 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21DC92168B;
        Wed,  4 Sep 2019 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567608258;
        bh=d6KRgwdX/Y5jmEPyibbuMlgSXAKDThwT3pnBJ8rXseE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPBOwtNjn1vL8Bfld/X1kk/exwtpqBvmfq4JZyTeakOBU5pvEu0XVFZakh7cOh+ve
         FqcRaE04xKWc0qy2x8Za28GRyHeWxc06Vcyc1QiBHsT7Z0y5ApFlVPg1BAWDhfg3S7
         j9P3u3PFaH3gCBOVfuAArjV8JdkrSAKJ0uIQR9XY=
Date:   Wed, 4 Sep 2019 16:44:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/3] task: Add a count of task rcu users
Message-ID: <20190904144415.GB20391@lenoir>
References: <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:51:34PM -0500, Eric W. Biederman wrote:
> 
> Add a count of the number of rcu users (currently 1) of the task
> struct so that we can later add the scheduler case and get rid of the
> very subtle task_rcu_dereference, and just use rcu_dereference.
> 
> As suggested by Oleg have the count overlap rcu_head so that no
> additional space in task_struct is required.
> 
> Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
> Inspired-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched.h      | 5 ++++-
>  include/linux/sched/task.h | 1 +
>  kernel/exit.c              | 7 ++++++-
>  kernel/fork.c              | 7 +++----
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9f51932bd543..99a4518b9b17 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1142,7 +1142,10 @@ struct task_struct {
>  
>  	struct tlbflush_unmap_batch	tlb_ubc;
>  
> -	struct rcu_head			rcu;
> +	union {
> +		refcount_t		rcu_users;
> +		struct rcu_head		rcu;

So what happens if, say:


           CPU 1                         CPU 2
   --------------------------------------------------------------
   rcu_read_lock()
   p = rcu_dereference(rq->task)
   if (refcount_inc_not_zero(p->rcu_users)) {
       .....
                                         release_task() {
                                             put_task_struct_rcu_user() {
                                                 call_rcu() {
                                                     queue rcu_head
                                                 }
                                             }
                                         }
       put_task_struct_rcu_user(); //here rcu_users has been overwritten


Thanks.
