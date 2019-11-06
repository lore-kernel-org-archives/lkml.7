Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D0C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A3F217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olnefStW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfKFJpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:45:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46015 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKFJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:45:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id w11so6423854pga.12;
        Wed, 06 Nov 2019 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bXe/BBaX+xudQUA/2Ft5oq6zptOTHdm2b4uiyD05GvQ=;
        b=olnefStWjGtbjizKh7p0H6220AAJtVVUM/Ypwwi4p/1mxabNRW/SY2PYouv/GPUh9Q
         w+qYlkJCzEXGB0q0nCESAeXUJhPJEUoHBz0AXtx3VNUwzAfVUjFuQdj2y/drPDq20w7B
         A6ktwF1bA3R7/WtzwxNvTKY4tVVeBoBhEQcjt4YtBLtwgfdOF6dS5oQt2Kej8I5LOk9i
         iuVikraovNMWAMk/RBvk+YB2cH+MojJ3e5m9WHMGl51AGXJZV9IRW0lbPqMUWT53aI7M
         NvfrUHQlPAXRhvqbRWOlS6bI9WsNI12DhMgE7SoZ5zXsIKjbEGH0d2+/m366t5iQIr97
         0w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bXe/BBaX+xudQUA/2Ft5oq6zptOTHdm2b4uiyD05GvQ=;
        b=MbxVVcSnsHoV7Iel39Couv3SHowy4dgji/ccJrHsx5GwrSVVPkS4mjcjFAhadUa2pi
         csN/5ntdUOU61V1+MKC56EPFqcKhMArlZgIDPmEsplWWnayxrCgxWPL/yHd3l9Wo2c4C
         dObYerVRliLwA/3XI0DZvhQLciAaSbmBnHd6mXjE2v6oremQKYpiwlxr5hWfFN0rO20Z
         GD4pDM/KSZ7UcngsIOdBOxEBV9D1urdeGi0ssuAMWiLCrCns16JPkYf2H6TIWw0faV5S
         oEwdZuxOZurlu0o13twQ4Z6d+FGDn7z9RjNvxGneqx99ZUqi+nwt9y1t18h1CArDK3Xf
         FHcQ==
X-Gm-Message-State: APjAAAX7U468dtP9cwQt6iGRb73S2UCbdGMxOnyAi8z44zeROfRRaYcC
        TuB2Il/a+j8u+74fUucFIO5z9MyvIC9NUw==
X-Google-Smtp-Source: APXvYqxw05ljDQcvrxoc7AW4N2Mal6rKcm3jifVN53J5F7QgnDIN/bvtrqdDRzlLic0hbqEa0mbUnw==
X-Received: by 2002:a63:fa0d:: with SMTP id y13mr1794954pgh.18.1573033529858;
        Wed, 06 Nov 2019 01:45:29 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.230])
        by smtp.gmail.com with ESMTPSA id q42sm2236843pja.16.2019.11.06.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 01:45:29 -0800 (PST)
Date:   Wed, 6 Nov 2019 15:15:23 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     paulmck@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        mathieu.desnoyers@efficios.com, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Doc: whatisRCU: Add more Markup
Message-ID: <20191106094523.GA1245@workstation-kernel-dev>
References: <20191105165938.GA10903@workstation>
 <20191105214234.17116-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105214234.17116-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:42:34AM +0700, Phong Tran wrote:
