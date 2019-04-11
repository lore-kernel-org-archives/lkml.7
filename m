Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86008C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE08218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKDJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfDKDJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:09:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D8C20818;
        Thu, 11 Apr 2019 03:09:35 +0000 (UTC)
Date:   Wed, 10 Apr 2019 23:09:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190410230933.7d1138b3@oasis.local.home>
In-Reply-To: <20190411030201.uko3njal44w2ea4b@treble>
References: <20190410102754.387743324@linutronix.de>
        <20190410103646.130022106@linutronix.de>
        <20190411030201.uko3njal44w2ea4b@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 22:02:01 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> >  #ifdef CONFIG_STACKTRACE
> > -	struct		 stack_trace stacktrace;
> > -	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> > +	unsigned int	st_len;
> > +	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];  
> 
> nit: st_entries isn't very readable.  Thanks to the magic of compilers,
> the characters are free, so why not call them "stacktrace_entries" and
> "stacktrace_len".

But doesn't that slow down the time it takes to compile?

/me runs...

-- Steve
