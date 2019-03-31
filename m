Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5F21726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfCaEAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 00:00:36 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:35948 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfCaEAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 00:00:36 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1hARe1-00027a-8N; Sun, 31 Mar 2019 00:00:29 -0400
Date:   Sun, 31 Mar 2019 00:00:24 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: fs/coda oops bisected to (925b9cd1b8) "locking/rwsem: Make owner
 store task pointer of last owni
Message-ID: <20190331040023.qbx52lwzufkxg3kw@cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 05:53:22PM +0000, Waiman Long wrote:
> On 03/29/2019 12:10 PM, Jan Harkes wrote:
> > I knew I definitely had never seen this problem with the stable kernel
> > on Ubuntu xenial (4.4) so I bisected between v4.4 and v5.1-rc2 and ended
> > up at
> >
> >     # first bad commit: [925b9cd1b89a94b7124d128c80dfc48f78a63098]
> >     # locking/rwsem: Make owner store task pointer of last owning reader
> >
> > When I revert this particular commit on 5.1-rc2, I am not able to
> > reproduce the problem anymore.
> 
> Without CONFIG_DEBUG_RWSEMS, the only behavioral change of this patch is
> to do an unconditional write of task_structure pointer into sem->owner
> after acquiring the read lock in down_read(). Before this patch, it does

I tried with just that change, but that is not at fault. It is also hard
to believe we have a use-after-free issue, because we are using a
spinlock on the inode that is held in place by the file we are releasing.

After trying various variations the minimal change that fixes the soft
lockup is as follows. Without this patch I get a reliable lockup, with
the patch everything works as expected.


    diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
    index bad2bca..0cc437d 100644
    --- a/kernel/locking/rwsem.h
    +++ b/kernel/locking/rwsem.h
    @@ -61,8 +61,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
     static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
                                                struct task_struct *owner)
     {
    -	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
    -						 | RWSEM_ANONYMOUSLY_OWNED;
    +	unsigned long val = RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED;
     
            WRITE_ONCE(sem->owner, (struct task_struct *)val);
     }


I'll continue digging if I can find a reason why. So far I've only found
one place where rwsem->owner is modified while not holding a lock, but
changing that doesn't make a difference for my particular case.


    diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
    index 03cb4b6f842e..fe696a8b57f3 100644
    --- a/include/linux/percpu-rwsem.h
    +++ b/include/linux/percpu-rwsem.h
    @@ -114,11 +114,11 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
     static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
                                            bool read, unsigned long ip)
     {
    -	lock_release(&sem->rw_sem.dep_map, 1, ip);
     #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
            if (!read)
                    sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
     #endif
    +	lock_release(&sem->rw_sem.dep_map, 1, ip);
     }
     
     static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,


Jan
