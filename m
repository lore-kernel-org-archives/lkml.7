Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB1C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B067C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfGJPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGJPgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:36:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979A320844;
        Wed, 10 Jul 2019 15:36:10 +0000 (UTC)
Date:   Wed, 10 Jul 2019 11:36:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     tglx@linutronix.de, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, sboyd@codeaurora.org,
        john.stultz@linaro.org, chang-an.chen@mediatek.com,
        mingo@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: sched_clock and device suspend/resume
Message-ID: <20190710113609.7b63c5d6@gandalf.local.home>
In-Reply-To: <1d6ef4687c87dd4d2ec88d0d593a9c1d@codeaurora.org>
References: <1d6ef4687c87dd4d2ec88d0d593a9c1d@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Resending as your Cc was screwed up and caused my reply to mess up
  the Cc list ]

On Wed, 10 Jul 2019 08:20:37 -0700
Sodagudi Prasad <psodagud@codeaurora.org> wrote:

> Another option is printing the epoch/cycles information in every print 
> statement similar to thread id or processor id added 
> recently(CONFIG_PRINTK_CALLER). This can be avoided if we start 
> accounting suspend time in sched_clock.

Or another option is add a new clock that printk and tracing can use.
tracing already can switch between clocks trivially.

sched_clock_continuous() ? (I know, horrible name), that simply keeps
track of the time delta at suspend and returns:

	sched_clock() + delta;

This will prevent other issues happening by modifying sched_clock(),
specifically, screwing up the scheduler (what sched_clock()'s main
purpose is for). We don't want the scheduler to think that a process
was running for hours when it has spent most of that time in the
suspend state. Which is probably your answer to why it was designed
that way.

-- Steve
