Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDWKW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:22:58 -0400
Received: from foss.arm.com ([217.140.101.70]:53430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWKW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:22:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5129374;
        Tue, 23 Apr 2019 03:22:57 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5643F557;
        Tue, 23 Apr 2019 03:22:55 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:22:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190423102250.GA56999@lakrids.cambridge.arm.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:37:51AM -0700, Dhaval Giani wrote:
> Hi Folks,
> 
> This is a call for participation for the Linux Testing microconference
> at LPC this year.
> 
> For those who were at LPC last year, as the closing panel mentioned,
> testing is probably the next big push needed to improve quality. From
> getting more selftests in, to regression testing to ensure we don't
> break realtime as more of PREEMPT_RT comes in, to more stable distros,
> we need more testing around the kernel.
> 
> We have talked about different efforts around testing, such as fuzzing
> (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> testing, test frameworks such as ktests, smatch to find bugs in the
> past. We want to push this discussion further this year and are
> interested in hearing from you what you want to talk about, and where
> kernel testing needs to go next.

I'd be interested to discuss what we could do with annotations and
compiler instrumentation to make the kernel more amenable to static and
dynamic analysis (and to some extent, documenting implicit
requirements).

One idea that I'd like to explore in the context of RT is to annotate
function signatures with their required IRQ/preempt context, such that
we could dynamically check whether those requirements were violated
(even if it didn't happen to cause a problem at that point in time), and
static analysis would be able to find some obviously broken usage. I had
some rough ideas of how to do the dynamic part atop/within ftrace. Maybe
there are similar problems elsewhere.

I know that some clang folk were interested in similar stuff. IIRC Nick
Desaulniers was interested in whether clang's thread safety analysis
tooling could be applied to the kernel (e.g. based on lockdep
annotations).

Thanks,
Mark.
