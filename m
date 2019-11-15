Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4821E206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKONaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfKONaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:30:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2422C206CC;
        Fri, 15 Nov 2019 13:30:02 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:30:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of
 buffer_size_kb
Message-ID: <20191115083000.76f89785@gandalf.local.home>
In-Reply-To: <20191115042428.6xxiqbzhgoko6vyk@ubuntu1804-desktop>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
        <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
        <20191113113730.213ddd72@gandalf.local.home>
        <20191114202059.GC186056@google.com>
        <20191114163639.4727e3ed@gandalf.local.home>
        <20191115042428.6xxiqbzhgoko6vyk@ubuntu1804-desktop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 23:24:28 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> On Thu, Nov 14, 2019 at 04:36:39PM -0500, Steven Rostedt wrote:
> > On Thu, 14 Nov 2019 15:20:59 -0500
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >   
> > > On Wed, Nov 13, 2019 at 11:37:30AM -0500, Steven Rostedt wrote:  
> > > > On Wed, 13 Nov 2019 11:32:36 -0500
> > > > "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:    
> > > [snip]  
> > > > > +
> > > > > +        The number of pages allocated for each CPU buffer may not
> > > > > +        be the same than the round up of the division:
> > > > > +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> > > > > +        used to store a page header with metadata. E.g. with
> > > > > +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> > > > > +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> > > > > +        page header with metadata) the number of pages allocated for each
> > > > > +        CPU buffer is 1029, not 1024. The formula for calculating the
> > > > > +        number of pages allocated for each CPU buffer is the round up of:
> > > > > +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).    
> > > > 
> > > > I have no problem with this patch, but the concern of documenting the
> > > > implementation here, which will most likely not be updated if the
> > > > implementation is ever changed, which is why I was vague to begin with.
> > > > 
> > > > But it may never be changed as that code has been like that for a
> > > > decade now.    
> > > 
> > > Agreed. To give some context, Frank is an outreachy intern I am working with and
> > > one of his starter tasks was to understand the ring buffer's basics.  I asked
> > > him to send a patch since I thought he mentioned there was an error in the
> > > documnentation. It looks like all that was missing is some explanation which
> > > the deleted text in brackets above should already cover.
> > >   
> 
> Not exactly in my opinion ;) The deleted text was not the problem. I
> just deleted it because with the added text it turns to be redundant.
> 
> The issue that I found with the documentation (maybe just to my
> newbie's eyes) is in this part:
> 
> "The trace buffers are allocated in pages (blocks of memory that the
> kernel uses for allocation, usually 4 KB in size). If the last page
> allocated has room for more bytes than requested, the rest of the
> page will be used, making the actual allocation bigger than requested
> or shown."
> 
> For me that "suggests" the interpretation that the number of pages
> allocated in the current implementation correspond with the round
> integer division of buffer_size_kb / PAGE_SIZE, which is inaccurate
> (for 5 pages in the example that I mentioned).

If you would like, you could reword that to something more accurate,
but still not detailing the implementation.

> Understood and agreed. It is funny that what I spotted as "a problem"
> was precisely an incomplete description of the implementation (the
> sentences that I quoted above). What do you think about removing
> those two sentences?

I wouldn't remove them, just reword them to something you find more
accurate.

-- Steve
