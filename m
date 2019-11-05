Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763C8C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3482A21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so/fDEMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbfKEQ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:59:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45546 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389049AbfKEQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:59:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id w11so4320312pga.12;
        Tue, 05 Nov 2019 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnPGHnYquEoL4Y3ffViBXfnI1bIH8/s67EREknh96FY=;
        b=so/fDEMp72Vf6Sr5a1BXbJNwaMKpFrTW7gdP2OeSeYQIpILrEuWaZjEG9c4pVwnz0k
         v0sW4rUV/wmq+kXMvCw4biQ6AjKNOIwQc/hHDbKpKfXca88cjBu1sO8yz+YkINzzEFLv
         5MZB6dpCxsFHmNlWnsTclbs4knP1hXC+xXL5i7EVshDCUUJif+WYzorDZu0q6yoAlt3B
         odsI3P9F09HMw4VFmkewkL381jHhWK++38Qlt9izSqMZxaLuZUATxLmVexn74dLRhgMP
         5xoQlGalhMyDmOW5Oyz55byQtTQqWdlnpN92qxRr3toZZGfp5UKQ+0TQnjO8rZs+9gMe
         Fo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnPGHnYquEoL4Y3ffViBXfnI1bIH8/s67EREknh96FY=;
        b=sLO8AqTmi1NO5fIx9dtt25S41yefjivy/DUgT5YO3HDoU7TglgOuMS5MGkCXQoym+b
         wv3c8FqJHcUuhFeWx90nLjJ3IwGLUYFLCelQz5q+5CtwvaVjfNTY8g4FxpgxIGy6n3+M
         UAVmLtgtrGSv3UnD965NFBwa3RmtDI7U476SuM+vi7pnKmWu6YZt7Q7tyTOMWyRRZuV/
         1wkAMlDzxLsBVTkso+3T6tTst1RASv9ObTHarf0eluvxsj4QAIIP5ECtOm2nk6dq0d6s
         VOwrSF8OiAHEoCWPGyQcVZXpJqaB5DhP8ZhIp7b0WdwolQZVnUQ3bCPZ5amgK2cWALqk
         IvJw==
X-Gm-Message-State: APjAAAXv1JFPC15d22Bj9F+mBedQDK5Fi0gi4WttE+XQCGeL3KVt3u9+
        iMkGaWqVuAW8vtDAANB6Tfo=
X-Google-Smtp-Source: APXvYqzrsfHlBALe4nXUrCUoQJrdWDvaRJPSDoAGDVk2J8FKedk247s9D0olcClDm0o+UkzJDH7vIw==
X-Received: by 2002:aa7:9787:: with SMTP id o7mr38325469pfp.120.1572973189630;
        Tue, 05 Nov 2019 08:59:49 -0800 (PST)
Received: from workstation ([139.5.253.184])
        by smtp.gmail.com with ESMTPSA id w10sm8233pjq.3.2019.11.05.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 08:59:49 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:29:38 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net,
        madhuparnabhowmik04@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Doc: Improve format for
 whatisRCU.rst
Message-ID: <20191105165938.GA10903@workstation>
References: <20191102115517.6378-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102115517.6378-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:55:17PM +0700, Phong Tran wrote:
> Adding crossreference target for some headers, answer of quizzes
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  Documentation/RCU/whatisRCU.rst | 73 +++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 70d0e4c21917..ae40c8bcc56c 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1,4 +1,4 @@
> -.. _rcu_doc:
> +.. _whatisrcu_doc:
>  
>  What is RCU?  --  "Read, Copy, Update"
>  ======================================
> @@ -27,14 +27,21 @@ the experience has been that different people must take different paths
>  to arrive at an understanding of RCU.  This document provides several
>  different paths, as follows:
>  
> -1.	RCU OVERVIEW
> -2.	WHAT IS RCU'S CORE API?
> -3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
> -4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK?
> -5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
> -6.	ANALOGY WITH READER-WRITER LOCKING
> -7.	FULL LIST OF RCU APIs
> -8.	ANSWERS TO QUICK QUIZZES
> +:ref:`1.	RCU OVERVIEW <1_whatisRCU>`
> +
> +:ref:`2.	WHAT IS RCU'S CORE API? <2_whatisRCU>`
> +
> +:ref:`3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API? <3_whatisRCU>`
> +
> +:ref:`4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK? <4_whatisRCU>`
> +
> +:ref:`5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU? <5_whatisRCU>`
> +
> +:ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
> +
> +:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> +
> +:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
>  
>  People who prefer starting with a conceptual overview should focus on
>  Section 1, though most readers will profit by reading this section at
> @@ -52,6 +59,7 @@ everything, feel free to read the whole thing -- but if you are really
>  that type of person, you have perused the source code and will therefore
>  never need this document anyway.  ;-)
>  
> +.. _1_whatisRCU:
>  
>  1.  RCU OVERVIEW
>  ----------------
> @@ -120,6 +128,7 @@ So how the heck can a reclaimer tell when a reader is done, given
>  that readers are not doing any sort of synchronization operations???
>  Read on to learn about how RCU's API makes this easy.
>  
> +.. _2_whatisRCU:
>  
>  2.  WHAT IS RCU'S CORE API?
>  ---------------------------
> @@ -381,13 +390,15 @@ c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
>  Again, most uses will be of (a).  The (b) and (c) cases are important
>  for specialized uses, but are relatively uncommon.

Hey,

The changes looks good overall, however a few areas would
look even better after a bit of formatting.

