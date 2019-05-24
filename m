Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FCBC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE92177E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfEXDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbfEXDFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:05:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B18B205ED;
        Fri, 24 May 2019 03:05:17 +0000 (UTC)
Date:   Thu, 23 May 2019 23:05:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Divya Indi <divya.indi@oracle.com>
Subject: Re: [RFC] Allowing modules to control tracing subsystem
Message-ID: <20190523230515.01c5f58a@oasis.local.home>
In-Reply-To: <87k1gdezb4.fsf@linux.intel.com>
References: <87h8bvffth.fsf@linux.intel.com>
        <87k1gdezb4.fsf@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2019 08:44:31 +0300
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Hi,
> 
> Felipe Balbi <felipe.balbi@linux.intel.com> writes:

Hi Felipe,

I somehow missed both your original email and this gentle reminder.

> > Hi guys,
> >
> > I've been thinking about turning my f-trace.c USB function [1] into an
> > implementation of the USB Debug Class [2]. In order to support all
> > requests, I would need means to control parts of the tracing subsystem,
> > for example enabling and disabling tracing, flushing the trace buffer,
> > changing trace buffer size, choose which trace events to enable, etc.

I believe a lot of these are already available.

Also note, that Divya made it possible to have your own tracing
instance for a module.

> >
> > Some of those functions (e.g. print_trace_line()) are available for
> > things like trace_kdb.c [3], but they're not available for modules;
> > i.e. they're not exported symbols.
> >
> > This will involve a rather large change to tracing subsystem however we
> > could rely on such infrastructure for remote debugging of e.g. IVIs,
> > phones, etc.
> >
> > The USB Debug Class already predicts the presence of JTAG access and
> > Hardware tracing modules to be exported over USB. It also allows for
> > GDB-type access. Adding our linux kernel tracing would make it into a
> > complete tracing solution.
> >
> > In order to fully support this we would need, not only to expose some
> > internal trace functions for modules, but I suppose the trace format
> > would have to be slightly better defined so that it be decoded remotely
> > give access to vmlinux.
> >
> > What do you guys think about this? Would this be something that folks
> > would be interested in? Currently we can only export ftrace data, not
> > trace events or anything else. Ideally we would export raw trace buffer
> > entries to be decoded at a later moment.
> >

Let me know what changes are needed and we can work something out.

Sorry for the delay, it appears I missed quite a bit of emails in this period :-/


-- Steve

> > cheers
> >
> > [1] https://marc.info/?i=20190321094748.7031-1-felipe.balbi@linux.intel.com
> > [2] https://www.usb.org/sites/default/files/documents/usb_debug_class_rev_1_0_final_0.pdf
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace_kdb.c#n20  
> 
> A gentle reminder here.
> 

