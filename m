Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF45C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB2A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n5tZFOKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfDRMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:54:21 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51423 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:54:21 -0400
Received: by mail-wm1-f47.google.com with SMTP id 4so2658700wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ByEa1lD5mAxKhpWtXW4/ZgKF/orHerjfNa7MXZaf6wk=;
        b=n5tZFOKJY5djututyuZ0wXiLEWKi/1VEIgoYX6lHsfXtPyvZblC0hEmx1zTPk55HiP
         pfIXHkU/o+Mgv+CYx7Fpo8odLG+mvg1LfEkn/oj/TSjEk1yuJlMac2+wY1Q1E9kxJrkT
         3Ztctb8dD7VE/LpFCKVHm9Cz/RgB1IwN7cWkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByEa1lD5mAxKhpWtXW4/ZgKF/orHerjfNa7MXZaf6wk=;
        b=KH9Bo3T+ioC4gIS1VcWfRfeOm8EdQxVLg59Ft16MZ7QgLkwxT79rQTIHrYt1fCv3bs
         NrySfdXdrv+EvoCHqeCHFRD5XR4AN9JzngXd1wNINhdE+FqC03tV32mXH+rZQYtwftfi
         QI5JqkYR9f4rOT+foABU6SNjly5Nc1F3gy4lWOWtajT33s3Utzt9+clboFP/JE61bDES
         VPk9/TGvU5/La853LF9Qk65PpZu4tftBYRn+pCxmzkq4uyO4ZYgl+gdXGtuz4j1lVNby
         iOiyD9C5nxdeVNZ9y8a0kK+Oh41bAn0s/lLMzwrjydvnePFCbSc1G14rblBim/WsKu9D
         cY2Q==
X-Gm-Message-State: APjAAAWw991U744wf1+MA3ufvvcwy6z7kpT8Wj8PDYdZFkcSDgfBs9Dr
        PKh6bmcrXXFfpSOZ0kY3GdRBMQ==
X-Google-Smtp-Source: APXvYqwNxhDQ3bUXhz+Ty7qUZ0PwvP0gcBlJUn/Dj+Ky6ni3/jJygHEb0BHIrsZgbfWlVjZFSpKk0A==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr3014673wmc.12.1555592059385;
        Thu, 18 Apr 2019 05:54:19 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id y9sm3695561wrn.18.2019.04.18.05.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:54:18 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:54:12 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Message-ID: <20190418125412.GA10817@andrea>
References: <20190408055117.GA25135@andrea>
 <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
 <20190409013618.GA3824@andrea>
 <20190409150132.GB14111@linux.ibm.com>
 <20190413213938.GA4371@andrea>
 <20190415133535.GU14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415133535.GU14111@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Another question is "should the kernel permit smp_mb__{before,after}*()
> anywhere other than immediately before or after the primitive being
> strengthened?"

Mmh, I do think that keeping these barriers "immediately before or after
the primitive being strengthened" is a good practice (readability, and
all that), if this is what you're suggesting.

However, a first auditing of the callsites showed that this practice is
in fact not always applied, notably... ;-)

	kernel/rcu/tree_exp.h:sync_exp_work_done
	kernel/sched/cpupri.c:cpupri_set

So there appear, at least, to be some exceptions/reasons for not always
following it?  Thoughts?

BTW, while auditing these callsites, I've stumbled across the following
snippet (from kernel/futex.c):

	*futex = newval;
	sys_futex(WAKE, futex);
          futex_wake(futex);
          smp_mb(); (B)
	  if (waiters)
	    ...

where B is actually (c.f., futex_get_mm()):

	atomic_inc(...->mm_count);
	smp_mb__after_atomic();

It seems worth mentioning the fact that, AFAICT, this sequence does not
necessarily provide ordering when plain accesses are involved: consider,
e.g., the following variant of the snippet:

	A:*x = 1;
	/*
	 * I've "ignored" the syscall, which should provide
	 * (at least) a compiler barrier...
	 */
	atomic_inc(u);
	smp_mb__after_atomic();
	B:r0 = *y;

On x86, AFAICT, the compiler can do this:

	atomic_inc(u);
	A:*x = 1;
	smp_mb__after_atomic();
	B:r0 = *y;

(the implementation of atomic_inc() contains no compiler barrier), then
the CPU can "reorder" A and B (smp_mb__after_atomic() being #defined to
a compiler barrier).

The mips implementation seems also affected by such "reorderings": I am
not familiar with this implementation but, AFAICT, it does not enforce
ordering from A to B in the following snippet:

	A:*x = 1;
	atomic_inc(u);
	smp_mb__after_atomic();
	B:WRITE_ONCE(*y, 1);

when CONFIG_WEAK_ORDERING=y, CONFIG_WEAK_REORDERING_BEYOND_LLSC=n.

Do these observations make sense to you?  Thoughts?

  Andrea
