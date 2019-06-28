Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8777C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2412133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF1BHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfF1BHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:07:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C52208E3;
        Fri, 28 Jun 2019 01:07:09 +0000 (UTC)
Date:   Thu, 27 Jun 2019 21:07:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Takeshi Misawa <jeliantsurux@gmail.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix memory leak in tracing_err_log_open()
Message-ID: <20190627210707.49ebbcf1@gandalf.local.home>
In-Reply-To: <20190627210231.07cb24aa@gandalf.local.home>
References: <20190627114116.GA2533@DESKTOP>
        <20190627210231.07cb24aa@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 21:02:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +++ b/kernel/trace/trace.c
> > @@ -7126,12 +7126,24 @@ static ssize_t tracing_err_log_write(struct file *file,
> >  	return count;
> >  }
> >  
> > +static int tracing_err_log_release(struct inode *inode, struct file *file)
> > +{
> > +	struct trace_array *tr = inode->i_private;
> > +
> > +	trace_array_put(tr);
> > +
> > +	if (file->private_data)

Actually, I think it is safer to have the condition be:

	if (file->f_mode & FMODE_READ)

As that would match the open.

Takeshi,

Can you send a v2?

Thanks!

-- Steve

> > +		seq_release(inode, file);
> > +
> > +	return 0;
> > +}
> > +