> o Adding more crossrefs.
> o Bold some words.
> o Add header levels.
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  Documentation/RCU/whatisRCU.rst | 67 ++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index ae40c8bcc56c..3e24e0155a91 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -150,7 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
>  at the function header comments.
>  
>  rcu_read_lock()
> -
> +^^^^^^^^^^^^^^^
>  	void rcu_read_lock(void);
>  
>  	Used by a reader to inform the reclaimer that the reader is
> @@ -164,7 +164,7 @@ rcu_read_lock()
>  	longer-term references to data structures.
>  
>  rcu_read_unlock()
> -
> +^^^^^^^^^^^^^^^^^
>  	void rcu_read_unlock(void);
>  
>  	Used by a reader to inform the reclaimer that the reader is
> @@ -172,13 +172,13 @@ rcu_read_unlock()
>  	read-side critical sections may be nested and/or overlapping.
>  
>  synchronize_rcu()
> -
> +^^^^^^^^^^^^^^^^^
>  	void synchronize_rcu(void);
>  
>  	Marks the end of updater code and the beginning of reclaimer
>  	code.  It does this by blocking until all pre-existing RCU
>  	read-side critical sections on all CPUs have completed.
> -	Note that synchronize_rcu() will -not- necessarily wait for
> +	Note that synchronize_rcu() will **not** necessarily wait for
>  	any subsequent RCU read-side critical sections to complete.
>  	For example, consider the following sequence of events::
>  
> @@ -196,7 +196,7 @@ synchronize_rcu()
>  	any that begin after synchronize_rcu() is invoked.
>  
>  	Of course, synchronize_rcu() does not necessarily return
> -	-immediately- after the last pre-existing RCU read-side critical
> +	**immediately** after the last pre-existing RCU read-side critical
>  	section completes.  For one thing, there might well be scheduling
>  	delays.  For another thing, many RCU implementations process
>  	requests in batches in order to improve efficiencies, which can
> @@ -225,10 +225,10 @@ synchronize_rcu()
>  	checklist.txt for some approaches to limiting the update rate.
>  
>  rcu_assign_pointer()
> -
> +^^^^^^^^^^^^^^^^^^^^
>  	void rcu_assign_pointer(p, typeof(p) v);
>  
> -	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
> +	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
>  	would be cool to be able to declare a function in this manner.
>  	(Compiler experts will no doubt disagree.)
>  
> @@ -245,7 +245,7 @@ rcu_assign_pointer()
>  	the _rcu list-manipulation primitives such as list_add_rcu().
>  
>  rcu_dereference()
> -
> +^^^^^^^^^^^^^^^^^
>  	typeof(p) rcu_dereference(p);
>  
>  	Like rcu_assign_pointer(), rcu_dereference() must be implemented
> @@ -280,8 +280,8 @@ rcu_dereference()
>  	unnecessary overhead on Alpha CPUs.
>  
>  	Note that the value returned by rcu_dereference() is valid
> -	only within the enclosing RCU read-side critical section [1].
> -	For example, the following is -not- legal::
> +	only within the enclosing RCU read-side critical section [1]_.
> +	For example, the following is **not** legal::
>  
>  		rcu_read_lock();
>  		p = rcu_dereference(head.next);
> @@ -304,9 +304,11 @@ rcu_dereference()
>  	at any time, including immediately after the rcu_dereference().
>  	And, again like rcu_assign_pointer(), rcu_dereference() is
>  	typically used indirectly, via the _rcu list-manipulation
> -	primitives, such as list_for_each_entry_rcu() [2].
> +	primitives, such as list_for_each_entry_rcu() [2]_.
> +
> +	.. [1]

Hey Phong,
I just checked the patch but this change doesn't seem quite right.
It just creates an empty footnote. Something on the lines of
..	[1] The variant rcu_dereference_protected()...
should work.

