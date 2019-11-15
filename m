Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6955AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C8D206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="DT38kzET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKOP77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:59:59 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39946 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:59:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id m9so6642699vsq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFjIWC5grXH1heIBOULUw1cc4MTk9CxbaN9F9M43lG4=;
        b=DT38kzETDzh6x9pco0SshpqhuC66Qw3l7VpmSb4ev52NzeA/LMlkMqBWRFXdhfjX1d
         NlFhqHW9c++2KLZRej4J3Kc00BDPUt4Dl9e0gBafZ1kpQIlajKpsd2OAAQdMC0Pn+soR
         /+rVLUP3ELsW0azaRX08CVMopLEjp1/RNlozn6KfjU3tcDnLJLbCbqggrk2JD9rAEnyY
         qwZEHkk5bRiN5Km62e9WxJ87o+jMaT7CcmNFlVvw2K4VPEkFMy0OJoFPYNrQR4mYioDS
         y6zwhWi6TpAypo8S9JsuOeY0hRZJcudItxRDSxFoMDsrWh/t7scPxoQ5Mp2uSWO7k/7v
         PoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFjIWC5grXH1heIBOULUw1cc4MTk9CxbaN9F9M43lG4=;
        b=WJgCPNRBBqhQqWZA5Sq4FIed5iRmJXYFymdOEC7DO+Uhzaq8cBE9mV3XIxT/TCJesU
         bY6Dy3mR4yPbmqbbwhdnQm4e3F/DQk5iG57o93Yj92Wkl4XQ53EFTa1Bvtntw1KVWA22
         79PAccXp1/0vmmKsyRZ7CIqGD2cI9OtNgOo76u8DPcSzcmRoUnRooiw59+lh80h7mqPD
         iVJ+ZLvbJEc1YoRpj5673HfFHgPbRvdMPC6tX22zrVNye4bQFyyxgcAsiLYy7AjE6jOz
         e9V9XnfcClx5ubpGA8eByc9tBHvJ4eey4ss97sM0Cif4Bqo4TfV210HLcXEQQdanMP21
         i7Dg==
X-Gm-Message-State: APjAAAUaxGM8WywWyfzXq4SyqFHdydwJWw6b5m7jZWtVpA7vwfyjHhU1
        bR6hFH752TrdMGog0LyyWQDYrSlP/dqyUQ==
X-Google-Smtp-Source: APXvYqz1n+cQP+U6jImgFyiC6kv6X9QcmucfMSDgJ3qSjnM13Oj4YaNWJUfBhODzmLoLtbhJ2YQDYg==
X-Received: by 2002:a67:7d95:: with SMTP id y143mr10065554vsc.39.1573833597008;
        Fri, 15 Nov 2019 07:59:57 -0800 (PST)
Received: from ubuntu1804-desktop ([172.97.41.74])
        by smtp.gmail.com with ESMTPSA id m78sm2547032vke.30.2019.11.15.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 07:59:56 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:59:55 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of buffer_size_kb
Message-ID: <20191115155955.4khvnlnzjhnp5bxa@ubuntu1804-desktop>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
 <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
 <20191113113730.213ddd72@gandalf.local.home>
 <20191114202059.GC186056@google.com>
 <20191114163639.4727e3ed@gandalf.local.home>
 <20191115042428.6xxiqbzhgoko6vyk@ubuntu1804-desktop>
 <20191115083000.76f89785@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115083000.76f89785@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:30:00AM -0500, Steven Rostedt wrote:
> On Thu, 14 Nov 2019 23:24:28 -0500
> "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
> 
> > On Thu, Nov 14, 2019 at 04:36:39PM -0500, Steven Rostedt wrote:
> > > On Thu, 14 Nov 2019 15:20:59 -0500
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >   
> > > > On Wed, Nov 13, 2019 at 11:37:30AM -0500, Steven Rostedt wrote:  
> > > > > On Wed, 13 Nov 2019 11:32:36 -0500
> > > > > "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:    
> > > > [snip]  
> > > > > > +
> > > > > > +        The number of pages allocated for each CPU buffer may not
> > > > > > +        be the same than the round up of the division:
> > > > > > +        buffer_size_kb / PAGE_SIZE. This is because part of each page is
> > > > > > +        used to store a page header with metadata. E.g. with
> > > > > > +        buffer_size_kb=4096 (kilobytes), a PAGE_SIZE=4096 bytes and a
> > > > > > +        BUF_PAGE_HDR_SIZE=16 bytes (BUF_PAGE_HDR_SIZE is the size of the
> > > > > > +        page header with metadata) the number of pages allocated for each
> > > > > > +        CPU buffer is 1029, not 1024. The formula for calculating the
> > > > > > +        number of pages allocated for each CPU buffer is the round up of:
> > > > > > +        buffer_size_kb / (PAGE_SIZE - BUF_PAGE_HDR_SIZE).    
> > > > > 
> > > > > I have no problem with this patch, but the concern of documenting the
> > > > > implementation here, which will most likely not be updated if the
> > > > > implementation is ever changed, which is why I was vague to begin with.
> > > > > 
> > > > > But it may never be changed as that code has been like that for a
> > > > > decade now.    
> > > > 
> > > > Agreed. To give some context, Frank is an outreachy intern I am working with and
> > > > one of his starter tasks was to understand the ring buffer's basics.  I asked
> > > > him to send a patch since I thought he mentioned there was an error in the
> > > > documnentation. It looks like all that was missing is some explanation which
> > > > the deleted text in brackets above should already cover.
> > > >   
> > 
> > Not exactly in my opinion ;) The deleted text was not the problem. I
> > just deleted it because with the added text it turns to be redundant.
> > 
> > The issue that I found with the documentation (maybe just to my
> > newbie's eyes) is in this part:
> > 
> > "The trace buffers are allocated in pages (blocks of memory that the
> > kernel uses for allocation, usually 4 KB in size). If the last page
> > allocated has room for more bytes than requested, the rest of the
> > page will be used, making the actual allocation bigger than requested
> > or shown."
> > 
> > For me that "suggests" the interpretation that the number of pages
> > allocated in the current implementation correspond with the round
> > integer division of buffer_size_kb / PAGE_SIZE, which is inaccurate
> > (for 5 pages in the example that I mentioned).
> 
> If you would like, you could reword that to something more accurate,
> but still not detailing the implementation.
> 
> > Understood and agreed. It is funny that what I spotted as "a problem"
> > was precisely an incomplete description of the implementation (the
> > sentences that I quoted above). What do you think about removing
> > those two sentences?
> 
> I wouldn't remove them, just reword them to something you find more
> accurate.
> 

I feel that adding:

"A few extra pages may be allocated to accommodate buffer management
meta-data."

between the two sentences that I quoted will address the issue. If
that is OK with you I will proceed to package this change in a new
patchset along with a few fixes of typos that I spotted in other
parts of the doc.

thanks one more time for your quick response.
frank a.

