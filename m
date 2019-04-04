Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC03EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A582C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDDQX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:23:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:23:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hC59a-0005f2-1o; Thu, 04 Apr 2019 18:23:50 +0200
Date:   Thu, 4 Apr 2019 18:23:50 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [RFC PATCH v9 02/13] x86: always set IF before oopsing from page
 fault
Message-ID: <20190404162349.rvkaozmtozamdoar@linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <e6c57f675e5b53d4de266412aa526b7660c47918.1554248002.git.khalid.aziz@oracle.com>
 <CALCETrXvwuwkVSJ+S5s7wTBkNNj3fRVxpx9BvsXWrT=3ZdRnCw@mail.gmail.com>
 <20190404013956.GA3365@cisco>
 <CALCETrVp37Xo3EMHkeedP1zxUMf9og=mceBa8c55e1F4G1DRSQ@mail.gmail.com>
 <20190404154727.GA14030@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404154727.GA14030@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- stepping on del button while browsing though CCs.
On 2019-04-04 09:47:27 [-0600], Tycho Andersen wrote:
> > Hmm.  do_exit() isn't really meant to be "try your best to leave the
> > system somewhat usable without returning" -- it's a function that,
> > other than in OOPSes, is called from a well-defined state.  So I think
> > rewind_stack_do_exit() is probably a better spot.  But we need to
> > rewind the stack and *then* turn on IRQs, since we otherwise risk
> > exploding quite badly.
> 
> Ok, sounds good. I guess we can include something like this patch in
> the next series.

The tracing infrastructure probably doesn't know that the interrupts are
back on. Also if you were holding a spin lock then your preempt count
isn't 0 which means that might_sleep() will trigger a splat (in your
backtrace it was zero).

> Thanks,
> 
> Tycho
Sebastian
