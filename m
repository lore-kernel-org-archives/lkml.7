Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3038C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6406720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406486AbfFLHaI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:30:08 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:44788 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfFLHaH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Wed, 12 Jun 2019 03:30:07 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 12 Jun 2019 01:30:06 -0600
Message-Id: <5D00A9F7020000F90006BBB4@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 12 Jun 2019 01:29:59 -0600
From:   "Gang He" <ghe@suse.com>
To:     <jlbec@evilplan.org>, <mark@fasheh.com>,
        "Joseph Qi" <joseph.qi@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <ocfs2-devel@oss.oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 3/3] ocfs2: add first lock wait time in
 locking_state
References: <20190611015414.27754-1-ghe@suse.com>
 <20190611015414.27754-3-ghe@suse.com>
 <fe52ae81-2140-9f68-8ec2-cc7c1fb3bc1a@linux.alibaba.com>
In-Reply-To: <fe52ae81-2140-9f68-8ec2-cc7c1fb3bc1a@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joseph,

>>> On 6/12/2019 at  3:03 pm, in message
<fe52ae81-2140-9f68-8ec2-cc7c1fb3bc1a@linux.alibaba.com>, Joseph Qi
<joseph.qi@linux.alibaba.com> wrote:
> Hi Gang,
> 
> On 19/6/11 09:54, Gang He wrote:
>> ocfs2 file system uses locking_state file under debugfs to dump
>> each ocfs2 file system's dlm lock resources, but the users ever
>> encountered some hang(deadlock) problems in ocfs2 file system.
>> I'd like to add first lock wait time in locking_state file, which
>> can help the upper scripts detect these deadlock problems via
>> comparing the first lock wait time with the current time.
>> 
>> Signed-off-by: Gang He <ghe@suse.com>
>> ---
>>  fs/ocfs2/dlmglue.c | 32 +++++++++++++++++++++++++++++---
>>  fs/ocfs2/ocfs2.h   |  1 +
>>  2 files changed, 30 insertions(+), 3 deletions(-)
>> 
>> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
>> index d4caa6d117c6..8ce4b76f81ee 100644
>> --- a/fs/ocfs2/dlmglue.c
>> +++ b/fs/ocfs2/dlmglue.c
>> @@ -440,6 +440,7 @@ static void ocfs2_remove_lockres_tracking(struct 
> ocfs2_lock_res *res)
>>  static void ocfs2_init_lock_stats(struct ocfs2_lock_res *res)
>>  {
>>  	res->l_lock_refresh = 0;
>> +	res->l_lock_wait = 0;
>>  	memset(&res->l_lock_prmode, 0, sizeof(struct ocfs2_lock_stats));
>>  	memset(&res->l_lock_exmode, 0, sizeof(struct ocfs2_lock_stats));
>>  }
>> @@ -483,6 +484,21 @@ static inline void ocfs2_track_lock_refresh(struct 
> ocfs2_lock_res *lockres)
>>  	lockres->l_lock_refresh++;
>>  }
>>  
>> +static inline void ocfs2_track_lock_wait(struct ocfs2_lock_res *lockres)
>> +{
>> +	struct ocfs2_mask_waiter *mw;
>> +
>> +	if (list_empty(&lockres->l_mask_waiters)) {
>> +		lockres->l_lock_wait = 0;
>> +		return;
>> +	}
>> +
>> +	mw = list_first_entry(&lockres->l_mask_waiters,
>> +				struct ocfs2_mask_waiter, mw_item);
>> +	lockres->l_lock_wait =
>> +			ktime_to_us(ktime_mono_to_real(mw->mw_lock_start));
> 
> I wonder why ktime_mono_to_real() here?
The new item l_lock_wait is a statistic (or debugging) related, which will be dumping to the user-space via debugfs file locking_state for the further analysis if need.
As the last comments from Wengang, the dumping is from different nodes in the cluster, it is better to use wall time (instead of mono or boot time) to display the related absolute times.
Of course, the existing delta time (use mono time) will not affected.

Thanks
Gang

> 
> Thanks,
> Joseph
> 
>> +}
>> +
>>  static inline void ocfs2_init_start_time(struct ocfs2_mask_waiter *mw)
>>  {
>>  	mw->mw_lock_start = ktime_get();
>> @@ -498,6 +514,9 @@ static inline void ocfs2_update_lock_stats(struct 
> ocfs2_lock_res *res,
>>  static inline void ocfs2_track_lock_refresh(struct ocfs2_lock_res *lockres)
>>  {
>>  }
>> +static inline void ocfs2_track_lock_wait(struct ocfs2_lock_res *lockres)
>> +{
>> +}
>>  static inline void ocfs2_init_start_time(struct ocfs2_mask_waiter *mw)
>>  {
>>  }
>> @@ -891,6 +910,7 @@ static void lockres_set_flags(struct ocfs2_lock_res 
> *lockres,
>>  		list_del_init(&mw->mw_item);
>>  		mw->mw_status = 0;
>>  		complete(&mw->mw_complete);
>> +		ocfs2_track_lock_wait(lockres);
>>  	}
>>  }
>>  static void lockres_or_flags(struct ocfs2_lock_res *lockres, unsigned long 
> or)
>> @@ -1402,6 +1422,7 @@ static void lockres_add_mask_waiter(struct 
> ocfs2_lock_res *lockres,
>>  	list_add_tail(&mw->mw_item, &lockres->l_mask_waiters);
>>  	mw->mw_mask = mask;
>>  	mw->mw_goal = goal;
>> +	ocfs2_track_lock_wait(lockres);
>>  }
>>  
>>  /* returns 0 if the mw that was removed was already satisfied, -EBUSY
>> @@ -1418,6 +1439,7 @@ static int __lockres_remove_mask_waiter(struct 
> ocfs2_lock_res *lockres,
>>  
>>  		list_del_init(&mw->mw_item);
>>  		init_completion(&mw->mw_complete);
>> +		ocfs2_track_lock_wait(lockres);
>>  	}
>>  
>>  	return ret;
>> @@ -3098,7 +3120,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, 
> void *v, loff_t *pos)
>>   * New in version 3
>>   *	- Max time in lock stats is in usecs (instead of nsecs)
>>   * New in version 4
>> - *	- Add last pr/ex unlock times in usecs
>> + *	- Add last pr/ex unlock times and first lock wait time in usecs
>>   */
>>  #define OCFS2_DLM_DEBUG_STR_VERSION 4
>>  static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>> @@ -3116,7 +3138,7 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void 
> *v)
>>  		return -EINVAL;
>>  
>>  #ifdef CONFIG_OCFS2_FS_STATS
>> -	if (dlm_debug->d_filter_secs) {
>> +	if (!lockres->l_lock_wait && dlm_debug->d_filter_secs) {
>>  		now = ktime_to_us(ktime_get_real());
>>  		if (lockres->l_lock_prmode.ls_last >
>>  		    lockres->l_lock_exmode.ls_last)
>> @@ -3177,6 +3199,7 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void 
> *v)
>>  # define lock_refresh(_l)		((_l)->l_lock_refresh)
>>  # define lock_last_prmode(_l)		((_l)->l_lock_prmode.ls_last)
>>  # define lock_last_exmode(_l)		((_l)->l_lock_exmode.ls_last)
>> +# define lock_wait(_l)			((_l)->l_lock_wait)
>>  #else
>>  # define lock_num_prmode(_l)		(0)
>>  # define lock_num_exmode(_l)		(0)
>> @@ -3189,6 +3212,7 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void 
> *v)
>>  # define lock_refresh(_l)		(0)
>>  # define lock_last_prmode(_l)		(0ULL)
>>  # define lock_last_exmode(_l)		(0ULL)
>> +# define lock_wait(_l)			(0ULL)
>>  #endif
>>  	/* The following seq_print was added in version 2 of this output */
>>  	seq_printf(m, "%u\t"
>> @@ -3201,6 +3225,7 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void 
> *v)
>>  		   "%u\t"
>>  		   "%u\t"
>>  		   "%llu\t"
>> +		   "%llu\t"
>>  		   "%llu\t",
>>  		   lock_num_prmode(lockres),
>>  		   lock_num_exmode(lockres),
>> @@ -3212,7 +3237,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void 
> *v)
>>  		   lock_max_exmode(lockres),
>>  		   lock_refresh(lockres),
>>  		   lock_last_prmode(lockres),
>> -		   lock_last_exmode(lockres));
>> +		   lock_last_exmode(lockres),
>> +		   lock_wait(lockres));
>>  
>>  	/* End the line */
>>  	seq_printf(m, "\n");
>> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
>> index 6d0a77703d0e..99ce40063da6 100644
>> --- a/fs/ocfs2/ocfs2.h
>> +++ b/fs/ocfs2/ocfs2.h
>> @@ -206,6 +206,7 @@ struct ocfs2_lock_res {
>>  #ifdef CONFIG_OCFS2_FS_STATS
>>  	struct ocfs2_lock_stats  l_lock_prmode;		/* PR mode stats */
>>  	u32                      l_lock_refresh;	/* Disk refreshes */
>> +	u64                      l_lock_wait;	/* First lock wait time */
>>  	struct ocfs2_lock_stats  l_lock_exmode;		/* EX mode stats */
>>  #endif
>>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>> 
