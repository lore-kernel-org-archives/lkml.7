Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B04021841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfI0PGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfI0PGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:06:50 -0400
Received: from oasis.local.home (unknown [65.39.69.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504942146E;
        Fri, 27 Sep 2019 15:06:48 +0000 (UTC)
Date:   Fri, 27 Sep 2019 11:06:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tracing/probe: Test nr_args match in looking for same
 probe events
Message-ID: <20190927105019.661591cd@oasis.local.home>
In-Reply-To: <20190927131458.GA19008@linux.vnet.ibm.com>
References: <20190927055035.4c3abae9@oasis.local.home>
        <20190927131458.GA19008@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 19:08:53 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
\> > ---
> >  kernel/trace/trace_kprobe.c | 2 ++
> >  kernel/trace/trace_uprobe.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 402dc3ce88d3..d2543a403f25 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -537,6 +537,8 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
> > 
> >  	list_for_each_entry(pos, &tpe->probes, list) {
> >  		orig = container_of(pos, struct trace_kprobe, tp);
> > +		if (orig->tp.nr_args != comp->tp.nr_args)
> > +			continue;  
> 
> This has a side-effect where the newer probe has same argument commands, we
> still end up appending the probe.

??

How so?

If the two have the same number of arguments we do exactly what we did
before this patch. Please explain to me how that side effect would happen?

It basically is doing, "if the two probes do not have the same number
of arguments, don't bother comparing, because they are different."

-- Steve
