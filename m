Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A25C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD432077C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKdLEu+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfKFNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:16:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33118 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfKFNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:16:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so4416632plb.0;
        Wed, 06 Nov 2019 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jH1CxWqEe5u9tGVGijQtsOXtAhLD0z88WC7LLZl90EA=;
        b=eKdLEu+G6yD6w9fFrb36tbbY8q/Qizz9j2ep8AtDSIqRH0N4OX38AJYVrNqQQLJgiI
         fDVdvWbtQrwjtko0umuiNgkAQP7MpBKd76opQgeqGTguqkoPWHkT0nrSlTEFDQKcwZox
         J0Czo4e3Li/Al5Nt624/TuZ2BYvjv7sos3uaFow4VTXTjlXS1BibegLDC04lhfkSZgeo
         3X3ymRUegYNqP1Q9B410+uiAzPZuwsV5kCCrswl0N3+h2gA111mwTtls3m83UAlSnKi9
         BCvCYOTXU/i46/zMelsgYqRevWnfAdwXUrf4JTxEECLwCP7GDYwlfpnYnC+GPpahuWUG
         CrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jH1CxWqEe5u9tGVGijQtsOXtAhLD0z88WC7LLZl90EA=;
        b=YFbUOgxJuFDXpXxSKgJf4aUyZHz3deuN5X98cLJSZ8juDq1Bu3Vc7oEJGyulx2e4A3
         ywIWDz6pyOMi9ijuK3IbSTI4OJwHdltfPixFc2psMUR3i6tTKAdkzTWurg13h8Eo/DhY
         wVT6eTy5JLdb+P1b1kRhryiQimFXEg69am8QUjuwrb3QbshZdPYWExuNeHY+fShxFNYu
         8XJvvNVa1l7eh2IHMbpeQV+Wi/Tcf9aglyXdCUaL9mn8AxGx5nYYGaRZ1+KM2liz30t4
         UYrd1ScYteSqXH69xj/uGafF9mSJTEam/GLY/3bFu+G3OLx6B0ek7kL1XhEbegYW8S0V
         hyQA==
X-Gm-Message-State: APjAAAVI5cltGFi+d+xf2Gj21XnMWpdpclC1FvOKV65sdem6lzW68IF6
        MKlZV0ara/M8EDGmDvxCcjI=
X-Google-Smtp-Source: APXvYqxp58pt5cP0YvZCIifD24FK0eCy/ukLAA5N1vzz0ykRvr6pUS6GC7funBp42A5ELVgxTOhPzQ==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr2665743plp.166.1573046200967;
        Wed, 06 Nov 2019 05:16:40 -0800 (PST)
Received: from ?IPv6:2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb? ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id 18sm23577703pfp.100.2019.11.06.05.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 05:16:40 -0800 (PST)
Cc:     tranmanphong@gmail.com, paulmck@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: Re: [Linux-kernel-mentees] [PATCH] Doc: whatisRCU: Add more
 Markup
To:     Amol Grover <frextrite@gmail.com>
References: <20191105165938.GA10903@workstation>
 <20191105214234.17116-1-tranmanphong@gmail.com>
 <20191106094523.GA1245@workstation-kernel-dev>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <8705475b-7423-1af1-a664-bdee2bf3894d@gmail.com>
