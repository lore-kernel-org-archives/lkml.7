Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91520881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfEVSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F4A58666F;
        Wed, 22 May 2019 18:41:53 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F37F61001284;
        Wed, 22 May 2019 18:41:49 +0000 (UTC)
Subject: Re: [PATCH] rcu: Force inlining of rcu_read_lock()
To:     paulmck@linux.ibm.com
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190521204843.11060-1-longman@redhat.com>
 <20190522181817.GF28207@linux.ibm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <57dc4711-8e06-4c29-6e9a-ce98577e27fa@redhat.com>
Date:   Wed, 22 May 2019 14:41:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522181817.GF28207@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 22 May 2019 18:41:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 2:18 PM, Paul E. McKenney wrote:
> On Tue, May 21, 2019 at 04:48:43PM -0400, Waiman Long wrote:
>> It is found that when debugging options are turned on, the
>> rcu_read_lock() function may not be inlined at all. That will make
>> it harder to debug RCU related problem as the print_lock() function
>> in lockdep will print "rcu_read_lock()" instead of the caller of
>> rcu_read_lock() function. For example,
>>
>> [   10.579995] =============================
>> [   10.584033] WARNING: suspicious RCU usage
>> [   10.588074] 4.18.0.memcg_v2+ #1 Not tainted
>> [   10.593162] -----------------------------
>> [   10.597203] include/linux/rcupdate.h:281 Illegal context switch in
>> RCU read-side critical section!
>> [   10.606220]
>> [   10.606220] other info that might help us debug this:
>> [   10.606220]
>> [   10.614280]
>> [   10.614280] rcu_scheduler_active = 2, debug_locks = 1
>> [   10.620853] 3 locks held by systemd/1:
>> [   10.624632]  #0: (____ptrval____) (&type->i_mutex_dir_key#5){.+.+}, at: lookup_slow+0x42/0x70
>> [   10.633232]  #1: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
>> [   10.640954]  #2: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
>>
>> To make sure that the proper caller of rcu_read_lock() is shown, we
>> have to force the inlining of the rcu_read_lock() function.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Good point, queued!  I reworked the commit log as follows, is this OK?
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit c006ffd7b607f8ee216f6a7a6d845b9514881e92
> Author: Waiman Long <longman@redhat.com>
> Date:   Tue May 21 16:48:43 2019 -0400
>
>     rcu: Force inlining of rcu_read_lock()
>     
>     When debugging options are turned on, the rcu_read_lock() function
>     might not be inlined. This results in lockdep's print_lock() function
>     printing "rcu_read_lock+0x0/0x70" instead of rcu_read_lock()'s caller.
>     For example:
>     
>     [   10.579995] =============================
>     [   10.584033] WARNING: suspicious RCU usage
>     [   10.588074] 4.18.0.memcg_v2+ #1 Not tainted
>     [   10.593162] -----------------------------
>     [   10.597203] include/linux/rcupdate.h:281 Illegal context switch in
>     RCU read-side critical section!
>     [   10.606220]
>     [   10.606220] other info that might help us debug this:
>     [   10.606220]
>     [   10.614280]
>     [   10.614280] rcu_scheduler_active = 2, debug_locks = 1
>     [   10.620853] 3 locks held by systemd/1:
>     [   10.624632]  #0: (____ptrval____) (&type->i_mutex_dir_key#5){.+.+}, at: lookup_slow+0x42/0x70
>     [   10.633232]  #1: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
>     [   10.640954]  #2: (____ptrval____) (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x70
>     
>     These "rcu_read_lock+0x0/0x70" strings are not providing any useful
>     information.  This commit therefore forces inlining of the rcu_read_lock()
>     function so that rcu_read_lock()'s caller is instead shown.
>     

Your modification make sense to me.

Thanks,
Longman


>     Signed-off-by: Waiman Long <longman@redhat.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 534c05d529b5..a8ed624da555 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -588,7 +588,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>   * read-side critical sections may be preempted and they may also block, but
>   * only when acquiring spinlocks that are subject to priority inheritance.
>   */
> -static inline void rcu_read_lock(void)
> +static __always_inline void rcu_read_lock(void)
>  {
>  	__rcu_read_lock();
>  	__acquire(RCU);
>

