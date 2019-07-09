Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC90C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D721670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGIPSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfGIPSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:18:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568E02166E;
        Tue,  9 Jul 2019 15:18:35 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190709111833.7fa42a2f@gandalf.local.home>
In-Reply-To: <20190709215124.979ef648aabbae2fc0cd91d3@kernel.org>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
        <20190703140832.GD48312@arrakis.emea.arm.com>
        <20190703102402.1319b928@gandalf.local.home>
        <20190703102504.13344555@gandalf.local.home>
        <20190709215124.979ef648aabbae2fc0cd91d3@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 21:51:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Masami,
> > 
> > If you give me an Acked-by, I'll add it to my tree.  
> 
> Sorry for late reply, but I want to keep the test running right after
> initialization as the first user of kprobes at that timing, since
> other user can start using kprobes right after init_kprobes().
> So this issue must be fixed in moving the init_kprobes() itself
> right after arch_initcall() (and that is subsys_initcall)
> 
> Catalin, Mark, could you ensure the below patch can fix your issue?
> 
> https://lore.kernel.org/lkml/20190625191545.245259106@goodmis.org/
> 
> And if so, Steve, could you push above one (which seems already in your
> tree) to next as a fix?

Bah, I forgot to push. I usually do that right after I send the series.

I just pushed to my for-next branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

Can you see if that fixes the issue. If so, then we don't need to do
anything.

Thanks!

-- Steve