Date:   Wed, 6 Nov 2019 20:16:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106094523.GA1245@workstation-kernel-dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 4:45 PM, Amol Grover wrote:
> On Wed, Nov 06, 2019 at 04:42:34AM +0700, Phong Tran wrote:
>> o Adding more crossrefs.
>> o Bold some words.
>> o Add header levels.
>>
>> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
>> ---
>>   Documentation/RCU/whatisRCU.rst | 67 ++++++++++++++++++++-------------
>>   1 file changed, 41 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
>> index ae40c8bcc56c..3e24e0155a91 100644
>> --- a/Documentation/RCU/whatisRCU.rst
>> +++ b/Documentation/RCU/whatisRCU.rst
>> @@ -150,7 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
>>   at the function header comments.
>>   
>>   rcu_read_lock()
>> -
>> +^^^^^^^^^^^^^^^
>>   	void rcu_read_lock(void);
>>   
>>   	Used by a reader to inform the reclaimer that the reader is
>> @@ -164,7 +164,7 @@ rcu_read_lock()
>>   	longer-term references to data structures.
>>   
>>   rcu_read_unlock()
>> -
>> +^^^^^^^^^^^^^^^^^
>>   	void rcu_read_unlock(void);
>>   
>>   	Used by a reader to inform the reclaimer that the reader is
>> @@ -172,13 +172,13 @@ rcu_read_unlock()
>>   	read-side critical sections may be nested and/or overlapping.
>>   
>>   synchronize_rcu()
>> -
>> +^^^^^^^^^^^^^^^^^
>>   	void synchronize_rcu(void);
>>   
>>   	Marks the end of updater code and the beginning of reclaimer
>>   	code.  It does this by blocking until all pre-existing RCU
>>   	read-side critical sections on all CPUs have completed.
>> -	Note that synchronize_rcu() will -not- necessarily wait for
>> +	Note that synchronize_rcu() will **not** necessarily wait for
>>   	any subsequent RCU read-side critical sections to complete.
>>   	For example, consider the following sequence of events::
>>   
>> @@ -196,7 +196,7 @@ synchronize_rcu()
>>   	any that begin after synchronize_rcu() is invoked.
>>   
>>   	Of course, synchronize_rcu() does not necessarily return
>> -	-immediately- after the last pre-existing RCU read-side critical
>> +	**immediately** after the last pre-existing RCU read-side critical
>>   	section completes.  For one thing, there might well be scheduling
>>   	delays.  For another thing, many RCU implementations process
>>   	requests in batches in order to improve efficiencies, which can
>> @@ -225,10 +225,10 @@ synchronize_rcu()
>>   	checklist.txt for some approaches to limiting the update rate.
>>   
>>   rcu_assign_pointer()
>> -
>> +^^^^^^^^^^^^^^^^^^^^
>>   	void rcu_assign_pointer(p, typeof(p) v);
>>   
>> -	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
>> +	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
>>   	would be cool to be able to declare a function in this manner.
>>   	(Compiler experts will no doubt disagree.)
>>   
>> @@ -245,7 +245,7 @@ rcu_assign_pointer()
>>   	the _rcu list-manipulation primitives such as list_add_rcu().
>>   
>>   rcu_dereference()
>> -
>> +^^^^^^^^^^^^^^^^^
>>   	typeof(p) rcu_dereference(p);
>>   
>>   	Like rcu_assign_pointer(), rcu_dereference() must be implemented
>> @@ -280,8 +280,8 @@ rcu_dereference()
>>   	unnecessary overhead on Alpha CPUs.
>>   
>>   	Note that the value returned by rcu_dereference() is valid
>> -	only within the enclosing RCU read-side critical section [1].
>> -	For example, the following is -not- legal::
>> +	only within the enclosing RCU read-side critical section [1]_.
>> +	For example, the following is **not** legal::
>>   
>>   		rcu_read_lock();
>>   		p = rcu_dereference(head.next);
>> @@ -304,9 +304,11 @@ rcu_dereference()
>>   	at any time, including immediately after the rcu_dereference().
>>   	And, again like rcu_assign_pointer(), rcu_dereference() is
>>   	typically used indirectly, via the _rcu list-manipulation
>> -	primitives, such as list_for_each_entry_rcu() [2].
>> +	primitives, such as list_for_each_entry_rcu() [2]_.
>> +
>> +	.. [1]
> 
> Hey Phong,
> I just checked the patch but this change doesn't seem quite right.
> It just creates an empty footnote. Something on the lines of
> ..	[1] The variant rcu_dereference_protected()...
> should work.
> 
thanks, Amol.
fixed it. The patch sent out amend to 7c12b3764c47

https://lkml.org/lkml/2019/11/6/513

