Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66434C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3641E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 03:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfCMDZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 23:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCMDZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 23:25:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB2E2173C;
        Wed, 13 Mar 2019 03:25:30 +0000 (UTC)
Date:   Tue, 12 Mar 2019 23:25:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing: kdb: Allow ftdump to skip all but the
 last few lines
Message-ID: <20190312232528.4fa0b806@oasis.local.home>
In-Reply-To: <20190308193205.213659-2-dianders@chromium.org>
References: <20190308193205.213659-1-dianders@chromium.org>
        <20190308193205.213659-2-dianders@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 11:32:05 -0800
Douglas Anderson <dianders@chromium.org> wrote:

> The 'ftdump' command in kdb is currently a bit of a last resort, at
> least if you have lots of traces turned on.  It's going to print a
> whole boatload of lines out your serial port which is probably running
> at 115200.  This could easily take many, many minutes.
> 
> Usually you're most interested in what's at the _end_ of the ftrace
> buffer, AKA what happened most recently.  That means you've got to
> wait the full time for the dump.  The 'ftdump' command does attempt to
> help you a little bit by allowing you to skip a fixed number of lines.
> Unfortunately it provides no way for you to know how many lines you
> should skip.
> 
> Let's do similar to python and allow you to use a negative number to
> indicate that you want to skip all lines except the last few.  This
> allows you to quickly see what you want.

Why not just read how many entries are in the ring buffer and return that?

	cnt = 0;
	for_each_cpu(cpu, tr->tracing_cpumask)
		cnt += ring_buffer_entries_cpu(tr->trace_buffer, cpu);
	return cnt;

The output will print out one entry per line.

-- Steve


> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
