Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4899C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38E820857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfCHUT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHUT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:19:57 -0500
Received: from oasis.local.home (unknown [38.98.46.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBD820851;
        Fri,  8 Mar 2019 20:19:55 +0000 (UTC)
Date:   Fri, 8 Mar 2019 15:19:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, Baohong Liu <baohong.liu@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing: kdb: Fix ftdump to not sleep
Message-ID: <20190308151954.224ddca6@oasis.local.home>
In-Reply-To: <20190308193205.213659-1-dianders@chromium.org>
References: <20190308193205.213659-1-dianders@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 11:32:04 -0800
Douglas Anderson <dianders@chromium.org> wrote:

> As reported back in 2016-11 [1], the "ftdump" kdb command triggers a
> BUG for "sleeping function called from invalid context".
> 
> kdb's "ftdump" command wants to call ring_buffer_read_prepare() in
> atomic context.  A very simple solution for this is to add allocation
> flags to ring_buffer_read_prepare() so kdb can call it without
> triggering the allocation error.  This patch does that.
> 
> Note that in the original email thread about this, it was suggested
> that perhaps the solution for kdb was to either preallocate the buffer
> ahead of time or create our own iterator.  I'm hoping that this
> alternative of adding allocation flags to ring_buffer_read_prepare()
> can be considered since it means I don't need to duplicate more of the
> core trace code into "trace_kdb.c" (for either creating my own
> iterator or re-preparing a ring allocator whose memory was already
> allocated).
> 
> NOTE: another option for kdb is to actually figure out how to make it
> reuse the existing ftrace_dump() function and totally eliminate the
> duplication.  This sounds very appealing and actually works (the "sr
> z" command can be seen to properly dump the ftrace buffer).  The
> downside here is that ftrace_dump() fully consumes the trace buffer.
> Unless that is changed I'd rather not use it because it means "ftdump
> | grep xyz" won't be very useful to search the ftrace buffer since it
> will throw away the whole trace on the first grep.  A future patch to
> dump only the last few lines of the buffer will also be hard to
> implement.
> 
> [1] https://lkml.kernel.org/r/20161117191605.GA21459@google.com
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 

Thanks for sending this. I'm currently traveling and also have to get
the merge window patches out, I wont be able to get to these till I
have that settled. If you don't hear from me in a week, please send me
a reminder.

Thanks!

-- Steve
