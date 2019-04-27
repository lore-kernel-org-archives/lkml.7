Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F01C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45B3206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O3KVfron"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD0IRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:17:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0IRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:17:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so7740411wru.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q01K7Ky4BKJ/pxdXFN5GOUuy31dwR07sCeBMrLpe13Q=;
        b=O3KVfronCxGnoc/6ysQ8EVduLFY9PqpholsaHDl3xJT06oWYf6YKg7ljnf3pzCF8ru
         ByY6OprY6cVjAhe7PzUV6AKfw4cJ4ZUk+keTg/Otef/AplTguh0qSaoqkR0GqbP5stjJ
         NHSYa+9+T1ijrIja3wo07VJ1Littuol91nU40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q01K7Ky4BKJ/pxdXFN5GOUuy31dwR07sCeBMrLpe13Q=;
        b=nco3sSy7QPgpcEMqf/G8jGiio4a8t8YbbBAPxYWStq7vLPE6m+MAYgM62e9k5thzCO
         6wiwX3iwXx5l4A6hGZ4axswXNTRHdA3hq/E8dAJbssG3M6pWD4osYnl0OXJQidWg90RC
         zpzzyc0QFsGq6qF1QLhVbiSjw1Wn+jfHWn6kCbW9aqKIQs2oTCuPq23ul+HKyMPKNgWL
         9tMiptXkjnDCqn5zhpvibEMR64JWMHXkKSEZoLhygF1tN9KmAbCsEwx6tHXnpa9k5+d1
         0rS5bPmoouD5v425jzY4BRUDeHFGUEoLNpldaAwY316Ta3mpFaOazFzw3Oc4efxoAT6z
         aeUA==
X-Gm-Message-State: APjAAAWbtZAbSUI+1k2rhZN7SgYxChsHl5mCctRqPhjIOBmtSSkEcK+d
        etdg8LemfqeSMC5LO/AikGFXRg==
X-Google-Smtp-Source: APXvYqw5nUmpGfAmNdW21afE24x1hPIopVfhjv6eRVtKlTG+NGBG5XejrnLHbMBJP4v+2ueDXcar4w==
X-Received: by 2002:adf:d081:: with SMTP id y1mr6533969wrh.283.1556353066536;
        Sat, 27 Apr 2019 01:17:46 -0700 (PDT)
Received: from andrea (host116-65-dynamic.49-79-r.retail.telecomitalia.it. [79.49.65.116])
        by smtp.gmail.com with ESMTPSA id o16sm24254238wrw.10.2019.04.27.01.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 01:17:45 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:17:38 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190427081738.GA11149@andrea>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423123209.GR4038@hirez.programming.kicks-ass.net>
 <20190423133010.GK3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423133010.GK3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:30:10AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 23, 2019 at 02:32:09PM +0200, Peter Zijlstra wrote:
> > On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> > > 	And atomic_set(): set_preempt_state().	This fails
> > > 	on x86, s390, and TSO friends, does it not?  Or is
> > > 	this ARM-only?	Still, why not just smp_mb() before and
> > > 	after?	Same issue in __kernfs_new_node(), bio_cnt_set(),
> > > 	sbitmap_queue_update_wake_batch(), 
> > > 
> > > 	Ditto for atomic64_set() in __ceph_dir_set_complete().
> > > 
> > > 	Ditto for atomic_read() in rvt_qp_is_avail().  This function
> > > 	has a couple of other oddly placed smp_mb__before_atomic().
> > 
> > That are just straight up bugs. The atomic_t.txt file clearly specifies
> > the barriers only apply to RmW ops and both _set() and _read() are
> > specified to not be a RmW.
> 
> Agreed.  The "Ditto" covers my atomic_set() consternation.  ;-)

I was working on some of these before the Easter break [1, 2]: the plan
was to continue next week, but by addressing the remaining cases with a
conservative s/that barrier/smp_mb at first; unless you've other plans?

  Andrea

[1] http://lkml.kernel.org/r/1555417031-27356-1-git-send-email-andrea.parri@amarulasolutions.com
[2] http://lkml.kernel.org/r/1555404968-39927-1-git-send-email-pbonzini@redhat.com
