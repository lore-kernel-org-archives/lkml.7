Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197CDECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CBB20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbfJISIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJISIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:08:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3C820679;
        Wed,  9 Oct 2019 18:08:06 +0000 (UTC)
Date:   Wed, 9 Oct 2019 14:08:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] ftrace: Add an option for tracing console
 latencies
Message-ID: <20191009140804.74d9ab1f@gandalf.local.home>
In-Reply-To: <CAPQh3wP93yF4R4LOabmBf8zqTgM7ZVT=_eZRPwgq5WKEESjnyw@mail.gmail.com>
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
        <20191008220824.7911-5-viktor.rosendahl@gmail.com>
        <20191009141114.GC143258@google.com>
        <CAPQh3wP93yF4R4LOabmBf8zqTgM7ZVT=_eZRPwgq5WKEESjnyw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 16:51:07 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> Apologies, I should have replied there but I have been a bit busy the
> last few days with other topics, and I felt a bit indecisive about
> that point, so I just sloppily addressed the issue in the cover letter
> of this new series:
> 
> "I have retained the fourth patch, although it was suggested that is becoming
> obsolete soon. I have retained it only because I do not know the status of
> the code that will make it obsolete. It's the last patch of the series and
> if there indeed is some code that will remove the latency issues from the
> printk code, then of course it makes sense to drop it. The first three patches
> will work without it."
> 
> I thought that, since it's the last in the series, it would be
> possible for maintainers to just take the first three if the last one
> is not wanted.
> 
> For me it solves a rather important problem though, so if the code
> that will make it obsolete isn't available for some time, then perhaps
> it should be considered as a temporary solution.
> 
> Of course, if there is a commitment to never remove any knobs from
> /sys/kernel/debug/tracing/trace_options, then I can easily understand
> that it's not wanted as a temporary fix.

There isn't quite a commitment to not remove knobs, but if a tool
starts relying on a knob, then, the answer is yes there is :-p

As this will hopefully become something we don't worry about in the
future, I would rather have this be a kernel command line option. This
way, it wont be something that tools can really check for.

If you add a trace_console_latency option to the kernel command line,
we can enable it that way. And then when it becomes obsolete, we can
simply remove it, without breaking any tools.

Would that work for you?

-- Steve
