Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED77B20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cq9IUKye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfDSTWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:22:53 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:32914 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfDSTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:22:51 -0400
Received: by mail-wr1-f48.google.com with SMTP id k1so6804992wrw.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DK/hOEW24v0GxNzxYUXf8lPL5ZqO1QoA1w+S6eYUn3M=;
        b=cq9IUKyeCr/KgwR2dnLPTFU9WsbCvcKamq2zHv0If8oLJrBZLJ2xt3aozNkOxAaYNX
         eBrQKkNleRDM8b0j3rspK89TPfW0WPlrXV3RnL6jLtwoceS/UlaiUNGnLkAmwsWSxDdn
         vfvPtlGfDgBBucMuvrCDNa+4Keljkm7EhJ/kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DK/hOEW24v0GxNzxYUXf8lPL5ZqO1QoA1w+S6eYUn3M=;
        b=MICX/yvS7Kxuo9/i/SxQiHyi+VUUm4cS38bhMrLpmJXmw4kKJ9R3z/csBe5c1pGAtb
         TM9PdPRiR7V26v8rMhTRymhEG6l3KPQcDOxOSSKnsYA9++obdjdXW/ZkeMCrOGIiue5u
         68rj2PudwpR1JA8PJsYAFy9wPhr39cTCXs50Rvbf2z5hjOaOApBCKjG3i03fkXTm8WHq
         MtG83Qtpedmso5So35fdG3E+efN4zXrduwtC4tm8OJKxbzUZPzS/t+MmixLhLtgmesRq
         UU0NOyO5mnhJF/5/JtEioUlQnQqTQLYcpzt+YDQ2nGJ92tWh3vQX/GBBPzSxH46M9nOb
         vAVw==
X-Gm-Message-State: APjAAAVUyEzuDs2JwkfDVZ3c+3/w7f7WMnKcLJhfnkqTx3KXAXffDjLK
        vPl0yNwRYWUl6k62gE4dp9bmDbznui6VHQ==
X-Google-Smtp-Source: APXvYqyWH0gBbmTgFqbh28TeqZSJRt7eNOS3YzTUEfB3hYWkqbNPdNLavVWj9TdCErNN3ntlhXLyHg==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr3828758wrs.241.1555691868685;
        Fri, 19 Apr 2019 09:37:48 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id a11sm3776023wmm.35.2019.04.19.09.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 09:37:47 -0700 (PDT)
Date:   Fri, 19 Apr 2019 18:37:37 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20190419163737.GA8690@andrea>
References: <20190418125412.GA10817@andrea>
 <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
 <20190419005302.GA5311@andrea>
 <20190419124720.GU14111@linux.ibm.com>
 <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     (1) The compiler can reorder the load from a to precede the
> > +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
> > +     compiler barrier, the CPU can reorder the preceding store to
> > +     obj->dead with the later load from a.
> > +
> > +     This could be avoided by using READ_ONCE(), which would prevent the
> > +     compiler from reordering due to both atomic_dec() and READ_ONCE()
> > +     being volatile accesses, and is usually preferable for loads from
> > +     shared variables.  However, weakly ordered CPUs would still be
> > +     free to reorder the atomic_dec() with the load from a, so a more
> > +     readable option is to also use smp_mb__after_atomic() as follows:
> > +
> > +	WRITE_ONCE(obj->dead, 1);
> > +	smp_mb__before_atomic();
> > +	atomic_dec(&obj->ref_count);
> > +	smp_mb__after_atomic();
> > +	r1 = READ_ONCE(a);
> 
> The point here is not just "readability", but also the portability of the
> code, isn't it?

The implicit assumption was, I guess, that all weakly ordered CPUs which
are free to reorder the atomic_dec() with the READ_ONCE() execute a full
memory barrier in smp_mb__before_atomic() ...  This assumption currently
holds, AFAICT, but yes: it may well become "non-portable"! ... ;-)

  Andrea
