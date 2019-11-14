Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD40D20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNVgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKNVgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:36:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B0920709;
        Thu, 14 Nov 2019 21:36:42 +0000 (UTC)
Date:   Thu, 14 Nov 2019 16:36:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of
 buffer_size_kb
Message-ID: <20191114163639.4727e3ed@gandalf.local.home>
In-Reply-To: <20191114202059.GC186056@google.com>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
        <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
        <20191113113730.213ddd72@gandalf.local.home>
        <20191114202059.GC186056@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 15:20:59 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Nov 13, 2019 at 11:37:30AM -0500, Steven Rostedt wrote:
> > On Wed, 13 Nov 2019 11:32:36 -0500
> > "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:  
> [snip]
> > > +
> > > +        The number of pages allocated for each CPU buffer may not
> > > +        be the same than the round up of the division:
> > > +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> > > +        used to store a page header with metadata. E.g. with
> > > +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> > > +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> > > +        page header with metadata) the number of pages allocated for each
> > > +        CPU buffer is 1029, not 1024. The formula for calculating the
> > > +        number of pages allocated for each CPU buffer is the round up of:
> > > +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).  
> > 
> > I have no problem with this patch, but the concern of documenting the
> > implementation here, which will most likely not be updated if the
> > implementation is ever changed, which is why I was vague to begin with.
> > 
> > But it may never be changed as that code has been like that for a
> > decade now.  
> 
> Agreed. To give some context, Frank is an outreachy intern I am working with and
> one of his starter tasks was to understand the ring buffer's basics.  I asked
> him to send a patch since I thought he mentioned there was an error in the
> documnentation. It looks like all that was missing is some explanation which
> the deleted text in brackets above should already cover.
> 
> Steve, your call if you want this patch. Looks like Frank understands the
> page header taking up some space, so one of the goals of the exercise is
> accomplished ;-)

Yes agreed, what was written was not wrong (thus understood). But the
more I think about this, the less I like the implementation details in
the documentation directory. Now I am looking forward for some other
patches from Frank, and perhaps he could add some comments in
ring_buffer.c about this. ;-)

-- Steve

