Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDADC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B37C206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="AbIXERx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKOEYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:24:34 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35320 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOEYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:24:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id k15so5518079vsp.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 20:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZHul1S0/sEWzNeizlfiCToM557B/nMiQDe7Y5WogMac=;
        b=AbIXERx2EbwRaKBuXboK1iW3XeMTNnisqX11bXzbGlulz6dvk28pHoRoBg4B3J4wCc
         /0/LnTwFp/32KiF3oUvcqVNR8qLOOol7a9TbU3Eb8fyk5PymIuxWsAT2//MWcvitzRzC
         N+YLU2C5XvkZ0vw1hBG5vgIBEwBnoKIFSwaYP7skifCVIL1jx5OGCJblladzju+UXrv+
         Q68qwNAJbv94Fj5Krnaoc2Y/ile9lec6ODrOOsHLuWCyBKO9KpS/WY2M73yEh8gTbEmx
         ITQUnhILFHv7R3b9O1eITgBuMWkSfwObcR6FPIVC9Fl3PIguu+HmfjIswXnZPvzpg3Zf
         xhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZHul1S0/sEWzNeizlfiCToM557B/nMiQDe7Y5WogMac=;
        b=mmpXUwC909jh0g94FH13s/pgZhSEhpL49hx/rY3rNwBSz24oEBGfdv9UW1OlHmbnBk
         M9/vJOEB6Lqx3NV+eieG6L3q7hSLZ/yLZp66PDG2qQ/f/FSccrcHxXC7j9fx10bK/+iI
         6p/+zRFpWqvsajlWagPvhPBSod3dSGDvJkYi/2cPVH2KLE0k9fzDG8q7DYJLHjT4kN6H
         7DKW5w3B72wcttFve+6vDf0tx5ErIxMpXPK6jWurN5P1L49J5M7s/+KmYQmVrvDWf31x
         +ZkWqMYmWP9FBnjetzw8p6sgn7E66K2RwVF8IXVTUEUbf20Y3XG6JfviB0K0Kt5e1+eX
         CutA==
X-Gm-Message-State: APjAAAWZC7NqvZPPJfhSFcinyVHOJFx7GW7AUENHLGp2zTr9nMXoflz2
        S+r3pw7lAqDD6FIHAzQVxEeEFA==
X-Google-Smtp-Source: APXvYqxtYlU8vLYoS/tZfviECnnJb+Mk62fA5KDzOSYCGSiuvnxxQ62MLfjPuc1yweHGzeOTmdSvzw==
X-Received: by 2002:a05:6102:355:: with SMTP id e21mr3295793vsa.202.1573791870443;
        Thu, 14 Nov 2019 20:24:30 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id c126sm1863156vsc.32.2019.11.14.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 20:24:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 23:24:28 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <20191115042428.6xxiqbzhgoko6vyk@ubuntu1804-desktop>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
 <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
 <20191113113730.213ddd72@gandalf.local.home>
 <20191114202059.GC186056@google.com>
 <20191114163639.4727e3ed@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114163639.4727e3ed@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 04:36:39PM -0500, Steven Rostedt wrote:
> On Thu, 14 Nov 2019 15:20:59 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Nov 13, 2019 at 11:37:30AM -0500, Steven Rostedt wrote:
> > > On Wed, 13 Nov 2019 11:32:36 -0500
> > > "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:  
> > [snip]
> > > > +
> > > > +        The number of pages allocated for each CPU buffer may not
> > > > +        be the same than the round up of the division:
> > > > +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> > > > +        used to store a page header with metadata. E.g. with
> > > > +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> > > > +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> > > > +        page header with metadata) the number of pages allocated for each
> > > > +        CPU buffer is 1029, not 1024. The formula for calculating the
> > > > +        number of pages allocated for each CPU buffer is the round up of:
> > > > +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).  
> > > 
> > > I have no problem with this patch, but the concern of documenting the
> > > implementation here, which will most likely not be updated if the
> > > implementation is ever changed, which is why I was vague to begin with.
> > > 
> > > But it may never be changed as that code has been like that for a
> > > decade now.  
> > 
> > Agreed. To give some context, Frank is an outreachy intern I am working with and
> > one of his starter tasks was to understand the ring buffer's basics.  I asked
> > him to send a patch since I thought he mentioned there was an error in the
> > documnentation. It looks like all that was missing is some explanation which
> > the deleted text in brackets above should already cover.
> > 

Not exactly in my opinion ;) The deleted text was not the problem. I
just deleted it because with the added text it turns to be redundant.

The issue that I found with the documentation (maybe just to my
newbie's eyes) is in this part:

"The trace buffers are allocated in pages (blocks of memory that the
kernel uses for allocation, usually 4 KB in size). If the last page
allocated has room for more bytes than requested, the rest of the
page will be used, making the actual allocation bigger than requested
or shown."

For me that "suggests" the interpretation that the number of pages
allocated in the current implementation correspond with the round
integer division of buffer_size_kb / PAGE_SIZE, which is inaccurate
(for 5 pages in the example that I mentioned).


> > Steve, your call if you want this patch. Looks like Frank understands the
> > page header taking up some space, so one of the goals of the exercise is
> > accomplished ;-)
> 
> Yes agreed, what was written was not wrong (thus understood). But the
> more I think about this, the less I like the implementation details in
> the documentation directory.

Understood and agreed. It is funny that what I spotted as "a problem"
was precisely an incomplete description of the implementation (the
sentences that I quoted above). What do you think about removing
those two sentences?

> Now I am looking forward for some other
> patches from Frank, and perhaps he could add some comments in
> ring_buffer.c about this. ;-)
>

You can count on it. I'm just starting to learn. I'm very grateful
that Joel took me under his wing ;) and with the time I hope to be
able to give back more to the community with the help of experts like
you Steve.

Thank you, Steve and Joel, for such quick feedback!
frank a.

