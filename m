Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF45C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66DA2147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aXLKdbeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfDMVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:39:57 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:33885 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDMVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:39:57 -0400
Received: by mail-wm1-f43.google.com with SMTP id r186so3089370wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NltJFvUkFPAAEBpx8MoWkiwpJTDuphCP3bx5XvrZP7s=;
        b=aXLKdbeTCvGr/lEtbI6JMmCjNrOejt5N5HmOsXcOJxCEyic3KgkXXPrjYZqGL3lFR1
         wEsSIxnRvdtLcZadA8G43DJxFqKLxKoqtBUiQdp3QoB6NiPjjVFjxMQTo+iHUv373wC4
         lN8KfHDTdXbfTvw+P/lSX9DDjb2zCpiDZKqCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NltJFvUkFPAAEBpx8MoWkiwpJTDuphCP3bx5XvrZP7s=;
        b=aTujLgIcb+5Lz1p+coJMfI7Wp44o7UW8ngn3sVqp/Lv44Ei07kiGCWqEe8u48aPi6K
         C6kaiy44H9+6WEqnP49TTdZEfRkleWwXgl2xI0md3me01FTKGKFDDyVq5K08lzVdcCSs
         +IJm+LB2tIX9DNFPDUXFNgTwftshE0jq8aCRrmutopRJuoi8DthSQif8TWh3ITeC7Kbu
         Sog5dnsSA191eevZYsj+Ew9ngAmAVRzg4Rvbc1+U09E68bnkKTi0qxxoFVOiBGGnSudr
         rMF3SYR8z6FWBuaxAh69/1t1TIjOImRyUfBuy957GQqmb3k95TyQ2budw0ykgy9V804f
         jrDQ==
X-Gm-Message-State: APjAAAX6Ml0kglwIvBfcS28jGK7rFyX8D+SMmejaAdJYRrV937ZQaOux
        Xs8LwAJItAW8q0Yrn9HSihLreQ==
X-Google-Smtp-Source: APXvYqy/37K5acMZSqsgWvEHj0N6hTdMO66EnuWu0i4yTK9RgfuG5ge2kwdLlLDG7XFstiEvRpriHQ==
X-Received: by 2002:a1c:ed12:: with SMTP id l18mr15142977wmh.13.1555191594698;
        Sat, 13 Apr 2019 14:39:54 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id r6sm39782225wrt.38.2019.04.13.14.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 14:39:53 -0700 (PDT)
Date:   Sat, 13 Apr 2019 23:39:38 +0200
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
Message-ID: <20190413213938.GA4371@andrea>
References: <20190408055117.GA25135@andrea>
 <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
 <20190409013618.GA3824@andrea>
 <20190409150132.GB14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409150132.GB14111@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 08:01:32AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 09, 2019 at 03:36:18AM +0200, Andrea Parri wrote:
> > > > The formula was more along the line of "do not assume either of these
> > > > cases to hold; use barrier() is you need an unconditional barrier..."
> > > > AFAICT, all current implementations of smp_mb__{before,after}_atomic()
> > > > provides a compiler barrier with either barrier() or "memory" clobber.
> > > 
> > > Well, we have two reasonable choices: Say that 
> > > smp_mb__{before,after}_atomic will always provide a compiler barrier, 
> > > or don't say this.  I see no point in saying that the combination of 
> > > Before-atomic followed by RMW provides a barrier.
> > 
> > ;-/ I'm fine with the first choice. I don't see how the second choice
> > (this proposal/patch) would be consistent with some documentation and
> > with the current implementations; for example,
> > 
> > 1) Documentation/atomic_t.txt says:
> > 
> > Thus:
> > 
> >   atomic_fetch_add();
> > 
> > is equivalent to:
> > 
> >   smp_mb__before_atomic();
> >   atomic_fetch_add_relaxed();
> >   smp_mb__after_atomic();
> > 
> > [...]
> > 
> > 2) Some implementations of the _relaxed() variants do not provide any
> > compiler barrier currently.
> 
> But don't all implementations of smp_mb__before_atomic() and
> smp_mb__after_atomic() currently supply a compiler barrier?

Yes, AFAICS, all implementations of smp_mb__{before,after}_atomic() currently
supply a compiler barrier.

Nevertheless, there's a difference between:  (1) Specify that these barriers
supply a compiler barrier,  (2) Specify that (certain) combinations of these
barriers and RMWs supply a compiler barrier, and  (3) This patch...  ;-)

FWIW, I'm not aware of current/informal documentation following (the arguably
simpler but slightly stronger) (1).  But again (amending my last remark): (1)
and (2) both make sense to me.

Thanx,
  Andrea


> 
> 							Thanx, Paul
> 