>  
> -	[1] The variant rcu_dereference_protected() can be used outside
> +	The variant rcu_dereference_protected() can be used outside
>  	of an RCU read-side critical section as long as the usage is
>  	protected by locks acquired by the update-side code.  This variant
>  	avoids the lockdep warning that would happen when using (for
> @@ -319,7 +321,9 @@ rcu_dereference()
>  	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
>  	and the API's code comments for more details and example usage.
>  
> -	[2] If the list_for_each_entry_rcu() instance might be used by
> +	.. [2]

Similarly for this.

> +
> +	If the list_for_each_entry_rcu() instance might be used by
>  	update-side code as well as by RCU readers, then an additional
>  	lockdep expression can be added to its list of arguments.
>  	For example, given an additional "lock_is_held(&mylock)" argument,
> @@ -459,22 +463,22 @@ uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
>  
>  So, to sum up:
>  
> -o	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
> +-	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
>  	read-side critical sections.
>  
> -o	Within an RCU read-side critical section, use rcu_dereference()
> +-	Within an RCU read-side critical section, use rcu_dereference()
>  	to dereference RCU-protected pointers.
>  
> -o	Use some solid scheme (such as locks or semaphores) to
> +-	Use some solid scheme (such as locks or semaphores) to
>  	keep concurrent updates from interfering with each other.
>  
> -o	Use rcu_assign_pointer() to update an RCU-protected pointer.
> +-	Use rcu_assign_pointer() to update an RCU-protected pointer.
>  	This primitive protects concurrent readers from the updater,
> -	-not- concurrent updates from each other!  You therefore still
> +	**not** concurrent updates from each other!  You therefore still
>  	need to use locking (or something similar) to keep concurrent
>  	rcu_assign_pointer() primitives from interfering with each other.
>  
> -o	Use synchronize_rcu() -after- removing a data element from an
> +-	Use synchronize_rcu() **after** removing a data element from an
>  	RCU-protected data structure, but -before- reclaiming/freeing

And this -before- is feeling lonely aswell.


Thanks
Amol

>  	the data element, in order to wait for the completion of all
>  	RCU read-side critical sections that might be referencing that
> @@ -566,7 +570,7 @@ namely foo_reclaim().
>  The summary of advice is the same as for the previous section, except
>  that we are now using call_rcu() rather than synchronize_rcu():
>  
> -o	Use call_rcu() -after- removing a data element from an
> +-	Use call_rcu() **after** removing a data element from an
>  	RCU-protected data structure in order to register a callback
>  	function that will be invoked after the completion of all RCU
>  	read-side critical sections that might be referencing that
> @@ -603,7 +607,7 @@ more details on the current implementation as of early 2004.
>  
>  
>  5A.  "TOY" IMPLEMENTATION #1: LOCKING
> -
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  This section presents a "toy" RCU implementation that is based on
>  familiar locking primitives.  Its overhead makes it a non-starter for
>  real-life use, as does its lack of scalability.  It is also unsuitable
> @@ -671,6 +675,8 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
>  But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
>  so there can be no deadlock cycle.
>  
> +.. _quiz_1:
> +
>  Quick Quiz #1:
>  		Why is this argument naive?  How could a deadlock
>  		occur when using this algorithm in a real-world Linux
> @@ -679,7 +685,7 @@ Quick Quiz #1:
>  :ref:`Answers to Quick Quiz <8_whatisRCU>`
>  
>  5B.  "TOY" EXAMPLE #2: CLASSIC RCU
> -
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  This section presents a "toy" RCU implementation that is based on
>  "classic RCU".  It is also short on performance (but only for updates) and
>  on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
> @@ -710,14 +716,14 @@ CPU in turn.  The run_on() primitive can be implemented straightforwardly
>  in terms of the sched_setaffinity() primitive.  Of course, a somewhat less
>  "toy" implementation would restore the affinity upon completion rather
>  than just leaving all tasks running on the last CPU, but when I said
> -"toy", I meant -toy-!
> +"toy", I meant **toy**!
>  
>  So how the heck is this supposed to work???
>  
>  Remember that it is illegal to block while in an RCU read-side critical
>  section.  Therefore, if a given CPU executes a context switch, we know
>  that it must have completed all preceding RCU read-side critical sections.
> -Once -all- CPUs have executed a context switch, then -all- preceding
> +Once **all** CPUs have executed a context switch, then **all** preceding
>  RCU read-side critical sections will have completed.
>  
>  So, suppose that we remove a data item from its structure and then invoke
> @@ -725,12 +731,16 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
>  that there are no RCU read-side critical sections holding a reference
>  to that data item, so we can safely reclaim it.
>  
> +.. _quiz_2:
> +
>  Quick Quiz #2:
>  		Give an example where Classic RCU's read-side
> -		overhead is -negative-.
> +		overhead is **negative**.
>  
>  :ref:`Answers to Quick Quiz <8_whatisRCU>`
>  
> +.. _quiz_3:
> +
>  Quick Quiz #3:
>  		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
> @@ -1076,9 +1086,11 @@ Answer:
>  		approach where tasks in RCU read-side critical sections
>  		cannot be blocked by tasks executing synchronize_rcu().
>  
> +:ref:`Back to Quick Quiz #1 <quiz_1>`
> +
>  Quick Quiz #2:
>  		Give an example where Classic RCU's read-side
> -		overhead is -negative-.
> +		overhead is **negative**.
>  
>  Answer:
>  		Imagine a single-CPU system with a non-CONFIG_PREEMPT
> @@ -1103,6 +1115,8 @@ Answer:
>  		even the theoretical possibility of negative overhead for
>  		a synchronization primitive is a bit unexpected.  ;-)
>  
> +:ref:`Back to Quick Quiz #2 <quiz_2>`
> +
>  Quick Quiz #3:
>  		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
> @@ -1128,6 +1142,7 @@ Answer:
>  		Besides, how does the computer know what pizza parlor
>  		the human being went to???
>  
> +:ref:`Back to Quick Quiz #3 <quiz_3>`
>  
>  ACKNOWLEDGEMENTS
>  
> -- 
> 2.20.1
> 
