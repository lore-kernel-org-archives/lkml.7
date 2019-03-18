Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC2520863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCRNyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfCRNyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:54:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D5B20857;
        Mon, 18 Mar 2019 13:54:38 +0000 (UTC)
Date:   Mon, 18 Mar 2019 09:54:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] tracing: kdb: Allow ftdump to skip all but the
 last few entries
Message-ID: <20190318095436.7f09a371@gandalf.local.home>
In-Reply-To: <20190318030238.GD27232@oak.lan>
References: <20190315230906.250598-1-dianders@chromium.org>
        <20190315230906.250598-3-dianders@chromium.org>
        <20190318030238.GD27232@oak.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 03:02:38 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > index 4b666643d69f..996e1e9cd9a6 100644
> > --- a/kernel/trace/trace_kdb.c
> > +++ b/kernel/trace/trace_kdb.c
> > @@ -39,7 +39,8 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
> >  	/* don't look at user memory in panic mode */
> >  	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
> >  
> > -	kdb_printf("Dumping ftrace buffer:\n");
> > +	kdb_printf("Dumping ftrace buffer (skipping %d entries):\n",
> > +		   skip_entries);  
> 
> If someone *doesn't* need to skip any entries I'm not a fan of telling
> them we are "skipping 0 entries"; it is more unnerving than helpful
> ("huh? what does it need to tell me that no entried were skipped?
> what makes the tracer skip entries?... Doh... I get it").

I agree.

Probably best to have this:

	kdb_printf("Dumping ftrace buffer:\n");
	if (skip_entries)
		kdb_printf("(skipping %d entries)\n", skip_entries);

No reason to inject that skipping line in the first line.

-- Steve
