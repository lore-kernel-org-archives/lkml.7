Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AB120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555471465;
	bh=IuidmULxl+r0vAi+16GzS/I3b50m+3IjshiEXzW3mUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ICs8dYzOEsLBN7PSLPp/qXM2z4ImxO0UfLBNGTwL0fBoOpZgnewswMWnDpT0o85L5
	 lFYbCOD0GHKPwrAZZ0KqXAuIXVutFMIKt4i1g9haO123QlsZiM9z+cTkX6ZMQBaoGw
	 xirdRTBQrZbgS2RGJvL8nu/S116P9/2mRJOw4Zok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfDQDYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:24:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfDQDYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:24:23 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7D8A6B65;
        Wed, 17 Apr 2019 03:24:22 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:24:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] init: Initialize jump labels before command line option
 parsing
Message-Id: <20190416202420.9acb6f56fd10e7f84446e75b@linux-foundation.org>
In-Reply-To: <CABXOdTdSNgEnn+mEk-X5ZWph8rCz+yW7EKiA-GHnZdsBC3rsNg@mail.gmail.com>
References: <155544804466.1032396.13418949511615676665.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20190416164418.3ca1d8cef2713a1154067291@linux-foundation.org>
        <CAPcyv4iJxyiGWqjGKLuRgjr9UgDO9ERSghUi3k597gk=X5votQ@mail.gmail.com>
        <CABXOdTdSNgEnn+mEk-X5ZWph8rCz+yW7EKiA-GHnZdsBC3rsNg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 17:39:03 -0700 Guenter Roeck <groeck@google.com> wrote:

> > > Has it been confirmed that this fixes
> > > mm-shuffle-initial-free-memory-to-improve-memory-side-cache-utilization.patch
> > > on beaglebone-black?
> >
> > This only fixes dynamically enabling the shuffling on 32-bit ARM.
> > Guenter happened to run without the mm-only 'force-enable-always'
> > patch and when he went to use the command line option to enable it he
> > hit the jump-label warning.
> >
> 
> For my part I have not seen the original failure; it seems that the
> kernelci logs are no longer present. As such, I neither know how it
> looks like nor how to (try to) reproduce it. I just thought it might
> be worthwhile to run the patch through my boot tests to see if
> anything pops up. From the feedback I got, though, it sounded like the
> failure is/was very omap2 specific, so I would not be able to
> reproduce it anyway.

hm.  Maybe we forge ahead and see if someone hits the issue who
can work with us on resolving it.  It sounds like the affected population
will be quite small.  But still, ugh :(
