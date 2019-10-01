Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F96ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F9321855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569919452;
	bh=kG8VWB5S4eyjcS1JBhJuQtUp+VkgX2w/qBlFQEPWX4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xGAhHsbP6S3qzSF2XQ0RG7KNPBtd0qkEgLV6UdY3ejKZAB8JCkQRtvIiuOaMljpBD
	 f5ITaDXeEvFubGbe7Vpvv4zyohIlxxCxiUjB7osnSldqJzXICjpzCGpJF6CYoQzrGQ
	 EWnqmhD1G+E5t9XZmqoc4OlOyehoj1pLmkMdlCeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfJAIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:44:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733089AbfJAIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:44:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so14351660wrv.13;
        Tue, 01 Oct 2019 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdwQsb3+JNLacsbpDuz5D32yWpg1tCJ/fPIbG+myM0k=;
        b=HdLePNBPoqDcKEnbiodeM2y0/VHWwbTm0K4gcAPzQG5RyacfWV8WdQ7aANdu6YFRld
         4gvhFaEjdKU/VKuqkXc8uDdEDLc718tTTK4psrEo7DArxtyyC7EmhUGc12rCtxIu76U+
         F+h6qIAos0aLbpED271AqnIXBF2AzkfGl90a/0noS3z3/3BZmuHmGcfFEXoHeV3CINSS
         M4iq2zgCvOisAC4VLxU2FtoTyvVTIMJcrwGbbERl4h+5A1XWMD9liYf6GxbcH24Em7pg
         qlKC4xx1ylqwLmTdHmJeCP/Ys8XMdMh1id+lz9nz0OGRcJoGSbtgMFQH+DUURXYTVto8
         6E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdwQsb3+JNLacsbpDuz5D32yWpg1tCJ/fPIbG+myM0k=;
        b=KhLOFEuBFULxBIBzIfn7eHXwW5ocF9xC/IhjoAoR3jvEVY+vIqM4vyqW/CcKBgEcPZ
         a74OWYuGavUyaL2tl3rs2HmYXPN/DndzeUl2wXX0JibYoyAf6D8qTEGeWVU3aGjJpMbV
         LkPLLvKLbo7IRcBN15DUoGyEIlLCob3fS5/8lkPcLE1exii8CRR4z396C9jt1UHEMtkO
         JEGY2qgorluX+Wg4srBu6l/ECGD3NrZ0xU4NwCNnFgKG3QxhK+1DcPKLMYQYWy0LAiZr
         cOu09JChvAV+oaCj6XP7jhES4n12o4E8NS8vBnL0N8JGAgzcRpTvP57WOr85Su7ayTjv
         DQdQ==
X-Gm-Message-State: APjAAAUz8j4gK5iBfHIeqRy2gfTvawTWplEAMsvIs8wF5jt++L7FwooA
        eKbpZGGCy0uKa+NHnJePypRNvOYE
X-Google-Smtp-Source: APXvYqxEOTjQwvwYhtdzjfmAg55crVPh5QvTjltvq9e7dUT8IARmTGB+GkEbovvl0gxcy+nDXVx6Zg==
X-Received: by 2002:adf:f341:: with SMTP id e1mr16367215wrp.1.1569919448565;
        Tue, 01 Oct 2019 01:44:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d10sm2307155wma.42.2019.10.01.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 01:44:07 -0700 (PDT)
Date:   Tue, 1 Oct 2019 10:44:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: sched/urgent] sched/membarrier: Fix
 p->mm->membarrier_state racy load
Message-ID: <20191001084405.GA115089@gmail.com>
References: <20190919173705.2181-5-mathieu.desnoyers@efficios.com>
 <156957184332.9866.1795367595934026999.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156957184332.9866.1795367595934026999.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Mathieu Desnoyers <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     227a4aadc75ba22fcb6c4e1c078817b8cbaae4ce
> Gitweb:        https://git.kernel.org/tip/227a4aadc75ba22fcb6c4e1c078817b8cbaae4ce
> Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> AuthorDate:    Thu, 19 Sep 2019 13:37:02 -04:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 25 Sep 2019 17:42:30 +02:00
> 
> sched/membarrier: Fix p->mm->membarrier_state racy load

> +	rcu_read_unlock();
>  	if (!fallback) {
>  		preempt_disable();
>  		smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> @@ -136,6 +178,7 @@ static int membarrier_private_expedited(int flags)
>  	}
>  
>  	cpus_read_lock();
> +	rcu_read_lock();
>  	for_each_online_cpu(cpu) {
>  		struct task_struct *p;
>  
> @@ -157,8 +200,8 @@ static int membarrier_private_expedited(int flags)
>  			else
>  				smp_call_function_single(cpu, ipi_mb, NULL, 1);
>  		}
> -		rcu_read_unlock();
>  	}
> +	rcu_read_unlock();

I noticed this too late, but the locking in this part is now bogus:

	rcu_read_lock();
	for_each_online_cpu(cpu) {
		struct task_struct *p;

		/*
		 * Skipping the current CPU is OK even through we can be
		 * migrated at any point. The current CPU, at the point
		 * where we read raw_smp_processor_id(), is ensured to
		 * be in program order with respect to the caller
		 * thread. Therefore, we can skip this CPU from the
		 * iteration.
		 */
		if (cpu == raw_smp_processor_id())
			continue;
		rcu_read_lock();
		p = rcu_dereference(cpu_rq(cpu)->curr);
		if (p && p->mm == mm)
			__cpumask_set_cpu(cpu, tmpmask);
	}
	rcu_read_unlock();

Note the double rcu_read_lock() ....

This bug is now upstream, so requires an urgent fix, as it should be 
trivial to trigger with pretty much any membarrier user.

Thanks,

	Ingo