The API methods text under this section could be converted
to sub-headings (^^^) for improved readability.

rcu_dereference() sub-section under `Section 2` has 2
footnotes which could be linked using
http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#footnotes

>  
> +.. _3_whatisRCU:
>  
>  3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
>  -----------------------------------------------
>  
>  This section shows a simple use of the core RCU API to protect a
>  global pointer to a dynamically allocated structure.  More-typical
> -uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
> +uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
> +:ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst <NMI_rcu_doc>`.
>  ::
>  
>  	struct foo {
> @@ -470,9 +481,11 @@ o	Use synchronize_rcu() -after- removing a data element from an
>  	data item.
>  
>  See checklist.txt for additional rules to follow when using RCU.
> -And again, more-typical uses of RCU may be found in listRCU.txt,
> -arrayRCU.txt, and NMI-RCU.txt.
> +And again, more-typical uses of RCU may be found in :ref:`listRCU.rst
> +<list_rcu_doc>`, :ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst
> +<NMI_rcu_doc>`.
>  
> +.. _4_whatisRCU:
>  
>  4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
>  --------------------------------------------
> @@ -567,6 +580,7 @@ to avoid having to write your own callback::
>  
>  Again, see checklist.txt for additional rules governing the use of RCU.
>  
> +.. _5_whatisRCU:
>  
>  5.  WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
>  ------------------------------------------------
> @@ -657,10 +671,12 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
>  But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
>  so there can be no deadlock cycle.
>  
> -Quick Quiz #1:	Why is this argument naive?  How could a deadlock
> +Quick Quiz #1:
> +		Why is this argument naive?  How could a deadlock
>  		occur when using this algorithm in a real-world Linux
>  		kernel?  How could this deadlock be avoided?
>  
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
>  
>  5B.  "TOY" EXAMPLE #2: CLASSIC RCU

This could also be converted to a subheading alongside 5A.

>  
> @@ -709,13 +725,20 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
>  that there are no RCU read-side critical sections holding a reference
>  to that data item, so we can safely reclaim it.
>  
> -Quick Quiz #2:	Give an example where Classic RCU's read-side
> +Quick Quiz #2:
> +		Give an example where Classic RCU's read-side
>  		overhead is -negative-.
>  
> -Quick Quiz #3:  If it is illegal to block in an RCU read-side
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +
> +Quick Quiz #3:
> +		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
>  		PREEMPT_RT, where normal spinlocks can block???
>  
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +
> +.. _6_whatisRCU:
>  
>  6.  ANALOGY WITH READER-WRITER LOCKING
>  --------------------------------------
> @@ -842,6 +865,7 @@ delete() can now block.  If this is a problem, there is a callback-based
>  mechanism that never blocks, namely call_rcu() or kfree_rcu(), that can
>  be used in place of synchronize_rcu().
>  
> +.. _7_whatisRCU:
>  
>  7.  FULL LIST OF RCU APIs
>  -------------------------
> @@ -1001,16 +1025,19 @@ g.	Otherwise, use RCU.
>  Of course, this all assumes that you have determined that RCU is in fact
>  the right tool for your job.
>  
> +.. _8_whatisRCU:
>  
>  8.  ANSWERS TO QUICK QUIZZES
>  ----------------------------
>  
> -Quick Quiz #1:	Why is this argument naive?  How could a deadlock
> +Quick Quiz #1:
> +		Why is this argument naive?  How could a deadlock
>  		occur when using this algorithm in a real-world Linux
>  		kernel?  [Referring to the lock-based "toy" RCU
>  		algorithm.]
>  
> -Answer:		Consider the following sequence of events:
> +Answer:
> +		Consider the following sequence of events:
>  
>  		1.	CPU 0 acquires some unrelated lock, call it
>  			"problematic_lock", disabling irq via
> @@ -1049,10 +1076,12 @@ Answer:		Consider the following sequence of events:
>  		approach where tasks in RCU read-side critical sections
>  		cannot be blocked by tasks executing synchronize_rcu().

A cross-reference link, like, `Back to Quick Quiz #n` could be
created which would link to `Quick Quiz #n` in the text. I
noticed other .rst have this feature so this could be a nice
addition.

>  
> -Quick Quiz #2:	Give an example where Classic RCU's read-side
> +Quick Quiz #2:
> +		Give an example where Classic RCU's read-side
>  		overhead is -negative-.
>  
> -Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
> +Answer:
> +		Imagine a single-CPU system with a non-CONFIG_PREEMPT
>  		kernel where a routing table is used by process-context
>  		code, but can be updated by irq-context code (for example,
>  		by an "ICMP REDIRECT" packet).	The usual way of handling
> @@ -1074,11 +1103,13 @@ Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
>  		even the theoretical possibility of negative overhead for
>  		a synchronization primitive is a bit unexpected.  ;-)
>  
> -Quick Quiz #3:  If it is illegal to block in an RCU read-side
> +Quick Quiz #3:
> +		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
>  		PREEMPT_RT, where normal spinlocks can block???
>  
> -Answer:		Just as PREEMPT_RT permits preemption of spinlock
> +Answer:
> +		Just as PREEMPT_RT permits preemption of spinlock
>  		critical sections, it permits preemption of RCU
>  		read-side critical sections.  It also permits
>  		spinlocks blocking while in RCU read-side critical

Further, many words were emphasized in txt format,
example, -toy-, -before- etc. These could be italicized/
bold to comply with reST formatting.

Thanks a lot
Amol

> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
