Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A481CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A1A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfCaTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 15:13:55 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:38658 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbfCaTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 15:13:54 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1hAfts-0005N4-9z; Sun, 31 Mar 2019 15:13:48 -0400
Date:   Sun, 31 Mar 2019 15:13:47 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: fs/coda oops bisected to (925b9cd1b8) "locking/rwsem: Make owner
 store task pointer of last owni
Message-ID: <20190331191347.irnmkv6ocwsq4r5r@cs.cmu.edu>
References: <20190331040023.qbx52lwzufkxg3kw@cs.cmu.edu>
 <497db260-fb1e-4b37-319f-6806df87f270@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497db260-fb1e-4b37-319f-6806df87f270@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 02:14:13PM -0400, Waiman Long wrote:
> On 03/31/2019 12:00 AM, Jan Harkes wrote:
> > On Fri, Mar 29, 2019 at 05:53:22PM +0000, Waiman Long wrote:
> >> On 03/29/2019 12:10 PM, Jan Harkes wrote:
> >>> I knew I definitely had never seen this problem with the stable kernel
> >>> on Ubuntu xenial (4.4) so I bisected between v4.4 and v5.1-rc2 and ended
> >>> up at
> >>>
> >>>     # first bad commit: [925b9cd1b89a94b7124d128c80dfc48f78a63098]
> >>>     # locking/rwsem: Make owner store task pointer of last owning reader
> >>>
> >>> When I revert this particular commit on 5.1-rc2, I am not able to
> >>> reproduce the problem anymore.
> >> Without CONFIG_DEBUG_RWSEMS, the only behavioral change of this patch is
> >> to do an unconditional write of task_structure pointer into sem->owner
> >> after acquiring the read lock in down_read(). Before this patch, it does
> >
> > I tried with just that change, but that is not at fault. It is also hard
> > to believe we have a use-after-free issue, because we are using a
> > spinlock on the inode that is held in place by the file we are releasing.
> 
> One possibility is that there is a previous reference to the memory
> currently occupied by the spinlock. If the memory location is previously
> part of a rwsem structure and someone is still using it, you may get
> memory corruption.

Ah, I hadn't even thought of that possibility. Good, it will open up
some new places to look at. Since I can open, read, write and close
files in Coda without problems and so far it only seems to be related to
closing the fd as a result of an executable process exiting.

> >     -	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
> >     -						 | RWSEM_ANONYMOUSLY_OWNED;
> >     +	unsigned long val = RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED;
>
> The change above clears all the upper bytes of owner to 0, while the
> original code will write some non-zero values to the upper bytes.

Yes, and write locks will still write to all bits of the owner field. So
the clobber must then be caused by something trying to grab a read lock
on a rw_semaphore that has been freed, and whose memory got reused by
the inode that was allocated when starting the executable. That seems
like a specific enough thing that I hopefully will be able to find it.

> > I'll continue digging if I can find a reason why. So far I've only found
> > one place where rwsem->owner is modified while not holding a lock, but
> > changing that doesn't make a difference for my particular case.
...
> The rwsem is still locked. The above code releases the current task from
> being the lock holder of the rwsem from lockdep's perspective. Later on

Ah that explains why that change made no difference. I'm unfamiliar with
the details of the locking code and assumed it was releasing some sort
of write lock there, my bad.

Jan

