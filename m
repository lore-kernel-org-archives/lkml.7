Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41AFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5C5206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLRR7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfLRR7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:59:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFF62064B;
        Wed, 18 Dec 2019 17:59:43 +0000 (UTC)
Date:   Wed, 18 Dec 2019 12:59:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>
Subject: Re: ftrace trace_raw_pipe format
Message-ID: <20191218125941.3845add7@gandalf.local.home>
In-Reply-To: <3df0aa9c69ec4d2086b96eb032a1a0df@AcuMS.aculab.com>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
        <20191217173403.61f4e2d8@gandalf.local.home>
        <3df0aa9c69ec4d2086b96eb032a1a0df@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 17:28:13 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 17 December 2019 22:34
> >  
> > > I'm trying to 'grok' the trace_raw_pipe data that ftrace generates.
> > > I've some 3rd party code that post-processes it, but doesn't like wrapped traces
> > > because (I think) the traces from different cpus start at different times.
> > >
> > > I can't seem to find any documentation at all...  
> ...
> > You may want to use libtraceevent (which will, hopefully, soon
> > be in debian!). Attached is a simple program that reads the data using
> > it and prints out the format.  
> 
> The problem is that I don't want to print the trace, I want to fix
> some trace files so that another program doesn't barf at them.

It's not just for printing. It allows you to read the buffers and do
whatever you want with the data. Look at the kbuffer code. It's the way
to get the raw event data with the time stamps attached to them. The
kbuffer part (see kbuffer.h) processes the meta data in the
trace-pipe-raw file, and hands you the raw data that's there.

The libtraceevent is mainly to parse the format files of the events, to
know how to read the data (see the my_sched_switch() code of the second
version of my sample program). As the format files describe the binary
layout of the raw event data. Yes, this program prints the data, but it
could be easily modified to convert the data into a different format.

> 
> I guess I can try to reverse engineer the library code.

You shouldn't have to reverse engineer the code. If it's not what you
need, let me know exactly what you want, and we can add to it. The
reason I created libtraceevent, is to get rid of all the duplicate code
that's out there toady.

> 
> It would also be nice if there was a way that some standard program
> (like cat) could read out the trace files without blocking at the end
> when the trace is inactive.
> 

It shouldn't be hard to add a trace option to the kernel, to do that.

-- Steve
