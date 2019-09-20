Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568994869;
	bh=JB/KlavkKYyb6cShAWrH8NzqXSYVIlW2OW86Y+sEVJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mL1aI3UgZdc5ye1rjE0eBbJLoCyp961ztUXS1tuv8n3VCGqe2MbOp2pTBt74MUHjs
	 3X7YX3kyr1qwahY92mcT5RkItzurzg5srwEMJHcTk4BOoCe/axQtDifpHkIhz7bHas
	 t9w09OAhzjoe7/Ta2QQ1kJId/3jVHYP+k00qPUrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbfITPy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404729AbfITPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:54:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444BE2086A;
        Fri, 20 Sep 2019 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568994867;
        bh=JB/KlavkKYyb6cShAWrH8NzqXSYVIlW2OW86Y+sEVJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbTzVipQPKINemMAWxR+AAOssChAagB9KRceRQ8GEXxOAeb2qRyxDif3CLPBDf1KH
         jL28zQC3QpkSwJaIj5BP9MnJ0GCXR4y+pUaFF3ZVzHBTFaKO097I9FvQ+LHhv9/0Qp
         PLyFaIaqTwkHIPQ/RQjKcMXECZCek5yRZ8OsZKY0=
Date:   Fri, 20 Sep 2019 16:54:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> We would like to share a new data-race detector for the Linux kernel:
> Kernel Concurrency Sanitizer (KCSAN) --
> https://github.com/google/ktsan/wiki/KCSAN  (Details:
> https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> 
> To those of you who we mentioned at LPC that we're working on a
> watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> renamed it to KCSAN to avoid confusion with KTSAN).
> [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf

Oh, spiffy!

> In the coming weeks we're planning to:
> * Set up a syzkaller instance.
> * Share the dashboard so that you can see the races that are found.
> * Attempt to send fixes for some races upstream (if you find that the
> kcsan-with-fixes branch contains an important fix, please feel free to
> point it out and we'll prioritize that).

Curious: do you take into account things like alignment and/or access size
when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially prune
naturally aligned accesses for which __native_word() is true?

> There are a few open questions:
> * The big one: most of the reported races are due to unmarked
> accesses; prioritization or pruning of races to focus initial efforts
> to fix races might be required. Comments on how best to proceed are
> welcome. We're aware that these are issues that have recently received
> attention in the context of the LKMM
> (https://lwn.net/Articles/793253/).

This one is tricky. What I think we need to avoid is an onslaught of
patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
code being modified. My worry is that Joe Developer is eager to get their
first patch into the kernel, so runs this tool and starts spamming
maintainers with these things to the point that they start ignoring KCSAN
reports altogether because of the time they take up.

I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
to have a comment describing the racy access, a bit like we do for memory
barriers. Another possibility would be to use atomic_t more widely if
there is genuine concurrency involved.

> * How/when to upstream KCSAN?

Start by posting the patches :)

Will