>>   
>> -	[1] The variant rcu_dereference_protected() can be used outside
>> +	The variant rcu_dereference_protected() can be used outside
>>   	of an RCU read-side critical section as long as the usage is
>>   	protected by locks acquired by the update-side code.  This variant
>>   	avoids the lockdep warning that would happen when using (for
>> @@ -319,7 +321,9 @@ rcu_dereference()
>>   	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
>>   	and the API's code comments for more details and example usage.
>>   
>> -	[2] If the list_for_each_entry_rcu() instance might be used by
>> +	.. [2]
> 
> Similarly for this.
> 
Fixed it

>> +
>> +	If the list_for_each_entry_rcu() instance might be used by
>>   	update-side code as well as by RCU readers, then an additional
>>   	lockdep expression can be added to its list of arguments.
>>   	For example, given an additional "lock_is_held(&mylock)" argument,
>> @@ -459,22 +463,22 @@ uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
>>   
>>   So, to sum up:
>>   
>> -o	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
>> +-	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
>>   	read-side critical sections.
>>   
>> -o	Within an RCU read-side critical section, use rcu_dereference()
>> +-	Within an RCU read-side critical section, use rcu_dereference()
>>   	to dereference RCU-protected pointers.
>>   
>> -o	Use some solid scheme (such as locks or semaphores) to
>> +-	Use some solid scheme (such as locks or semaphores) to
>>   	keep concurrent updates from interfering with each other.
>>   
>> -o	Use rcu_assign_pointer() to update an RCU-protected pointer.
>> +-	Use rcu_assign_pointer() to update an RCU-protected pointer.
>>   	This primitive protects concurrent readers from the updater,
>> -	-not- concurrent updates from each other!  You therefore still
>> +	**not** concurrent updates from each other!  You therefore still
>>   	need to use locking (or something similar) to keep concurrent
>>   	rcu_assign_pointer() primitives from interfering with each other.
>>   
>> -o	Use synchronize_rcu() -after- removing a data element from an
>> +-	Use synchronize_rcu() **after** removing a data element from an
>>   	RCU-protected data structure, but -before- reclaiming/freeing
> 
> And this -before- is feeling lonely aswell.
> 
okay, fixed.

Regards,
Phong.

> 
> Thanks
> Amol
> 
>>   	the data element, in order to wait for the completion of all
>>   	RCU read-side critical sections that might be referencing that
>> @@ -566,7 +570,7 @@ namely foo_reclaim().
>>   The summary of advice is the same as for the previous section, except
>>   that we are now using call_rcu() rather than synchronize_rcu():
>>   
>> -o	Use call_rcu() -after- removing a data element from an
>> +-	Use call_rcu() **after** removing a data element from an
>>   	RCU-protected data structure in order to register a callback
>>   	function that will be invoked after the completion of all RCU
>>   	read-side critical sections that might be referencing that
>> @@ -603,7 +607,7 @@ more details on the current implementation as of early 2004.
>>   
>>   
>>   5A.  "TOY" IMPLEMENTATION #1: LOCKING
>> -
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   This section presents a "toy" RCU implementation that is based on
>>   familiar locking primitives.  Its overhead makes it a non-starter for
>>   real-life use, as does its lack of scalability.  It is also unsuitable
>> @@ -671,6 +675,8 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
>>   But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
>>   so there can be no deadlock cycle.
>>   
>> +.. _quiz_1:
>> +
>>   Quick Quiz #1:
>>   		Why is this argument naive?  How could a deadlock
>>   		occur when using this algorithm in a real-world Linux
>> @@ -679,7 +685,7 @@ Quick Quiz #1:
>>   :ref:`Answers to Quick Quiz <8_whatisRCU>`
>>   
>>   5B.  "TOY" EXAMPLE #2: CLASSIC RCU
>> -
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   This section presents a "toy" RCU implementation that is based on
>>   "classic RCU".  It is also short on performance (but only for updates) and
>>   on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
>> @@ -710,14 +716,14 @@ CPU in turn.  The run_on() primitive can be implemented straightforwardly
>>   in terms of the sched_setaffinity() primitive.  Of course, a somewhat less
>>   "toy" implementation would restore the affinity upon completion rather
>>   than just leaving all tasks running on the last CPU, but when I said
>> -"toy", I meant -toy-!
>> +"toy", I meant **toy**!
>>   
>>   So how the heck is this supposed to work???
>>   
>>   Remember that it is illegal to block while in an RCU read-side critical
>>   section.  Therefore, if a given CPU executes a context switch, we know
>>   that it must have completed all preceding RCU read-side critical sections.
>> -Once -all- CPUs have executed a context switch, then -all- preceding
>> +Once **all** CPUs have executed a context switch, then **all** preceding
>>   RCU read-side critical sections will have completed.
>>   
>>   So, suppose that we remove a data item from its structure and then invoke
>> @@ -725,12 +731,16 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
>>   that there are no RCU read-side critical sections holding a reference
>>   to that data item, so we can safely reclaim it.
>>   
>> +.. _quiz_2:
>> +
>>   Quick Quiz #2:
>>   		Give an example where Classic RCU's read-side
>> -		overhead is -negative-.
>> +		overhead is **negative**.
>>   
>>   :ref:`Answers to Quick Quiz <8_whatisRCU>`
>>   
>> +.. _quiz_3:
>> +
>>   Quick Quiz #3:
>>   		If it is illegal to block in an RCU read-side
>>   		critical section, what the heck do you do in
>> @@ -1076,9 +1086,11 @@ Answer:
>>   		approach where tasks in RCU read-side critical sections
>>   		cannot be blocked by tasks executing synchronize_rcu().
>>   
>> +:ref:`Back to Quick Quiz #1 <quiz_1>`
>> +
>>   Quick Quiz #2:
>>   		Give an example where Classic RCU's read-side
>> -		overhead is -negative-.
>> +		overhead is **negative**.
>>   
>>   Answer:
>>   		Imagine a single-CPU system with a non-CONFIG_PREEMPT
>> @@ -1103,6 +1115,8 @@ Answer:
>>   		even the theoretical possibility of negative overhead for
>>   		a synchronization primitive is a bit unexpected.  ;-)
>>   
>> +:ref:`Back to Quick Quiz #2 <quiz_2>`
>> +
>>   Quick Quiz #3:
>>   		If it is illegal to block in an RCU read-side
>>   		critical section, what the heck do you do in
>> @@ -1128,6 +1142,7 @@ Answer:
>>   		Besides, how does the computer know what pizza parlor
>>   		the human being went to???
>>   
>> +:ref:`Back to Quick Quiz #3 <quiz_3>`
>>   
>>   ACKNOWLEDGEMENTS
>>   
>> -- 
>> 2.20.1
>>
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
> 
