Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CEC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B432133F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 15:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfFWPPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 11:15:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43227 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726429AbfFWPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 11:15:08 -0400
Received: (qmail 25897 invoked by uid 500); 23 Jun 2019 11:15:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jun 2019 11:15:06 -0400
Date:   Sun, 23 Jun 2019 11:15:06 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Akira Yokosawa <akiyks@gmail.com>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
In-Reply-To: <91a9c6f8-7bbf-376d-b1e0-0e2693c84ee8@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1906231112300.24649-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019, Akira Yokosawa wrote:

> Hi Paul and Alan,
> 
> On 2019/06/22 8:54, Paul E. McKenney wrote:
> > On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> >> On Fri, 21 Jun 2019, Andrea Parri wrote:
> >>
> >>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> >>>> Herbert Xu recently reported a problem concerning RCU and compiler
> >>>> barriers.  In the course of discussing the problem, he put forth a
> >>>> litmus test which illustrated a serious defect in the Linux Kernel
> >>>> Memory Model's data-race-detection code.
> 
> I was not involved in the mail thread and wondering what the litmus test
> looked like. Some searching of the archive has suggested that Alan presented
> a properly formatted test based on Herbert's idea in [1].
> 
> [1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/

Yes, that's it.  The test is also available at:

https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus

Alan

> If this is the case, adding the link (or message id) in the change
> log would help people see the circumstances, I suppose.
> Paul, can you amend the change log?
> 
> I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
> confirmed that this patch fixes the result.
> 
> So,
> 
> Tested-by: Akira Yokosawa <akiyks@gmail.com>
> 
>         Thanks, Akira

