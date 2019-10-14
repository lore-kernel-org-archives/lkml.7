Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDACC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDBE20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbfJNMvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:51:19 -0400
Received: from foss.arm.com ([217.140.110.172]:43102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbfJNMvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:51:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43A16337;
        Mon, 14 Oct 2019 05:51:18 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75F2B3F68E;
        Mon, 14 Oct 2019 05:51:17 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:51:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
Message-ID: <20191014125115.GA19200@arrakis.emea.arm.com>
References: <20191014022633.GA6430@mit.edu>
 <20191014070312.GA3327@iMac-3.local>
 <20191014115021.GA5564@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014115021.GA5564@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 07:50:21AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 14, 2019 at 08:03:14AM +0100, Catalin Marinas wrote:
> > Thanks for the report. I have a fix already:
> > 
> > http://lkml.kernel.org/r/20191004134624.46216-1-catalin.marinas@arm.com
> > 
> > I was hoping Andrew had sent it to Linus before -rc3 but it doesn't seem
> > to be in mainline yet.
> 
> Thanks for the pointer to the fix!  Does that mean that the workaround
> is to increase the kmemleak pool size?  I had been using the default
> (16000) and it seems surprising that that it wasn't enough to even get
> the kernel through a standard boot sequence.  Should we perhaps
> increase the default mempool size?

In your case, CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y, so it disables itself
irrespective of the pool size and trips over the bug. Even with default
off, it still involves the clean-up since kmemleak needs to track early
allocations in case it is turned on by the kmemleak=on cmdline option.

So I think 16000 is sufficient in your case, the default-off triggered
the bug (well, unless you find in the logs "kmemleak: Memory pool empty,
consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE").

-- 
Catalin
