Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81BEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BFB20652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556529874;
	bh=q3YiTWs50dMDTd8JeYCZknpgHRHn8ZwgqhXR1mTJh2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KmX2OWvfc0whoeP+ULxK5U/Ki+PmN0mZld2TKBtvSOS8s3RPXIU7J/QgCLI0wWXpr
	 FCZCuAdWWBTJB8bx6r3bylHM2e3uKun4AAc/mMtBh9DNFD6JM5lX3mfbK4T2KjK77j
	 sJCEAHRJ1HAa0IspZNURiHKFuy0C65bh4x7NCAeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfD2JYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:24:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41614 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfD2JYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:24:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so8665765lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEJdVdZWdwXAxOfDG1xY+PigwDXCpbRA1Hg7zPvHQ6o=;
        b=GfK54Lv/zee/iL/t0fBaNmTn1PaER5zOFF3h0Rm87LybGU/LKBCEUkaTuNLGalSbvH
         4mXPPxkhm9xleq3lbC+2H5hJgOdVjncpv3BzCzkSvC+omW2zCYZHcAW7J/TLj2EfU4S+
         fxPe0Z10WvsI6TLlWoOKOQAWtpZ4f9qAqt7KPQL0pN/jhKBCviCCVkwB3S8+KneUhH4T
         AjBOJKL1odaHVroPx7VPIXkm0c/J7TyhCoUrGRw1DHXKzGTZ1xxiob0zcRBvKVO+wFlZ
         gxoFjNmM24u+MEclGj8xj0YxPiOmgP6zMIcwmBHFwPYU6i0ttMlGFYO4Fndlt5aUvK/i
         haEQ==
X-Gm-Message-State: APjAAAXKDl2ZA7+sYvx3gTaZLgz2GajB2Mmhzqdkob1zyELSIaTi+nwD
        6qnbDymhg5peYzYuEydbQ5A=
X-Google-Smtp-Source: APXvYqzsqbzql/ON6mGxvxLdcdKbXtmXtfv8yW22ez3OOAx0jNgFhKSpru3mC40b/etESjF56kkX1g==
X-Received: by 2002:a2e:3815:: with SMTP id f21mr9029618lja.25.1556529870868;
        Mon, 29 Apr 2019 02:24:30 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m28sm7242040lfc.71.2019.04.29.02.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 02:24:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hL2WU-0002zz-Pi; Mon, 29 Apr 2019 11:24:30 +0200
Date:   Mon, 29 Apr 2019 11:24:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20190429092430.GF26546@localhost>
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
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:30:10AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 23, 2019 at 02:32:09PM +0200, Peter Zijlstra wrote:
> > On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:

> > > 	And lock acquisition??? acm_read_bulk_callback().
> > 
> > I think it goes with the set_bit() earlier, but what do I know.
> 
> Quite possibly!  In that case it should be smp_mb__after_atomic(),
> and it would be nice if it immediately followed the set_bit().

I noticed this one last week as well. The set_bit() had been incorrectly
moved and without noticing the smp_mb__before_atomic(). I've submitted a
patch to restore it and to fix a related issue to due missing barriers:

	https://lkml.kernel.org/r/20190425160540.10036-5-johan@kernel.org

Johan
