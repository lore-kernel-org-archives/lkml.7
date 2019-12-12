Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29724C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EE021655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfLLR1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:27:11 -0500
Received: from foss.arm.com ([217.140.110.172]:54500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfLLR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:27:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97AE30E;
        Thu, 12 Dec 2019 09:27:09 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89DEB3F6CF;
        Thu, 12 Dec 2019 09:27:08 -0800 (PST)
Date:   Thu, 12 Dec 2019 17:27:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        sgrover@codeaurora.org, kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: KCSAN Support on ARM64 Kernel
Message-ID: <20191212172705.GI46910@lakrids.cambridge.arm.com>
References: <000001d5824d$c8b2a060$5a17e120$@codeaurora.org>
 <CACT4Y+aAicvQ1FYyOVbhJy62F4U6R_PXr+myNghFh8PZixfYLQ@mail.gmail.com>
 <CANpmjNOx7fuLLBasdEgnOCJepeufY4zo_FijsoSg0hfVgN7Ong@mail.gmail.com>
 <20191014101938.GB41626@lakrids.cambridge.arm.com>
 <0101016efaeb3a3b-81a8c0fa-c656-4f95-9864-c7f4573024fd-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016efaeb3a3b-81a8c0fa-c656-4f95-9864-c7f4573024fd-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

In future *please* reply in plaintext rather than HTML.

On Thu, Dec 12, 2019 at 04:22:30PM +0000, Mukesh Ojha wrote:
> On 10/14/2019 3:49 PM, Mark Rutland wrote:
> > Once the core kcsan bits are ready, I'll rebase the arm64 patch atop.
> > I'm expecting some things to change as part of review, so it'd be great
> > to see that posted ASAP.
> > 
> > For arm64 I'm not expecting major changes (other than those necessary to
> > handle the arm64 atomic rework that went in to v5.4-rc1)
> 
> Hi Mark,
> 
> Are the below patches enough for kcsan to be working on arm64 ?

That depends on what branch you're using as a base. My arm64/kcsan
branch worked for me as-is, but as I mentioned that was /very/ noisy.
Both the kcsan code and the arm64 code have moved on since then, and I
have no idea how well that would backport.

I had a quick go at porting my arm64 patch atop the kcsan branch in
Paul's tree, and that doesn't get as far as producing earlycon output,
so more work will be necessary to investigate and debug that.

I hope to look at that, but I don't think I'll have the chance to do so
before the end of next week.

> I am not sure about the one you are mentioning about "atomic rework patches
> which went in 5.4 rc1" .

There were a number of patches from Andrew Murray reworking the arm64
atomic implementation. See:

$ git log v5.3..v5.4-rc1 --author='Andrew Murray' -- arch/arm64

With those patches applied, my change to arch/arm64/lib/Makefile is
unnecessary and can be dropped.

Thanks,
Mark.

> 2019-10-03 	arm64, kcsan: enable KCSAN for arm64 <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=ae1d089527027ce710e464105a73eb0db27d7875>arm64/kcsan <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/kcsan>
> 	Mark Rutland 	5 	-1/+5
> 
> 	
> 	
> 	
> 	
> 2019-09-24 	locking/atomics, kcsan: Add KCSAN instrumentation <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=8b3b76ec443b9af7e55994a163bb6f4aee016f09>
> 	Marco Elver 	2 	-2/+199
> 2019-09-24 	asm-generic, kcsan: Add KCSAN instrumentation for bitops <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=50c23ad00c040927e71c8943d4eb7d52e9f77762>
> 	Marco Elver 	1 	-0/+18
> 2019-09-24 	seqlock, kcsan: Add annotations for KCSAN <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=e2b32e1a3b397bffcb6afbe86f6fe55e2040a34a>
> 	Marco Elver 	1 	-5/+42
> 2019-09-24 	build, kcsan: Add KCSAN build exceptions <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=35a907033244099a71f17d28e9ffaca92f714463>
> 	Marco Elver 	3 	-0/+17
> 2019-09-24 	objtool, kcsan: Add KCSAN runtime functions to whitelist <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=3afc592ca7ebd9c13c939c98b995763345e85e08>
> 	Marco Elver 	1 	-0/+17
> 2019-09-24 	kcsan: Add Kernel Concurrency Sanitizer infrastructure <https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=73d893b441dc3e5c1645884a19b46a1bfd4fd692>
> 	Marco Elver
> 
